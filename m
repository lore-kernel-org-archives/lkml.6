Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933211AbeBUKbh (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 05:31:37 -0500
Received: from terminus.zytor.com ([198.137.202.136]:34653 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932751AbeBUKbg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 05:31:36 -0500
Date: Wed, 21 Feb 2018 02:29:07 -0800
From: tip-bot for Peter Zijlstra <tipbot@zytor.com>
Message-ID: <tip-24d0c1d6e65f635b2c0684d0a42ff6c0674aa0e6@git.kernel.org>
Cc: torvalds@linux-foundation.org, hpa@zytor.com, ggherdovich@suse.cz,
        efault@gmx.de, mgorman@techsingularity.net, tglx@linutronix.de,
        peterz@infradead.org, mingo@kernel.org, linux-kernel@vger.kernel.org,
        matt@codeblueprint.co.uk
Reply-To: torvalds@linux-foundation.org, hpa@zytor.com, mingo@kernel.org,
        peterz@infradead.org, tglx@linutronix.de, mgorman@techsingularity.net,
        efault@gmx.de, ggherdovich@suse.cz, matt@codeblueprint.co.uk,
        linux-kernel@vger.kernel.org
In-Reply-To: <20180213133730.24064-5-mgorman@techsingularity.net>
References: <20180213133730.24064-5-mgorman@techsingularity.net>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:sched/core] sched/fair: Do not migrate due to a sync wakeup on
 exit
Git-Commit-ID: 24d0c1d6e65f635b2c0684d0a42ff6c0674aa0e6
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  24d0c1d6e65f635b2c0684d0a42ff6c0674aa0e6
Gitweb:     https://git.kernel.org/tip/24d0c1d6e65f635b2c0684d0a42ff6c0674aa0e6
Author:     Peter Zijlstra <peterz@infradead.org>
AuthorDate: Tue, 13 Feb 2018 13:37:28 +0000
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Wed, 21 Feb 2018 08:49:42 +0100

sched/fair: Do not migrate due to a sync wakeup on exit

When a task exits, it notifies the parent that it has exited. This is a
sync wakeup and the exiting task may pull the parent towards the wakers
CPU. For simple workloads like using a shell, it was observed that the
shell is pulled across nodes by exiting processes. This is daft as the
parent may be long-lived and properly placed. This patch special cases a
sync wakeup on exit to avoid pulling tasks across nodes. Testing on a range
of workloads and machines showed very little differences in performance
although there was a small 3% boost on some machines running a shellscript
intensive workload (git regression test suite).

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Giovanni Gherdovich <ggherdovich@suse.cz>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Matt Fleming <matt@codeblueprint.co.uk>
Cc: Mike Galbraith <efault@gmx.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/20180213133730.24064-5-mgorman@techsingularity.net
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/fair.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index a07920f..302dda8 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6350,7 +6350,7 @@ select_task_rq_fair(struct task_struct *p, int prev_cpu, int sd_flag, int wake_f
 	int cpu = smp_processor_id();
 	int new_cpu = prev_cpu;
 	int want_affine = 0;
-	int sync = wake_flags & WF_SYNC;
+	int sync = (wake_flags & WF_SYNC) && !(current->flags & PF_EXITING);
 
 	if (sd_flag & SD_BALANCE_WAKE) {
 		record_wakee(p);
