Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ACC3C46469
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 17:42:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01FEF20880
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 17:42:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Df9TfgGm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01FEF20880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728043AbeILWsQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 18:48:16 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:38878 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726862AbeILWsQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 18:48:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ENP3GbDyOQnD1mynbxYqp5fvvdRJktS2bf05jAAEepE=; b=Df9TfgGmQEYa6VHlPaG0aZX1Q
        E8PDDOleY7/dj4/+iBGSHjxk1h+iUMne3FCJJqCfckbPEb7V8yAFzOZXEzkkZs37r0GW07jF38TDi
        yxIB+6tBJQbOrpOcu2cRlce4Di/Uu4kHewpUQhCEeB5qtJRI49vW85nfJu8j4Ex+d83s8sYoZJsYq
        T5BV1wX+7KV/ud3h+qii3+cqNI/o7NGK4UGQ+awC3M2g2YDjOGMOBz97GgFLavzFC2A/wpUPCI/Uk
        el6hhrAsYUr2b1QgEa0GY/NgEHwZQBK72KyLPP2t7xjWgZ1/gUbQHhhI388v+yRWiONYZ4EmHuLnr
        L+04E+wZA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g099x-0006x1-JM; Wed, 12 Sep 2018 17:42:37 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1B349202C1A09; Wed, 12 Sep 2018 19:42:36 +0200 (CEST)
Date:   Wed, 12 Sep 2018 19:42:36 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Patrick Bellasi <patrick.bellasi@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>, Tejun Heo <tj@kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Paul Turner <pjt@google.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Todd Kjos <tkjos@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Steve Muckle <smuckle@google.com>,
        Suren Baghdasaryan <surenb@google.com>
Subject: Re: [PATCH v4 02/16] sched/core: uclamp: map TASK's clamp values
 into CPU's clamp groups
Message-ID: <20180912174236.GB24106@hirez.programming.kicks-ass.net>
References: <20180828135324.21976-1-patrick.bellasi@arm.com>
 <20180828135324.21976-3-patrick.bellasi@arm.com>
 <20180912134945.GZ24106@hirez.programming.kicks-ass.net>
 <20180912155619.GG1413@e110439-lin>
 <20180912161218.GW24082@hirez.programming.kicks-ass.net>
 <20180912173515.GH1413@e110439-lin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180912173515.GH1413@e110439-lin>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 12, 2018 at 06:35:15PM +0100, Patrick Bellasi wrote:
> On 12-Sep 18:12, Peter Zijlstra wrote:

> > No idea; but if you want to go all fancy you can replace he whole
> > uclamp_map thing with something like:
> > 
> > struct uclamp_map {
> > 	union {
> > 		struct {
> > 			unsigned long v : 10;
> > 			unsigned long c : BITS_PER_LONG - 10;
> > 		};
> > 		atomic_long_t s;
> > 	};
> > };
> 
> That sounds really cool and scary at the same time :)
> 
> The v:10 requires that we never set SCHED_CAPACITY_SCALE>1024
> or that we use it to track a percentage value (i.e. [0..100]).

Or we pick 11 bits, it seems unlikely that capacity be larger than 2k.

> One of the last patches introduces percentage values to userspace.
> But, I was considering that in kernel space we should always track
> full scale utilization values.
> 
> The c:(BITS_PER_LONG-10) restricts the range of concurrently active
> SE refcounting the same clamp value. Which, for some 32bit systems is
> only 4 milions among tasks and cgroups... maybe still reasonable...

Yeah, on 32bit having 4M tasks seems 'unlikely'.
