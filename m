Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51847C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 13:10:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1484C21852
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 13:10:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Ao1cRRe7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726705AbeLRNKo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 08:10:44 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:47846 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726403AbeLRNKn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 08:10:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=gy0tGOfvPVWgQpZsiviUwbiTFWS03ZAqhYTsEA4TVWg=; b=Ao1cRRe7Km5I+/Y8eulEnly9J
        x6ki13nWZ4LYALVFALz0TT61cnneZz+36OdhdERfRbPk+FVMJUuldIuH/RHC5fDnAGD2+MNUlRkGx
        vhHyM9iRbgMDK74QwDqbZxpsoc9HB0AwPNZ+mBIMxk1EXt8oJdX1tSZzqKMgRDJZ+0r3U+pYsg9Mo
        LYEi4qhGNNZaLLlXZJhEA5Frpd0sX5cmD4EFdxwjy8y12o+6MtKl2ZgQsm6hrq4BAoTwbuF6XOIuQ
        jNTqekXcOsfdDz9T0FnAheSqbU5O1QLl8MONA+/ssfSxwPn4MVyasMxyzdXyIDvF1HJwQy2GxDbs4
        i+LhNB3Xg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gZF8r-0000dd-QJ; Tue, 18 Dec 2018 13:10:33 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C6D48203895D5; Tue, 18 Dec 2018 14:10:31 +0100 (CET)
Date:   Tue, 18 Dec 2018 14:10:31 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     Yongji Xie <elohimes@gmail.com>, mingo@redhat.com,
        will.deacon@arm.com, linux-kernel@vger.kernel.org,
        Xie Yongji <xieyongji@baidu.com>, zhangyu31@baidu.com,
        liuqi16@baidu.com, yuanlinsi01@baidu.com, nixun@baidu.com,
        lilin24@baidu.com, longman@redhat.com,
        andrea.parri@amarulasolutions.com
Subject: Re: [RFC] locking/rwsem: Avoid issuing wakeup before setting the
 reader waiter to nil
Message-ID: <20181218131031.GJ15430@hirez.programming.kicks-ass.net>
References: <8cc45695-b325-a219-8b46-d5da6ddfdd63@redhat.com>
 <20181129172700.GA11632@hirez.programming.kicks-ass.net>
 <20181129180828.GA11650@hirez.programming.kicks-ass.net>
 <729ceddb-dd9a-ec2a-f74e-03fa4d7e65e8@redhat.com>
 <20181129213017.v3eljor54lfpoug2@linux-r8p5>
 <20181129213421.wwvhsjql3m3lvtv4@linux-r8p5>
 <20181129221714.GF11632@hirez.programming.kicks-ass.net>
 <CAONzpcZ_kQ0cwit+d5uL=v2SqwP=Fo0WSihdCr23uKCAFAhTbQ@mail.gmail.com>
 <20181217113718.GB4900@worktop.programming.kicks-ass.net>
 <20181217205310.pvwcryyaqlrzmaex@linux-r8p5>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181217205310.pvwcryyaqlrzmaex@linux-r8p5>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 17, 2018 at 12:53:10PM -0800, Davidlohr Bueso wrote:
> On Mon, 17 Dec 2018, Peter Zijlstra wrote:
> > 
> > I've put some patches here:
> > 
> >  git://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git locking/core
> > 
> > Could you have a look?
> 
> So how about the following to reduce some of the performance penalty (at
> the cost of more complexity)?

I'd rather do it like so, except I'm still conflicted on the naming.

diff --git a/include/linux/sched/wake_q.h b/include/linux/sched/wake_q.h
index 545f37138057..ad826d2a4557 100644
--- a/include/linux/sched/wake_q.h
+++ b/include/linux/sched/wake_q.h
@@ -51,8 +51,8 @@ static inline void wake_q_init(struct wake_q_head *head)
 	head->lastp = &head->first;
 }
 
-extern void wake_q_add(struct wake_q_head *head,
-		       struct task_struct *task);
+extern void wake_q_add(struct wake_q_head *head, struct task_struct *task);
+extern void wake_q_add_safe(struct wake_q_head *head, struct task_struct *task);
 extern void wake_up_q(struct wake_q_head *head);
 
 #endif /* _LINUX_SCHED_WAKE_Q_H */
diff --git a/kernel/futex.c b/kernel/futex.c
index d14971f6ed3d..6218d98f649b 100644
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -1402,8 +1402,7 @@ static void mark_wake_futex(struct wake_q_head *wake_q, struct futex_q *q)
 	 * Queue the task for later wakeup for after we've released
 	 * the hb->lock. wake_q_add() grabs reference to p.
 	 */
-	wake_q_add(wake_q, p);
-	put_task_struct(p);
+	wake_q_add_safe(wake_q, p);
 }
 
 /*
diff --git a/kernel/locking/rwsem-xadd.c b/kernel/locking/rwsem-xadd.c
index 50d9af615dc4..fbe96341beee 100644
--- a/kernel/locking/rwsem-xadd.c
+++ b/kernel/locking/rwsem-xadd.c
@@ -211,9 +211,7 @@ static void __rwsem_mark_wake(struct rw_semaphore *sem,
 		 * Ensure issuing the wakeup (either by us or someone else)
 		 * after setting the reader waiter to nil.
 		 */
-		wake_q_add(wake_q, tsk);
-		/* wake_q_add() already take the task ref */
-		put_task_struct(tsk);
+		wake_q_add_safe(wake_q, tsk);
 	}
 
 	adjustment = woken * RWSEM_ACTIVE_READ_BIAS - adjustment;
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index d740d7a3608d..72d82ce73714 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -408,7 +408,7 @@ static bool set_nr_if_polling(struct task_struct *p)
  * This function must be used as-if it were wake_up_process(); IOW the task
  * must be ready to be woken at this location.
  */
-void wake_q_add(struct wake_q_head *head, struct task_struct *task)
+static bool __wake_q_add(struct wake_q_head *head, struct task_struct *task)
 {
 	struct wake_q_node *node = &task->wake_q;
 
@@ -422,15 +422,27 @@ void wake_q_add(struct wake_q_head *head, struct task_struct *task)
 	 */
 	smp_mb__before_atomic();
 	if (unlikely(cmpxchg_relaxed(&node->next, NULL, WAKE_Q_TAIL)))
-		return;
-
-	get_task_struct(task);
+		return false;
 
 	/*
 	 * The head is context local, there can be no concurrency.
 	 */
 	*head->lastp = node;
 	head->lastp = &node->next;
+
+	return true;
+}
+
+void wake_q_add(struct wake_q_head *head, struct task_struct *task)
+{
+	if (__wake_q_add(head, task))
+		get_task_struct(task);
+}
+
+void wake_q_add_safe(struct wake_q_head *head, struct task_struct *task)
+{
+	if (!__wake_a_add(head, task))
+		put_task_struct(task);
 }
 
 void wake_up_q(struct wake_q_head *head)
