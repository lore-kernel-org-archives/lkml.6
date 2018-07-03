Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFD84C6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 20:50:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9CEE2464F
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 20:50:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9CEE2464F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752965AbeGCUuH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 16:50:07 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:41682 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752466AbeGCUuG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 16:50:06 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.9.92])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 0E61BD37;
        Tue,  3 Jul 2018 20:50:05 +0000 (UTC)
Date:   Tue, 3 Jul 2018 13:50:00 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Kirill Tkhai <ktkhai@virtuozzo.com>
Cc:     vdavydov.dev@gmail.com, shakeelb@google.com,
        viro@zeniv.linux.org.uk, hannes@cmpxchg.org, mhocko@kernel.org,
        tglx@linutronix.de, pombredanne@nexb.com, stummala@codeaurora.org,
        gregkh@linuxfoundation.org, sfr@canb.auug.org.au, guro@fb.com,
        mka@chromium.org, penguin-kernel@I-love.SAKURA.ne.jp,
        chris@chris-wilson.co.uk, longman@redhat.com, minchan@kernel.org,
        ying.huang@intel.com, mgorman@techsingularity.net, jbacik@fb.com,
        linux@roeck-us.net, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, willy@infradead.org, lirongqing@baidu.com,
        aryabinin@virtuozzo.com
Subject: Re: [PATCH v8 05/17] mm: Assign memcg-aware shrinkers bitmap to
 memcg
Message-Id: <20180703135000.b2322ae0e514f028e7941d3c@linux-foundation.org>
In-Reply-To: <153063056619.1818.12550500883688681076.stgit@localhost.localdomain>
References: <153063036670.1818.16010062622751502.stgit@localhost.localdomain>
        <153063056619.1818.12550500883688681076.stgit@localhost.localdomain>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 03 Jul 2018 18:09:26 +0300 Kirill Tkhai <ktkhai@virtuozzo.com> wrote:

> Imagine a big node with many cpus, memory cgroups and containers.
> Let we have 200 containers, every container has 10 mounts,
> and 10 cgroups. All container tasks don't touch foreign
> containers mounts. If there is intensive pages write,
> and global reclaim happens, a writing task has to iterate
> over all memcgs to shrink slab, before it's able to go
> to shrink_page_list().
> 
> Iteration over all the memcg slabs is very expensive:
> the task has to visit 200 * 10 = 2000 shrinkers
> for every memcg, and since there are 2000 memcgs,
> the total calls are 2000 * 2000 = 4000000.
> 
> So, the shrinker makes 4 million do_shrink_slab() calls
> just to try to isolate SWAP_CLUSTER_MAX pages in one
> of the actively writing memcg via shrink_page_list().
> I've observed a node spending almost 100% in kernel,
> making useless iteration over already shrinked slab.
> 
> This patch adds bitmap of memcg-aware shrinkers to memcg.
> The size of the bitmap depends on bitmap_nr_ids, and during
> memcg life it's maintained to be enough to fit bitmap_nr_ids
> shrinkers. Every bit in the map is related to corresponding
> shrinker id.
> 
> Next patches will maintain set bit only for really charged
> memcg. This will allow shrink_slab() to increase its
> performance in significant way. See the last patch for
> the numbers.
> 
> ...
>
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -182,6 +182,11 @@ static int prealloc_memcg_shrinker(struct shrinker *shrinker)
>  	if (id < 0)
>  		goto unlock;
>  
> +	if (memcg_expand_shrinker_maps(id)) {
> +		idr_remove(&shrinker_idr, id);
> +		goto unlock;
> +	}
> +
>  	if (id >= shrinker_nr_max)
>  		shrinker_nr_max = id + 1;
>  	shrinker->id = id;

This function ends up being a rather sad little thing.

: static int prealloc_memcg_shrinker(struct shrinker *shrinker)
: {
: 	int id, ret = -ENOMEM;
: 
: 	down_write(&shrinker_rwsem);
: 	id = idr_alloc(&shrinker_idr, shrinker, 0, 0, GFP_KERNEL);
: 	if (id < 0)
: 		goto unlock;
: 
: 	if (memcg_expand_shrinker_maps(id)) {
: 		idr_remove(&shrinker_idr, id);
: 		goto unlock;
: 	}
: 
: 	if (id >= shrinker_nr_max)
: 		shrinker_nr_max = id + 1;
: 	shrinker->id = id;
: 	ret = 0;
: unlock:
: 	up_write(&shrinker_rwsem);
: 	return ret;
: }

- there's no need to call memcg_expand_shrinker_maps() unless id >=
  shrinker_nr_max so why not move the code and avoid calling
  memcg_expand_shrinker_maps() in most cases.

- why aren't we decreasing shrinker_nr_max in
  unregister_memcg_shrinker()?  That's easy to do, avoids pointless
  work in shrink_slab_memcg() and avoids memory waste in future
  prealloc_memcg_shrinker() calls.

  It should be possible to find the highest ID in an IDR tree with a
  straightforward descent of the underlying radix tree, but I doubt if
  that has been wired up.  Otherwise a simple loop in
  unregister_memcg_shrinker() would be needed.


