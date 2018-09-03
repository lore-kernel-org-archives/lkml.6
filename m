Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70152C433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 17:28:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34BD020868
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 17:28:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34BD020868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731137AbeICVt1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 17:49:27 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:46408 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728175AbeICVt0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 17:49:26 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id EC3B6CF4;
        Mon,  3 Sep 2018 17:28:18 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>, oleg@redhat.com,
        tj@kernel.org
Subject: [PATCH 4.14 162/165] watchdog: Mark watchdog touch functions as notrace
Date:   Mon,  3 Sep 2018 18:57:28 +0200
Message-Id: <20180903165705.221472971@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180903165655.003605184@linuxfoundation.org>
References: <20180903165655.003605184@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Vincent Whitchurch <vincent.whitchurch@axis.com>

commit cb9d7fd51d9fbb329d182423bd7b92d0f8cb0e01 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/watchdog.c     |    4 ++--
 kernel/watchdog_hld.c |    2 +-
 kernel/workqueue.c    |    2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

--- a/kernel/watchdog.c
+++ b/kernel/watchdog.c
@@ -265,7 +265,7 @@ static void __touch_watchdog(void)
  * entering idle state.  This should only be used for scheduler events.
  * Use touch_softlockup_watchdog() for everything else.
  */
-void touch_softlockup_watchdog_sched(void)
+notrace void touch_softlockup_watchdog_sched(void)
 {
 	/*
 	 * Preemption can be enabled.  It doesn't matter which CPU's timestamp
@@ -274,7 +274,7 @@ void touch_softlockup_watchdog_sched(voi
 	raw_cpu_write(watchdog_touch_ts, 0);
 }
 
-void touch_softlockup_watchdog(void)
+notrace void touch_softlockup_watchdog(void)
 {
 	touch_softlockup_watchdog_sched();
 	wq_watchdog_touch(raw_smp_processor_id());
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
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -5484,7 +5484,7 @@ static void wq_watchdog_timer_fn(unsigne
 	mod_timer(&wq_watchdog_timer, jiffies + thresh);
 }
 
-void wq_watchdog_touch(int cpu)
+notrace void wq_watchdog_touch(int cpu)
 {
 	if (cpu >= 0)
 		per_cpu(wq_watchdog_touched_cpu, cpu) = jiffies;


