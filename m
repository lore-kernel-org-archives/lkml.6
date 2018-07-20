Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56E7CECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 10:01:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B16920661
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 10:01:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B16920661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729890AbeGTKsy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 06:48:54 -0400
Received: from terminus.zytor.com ([198.137.202.136]:37217 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727243AbeGTKsy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 06:48:54 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w6KA0oTt2614589
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 20 Jul 2018 03:00:50 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w6KA0oDt2614586;
        Fri, 20 Jul 2018 03:00:50 -0700
Date:   Fri, 20 Jul 2018 03:00:50 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Peter Zijlstra <tipbot@zytor.com>
Message-ID: <tip-9407f5a7ee77c631d1e100436132437cf6237e45@git.kernel.org>
Cc:     mingo@kernel.org, tglx@linutronix.de, peterz@infradead.org,
        linux-kernel@vger.kernel.org, pasha.tatashin@oracle.com,
        hpa@zytor.com
Reply-To: tglx@linutronix.de, peterz@infradead.org, mingo@kernel.org,
          pasha.tatashin@oracle.com, hpa@zytor.com,
          linux-kernel@vger.kernel.org
In-Reply-To: <20180720080911.GM2494@hirez.programming.kicks-ass.net>
References: <20180720080911.GM2494@hirez.programming.kicks-ass.net>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/timers] sched/clock: Close a hole in sched_clock_init()
Git-Commit-ID: 9407f5a7ee77c631d1e100436132437cf6237e45
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  9407f5a7ee77c631d1e100436132437cf6237e45
Gitweb:     https://git.kernel.org/tip/9407f5a7ee77c631d1e100436132437cf6237e45
Author:     Peter Zijlstra <peterz@infradead.org>
AuthorDate: Fri, 20 Jul 2018 10:09:11 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Fri, 20 Jul 2018 11:58:00 +0200

sched/clock: Close a hole in sched_clock_init()

All data required for the 'unstable' sched_clock must be set-up _before_
enabling it -- setting sched_clock_running. This includes the
__gtod_offset but also a recent scd stamp.

Make the gtod-offset update also set the csd stamp -- it requires the
same two clock reads _anyway_. This doesn't hurt in the
sched_clock_tick_stable() case and ensures sched_clock_init() gets
everything set-up before use.

Also switch to unconditional IRQ-disable/enable because the static key
stuff already requires this is not ran with IRQs disabled.

Fixes: 857baa87b642 ("sched/clock: Enable sched clock early")
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Pavel Tatashin <pasha.tatashin@oracle.com>
Cc: steven.sistare@oracle.com
Cc: daniel.m.jordan@oracle.com
Cc: linux@armlinux.org.uk
Cc: schwidefsky@de.ibm.com
Cc: heiko.carstens@de.ibm.com
Cc: john.stultz@linaro.org
Cc: sboyd@codeaurora.org
Cc: hpa@zytor.com
Cc: douly.fnst@cn.fujitsu.com
Cc: prarit@redhat.com
Cc: feng.tang@intel.com
Cc: pmladek@suse.com
Cc: gnomes@lxorguk.ukuu.org.uk
Cc: linux-s390@vger.kernel.org
Cc: boris.ostrovsky@oracle.com
Cc: jgross@suse.com
Cc: pbonzini@redhat.com
Link: https://lkml.kernel.org/r/20180720080911.GM2494@hirez.programming.kicks-ass.net
---
 kernel/sched/clock.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/kernel/sched/clock.c b/kernel/sched/clock.c
index c5c47ad3f386..811a39aca1ce 100644
--- a/kernel/sched/clock.c
+++ b/kernel/sched/clock.c
@@ -197,13 +197,14 @@ void clear_sched_clock_stable(void)
 
 static void __sched_clock_gtod_offset(void)
 {
-	__gtod_offset = (sched_clock() + __sched_clock_offset) - ktime_get_ns();
+	struct sched_clock_data *scd = this_scd();
+
+	__scd_stamp(scd);
+	__gtod_offset = (scd->tick_raw + __sched_clock_offset) - scd->tick_gtod;
 }
 
 void __init sched_clock_init(void)
 {
-	unsigned long flags;
-
 	/*
 	 * Set __gtod_offset such that once we mark sched_clock_running,
 	 * sched_clock_tick() continues where sched_clock() left off.
@@ -211,16 +212,11 @@ void __init sched_clock_init(void)
 	 * Even if TSC is buggered, we're still UP at this point so it
 	 * can't really be out of sync.
 	 */
-	local_irq_save(flags);
+	local_irq_disable();
 	__sched_clock_gtod_offset();
-	local_irq_restore(flags);
+	local_irq_enable();
 
 	static_branch_inc(&sched_clock_running);
-
-	/* Now that sched_clock_running is set adjust scd */
-	local_irq_save(flags);
-	sched_clock_tick();
-	local_irq_restore(flags);
 }
 /*
  * We run this as late_initcall() such that it runs after all built-in drivers,
