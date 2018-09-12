Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94B03C46469
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 16:12:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F8A520880
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 16:12:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kh4TlGV0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F8A520880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728096AbeILVRp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 17:17:45 -0400
Received: from merlin.infradead.org ([205.233.59.134]:46244 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727051AbeILVRo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 17:17:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=3cMuVh7nHbWdcqVCPMDieiBkxBIqy4nedGR4N48aKJc=; b=kh4TlGV0gW4banNcPmTMp5fQN
        HwFFWzRBS4Ir2tAexNzhcuUxeVUwCjvR4PZMzGtmRNaHtRPefXnRjHWdFqVtYLmLaLZT717Wlhqr6
        37zGUlWEqzW37GLkrGLLBaE7UN0xccwIQOrLrgXl/TNMphqiFRRktRKbSqd7jAt/Bn9YLRJb03beR
        HaJj9hus8+9h96me5XqVhB4KNDXd4dqW2iJ0JCSUF80tGIz+WtPfSzTGbnEjgikEcjBtVCcq95++y
        XDIoZEIINAAI7+60xoODl/AalEmZdHWIS8yJgi+VhqbWYcW2dXknD82k2oGEj6zFbFNkeDR94V0B0
        /K9533UMw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g07ka-0003qw-1x; Wed, 12 Sep 2018 16:12:20 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 707BD202C1A09; Wed, 12 Sep 2018 18:12:18 +0200 (CEST)
Date:   Wed, 12 Sep 2018 18:12:18 +0200
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
Message-ID: <20180912161218.GW24082@hirez.programming.kicks-ass.net>
References: <20180828135324.21976-1-patrick.bellasi@arm.com>
 <20180828135324.21976-3-patrick.bellasi@arm.com>
 <20180912134945.GZ24106@hirez.programming.kicks-ass.net>
 <20180912155619.GG1413@e110439-lin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180912155619.GG1413@e110439-lin>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 12, 2018 at 04:56:19PM +0100, Patrick Bellasi wrote:
> On 12-Sep 15:49, Peter Zijlstra wrote:
> > On Tue, Aug 28, 2018 at 02:53:10PM +0100, Patrick Bellasi wrote:

> > > +/**
> > > + * uclamp_map: reference counts a utilization "clamp value"
> > > + * @value:    the utilization "clamp value" required
> > > + * @se_count: the number of scheduling entities requiring the "clamp value"
> > > + * @se_lock:  serialize reference count updates by protecting se_count
> > 
> > Why do you have a spinlock to serialize a single value? Don't we have
> > atomics for that?
> 
> There are some code paths where it's used to protect clamp groups
> mapping and initialization, e.g.
> 
>       uclamp_group_get()
>           spin_lock()
>               // initialize clamp group (if required) and then...
>               se_count += 1
>           spin_unlock()
> 
> Almost all these paths are triggered from user-space and protected
> by a global uclamp_mutex, but fork/exit paths.
> 
> To serialize these paths I'm using the spinlock above, does it make
> sense ? Can we use the global uclamp_mutex on forks/exit too ?

OK, then your comment is misleading; it serializes both fields.

> One additional observations is that, if in the future we want to add a
> kernel space API, (e.g. driver asking for a new clamp value), maybe we
> will need to have a serialized non-sleeping uclamp_group_get() API ?

No idea; but if you want to go all fancy you can replace he whole
uclamp_map thing with something like:

struct uclamp_map {
	union {
		struct {
			unsigned long v : 10;
			unsigned long c : BITS_PER_LONG - 10;
		};
		atomic_long_t s;
	};
};

And use uclamp_map::c == 0 as unused (as per normal refcount
semantics) and atomic_long_cmpxchg() the whole thing using
uclamp_map::s.

> > > + *                          uclamp_maps is a matrix of
> > > + *          +------- UCLAMP_CNT by CONFIG_UCLAMP_GROUPS_COUNT+1 entries
> > > + *          |                                |
> > > + *          |                /---------------+---------------\
> > > + *          |               +------------+       +------------+
> > > + *          |  / UCLAMP_MIN | value      |       | value      |
> > > + *          |  |            | se_count   |...... | se_count   |
> > > + *          |  |            +------------+       +------------+
> > > + *          +--+            +------------+       +------------+
> > > + *             |            | value      |       | value      |
> > > + *             \ UCLAMP_MAX | se_count   |...... | se_count   |
> > > + *                          +-----^------+       +----^-------+
> > > + *                                |                   |
> > > + *                      uc_map =  +                   |
> > > + *                     &uclamp_maps[clamp_id][0]      +
> > > + *                                                clamp_value =
> > > + *                                       uc_map[group_id].value
> > > + */
> > > +static struct uclamp_map uclamp_maps[UCLAMP_CNT]
> > > +				    [CONFIG_UCLAMP_GROUPS_COUNT + 1]
> > > +				    ____cacheline_aligned_in_smp;
> > > +
> > 
> > I'm still completely confused by all this.
> > 
> > sizeof(uclamp_map) = 12
> > 
> > that array is 2*6=12 of those, so the whole thing is 144 bytes. which is
> > more than 2 (64 byte) cachelines.
> 
> This data structure is *not* used in the hot-path, that's why I did not
> care about fitting it exactly into few cache lines.
> 
> It's used to map a user-space "clamp value" into a kernel-space "clamp
> group" when user-space:
>  - changes a task specific clamp value
>  - changes a cgroup clamp value
>  - a task forks/exits
> 
> I assume we can consider all those as "slow" code paths, is that correct ?

Yep.

> > What's the purpose of that cacheline align statement?
> 
> In uclamp_maps, we still need to scan the array when a clamp value is
> changed from user-space, i.e. the cases reported above. Thus, that
> alignment is just to ensure that we minimize the number of cache lines
> used. Does that make sense ?
> 
> Maybe that alignment implicitly generated by the compiler ?

It is not, but if it really is a slow path, we shouldn't care about
alignment.

> > Note that without that apparently superfluous lock, it would be 8*12 =
> > 96 bytes, which is 1.5 lines and would indeed suggest you default to
> > GROUP_COUNT=7 by default to fill 2 lines.
> 
> Yes, will check better if we can count on just the uclamp_mutex

Well, if we don't care about performance (slow path) then keeping he
lock is fine, just the comment and alignment are misleading.

> > Why are the min and max things torn up like that?  I'm fairly sure I
> > asked some of that last time; but the above comments only try to explain
> > what, not why.
> 
> We use that organization to speedup scanning for clamp values of the
> same clamp_id. That's more important in the hot-path than above, where
> we need to scan struct uclamp_cpu when a new aggregated clamp value
> has to be computed. This is done in:
> 
>    [PATCH v4 03/16] sched/core: uclamp: add CPU's clamp groups accounting
>    https://lore.kernel.org/lkml/20180828135324.21976-4-patrick.bellasi@arm.com/
> 
> Specifically:
> 
>    dequeue_task()
>      uclamp_cpu_put()
>        uclamp_cpu_put_id(clamp_id)
>          uclamp_cpu_update(clamp_id)
>             // Here we have an array scan by clamp_id
> 
> With the given data layout I reported above, when we update the
> min_clamp value (boost) we have all the data required in a single
> cache line.
> 
> If that makes sense, I can certainly improve the comment above to
> justify its layout.

OK, let me read on.
