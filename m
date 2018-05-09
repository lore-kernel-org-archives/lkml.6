Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965835AbeEIWiJ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 18:38:09 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:44502 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965426AbeEIWiH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 18:38:07 -0400
Date: Wed, 9 May 2018 15:38:05 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Roman Gushchin <guro@fb.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>,
        Michal Hocko <mhocko@suse.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>, Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v3 2/2] mm: ignore memory.min of abandoned memory
 cgroups
Message-Id: <20180509153805.2a940eac8c858398fb0f4b0c@linux-foundation.org>
In-Reply-To: <20180509180734.GA4856@castle.DHCP.thefacebook.com>
References: <20180503114358.7952-1-guro@fb.com>
        <20180503114358.7952-2-guro@fb.com>
        <20180503173835.GA28437@cmpxchg.org>
        <20180509180734.GA4856@castle.DHCP.thefacebook.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> Memory controller implements the memory.low best-effort memory
> protection mechanism, which works perfectly in many cases and
> allows protecting working sets of important workloads from
> sudden reclaim.
> 
> But its semantics has a significant limitation: it works
> only as long as there is a supply of reclaimable memory.
> This makes it pretty useless against any sort of slow memory
> leaks or memory usage increases. This is especially true
> for swapless systems. If swap is enabled, memory soft protection
> effectively postpones problems, allowing a leaking application
> to fill all swap area, which makes no sense.
> The only effective way to guarantee the memory protection
> in this case is to invoke the OOM killer.
> 
> It's possible to handle this case in userspace by reacting
> on MEMCG_LOW events; but there is still a place for a fail-safe
> in-kernel mechanism to provide stronger guarantees.
> 
> This patch introduces the memory.min interface for cgroup v2
> memory controller. It works very similarly to memory.low
> (sharing the same hierarchical behavior), except that it's
> not disabled if there is no more reclaimable memory in the system.
> 
> If cgroup is not populated, its memory.min is ignored,
> because otherwise even the OOM killer wouldn't be able
> to reclaim the protected memory, and the system can stall.
> 
> ...
>
> --- a/Documentation/cgroup-v2.txt
> +++ b/Documentation/cgroup-v2.txt
> @@ -1002,6 +1002,29 @@ PAGE_SIZE multiple when read back.
>  	The total amount of memory currently being used by the cgroup
>  	and its descendants.
>  
> +  memory.min
> +	A read-write single value file which exists on non-root
> +	cgroups.  The default is "0".
> +
> +	Hard memory protection.  If the memory usage of a cgroup
> +	is within its effective min boundary, the cgroup's memory
> +	won't be reclaimed under any conditions. If there is no
> +	unprotected reclaimable memory available, OOM killer
> +	is invoked.
> +
> +	Effective low boundary is limited by memory.min values of
> +	all ancestor cgroups. If there is memory.min overcommitment
> +	(child cgroup or cgroups are requiring more protected memory
> +	than parent will allow), then each child cgroup will get
> +	the part of parent's protection proportional to its
> +	actual memory usage below memory.min.
> +
> +	Putting more memory than generally available under this
> +	protection is discouraged and may lead to constant OOMs.
> +
> +	If a memory cgroup is not populated with processes,
> +	its memory.min is ignored.

This is a copy-paste-edit of the memory.low description.  Could we
please carefully check that it all remains accurate?  Should "Effective
low boundary" be "Effective min boundary"?  Does overcommit still apply
to .min?  etcetera.
