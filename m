Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753915AbeBLTO4 convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 14:14:56 -0500
Received: from mout.gmx.net ([212.227.15.15]:47605 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752972AbeBLTOy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 14:14:54 -0500
Message-ID: <1518462889.7104.78.camel@gmx.de>
Subject: Re: [PATCH 3/4] sched/fair: Do not migrate on wake_affine_weight if
 weights are equal
From: Mike Galbraith <efault@gmx.de>
To: Peter Zijlstra <peterz@infradead.org>,
        Mel Gorman <mgorman@techsingularity.net>
Cc: Matt Fleming <matt@codeblueprint.co.uk>,
        LKML <linux-kernel@vger.kernel.org>
Date: Mon, 12 Feb 2018 20:14:49 +0100
In-Reply-To: <20180212172926.GY25201@hirez.programming.kicks-ass.net>
References: <20180212145857.8056-1-mgorman@techsingularity.net>
         <20180212145857.8056-4-mgorman@techsingularity.net>
         <20180212172926.GY25201@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.20.5 
Mime-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-Provags-ID: V03:K0:4XU3C0IQrIcGRD6EMQIQiHFUOz4oFN4LvvcsXyXg42fzg84sRFe
 sOwPQZ1TZO9QQsXLQLRqJ/4VwlR00ix1nEdBqWgZbhQcyNdA49iSVb6mcnhwWYV2AlNB/FB
 eBt0+WkfySccbz7vqbweRwdVjuXBGqta1x3BaRaGFmixxFRjQva0XPOKVCGeG1SJe0Ibt7n
 oy/AY7qf+GpJUaaOM3sMA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:hJwS760XKns=:wE+/bWa0rdSJyki4Yfbx1U
 0noRhVFsGltDxmqsWQLxQcLK11OIwBLW0EIvubHn+XNJ2O/WE3XMHyBEV8/S6ovoXa7jTO6v1
 UE35+OHnr83+YrO+u9EnKb6QWU/MLWlxz+3gb2NWNl1zPbZkMH8v/JoqbUc9frvpu/vLLyhCW
 jQtb3raWMXNtCtmEBMXpD7bxDGay4jTboAcVVLFktyH/QwT7TBflBfuN5YMOVK8SbQoLzDmMd
 EJu+kU8r5TpIZdNEmY6f6kjOLh1X7GaJc3OBcB5PN5S+dcLDPVredEba3HypnoaZ7RCyTCmeA
 b2qUM/tARU0N4UzM20vQaWcScxKgLNM9CUpjZCiX2GmGVHsTyOBUXXTWsfpu35Q6Fl13Ljs4Y
 aWGsxdOC5Amze9XOidvJfIe9YVCG8ToiuTw3NoVn7NsC3GDcew86E+GFa6zVKa6ueThkserZ+
 pB5NpBSIQsjOdbxxt8iZfc/ZfJynRkPIuTQwl/ilSQkL4vK2PTTQyPB9IGcQh+9mHBJ0COZQ9
 KSNcZJFA89sH98SzgpUVZ1FxudalCj9n7nKN9QUZAXLkKc0jU9C1nNg/GaZ7qp4BGLdD2/LoC
 2Mda0fVwyRs11uPBVe6tlTTEvATRqF0ZHorKWLT11LtrZq0l5xcC+sm64wtbNUMcD8sv1jUef
 Je4JnyhdyilQYo79kZzqjAG/L2itTCi+2lS2SmTrbTkwpusdvCqP+VhNj0l/EfD+apk7N3M+b
 1F9v+/aHTQRK0wf973aqvFFQv6QjJE4hue1sfRp8+EG1yOeT0PtluBI+0ydasLgHO0+oEMiXM
 eec4A0Sz6paTF5jEKP/hBayXMufeH1EAbfoGQaZ1LO4Bdf6pbw=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-02-12 at 18:29 +0100, Peter Zijlstra wrote:
> On Mon, Feb 12, 2018 at 02:58:56PM +0000, Mel Gorman wrote:
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index c1091cb023c4..28c8d9c91955 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -5747,7 +5747,16 @@ wake_affine_weight(struct sched_domain *sd, struct task_struct *p,
> >  		prev_eff_load *= 100 + (sd->imbalance_pct - 100) / 2;
> >  	prev_eff_load *= capacity_of(this_cpu);
> >  
> > -	return this_eff_load <= prev_eff_load ? this_cpu : nr_cpumask_bits;
> > +	/*
> > +	 * If sync, adjust the weight of prev_eff_load such that if
> > +	 * prev_eff == this_eff that select_idle_sibling will consider
> > +	 * stacking the wakee on top of the waker if no other CPU is
> > +	 * idle.
> > +	 */
> > +	if (sync)
> > +		prev_eff_load += 1;
> 
> So where we had <= and would consistently favour pulling the task to the
> waking CPU when all else what equal, you now switch to <, such that when
> things are equal we do not pull.
> 
> That makes sense I suppose.
> 
> Except for sync wakeups, where you say, if everything else is equal,
> pull, which also makes sense, because sync says 'current' promises to go
> away.
> 
> OK.

Tasks tend to not honor that promise.. a lot.  Even if the sync hint
were a golden promise, it wouldn't be bullet proof: migrating a compute
hog based on a single "phoned home" wakeup remains a bad idea whether
schedule() is called immediately after the wakeup or not.  It's a pain,
only useful informational content is "this is a communication wakeup".

	-Mike
