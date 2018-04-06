Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752105AbeDFQLu (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 12:11:50 -0400
Received: from mx2.suse.de ([195.135.220.15]:35845 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751754AbeDFQLt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 12:11:49 -0400
Date: Fri, 6 Apr 2018 18:11:46 +0200
From: Michal Hocko <mhocko@kernel.org>
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] mm: memcg: make sure memory.events is uptodate when
 waking pollers fix
Message-ID: <20180406161146.GN8286@dhcp22.suse.cz>
References: <20180406145330.4d166464@canb.auug.org.au>
 <20180406155441.GA20806@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180406155441.GA20806@cmpxchg.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 06-04-18 11:54:41, Johannes Weiner wrote:
> On Fri, Apr 06, 2018 at 02:53:30PM +1000, Stephen Rothwell wrote:
> > Hi Andrew,
> > 
> > After merging the akpm-current tree, today's linux-next build (x86_64
> > allmodconfig) produced this warning:
> > 
> > mm/memcontrol.c: In function 'memory_events_show':
> > mm/memcontrol.c:5453:23: warning: array subscript is above array bounds [-Warray-bounds]
> >       atomic_long_read(&memcg->memory_events[OOM_KILL]));
> >                        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > 
> > Introduced by commit
> > 
> >   725844c87a0d ("mm: memcg: make sure memory.events is uptodate when waking pollers")
> 
> Ah, silly, I missed that warning. The below fixes it.
> 
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> ---
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 04ea2b104ee2..9bac6dc26e09 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -5199,8 +5199,7 @@ static int memory_events_show(struct seq_file *m, void *v)
>  		   atomic_long_read(&memcg->memory_events[MEMCG_MAX]));
>  	seq_printf(m, "oom %lu\n",
>  		   atomic_long_read(&memcg->memory_events[MEMCG_OOM]));
> -	seq_printf(m, "oom_kill %lu\n",
> -		   atomic_long_read(&memcg->memory_events[OOM_KILL]));
> +	seq_printf(m, "oom_kill %lu\n", memcg_sum_events(memcg, OOM_KILL));

Ohh, this is so easy to miss.

-- 
Michal Hocko
SUSE Labs
