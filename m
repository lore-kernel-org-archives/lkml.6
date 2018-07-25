Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDE0DC6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 14:22:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A458520843
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 14:22:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A458520843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729113AbeGYPeH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 11:34:07 -0400
Received: from terminus.zytor.com ([198.137.202.136]:48971 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727881AbeGYPeH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 11:34:07 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w6PELfNU400200
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 25 Jul 2018 07:21:42 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w6PELemX400197;
        Wed, 25 Jul 2018 07:21:40 -0700
Date:   Wed, 25 Jul 2018 07:21:40 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Daniel Bristot de Oliveira <tipbot@zytor.com>
Message-ID: <tip-840d719604b0925ca23dde95f1767e4528668369@git.kernel.org>
Cc:     daniel.casini@santannapisa.it, tglx@linutronix.de,
        rostedt@goodmis.org, tommaso.cucinotta@santannapisa.it,
        juri.lelli@redhat.com, peterz@infradead.org, hpa@zytor.com,
        linux-kernel@vger.kernel.org, mingo@kernel.org, bristot@redhat.com,
        williams@redhat.com, torvalds@linux-foundation.org,
        luca.abeni@santannapisa.it
Reply-To: mingo@kernel.org, bristot@redhat.com, hpa@zytor.com,
          linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
          luca.abeni@santannapisa.it, williams@redhat.com,
          daniel.casini@santannapisa.it, peterz@infradead.org,
          juri.lelli@redhat.com, tglx@linutronix.de,
          tommaso.cucinotta@santannapisa.it, rostedt@goodmis.org
In-Reply-To: <ca31d073a4788acf0684a8b255f14fea775ccf20.1532077269.git.bristot@redhat.com>
References: <ca31d073a4788acf0684a8b255f14fea775ccf20.1532077269.git.bristot@redhat.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:sched/core] sched/deadline: Update rq_clock of later_rq when
 pushing a task
Git-Commit-ID: 840d719604b0925ca23dde95f1767e4528668369
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

Commit-ID:  840d719604b0925ca23dde95f1767e4528668369
Gitweb:     https://git.kernel.org/tip/840d719604b0925ca23dde95f1767e4528668369
Author:     Daniel Bristot de Oliveira <bristot@redhat.com>
AuthorDate: Fri, 20 Jul 2018 11:16:30 +0200
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Wed, 25 Jul 2018 11:29:08 +0200

sched/deadline: Update rq_clock of later_rq when pushing a task

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

This warning happened in the push_dl_task(), because
__add_running_bw()->cpufreq_update_util() is getting the rq_clock of
the later_rq before its update, which takes place at activate_task().
The fix then is to update the rq_clock before calling add_running_bw().

To avoid double rq_clock_update() call, we set ENQUEUE_NOCLOCK flag to
activate_task().

Reported-by: Daniel Casini <daniel.casini@santannapisa.it>
Signed-off-by: Daniel Bristot de Oliveira <bristot@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Juri Lelli <juri.lelli@redhat.com>
Cc: Clark Williams <williams@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Luca Abeni <luca.abeni@santannapisa.it>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>
Fixes: e0367b12674b sched/deadline: Move CPU frequency selection triggering points
Link: http://lkml.kernel.org/r/ca31d073a4788acf0684a8b255f14fea775ccf20.1532077269.git.bristot@redhat.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/deadline.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 10c7b51c0d1f..b5fbdde6afa9 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -2090,8 +2090,14 @@ retry:
 	sub_rq_bw(&next_task->dl, &rq->dl);
 	set_task_cpu(next_task, later_rq->cpu);
 	add_rq_bw(&next_task->dl, &later_rq->dl);
+
+	/*
+	 * Update the later_rq clock here, because the clock is used
+	 * by the cpufreq_update_util() inside __add_running_bw().
+	 */
+	update_rq_clock(later_rq);
 	add_running_bw(&next_task->dl, &later_rq->dl);
-	activate_task(later_rq, next_task, 0);
+	activate_task(later_rq, next_task, ENQUEUE_NOCLOCK);
 	ret = 1;
 
 	resched_curr(later_rq);
