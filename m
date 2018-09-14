Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E090C070C3
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 08:16:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35B0220853
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 08:16:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35B0220853
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728057AbeINN35 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 09:29:57 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:57173 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726883AbeINN34 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 09:29:56 -0400
Received: from 79.184.255.178.ipv4.supernova.orange.pl (79.184.255.178) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.148)
 id 7559d7d3de35f1b1; Fri, 14 Sep 2018 10:16:34 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
Subject: [PATCH v2] PM / suspend: Count suspend-to-idle loop as sleep time
Date:   Fri, 14 Sep 2018 10:13:53 +0200
Message-ID: <2512990.M6WkFzBlpI@aspire.rjw.lan>
In-Reply-To: <9611469.2z7W9akjOQ@aspire.rjw.lan>
References: <9611469.2z7W9akjOQ@aspire.rjw.lan>
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
 by s2idle_enter().]

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---

-> v2:
 - Switched over to ktime_get_ns() as suggested by Peter.
 - Tentatively added "Acked-by" from Peter.

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
+	u64 delta_ns;
+
 	pm_pr_dbg("suspend-to-idle\n");
 
+	delta_ns = ktime_get_ns();
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
+	delta_ns = ktime_get_ns() - delta_ns;
+	if (delta_ns) {
+		struct timespec64 timespec64_delta = ns_to_timespec64(delta_ns);
+
+		timekeeping_inject_sleeptime64(&timespec64_delta);
+	}
+
 	pm_pr_dbg("resume from suspend-to-idle\n");
 }
 

