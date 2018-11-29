Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 700A0C04EB9
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 22:17:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2989B2146F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 22:17:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gkC5JIvd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2989B2146F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726463AbeK3JYX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 04:24:23 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:55986 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726264AbeK3JYW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 04:24:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=+mMrZVtKA2Oq8POkxjY1MuymzApncZl3S9cuM6cdNVc=; b=gkC5JIvd68FIhdCRvXy+SKuc9
        HMxdQpSlwHvV1WWKdKJuhr3AHRUvuFWdrVrAmLlJGTMpnmP8ddg+GkjiG3jkuKIHk4aFZcogV2K7Z
        HhpAQhkqQI3qwJKkN/4F0nRi+Xt+cd3ZCeeVUl4QtArcah7z5EgWGpO74WjeClrsd2tj4kdbZjHZ3
        J7Bkw12JL47Rbnznbo8c7xofUUE/9y7K2C9wh+awsrO1tzklMlOlqhnwngcJYV44tCgS9S7FALJvM
        EFqivWjE69UQPjSsuwEyeNBey7ij+kw3Bzw5TCrS5Fl1httbjtQgn6EVg/PE4ukam7gkCfFDMArrz
        WRYm7Ea1Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gSUcX-0004eT-6d; Thu, 29 Nov 2018 22:17:17 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8EC952029FD58; Thu, 29 Nov 2018 23:17:14 +0100 (CET)
Date:   Thu, 29 Nov 2018 23:17:14 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     Yongji Xie <elohimes@gmail.com>, mingo@redhat.com,
        will.deacon@arm.com, linux-kernel@vger.kernel.org,
        xieyongji@baidu.com, zhangyu31@baidu.com, liuqi16@baidu.com,
        yuanlinsi01@baidu.com, nixun@baidu.com, lilin24@baidu.com,
        longman@redhat.com, andrea.parri@amarulasolutions.com
Subject: Re: [RFC] locking/rwsem: Avoid issuing wakeup before setting the
 reader waiter to nil
Message-ID: <20181129221714.GF11632@hirez.programming.kicks-ass.net>
References: <1543495830-2644-1-git-send-email-xieyongji@baidu.com>
 <20181129131232.GN2131@hirez.programming.kicks-ass.net>
 <5598cd71-c3c8-d6ef-eb30-777cf901a2ef@redhat.com>
 <20181129160627.GU2131@hirez.programming.kicks-ass.net>
 <8cc45695-b325-a219-8b46-d5da6ddfdd63@redhat.com>
 <20181129172700.GA11632@hirez.programming.kicks-ass.net>
 <20181129180828.GA11650@hirez.programming.kicks-ass.net>
 <729ceddb-dd9a-ec2a-f74e-03fa4d7e65e8@redhat.com>
 <20181129213017.v3eljor54lfpoug2@linux-r8p5>
 <20181129213421.wwvhsjql3m3lvtv4@linux-r8p5>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181129213421.wwvhsjql3m3lvtv4@linux-r8p5>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 29, 2018 at 01:34:21PM -0800, Davidlohr Bueso wrote:
> I messed up something such that waiman was not in the thread. Ccing.
> 
> > On Thu, 29 Nov 2018, Waiman Long wrote:
> > 
> > > That can be costly for x86 which will now have 2 locked instructions.
> > 
> > Yeah, and when used as an actual queue we should really start to notice.
> > Some users just have a single task in the wake_q because avoiding the cost
> > of wake_up_process() with locks held is significant.
> > 
> > How about instead of adding the barrier before the cmpxchg, we do it
> > in the failed branch, right before we return. This is the uncommon
> > path.
> > 
> > Thanks,
> > Davidlohr
> > 
> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > index 091e089063be..0d844a18a9dc 100644
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -408,8 +408,14 @@ void wake_q_add(struct wake_q_head *head, struct task_struct *task)
> > 	 * This cmpxchg() executes a full barrier, which pairs with the full
> > 	 * barrier executed by the wakeup in wake_up_q().
> > 	 */
> > -	if (cmpxchg(&node->next, NULL, WAKE_Q_TAIL))
> > +	if (cmpxchg(&node->next, NULL, WAKE_Q_TAIL)) {
> > +		/*
> > +		 * Ensure, that when the cmpxchg() fails, the corresponding
> > +		 * wake_up_q() will observe our prior state.
> > +		 */
> > +		smp_mb__after_atomic();
> > 		return;
> > +	}

So wake_up_q() does:

  wake_up_q():
	node->next = NULL;
	/* implied smp_mb */
	wake_up_process();

So per the cross your variables 'rule', this side then should do:

  wake_q_add():
	/* wake_cond = true */
	smp_mb()
	cmpxchg_relaxed(&node->next, ...);

So that the ordering pivots around node->next.

Either we see NULL and win the cmpxchg (in which case we'll do the
wakeup later) or, when we fail the cmpxchg, we must observe what came
before the failure.

If it wasn't so damn late, I'd try and write a litmus test for this,
because now I'm starting to get confused -- also probably because it's
late.

In any case, I think you patch is 'wrong' because it puts the barrier on
the wrong side of the cmpxchg() (after, as opposed to before).
