Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0402C070C3
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 07:01:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A099E20866
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 07:01:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A099E20866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727676AbeINMOv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 08:14:51 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:58761 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726822AbeINMOu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 08:14:50 -0400
Received: from 79.184.255.178.ipv4.supernova.orange.pl (79.184.255.178) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.148)
 id f76cb641916a1a90; Fri, 14 Sep 2018 09:01:43 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
Subject: [PATCH] PM / suspend: Count suspend-to-idle loop as sleep time
Date:   Fri, 14 Sep 2018 08:59:03 +0200
Message-ID: <9611469.2z7W9akjOQ@aspire.rjw.lan>
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
doesn't happen during suspend-to-RAM and so it is unexpected and
leads to confusion and misbehavior in user space (similar to what
ensued when we tried to combine the boottime and monotonic clocks).

To avoid that, count all iterations of the loop in s2idle_loop()
as "sleep time" and adjust the clock for that on exit from
suspend-to-idle.

[That also covers systems on which timekeeping is not suspended
 by by s2idle_enter().]

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

This is a replacement for https://patchwork.kernel.org/patch/10599209/

I decided to count the entire loop in s2idle_loop() as "sleep time" as the
patch is then simpler and it also covers systems where timekeeping is not
suspended in the final step of suspend-to-idle.

I dropped the "Fixes:" tag, because the monotonic clock delta problem
has been present on the latter since the very introduction of "freeze"
(as suspend-to-idle was referred to previously) and so this doesn't fix
any particular later commits.

---
 kernel/power/suspend.c |   18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

Index: linux-pm/kernel/power/suspend.c
===================================================================
--- linux-pm.orig/kernel/power/suspend.c
+++ linux-pm/kernel/power/suspend.c
@@ -109,8 +109,12 @@ static void s2idle_enter(void)
 
 static void s2idle_loop(void)
 {
+	ktime_t start, delta;
+
 	pm_pr_dbg("suspend-to-idle\n");
 
+	start = ktime_get();
+
 	for (;;) {
 		int error;
 
@@ -150,6 +154,20 @@ static void s2idle_loop(void)
 		pm_wakeup_clear(false);
 	}
 
+	/*
+	 * If the monotonic clock difference between the start of the loop and
+	 * this point is too large, user space may get confused about whether or
+	 * not the system has been suspended and tasks may get killed by
+	 * watchdogs etc., so count the loop as "sleep time" to compensate for
+	 * that.
+	 */
+	delta = ktime_sub(ktime_get(), start);
+	if (ktime_to_ns(delta) > 0) {
+		struct timespec64 timespec64_delta = ktime_to_timespec64(delta);
+
+		timekeeping_inject_sleeptime64(&timespec64_delta);
+	}
+
 	pm_pr_dbg("resume from suspend-to-idle\n");
 }
 

