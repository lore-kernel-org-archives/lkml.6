Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D573FC282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 13:40:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A87C218A3
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 13:40:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RmcetwdC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730739AbfA3Nk1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 08:40:27 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:48858 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726233AbfA3Nk1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 08:40:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=w7uhVDMnb5iOTArrxUzZpNAfMoYz/9iS0wloR+aaLi0=; b=RmcetwdCl9v9NGhxUTULdu3vC
        hhgoGypkD8xDYC4wheRqf7G9wVjOmPnw9vpwOv9WJMVMvYvBv1v7RsBSkP3Y5Fs3I1/FTdnagJHdY
        boqkWu/GhDgrrHbvZRf98fJd3KCe9zGG8gj5LkLd9xbfe+XGgpA8wt6KZZGMPEIVaFhdKdC6InOv3
        wyu5FnqhIKz5GvWDf0xOITaSkgL8zdAwwwpqGWywg6vXcvLDhgv2vkWdtiCsu1RhnxYKsNRTazywe
        yRvNps1prOOKlm8/sWQwx2oEDxRFsMVZfInSyaHDmqjjuDyJSROKt7gfHiHazm+n4OKftuyHOmRbf
        gAk3fZVng==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1goq6L-000734-Pt; Wed, 30 Jan 2019 13:40:25 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6DC612072FAD2; Wed, 30 Jan 2019 14:40:23 +0100 (CET)
Date:   Wed, 30 Jan 2019 14:40:23 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Tejun Heo <tj@kernel.org>,
        Sargun Dhillon <sargun@sargun.me>
Subject: Re: [PATCH v2] sched/fair: Fix insertion in rq->leaf_cfs_rq_list
Message-ID: <20190130134023.GA2296@hirez.programming.kicks-ass.net>
References: <1548782332-18591-1-git-send-email-vincent.guittot@linaro.org>
 <1548825767-10799-1-git-send-email-vincent.guittot@linaro.org>
 <20190130130410.GG2278@hirez.programming.kicks-ass.net>
 <20190130130620.GB3103@hirez.programming.kicks-ass.net>
 <20190130132717.GC3103@hirez.programming.kicks-ass.net>
 <CAKfTPtBhOomgYONsdfaaVgZCENM+QhfPie2qpu0KyOsvMiog_g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtBhOomgYONsdfaaVgZCENM+QhfPie2qpu0KyOsvMiog_g@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 30, 2019 at 02:29:42PM +0100, Vincent Guittot wrote:
> On Wed, 30 Jan 2019 at 14:27, Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Wed, Jan 30, 2019 at 02:06:20PM +0100, Peter Zijlstra wrote:
> > > On Wed, Jan 30, 2019 at 02:04:10PM +0100, Peter Zijlstra wrote:
> >
> > > > So I don't much like this; at all. But maybe I misunderstand, this is
> > > > somewhat tricky stuff and I've not looked at it in a while.
> > > >
> > > > So per normal we do:
> > > >
> > > >     enqueue_task_fair()
> > > >       for_each_sched_entity() {
> > > >         if (se->on_rq)
> > > >           break;
> > > >         enqueue_entity()
> > > >           list_add_leaf_cfs_rq();
> > > >       }
> > > >
> > > > This ensures that all parents are already enqueued, right? because this
> > > > is what enqueues those parents.
> > > >
> > > > And in this case you add an unconditional second
> > > > for_each_sched_entity(); even though it is completely redundant, afaict.
> > >
> > > Ah, it doesn't do a second iteration; it continues where the previous
> > > two left off.
> > >
> > > Still, why isn't this in unthrottle?
> >
> > Aah, I see, because we need:
> >
> >   rq->tmp_alone_branch == &rq->lead_cfs_rq_list
> >
> > at the end of enqueue_task_fair(); having had that assertion would've
> 
> Yes exactly.

How's this ?

---
 kernel/sched/fair.c | 125 +++++++++++++++++++++++++++++-----------------------
 1 file changed, 69 insertions(+), 56 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index e2ff4b69dcf6..747976ca84ea 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -284,64 +284,66 @@ static inline struct cfs_rq *group_cfs_rq(struct sched_entity *grp)
 
 static inline void list_add_leaf_cfs_rq(struct cfs_rq *cfs_rq)
 {
-	if (!cfs_rq->on_list) {
-		struct rq *rq = rq_of(cfs_rq);
-		int cpu = cpu_of(rq);
+	struct rq *rq = rq_of(cfs_rq);
+	int cpu = cpu_of(rq);
+
+	if (cfs_rq->on_list)
+		return;
+
+	/*
+	 * Ensure we either appear before our parent (if already
+	 * enqueued) or force our parent to appear after us when it is
+	 * enqueued. The fact that we always enqueue bottom-up
+	 * reduces this to two cases and a special case for the root
+	 * cfs_rq. Furthermore, it also means that we will always reset
+	 * tmp_alone_branch either when the branch is connected
+	 * to a tree or when we reach the top of the tree
+	 */
+	if (cfs_rq->tg->parent &&
+	    cfs_rq->tg->parent->cfs_rq[cpu]->on_list) {
 		/*
-		 * Ensure we either appear before our parent (if already
-		 * enqueued) or force our parent to appear after us when it is
-		 * enqueued. The fact that we always enqueue bottom-up
-		 * reduces this to two cases and a special case for the root
-		 * cfs_rq. Furthermore, it also means that we will always reset
-		 * tmp_alone_branch either when the branch is connected
-		 * to a tree or when we reach the beg of the tree
+		 * If parent is already on the list, we add the child
+		 * just before. Thanks to circular linked property of
+		 * the list, this means to put the child at the tail
+		 * of the list that starts by parent.
 		 */
-		if (cfs_rq->tg->parent &&
-		    cfs_rq->tg->parent->cfs_rq[cpu]->on_list) {
-			/*
-			 * If parent is already on the list, we add the child
-			 * just before. Thanks to circular linked property of
-			 * the list, this means to put the child at the tail
-			 * of the list that starts by parent.
-			 */
-			list_add_tail_rcu(&cfs_rq->leaf_cfs_rq_list,
-				&(cfs_rq->tg->parent->cfs_rq[cpu]->leaf_cfs_rq_list));
-			/*
-			 * The branch is now connected to its tree so we can
-			 * reset tmp_alone_branch to the beginning of the
-			 * list.
-			 */
-			rq->tmp_alone_branch = &rq->leaf_cfs_rq_list;
-		} else if (!cfs_rq->tg->parent) {
-			/*
-			 * cfs rq without parent should be put
-			 * at the tail of the list.
-			 */
-			list_add_tail_rcu(&cfs_rq->leaf_cfs_rq_list,
-				&rq->leaf_cfs_rq_list);
-			/*
-			 * We have reach the beg of a tree so we can reset
-			 * tmp_alone_branch to the beginning of the list.
-			 */
-			rq->tmp_alone_branch = &rq->leaf_cfs_rq_list;
-		} else {
-			/*
-			 * The parent has not already been added so we want to
-			 * make sure that it will be put after us.
-			 * tmp_alone_branch points to the beg of the branch
-			 * where we will add parent.
-			 */
-			list_add_rcu(&cfs_rq->leaf_cfs_rq_list,
-				rq->tmp_alone_branch);
-			/*
-			 * update tmp_alone_branch to points to the new beg
-			 * of the branch
-			 */
-			rq->tmp_alone_branch = &cfs_rq->leaf_cfs_rq_list;
-		}
-
-		cfs_rq->on_list = 1;
+		list_add_tail_rcu(&cfs_rq->leaf_cfs_rq_list,
+			&(cfs_rq->tg->parent->cfs_rq[cpu]->leaf_cfs_rq_list));
+		/*
+		 * The branch is now connected to its tree so we can
+		 * reset tmp_alone_branch to the beginning of the
+		 * list.
+		 */
+		rq->tmp_alone_branch = &rq->leaf_cfs_rq_list;
+	} else if (!cfs_rq->tg->parent) {
+		/*
+		 * cfs rq without parent should be put
+		 * at the tail of the list.
+		 */
+		list_add_tail_rcu(&cfs_rq->leaf_cfs_rq_list,
+			&rq->leaf_cfs_rq_list);
+		/*
+		 * We have reach the top of a tree so we can reset
+		 * tmp_alone_branch to the beginning of the list.
+		 */
+		rq->tmp_alone_branch = &rq->leaf_cfs_rq_list;
+	} else {
+		/*
+		 * The parent has not already been added so we want to
+		 * make sure that it will be put after us.
+		 * tmp_alone_branch points to the begin of the branch
+		 * where we will add parent.
+		 */
+		list_add_rcu(&cfs_rq->leaf_cfs_rq_list,
+			rq->tmp_alone_branch);
+		/*
+		 * update tmp_alone_branch to points to the new begin
+		 * of the branch
+		 */
+		rq->tmp_alone_branch = &cfs_rq->leaf_cfs_rq_list;
 	}
+
+	cfs_rq->on_list = 1;
 }
 
 static inline void list_del_leaf_cfs_rq(struct cfs_rq *cfs_rq)
@@ -352,7 +354,12 @@ static inline void list_del_leaf_cfs_rq(struct cfs_rq *cfs_rq)
 	}
 }
 
-/* Iterate through all leaf cfs_rq's on a runqueue: */
+static inline void assert_list_leaf_cfs_rq(struct rq *rq)
+{
+	SCHED_WARN_ON(rq->tmp_alone_branch != &rq->lead_cfs_rq_list);
+}
+
+/* Iterate through all cfs_rq's on a runqueue in bottom-up order */
 #define for_each_leaf_cfs_rq(rq, cfs_rq) \
 	list_for_each_entry_rcu(cfs_rq, &rq->leaf_cfs_rq_list, leaf_cfs_rq_list)
 
@@ -446,6 +453,10 @@ static inline void list_del_leaf_cfs_rq(struct cfs_rq *cfs_rq)
 {
 }
 
+static inline void assert_list_leaf_cfs_rq(struct rq *rq)
+{
+}
+
 #define for_each_leaf_cfs_rq(rq, cfs_rq)	\
 		for (cfs_rq = &rq->cfs; cfs_rq; cfs_rq = NULL)
 
@@ -5179,6 +5190,8 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 
 	}
 
+	assert_list_leaf_cfs_rq(rq);
+
 	hrtick_update(rq);
 }
 
