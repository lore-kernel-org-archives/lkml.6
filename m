Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94CF5C43610
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 02:46:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 595242250F
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 02:46:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="jQ68PtkF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 595242250F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732433AbeKNMrs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 07:47:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:51720 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732374AbeKNMrr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 07:47:47 -0500
Received: from lerouge.suse.de (lfbn-ncy-1-241-207.w83-194.abo.wanadoo.fr [83.194.85.207])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4DC0C2245E;
        Wed, 14 Nov 2018 02:46:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542163597;
        bh=G4dQcNE8gHAxIUww8mS4/3334uIZk095aRN1sG4j5PQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jQ68PtkFi4rG/6PLR3cwQ1AHce0fIPPYySVO1PwWrkJFWocP++g91V0Ikix0MfiUS
         z4ZD4Ex1Z5P82+EkraJ3W8DDK596CW8cAnKxXQOKpqE+w8uhJHIfBOanRsxfZy0kjp
         FtLC3gRQlBDms9nKUXYAvmFxalQ2cDT5LT9zqfV8=
From:   Frederic Weisbecker <frederic@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Wanpeng Li <wanpengli@tencent.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yauheni Kaliuta <yauheni.kaliuta@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Rik van Riel <riel@redhat.com>
Subject: [PATCH 09/25] kcpustat: Track running task following vtime sequences
Date:   Wed, 14 Nov 2018 03:45:53 +0100
Message-Id: <1542163569-20047-10-git-send-email-frederic@kernel.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1542163569-20047-1-git-send-email-frederic@kernel.org>
References: <1542163569-20047-1-git-send-email-frederic@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to make kcpustat vtime aware (ie: work on nohz_full without
freezing), we need to track the task running on the CPU in order to
fetch its vtime delta and add it to the relevant kcpustat field.

The most efficient way to track this task is to use RCU. The task is
assigned on context switch right after we flush the vtime of the previous
task and the next task has been set on vtime.

Things are then prepared to be ordered that way:

             WRITER (ctx switch)                READER
             ------------------            -----------------------
        vtime_seqcount_write_lock(prev)     rcu_read_lock()
        //flush prev vtime                  curr = rcu_dereference(kcpustat->curr)
        vtime_seqcount_write_unlock(prev)   vtime_seqcount_read_start(curr)
                                            //fetch curr vtime
        vtime_seqcount_lock(next)           vtime_seqcount_read_end(curr)
        //Init vtime                        rcu_read_unlock()
        vtime_seqcount_unlock(next)

        rcu_assign_pointer(kcpustat->curr, next)

With this ordering layout, we are sure that we get a sequence with a
coherent couple (task cputime, kcpustat).

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Rik van Riel <riel@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Wanpeng Li <wanpengli@tencent.com>
Cc: Ingo Molnar <mingo@kernel.org>
---
 include/linux/kernel_stat.h |  1 +
 kernel/sched/cputime.c      | 11 ++++++++++-
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/include/linux/kernel_stat.h b/include/linux/kernel_stat.h
index 7ee2bb4..86fdbce 100644
--- a/include/linux/kernel_stat.h
+++ b/include/linux/kernel_stat.h
@@ -32,6 +32,7 @@ enum cpu_usage_stat {
 };
 
 struct kernel_cpustat {
+	struct task_struct __rcu *curr;
 	u64 cpustat[NR_STATS];
 };
 
diff --git a/kernel/sched/cputime.c b/kernel/sched/cputime.c
index a0c3a82..2eb313a 100644
--- a/kernel/sched/cputime.c
+++ b/kernel/sched/cputime.c
@@ -812,6 +812,7 @@ void vtime_account_idle(struct task_struct *tsk)
 void vtime_task_switch_generic(struct task_struct *prev)
 {
 	struct vtime *vtime = &prev->vtime;
+	struct kernel_cpustat *kcpustat = kcpustat_this_cpu;
 
 	/*
 	 * Flush the prev task vtime, unless it has passed
@@ -835,8 +836,10 @@ void vtime_task_switch_generic(struct task_struct *prev)
 	 * Ignore the next task if it has been preempted after
 	 * vtime_exit_task().
 	 */
-	if (vtime->state == VTIME_DEAD)
+	if (vtime->state == VTIME_DEAD) {
+		rcu_assign_pointer(kcpustat->curr, NULL);
 		return;
+	}
 
 	write_seqcount_begin(&vtime->seqcount);
 	if (is_idle_task(current))
@@ -848,10 +851,13 @@ void vtime_task_switch_generic(struct task_struct *prev)
 	vtime->starttime = sched_clock();
 	vtime->cpu = smp_processor_id();
 	write_seqcount_end(&vtime->seqcount);
+
+	rcu_assign_pointer(kcpustat->curr, current);
 }
 
 void vtime_init_idle(struct task_struct *t, int cpu)
 {
+	struct kernel_cpustat *kcpustat = &kcpustat_cpu(cpu);
 	struct vtime *vtime = &t->vtime;
 	unsigned long flags;
 
@@ -862,6 +868,8 @@ void vtime_init_idle(struct task_struct *t, int cpu)
 	vtime->cpu = cpu;
 	write_seqcount_end(&vtime->seqcount);
 	local_irq_restore(flags);
+
+	rcu_assign_pointer(kcpustat->curr, t);
 }
 
 /*
@@ -885,6 +893,7 @@ void vtime_exit_task(struct task_struct *t)
 	vtime->state = VTIME_DEAD;
 	vtime->cpu = -1;
 	write_seqcount_end(&vtime->seqcount);
+	rcu_assign_pointer(kcpustat_this_cpu->curr, NULL);
 	local_irq_restore(flags);
 }
 
-- 
2.7.4

