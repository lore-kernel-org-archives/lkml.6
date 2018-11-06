Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C704EC32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 10:54:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C1FA2086A
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 10:54:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="dK6rsDy/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C1FA2086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730160AbeKFUSt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 15:18:49 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:44578 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729272AbeKFUSt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 15:18:49 -0500
Received: by mail-ed1-f65.google.com with SMTP id n19-v6so10065975edq.11
        for <linux-kernel@vger.kernel.org>; Tue, 06 Nov 2018 02:54:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=OGPLlvaEaydbhwOTndVZDHSNwtiPv9n6A9iZehHX+Hw=;
        b=dK6rsDy/U6OByk3/N/NyTcP3TgMbY1zK8RQu2N4oPiO3ZjjwD/fS3d5iXe7fZ2x0jG
         VFZYmhwho0pXB85D+uUTPle9cdzc0udfUrPrT5+99BWy0vXrFPQjqoJmAf+wvYIw62/x
         npTfHnDNi/mhvsIYwd9dirodO3TsebAgGkGNY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=OGPLlvaEaydbhwOTndVZDHSNwtiPv9n6A9iZehHX+Hw=;
        b=S+XzxSMI8g1TKLX8PqxWf6CkiKALXF+3u146rbda6QnyhVXPixoZWRRDm2eSjam3w8
         Ju2oBK0cFD4RMpOEoOC+TBK+ow96fEM33RyAtC9PcjxrSspgcOtSNNWEIgPy3W+AEYRD
         K31sDYsHO541f1LsSoUJhvZqmiu2Z+BlQC8uU91j6z9Z1On1aosvNtnhXXvpQvaphhx7
         Fchz0vHFfUp9sUu2nWifb3L5G3PecmmGV+x8SuBPhTwTQiyJs7ZTvUQSGADv1Leo04a+
         fwWd7sLFPmaVnt4+iiselRFjfnXJjsDlIQ+BP7wBnkhF98GXSeet3G5i6yexQImINa4r
         Sw7w==
X-Gm-Message-State: AGRZ1gLqISrjbbTWS2hs0qH1o3A0QHLDEhwVpQfhHZh1k8ZxdsrZ4Mw+
        OEAMdrXB33AXnK9pUJx9P/VF5A==
X-Google-Smtp-Source: AJdET5cgdyODqiP7A8Ej8G69AiGRR5xTqjA824Pfq2agNO8dpbnrOnPfIQOeX9di+guQScvkg68Wvw==
X-Received: by 2002:a17:906:4c89:: with SMTP id q9-v6mr16691636eju.26.1541501649546;
        Tue, 06 Nov 2018 02:54:09 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id e10-v6sm7450060ejf.28.2018.11.06.02.54.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 06 Nov 2018 02:54:08 -0800 (PST)
Date:   Tue, 6 Nov 2018 11:54:06 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Kuo-Hsin Yang <vovoy@chromium.org>
Cc:     linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org,
        linux-mm@kvack.org, Chris Wilson <chris@chris-wilson.co.uk>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH v6] mm, drm/i915: mark pinned shmemfs pages as unevictable
Message-ID: <20181106105406.GO21967@phenom.ffwll.local>
Mail-Followup-To: Kuo-Hsin Yang <vovoy@chromium.org>,
        linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org,
        linux-mm@kvack.org, Chris Wilson <chris@chris-wilson.co.uk>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@intel.com>, Michal Hocko <mhocko@suse.com>
References: <20181106093100.71829-1-vovoy@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181106093100.71829-1-vovoy@chromium.org>
X-Operating-System: Linux phenom 4.18.0-2-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 06, 2018 at 05:30:59PM +0800, Kuo-Hsin Yang wrote:
> The i915 driver uses shmemfs to allocate backing storage for gem
> objects. These shmemfs pages can be pinned (increased ref count) by
> shmem_read_mapping_page_gfp(). When a lot of pages are pinned, vmscan
> wastes a lot of time scanning these pinned pages. In some extreme case,
> all pages in the inactive anon lru are pinned, and only the inactive
> anon lru is scanned due to inactive_ratio, the system cannot swap and
> invokes the oom-killer. Mark these pinned pages as unevictable to speed
> up vmscan.
> 
> Export pagevec API check_move_unevictable_pages().
> 
> This patch was inspired by Chris Wilson's change [1].
> 
> [1]: https://patchwork.kernel.org/patch/9768741/
> 
> Cc: Chris Wilson <chris@chris-wilson.co.uk>
> Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Dave Hansen <dave.hansen@intel.com>
> Signed-off-by: Kuo-Hsin Yang <vovoy@chromium.org>
> Acked-by: Michal Hocko <mhocko@suse.com> # mm part

There was ages ago some planes to have our own i915fs, so that we could
overwrite the address_space hooks for page migration and eviction and that
sort of thing, which would make all these pages evictable. Atm you have to
ĥope our shrinker drops them on the floor, which I think is fairly
confusing to core mm code (it's kinda like page eviction worked way back
before rmaps).

Just an side really.
-Daniel

> ---
> Changes for v6:
>  Tweak the acked-by.
> 
> Changes for v5:
>  Modify doc and comments. Remove the ifdef surrounding
>  check_move_unevictable_pages.
> 
> Changes for v4:
>  Export pagevec API check_move_unevictable_pages().
> 
> Changes for v3:
>  Use check_move_lru_page instead of shmem_unlock_mapping to move pages
>  to appropriate lru lists.
> 
> Changes for v2:
>  Squashed the two patches.
> 
>  Documentation/vm/unevictable-lru.rst |  6 +++++-
>  drivers/gpu/drm/i915/i915_gem.c      | 28 ++++++++++++++++++++++++++--
>  include/linux/swap.h                 |  4 +++-
>  mm/shmem.c                           |  2 +-
>  mm/vmscan.c                          | 22 +++++++++++-----------
>  5 files changed, 46 insertions(+), 16 deletions(-)
> 
> diff --git a/Documentation/vm/unevictable-lru.rst b/Documentation/vm/unevictable-lru.rst
> index fdd84cb8d511..b8e29f977f2d 100644
> --- a/Documentation/vm/unevictable-lru.rst
> +++ b/Documentation/vm/unevictable-lru.rst
> @@ -143,7 +143,7 @@ using a number of wrapper functions:
>  	Query the address space, and return true if it is completely
>  	unevictable.
>  
> -These are currently used in two places in the kernel:
> +These are currently used in three places in the kernel:
>  
>   (1) By ramfs to mark the address spaces of its inodes when they are created,
>       and this mark remains for the life of the inode.
> @@ -154,6 +154,10 @@ These are currently used in two places in the kernel:
>       swapped out; the application must touch the pages manually if it wants to
>       ensure they're in memory.
>  
> + (3) By the i915 driver to mark pinned address space until it's unpinned. The
> +     amount of unevictable memory marked by i915 driver is roughly the bounded
> +     object size in debugfs/dri/0/i915_gem_objects.
> +
>  
>  Detecting Unevictable Pages
>  ---------------------------
> diff --git a/drivers/gpu/drm/i915/i915_gem.c b/drivers/gpu/drm/i915/i915_gem.c
> index 0c8aa57ce83b..c620891e0d02 100644
> --- a/drivers/gpu/drm/i915/i915_gem.c
> +++ b/drivers/gpu/drm/i915/i915_gem.c
> @@ -2381,12 +2381,25 @@ void __i915_gem_object_invalidate(struct drm_i915_gem_object *obj)
>  	invalidate_mapping_pages(mapping, 0, (loff_t)-1);
>  }
>  
> +/**
> + * Move pages to appropriate lru and release the pagevec. Decrement the ref
> + * count of these pages.
> + */
> +static inline void check_release_pagevec(struct pagevec *pvec)
> +{
> +	if (pagevec_count(pvec)) {
> +		check_move_unevictable_pages(pvec);
> +		__pagevec_release(pvec);
> +	}
> +}
> +
>  static void
>  i915_gem_object_put_pages_gtt(struct drm_i915_gem_object *obj,
>  			      struct sg_table *pages)
>  {
>  	struct sgt_iter sgt_iter;
>  	struct page *page;
> +	struct pagevec pvec;
>  
>  	__i915_gem_object_release_shmem(obj, pages, true);
>  
> @@ -2395,6 +2408,9 @@ i915_gem_object_put_pages_gtt(struct drm_i915_gem_object *obj,
>  	if (i915_gem_object_needs_bit17_swizzle(obj))
>  		i915_gem_object_save_bit_17_swizzle(obj, pages);
>  
> +	mapping_clear_unevictable(file_inode(obj->base.filp)->i_mapping);
> +
> +	pagevec_init(&pvec);
>  	for_each_sgt_page(page, sgt_iter, pages) {
>  		if (obj->mm.dirty)
>  			set_page_dirty(page);
> @@ -2402,8 +2418,10 @@ i915_gem_object_put_pages_gtt(struct drm_i915_gem_object *obj,
>  		if (obj->mm.madv == I915_MADV_WILLNEED)
>  			mark_page_accessed(page);
>  
> -		put_page(page);
> +		if (!pagevec_add(&pvec, page))
> +			check_release_pagevec(&pvec);
>  	}
> +	check_release_pagevec(&pvec);
>  	obj->mm.dirty = false;
>  
>  	sg_free_table(pages);
> @@ -2526,6 +2544,7 @@ static int i915_gem_object_get_pages_gtt(struct drm_i915_gem_object *obj)
>  	unsigned int sg_page_sizes;
>  	gfp_t noreclaim;
>  	int ret;
> +	struct pagevec pvec;
>  
>  	/*
>  	 * Assert that the object is not currently in any GPU domain. As it
> @@ -2559,6 +2578,7 @@ static int i915_gem_object_get_pages_gtt(struct drm_i915_gem_object *obj)
>  	 * Fail silently without starting the shrinker
>  	 */
>  	mapping = obj->base.filp->f_mapping;
> +	mapping_set_unevictable(mapping);
>  	noreclaim = mapping_gfp_constraint(mapping, ~__GFP_RECLAIM);
>  	noreclaim |= __GFP_NORETRY | __GFP_NOWARN;
>  
> @@ -2673,8 +2693,12 @@ static int i915_gem_object_get_pages_gtt(struct drm_i915_gem_object *obj)
>  err_sg:
>  	sg_mark_end(sg);
>  err_pages:
> +	mapping_clear_unevictable(mapping);
> +	pagevec_init(&pvec);
>  	for_each_sgt_page(page, sgt_iter, st)
> -		put_page(page);
> +		if (!pagevec_add(&pvec, page))
> +			check_release_pagevec(&pvec);
> +	check_release_pagevec(&pvec);
>  	sg_free_table(st);
>  	kfree(st);
>  
> diff --git a/include/linux/swap.h b/include/linux/swap.h
> index d8a07a4f171d..a8f6d5d89524 100644
> --- a/include/linux/swap.h
> +++ b/include/linux/swap.h
> @@ -18,6 +18,8 @@ struct notifier_block;
>  
>  struct bio;
>  
> +struct pagevec;
> +
>  #define SWAP_FLAG_PREFER	0x8000	/* set if swap priority specified */
>  #define SWAP_FLAG_PRIO_MASK	0x7fff
>  #define SWAP_FLAG_PRIO_SHIFT	0
> @@ -369,7 +371,7 @@ static inline int node_reclaim(struct pglist_data *pgdat, gfp_t mask,
>  #endif
>  
>  extern int page_evictable(struct page *page);
> -extern void check_move_unevictable_pages(struct page **, int nr_pages);
> +extern void check_move_unevictable_pages(struct pagevec *pvec);
>  
>  extern int kswapd_run(int nid);
>  extern void kswapd_stop(int nid);
> diff --git a/mm/shmem.c b/mm/shmem.c
> index ea26d7a0342d..de4893c904a3 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -756,7 +756,7 @@ void shmem_unlock_mapping(struct address_space *mapping)
>  			break;
>  		index = indices[pvec.nr - 1] + 1;
>  		pagevec_remove_exceptionals(&pvec);
> -		check_move_unevictable_pages(pvec.pages, pvec.nr);
> +		check_move_unevictable_pages(&pvec);
>  		pagevec_release(&pvec);
>  		cond_resched();
>  	}
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 62ac0c488624..d070f431ff19 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -50,6 +50,7 @@
>  #include <linux/printk.h>
>  #include <linux/dax.h>
>  #include <linux/psi.h>
> +#include <linux/pagevec.h>
>  
>  #include <asm/tlbflush.h>
>  #include <asm/div64.h>
> @@ -4182,17 +4183,16 @@ int page_evictable(struct page *page)
>  	return ret;
>  }
>  
> -#ifdef CONFIG_SHMEM
>  /**
> - * check_move_unevictable_pages - check pages for evictability and move to appropriate zone lru list
> - * @pages:	array of pages to check
> - * @nr_pages:	number of pages to check
> + * check_move_unevictable_pages - check pages for evictability and move to
> + * appropriate zone lru list
> + * @pvec: pagevec with lru pages to check
>   *
> - * Checks pages for evictability and moves them to the appropriate lru list.
> - *
> - * This function is only used for SysV IPC SHM_UNLOCK.
> + * Checks pages for evictability, if an evictable page is in the unevictable
> + * lru list, moves it to the appropriate evictable lru list. This function
> + * should be only used for lru pages.
>   */
> -void check_move_unevictable_pages(struct page **pages, int nr_pages)
> +void check_move_unevictable_pages(struct pagevec *pvec)
>  {
>  	struct lruvec *lruvec;
>  	struct pglist_data *pgdat = NULL;
> @@ -4200,8 +4200,8 @@ void check_move_unevictable_pages(struct page **pages, int nr_pages)
>  	int pgrescued = 0;
>  	int i;
>  
> -	for (i = 0; i < nr_pages; i++) {
> -		struct page *page = pages[i];
> +	for (i = 0; i < pvec->nr; i++) {
> +		struct page *page = pvec->pages[i];
>  		struct pglist_data *pagepgdat = page_pgdat(page);
>  
>  		pgscanned++;
> @@ -4233,4 +4233,4 @@ void check_move_unevictable_pages(struct page **pages, int nr_pages)
>  		spin_unlock_irq(&pgdat->lru_lock);
>  	}
>  }
> -#endif /* CONFIG_SHMEM */
> +EXPORT_SYMBOL_GPL(check_move_unevictable_pages);
> -- 
> 2.19.1.930.g4563a0d9d0-goog
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
