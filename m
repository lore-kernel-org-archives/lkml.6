Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1425103AbeE1Mpc (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 08:45:32 -0400
Received: from merlin.infradead.org ([205.233.59.134]:46990 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1425087AbeE1MpZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 08:45:25 -0400
Date: Mon, 28 May 2018 14:45:08 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Waiman Long <longman@redhat.com>
Cc: Tejun Heo <tj@kernel.org>, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>, Ingo Molnar <mingo@redhat.com>,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, kernel-team@fb.com, pjt@google.com,
        luto@amacapital.net, Mike Galbraith <efault@gmx.de>,
        torvalds@linux-foundation.org, Roman Gushchin <guro@fb.com>,
        Juri Lelli <juri.lelli@redhat.com>
Subject: Re: [PATCH v8 3/6] cpuset: Add cpuset.sched.load_balance flag to v2
Message-ID: <20180528124508.GE3452@worktop.programming.kicks-ass.net>
References: <1526590545-3350-1-git-send-email-longman@redhat.com>
 <1526590545-3350-4-git-send-email-longman@redhat.com>
 <20180524154341.GJ12198@hirez.programming.kicks-ass.net>
 <9f547771-54e8-118e-80f7-48f99c7b0a12@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9f547771-54e8-118e-80f7-48f99c7b0a12@redhat.com>
User-Agent: Mutt/1.5.22.1 (2013-10-16)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 24, 2018 at 02:55:25PM -0400, Waiman Long wrote:
> On 05/24/2018 11:43 AM, Peter Zijlstra wrote:

> > I'm confused... why exactly do we have both domain and load_balance ?
> 
> The domain is for partitioning the CPUs only. It doesn't change the load
> balancing state. So the load_balance flag is still need to turn on and
> off load balancing.

OK, so we have to two boolean flags, giving 4 possible states. Lets just
go through them one by on:

A) domain:0 load_balance:0 -- we have no exclusive domain, but have
   load-balancing disabled across them. AFAICT this should be an invalid
   state.

B) domain:0 load_balance:1 -- we have no exclusive domain, but have
   load-balancing enabled. AFAICT this is the default state and is a
   no-op.

C) domain:1 load_balance:0 -- we have an exclusive domain, and have
   load-balancing disabled across it. This is, AFAICT, identical to
   having a bunch of sub/sibling groups each with a single CPU domain.

D) domain:1 load_balance:1 -- we have an exclusive domain, and have
   load-balancing enabled. This is a partition.

Now, I think I've overlooked the fact that load_balance==1 only really
means something when the parent's load_balance==0, but I'm not sure that
really changes anything.

So, afaict, the above only have two useful states: B and D. Which again
raises the question, why two knobs? What useful configurations does it
allow?
