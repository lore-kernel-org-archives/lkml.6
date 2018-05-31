Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754121AbeEaIlp (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 04:41:45 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:41745 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754046AbeEaIlj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 04:41:39 -0400
X-Google-Smtp-Source: ADUXVKI3xYUetrHjfusQDohYG0knYSgHy9zXELSZy2xDyO/phYZP2uYsiyXHdbJgYNlD+294i8iPrg==
Date: Thu, 31 May 2018 10:41:34 +0200
From: Juri Lelli <juri.lelli@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Zefan Li <lizefan@huawei.com>, Waiman Long <longman@redhat.com>,
        Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
        Ingo Molnar <mingo@redhat.com>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        kernel-team@fb.com, pjt@google.com, luto@amacapital.net,
        Mike Galbraith <efault@gmx.de>, torvalds@linux-foundation.org,
        Roman Gushchin <guro@fb.com>,
        Patrick Bellasi <patrick.bellasi@arm.com>
Subject: Re: [PATCH] cpuset: Enforce that a child's cpus must be a subset of
 the parent
Message-ID: <20180531084134.GA17937@localhost.localdomain>
References: <1527687991-1431-1-git-send-email-longman@redhat.com>
 <5B0F4F09.9050100@huawei.com>
 <5B0FAE72.1090204@huawei.com>
 <20180531082613.GF12180@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180531082613.GF12180@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/05/18 10:26, Peter Zijlstra wrote:
> On Thu, May 31, 2018 at 04:12:34PM +0800, Zefan Li wrote:
> > On 2018/5/31 9:25, Zefan Li wrote:
> > > Hi Waiman,
> > > 
> > > On 2018/5/30 21:46, Waiman Long wrote:
> > >> It was found that the cpuset.cpus could contain CPUs that are not listed
> > >> in their parent's cpu list as shown by the command sequence below:
> > >>
> > >>   # echo "+cpuset" >cgroup.subtree_control
> > >>   # mkdir g1
> > >>   # echo 0-5 >g1/cpuset.cpus
> > >>   # mkdir g1/g11
> > >>   # echo "+cpuset" > g1/cgroup.subtree_control
> > >>   # echo 6-11 >g1/g11/cpuset.cpus
> > >>   # grep -R . g1 | grep "\.cpus"
> > >>   g1/cpuset.cpus:0-5
> > >>   g1/cpuset.cpus.effective:0-5
> > >>   g1/g11/cpuset.cpus:6-11
> > >>   g1/g11/cpuset.cpus.effective:0-5
> > >>
> > >> As the intersection of g11's cpus and that of g1 is empty, the effective
> > >> cpus of g11 is just that of g1. The check in update_cpumask() is now
> > >> corrected to make sure that cpus in a child cpus must be a subset of
> > >> its parent's cpus. The error "write error: Invalid argument" will now
> > >> be reported in the above case.
> > >>
> > > 
> > > We made the distinction between user-configured CPUs and effective CPUs
> > > in commit 7e88291beefbb758, so actually it's not a bug.
> > > 
> > 
> > I remember the original reason is to support restoration of the original
> > cpu after cpu offline->online. We use user-configured CPUs to remember
> > if the cpu should be restored in the cpuset after it's onlined.
> 
> AFAICT you can do that and still have the child a subset of the parent,
> no?

Plus this is not hotplug, but a user decision. It could make sense to
keep .cpus unmodified after hotplug events, but does it make sense to
let the user be able to choose cpus outside the parent domain?
