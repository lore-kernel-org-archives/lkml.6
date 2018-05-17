Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752014AbeEQEQl (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 00:16:41 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:37950 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751595AbeEQEQj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 00:16:39 -0400
X-Google-Smtp-Source: AB8JxZrsiYF2MzKUW7yOoI3OLoumwiHJUlgV7eghEPNOTiOcwyCBQJcybKzZr5HLq5iiegm7rD3HRA==
Date: Thu, 17 May 2018 07:16:34 +0300
From: Vladimir Davydov <vdavydov.dev@gmail.com>
To: Kirill Tkhai <ktkhai@virtuozzo.com>
Cc: akpm@linux-foundation.org, shakeelb@google.com,
        viro@zeniv.linux.org.uk, hannes@cmpxchg.org, mhocko@kernel.org,
        tglx@linutronix.de, pombredanne@nexb.com, stummala@codeaurora.org,
        gregkh@linuxfoundation.org, sfr@canb.auug.org.au, guro@fb.com,
        mka@chromium.org, penguin-kernel@I-love.SAKURA.ne.jp,
        chris@chris-wilson.co.uk, longman@redhat.com, minchan@kernel.org,
        ying.huang@intel.com, mgorman@techsingularity.net, jbacik@fb.com,
        linux@roeck-us.net, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        willy@infradead.org, lirongqing@baidu.com, aryabinin@virtuozzo.com
Subject: Re: [PATCH v5 11/13] mm: Iterate only over charged shrinkers during
 memcg shrink_slab()
Message-ID: <20180517041634.lgkym6gdctya3oq6@esperanza>
References: <152594582808.22949.8353313986092337675.stgit@localhost.localdomain>
 <152594603565.22949.12428911301395699065.stgit@localhost.localdomain>
 <20180515054445.nhe4zigtelkois4p@esperanza>
 <5c0dbd12-8100-61a2-34fd-8878c57195a3@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5c0dbd12-8100-61a2-34fd-8878c57195a3@virtuozzo.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 15, 2018 at 05:49:59PM +0300, Kirill Tkhai wrote:
> >> @@ -589,13 +647,7 @@ static unsigned long shrink_slab(gfp_t gfp_mask, int nid,
> >>  			.memcg = memcg,
> >>  		};
> >>  
> >> -		/*
> >> -		 * If kernel memory accounting is disabled, we ignore
> >> -		 * SHRINKER_MEMCG_AWARE flag and call all shrinkers
> >> -		 * passing NULL for memcg.
> >> -		 */
> >> -		if (memcg_kmem_enabled() &&
> >> -		    !!memcg != !!(shrinker->flags & SHRINKER_MEMCG_AWARE))
> >> +		if (!!memcg != !!(shrinker->flags & SHRINKER_MEMCG_AWARE))
> >>  			continue;
> > 
> > I want this check gone. It's easy to achieve, actually - just remove the
> > following lines from shrink_node()
> > 
> > 		if (global_reclaim(sc))
> > 			shrink_slab(sc->gfp_mask, pgdat->node_id, NULL,
> > 				    sc->priority);
> 
> This check is not related to the patchset.

Yes, it is. This patch modifies shrink_slab which is used only by
shrink_node. Simplifying shrink_node along the way looks right to me.

> Let's don't mix everything in the single series of patches, because
> after your last remarks it will grow at least up to 15 patches.

Most of which are trivial so I don't see any problem here.

> This patchset can't be responsible for everything.

I don't understand why you balk at simplifying the code a bit while you
are patching related functions anyway.

> 
> >>  
> >>  		if (!(shrinker->flags & SHRINKER_NUMA_AWARE))
> >>
