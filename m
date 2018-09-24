Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91679C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 15:36:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52E352083A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 15:36:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52E352083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730877AbeIXVjR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 17:39:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43706 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727770AbeIXVjQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 17:39:16 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 51FBD30001DE;
        Mon, 24 Sep 2018 15:36:32 +0000 (UTC)
Received: from llong.com (dhcp-17-8.bos.redhat.com [10.18.17.8])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3723F106A7AD;
        Mon, 24 Sep 2018 15:36:28 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     John Stultz <john.stultz@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH v3] clocksource: Warn if too many missing ticks are detected
Date:   Mon, 24 Sep 2018 11:36:15 -0400
Message-Id: <1537803375-31667-1-git-send-email-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Mon, 24 Sep 2018 15:36:32 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The clocksource watchdog, when running, is scheduled on all the CPUs in
the system sequentially on a round-robin fashion with a period of 0.5s.
A bug in the 4.18 kernel is causing missing ticks when nohz_full
is specified. Under some circumstances, this causes the watchdog to
incorrectly state that the TSC is unstable because of counter overflow
in the hpet watchdog clock source after a few minutes delay.

That particular bug is fixed by the 4.19 commit 7059b36636beab ("sched:
idle: Avoid retaining the tick when it has been stopped"). To make it
easier to catch this kind of bug in the future, a check is added to see
if there is too much delay in the invocation of the watchdog callback
and print a warning once if it happens.

v3: Do the check only when SYSTEM_RUNNING & print the delay as well.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/time/clocksource.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
index 0e6e97a..e5d2e38 100644
--- a/kernel/time/clocksource.c
+++ b/kernel/time/clocksource.c
@@ -208,11 +208,40 @@ static void clocksource_watchdog(struct timer_list *unused)
 	u64 csnow, wdnow, cslast, wdlast, delta;
 	int64_t wd_nsec, cs_nsec;
 	int next_cpu, reset_pending;
+	static bool prev_running; /* Set if previously in SYSTEM_RUNNING */
 
 	spin_lock(&watchdog_lock);
 	if (!watchdog_running)
 		goto out;
 
+	/*
+	 * When the timer tick is incorrectly stopped on a CPU with
+	 * pending events, for example, it is possible that the
+	 * clocksource watchdog will stop running for a sufficiently
+	 * long enough time to cause overflow in the delta computation
+	 * leading to incorrect report of unstable clock source.
+	 * So print a warning if there is unusually large delay (> 0.5s)
+	 * in the invocation of the watchdog. That can indicate a hidden
+	 * bug in the timer tick code.
+	 *
+	 * This check is performed only when the system is previously
+	 * running in the SYSTEM_RUNNING state as large delay may happen
+	 * when running in other states, especially when self-tests are
+	 * being run. If the watchdog was previously in the running state,
+	 * that will make sure that the current timer expiry happened in
+	 * that state too.
+	 */
+	if (prev_running) {
+		unsigned long delay = jiffies - watchdog_timer.expires;
+
+		if (delay > WATCHDOG_INTERVAL) {
+			pr_warn("watchdog delayed by %ld ticks!\n", delay);
+			WARN_ON_ONCE(1);
+		}
+	} else if (system_state == SYSTEM_RUNNING) {
+		prev_running = true;
+	}
+
 	reset_pending = atomic_read(&watchdog_reset_pending);
 
 	list_for_each_entry(cs, &watchdog_list, wd_list) {
-- 
1.8.3.1

