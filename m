Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E2BAC0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 13:58:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 422DD2085B
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 13:58:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SxUv/afP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 422DD2085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730660AbeKGX2k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 18:28:40 -0500
Received: from merlin.infradead.org ([205.233.59.134]:60982 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727168AbeKGX2k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 18:28:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=EltP8ilXjkv36t1bw1TG5a0Czq2nBHXdy4S7Z15GOtE=; b=SxUv/afPVdYpf1ZVY+PTm0CeM
        RFSwfZgn0sDUHzEGnNMZaiK2fj+0vm9K1vBLZHM7zx3DLaomdkT/DRIqzc+RzbPwEdghwWmJK3ql2
        vZhnlBFbHT3qxv5zxlL0JmI35lttZHhuIHs0069DLIZR2zlaue8zTi9fu7EMvKoBgSY9qwBK+onNn
        KBwLtEIt6/VOLhV7cpgOPshA6xpvWjs+iL24OvHr7fP/YCbdVFFu5zfqalMLeb2pZFQ240oywqmTq
        Vx5P3IH1EXxFQRxvsP59qTd6APaABQjB7N45c2itL+qLr6qVnKli88lEJkyef4tcft+VwDv7GoCgs
        vIUiUOiXQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gKOLL-00068w-Te; Wed, 07 Nov 2018 13:58:04 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C03302029F883; Wed,  7 Nov 2018 14:58:01 +0100 (CET)
Date:   Wed, 7 Nov 2018 14:58:01 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Patrick Bellasi <patrick.bellasi@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>, Tejun Heo <tj@kernel.org>,
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
        Suren Baghdasaryan <surenb@google.com>,
        linux-api@vger.kernel.org
Subject: Re: [PATCH v5 02/15] sched/core: make sched_setattr able to tune the
 current policy
Message-ID: <20181107135801.GE9761@hirez.programming.kicks-ass.net>
References: <20181029183311.29175-1-patrick.bellasi@arm.com>
 <20181029183311.29175-3-patrick.bellasi@arm.com>
 <20181107121126.GN9781@hirez.programming.kicks-ass.net>
 <20181107135039.GD14309@e110439-lin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181107135039.GD14309@e110439-lin>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 07, 2018 at 01:50:39PM +0000, Patrick Bellasi wrote:
> On 07-Nov 13:11, Peter Zijlstra wrote:
> > On Mon, Oct 29, 2018 at 06:32:56PM +0000, Patrick Bellasi wrote:
> > 
> > > @@ -50,11 +52,13 @@
> > >  #define SCHED_FLAG_RESET_ON_FORK	0x01
> > >  #define SCHED_FLAG_RECLAIM		0x02
> > >  #define SCHED_FLAG_DL_OVERRUN		0x04
> > > -#define SCHED_FLAG_UTIL_CLAMP		0x08
> > > +#define SCHED_FLAG_TUNE_POLICY		0x08
> > > +#define SCHED_FLAG_UTIL_CLAMP		0x10
> > 
> > That seems to suggest you want to do this patch first, but you didn't..
> 
> I've kept it here just to better highlight this change, suggested by
> Juri, since we was not entirely sure you are fine with it...
> 
> If you think it's ok adding a SCHED_FLAG_TUNE_POLICY behavior to the
> sched_setattr syscall, I can certainly squash into the previous patch,
> which gives more context on why we need it.

I'm fine with the idea I think. It's the details I worry about. Which
fields in particular are not updated with this. Are flags?

Also, I'm not too keen on the name; since it explicitly does not modify
the policy and its related parameters, so TUNE_POLICY is actively wrong.

But the thing that confused me most is how fiddled the numbers to fit
this before UTIL_CLAMP.

> Since we are at that, are we supposed to document some{where,how}
> these API changes ?

I'm pretty sure there's a manpage somewhere... SCHED_SETATTR(2) seems to
exist on my machine. So that wants updates.
