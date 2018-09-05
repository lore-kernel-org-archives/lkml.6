Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59664C43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 20:51:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11B962073D
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 20:51:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11B962073D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727714AbeIFBXs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 21:23:48 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:53552 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727234AbeIFBXs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 21:23:48 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 99F47D16;
        Wed,  5 Sep 2018 20:51:53 +0000 (UTC)
Date:   Wed, 5 Sep 2018 13:51:52 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Roman Gushchin <guro@fb.com>
Cc:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <kernel-team@fb.com>, Rik van Riel <riel@surriel.com>,
        Josef Bacik <jbacik@fb.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [PATCH v2] mm: slowly shrink slabs with a relatively small
 number of objects
Message-Id: <20180905135152.1238c7103b2ecd6da206733c@linux-foundation.org>
In-Reply-To: <20180904224707.10356-1-guro@fb.com>
References: <20180904224707.10356-1-guro@fb.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Sep 2018 15:47:07 -0700 Roman Gushchin <guro@fb.com> wrote:

> Commit 9092c71bb724 ("mm: use sc->priority for slab shrink targets")
> changed the way how the target slab pressure is calculated and
> made it priority-based:
> 
>     delta = freeable >> priority;
>     delta *= 4;
>     do_div(delta, shrinker->seeks);
> 
> The problem is that on a default priority (which is 12) no pressure
> is applied at all, if the number of potentially reclaimable objects
> is less than 4096 (1<<12).
> 
> This causes the last objects on slab caches of no longer used cgroups
> to never get reclaimed, resulting in dead cgroups staying around forever.

But this problem pertains to all types of objects, not just the cgroup
cache, yes?

> Slab LRU lists are reparented on memcg offlining, but corresponding
> objects are still holding a reference to the dying cgroup.
> If we don't scan them at all, the dying cgroup can't go away.
> Most likely, the parent cgroup hasn't any directly associated objects,
> only remaining objects from dying children cgroups. So it can easily
> hold a reference to hundreds of dying cgroups.
> 
> If there are no big spikes in memory pressure, and new memory cgroups
> are created and destroyed periodically, this causes the number of
> dying cgroups grow steadily, causing a slow-ish and hard-to-detect
> memory "leak". It's not a real leak, as the memory can be eventually
> reclaimed, but it could not happen in a real life at all. I've seen
> hosts with a steadily climbing number of dying cgroups, which doesn't
> show any signs of a decline in months, despite the host is loaded
> with a production workload.
> 
> It is an obvious waste of memory, and to prevent it, let's apply
> a minimal pressure even on small shrinker lists. E.g. if there are
> freeable objects, let's scan at least min(freeable, scan_batch)
> objects.
> 
> This fix significantly improves a chance of a dying cgroup to be
> reclaimed, and together with some previous patches stops the steady
> growth of the dying cgroups number on some of our hosts.
> 
> ...
>
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -476,6 +476,17 @@ static unsigned long do_shrink_slab(struct shrink_control *shrinkctl,
>  	delta = freeable >> priority;
>  	delta *= 4;
>  	do_div(delta, shrinker->seeks);
> +
> +	/*
> +	 * Make sure we apply some minimal pressure even on
> +	 * small cgroups. This is necessary because some of
> +	 * belonging objects can hold a reference to a dying
> +	 * child cgroup. If we don't scan them, the dying
> +	 * cgroup can't go away unless the memory pressure
> +	 * (and the scanning priority) raise significantly.
> +	 */
> +	delta = max(delta, min(freeable, batch_size));
> +

If so I think the comment should be cast in more general terms.  Maybe
with a final sentence "the cgroup cache is one such case".

Also, please use all 80 columns in block comments to save a few display
lines.

And `delta' has type ULL whereas the other two are longs.  We'll
presumably hit warnings here, preventable with max_t.

