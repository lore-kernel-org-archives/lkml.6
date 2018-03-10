Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932998AbeCJNRC (ORCPT <rfc822;w@1wt.eu>);
        Sat, 10 Mar 2018 08:17:02 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:39844 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932130AbeCJNQ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Mar 2018 08:16:59 -0500
Date: Sat, 10 Mar 2018 14:16:47 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Waiman Long <longman@redhat.com>
Cc: Mike Galbraith <efault@gmx.de>, Tejun Heo <tj@kernel.org>,
        Li Zefan <lizefan@huawei.com>, Johannes Weiner <hannes@cmpxchg.org>,
        Ingo Molnar <mingo@redhat.com>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        kernel-team@fb.com, pjt@google.com, luto@amacapital.net,
        torvalds@linux-foundation.org, Roman Gushchin <guro@fb.com>
Subject: Re: [PATCH v4] cpuset: Enable cpuset controller in default hierarchy
Message-ID: <20180310131647.GB4043@hirez.programming.kicks-ass.net>
References: <1520609707-16582-1-git-send-email-longman@redhat.com>
 <1520613285.12489.36.camel@gmx.de>
 <1c3fe7b0-2600-c46d-1527-d3aaf024bb91@redhat.com>
 <1520619426.27998.18.camel@gmx.de>
 <55809fe4-98ba-5566-86ed-457acfef0e1c@redhat.com>
 <1520624424.27998.76.camel@gmx.de>
 <53de9683-01b7-bac4-8b70-dc1f93ede600@redhat.com>
 <20180309221736.GB5926@hirez.programming.kicks-ass.net>
 <f0fca497-e4e7-3dbd-1e5c-a7f502c05dcb@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f0fca497-e4e7-3dbd-1e5c-a7f502c05dcb@redhat.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 09, 2018 at 06:06:29PM -0500, Waiman Long wrote:
> So you are talking about sched_relax_domain_level and

That one I wouldn't be sad to see the back of.

> sched_load_balance.

This one, that's critical. And this is the perfect time to try and fix
the whole isolcpus issue.

The primary issue is that to make equivalent functionality available
through cpuset, we need to basically start all tasks outside the root
group.

The equivalent of isolcpus=xxx is a cgroup setup like:

        root
	/  \
  system    other

Where other has the @xxx cpus and system the remainder and
root.sched_load_balance = 0.

Back before cgroups (and the new workqueue stuff), we could've started
everything in the !root group, no worry. But now that doesn't work,
because a bunch of controllers can't deal with that and everything
cgroup expects the cgroupfs to be empty on boot.

It's one of my biggest regrets that I didn't 'fix' this before cgroups
came along.

> I have not removed any bits. I just haven't exposed
> them yet. It does seem like these 2 control knobs are useful from the
> scheduling perspective. Do we also need cpu_exclusive or just the two
> sched control knobs are enough?

I always forget if we need exclusive for load_balance to work; I'll
peruse the document/code.
