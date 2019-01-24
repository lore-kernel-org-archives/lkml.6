Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72173C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 15:33:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38343218A2
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 15:33:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BzWQhJ+P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728359AbfAXPd5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 10:33:57 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:44554 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727649AbfAXPd4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 10:33:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=WpLt4VcRsTHzzzmGG2pnpjIihvx+8RyruObT+Y0/t8Q=; b=BzWQhJ+P0f+SVyfn0/jXxNyAA
        ggTwOs9n/zJIbOYa/WGcEbT575BWfmmr/qo4sV88MkgJB6whq4V9JYFH5zpy3hhRW/lCelfFxPopJ
        sXjjhmtxQzDxgV3/dtJAEOBQrrrz1HQTOWjpdkrqpbu2tm2M7zx3ElJcEYKNhQDG7qp4wvb5tPCxe
        /Y4YShOs5gPJBL0iU5B/rNP2lWGd/gEJ4C/pISs8SdDk16dSKDpR6REzj6h7TshPue+ZyhlkNRg+9
        X24rySOzT0mVCcPWN5yCsAUprt6EcXjvdIPAkF3YOOMqzVsoZzljJNLrQ3zx80YMbnT66LciPUGjv
        GZUy2glrw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gmh0q-0003xg-IM; Thu, 24 Jan 2019 15:33:52 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1418E20D1512E; Thu, 24 Jan 2019 16:33:51 +0100 (CET)
Date:   Thu, 24 Jan 2019 16:33:51 +0100
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
Subject: Re: [PATCH v6 09/16] sched/cpufreq: uclamp: Add utilization clamping
 for RT tasks
Message-ID: <20190124153351.GR13777@hirez.programming.kicks-ass.net>
References: <20190115101513.2822-1-patrick.bellasi@arm.com>
 <20190115101513.2822-10-patrick.bellasi@arm.com>
 <20190123104944.GX27931@hirez.programming.kicks-ass.net>
 <20190123144011.iid3avb63r5v4r2c@e110439-lin>
 <20190123201146.GH17749@hirez.programming.kicks-ass.net>
 <20190124123009.2yulcf25ld66popd@e110439-lin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190124123009.2yulcf25ld66popd@e110439-lin>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 24, 2019 at 12:30:09PM +0000, Patrick Bellasi wrote:
> On 23-Jan 21:11, Peter Zijlstra wrote:

> > Anyway, once you get range composition defined; that should be something
> > like:
> > 
> > 	R_p \Compose_g R_g
> > 
> > Where R_p is the range of task-p, and R_g is the range of the g'th
> > cgroup of p (where you can make an identity between the root cgroup and
> > the system default).
> > 
> > Now; as per the other email; I think the straight forward composition:
> > 
> > struct range compose(struct range a, struct range b)
> > {
> > 	return (range){.min = clamp(a.min, b.min, b.max),
> > 	               .max = clamp(a.max, b.min, b.max), };
> > }
> 
> This composition is done in uclamp_effective_get() but it's
> slightly different, since we want to support a "nice policy" where
> tasks can always ask less then what they have got assigned.

Not sure I follow..

> Thus, from an abstract standpoint, if a task is in a cgroup:
> 
>      task.min <= R_g.min
>      task.max <= R_g.max
> 
> While, for tasks in the root cgroup system default applies and we
> enforece:
> 
>      task.min >= R_0.min
>      task.max <= R_0.max
> 
> ... where the "nice policy" is currently not more supported, but
> perhaps we can/should use the same for system defaults too.

That seems inconsistent at best.

OK, I'll go have another look. I never recognised that function for
doing that.


