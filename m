Return-Path: <SRS0=XIf+=PH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0DCBC43387
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Dec 2018 13:01:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7709A20815
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Dec 2018 13:01:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726088AbeL3NBn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Dec 2018 08:01:43 -0500
Received: from terminus.zytor.com ([198.137.202.136]:37581 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725914AbeL3NBn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Dec 2018 08:01:43 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wBUD0wuW3768685
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sun, 30 Dec 2018 05:00:58 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wBUD0wAi3768682;
        Sun, 30 Dec 2018 05:00:58 -0800
Date:   Sun, 30 Dec 2018 05:00:58 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Linus Torvalds <tipbot@zytor.com>
Message-ID: <tip-c40f7d74c741a907cfaeb73a7697081881c497d0@git.kernel.org>
Cc:     torvalds@linux-foundation.org, hpa@zytor.com, efault@gmx.de,
        xiexiuqi@huawei.com, linux-kernel@vger.kernel.org, tj@kernel.org,
        peterz@infradead.org, tglx@linutronix.de, xiezhipeng1@huawei.com,
        vincent.guittot@linaro.org, huawei.libin@huawei.com,
        sargun@sargun.me, mingo@kernel.org
Reply-To: efault@gmx.de, hpa@zytor.com, xiexiuqi@huawei.com,
          linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
          sargun@sargun.me, mingo@kernel.org, vincent.guittot@linaro.org,
          huawei.libin@huawei.com, tglx@linutronix.de,
          xiezhipeng1@huawei.com, peterz@infradead.org, tj@kernel.org
In-Reply-To: <1545879866-27809-1-git-send-email-xiexiuqi@huawei.com>
References: <1545879866-27809-1-git-send-email-xiexiuqi@huawei.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:sched/urgent] sched/fair: Fix infinite loop in
 update_blocked_averages() by reverting a9e7f6544b9c
Git-Commit-ID: c40f7d74c741a907cfaeb73a7697081881c497d0
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

Commit-ID:  c40f7d74c741a907cfaeb73a7697081881c497d0
Gitweb:     https://git.kernel.org/tip/c40f7d74c741a907cfaeb73a7697081881c497d0
Author:     Linus Torvalds <torvalds@linux-foundation.org>
AuthorDate: Thu, 27 Dec 2018 13:46:17 -0800
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Sun, 30 Dec 2018 13:54:31 +0100

sched/fair: Fix infinite loop in update_blocked_averages() by reverting a9e7f6544b9c

Zhipeng Xie, Xie XiuQi and Sargun Dhillon reported lockups in the
scheduler under high loads, starting at around the v4.18 time frame,
and Zhipeng Xie tracked it down to bugs in the rq->leaf_cfs_rq_list
manipulation.

Do a (manual) revert of:

  a9e7f6544b9c ("sched/fair: Fix O(nr_cgroups) in load balance path")

It turns out that the list_del_leaf_cfs_rq() introduced by this commit
is a surprising property that was not considered in followup commits
such as:

  9c2791f936ef ("sched/fair: Fix hierarchical order in rq->leaf_cfs_rq_list")

As Vincent Guittot explains:

 "I think that there is a bigger problem with commit a9e7f6544b9c and
  cfs_rq throttling:

  Let take the example of the following topology TG2 --> TG1 --> root:

   1) The 1st time a task is enqueued, we will add TG2 cfs_rq then TG1
      cfs_rq to leaf_cfs_rq_list and we are sure to do the whole branch in
      one path because it has never been used and can't be throttled so
      tmp_alone_branch will point to leaf_cfs_rq_list at the end.

   2) Then TG1 is throttled

   3) and we add TG3 as a new child of TG1.

   4) The 1st enqueue of a task on TG3 will add TG3 cfs_rq just before TG1
      cfs_rq and tmp_alone_branch will stay  on rq->leaf_cfs_rq_list.

  With commit a9e7f6544b9c, we can del a cfs_rq from rq->leaf_cfs_rq_list.
  So if the load of TG1 cfs_rq becomes NULL before step 2) above, TG1
  cfs_rq is removed from the list.
  Then at step 4), TG3 cfs_rq is added at the beginning of rq->leaf_cfs_rq_list
  but tmp_alone_branch still points to TG3 cfs_rq because its throttled
  parent can't be enqueued when the lock is released.
  tmp_alone_branch doesn't point to rq->leaf_cfs_rq_list whereas it should.

  So if TG3 cfs_rq is removed or destroyed before tmp_alone_branch
  points on another TG cfs_rq, the next TG cfs_rq that will be added,
  will be linked outside rq->leaf_cfs_rq_list - which is bad.

  In addition, we can break the ordering of the cfs_rq in
  rq->leaf_cfs_rq_list but this ordering is used to update and
  propagate the update from leaf down to root."

Instead of trying to work through all these cases and trying to reproduce
the very high loads that produced the lockup to begin with, simplify
the code temporarily by reverting a9e7f6544b9c - which change was clearly
not thought through completely.

This (hopefully) gives us a kernel that doesn't lock up so people
can continue to enjoy their holidays without worrying about regressions. ;-)

[ mingo: Wrote changelog, fixed weird spelling in code comment while at it. ]

Analyzed-by: Xie XiuQi <xiexiuqi@huawei.com>
Analyzed-by: Vincent Guittot <vincent.guittot@linaro.org>
Reported-by: Zhipeng Xie <xiezhipeng1@huawei.com>
Reported-by: Sargun Dhillon <sargun@sargun.me>
Reported-by: Xie XiuQi <xiexiuqi@huawei.com>
Tested-by: Zhipeng Xie <xiezhipeng1@huawei.com>
Tested-by: Sargun Dhillon <sargun@sargun.me>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Acked-by: Vincent Guittot <vincent.guittot@linaro.org>
Cc: <stable@vger.kernel.org> # v4.13+
Cc: Bin Li <huawei.libin@huawei.com>
Cc: Mike Galbraith <efault@gmx.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Tejun Heo <tj@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Fixes: a9e7f6544b9c ("sched/fair: Fix O(nr_cgroups) in load balance path")
Link: http://lkml.kernel.org/r/1545879866-27809-1-git-send-email-xiexiuqi@huawei.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/fair.c | 43 +++++++++----------------------------------
 1 file changed, 9 insertions(+), 34 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index d1907506318a..6483834f1278 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -352,10 +352,9 @@ static inline void list_del_leaf_cfs_rq(struct cfs_rq *cfs_rq)
 	}
 }
 
-/* Iterate thr' all leaf cfs_rq's on a runqueue */
-#define for_each_leaf_cfs_rq_safe(rq, cfs_rq, pos)			\
-	list_for_each_entry_safe(cfs_rq, pos, &rq->leaf_cfs_rq_list,	\
-				 leaf_cfs_rq_list)
+/* Iterate through all leaf cfs_rq's on a runqueue: */
+#define for_each_leaf_cfs_rq(rq, cfs_rq) \
+	list_for_each_entry_rcu(cfs_rq, &rq->leaf_cfs_rq_list, leaf_cfs_rq_list)
 
 /* Do the two (enqueued) entities belong to the same group ? */
 static inline struct cfs_rq *
@@ -447,8 +446,8 @@ static inline void list_del_leaf_cfs_rq(struct cfs_rq *cfs_rq)
 {
 }
 
-#define for_each_leaf_cfs_rq_safe(rq, cfs_rq, pos)	\
-		for (cfs_rq = &rq->cfs, pos = NULL; cfs_rq; cfs_rq = pos)
+#define for_each_leaf_cfs_rq(rq, cfs_rq)	\
+		for (cfs_rq = &rq->cfs; cfs_rq; cfs_rq = NULL)
 
 static inline struct sched_entity *parent_entity(struct sched_entity *se)
 {
@@ -7647,27 +7646,10 @@ static inline bool others_have_blocked(struct rq *rq)
 
 #ifdef CONFIG_FAIR_GROUP_SCHED
 
-static inline bool cfs_rq_is_decayed(struct cfs_rq *cfs_rq)
-{
-	if (cfs_rq->load.weight)
-		return false;
-
-	if (cfs_rq->avg.load_sum)
-		return false;
-
-	if (cfs_rq->avg.util_sum)
-		return false;
-
-	if (cfs_rq->avg.runnable_load_sum)
-		return false;
-
-	return true;
-}
-
 static void update_blocked_averages(int cpu)
 {
 	struct rq *rq = cpu_rq(cpu);
-	struct cfs_rq *cfs_rq, *pos;
+	struct cfs_rq *cfs_rq;
 	const struct sched_class *curr_class;
 	struct rq_flags rf;
 	bool done = true;
@@ -7679,7 +7661,7 @@ static void update_blocked_averages(int cpu)
 	 * Iterates the task_group tree in a bottom up fashion, see
 	 * list_add_leaf_cfs_rq() for details.
 	 */
-	for_each_leaf_cfs_rq_safe(rq, cfs_rq, pos) {
+	for_each_leaf_cfs_rq(rq, cfs_rq) {
 		struct sched_entity *se;
 
 		/* throttled entities do not contribute to load */
@@ -7694,13 +7676,6 @@ static void update_blocked_averages(int cpu)
 		if (se && !skip_blocked_update(se))
 			update_load_avg(cfs_rq_of(se), se, 0);
 
-		/*
-		 * There can be a lot of idle CPU cgroups.  Don't let fully
-		 * decayed cfs_rqs linger on the list.
-		 */
-		if (cfs_rq_is_decayed(cfs_rq))
-			list_del_leaf_cfs_rq(cfs_rq);
-
 		/* Don't need periodic decay once load/util_avg are null */
 		if (cfs_rq_has_blocked(cfs_rq))
 			done = false;
@@ -10570,10 +10545,10 @@ const struct sched_class fair_sched_class = {
 #ifdef CONFIG_SCHED_DEBUG
 void print_cfs_stats(struct seq_file *m, int cpu)
 {
-	struct cfs_rq *cfs_rq, *pos;
+	struct cfs_rq *cfs_rq;
 
 	rcu_read_lock();
-	for_each_leaf_cfs_rq_safe(cpu_rq(cpu), cfs_rq, pos)
+	for_each_leaf_cfs_rq(cpu_rq(cpu), cfs_rq)
 		print_cfs_rq(m, cpu, cfs_rq);
 	rcu_read_unlock();
 }
