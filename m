Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6053DC282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 15:12:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D064218AE
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 15:12:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="uc1/uLVX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728386AbfAXPMg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 10:12:36 -0500
Received: from merlin.infradead.org ([205.233.59.134]:55800 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727996AbfAXPMf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 10:12:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=p3DLEMwl1y2+AhetxSrpIUDwy+GX3h7Gw1uvn5TEME0=; b=uc1/uLVXqhz4xsQJHbnjlKkRS
        4/2VIRZ4DC8I3jAt5ARNIxiRJTv/n0aySuDt4Cs5j1ij0ZPI2nQAYKNVGg5R9+z/vSLkhvFrWlDrN
        ZY9ODMax+QPxudQsBLZvR5oO7IyWNOwX3mENFl3T7l/lAfPj2GJfce46Og4bo5Z/F+EZ2x2FxLUwg
        oq1psaP8meBkQDQRNOLvH4v2o5FaDTWX5pC+GQev2bfyW82YkLtq3xeIdjCo2GVK+vDNE/1T/RwS2
        tdAa3fld7Ytq0e2QaQ+PKmLeINmtCFUFfLt5ICKSCZ4rmmSmbhqPLMm4AOPNS0o3PoLGusdvcUW8q
        b63KfoH4g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gmgfu-00046Z-K2; Thu, 24 Jan 2019 15:12:14 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 22198238BB05C; Thu, 24 Jan 2019 16:12:12 +0100 (CET)
Date:   Thu, 24 Jan 2019 16:12:12 +0100
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
Message-ID: <20190124151212.GO13777@hirez.programming.kicks-ass.net>
References: <20190115101513.2822-1-patrick.bellasi@arm.com>
 <20190115101513.2822-10-patrick.bellasi@arm.com>
 <20190123104944.GX27931@hirez.programming.kicks-ass.net>
 <20190123144011.iid3avb63r5v4r2c@e110439-lin>
 <20190123201146.GH17749@hirez.programming.kicks-ass.net>
 <20190124123009.2yulcf25ld66popd@e110439-lin>
 <20190124123835.nliwk2onvrhe5aqf@e110439-lin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190124123835.nliwk2onvrhe5aqf@e110439-lin>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 24, 2019 at 12:38:35PM +0000, Patrick Bellasi wrote:
> On 24-Jan 12:30, Patrick Bellasi wrote:
> > On 23-Jan 21:11, Peter Zijlstra wrote:
> > > On Wed, Jan 23, 2019 at 02:40:11PM +0000, Patrick Bellasi wrote:
> > > > On 23-Jan 11:49, Peter Zijlstra wrote:
> > > > > On Tue, Jan 15, 2019 at 10:15:06AM +0000, Patrick Bellasi wrote:
> 
> [...]
> 
> > > I'm thikning that if we haz a single bit, say:
> > > 
> > >   struct uclamp_se {
> > > 	...
> > > 	unsigned int	changed : 1;
> > >   };
> > > 
> > > We can update uclamp_se::value and set uclamp_se::changed, and then the
> > > next enqueue will (unlikely) test-and-clear changed and recompute the
> > > bucket_id.
> > 
> > This mean will lazy update the "requested" bucket_id by deferring its
> > computation at enqueue time. Which saves us a copy of the bucket_id,
> > i.e. we will have only the "effective" value updated at enqueue time.
> > 
> > But...
> > 
> > > Would that not be simpler?
> > 
> > ... although being simpler it does not fully exploit the slow-path,
> > a syscall which is usually running from a different process context
> > (system management software).
> > 
> > It also fits better for lazy updates but, in the cgroup case, where we
> > wanna enforce an update ASAP for RUNNABLE tasks, we will still have to
> > do the updates from the slow-path.
> > 
> > Will look better into this simplification while working on v7, perhaps
> > the linear mapping can really help in that too.
> 
> Actually, I forgot to mention that:
> 
>     uclamp_se::effective::{
>         value, bucket_id
>     }
> 
> will be still required to proper support the cgroup delegation model,
> where a child group could be restricted by the parent but we want to
> keep track of the original "requested" value for when the parent
> should relax the restriction.
> 
> Thus, since effective values are already there, why not using them
> also to pre-compute the new requested bucket_id from the slow path?

Well, we need the orig_value; but I'm still not sure why you need more
bucket_id's. Also, retaining orig_value is already required for the
system limits, there's nothing cgroup-y about this afaict.
