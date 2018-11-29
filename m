Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92C56C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 18:30:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A00F21104
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 18:30:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A00F21104
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728606AbeK3FhD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 00:37:03 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:43086 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728348AbeK3FhD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 00:37:03 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4560A80D;
        Thu, 29 Nov 2018 10:30:45 -0800 (PST)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 141FF3F575;
        Thu, 29 Nov 2018 10:30:45 -0800 (PST)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id 8F4971AE0FD4; Thu, 29 Nov 2018 18:31:03 +0000 (GMT)
Date:   Thu, 29 Nov 2018 18:31:03 +0000
From:   Will Deacon <will.deacon@arm.com>
To:     Waiman Long <longman@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Yongji Xie <elohimes@gmail.com>, mingo@redhat.com,
        linux-kernel@vger.kernel.org, xieyongji@baidu.com,
        zhangyu31@baidu.com, liuqi16@baidu.com, yuanlinsi01@baidu.com,
        nixun@baidu.com, lilin24@baidu.com,
        Davidlohr Bueso <dave@stgolabs.net>
Subject: Re: [RFC] locking/rwsem: Avoid issuing wakeup before setting the
 reader waiter to nil
Message-ID: <20181129183103.GA4952@arm.com>
References: <1543495830-2644-1-git-send-email-xieyongji@baidu.com>
 <20181129131232.GN2131@hirez.programming.kicks-ass.net>
 <5598cd71-c3c8-d6ef-eb30-777cf901a2ef@redhat.com>
 <20181129160627.GU2131@hirez.programming.kicks-ass.net>
 <8cc45695-b325-a219-8b46-d5da6ddfdd63@redhat.com>
 <20181129172700.GA11632@hirez.programming.kicks-ass.net>
 <20181129180828.GA11650@hirez.programming.kicks-ass.net>
 <729ceddb-dd9a-ec2a-f74e-03fa4d7e65e8@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <729ceddb-dd9a-ec2a-f74e-03fa4d7e65e8@redhat.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 29, 2018 at 01:26:34PM -0500, Waiman Long wrote:
> On 11/29/2018 01:08 PM, Peter Zijlstra wrote:
> > Hmm, I think we're missing a barrier in wake_q_add(); when cmpxchg()
> > fails we still need an smp_mb().
> >
> > Something like so.
> >
> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > index 3d87a28da378..69def558edf6 100644
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -400,6 +400,13 @@ void wake_q_add(struct wake_q_head *head, struct task_struct *task)
> >  {
> >  	struct wake_q_node *node = &task->wake_q;
> >  
> > +	/*
> > +	 * Ensure, that when the below cmpxchg() fails, the corresponding
> > +	 * wake_up_q() will observe our prior state.
> > +	 *
> > +	 * Pairs with the smp_mb() from wake_up_q()'s wake_up_process().
> > +	 */
> > +	smp_mb();
> >  	/*
> >  	 * Atomically grab the task, if ->wake_q is !nil already it means
> >  	 * its already queued (either by us or someone else) and will get the
> > @@ -408,7 +415,7 @@ void wake_q_add(struct wake_q_head *head, struct task_struct *task)
> >  	 * This cmpxchg() executes a full barrier, which pairs with the full
> >  	 * barrier executed by the wakeup in wake_up_q().
> >  	 */
> > -	if (cmpxchg(&node->next, NULL, WAKE_Q_TAIL))
> > +	if (cmpxchg_relaxed(&node->next, NULL, WAKE_Q_TAIL))
> >  		return;
> >  
> >  	get_task_struct(task);
> 
> That can be costly for x86 which will now have 2 locked instructions.
> Should we introduce a kind of special cmpxchg (e.g. cmpxchg_mb) that
> will guarantee a memory barrier whether the operation fails or not?

I thought smp_mb__before_atomic() was designed for this sort of thing?

Will
