Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9557C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 09:04:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B07EA214DA
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 09:04:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728944AbfBDJEM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 04:04:12 -0500
Received: from terminus.zytor.com ([198.137.202.136]:41725 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726320AbfBDJEL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 04:04:11 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x1493tpQ359250
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 4 Feb 2019 01:03:55 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x1493sDd359247;
        Mon, 4 Feb 2019 01:03:54 -0800
Date:   Mon, 4 Feb 2019 01:03:54 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Vincent Guittot <tipbot@zytor.com>
Message-ID: <tip-f6783319737f28e4436a69611853a5a098cbe974@git.kernel.org>
Cc:     vincent.guittot@linaro.org, hpa@zytor.com, sargun@sargun.me,
        mingo@kernel.org, efault@gmx.de, linux-kernel@vger.kernel.org,
        peterz@infradead.org, torvalds@linux-foundation.org,
        tglx@linutronix.de
Reply-To: sargun@sargun.me, mingo@kernel.org, hpa@zytor.com,
          vincent.guittot@linaro.org, tglx@linutronix.de,
          peterz@infradead.org, torvalds@linux-foundation.org,
          efault@gmx.de, linux-kernel@vger.kernel.org
In-Reply-To: <1548825767-10799-1-git-send-email-vincent.guittot@linaro.org>
References: <1548825767-10799-1-git-send-email-vincent.guittot@linaro.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:sched/core] sched/fair: Fix insertion in rq->leaf_cfs_rq_list
Git-Commit-ID: f6783319737f28e4436a69611853a5a098cbe974
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

Commit-ID:  f6783319737f28e4436a69611853a5a098cbe974
Gitweb:     https://git.kernel.org/tip/f6783319737f28e4436a69611853a5a098cbe974
Author:     Vincent Guittot <vincent.guittot@linaro.org>
AuthorDate: Wed, 30 Jan 2019 06:22:47 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 4 Feb 2019 09:14:48 +0100

sched/fair: Fix insertion in rq->leaf_cfs_rq_list

Sargun reported a crash:

  "I picked up c40f7d74c741a907cfaeb73a7697081881c497d0 sched/fair: Fix
   infinite loop in update_blocked_averages() by reverting a9e7f6544b9c
   and put it on top of 4.19.13. In addition to this, I uninlined
   list_add_leaf_cfs_rq for debugging.

   This revealed a new bug that we didn't get to because we kept getting
   crashes from the previous issue. When we are running with cgroups that
   are rapidly changing, with CFS bandwidth control, and in addition
   using the cpusets cgroup, we see this crash. Specifically, it seems to
   occur with cgroups that are throttled and we change the allowed
   cpuset."

The algorithm used to order cfs_rq in rq->leaf_cfs_rq_list assumes that
it will walk down to root the 1st time a cfs_rq is used and we will finish
to add either a cfs_rq without parent or a cfs_rq with a parent that is
already on the list. But this is not always true in presence of throttling.
Because a cfs_rq can be throttled even if it has never been used but other CPUs
of the cgroup have already used all the bandwdith, we are not sure to go down to
the root and add all cfs_rq in the list.

Ensure that all cfs_rq will be added in the list even if they are throttled.

[ mingo: Fix !CGROUPS build. ]

Reported-by: Sargun Dhillon <sargun@sargun.me>
Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mike Galbraith <efault@gmx.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: tj@kernel.org
Fixes: 9c2791f936ef ("Fix hierarchical order in rq->leaf_cfs_rq_list")
Link: https://lkml.kernel.org/r/1548825767-10799-1-git-send-email-vincent.guittot@linaro.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/fair.c | 33 ++++++++++++++++++++++++++++-----
 1 file changed, 28 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index d6a536dec0ca..ffd1ae7237e7 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -275,13 +275,13 @@ static inline struct cfs_rq *group_cfs_rq(struct sched_entity *grp)
 	return grp->my_q;
 }
 
-static inline void list_add_leaf_cfs_rq(struct cfs_rq *cfs_rq)
+static inline bool list_add_leaf_cfs_rq(struct cfs_rq *cfs_rq)
 {
 	struct rq *rq = rq_of(cfs_rq);
 	int cpu = cpu_of(rq);
 
 	if (cfs_rq->on_list)
-		return;
+		return rq->tmp_alone_branch == &rq->leaf_cfs_rq_list;
 
 	cfs_rq->on_list = 1;
 
@@ -310,7 +310,7 @@ static inline void list_add_leaf_cfs_rq(struct cfs_rq *cfs_rq)
 		 * list.
 		 */
 		rq->tmp_alone_branch = &rq->leaf_cfs_rq_list;
-		return;
+		return true;
 	}
 
 	if (!cfs_rq->tg->parent) {
@@ -325,7 +325,7 @@ static inline void list_add_leaf_cfs_rq(struct cfs_rq *cfs_rq)
 		 * tmp_alone_branch to the beginning of the list.
 		 */
 		rq->tmp_alone_branch = &rq->leaf_cfs_rq_list;
-		return;
+		return true;
 	}
 
 	/*
@@ -340,6 +340,7 @@ static inline void list_add_leaf_cfs_rq(struct cfs_rq *cfs_rq)
 	 * of the branch
 	 */
 	rq->tmp_alone_branch = &cfs_rq->leaf_cfs_rq_list;
+	return false;
 }
 
 static inline void list_del_leaf_cfs_rq(struct cfs_rq *cfs_rq)
@@ -435,8 +436,9 @@ static inline struct cfs_rq *group_cfs_rq(struct sched_entity *grp)
 	return NULL;
 }
 
-static inline void list_add_leaf_cfs_rq(struct cfs_rq *cfs_rq)
+static inline bool list_add_leaf_cfs_rq(struct cfs_rq *cfs_rq)
 {
+	return true;
 }
 
 static inline void list_del_leaf_cfs_rq(struct cfs_rq *cfs_rq)
@@ -4995,6 +4997,12 @@ static void __maybe_unused unthrottle_offline_cfs_rqs(struct rq *rq)
 }
 
 #else /* CONFIG_CFS_BANDWIDTH */
+
+static inline bool cfs_bandwidth_used(void)
+{
+	return false;
+}
+
 static inline u64 cfs_rq_clock_task(struct cfs_rq *cfs_rq)
 {
 	return rq_clock_task(rq_of(cfs_rq));
@@ -5186,6 +5194,21 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 
 	}
 
+	if (cfs_bandwidth_used()) {
+		/*
+		 * When bandwidth control is enabled; the cfs_rq_throttled()
+		 * breaks in the above iteration can result in incomplete
+		 * leaf list maintenance, resulting in triggering the assertion
+		 * below.
+		 */
+		for_each_sched_entity(se) {
+			cfs_rq = cfs_rq_of(se);
+
+			if (list_add_leaf_cfs_rq(cfs_rq))
+				break;
+		}
+	}
+
 	assert_list_leaf_cfs_rq(rq);
 
 	hrtick_update(rq);
