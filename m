Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71375C282CD
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 19:54:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48ED22087F
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 19:54:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727166AbfA1Ty1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 14:54:27 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:46434 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726766AbfA1Ty1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 14:54:27 -0500
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 103181AE5;
        Mon, 28 Jan 2019 19:54:25 +0000 (UTC)
Date:   Mon, 28 Jan 2019 11:54:24 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Rik van Riel <riel@surriel.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        kernel-team@fb.com, Johannes Weiner <hannes@cmpxchg.org>,
        Chris Mason <clm@fb.com>, Roman Gushchin <guro@fb.com>,
        Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH] mm,slab,vmscan: accumulate gradual pressure on small
 slabs
Message-Id: <20190128115424.df3f4647023e9e43e75afe67@linux-foundation.org>
In-Reply-To: <20190128143535.7767c397@imladris.surriel.com>
References: <20190128143535.7767c397@imladris.surriel.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Jan 2019 14:35:35 -0500 Rik van Riel <riel@surriel.com> wrote:

> There are a few issues with the way the number of slab objects to
> scan is calculated in do_shrink_slab.  First, for zero-seek slabs,
> we could leave the last object around forever. That could result
> in pinning a dying cgroup into memory, instead of reclaiming it.
> The fix for that is trivial.
> 
> Secondly, small slabs receive much more pressure, relative to their
> size, than larger slabs, due to "rounding up" the minimum number of
> scanned objects to batch_size.
> 
> We can keep the pressure on all slabs equal relative to their size
> by accumulating the scan pressure on small slabs over time, resulting
> in sometimes scanning an object, instead of always scanning several.
> 
> This results in lower system CPU use, and a lower major fault rate,
> as actively used entries from smaller caches get reclaimed less
> aggressively, and need to be reloaded/recreated less often.
> 
> Fixes: 4b85afbdacd2 ("mm: zero-seek shrinkers")
> Fixes: 172b06c32b94 ("mm: slowly shrink slabs with a relatively small number of objects")
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Chris Mason <clm@fb.com>
> Cc: Roman Gushchin <guro@fb.com>
> Cc: kernel-team@fb.com
> Tested-by: Chris Mason <clm@fb.com>

I added your Signed-off-by:

> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -488,18 +488,28 @@ static unsigned long do_shrink_slab(struct shrink_control *shrinkctl,
>  		 * them aggressively under memory pressure to keep
>  		 * them from causing refetches in the IO caches.
>  		 */
> -		delta = freeable / 2;
> +		delta = (freeable + 1)/ 2;
>  	}
>  
>  	/*
>  	 * Make sure we apply some minimal pressure on default priority
> -	 * even on small cgroups. Stale objects are not only consuming memory
> +	 * even on small cgroups, by accumulating pressure across multiple
> +	 * slab shrinker runs. Stale objects are not only consuming memory
>  	 * by themselves, but can also hold a reference to a dying cgroup,
>  	 * preventing it from being reclaimed. A dying cgroup with all
>  	 * corresponding structures like per-cpu stats and kmem caches
>  	 * can be really big, so it may lead to a significant waste of memory.
>  	 */
> -	delta = max_t(unsigned long long, delta, min(freeable, batch_size));
> +	if (!delta) {
> +		shrinker->small_scan += freeable;
> +
> +		delta = shrinker->small_scan >> priority;
> +		shrinker->small_scan -= delta << priority;
> +
> +		delta *= 4;
> +		do_div(delta, shrinker->seeks);

What prevents shrinker->small_scan from over- or underflowing over time?

> +	}
>  
>  	total_scan += delta;
>  	if (total_scan < 0) {

I'll add this:





whitespace fixes, per Roman

--- a/mm/vmscan.c~mmslabvmscan-accumulate-gradual-pressure-on-small-slabs-fix
+++ a/mm/vmscan.c
@@ -488,7 +488,7 @@ static unsigned long do_shrink_slab(stru
 		 * them aggressively under memory pressure to keep
 		 * them from causing refetches in the IO caches.
 		 */
-		delta = (freeable + 1)/ 2;
+		delta = (freeable + 1) / 2;
 	}
 
 	/*
@@ -508,7 +508,6 @@ static unsigned long do_shrink_slab(stru
 
 		delta *= 4;
 		do_div(delta, shrinker->seeks);
-
 	}
 
 	total_scan += delta;
_

