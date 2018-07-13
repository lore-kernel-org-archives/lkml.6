Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04E7BECDFB1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 14:09:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4AC42087A
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 14:09:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4AC42087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731329AbeGMOYD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 10:24:03 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41200 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729781AbeGMOYC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 10:24:02 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9AB5940122CF;
        Fri, 13 Jul 2018 14:09:13 +0000 (UTC)
Received: from t460s.bristot.redhat.com (ovpn-204-136.brq.redhat.com [10.40.204.136])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 637822156889;
        Fri, 13 Jul 2018 14:09:11 +0000 (UTC)
From:   Daniel Bristot de Oliveira <bristot@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Juri Lelli <juri.lelli@arm.com>,
        Luca Abeni <luca.abeni@santannapisa.it>,
        Tommaso Cucinotta <tommaso.cucinotta@sssup.it>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, stable@vger.kernel.org
Subject: [PATCH] sched/deadline: Update rq_clock of later_rq when pushing a task
Date:   Fri, 13 Jul 2018 16:09:06 +0200
Message-Id: <52d533238eb69a09fbf40b34765be312e0fd0296.1531490101.git.bristot@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Fri, 13 Jul 2018 14:09:13 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Fri, 13 Jul 2018 14:09:13 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'bristot@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Casini got this warn while running a DL task here at RetisLab:

  [  461.137582] ------------[ cut here ]------------
  [  461.137583] rq->clock_update_flags < RQCF_ACT_SKIP
  [  461.137599] WARNING: CPU: 4 PID: 2354 at kernel/sched/sched.h:967 assert_clock_updated.isra.32.part.33+0x17/0x20
      [a ton of modules]
  [  461.137646] CPU: 4 PID: 2354 Comm: label_image Not tainted 4.18.0-rc4+ #3
  [  461.137647] Hardware name: ASUS All Series/Z87-K, BIOS 0801 09/02/2013
  [  461.137649] RIP: 0010:assert_clock_updated.isra.32.part.33+0x17/0x20
  [  461.137649] Code: ff 48 89 83 08 09 00 00 eb c6 66 0f 1f 84 00 00 00 00 00 55 48 c7 c7 98 7a 6c a5 c6 05 bc 0d 54 01 01 48 89 e5 e8 a9 84 fb ff <0f> 0b 5d c3 0f 1f 44 00 00 0f 1f 44 00 00 83 7e 60 01 74 0a 48 3b
  [  461.137673] RSP: 0018:ffffa77e08cafc68 EFLAGS: 00010082
  [  461.137674] RAX: 0000000000000000 RBX: ffff8b3fc1702d80 RCX: 0000000000000006
  [  461.137674] RDX: 0000000000000007 RSI: 0000000000000096 RDI: ffff8b3fded164b0
  [  461.137675] RBP: ffffa77e08cafc68 R08: 0000000000000026 R09: 0000000000000339
  [  461.137676] R10: ffff8b3fd060d410 R11: 0000000000000026 R12: ffffffffa4e14e20
  [  461.137677] R13: ffff8b3fdec22940 R14: ffff8b3fc1702da0 R15: ffff8b3fdec22940
  [  461.137678] FS:  00007efe43ee5700(0000) GS:ffff8b3fded00000(0000) knlGS:0000000000000000
  [  461.137679] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  [  461.137680] CR2: 00007efe30000010 CR3: 0000000301744003 CR4: 00000000001606e0
  [  461.137680] Call Trace:
  [  461.137684]  push_dl_task.part.46+0x3bc/0x460
  [  461.137686]  task_woken_dl+0x60/0x80
  [  461.137689]  ttwu_do_wakeup+0x4f/0x150
  [  461.137690]  ttwu_do_activate+0x77/0x80
  [  461.137692]  try_to_wake_up+0x1d6/0x4c0
  [  461.137693]  wake_up_q+0x32/0x70
  [  461.137696]  do_futex+0x7e7/0xb50
  [  461.137698]  __x64_sys_futex+0x8b/0x180
  [  461.137701]  do_syscall_64+0x5a/0x110
  [  461.137703]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
  [  461.137705] RIP: 0033:0x7efe4918ca26
  [  461.137705] Code: 00 00 00 74 17 49 8b 48 20 44 8b 59 10 41 83 e3 30 41 83 fb 20 74 1e be 85 00 00 00 41 ba 01 00 00 00 41 b9 01 00 00 04 0f 05 <48> 3d 01 f0 ff ff 73 1f 31 c0 c3 be 8c 00 00 00 49 89 c8 4d 31 d2
  [  461.137738] RSP: 002b:00007efe43ee4928 EFLAGS: 00000283 ORIG_RAX: 00000000000000ca
  [  461.137739] RAX: ffffffffffffffda RBX: 0000000005094df0 RCX: 00007efe4918ca26
  [  461.137740] RDX: 0000000000000001 RSI: 0000000000000085 RDI: 0000000005094e24
  [  461.137741] RBP: 00007efe43ee49c0 R08: 0000000005094e20 R09: 0000000004000001
  [  461.137741] R10: 0000000000000001 R11: 0000000000000283 R12: 0000000000000000
  [  461.137742] R13: 0000000005094df8 R14: 0000000000000001 R15: 0000000000448a10
  [  461.137743] ---[ end trace 187df4cad2bf7649 ]---

This warning was caused in the push_dl_task(), because the rq_clock of
the later_rq was used by cpufreq_update_util() inside __add_running_bw(),
before its update at activate_task(). The fix then is to update the
clock before calling add_running_bw.

To avoid double rq_clock_update(), we set ENQUEUE_NOCLOCK flag to
activate_task().

Reported-by: Daniel Casini <daniel.casini@santannapisa.it>
Signed-off-by: Daniel Bristot de Oliveira <bristot@redhat.com>
Cc: Juri Lelli <juri.lelli@arm.com>
Cc: Luca Abeni <luca.abeni@santannapisa.it>
Cc: Tommaso Cucinotta <tommaso.cucinotta@sssup.it>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org
Cc: <stable@vger.kernel.org> # 4.16+
Fixes: e0367b12674b sched/deadline: Move CPU frequency selection triggering points
---
 kernel/sched/deadline.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index fbfc3f1d368a..e733c15b7695 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -2090,8 +2090,16 @@ static int push_dl_task(struct rq *rq)
 	sub_rq_bw(&next_task->dl, &rq->dl);
 	set_task_cpu(next_task, later_rq->cpu);
 	add_rq_bw(&next_task->dl, &later_rq->dl);
+
+	/*
+	 * Update the later_rq clock here, because the clock is used
+	 * by the cpufreq_update_util() inside __add_running_bw().
+	 * Then, set ENQUEUE_NOCLOCK flag to avoid updating the rq_clock
+	 * again in the activate_task()->enqueue_task().
+	 */
+	update_rq_clock(later_rq);
 	add_running_bw(&next_task->dl, &later_rq->dl);
-	activate_task(later_rq, next_task, 0);
+	activate_task(later_rq, next_task, ENQUEUE_NOCLOCK);
 	ret = 1;
 
 	resched_curr(later_rq);
-- 
2.17.1

