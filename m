Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49C2EC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 10:47:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1945E20863
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 10:47:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726978AbfBKKrh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 05:47:37 -0500
Received: from terminus.zytor.com ([198.137.202.136]:39019 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726046AbfBKKrg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 05:47:36 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x1BAlP2J3498184
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 11 Feb 2019 02:47:25 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x1BAlP663498178;
        Mon, 11 Feb 2019 02:47:25 -0800
Date:   Mon, 11 Feb 2019 02:47:25 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Vincent Guittot <tipbot@zytor.com>
Message-ID: <tip-31bc6aeaab1d1de8959b67edbed5c7a4b3cdbe7c@git.kernel.org>
Cc:     vincent.guittot@linaro.org, linux-kernel@vger.kernel.org,
        hpa@zytor.com, mingo@kernel.org, peterz@infradead.org,
        torvalds@linux-foundation.org, tglx@linutronix.de
Reply-To: tglx@linutronix.de, torvalds@linux-foundation.org,
          peterz@infradead.org, hpa@zytor.com, mingo@kernel.org,
          linux-kernel@vger.kernel.org, vincent.guittot@linaro.org
In-Reply-To: <1549469662-13614-2-git-send-email-vincent.guittot@linaro.org>
References: <1549469662-13614-2-git-send-email-vincent.guittot@linaro.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:sched/core] sched/fair: Optimize update_blocked_averages()
Git-Commit-ID: 31bc6aeaab1d1de8959b67edbed5c7a4b3cdbe7c
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

Commit-ID:  31bc6aeaab1d1de8959b67edbed5c7a4b3cdbe7c
Gitweb:     https://git.kernel.org/tip/31bc6aeaab1d1de8959b67edbed5c7a4b3cdbe7c
Author:     Vincent Guittot <vincent.guittot@linaro.org>
AuthorDate: Wed, 6 Feb 2019 17:14:21 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 11 Feb 2019 08:02:12 +0100

sched/fair: Optimize update_blocked_averages()

Removing a cfs_rq from rq->leaf_cfs_rq_list can break the parent/child
ordering of the list when it will be added back. In order to remove an
empty and fully decayed cfs_rq, we must remove its children too, so they
will be added back in the right order next time.

With a normal decay of PELT, a parent will be empty and fully decayed
if all children are empty and fully decayed too. In such a case, we just
have to ensure that the whole branch will be added when a new task is
enqueued. This is default behavior since :

  commit f6783319737f ("sched/fair: Fix insertion in rq->leaf_cfs_rq_list")

In case of throttling, the PELT of throttled cfs_rq will not be updated
whereas the parent will. This breaks the assumption made above unless we
remove the children of a cfs_rq that is throttled. Then, they will be
added back when unthrottled and a sched_entity will be enqueued.

As throttled cfs_rq are now removed from the list, we can remove the
associated test in update_blocked_averages().

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: sargun@sargun.me
Cc: tj@kernel.org
Cc: xiexiuqi@huawei.com
Cc: xiezhipeng1@huawei.com
Link: https://lkml.kernel.org/r/1549469662-13614-2-git-send-email-vincent.guittot@linaro.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/fair.c | 26 +++++++++++++++++++++-----
 1 file changed, 21 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 38d4669aa2ef..027f8e1b5b66 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -346,6 +346,18 @@ static inline bool list_add_leaf_cfs_rq(struct cfs_rq *cfs_rq)
 static inline void list_del_leaf_cfs_rq(struct cfs_rq *cfs_rq)
 {
 	if (cfs_rq->on_list) {
+		struct rq *rq = rq_of(cfs_rq);
+
+		/*
+		 * With cfs_rq being unthrottled/throttled during an enqueue,
+		 * it can happen the tmp_alone_branch points the a leaf that
+		 * we finally want to del. In this case, tmp_alone_branch moves
+		 * to the prev element but it will point to rq->leaf_cfs_rq_list
+		 * at the end of the enqueue.
+		 */
+		if (rq->tmp_alone_branch == &cfs_rq->leaf_cfs_rq_list)
+			rq->tmp_alone_branch = cfs_rq->leaf_cfs_rq_list.prev;
+
 		list_del_rcu(&cfs_rq->leaf_cfs_rq_list);
 		cfs_rq->on_list = 0;
 	}
@@ -4438,6 +4450,10 @@ static int tg_unthrottle_up(struct task_group *tg, void *data)
 		/* adjust cfs_rq_clock_task() */
 		cfs_rq->throttled_clock_task_time += rq_clock_task(rq) -
 					     cfs_rq->throttled_clock_task;
+
+		/* Add cfs_rq with already running entity in the list */
+		if (cfs_rq->nr_running >= 1)
+			list_add_leaf_cfs_rq(cfs_rq);
 	}
 
 	return 0;
@@ -4449,8 +4465,10 @@ static int tg_throttle_down(struct task_group *tg, void *data)
 	struct cfs_rq *cfs_rq = tg->cfs_rq[cpu_of(rq)];
 
 	/* group is entering throttled state, stop time */
-	if (!cfs_rq->throttle_count)
+	if (!cfs_rq->throttle_count) {
 		cfs_rq->throttled_clock_task = rq_clock_task(rq);
+		list_del_leaf_cfs_rq(cfs_rq);
+	}
 	cfs_rq->throttle_count++;
 
 	return 0;
@@ -4553,6 +4571,8 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
 			break;
 	}
 
+	assert_list_leaf_cfs_rq(rq);
+
 	if (!se)
 		add_nr_running(rq, task_delta);
 
@@ -7700,10 +7720,6 @@ static void update_blocked_averages(int cpu)
 	for_each_leaf_cfs_rq(rq, cfs_rq) {
 		struct sched_entity *se;
 
-		/* throttled entities do not contribute to load */
-		if (throttled_hierarchy(cfs_rq))
-			continue;
-
 		if (update_cfs_rq_load_avg(cfs_rq_clock_pelt(cfs_rq), cfs_rq))
 			update_tg_load_avg(cfs_rq, 0);
 
