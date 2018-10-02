Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CECD4C64EBD
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 21:51:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D1642083F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 21:51:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D1642083F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728728AbeJCEgx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 00:36:53 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:42616 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727460AbeJCEgm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 00:36:42 -0400
Received: from 79.184.253.194.ipv4.supernova.orange.pl (79.184.253.194) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.148)
 id f832cc799e713173; Tue, 2 Oct 2018 23:51:14 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH 1/6] cpuidle: menu: Fix wakeup statistics updates for polling state
Date:   Tue, 02 Oct 2018 23:42:02 +0200
Message-ID: <1561295.epLgDtImU0@aspire.rjw.lan>
In-Reply-To: <3510260.hvypppS8Bs@aspire.rjw.lan>
References: <3510260.hvypppS8Bs@aspire.rjw.lan>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

If the CPU exits the "polling" state due to the time limit in the
loop in poll_idle(), this is not a real wakeup and it just means
that the "polling" state selection was not adequate.  The governor
mispredicted short idle duration, but had a more suitable state been
selected, the CPU might have spent more time in it.  In fact, there
is no reason to expect that there would have been a wakeup event
earlier than the next timer in that case.

Handling such cases as regular wakeups in menu_update() may cause the
menu governor to make suboptimal decisions going forward, but ignoring
them altogether would not be correct either, because every time
menu_select() is invoked, it makes a separate new attempt to predict
the idle duration taking distinct time to the closest timer event as
input and the outcomes of all those attempts should be recorded.

For this reason, make menu_update() always assume that if the
"polling" state was exited due to the time limit, the next proper
wakeup event for the CPU would be the next timer event (not
including the tick).

Fixes: a37b969a61c1 "cpuidle: poll_state: Add time limit to poll_idle()"
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpuidle/governors/menu.c |   10 ++++++++++
 drivers/cpuidle/poll_state.c     |    6 +++++-
 include/linux/cpuidle.h          |    1 +
 3 files changed, 16 insertions(+), 1 deletion(-)

Index: linux-pm/drivers/cpuidle/governors/menu.c
===================================================================
--- linux-pm.orig/drivers/cpuidle/governors/menu.c
+++ linux-pm/drivers/cpuidle/governors/menu.c
@@ -511,6 +511,16 @@ static void menu_update(struct cpuidle_d
 		 * duration predictor do a better job next time.
 		 */
 		measured_us = 9 * MAX_INTERESTING / 10;
+	} else if ((drv->states[last_idx].flags & CPUIDLE_FLAG_POLLING) &&
+		   dev->poll_time_limit) {
+		/*
+		 * The CPU exited the "polling" state due to a time limit, so
+		 * the idle duration prediction leading to the selection of that
+		 * state was inaccurate.  If a better prediction had been made,
+		 * the CPU might have been woken up from idle by the next timer.
+		 * Assume that to be the case.
+		 */
+		measured_us = data->next_timer_us;
 	} else {
 		/* measured value */
 		measured_us = dev->last_residency;
Index: linux-pm/include/linux/cpuidle.h
===================================================================
--- linux-pm.orig/include/linux/cpuidle.h
+++ linux-pm/include/linux/cpuidle.h
@@ -81,6 +81,7 @@ struct cpuidle_device {
 	unsigned int		registered:1;
 	unsigned int		enabled:1;
 	unsigned int		use_deepest_state:1;
+	unsigned int		poll_time_limit:1;
 	unsigned int		cpu;
 
 	int			last_residency;
Index: linux-pm/drivers/cpuidle/poll_state.c
===================================================================
--- linux-pm.orig/drivers/cpuidle/poll_state.c
+++ linux-pm/drivers/cpuidle/poll_state.c
@@ -17,6 +17,8 @@ static int __cpuidle poll_idle(struct cp
 {
 	u64 time_start = local_clock();
 
+	dev->poll_time_limit = false;
+
 	local_irq_enable();
 	if (!current_set_polling_and_test()) {
 		unsigned int loop_count = 0;
@@ -27,8 +29,10 @@ static int __cpuidle poll_idle(struct cp
 				continue;
 
 			loop_count = 0;
-			if (local_clock() - time_start > POLL_IDLE_TIME_LIMIT)
+			if (local_clock() - time_start > POLL_IDLE_TIME_LIMIT) {
+				dev->poll_time_limit = true;
 				break;
+			}
 		}
 	}
 	current_clr_polling();

