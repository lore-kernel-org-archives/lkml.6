Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E735C04AA5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 15:42:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 575F1208AE
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 15:42:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 575F1208AE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726702AbeJOX2K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 19:28:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:49352 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726422AbeJOX2J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 19:28:09 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4C5F72089D;
        Mon, 15 Oct 2018 15:42:22 +0000 (UTC)
Date:   Mon, 15 Oct 2018 11:42:20 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Peng Hao <peng.hao2@zte.com.cn>, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] sched/rt : return accurate release rq lock info
Message-ID: <20181015114220.70c3598d@gandalf.local.home>
In-Reply-To: <20181015092032.GO9867@hirez.programming.kicks-ass.net>
References: <1538778131-44406-1-git-send-email-peng.hao2@zte.com.cn>
        <20181015092032.GO9867@hirez.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Oct 2018 11:20:32 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> > index 2e2955a..be0fc43 100644
> > --- a/kernel/sched/rt.c
> > +++ b/kernel/sched/rt.c
> > @@ -1754,7 +1754,7 @@ static struct rq *find_lock_lowest_rq(struct task_struct *task, struct rq *rq)
> >  				     !task_on_rq_queued(task))) {
> >  
> >  				double_unlock_balance(rq, lowest_rq);
> > -				lowest_rq = NULL;
> > +				lowest_rq = RETRY_TASK;
> >  				break;
> >  			}
> >  		}  
> 
> I'm confused.. should not:
> 
> 		/* try again */
> 		double_unlock_balance(rq, lowest_rq);
> 		lowest_rq = NULL;
> 
> also return RETRY_TASK? That also is in the double_lock_balance() path
> and will this have had rq->lock() released.

I thought the same thing at first, but this is in the loop path, where
it does everything again. But now looking closer, I think there's a bug
in the original code.

We only do the check if the immediate double_lock_balance() released
the current task rq lock, but we don't take into account if it was
released earlier, which means it could have migrated and we never
noticed!

I believe the code should look like this:

diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 2e2955a8cf8f..2c9128ce61e2 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -1718,6 +1718,7 @@ static int find_lowest_rq(struct task_struct *task)
 static struct rq *find_lock_lowest_rq(struct task_struct *task, struct rq *rq)
 {
 	struct rq *lowest_rq = NULL;
+	bool released = false;
 	int tries;
 	int cpu;
 
@@ -1740,7 +1741,7 @@ static struct rq *find_lock_lowest_rq(struct task_struct *task, struct rq *rq)
 		}
 
 		/* if the prio of this runqueue changed, try again */
-		if (double_lock_balance(rq, lowest_rq)) {
+		if (double_lock_balance(rq, lowest_rq) || released) {
 			/*
 			 * We had to unlock the run queue. In
 			 * the mean time, task could have
@@ -1754,7 +1755,7 @@ static struct rq *find_lock_lowest_rq(struct task_struct *task, struct rq *rq)
 				     !task_on_rq_queued(task))) {
 
 				double_unlock_balance(rq, lowest_rq);
-				lowest_rq = NULL;
+				lowest_rq = RETRY_TASK;
 				break;
 			}
 		}
@@ -1764,10 +1765,15 @@ static struct rq *find_lock_lowest_rq(struct task_struct *task, struct rq *rq)
 			break;
 
 		/* try again */
-		double_unlock_balance(rq, lowest_rq);
+		if (double_unlock_balance(rq, lowest_rq))
+			released = true;
+
 		lowest_rq = NULL;
 	}
 
+	if (!lowest_rq && released)
+		lowest_rq = RETRY_TASK;
+
 	return lowest_rq;
 }
 
-- Steve
