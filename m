Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755647AbeEaQRJ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 12:17:09 -0400
Received: from merlin.infradead.org ([205.233.59.134]:43122 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755456AbeEaQRG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 12:17:06 -0400
Date: Thu, 31 May 2018 18:16:45 +0200
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
Message-ID: <20180531161645.GN12180@hirez.programming.kicks-ass.net>
References: <1527687991-1431-1-git-send-email-longman@redhat.com>
 <5B0F4F09.9050100@huawei.com>
 <5B0FAE72.1090204@huawei.com>
 <20180531082613.GF12180@hirez.programming.kicks-ass.net>
 <5B0FB58C.9030705@huawei.com>
 <4dc718bc-4bd5-4998-853b-9c6ba67b89a0@redhat.com>
 <20180531155807.GU1351649@devbig577.frc2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180531155807.GU1351649@devbig577.frc2.facebook.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 31, 2018 at 08:58:07AM -0700, Tejun Heo wrote:
> Tying together what's configured and what's applied may feel
> attractive on the surface but it's a long term headache.
> 
> * It's inconsistent with what other controllers are doing.  All the
>   limit resource configs declare the upper bound the specific cgroup
>   can consume regardless of what's actually available to it.  They
>   limit but don't guarantee access.
> 
> * Which decouples a given cgroup's configurations from its ancestors',
>   which allows an ancestor to take away resources that it granted
>   before and then also giving it back later.  No matter what you do,
>   if you couple configs of cgroup hierarchy, you end up restricting
>   what an ancestor can do to its sub-hierarchy, which can quickly
>   become a difficult operational headache.
> 
> So, let's please stay away from it even if that means a bit of
> overhead in terms of interface.

Urgh, that again :/

I'm still not convinced by your arguments though. The root container can
access all the sub-groups anyway and can grub around in them to take
away resources if it really wants to.

For cpuset in particular randomly restricting on the ancestor level can
create an unrecoverable trainwreck inside a container. Affinities are
not recoverable. Once a runnable task ends up with an empty set, its
affinities are reset and the smaller (empty) set is lost.
