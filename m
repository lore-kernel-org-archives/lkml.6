Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC53FC169D4
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 02:46:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8147022513
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 02:46:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="houvQSdY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8147022513
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732316AbeKNMri (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 07:47:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:51522 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731854AbeKNMri (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 07:47:38 -0500
Received: from lerouge.suse.de (lfbn-ncy-1-241-207.w83-194.abo.wanadoo.fr [83.194.85.207])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4386A2243E;
        Wed, 14 Nov 2018 02:46:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542163588;
        bh=19WkyUkboSZyfb9685TeeAVHMmQCKTfx25fgEa3jisI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=houvQSdYSSYO77mZUQ2F5sGCdKKKvp874T1QN3MHY5snuhuR7VQqKjjaFJ+RcYyb1
         ckwRpoYOzceu1MpXuEnX1YdWEbKg2SPT6SaPM7ux5b/Whchmtv0gO2fOjl/Br/5Ri7
         o5KQP8Bydil70zDmaDG6dhM/JNQ1bwTXaE/B5tOk=
From:   Frederic Weisbecker <frederic@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Wanpeng Li <wanpengli@tencent.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yauheni Kaliuta <yauheni.kaliuta@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Rik van Riel <riel@redhat.com>
Subject: [PATCH 05/25] sched/vtime: Record CPU under seqcount for kcpustat needs
Date:   Wed, 14 Nov 2018 03:45:49 +0100
Message-Id: <1542163569-20047-6-git-send-email-frederic@kernel.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1542163569-20047-1-git-send-email-frederic@kernel.org>
References: <1542163569-20047-1-git-send-email-frederic@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to compute the kcpustat delta on a nohz CPU, we'll need to
fetch the task running on that target. Checking that its vtime
state snapshot actually refers to the relevant target involves recording
that CPU under the seqcount locked on task switch.

This is a step toward making kcpustat moving forward on full nohz CPUs.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Rik van Riel <riel@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Wanpeng Li <wanpengli@tencent.com>
Cc: Ingo Molnar <mingo@kernel.org>
---
 include/linux/sched.h  | 1 +
 kernel/sched/cputime.c | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index a51c13c..9f56880 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -275,6 +275,7 @@ struct vtime {
 	seqcount_t		seqcount;
 	unsigned long long	starttime;
 	enum vtime_state	state;
+	unsigned int		cpu;
 	u64			utime;
 	u64			stime;
 	u64			gtime;
diff --git a/kernel/sched/cputime.c b/kernel/sched/cputime.c
index facc665..6ac27687 100644
--- a/kernel/sched/cputime.c
+++ b/kernel/sched/cputime.c
@@ -817,6 +817,7 @@ void vtime_task_switch_generic(struct task_struct *prev)
 	else
 		__vtime_account_kernel(prev, vtime);
 	vtime->state = VTIME_INACTIVE;
+	vtime->cpu = -1;
 	write_seqcount_end(&vtime->seqcount);
 
 	vtime = &current->vtime;
@@ -824,6 +825,7 @@ void vtime_task_switch_generic(struct task_struct *prev)
 	write_seqcount_begin(&vtime->seqcount);
 	vtime->state = VTIME_SYS;
 	vtime->starttime = sched_clock();
+	vtime->cpu = smp_processor_id();
 	write_seqcount_end(&vtime->seqcount);
 }
 
@@ -836,6 +838,7 @@ void vtime_init_idle(struct task_struct *t, int cpu)
 	write_seqcount_begin(&vtime->seqcount);
 	vtime->state = VTIME_SYS;
 	vtime->starttime = sched_clock();
+	vtime->cpu = cpu;
 	write_seqcount_end(&vtime->seqcount);
 	local_irq_restore(flags);
 }
-- 
2.7.4

