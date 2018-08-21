Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3071C4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 15:34:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EACA2177A
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 15:34:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EACA2177A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axis.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727863AbeHUSym (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 14:54:42 -0400
Received: from bastet.se.axis.com ([195.60.68.11]:53198 "EHLO
        bastet.se.axis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727767AbeHUSym (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 14:54:42 -0400
X-Greylist: delayed 519 seconds by postgrey-1.27 at vger.kernel.org; Tue, 21 Aug 2018 14:54:39 EDT
Received: from localhost (localhost [127.0.0.1])
        by bastet.se.axis.com (Postfix) with ESMTP id C9B0A1832D;
        Tue, 21 Aug 2018 17:25:24 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at bastet.se.axis.com
Received: from bastet.se.axis.com ([IPv6:::ffff:127.0.0.1])
        by localhost (bastet.se.axis.com [::ffff:127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id f1nvzc7nlPLy; Tue, 21 Aug 2018 17:25:24 +0200 (CEST)
Received: from boulder03.se.axis.com (boulder03.se.axis.com [10.0.8.17])
        by bastet.se.axis.com (Postfix) with ESMTPS id F28FE180D2;
        Tue, 21 Aug 2018 17:25:23 +0200 (CEST)
Received: from boulder03.se.axis.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 989291E08A;
        Tue, 21 Aug 2018 17:25:23 +0200 (CEST)
Received: from boulder03.se.axis.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8CB1E1E089;
        Tue, 21 Aug 2018 17:25:23 +0200 (CEST)
Received: from seth.se.axis.com (unknown [10.0.2.172])
        by boulder03.se.axis.com (Postfix) with ESMTP;
        Tue, 21 Aug 2018 17:25:23 +0200 (CEST)
Received: from lnxartpec.se.axis.com (lnxartpec.se.axis.com [10.88.4.9])
        by seth.se.axis.com (Postfix) with ESMTP id 7F7F716B2;
        Tue, 21 Aug 2018 17:25:23 +0200 (CEST)
Received: by lnxartpec.se.axis.com (Postfix, from userid 10564)
        id 717018016D; Tue, 21 Aug 2018 17:25:23 +0200 (CEST)
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     mingo@kernel.org, tglx@linutronix.de
Cc:     oleg@redhat.com, linux-kernel@vger.kernel.org, tj@kernel.org,
        jiangshanlai@gmail.com, Vincent Whitchurch <rabinv@axis.com>
Subject: [PATCH] watchdog: Mark watchdog touch functions as notrace
Date:   Tue, 21 Aug 2018 17:25:07 +0200
Message-Id: <20180821152507.18313-1-vincent.whitchurch@axis.com>
X-Mailer: git-send-email 2.11.0
X-TM-AS-GCONF: 00
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some architectures need to use stop_machine() to patch functions for
ftrace, and the assumption is that the stopped CPUs do not make function
calls to traceable functions when they are in the stopped state.

Commit ce4f06dcbb5d ("stop_machine: Touch_nmi_watchdog() after
MULTI_STOP_PREPARE") added calls to the watchdog touch functions from
the stopped CPUs and those functions lack notrace annotations.  This
leads to crashes when enabling/disabling ftrace on ARM kernels built
with the Thumb-2 instruction set.

Fix it by adding the necessary notrace annotations.

Fixes: ce4f06dcbb5d ("stop_machine: Touch_nmi_watchdog() after MULTI_STOP_PREPARE")
Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
---
 kernel/watchdog.c     | 4 ++--
 kernel/watchdog_hld.c | 2 +-
 kernel/workqueue.c    | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/watchdog.c b/kernel/watchdog.c
index 5470dce212c0..977918d5d350 100644
--- a/kernel/watchdog.c
+++ b/kernel/watchdog.c
@@ -261,7 +261,7 @@ static void __touch_watchdog(void)
  * entering idle state.  This should only be used for scheduler events.
  * Use touch_softlockup_watchdog() for everything else.
  */
-void touch_softlockup_watchdog_sched(void)
+notrace void touch_softlockup_watchdog_sched(void)
 {
 	/*
 	 * Preemption can be enabled.  It doesn't matter which CPU's timestamp
@@ -270,7 +270,7 @@ void touch_softlockup_watchdog_sched(void)
 	raw_cpu_write(watchdog_touch_ts, 0);
 }
 
-void touch_softlockup_watchdog(void)
+notrace void touch_softlockup_watchdog(void)
 {
 	touch_softlockup_watchdog_sched();
 	wq_watchdog_touch(raw_smp_processor_id());
diff --git a/kernel/watchdog_hld.c b/kernel/watchdog_hld.c
index 1f7020d65d0a..71381168dede 100644
--- a/kernel/watchdog_hld.c
+++ b/kernel/watchdog_hld.c
@@ -29,7 +29,7 @@ static struct cpumask dead_events_mask;
 static unsigned long hardlockup_allcpu_dumped;
 static atomic_t watchdog_cpus = ATOMIC_INIT(0);
 
-void arch_touch_nmi_watchdog(void)
+notrace void arch_touch_nmi_watchdog(void)
 {
 	/*
 	 * Using __raw here because some code paths have
diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 78b192071ef7..5f78c6e41796 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -5559,7 +5559,7 @@ static void wq_watchdog_timer_fn(struct timer_list *unused)
 	mod_timer(&wq_watchdog_timer, jiffies + thresh);
 }
 
-void wq_watchdog_touch(int cpu)
+notrace void wq_watchdog_touch(int cpu)
 {
 	if (cpu >= 0)
 		per_cpu(wq_watchdog_touched_cpu, cpu) = jiffies;
-- 
2.11.0

