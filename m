Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09255C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 15:13:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA35E20879
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 15:13:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="1KkiRqkv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729117AbfAVPNb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 10:13:31 -0500
Received: from merlin.infradead.org ([205.233.59.134]:32950 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728795AbfAVPNb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 10:13:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=pol6vbvKu8tFxQP5TOGuApIiaN4SOJ/yxxzuZY8iRIY=; b=1KkiRqkvY7Ut9falFCG0TuEri
        gdiepq/u/kXEVv0nl1/MjhV3pHEifadphQN9DogTFalH1UpNVP3C5x4gN05bjkwi/KC9jocea5Szq
        JWXgevaBp5RNKI3LMMDQ1OAYE9OKFAeACr8VfJX/vSIeDRFUzNWzxDAeWOPJ3MU2UFnaGbJj/pZWo
        rluPO9wQ+GISVYkDcjhb7SLsOK+RKLFYu7VeAQgKNMCltnF2WGx+LyPg0Fw3S69Guxg54Gydtq4ZJ
        JGcYFQ84498a6LrdlsTnLmdAw1X+jIK+6lXm67lZbhmXkNZC/iX77QcTo5QUAdbeOJM+6Pa2BjHoh
        017L1eGSA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1glxjs-00034d-Dk; Tue, 22 Jan 2019 15:13:20 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 378FB2042CFCC; Tue, 22 Jan 2019 16:13:17 +0100 (CET)
Date:   Tue, 22 Jan 2019 16:13:17 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Patrick Bellasi <patrick.bellasi@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-api@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Tejun Heo <tj@kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Paul Turner <pjt@google.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Todd Kjos <tkjos@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Steve Muckle <smuckle@google.com>,
        Suren Baghdasaryan <surenb@google.com>
Subject: Re: [PATCH v6 07/16] sched/core: uclamp: Add system default clamps
Message-ID: <20190122151317.GH13777@hirez.programming.kicks-ass.net>
References: <20190115101513.2822-1-patrick.bellasi@arm.com>
 <20190115101513.2822-8-patrick.bellasi@arm.com>
 <20190122135644.GP27931@hirez.programming.kicks-ass.net>
 <20190122144329.ziimv6fejwvky7yb@e110439-lin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190122144329.ziimv6fejwvky7yb@e110439-lin>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 22, 2019 at 02:43:29PM +0000, Patrick Bellasi wrote:
> On 22-Jan 14:56, Peter Zijlstra wrote:
> > On Tue, Jan 15, 2019 at 10:15:04AM +0000, Patrick Bellasi wrote:
> > 
> > > diff --git a/include/linux/sched.h b/include/linux/sched.h
> > > index 84294925d006..c8f391d1cdc5 100644
> > > --- a/include/linux/sched.h
> > > +++ b/include/linux/sched.h
> > > @@ -625,6 +625,11 @@ struct uclamp_se {
> > >  	unsigned int bucket_id		: bits_per(UCLAMP_BUCKETS);
> > >  	unsigned int mapped		: 1;
> > >  	unsigned int active		: 1;
> > > +	/* Clamp bucket and value actually used by a RUNNABLE task */
> > > +	struct {
> > > +		unsigned int value	: bits_per(SCHED_CAPACITY_SCALE);
> > > +		unsigned int bucket_id	: bits_per(UCLAMP_BUCKETS);
> > > +	} effective;
> > 
> > I am confuzled by this thing..  so uclamp_se already has a value,bucket,
> > which per the prior code is the effective one.
> > 
> > Now; I think I see why you want another value; you need the second to
> > store the original value for when the system limits change and we must
> > re-evaluate.
> 
> Yes, that's one reason, the other one being to properly support
> CGroup when we add them in the following patches.
> 
> Effective will always track the value/bucket in which the task has
> been refcounted at enqueue time and it depends on the aggregated
> value.

> > Should you not update all tasks?
> 
> That's true, but that's also an expensive operation, that's why now
> I'm doing only lazy updates at next enqueue time.

Aaah, so you refcount on the original value, which allows you to skip
fixing up all tasks. I missed that bit.


> Do you think that could be acceptable?

Think so, it's a sysctl poke, 'nobody' ever does that.
