Return-Path: <SRS0=6f18=J7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD940ECDFB3
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 23:26:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DB2D2089D
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 23:26:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DB2D2089D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727411AbeGOXuP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Jul 2018 19:50:15 -0400
Received: from terminus.zytor.com ([198.137.202.136]:35575 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727005AbeGOXuP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jul 2018 19:50:15 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w6FNPMDK920931
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sun, 15 Jul 2018 16:25:22 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w6FNPLb2920928;
        Sun, 15 Jul 2018 16:25:21 -0700
Date:   Sun, 15 Jul 2018 16:25:21 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Peter Zijlstra <tipbot@zytor.com>
Message-ID: <tip-be45bf5395e0886a93fc816bbe41a008ec2e42e2@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, rong.a.chen@intel.com,
        mingo@kernel.org, torvalds@linux-foundation.org, hpa@zytor.com,
        tglx@linutronix.de, peterz@infradead.org, lkp@intel.com
Reply-To: peterz@infradead.org, tglx@linutronix.de, lkp@intel.com,
          hpa@zytor.com, rong.a.chen@intel.com,
          linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
          mingo@kernel.org
In-Reply-To: <20180713104208.GW2494@hirez.programming.kicks-ass.net>
References: <20180713104208.GW2494@hirez.programming.kicks-ass.net>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:sched/core] watchdog/softlockup: Fix cpu_stop_queue_work()
 double-queue bug
Git-Commit-ID: be45bf5395e0886a93fc816bbe41a008ec2e42e2
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

Commit-ID:  be45bf5395e0886a93fc816bbe41a008ec2e42e2
Gitweb:     https://git.kernel.org/tip/be45bf5395e0886a93fc816bbe41a008ec2e42e2
Author:     Peter Zijlstra <peterz@infradead.org>
AuthorDate: Fri, 13 Jul 2018 12:42:08 +0200
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Sun, 15 Jul 2018 23:51:19 +0200

watchdog/softlockup: Fix cpu_stop_queue_work() double-queue bug

When scheduling is delayed for longer than the softlockup interrupt
period it is possible to double-queue the cpu_stop_work, causing list
corruption.

Cure this by adding a completion to track the cpu_stop_work's
progress.

Reported-by: kernel test robot <lkp@intel.com>
Tested-by: Rong Chen <rong.a.chen@intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Fixes: 9cf57731b63e ("watchdog/softlockup: Replace "watchdog/%u" threads with cpu_stop_work")
Link: http://lkml.kernel.org/r/20180713104208.GW2494@hirez.programming.kicks-ass.net
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/watchdog.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/kernel/watchdog.c b/kernel/watchdog.c
index b81f777838d5..5470dce212c0 100644
--- a/kernel/watchdog.c
+++ b/kernel/watchdog.c
@@ -330,6 +330,9 @@ static void watchdog_interrupt_count(void)
 	__this_cpu_inc(hrtimer_interrupts);
 }
 
+static DEFINE_PER_CPU(struct completion, softlockup_completion);
+static DEFINE_PER_CPU(struct cpu_stop_work, softlockup_stop_work);
+
 /*
  * The watchdog thread function - touches the timestamp.
  *
@@ -343,12 +346,11 @@ static int softlockup_fn(void *data)
 	__this_cpu_write(soft_lockup_hrtimer_cnt,
 			 __this_cpu_read(hrtimer_interrupts));
 	__touch_watchdog();
+	complete(this_cpu_ptr(&softlockup_completion));
 
 	return 0;
 }
 
-static DEFINE_PER_CPU(struct cpu_stop_work, softlockup_stop_work);
-
 /* watchdog kicker functions */
 static enum hrtimer_restart watchdog_timer_fn(struct hrtimer *hrtimer)
 {
@@ -364,9 +366,12 @@ static enum hrtimer_restart watchdog_timer_fn(struct hrtimer *hrtimer)
 	watchdog_interrupt_count();
 
 	/* kick the softlockup detector */
-	stop_one_cpu_nowait(smp_processor_id(),
-			softlockup_fn, NULL,
-			this_cpu_ptr(&softlockup_stop_work));
+	if (completion_done(this_cpu_ptr(&softlockup_completion))) {
+		reinit_completion(this_cpu_ptr(&softlockup_completion));
+		stop_one_cpu_nowait(smp_processor_id(),
+				softlockup_fn, NULL,
+				this_cpu_ptr(&softlockup_stop_work));
+	}
 
 	/* .. and repeat */
 	hrtimer_forward_now(hrtimer, ns_to_ktime(sample_period));
@@ -467,9 +472,13 @@ static enum hrtimer_restart watchdog_timer_fn(struct hrtimer *hrtimer)
 static void watchdog_enable(unsigned int cpu)
 {
 	struct hrtimer *hrtimer = this_cpu_ptr(&watchdog_hrtimer);
+	struct completion *done = this_cpu_ptr(&softlockup_completion);
 
 	WARN_ON_ONCE(cpu != smp_processor_id());
 
+	init_completion(done);
+	complete(done);
+
 	/*
 	 * Start the timer first to prevent the NMI watchdog triggering
 	 * before the timer has a chance to fire.
@@ -499,6 +508,7 @@ static void watchdog_disable(unsigned int cpu)
 	 */
 	watchdog_nmi_disable(cpu);
 	hrtimer_cancel(hrtimer);
+	wait_for_completion(this_cpu_ptr(&softlockup_completion));
 }
 
 static int softlockup_stop_fn(void *data)
