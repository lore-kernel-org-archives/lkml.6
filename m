Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBF2EC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 10:48:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4D5720863
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 10:48:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726896AbfBKKsT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 05:48:19 -0500
Received: from terminus.zytor.com ([198.137.202.136]:58491 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726046AbfBKKsS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 05:48:18 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x1BAm7Un3498438
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 11 Feb 2019 02:48:07 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x1BAm6op3498435;
        Mon, 11 Feb 2019 02:48:06 -0800
Date:   Mon, 11 Feb 2019 02:48:06 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Vincent Guittot <tipbot@zytor.com>
Message-ID: <tip-039ae8bcf7a5f4476f4487e6bf816885fb3fb617@git.kernel.org>
Cc:     hpa@zytor.com, tglx@linutronix.de, peterz@infradead.org,
        vincent.guittot@linaro.org, torvalds@linux-foundation.org,
        mingo@kernel.org, linux-kernel@vger.kernel.org
Reply-To: hpa@zytor.com, tglx@linutronix.de, peterz@infradead.org,
          vincent.guittot@linaro.org, torvalds@linux-foundation.org,
          mingo@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <1549469662-13614-3-git-send-email-vincent.guittot@linaro.org>
References: <1549469662-13614-3-git-send-email-vincent.guittot@linaro.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:sched/core] sched/fair: Fix O(nr_cgroups) in the load
 balancing path
Git-Commit-ID: 039ae8bcf7a5f4476f4487e6bf816885fb3fb617
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

Commit-ID:  039ae8bcf7a5f4476f4487e6bf816885fb3fb617
Gitweb:     https://git.kernel.org/tip/039ae8bcf7a5f4476f4487e6bf816885fb3fb617
Author:     Vincent Guittot <vincent.guittot@linaro.org>
AuthorDate: Wed, 6 Feb 2019 17:14:22 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 11 Feb 2019 08:02:13 +0100

sched/fair: Fix O(nr_cgroups) in the load balancing path

This re-applies the commit reverted here:

  commit c40f7d74c741 ("sched/fair: Fix infinite loop in update_blocked_averages() by reverting a9e7f6544b9c")

I.e. now that cfs_rq can be safely removed/added in the list, we can re-apply:

 commit a9e7f6544b9c ("sched/fair: Fix O(nr_cgroups) in load balance path")

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: sargun@sargun.me
Cc: tj@kernel.org
Cc: xiexiuqi@huawei.com
Cc: xiezhipeng1@huawei.com
Link: https://lkml.kernel.org/r/1549469662-13614-3-git-send-email-vincent.guittot@linaro.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/fair.c | 43 ++++++++++++++++++++++++++++++++++---------
 1 file changed, 34 insertions(+), 9 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 027f8e1b5b66..17a961522d1e 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -368,9 +368,10 @@ static inline void assert_list_leaf_cfs_rq(struct rq *rq)
 	SCHED_WARN_ON(rq->tmp_alone_branch != &rq->leaf_cfs_rq_list);
 }
 
-/* Iterate through all cfs_rq's on a runqueue in bottom-up order */
-#define for_each_leaf_cfs_rq(rq, cfs_rq) \
-	list_for_each_entry_rcu(cfs_rq, &rq->leaf_cfs_rq_list, leaf_cfs_rq_list)
+/* Iterate thr' all leaf cfs_rq's on a runqueue */
+#define for_each_leaf_cfs_rq_safe(rq, cfs_rq, pos)			\
+	list_for_each_entry_safe(cfs_rq, pos, &rq->leaf_cfs_rq_list,	\
+				 leaf_cfs_rq_list)
 
 /* Do the two (enqueued) entities belong to the same group ? */
 static inline struct cfs_rq *
@@ -461,8 +462,8 @@ static inline void assert_list_leaf_cfs_rq(struct rq *rq)
 {
 }
 
-#define for_each_leaf_cfs_rq(rq, cfs_rq)	\
-		for (cfs_rq = &rq->cfs; cfs_rq; cfs_rq = NULL)
+#define for_each_leaf_cfs_rq_safe(rq, cfs_rq, pos)	\
+		for (cfs_rq = &rq->cfs, pos = NULL; cfs_rq; cfs_rq = pos)
 
 static inline struct sched_entity *parent_entity(struct sched_entity *se)
 {
@@ -7702,10 +7703,27 @@ static inline bool others_have_blocked(struct rq *rq)
 
 #ifdef CONFIG_FAIR_GROUP_SCHED
 
+static inline bool cfs_rq_is_decayed(struct cfs_rq *cfs_rq)
+{
+	if (cfs_rq->load.weight)
+		return false;
+
+	if (cfs_rq->avg.load_sum)
+		return false;
+
+	if (cfs_rq->avg.util_sum)
+		return false;
+
+	if (cfs_rq->avg.runnable_load_sum)
+		return false;
+
+	return true;
+}
+
 static void update_blocked_averages(int cpu)
 {
 	struct rq *rq = cpu_rq(cpu);
-	struct cfs_rq *cfs_rq;
+	struct cfs_rq *cfs_rq, *pos;
 	const struct sched_class *curr_class;
 	struct rq_flags rf;
 	bool done = true;
@@ -7717,7 +7735,7 @@ static void update_blocked_averages(int cpu)
 	 * Iterates the task_group tree in a bottom up fashion, see
 	 * list_add_leaf_cfs_rq() for details.
 	 */
-	for_each_leaf_cfs_rq(rq, cfs_rq) {
+	for_each_leaf_cfs_rq_safe(rq, cfs_rq, pos) {
 		struct sched_entity *se;
 
 		if (update_cfs_rq_load_avg(cfs_rq_clock_pelt(cfs_rq), cfs_rq))
@@ -7728,6 +7746,13 @@ static void update_blocked_averages(int cpu)
 		if (se && !skip_blocked_update(se))
 			update_load_avg(cfs_rq_of(se), se, 0);
 
+		/*
+		 * There can be a lot of idle CPU cgroups.  Don't let fully
+		 * decayed cfs_rqs linger on the list.
+		 */
+		if (cfs_rq_is_decayed(cfs_rq))
+			list_del_leaf_cfs_rq(cfs_rq);
+
 		/* Don't need periodic decay once load/util_avg are null */
 		if (cfs_rq_has_blocked(cfs_rq))
 			done = false;
@@ -10609,10 +10634,10 @@ const struct sched_class fair_sched_class = {
 #ifdef CONFIG_SCHED_DEBUG
 void print_cfs_stats(struct seq_file *m, int cpu)
 {
-	struct cfs_rq *cfs_rq;
+	struct cfs_rq *cfs_rq, *pos;
 
 	rcu_read_lock();
-	for_each_leaf_cfs_rq(cpu_rq(cpu), cfs_rq)
+	for_each_leaf_cfs_rq_safe(cpu_rq(cpu), cfs_rq, pos)
 		print_cfs_rq(m, cpu, cfs_rq);
 	rcu_read_unlock();
 }
