Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5382C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 02:46:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C11A2245E
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 02:46:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="pPV6Jpap"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C11A2245E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732674AbeKNMsG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 07:48:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:52042 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732434AbeKNMsG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 07:48:06 -0500
Received: from lerouge.suse.de (lfbn-ncy-1-241-207.w83-194.abo.wanadoo.fr [83.194.85.207])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 666DF20818;
        Wed, 14 Nov 2018 02:46:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542163615;
        bh=eL+cir4No9Ss1Hw6yOKvPy5pYzsimnzc9TXY0k2GB64=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pPV6JpapkkDgtikldGmF4iMztI1gcnGFZzCHSc7wRCVp0wjY2pCZ87C1F2Gpoxbul
         Q6qQCEynsWU6S+pwqHXCRehpQPmMjF3ZN9eC5NbKllljJv1vvx4jPouUcwfY9jLBAW
         ZCx8TI37g8EXKfCKAgd64Nsxha8KuYDO9/G3FM4g=
From:   Frederic Weisbecker <frederic@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Wanpeng Li <wanpengli@tencent.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yauheni Kaliuta <yauheni.kaliuta@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Rik van Riel <riel@redhat.com>
Subject: [PATCH 17/25] sched/cputime: Standardize the kcpustat index based accounting functions
Date:   Wed, 14 Nov 2018 03:46:01 +0100
Message-Id: <1542163569-20047-18-git-send-email-frederic@kernel.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1542163569-20047-1-git-send-email-frederic@kernel.org>
References: <1542163569-20047-1-git-send-email-frederic@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sanitize a bit the functions that do cputime accounting with custom
kcpustat indexes:

* Rename account_system_index_time() to account_system_time_index() to
  comply with account_guest/user_time_index()

* Use proper enum cpu_usage_stat type in account_system_time()

* Reorder task_group_account_field() parameters to comply with those of
  account_*_time_index().

* Rename task_group_account_field()'s tmp parameter to cputime

* Precise the type of index in task_group_account_field(): enum cpu_usage_stat

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Rik van Riel <riel@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Wanpeng Li <wanpengli@tencent.com>
Cc: Ingo Molnar <mingo@kernel.org>
---
 arch/ia64/kernel/time.c     |  6 +++---
 arch/powerpc/kernel/time.c  |  6 +++---
 arch/s390/kernel/vtime.c    |  2 +-
 include/linux/kernel_stat.h |  2 +-
 kernel/sched/cputime.c      | 22 +++++++++++-----------
 5 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/arch/ia64/kernel/time.c b/arch/ia64/kernel/time.c
index a3b09ea..46a9798 100644
--- a/arch/ia64/kernel/time.c
+++ b/arch/ia64/kernel/time.c
@@ -79,17 +79,17 @@ void vtime_flush(struct task_struct *tsk)
 
 	if (ti->stime) {
 		delta = cycle_to_nsec(ti->stime);
-		account_system_index_time(tsk, delta, CPUTIME_SYSTEM);
+		account_system_time_index(tsk, delta, CPUTIME_SYSTEM);
 	}
 
 	if (ti->hardirq_time) {
 		delta = cycle_to_nsec(ti->hardirq_time);
-		account_system_index_time(tsk, delta, CPUTIME_IRQ);
+		account_system_time_index(tsk, delta, CPUTIME_IRQ);
 	}
 
 	if (ti->softirq_time) {
 		delta = cycle_to_nsec(ti->softirq_time);
-		account_system_index_time(tsk, delta, CPUTIME_SOFTIRQ);
+		account_system_time_index(tsk, delta, CPUTIME_SOFTIRQ);
 	}
 
 	ti->utime = 0;
diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
index cc591a4..6e6e0c8 100644
--- a/arch/powerpc/kernel/time.c
+++ b/arch/powerpc/kernel/time.c
@@ -422,14 +422,14 @@ void vtime_flush(struct task_struct *tsk)
 		account_idle_time(cputime_to_nsecs(acct->idle_time));
 
 	if (acct->stime)
-		account_system_index_time(tsk, cputime_to_nsecs(acct->stime),
+		account_system_time_index(tsk, cputime_to_nsecs(acct->stime),
 					  CPUTIME_SYSTEM);
 
 	if (acct->hardirq_time)
-		account_system_index_time(tsk, cputime_to_nsecs(acct->hardirq_time),
+		account_system_time_index(tsk, cputime_to_nsecs(acct->hardirq_time),
 					  CPUTIME_IRQ);
 	if (acct->softirq_time)
-		account_system_index_time(tsk, cputime_to_nsecs(acct->softirq_time),
+		account_system_time_index(tsk, cputime_to_nsecs(acct->softirq_time),
 					  CPUTIME_SOFTIRQ);
 
 	vtime_flush_scaled(tsk, acct);
diff --git a/arch/s390/kernel/vtime.c b/arch/s390/kernel/vtime.c
index af48db3..b6b888d 100644
--- a/arch/s390/kernel/vtime.c
+++ b/arch/s390/kernel/vtime.c
@@ -115,7 +115,7 @@ static void account_system_index_scaled(struct task_struct *p, u64 cputime,
 					enum cpu_usage_stat index)
 {
 	p->stimescaled += cputime_to_nsecs(scale_vtime(cputime));
-	account_system_index_time(p, cputime_to_nsecs(cputime), index);
+	account_system_time_index(p, cputime_to_nsecs(cputime), index);
 }
 
 /*
diff --git a/include/linux/kernel_stat.h b/include/linux/kernel_stat.h
index 86fdbce..049d973 100644
--- a/include/linux/kernel_stat.h
+++ b/include/linux/kernel_stat.h
@@ -82,7 +82,7 @@ static inline unsigned int kstat_cpu_irqs_sum(unsigned int cpu)
 extern void account_user_time(struct task_struct *, u64);
 extern void account_guest_time(struct task_struct *, u64);
 extern void account_system_time(struct task_struct *, int, u64);
-extern void account_system_index_time(struct task_struct *, u64,
+extern void account_system_time_index(struct task_struct *, u64,
 				      enum cpu_usage_stat);
 extern void account_steal_time(u64);
 extern void account_idle_time(u64);
diff --git a/kernel/sched/cputime.c b/kernel/sched/cputime.c
index 63c4f0b..8f5dee2 100644
--- a/kernel/sched/cputime.c
+++ b/kernel/sched/cputime.c
@@ -94,8 +94,8 @@ static u64 irqtime_tick_accounted(u64 dummy)
 
 #endif /* !CONFIG_IRQ_TIME_ACCOUNTING */
 
-static inline void task_group_account_field(struct task_struct *p, int index,
-					    u64 tmp)
+static inline void task_group_account_field(struct task_struct *p, u64 cputime,
+					    enum cpu_usage_stat index)
 {
 	/*
 	 * Since all updates are sure to touch the root cgroup, we
@@ -103,9 +103,9 @@ static inline void task_group_account_field(struct task_struct *p, int index,
 	 * is the only cgroup, then nothing else should be necessary.
 	 *
 	 */
-	__this_cpu_add(kernel_cpustat.cpustat[index], tmp);
+	__this_cpu_add(kernel_cpustat.cpustat[index], cputime);
 
-	cgroup_account_cputime_field(p, index, tmp);
+	cgroup_account_cputime_field(p, index, cputime);
 }
 
 static void account_user_time_index(struct task_struct *p,
@@ -116,7 +116,7 @@ static void account_user_time_index(struct task_struct *p,
 	account_group_user_time(p, cputime);
 
 	/* Add user time to cpustat. */
-	task_group_account_field(p, index, cputime);
+	task_group_account_field(p, cputime, index);
 
 	/* Account for user time used */
 	acct_account_cputime(p);
@@ -174,7 +174,7 @@ void account_guest_time(struct task_struct *p, u64 cputime)
  * @cputime: the CPU time spent in kernel space since the last update
  * @index: pointer to cpustat field that has to be updated
  */
-void account_system_index_time(struct task_struct *p,
+void account_system_time_index(struct task_struct *p,
 			       u64 cputime, enum cpu_usage_stat index)
 {
 	/* Add system time to process. */
@@ -182,7 +182,7 @@ void account_system_index_time(struct task_struct *p,
 	account_group_system_time(p, cputime);
 
 	/* Add system time to cpustat. */
-	task_group_account_field(p, index, cputime);
+	task_group_account_field(p, cputime, index);
 
 	/* Account for system time used */
 	acct_account_cputime(p);
@@ -196,7 +196,7 @@ void account_system_index_time(struct task_struct *p,
  */
 void account_system_time(struct task_struct *p, int hardirq_offset, u64 cputime)
 {
-	int index;
+	enum cpu_usage_stat index;
 
 	if ((p->flags & PF_VCPU) && (irq_count() - hardirq_offset == 0)) {
 		account_guest_time(p, cputime);
@@ -210,7 +210,7 @@ void account_system_time(struct task_struct *p, int hardirq_offset, u64 cputime)
 	else
 		index = CPUTIME_SYSTEM;
 
-	account_system_index_time(p, cputime, index);
+	account_system_time_index(p, cputime, index);
 }
 
 /*
@@ -391,7 +391,7 @@ static void irqtime_account_process_tick(struct task_struct *p, int user_tick,
 		 * So, we have to handle it separately here.
 		 * Also, p->stime needs to be updated for ksoftirqd.
 		 */
-		account_system_index_time(p, cputime, CPUTIME_SOFTIRQ);
+		account_system_time_index(p, cputime, CPUTIME_SOFTIRQ);
 	} else if (user_tick) {
 		account_user_time(p, cputime);
 	} else if (p == rq->idle) {
@@ -399,7 +399,7 @@ static void irqtime_account_process_tick(struct task_struct *p, int user_tick,
 	} else if (p->flags & PF_VCPU) { /* System time or guest time */
 		account_guest_time(p, cputime);
 	} else {
-		account_system_index_time(p, cputime, CPUTIME_SYSTEM);
+		account_system_time_index(p, cputime, CPUTIME_SYSTEM);
 	}
 }
 
-- 
2.7.4

