Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFF6CC32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 11:07:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E6B420862
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 11:07:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E6B420862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=chris-wilson.co.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730436AbeKFUcd convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 15:32:33 -0500
Received: from mail.fireflyinternet.com ([109.228.58.192]:55102 "EHLO
        fireflyinternet.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726976AbeKFUcd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 15:32:33 -0500
X-Default-Received-SPF: pass (skip=forwardok (res=PASS)) x-ip-name=78.156.65.138;
Received: from localhost (unverified [78.156.65.138]) 
        by fireflyinternet.com (Firefly Internet (M1)) with ESMTP (TLS) id 14370028-1500050 
        for multiple; Tue, 06 Nov 2018 11:07:01 +0000
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To:     Kuo-Hsin Yang <vovoy@chromium.org>,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
From:   Chris Wilson <chris@chris-wilson.co.uk>
In-Reply-To: <20181106093100.71829-1-vovoy@chromium.org>
Cc:     Kuo-Hsin Yang <vovoy@chromium.org>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Michal Hocko <mhocko@suse.com>
References: <20181106093100.71829-1-vovoy@chromium.org>
Message-ID: <154150241813.6179.68008798371252810@skylake-alporthouse-com>
User-Agent: alot/0.6
Subject: Re: [PATCH v6] mm, drm/i915: mark pinned shmemfs pages as unevictable
Date:   Tue, 06 Nov 2018 11:06:58 +0000
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Kuo-Hsin Yang (2018-11-06 09:30:59)
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
>         Query the address space, and return true if it is completely
>         unevictable.
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
>         invalidate_mapping_pages(mapping, 0, (loff_t)-1);
>  }
>  
> +/**
> + * Move pages to appropriate lru and release the pagevec. Decrement the ref
> + * count of these pages.
> + */
> +static inline void check_release_pagevec(struct pagevec *pvec)
> +{
> +       if (pagevec_count(pvec)) {
> +               check_move_unevictable_pages(pvec);
> +               __pagevec_release(pvec);

This gave disappointing syslatency results until I put a cond_resched()
here and moved the one in put_pages_gtt to before the page alloc, see
https://patchwork.freedesktop.org/patch/260332/

The last really nasty wart for syslatency is the spin in
i915_gem_shrinker, for which I'm investigating
https://patchwork.freedesktop.org/patch/260365/

All 3 patches together give very reasonable syslatency results! (So
good that it's time to find a new worst case scenario!)

The challenge for the patch as it stands, is who lands it? We can take
it through drm-intel (for merging in 4.21) but need Andrew's ack on top
of all to agree with that path. Or we split the patch and only land the
i915 portion once we backmerge the mm tree. I think pushing the i915
portion through the mm tree is going to cause the most conflicts, so
would recommend against that.
-Chris
