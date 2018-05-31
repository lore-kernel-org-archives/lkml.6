Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755699AbeEaQik (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 12:38:40 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:52284 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755562AbeEaQii (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 12:38:38 -0400
Date: Thu, 31 May 2018 18:38:26 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Tejun Heo <tj@kernel.org>
Cc: Waiman Long <longman@redhat.com>, Zefan Li <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>, Ingo Molnar <mingo@redhat.com>,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, kernel-team@fb.com, pjt@google.com,
        luto@amacapital.net, Mike Galbraith <efault@gmx.de>,
        torvalds@linux-foundation.org, Roman Gushchin <guro@fb.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Patrick Bellasi <patrick.bellasi@arm.com>
Subject: Re: [PATCH] cpuset: Enforce that a child's cpus must be a subset of
 the parent
Message-ID: <20180531163826.GO12180@hirez.programming.kicks-ass.net>
References: <1527687991-1431-1-git-send-email-longman@redhat.com>
 <5B0F4F09.9050100@huawei.com>
 <5B0FAE72.1090204@huawei.com>
 <20180531082613.GF12180@hirez.programming.kicks-ass.net>
 <5B0FB58C.9030705@huawei.com>
 <4dc718bc-4bd5-4998-853b-9c6ba67b89a0@redhat.com>
 <20180531155807.GU1351649@devbig577.frc2.facebook.com>
 <20180531161645.GN12180@hirez.programming.kicks-ass.net>
 <20180531161942.GW1351649@devbig577.frc2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180531161942.GW1351649@devbig577.frc2.facebook.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 31, 2018 at 09:19:42AM -0700, Tejun Heo wrote:
> Hello,
> 
> On Thu, May 31, 2018 at 06:16:45PM +0200, Peter Zijlstra wrote:
> > > So, let's please stay away from it even if that means a bit of
> > > overhead in terms of interface.
> > 
> > Urgh, that again :/
> 
> Yeah, well, it's pretty important.
> 
> > I'm still not convinced by your arguments though. The root container can
> > access all the sub-groups anyway and can grub around in them to take
> > away resources if it really wants to.
> 
> That's really messy and if you delegated away a subtree, you can't
> walk the subtree in a race free way, not easily anyway.

Messy perhaps, but taking away resources you gave out earlier isn't
particularly nice either way around.

Not sure the races matter, if you win, the delegate can't undo it, if
you loose, you try again until you win.

It's not like cgroup stuff gets changed often, so a conflict causing you
to loose should be very rare indeed.

> > For cpuset in particular randomly restricting on the ancestor level can
> > create an unrecoverable trainwreck inside a container. Affinities are
> > not recoverable. Once a runnable task ends up with an empty set, its
> > affinities are reset and the smaller (empty) set is lost.
> 
> Yeah, for cpuset, it's messier, but it isn't different from hotunplug
> scenario, right?  I think the best we can do there is putting ancestor
> operation on an equal footing as hotplug ops.

Right, but hotplug is exceedingly rare, while I get the impression you
think it is perfectly fine to recind on your resource grants.
