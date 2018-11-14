Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 600C1C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 02:46:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 248742250E
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 02:46:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="beHTvLjX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 248742250E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732377AbeKNMro (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 07:47:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:51632 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727357AbeKNMrn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 07:47:43 -0500
Received: from lerouge.suse.de (lfbn-ncy-1-241-207.w83-194.abo.wanadoo.fr [83.194.85.207])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C101222507;
        Wed, 14 Nov 2018 02:46:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542163592;
        bh=5J7DJV2bFO4pShl4YrB3jAtqNmWqszbY4E0PBMkeRa4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=beHTvLjXssa3+hSwivglJhxLSm5FWjvc6hLZXpdQjphGJrb3P4YwUlalfXmcmijuB
         mBXi65RhcPer/A5zWY0o/kE8eBf46pDvs5sUUnCA93KEI6YtDR5UKeYhLhRzH/1+gH
         381rzmbEUKwqLB10obdAA+j38V6QW7NAhh6Y3QDc=
From:   Frederic Weisbecker <frederic@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Wanpeng Li <wanpengli@tencent.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yauheni Kaliuta <yauheni.kaliuta@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Rik van Riel <riel@redhat.com>
Subject: [PATCH 07/25] sched/cputime: Add vtime guest task state
Date:   Wed, 14 Nov 2018 03:45:51 +0100
Message-Id: <1542163569-20047-8-git-send-email-frederic@kernel.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1542163569-20047-1-git-send-email-frederic@kernel.org>
References: <1542163569-20047-1-git-send-email-frederic@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Record guest as a VTIME state instead of guessing it from VTIME_SYS and
PF_VCPU. This is going to simplify the cputime read side especially as
its state machine is going to further expand in order to fully support
kcpustat on nohz_full.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Rik van Riel <riel@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Wanpeng Li <wanpengli@tencent.com>
Cc: Ingo Molnar <mingo@kernel.org>
---
 include/linux/sched.h  |  2 ++
 kernel/sched/cputime.c | 18 +++++++++++-------
 2 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 6d13938..d458d65 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -271,6 +271,8 @@ enum vtime_state {
 	VTIME_SYS,
 	/* Task runs in userspace in a CPU with VTIME active: */
 	VTIME_USER,
+	/* Task runs as guests in a CPU with VTIME active: */
+	VTIME_GUEST,
 };
 
 struct vtime {
diff --git a/kernel/sched/cputime.c b/kernel/sched/cputime.c
index a9f42cc..f64afd7 100644
--- a/kernel/sched/cputime.c
+++ b/kernel/sched/cputime.c
@@ -732,7 +732,7 @@ static void __vtime_account_kernel(struct task_struct *tsk,
 				   struct vtime *vtime)
 {
 	/* We might have scheduled out from guest path */
-	if (tsk->flags & PF_VCPU)
+	if (vtime->state == VTIME_GUEST)
 		vtime_account_guest(tsk, vtime);
 	else
 		vtime_account_system(tsk, vtime);
@@ -787,6 +787,7 @@ void vtime_guest_enter(struct task_struct *tsk)
 	write_seqcount_begin(&vtime->seqcount);
 	vtime_account_system(tsk, vtime);
 	tsk->flags |= PF_VCPU;
+	vtime->state = VTIME_GUEST;
 	write_seqcount_end(&vtime->seqcount);
 }
 EXPORT_SYMBOL_GPL(vtime_guest_enter);
@@ -798,6 +799,7 @@ void vtime_guest_exit(struct task_struct *tsk)
 	write_seqcount_begin(&vtime->seqcount);
 	vtime_account_guest(tsk, vtime);
 	tsk->flags &= ~PF_VCPU;
+	vtime->state = VTIME_SYS;
 	write_seqcount_end(&vtime->seqcount);
 }
 EXPORT_SYMBOL_GPL(vtime_guest_exit);
@@ -825,6 +827,8 @@ void vtime_task_switch_generic(struct task_struct *prev)
 	write_seqcount_begin(&vtime->seqcount);
 	if (is_idle_task(current))
 		vtime->state = VTIME_IDLE;
+	else if (current->flags & PF_VCPU)
+		vtime->state = VTIME_GUEST;
 	else
 		vtime->state = VTIME_SYS;
 	vtime->starttime = sched_clock();
@@ -859,7 +863,7 @@ u64 task_gtime(struct task_struct *t)
 		seq = read_seqcount_begin(&vtime->seqcount);
 
 		gtime = t->gtime;
-		if (vtime->state == VTIME_SYS && t->flags & PF_VCPU)
+		if (vtime->state == VTIME_GUEST)
 			gtime += vtime->gtime + vtime_delta(vtime);
 
 	} while (read_seqcount_retry(&vtime->seqcount, seq));
@@ -897,13 +901,13 @@ void task_cputime(struct task_struct *t, u64 *utime, u64 *stime)
 		delta = vtime_delta(vtime);
 
 		/*
-		 * Task runs either in user or kernel space, add pending nohz time to
-		 * the right place.
+		 * Task runs either in user (including guest) or kernel space,
+		 * add pending nohz time to the right place.
 		 */
-		if (vtime->state == VTIME_USER || t->flags & PF_VCPU)
-			*utime += vtime->utime + delta;
-		else if (vtime->state == VTIME_SYS)
+		if (vtime->state == VTIME_SYS)
 			*stime += vtime->stime + delta;
+		else
+			*utime += vtime->utime + delta;
 	} while (read_seqcount_retry(&vtime->seqcount, seq));
 }
 #endif /* CONFIG_VIRT_CPU_ACCOUNTING_GEN */
-- 
2.7.4

