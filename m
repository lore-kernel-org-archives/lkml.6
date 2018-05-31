Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754274AbeEaJuB (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 05:50:01 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:42468 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754092AbeEaJt7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 05:49:59 -0400
Date: Thu, 31 May 2018 11:49:43 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Waiman Long <longman@redhat.com>
Cc: Tejun Heo <tj@kernel.org>, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>, Ingo Molnar <mingo@redhat.com>,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, kernel-team@fb.com, pjt@google.com,
        luto@amacapital.net, Mike Galbraith <efault@gmx.de>,
        torvalds@linux-foundation.org, Roman Gushchin <guro@fb.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Patrick Bellasi <patrick.bellasi@arm.com>
Subject: Re: [PATCH v9 2/7] cpuset: Add new v2 cpuset.sched.domain_root flag
Message-ID: <20180531094943.GG12180@hirez.programming.kicks-ass.net>
References: <1527601294-3444-1-git-send-email-longman@redhat.com>
 <1527601294-3444-3-git-send-email-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1527601294-3444-3-git-send-email-longman@redhat.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 29, 2018 at 09:41:29AM -0400, Waiman Long wrote:
> +  cpuset.sched.domain_root
> +	A read-write single value file which exists on non-root
> +	cpuset-enabled cgroups.  It is a binary value flag that accepts
> +	either "0" (off) or "1" (on).  This flag is set by the parent
> +	and is not delegatable.

What does "is not delegatable" mean?

I think you used to say "is owned by the parent", which is took to mean
file ownership is that of the parent directory (..) and not of the
current (,), which is slightly odd but works.

So if you chown a cgroup to a user, that user will not be able to change
the file of it's 'root' (will actually be the root in case of
container), but it _can_ change this file for any sub-cgroups it
creates, right?

So in that respect the feature is delegatable, a container can create
sub-partitions. It just cannot change it's 'root' partition, which is
consistent with a real root.

The only inconsistently left is then that the real root does not have
the file at all, vs a container root having it, but not accessible.
