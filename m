Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F4E1C43610
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 02:46:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23AEF2245E
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 02:46:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="xQAdNGev"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23AEF2245E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732349AbeKNMrl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 07:47:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:51582 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727357AbeKNMrk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 07:47:40 -0500
Received: from lerouge.suse.de (lfbn-ncy-1-241-207.w83-194.abo.wanadoo.fr [83.194.85.207])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8217C22419;
        Wed, 14 Nov 2018 02:46:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542163590;
        bh=TKimE9r/YNsqSAV8Klu9gybZyMmy7l2XqqjLS4Me9JE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xQAdNGevAEQk8LCen4+XwqSyztHwFRCZ2PCMEC+kzp14gMuPXpqpwSNQptjGKSj0D
         T9NVV62EvOfLCZfKRfgBgc5mVe70t3swPAf3VHStpY5JpNkLhawPscyJhM33An8r1v
         btzjl2nTMFlLpkU4gXo9KUOWENJHPBzsaaD7FwtI=
From:   Frederic Weisbecker <frederic@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Wanpeng Li <wanpengli@tencent.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yauheni Kaliuta <yauheni.kaliuta@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Rik van Riel <riel@redhat.com>
Subject: [PATCH 06/25] sched/cputime: Add vtime idle task state
Date:   Wed, 14 Nov 2018 03:45:50 +0100
Message-Id: <1542163569-20047-7-git-send-email-frederic@kernel.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1542163569-20047-1-git-send-email-frederic@kernel.org>
References: <1542163569-20047-1-git-send-email-frederic@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Record idle as a VTIME state instead of guessing it from VTIME_SYS and
is_idle_task(). This is going to simplify the cputime read side
especially as its state machine is going to further expand in order to
fully support kcpustat on nohz_full.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Rik van Riel <riel@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Wanpeng Li <wanpengli@tencent.com>
Cc: Ingo Molnar <mingo@kernel.org>
---
 include/linux/sched.h  |  6 ++++--
 kernel/sched/cputime.c | 13 ++++++++-----
 2 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 9f56880..6d13938 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -265,10 +265,12 @@ struct task_cputime {
 enum vtime_state {
 	/* Task is sleeping or running in a CPU with VTIME inactive: */
 	VTIME_INACTIVE = 0,
-	/* Task runs in userspace in a CPU with VTIME active: */
-	VTIME_USER,
+	/* Task is idle */
+	VTIME_IDLE,
 	/* Task runs in kernelspace in a CPU with VTIME active: */
 	VTIME_SYS,
+	/* Task runs in userspace in a CPU with VTIME active: */
+	VTIME_USER,
 };
 
 struct vtime {
diff --git a/kernel/sched/cputime.c b/kernel/sched/cputime.c
index 6ac27687..a9f42cc 100644
--- a/kernel/sched/cputime.c
+++ b/kernel/sched/cputime.c
@@ -812,7 +812,7 @@ void vtime_task_switch_generic(struct task_struct *prev)
 	struct vtime *vtime = &prev->vtime;
 
 	write_seqcount_begin(&vtime->seqcount);
-	if (is_idle_task(prev))
+	if (vtime->state == VTIME_IDLE)
 		vtime_account_idle(prev);
 	else
 		__vtime_account_kernel(prev, vtime);
@@ -823,7 +823,10 @@ void vtime_task_switch_generic(struct task_struct *prev)
 	vtime = &current->vtime;
 
 	write_seqcount_begin(&vtime->seqcount);
-	vtime->state = VTIME_SYS;
+	if (is_idle_task(current))
+		vtime->state = VTIME_IDLE;
+	else
+		vtime->state = VTIME_SYS;
 	vtime->starttime = sched_clock();
 	vtime->cpu = smp_processor_id();
 	write_seqcount_end(&vtime->seqcount);
@@ -836,7 +839,7 @@ void vtime_init_idle(struct task_struct *t, int cpu)
 
 	local_irq_save(flags);
 	write_seqcount_begin(&vtime->seqcount);
-	vtime->state = VTIME_SYS;
+	vtime->state = VTIME_IDLE;
 	vtime->starttime = sched_clock();
 	vtime->cpu = cpu;
 	write_seqcount_end(&vtime->seqcount);
@@ -887,8 +890,8 @@ void task_cputime(struct task_struct *t, u64 *utime, u64 *stime)
 		*utime = t->utime;
 		*stime = t->stime;
 
-		/* Task is sleeping, nothing to add */
-		if (vtime->state == VTIME_INACTIVE || is_idle_task(t))
+		/* Task is sleeping or idle, nothing to add */
+		if (vtime->state < VTIME_SYS)
 			continue;
 
 		delta = vtime_delta(vtime);
-- 
2.7.4

