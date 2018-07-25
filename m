Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CB50C6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 14:28:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA6D620852
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 14:28:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA6D620852
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729182AbeGYPk2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 11:40:28 -0400
Received: from terminus.zytor.com ([198.137.202.136]:40343 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728051AbeGYPk2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 11:40:28 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w6PES8Ng402435
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 25 Jul 2018 07:28:08 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w6PES8kb402432;
        Wed, 25 Jul 2018 07:28:08 -0700
Date:   Wed, 25 Jul 2018 07:28:08 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Srikar Dronamraju <tipbot@zytor.com>
Message-ID: <tip-0ad4e3dfe6cf3f207e61cbd8e3e4a943f8c1ad20@git.kernel.org>
Cc:     srikar@linux.vnet.ibm.com, peterz@infradead.org,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        hpa@zytor.com, riel@surriel.com, tglx@linutronix.de,
        mingo@kernel.org, mgorman@techsingularity.net
Reply-To: tglx@linutronix.de, riel@surriel.com, mingo@kernel.org,
          mgorman@techsingularity.net, linux-kernel@vger.kernel.org,
          torvalds@linux-foundation.org, hpa@zytor.com,
          srikar@linux.vnet.ibm.com, peterz@infradead.org
In-Reply-To: <1529514181-9842-10-git-send-email-srikar@linux.vnet.ibm.com>
References: <1529514181-9842-10-git-send-email-srikar@linux.vnet.ibm.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:sched/core] sched/numa: Modify migrate_swap() to accept
 additional parameters
Git-Commit-ID: 0ad4e3dfe6cf3f207e61cbd8e3e4a943f8c1ad20
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

Commit-ID:  0ad4e3dfe6cf3f207e61cbd8e3e4a943f8c1ad20
Gitweb:     https://git.kernel.org/tip/0ad4e3dfe6cf3f207e61cbd8e3e4a943f8c1ad20
Author:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>
AuthorDate: Wed, 20 Jun 2018 22:32:50 +0530
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Wed, 25 Jul 2018 11:41:07 +0200

sched/numa: Modify migrate_swap() to accept additional parameters

There are checks in migrate_swap_stop() that check if the task/CPU
combination is as per migrate_swap_arg before migrating.

However atleast one of the two tasks to be swapped by migrate_swap() could
have migrated to a completely different CPU before updating the
migrate_swap_arg. The new CPU where the task is currently running could
be a different node too. If the task has migrated, numa balancer might
end up placing a task in a wrong node.  Instead of achieving node
consolidation, it may end up spreading the load across nodes.

To avoid that pass the CPUs as additional parameters.

While here, place migrate_swap under CONFIG_NUMA_BALANCING.

Running SPECjbb2005 on a 4 node machine and comparing bops/JVM
JVMS  LAST_PATCH  WITH_PATCH  %CHANGE
16    25377.3     25226.6     -0.59
1     72287       73326       1.437

Signed-off-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Rik van Riel <riel@surriel.com>
Acked-by: Mel Gorman <mgorman@techsingularity.net>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/1529514181-9842-10-git-send-email-srikar@linux.vnet.ibm.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/core.c  | 9 ++++++---
 kernel/sched/fair.c  | 3 ++-
 kernel/sched/sched.h | 3 ++-
 3 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 2bc391a574e6..deafa9fe602b 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1176,6 +1176,7 @@ void set_task_cpu(struct task_struct *p, unsigned int new_cpu)
 	__set_task_cpu(p, new_cpu);
 }
 
+#ifdef CONFIG_NUMA_BALANCING
 static void __migrate_swap_task(struct task_struct *p, int cpu)
 {
 	if (task_on_rq_queued(p)) {
@@ -1257,16 +1258,17 @@ unlock:
 /*
  * Cross migrate two tasks
  */
-int migrate_swap(struct task_struct *cur, struct task_struct *p)
+int migrate_swap(struct task_struct *cur, struct task_struct *p,
+		int target_cpu, int curr_cpu)
 {
 	struct migration_swap_arg arg;
 	int ret = -EINVAL;
 
 	arg = (struct migration_swap_arg){
 		.src_task = cur,
-		.src_cpu = task_cpu(cur),
+		.src_cpu = curr_cpu,
 		.dst_task = p,
-		.dst_cpu = task_cpu(p),
+		.dst_cpu = target_cpu,
 	};
 
 	if (arg.src_cpu == arg.dst_cpu)
@@ -1291,6 +1293,7 @@ int migrate_swap(struct task_struct *cur, struct task_struct *p)
 out:
 	return ret;
 }
+#endif /* CONFIG_NUMA_BALANCING */
 
 /*
  * wait_task_inactive - wait for a thread to unschedule.
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 4ac60b296d96..7b4eddec3ccc 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1848,7 +1848,8 @@ static int task_numa_migrate(struct task_struct *p)
 		return ret;
 	}
 
-	ret = migrate_swap(p, env.best_task);
+	ret = migrate_swap(p, env.best_task, env.best_cpu, env.src_cpu);
+
 	if (ret != 0)
 		trace_sched_stick_numa(p, env.src_cpu, task_cpu(env.best_task));
 	put_task_struct(env.best_task);
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 614170d9b1aa..4a2e8cae63c4 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1099,7 +1099,8 @@ enum numa_faults_stats {
 };
 extern void sched_setnuma(struct task_struct *p, int node);
 extern int migrate_task_to(struct task_struct *p, int cpu);
-extern int migrate_swap(struct task_struct *, struct task_struct *);
+extern int migrate_swap(struct task_struct *p, struct task_struct *t,
+			int cpu, int scpu);
 extern void init_numa_balancing(unsigned long clone_flags, struct task_struct *p);
 #else
 static inline void
