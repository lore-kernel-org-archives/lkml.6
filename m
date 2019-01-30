Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 852C5C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 14:01:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A48420844
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 14:01:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="alM2jx0e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730979AbfA3OBL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 09:01:11 -0500
Received: from merlin.infradead.org ([205.233.59.134]:49298 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726151AbfA3OBL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 09:01:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=QRBFRWO5UtV0fGnWJVJqrsqrL9KwVT223j8KVhJdBBM=; b=alM2jx0e67AgTtD4lpjMJeReF
        cmFSXF5HnnQV/Hzjo4bl2vW1W/bNl2peDdJ1J8MhD4RnGuBQcKG6XjwC9gIhPHK0+ojhY5fFw64ry
        w4fgMMk9qC+Kr9iLJ/6VqE4e/hAzYElqI/aGvWaDC0zhTjuNFrJh3nHoU/izALpvIXZrxwtGA0gmZ
        ZKOF2cLjawnWd9gvy0i145DCHPVA7OiWEGy1iJRcyAir5yXkl53nzZvMX3NtlGBxQRCYnZzwJ/vYu
        RGls3QFarN5YgfQc20buEsysBJwGxpR87DhWviXyuYdnuRtrPso2gvQHBG/VXd9+tMvjEk5RFP+q7
        7DKlu4GQg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1goqQM-00021P-0b; Wed, 30 Jan 2019 14:01:06 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7B0D5200E2F88; Wed, 30 Jan 2019 15:01:04 +0100 (CET)
Date:   Wed, 30 Jan 2019 15:01:04 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com, tj@kernel.org,
        sargun@sargun.me
Subject: Re: [PATCH v2] sched/fair: Fix insertion in rq->leaf_cfs_rq_list
Message-ID: <20190130140104.GB2296@hirez.programming.kicks-ass.net>
References: <1548782332-18591-1-git-send-email-vincent.guittot@linaro.org>
 <1548825767-10799-1-git-send-email-vincent.guittot@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1548825767-10799-1-git-send-email-vincent.guittot@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 30, 2019 at 06:22:47AM +0100, Vincent Guittot wrote:
> Sargun reported a crash:
>   "I picked up c40f7d74c741a907cfaeb73a7697081881c497d0 sched/fair: Fix
>    infinite loop in update_blocked_averages() by reverting a9e7f6544b9c
>    and put it on top of 4.19.13. In addition to this, I uninlined
>    list_add_leaf_cfs_rq for debugging.
> 
>    This revealed a new bug that we didn't get to because we kept getting
>    crashes from the previous issue. When we are running with cgroups that
>    are rapidly changing, with CFS bandwidth control, and in addition
>    using the cpusets cgroup, we see this crash. Specifically, it seems to
>    occur with cgroups that are throttled and we change the allowed
>    cpuset."
> 
> The algorithm used to order cfs_rq in rq->leaf_cfs_rq_list assumes that
> it will walk down to root the 1st time a cfs_rq is used and we will finish
> to add either a cfs_rq without parent or a cfs_rq with a parent that is
> already on the list. But this is not always true in presence of throttling.
> Because a cfs_rq can be throttled even if it has never been used but other CPUs
> of the cgroup have already used all the bandwdith, we are not sure to go down to
> the root and add all cfs_rq in the list.
> 
> Ensure that all cfs_rq will be added in the list even if they are throttled.
> 
> Reported-by: Sargun Dhillon <sargun@sargun.me>
> Fixes: 9c2791f936ef ("Fix hierarchical order in rq->leaf_cfs_rq_list")
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>

Given my previous patch; how about something like so instead?

--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -282,13 +282,15 @@ static inline struct cfs_rq *group_cfs_r
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
+
+	cfs_rq->on_list = 1;
 
 	/*
 	 * Ensure we either appear before our parent (if already
@@ -315,7 +317,10 @@ static inline void list_add_leaf_cfs_rq(
 		 * list.
 		 */
 		rq->tmp_alone_branch = &rq->leaf_cfs_rq_list;
-	} else if (!cfs_rq->tg->parent) {
+		return true;
+	}
+
+	if (!cfs_rq->tg->parent) {
 		/*
 		 * cfs rq without parent should be put
 		 * at the tail of the list.
@@ -327,23 +332,22 @@ static inline void list_add_leaf_cfs_rq(
 		 * tmp_alone_branch to the beginning of the list.
 		 */
 		rq->tmp_alone_branch = &rq->leaf_cfs_rq_list;
-	} else {
-		/*
-		 * The parent has not already been added so we want to
-		 * make sure that it will be put after us.
-		 * tmp_alone_branch points to the begin of the branch
-		 * where we will add parent.
-		 */
-		list_add_rcu(&cfs_rq->leaf_cfs_rq_list,
-			rq->tmp_alone_branch);
-		/*
-		 * update tmp_alone_branch to points to the new begin
-		 * of the branch
-		 */
-		rq->tmp_alone_branch = &cfs_rq->leaf_cfs_rq_list;
+		return true;
 	}
 
-	cfs_rq->on_list = 1;
+	/*
+	 * The parent has not already been added so we want to
+	 * make sure that it will be put after us.
+	 * tmp_alone_branch points to the begin of the branch
+	 * where we will add parent.
+	 */
+	list_add_rcu(&cfs_rq->leaf_cfs_rq_list, rq->tmp_alone_branch);
+	/*
+	 * update tmp_alone_branch to points to the new begin
+	 * of the branch
+	 */
+	rq->tmp_alone_branch = &cfs_rq->leaf_cfs_rq_list;
+	return false;
 }
 
 static inline void list_del_leaf_cfs_rq(struct cfs_rq *cfs_rq)
@@ -4999,6 +5003,12 @@ static void __maybe_unused unthrottle_of
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
@@ -5190,6 +5200,21 @@ enqueue_task_fair(struct rq *rq, struct
 
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
