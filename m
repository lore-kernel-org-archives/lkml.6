Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFD17C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 09:30:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F42E20863
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 09:30:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="iKEuS2Ak"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F42E20863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726566AbeK3UjW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 15:39:22 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:44780 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726467AbeK3UjV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 15:39:21 -0500
Received: by mail-ed1-f65.google.com with SMTP id y56so4250217edd.11
        for <linux-kernel@vger.kernel.org>; Fri, 30 Nov 2018 01:30:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RDRAyzistiMunClpWSjFlvYfejV04nVdcw4zYkEs71w=;
        b=iKEuS2AkgbipvgPD/AF6OnROwKPvKlBojCZjG/K0cI74ATNViC5TTfXoF511HSdYTu
         ES5meiBBnakTz4MqsJIZPW/oMGb55jaqRzJP/cK9b7RfwrOAYI9teMkY00Hbv6OWMPn9
         o1hkwpfMF4ckUxMP4EzXqYLTwd2Ph9RZFyrX0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RDRAyzistiMunClpWSjFlvYfejV04nVdcw4zYkEs71w=;
        b=NWr83AFbC9/ZyYbV/DoQDVKvFdZ4dfE4ldGjvT9TJXdzKaGQUW7RhZvaJYqaN0cJLh
         UvGHn6bENsn2lDtPr2PF0aR0L2B8sP3z8i2tBe0PeGX/tPpMlbl/gUYwZZYa0K9UZdFu
         8Oyl2/Wq0KDjmMmexCG9ehvuL+B3XLe6dzagRyXvDuWejPJ++3x1UlJ0TUX6DjlqTIr5
         WgzBPb2nujY6exsvPb0DODHiApjA5w9mq+pTweo2ytYnEYQXSE1q7K2Gj7p20HXH2OBr
         /8K34QriwD+0qfHuSAA8cSKfVlqV+F079v3DNq5nCTy9lsui4mqRvZD8iJmZUTCgk2Rr
         4mjQ==
X-Gm-Message-State: AA+aEWbcfw7C14i1uj8csDE0v67/AQGNin6zZDZE6PPYyUt5ODM4GNzk
        c7EzH3UzZhXHD5KHlKOttpWGhg==
X-Google-Smtp-Source: AFSGD/XXJ3U7phljNeokTcA8ChJjS8Ktg+gpyTD9yScLZ7y01jsRbFnv0zdQPMyL5ohDuKcoy/WpcA==
X-Received: by 2002:a50:9a01:: with SMTP id o1mr4732001edb.82.1543570238463;
        Fri, 30 Nov 2018 01:30:38 -0800 (PST)
Received: from andrea (85.100.broadband17.iol.cz. [109.80.100.85])
        by smtp.gmail.com with ESMTPSA id f20sm1247353edf.19.2018.11.30.01.30.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 30 Nov 2018 01:30:37 -0800 (PST)
Date:   Fri, 30 Nov 2018 10:30:29 +0100
From:   Andrea Parri <andrea.parri@amarulasolutions.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Davidlohr Bueso <dave@stgolabs.net>,
        Yongji Xie <elohimes@gmail.com>, mingo@redhat.com,
        will.deacon@arm.com, linux-kernel@vger.kernel.org,
        xieyongji@baidu.com, zhangyu31@baidu.com, liuqi16@baidu.com,
        yuanlinsi01@baidu.com, nixun@baidu.com, lilin24@baidu.com,
        longman@redhat.com
Subject: Re: [RFC] locking/rwsem: Avoid issuing wakeup before setting the
 reader waiter to nil
Message-ID: <20181130093029.GA6299@andrea>
References: <20181129131232.GN2131@hirez.programming.kicks-ass.net>
 <5598cd71-c3c8-d6ef-eb30-777cf901a2ef@redhat.com>
 <20181129160627.GU2131@hirez.programming.kicks-ass.net>
 <8cc45695-b325-a219-8b46-d5da6ddfdd63@redhat.com>
 <20181129172700.GA11632@hirez.programming.kicks-ass.net>
 <20181129180828.GA11650@hirez.programming.kicks-ass.net>
 <729ceddb-dd9a-ec2a-f74e-03fa4d7e65e8@redhat.com>
 <20181129213017.v3eljor54lfpoug2@linux-r8p5>
 <20181129213421.wwvhsjql3m3lvtv4@linux-r8p5>
 <20181129221714.GF11632@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181129221714.GF11632@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 29, 2018 at 11:17:14PM +0100, Peter Zijlstra wrote:
> On Thu, Nov 29, 2018 at 01:34:21PM -0800, Davidlohr Bueso wrote:
> > I messed up something such that waiman was not in the thread. Ccing.
> > 
> > > On Thu, 29 Nov 2018, Waiman Long wrote:
> > > 
> > > > That can be costly for x86 which will now have 2 locked instructions.
> > > 
> > > Yeah, and when used as an actual queue we should really start to notice.
> > > Some users just have a single task in the wake_q because avoiding the cost
> > > of wake_up_process() with locks held is significant.
> > > 
> > > How about instead of adding the barrier before the cmpxchg, we do it
> > > in the failed branch, right before we return. This is the uncommon
> > > path.
> > > 
> > > Thanks,
> > > Davidlohr
> > > 
> > > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > > index 091e089063be..0d844a18a9dc 100644
> > > --- a/kernel/sched/core.c
> > > +++ b/kernel/sched/core.c
> > > @@ -408,8 +408,14 @@ void wake_q_add(struct wake_q_head *head, struct task_struct *task)
> > > 	 * This cmpxchg() executes a full barrier, which pairs with the full
> > > 	 * barrier executed by the wakeup in wake_up_q().
> > > 	 */
> > > -	if (cmpxchg(&node->next, NULL, WAKE_Q_TAIL))
> > > +	if (cmpxchg(&node->next, NULL, WAKE_Q_TAIL)) {
> > > +		/*
> > > +		 * Ensure, that when the cmpxchg() fails, the corresponding
> > > +		 * wake_up_q() will observe our prior state.
> > > +		 */
> > > +		smp_mb__after_atomic();
> > > 		return;
> > > +	}
> 
> So wake_up_q() does:
> 
>   wake_up_q():
> 	node->next = NULL;
> 	/* implied smp_mb */
> 	wake_up_process();
> 
> So per the cross your variables 'rule', this side then should do:
> 
>   wake_q_add():
> 	/* wake_cond = true */
> 	smp_mb()
> 	cmpxchg_relaxed(&node->next, ...);
> 
> So that the ordering pivots around node->next.
> 
> Either we see NULL and win the cmpxchg (in which case we'll do the
> wakeup later) or, when we fail the cmpxchg, we must observe what came
> before the failure.
> 
> If it wasn't so damn late, I'd try and write a litmus test for this,
> because now I'm starting to get confused -- also probably because it's
> late.

The above description suggests:

C wake_up_q-wake_q_add

{
	int next = 0;
	int y = 0;
}

P0(int *next, int *y)
{
	int r0;

	/* in wake_up_q() */

	WRITE_ONCE(*next, 1);	/* node->next = NULL */
	smp_mb();		/* implied by wake_up_process() */
	r0 = READ_ONCE(*y);
}

P1(int *next, int *y)
{
	int r1;

	/* in wake_q_add() */

	WRITE_ONCE(*y, 1);	/* wake_cond = true */
	smp_mb__before_atomic();
	r1 = cmpxchg_relaxed(next, 1, 2);
}

exists (0:r0=0 /\ 1:r1=0)


This "exists" clause cannot be satisfied according to the LKMM:

Test wake_up_q-wake_q_add Allowed
States 3
0:r0=0; 1:r1=1;
0:r0=1; 1:r1=0;
0:r0=1; 1:r1=1;
No
Witnesses
Positive: 0 Negative: 3
Condition exists (0:r0=0 /\ 1:r1=0)
Observation wake_up_q-wake_q_add Never 0 3
Time wake_up_q-wake_q_add 0.00
Hash=72d85545f97ef7fd35c8928259225ee0


(TBH, I'm not sure what "y" (you denoted it "wake_cond") is pointing to
 here/is modeling, but I might have missed some previous remarks...)

  Andrea


> 
> In any case, I think you patch is 'wrong' because it puts the barrier on
> the wrong side of the cmpxchg() (after, as opposed to before).
