Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752776AbeE1BY5 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 27 May 2018 21:24:57 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:42990 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751760AbeE1BY4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 May 2018 21:24:56 -0400
X-Google-Smtp-Source: AB8JxZqTtxXihfoTD/hd74JLua3JCBggsoCEUjcv6piU9Bq4RPojDnp87xIConfrlTjK874w2RY8RQ==
From: "Joel Fernandes (Google)" <joelaf@google.com>
X-Google-Original-From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
To: linux-kernel@vger.kernel.org
Cc: "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Ramussen <morten.rasmussen@arm.com>,
        Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        Rohit Jain <rohit.k.jain@oracle.com>, kernel-team@android.com
Subject: [PATCH v2] sched: Remove obscure comment from select_task_rq_fair
Date: Sun, 27 May 2018 18:24:47 -0700
Message-Id: <20180528012447.115411-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.17.0.921.gf22659ad46-goog
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I was playing with cpusets and sched_load_balance flag and notice that
the fast-path (select_idle_sibling) can also be attempted for
exec-balance, not just wake-balance if the waker cpu's cpuset has
sched_load_balance = 0. This patch removes the obscure comment which was
saying this path can be entered only for wake-balance.

To trigger this, I just do:
mkdir /cpuset
mount -t cpuset none /cpuset
echo 0 > sched_load_balance

Then did some random activity and dumped the stack from 'if (!sd)' for
the non wake-balance cases.

Following is one of the stacks:
dump_stack+0x46/0x5b
select_task_rq_fair+0x101d/0x1030
sched_exec+0x4f/0xc0
do_execveat_common.isra.41+0x1e3/0x7c0
__x64_sys_execve+0x2d/0x40
do_syscall_64+0x43/0xf0
entry_SYSCALL_64_after_hwframe+0x44/0xa9

Turns out the same case occurs also during boot up when kthreadd tries
to create threads before domains are attached so lets fix the comment.

Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Morten Ramussen <morten.rasmussen@arm.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: Rohit Jain <rohit.k.jain@oracle.com>
Cc: kernel-team@android.com
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
v1->v2: Resending without "XXX" in subject since otherwise LKML thinks
its junk.

 kernel/sched/fair.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 54dc31e7ab9b..dd07794141d0 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6665,7 +6665,7 @@ select_task_rq_fair(struct task_struct *p, int prev_cpu, int sd_flag, int wake_f
 
 	if (!sd) {
 pick_cpu:
-		if (sd_flag & SD_BALANCE_WAKE) { /* XXX always ? */
+		if (sd_flag & SD_BALANCE_WAKE) {
 			new_cpu = select_idle_sibling(p, prev_cpu, new_cpu);
 
 			if (want_affine)
-- 
2.17.0.921.gf22659ad46-goog
