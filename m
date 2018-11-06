Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B019C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 18:12:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F33AB20869
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 18:12:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F33AB20869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730950AbeKGDij (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 22:38:39 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:39524 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730315AbeKGDij (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 22:38:39 -0500
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 273DC516;
        Tue,  6 Nov 2018 18:12:12 +0000 (UTC)
Date:   Tue, 6 Nov 2018 10:12:11 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Chris Wilson <chris@chris-wilson.co.uk>
Cc:     intel-gfx@lists.freedesktop.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Kuo-Hsin Yang <vovoy@chromium.org>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH v7] mm, drm/i915: mark pinned shmemfs pages as
 unevictable
Message-Id: <20181106101211.d2e4857aa36ea8ffbd870d2f@linux-foundation.org>
In-Reply-To: <20181106132324.17390-1-chris@chris-wilson.co.uk>
References: <20181106093100.71829-1-vovoy@chromium.org>
        <20181106132324.17390-1-chris@chris-wilson.co.uk>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue,  6 Nov 2018 13:23:24 +0000 Chris Wilson <chris@chris-wilson.co.uk> wrote:

> From: Kuo-Hsin Yang <vovoy@chromium.org>
> 
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
> ...
>
> --- a/drivers/gpu/drm/i915/i915_gem.c
> +++ b/drivers/gpu/drm/i915/i915_gem.c
> @@ -2382,12 +2382,26 @@ void __i915_gem_object_invalidate(struct drm_i915_gem_object *obj)
>  	invalidate_mapping_pages(mapping, 0, (loff_t)-1);
>  }
>  
> +/**

This token is used to introduce a kerneldoc comment.

> + * Move pages to appropriate lru and release the pagevec. Decrement the ref
> + * count of these pages.
> + */

But this isn't a kerneldoc comment.

At least, I don't think it is.  Maybe the parser got smarter when I
wasn't looking.

> +static inline void check_release_pagevec(struct pagevec *pvec)
> +{
> +	if (pagevec_count(pvec)) {
> +		check_move_unevictable_pages(pvec);
> +		__pagevec_release(pvec);
> +		cond_resched();
> +	}
> +}

This looks too large to be inlined and the compiler will ignore the
`inline' anyway.


Otherwise, Acked-by: Andrew Morton <akpm@linux-foundation.org>.  Please
go ahead and merge via the appropriate drm tree.

