Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2224C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 12:35:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73D1E20866
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 12:35:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="U2reL9tp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73D1E20866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727105AbeJPUZk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 16:25:40 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:49990 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726778AbeJPUZk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 16:25:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=MIFkZXafsgU0n0h5B1FEhA7PnV97YNSnHnNN/NRLA0Y=; b=U2reL9tp38KrZYiR4ZWersSpN
        /lkWBEP8hgUU4apBFDAHg7FI9cndFkDUnVYwGHsMN5KzMXkWZ7stMSPE+IhzOei3Yj4f5xh2Czr9F
        pYhcJWCJ3R129ukWc1COgKcYVF/hqrR+Do/lPAyrDwFmJXiVMOpEplV8+wqNEPPkZxi4+qg0/FiSx
        pJ3ksT1nLgegouK2PrnsJwYIGIEx6V6169BIOoFIRK7IOr32xHx1DnKuEaYZQnDSmmRvUQ3X0WEWi
        lHk1tSiiqI9pnr1Uc0ETtAFIXQW6Tn+gnbSeRuLibSjPugHK1YFXpCu4EpkUj5FL3PetcVbjiuZ1H
        a/jOhzHbw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gCOZE-00032K-Mu; Tue, 16 Oct 2018 12:35:21 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 409E620297B7B; Tue, 16 Oct 2018 14:35:17 +0200 (CEST)
Date:   Tue, 16 Oct 2018 14:35:17 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Peng Hao <peng.hao2@zte.com.cn>, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] sched/rt : return accurate release rq lock info
Message-ID: <20181016123517.GB2537@hirez.programming.kicks-ass.net>
References: <1538778131-44406-1-git-send-email-peng.hao2@zte.com.cn>
 <20181015092032.GO9867@hirez.programming.kicks-ass.net>
 <20181015114220.70c3598d@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181015114220.70c3598d@gandalf.local.home>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 15, 2018 at 11:42:20AM -0400, Steven Rostedt wrote:
> On Mon, 15 Oct 2018 11:20:32 +0200
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > > index 2e2955a..be0fc43 100644
> > > --- a/kernel/sched/rt.c
> > > +++ b/kernel/sched/rt.c
> > > @@ -1754,7 +1754,7 @@ static struct rq *find_lock_lowest_rq(struct task_struct *task, struct rq *rq)
> > >  				     !task_on_rq_queued(task))) {
> > >  
> > >  				double_unlock_balance(rq, lowest_rq);
> > > -				lowest_rq = NULL;
> > > +				lowest_rq = RETRY_TASK;
> > >  				break;
> > >  			}
> > >  		}  
> > 
> > I'm confused.. should not:
> > 
> > 		/* try again */
> > 		double_unlock_balance(rq, lowest_rq);
> > 		lowest_rq = NULL;
> > 
> > also return RETRY_TASK? That also is in the double_lock_balance() path
> > and will this have had rq->lock() released.
> 
> I thought the same thing at first, but this is in the loop path, where
> it does everything again. But now looking closer, I think there's a bug
> in the original code.

So I find that whole thing utterly confusing; what about we start with
something like so?

---
 kernel/sched/rt.c | 51 +++++++++++++++++++++++----------------------------
 1 file changed, 23 insertions(+), 28 deletions(-)

diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 2e2955a8cf8f..237c84c2b042 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -1714,6 +1714,26 @@ static int find_lowest_rq(struct task_struct *task)
 	return -1;
 }
 
+static struct task_struct *first_pushable_task(struct rq *rq)
+{
+	struct task_struct *p;
+
+	if (!has_pushable_tasks(rq))
+		return NULL;
+
+	p = plist_first_entry(&rq->rt.pushable_tasks,
+			      struct task_struct, pushable_tasks);
+
+	BUG_ON(rq->cpu != task_cpu(p));
+	BUG_ON(task_current(rq, p));
+	BUG_ON(p->nr_cpus_allowed <= 1);
+
+	BUG_ON(!task_on_rq_queued(p));
+	BUG_ON(!rt_task(p));
+
+	return p;
+}
+
 /* Will lock the rq it finds */
 static struct rq *find_lock_lowest_rq(struct task_struct *task, struct rq *rq)
 {
@@ -1747,12 +1767,7 @@ static struct rq *find_lock_lowest_rq(struct task_struct *task, struct rq *rq)
 			 * migrated already or had its affinity changed.
 			 * Also make sure that it wasn't scheduled on its rq.
 			 */
-			if (unlikely(task_rq(task) != rq ||
-				     !cpumask_test_cpu(lowest_rq->cpu, &task->cpus_allowed) ||
-				     task_running(rq, task) ||
-				     !rt_task(task) ||
-				     !task_on_rq_queued(task))) {
-
+			if (first_pushable_task(rq) != task)
 				double_unlock_balance(rq, lowest_rq);
 				lowest_rq = NULL;
 				break;
@@ -1771,26 +1786,6 @@ static struct rq *find_lock_lowest_rq(struct task_struct *task, struct rq *rq)
 	return lowest_rq;
 }
 
-static struct task_struct *pick_next_pushable_task(struct rq *rq)
-{
-	struct task_struct *p;
-
-	if (!has_pushable_tasks(rq))
-		return NULL;
-
-	p = plist_first_entry(&rq->rt.pushable_tasks,
-			      struct task_struct, pushable_tasks);
-
-	BUG_ON(rq->cpu != task_cpu(p));
-	BUG_ON(task_current(rq, p));
-	BUG_ON(p->nr_cpus_allowed <= 1);
-
-	BUG_ON(!task_on_rq_queued(p));
-	BUG_ON(!rt_task(p));
-
-	return p;
-}
-
 /*
  * If the current CPU has more than one RT task, see if the non
  * running task can migrate over to a CPU that is running a task
@@ -1805,7 +1800,7 @@ static int push_rt_task(struct rq *rq)
 	if (!rq->rt.overloaded)
 		return 0;
 
-	next_task = pick_next_pushable_task(rq);
+	next_task = first_pushable_task(rq);
 	if (!next_task)
 		return 0;
 
@@ -1840,7 +1835,7 @@ static int push_rt_task(struct rq *rq)
 		 * run-queue and is also still the next task eligible for
 		 * pushing.
 		 */
-		task = pick_next_pushable_task(rq);
+		task = first_pushable_task(rq);
 		if (task == next_task) {
 			/*
 			 * The task hasn't migrated, and is still the next
