Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03AF1C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 11:01:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB7F02054F
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 11:01:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB7F02054F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728486AbeH3PDL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 11:03:11 -0400
Received: from terminus.zytor.com ([198.137.202.136]:47963 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728180AbeH3PDL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 11:03:11 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w7UB0tTl1727899
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 30 Aug 2018 04:00:55 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w7UB0tK41727887;
        Thu, 30 Aug 2018 04:00:55 -0700
Date:   Thu, 30 Aug 2018 04:00:55 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Vincent Whitchurch <tipbot@zytor.com>
Message-ID: <tip-cb9d7fd51d9fbb329d182423bd7b92d0f8cb0e01@git.kernel.org>
Cc:     tglx@linutronix.de, vincent.whitchurch@axis.com,
        linux-kernel@vger.kernel.org, hpa@zytor.com, peterz@infradead.org,
        mingo@kernel.org
Reply-To: tglx@linutronix.de, vincent.whitchurch@axis.com,
          linux-kernel@vger.kernel.org, peterz@infradead.org,
          hpa@zytor.com, mingo@kernel.org
In-Reply-To: <20180821152507.18313-1-vincent.whitchurch@axis.com>
References: <20180821152507.18313-1-vincent.whitchurch@axis.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:core/urgent] watchdog: Mark watchdog touch functions as
 notrace
Git-Commit-ID: cb9d7fd51d9fbb329d182423bd7b92d0f8cb0e01
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

Commit-ID:  cb9d7fd51d9fbb329d182423bd7b92d0f8cb0e01
Gitweb:     https://git.kernel.org/tip/cb9d7fd51d9fbb329d182423bd7b92d0f8cb0e01
Author:     Vincent Whitchurch <vincent.whitchurch@axis.com>
AuthorDate: Tue, 21 Aug 2018 17:25:07 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 30 Aug 2018 12:56:40 +0200

watchdog: Mark watchdog touch functions as notrace

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
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: oleg@redhat.com
Cc: tj@kernel.org
Cc: stable@vger.kernel.org
Link: https://lkml.kernel.org/r/20180821152507.18313-1-vincent.whitchurch@axis.com

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
index 60e80198c3df..0280deac392e 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -5574,7 +5574,7 @@ static void wq_watchdog_timer_fn(struct timer_list *unused)
 	mod_timer(&wq_watchdog_timer, jiffies + thresh);
 }
 
-void wq_watchdog_touch(int cpu)
+notrace void wq_watchdog_touch(int cpu)
 {
 	if (cpu >= 0)
 		per_cpu(wq_watchdog_touched_cpu, cpu) = jiffies;
