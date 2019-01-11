Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 444AFC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:58:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B8E720874
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:58:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547218722;
	bh=TxznblPju3hhTyfG3JFpP6TE+E5R75Vyw1jV97aaOyo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CF6OdVUtm0uKgJqprZp+pkTuRIzX9ySEb9TAEMESy8rrGkd1qD77+RLlLNIzQaU+4
	 8GRR13ZUihNxe2q4LxUtO1IO+OgUh67hQAIPUYoxkZ69dtpERgpmQuZzv3eznYVTHz
	 B1drO0Wf7V4FvoVJ7L0QtE6dYb8LUgwlSv03cpX4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389889AbfAKOeX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 09:34:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:54544 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387662AbfAKOeR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:34:17 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 129F321841;
        Fri, 11 Jan 2019 14:34:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547217255;
        bh=TxznblPju3hhTyfG3JFpP6TE+E5R75Vyw1jV97aaOyo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NTmCDugXx8WkP8rp8zdQ8RLcz4Q2T+7lPprnvmsOPRzhBsRBMJgsfk/zVCvDIq3Io
         PCah0vVPoTXMJDL3/KZThbKXrYJ8hE/YTaO+cWaJQAnFz/tMRnmftXyVCmWX/e6zIH
         EX24uxa2Y8RQ5akwUj/4Tk2ipMdBdYwKLThBVSA4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Zhipeng Xie <xiezhipeng1@huawei.com>,
        Sargun Dhillon <sargun@sargun.me>,
        Xie XiuQi <xiexiuqi@huawei.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Bin Li <huawei.libin@huawei.com>,
        Mike Galbraith <efault@gmx.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Tejun Heo <tj@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 4.14 099/105] sched/fair: Fix infinite loop in update_blocked_averages() by reverting a9e7f6544b9c
Date:   Fri, 11 Jan 2019 15:15:10 +0100
Message-Id: <20190111131111.118791086@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190111131102.899065735@linuxfoundation.org>
References: <20190111131102.899065735@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Linus Torvalds <torvalds@linux-foundation.org>

commit c40f7d74c741a907cfaeb73a7697081881c497d0 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/sched/fair.c |   43 +++++++++----------------------------------
 1 file changed, 9 insertions(+), 34 deletions(-)

--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -369,10 +369,9 @@ static inline void list_del_leaf_cfs_rq(
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
@@ -465,8 +464,8 @@ static inline void list_del_leaf_cfs_rq(
 {
 }
 
-#define for_each_leaf_cfs_rq_safe(rq, cfs_rq, pos)	\
-		for (cfs_rq = &rq->cfs, pos = NULL; cfs_rq; cfs_rq = pos)
+#define for_each_leaf_cfs_rq(rq, cfs_rq)	\
+		for (cfs_rq = &rq->cfs; cfs_rq; cfs_rq = NULL)
 
 static inline struct sched_entity *parent_entity(struct sched_entity *se)
 {
@@ -6970,27 +6969,10 @@ static void attach_tasks(struct lb_env *
 
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
-	if (cfs_rq->runnable_load_sum)
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
 	struct rq_flags rf;
 
 	rq_lock_irqsave(rq, &rf);
@@ -7000,7 +6982,7 @@ static void update_blocked_averages(int
 	 * Iterates the task_group tree in a bottom up fashion, see
 	 * list_add_leaf_cfs_rq() for details.
 	 */
-	for_each_leaf_cfs_rq_safe(rq, cfs_rq, pos) {
+	for_each_leaf_cfs_rq(rq, cfs_rq) {
 		struct sched_entity *se;
 
 		/* throttled entities do not contribute to load */
@@ -7014,13 +6996,6 @@ static void update_blocked_averages(int
 		se = cfs_rq->tg->se[cpu];
 		if (se && !skip_blocked_update(se))
 			update_load_avg(se, 0);
-
-		/*
-		 * There can be a lot of idle CPU cgroups.  Don't let fully
-		 * decayed cfs_rqs linger on the list.
-		 */
-		if (cfs_rq_is_decayed(cfs_rq))
-			list_del_leaf_cfs_rq(cfs_rq);
 	}
 	rq_unlock_irqrestore(rq, &rf);
 }
@@ -9580,10 +9555,10 @@ const struct sched_class fair_sched_clas
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


