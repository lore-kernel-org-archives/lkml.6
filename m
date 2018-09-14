Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6BF9FC6182
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 14:28:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6097F206B5
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 14:28:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KJJD7DEc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6097F206B5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728254AbeINTnI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 15:43:08 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:52686 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727734AbeINTnI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 15:43:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=KSjVOVYJc6J7ts91fJCpCUWlUfmeJWujxg9xcQbomt8=; b=KJJD7DEcNOMHruBdV7RenNGi+
        0iu0vaN4qHjn1QDtk9PSBomoLpVUW2e5lrMVnbkxM5RvaiTmv0KoGICGdBFFqsQvX++1x4q/K0apH
        JisiPCPNIqG6ytvFgbBPY1g/8pZYL0Gmt9I5SBhPa6kN584PIa45xoIq7lK/viwVESxHvX1ySBoJK
        dR9meSTdGqGb+LtWWUhbPAHqjLPx5ecgur73W/Pt2svN7xmROfOFtf/VwuSDh9rNuAThCKr9skWAy
        9y9U0tlO6dEwYZxzb1/q8f8lGNMacSfKXYEje6PNqK0dHEYW7gV7dYUdUdOlto/yX5zkl+4I04M68
        oqjqCB4qQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g0p4y-0001of-IP; Fri, 14 Sep 2018 14:28:18 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 76DEF202C1A2E; Fri, 14 Sep 2018 16:28:13 +0200 (CEST)
Date:   Fri, 14 Sep 2018 16:28:13 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Patrick Bellasi <patrick.bellasi@arm.com>
Cc:     Juri Lelli <juri.lelli@redhat.com>, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Tejun Heo <tj@kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Paul Turner <pjt@google.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Todd Kjos <tkjos@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Steve Muckle <smuckle@google.com>,
        Suren Baghdasaryan <surenb@google.com>
Subject: Re: [PATCH v4 14/16] sched/core: uclamp: request CAP_SYS_ADMIN by
 default
Message-ID: <20180914142813.GM24124@hirez.programming.kicks-ass.net>
References: <20180828135324.21976-1-patrick.bellasi@arm.com>
 <20180828135324.21976-15-patrick.bellasi@arm.com>
 <20180904134748.GA4974@localhost.localdomain>
 <20180906144053.GD25636@e110439-lin>
 <20180914111003.GC24082@hirez.programming.kicks-ass.net>
 <20180914140732.GR1413@e110439-lin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180914140732.GR1413@e110439-lin>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Just a quick reply because I have to run..

On Fri, Sep 14, 2018 at 03:07:32PM +0100, Patrick Bellasi wrote:
> On 14-Sep 13:10, Peter Zijlstra wrote:

> > I think the problem here is that the two are conflated in the very same
> > interface.
> > 
> > Would it make sense to move the available clamp values out to some sysfs
> > interface like thing and guard that with a capability, while keeping the
> > task interface unprivilidged?
> 
> You mean something like:
> 
>    $ cat /proc/sys/kernel/sched_uclamp_min_utils
>    0 10 20 ... 100
> 
> to notify users about the set of clamp values which are available ?
> 
> > Another thing that has me 'worried' about this interface is the direct
> > tie to CPU capacity (not that I have a better suggestion). But it does
> > raise the point of how userspace is going to discover the relevant
> > values of the platform.
> 
> This point worries me too, and that's what I think is addressed in a
> sane way in:
> 
>    [PATCH v4 13/16] sched/core: uclamp: use percentage clamp values
>    https://lore.kernel.org/lkml/20180828135324.21976-14-patrick.bellasi@arm.com/
> 
> IMHO percentages are a reasonably safe and generic API to expose to
> user-space. Don't you think this should address your concern above ?

Not at all what I meant, and no, percentages don't help.

The thing is, the values you'd want to use are for example the capacity
of the little CPUs. or the capacity of the most energy efficient OPP
(the knee).

Similarly for boosting, how are we 'easily' going to find the values
that correspond to the various available OPPs.

The EAS thing might have these around; but I forgot if/how they're
exposed to userspace (I'll have to soon look at the latest posting).

But changing the clamp metric to something different than these values
is going to be pain.
