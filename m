Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753449AbeDTRBX (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 13:01:23 -0400
Received: from merlin.infradead.org ([205.233.59.134]:54682 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753158AbeDTRBW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 13:01:22 -0400
Subject: Re: [PATCH 1/2] mm: introduce memory.min
To: Roman Gushchin <guro@fb.com>, linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        kernel-team@fb.com, Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>, Tejun Heo <tj@kernel.org>
References: <20180420163632.3978-1-guro@fb.com>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <527af98a-8d7f-42ab-9ba8-71444ef7e25f@infradead.org>
Date: Fri, 20 Apr 2018 10:01:04 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180420163632.3978-1-guro@fb.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/20/18 09:36, Roman Gushchin wrote:

> ---
>  Documentation/cgroup-v2.txt  | 20 +++++++++
>  include/linux/memcontrol.h   | 15 ++++++-
>  include/linux/page_counter.h | 11 ++++-
>  mm/memcontrol.c              | 99 ++++++++++++++++++++++++++++++++++++--------
>  mm/page_counter.c            | 63 ++++++++++++++++++++--------
>  mm/vmscan.c                  | 19 ++++++++-
>  6 files changed, 189 insertions(+), 38 deletions(-)
> 
> diff --git a/Documentation/cgroup-v2.txt b/Documentation/cgroup-v2.txt
> index 657fe1769c75..49c846020f96 100644
> --- a/Documentation/cgroup-v2.txt
> +++ b/Documentation/cgroup-v2.txt
> @@ -1002,6 +1002,26 @@ PAGE_SIZE multiple when read back.
>  	The total amount of memory currently being used by the cgroup
>  	and its descendants.
>  
> +  memory.min
> +	A read-write single value file which exists on non-root
> +	cgroups.  The default is "0".
> +
> +	Hard memory protection.  If the memory usage of a cgroup
> +	is within its effectife min boundary, the cgroup's memory

	              effective

> +	won't be reclaimed under any conditions. If there is no
> +	unprotected reclaimable memory available, OOM killer
> +	is invoked.
> +
> +	Effective low boundary is limited by memory.min values of
> +	all ancestor cgroups. If there is memory.mn overcommitment

	                                  memory.min ? overcommit

> +	(child cgroup or cgroups are requiring more protected memory,

	                                          drop ending ','  ^^

> +	than parent will allow), then each child cgroup will get
> +	the part of parent's protection proportional to the its

	                                             to its

> +	actual memory usage below memory.min.
> +
> +	Putting more memory than generally available under this
> +	protection is discouraged and may lead to constant OOMs.
> +
>    memory.low
>  	A read-write single value file which exists on non-root
>  	cgroups.  The default is "0".


-- 
~Randy
