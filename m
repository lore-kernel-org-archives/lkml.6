Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B207C04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 10:04:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DA9E21477
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 10:04:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DA9E21477
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727358AbeIMPNg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 11:13:36 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:52104 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726819AbeIMPNg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 11:13:36 -0400
Received: from 79.184.255.178.ipv4.supernova.orange.pl (79.184.255.178) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.148)
 id 96672996049e319a; Thu, 13 Sep 2018 12:04:47 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
Subject: [PATCH] PM / suspend: Count extra iterations of s2idle loop as sleep time
Date:   Thu, 13 Sep 2018 12:02:08 +0200
Message-ID: <2599994.ffBKF6PfAe@aspire.rjw.lan>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

There is a difference in behavior between suspend-to-idle and
suspend-to-RAM in the timekeeping handling that leads to functional
issues.  Namely, every iteration of the loop in s2idle_loop()
increases the monotinic clock somewhat, even if timekeeping_suspend()
and timekeeping_resume() are invoked from s2idle_enter(), and if
many of them are carried out in a row, the monotonic clock can grow
significantly while the system is regarded as suspended, which
doesn't happend during suspend-to-RAM and so it is unexpected and
leads to confusion and misbehavior in user space (similar to what
ensued when we tried to combine the boottime and monotonic clocks).

To avoid that, count all iterations of the loop in s2idle_loop()
except for the last one as "sleep time" and adjust the clock for
that on exit from suspend-to-idle.

Fixes: 33e4f80ee69b (ACPI / PM: Ignore spurious SCI wakeups from suspend-to-idle)
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 kernel/power/suspend.c |   22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

Index: linux-pm/kernel/power/suspend.c
===================================================================
--- linux-pm.orig/kernel/power/suspend.c
+++ linux-pm/kernel/power/suspend.c
@@ -109,11 +109,16 @@ static void s2idle_enter(void)
 
 static void s2idle_loop(void)
 {
+	ktime_t delta = 0;
+
 	pm_pr_dbg("suspend-to-idle\n");
 
 	for (;;) {
+		ktime_t before;
 		int error;
 
+		before = ktime_get();
+
 		dpm_noirq_begin();
 
 		/*
@@ -148,6 +153,23 @@ static void s2idle_loop(void)
 			break;
 
 		pm_wakeup_clear(false);
+
+		/*
+		 * Count all iterations except for the last one as "sleep time".
+		 */
+		delta = ktime_add(delta, ktime_sub(ktime_get(), before));
+	}
+
+	/*
+	 * If the monotonic clock difference between the start of the loop and
+	 * this point is too large, user space may get confused about whether or
+	 * not the system has been suspended and tasks may get killed by
+	 * watchdogs etc., so compensate for that.
+	 */
+	if (ktime_to_ns(delta) > 0) {
+		struct timespec64 timespec64_delta = ktime_to_timespec64(delta);
+
+		timekeeping_inject_sleeptime64(&timespec64_delta);
 	}
 
 	pm_pr_dbg("resume from suspend-to-idle\n");

