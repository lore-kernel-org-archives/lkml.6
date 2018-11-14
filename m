Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4277C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 02:47:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAAB62245E
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 02:47:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="dS+mW69T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAAB62245E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732699AbeKNMsJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 07:48:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:52082 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732434AbeKNMsH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 07:48:07 -0500
Received: from lerouge.suse.de (lfbn-ncy-1-241-207.w83-194.abo.wanadoo.fr [83.194.85.207])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A4F9522419;
        Wed, 14 Nov 2018 02:46:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542163617;
        bh=eUj4RcSukekEPCJX4GbNOc6TawSt0YVnBhnGqU7g4fw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dS+mW69Td68Rv6GiaQNwsB0k4LI91bncHwUk9nx0GRyOgASpfA6KKD2KIFI3OrFVf
         CR33ZwBo5+wNyJFhYBwSTOJMF8IW7Wk8WDKUeK1NzxnrteGQ6vbdlML8anWGpzM3sa
         cXXpz+BEJTJ7U74XXmXwnmB2Gwe0rghX67rKJtPc=
From:   Frederic Weisbecker <frederic@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Wanpeng Li <wanpengli@tencent.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yauheni Kaliuta <yauheni.kaliuta@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Rik van Riel <riel@redhat.com>
Subject: [PATCH 18/25] vtime: Track nice-ness on top of context switch
Date:   Wed, 14 Nov 2018 03:46:02 +0100
Message-Id: <1542163569-20047-19-git-send-email-frederic@kernel.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1542163569-20047-1-git-send-email-frederic@kernel.org>
References: <1542163569-20047-1-git-send-email-frederic@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We need to read the nice value of the task running on any CPU, possibly
remotely, in order to correctly support kcpustat on nohz_full.
Unfortunately we can't just read task_nice(tsk) when tsk runs on another
CPU because its nice value may be concurrently changed. There could be a
risk that a recently modified nice value is thought to apply for a longer
while than is supposed to.

For example if a task runs at T0 with nice = -10, then its nice value
is changed at T0 + 1 second with nice = 10, a reader at T0 + 1 second
could think that the task had this "nice == 10" value since the beginning
(T0) and spuriously account 1 second nice time on kcpustat instead of 1
second user time.

So we need to track the nice value changes under vtime seqcount. Start
with context switches and account the vtime nice-ness on top of it.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Rik van Riel <riel@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Wanpeng Li <wanpengli@tencent.com>
Cc: Ingo Molnar <mingo@kernel.org>
---
 include/linux/sched.h  |  1 +
 kernel/sched/cputime.c | 44 +++++++++++++++++++++++++++++++++++---------
 2 files changed, 36 insertions(+), 9 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 27e0544..356326f 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -280,6 +280,7 @@ enum vtime_state {
 struct vtime {
 	seqcount_t		seqcount;
 	unsigned long long	starttime;
+	int			nice;
 	enum vtime_state	state;
 	unsigned int		cpu;
 	u64			utime;
diff --git a/kernel/sched/cputime.c b/kernel/sched/cputime.c
index 8f5dee2..07c2e7f 100644
--- a/kernel/sched/cputime.c
+++ b/kernel/sched/cputime.c
@@ -735,13 +735,42 @@ static void vtime_account_system(struct task_struct *tsk,
 static void vtime_account_guest(struct task_struct *tsk,
 				struct vtime *vtime)
 {
+	enum cpu_usage_stat index;
+
 	vtime->gtime += get_vtime_delta(vtime);
-	if (vtime->gtime >= TICK_NSEC) {
-		account_guest_time(tsk, vtime->gtime);
-		vtime->gtime = 0;
-	}
+
+	if (vtime->gtime < TICK_NSEC)
+		return;
+
+	if (vtime->nice)
+		index = CPUTIME_GUEST_NICE;
+	else
+		index = CPUTIME_GUEST;
+
+	account_guest_time_index(tsk, vtime->gtime, index);
+	vtime->gtime = 0;
 }
 
+static void vtime_account_user(struct task_struct *tsk,
+			       struct vtime *vtime)
+{
+	enum cpu_usage_stat index;
+
+	vtime->utime += get_vtime_delta(vtime);
+
+	if (vtime->utime < TICK_NSEC)
+		return;
+
+	if (vtime->nice)
+		index = CPUTIME_NICE;
+	else
+		index = CPUTIME_USER;
+
+	account_user_time_index(tsk, vtime->utime, index);
+	vtime->utime = 0;
+}
+
+
 static void __vtime_account_kernel(struct task_struct *tsk,
 				   struct vtime *vtime)
 {
@@ -779,11 +808,7 @@ void vtime_user_exit(struct task_struct *tsk)
 	struct vtime *vtime = &tsk->vtime;
 
 	write_seqcount_begin(&vtime->seqcount);
-	vtime->utime += get_vtime_delta(vtime);
-	if (vtime->utime >= TICK_NSEC) {
-		account_user_time(tsk, vtime->utime);
-		vtime->utime = 0;
-	}
+	vtime_account_user(tsk, vtime);
 	vtime->state = VTIME_SYS;
 	write_seqcount_end(&vtime->seqcount);
 }
@@ -864,6 +889,7 @@ void vtime_task_switch_generic(struct task_struct *prev)
 		vtime->state = VTIME_SYS;
 	vtime->starttime = sched_clock();
 	vtime->cpu = smp_processor_id();
+	vtime->nice = (task_nice(current) > 0) ? 1 : 0;
 	write_seqcount_end(&vtime->seqcount);
 
 	rcu_assign_pointer(kcpustat->curr, current);
-- 
2.7.4

