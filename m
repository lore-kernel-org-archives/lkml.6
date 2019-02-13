Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 049AFC0044B
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 20:59:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1516218D9
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 20:59:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394689AbfBMU7J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 15:59:09 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:33480 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731303AbfBMU7I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 15:59:08 -0500
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 17357121F;
        Wed, 13 Feb 2019 20:59:07 +0000 (UTC)
Date:   Wed, 13 Feb 2019 12:59:06 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Jann Horn <jannh@google.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Pavel Tatashin <pavel.tatashin@microsoft.com>,
        Oscar Salvador <osalvador@suse.de>,
        Mel Gorman <mgorman@techsingularity.net>,
        Aaron Lu <aaron.lu@intel.com>, netdev@vger.kernel.org,
        Alexander Duyck <alexander.h.duyck@redhat.com>
Subject: Re: [PATCH] mm: page_alloc: fix ref bias in page_frag_alloc() for
 1-byte allocs
Message-Id: <20190213125906.eae96c18fe585e060aaf0ef7@linux-foundation.org>
In-Reply-To: <20190213204157.12570-1-jannh@google.com>
References: <20190213204157.12570-1-jannh@google.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Feb 2019 21:41:57 +0100 Jann Horn <jannh@google.com> wrote:

> The basic idea behind ->pagecnt_bias is: If we pre-allocate the maximum
> number of references that we might need to create in the fastpath later,
> the bump-allocation fastpath only has to modify the non-atomic bias value
> that tracks the number of extra references we hold instead of the atomic
> refcount. The maximum number of allocations we can serve (under the
> assumption that no allocation is made with size 0) is nc->size, so that's
> the bias used.
> 
> However, even when all memory in the allocation has been given away, a
> reference to the page is still held; and in the `offset < 0` slowpath, the
> page may be reused if everyone else has dropped their references.
> This means that the necessary number of references is actually
> `nc->size+1`.
> 
> Luckily, from a quick grep, it looks like the only path that can call
> page_frag_alloc(fragsz=1) is TAP with the IFF_NAPI_FRAGS flag, which
> requires CAP_NET_ADMIN in the init namespace and is only intended to be
> used for kernel testing and fuzzing.

For the net-naive, what is TAP?  It doesn't appear to mean
drivers/net/tap.c.

> To test for this issue, put a `WARN_ON(page_ref_count(page) == 0)` in the
> `offset < 0` path, below the virt_to_page() call, and then repeatedly call
> writev() on a TAP device with IFF_TAP|IFF_NO_PI|IFF_NAPI_FRAGS|IFF_NAPI,
> with a vector consisting of 15 elements containing 1 byte each.
> 
> ...
>
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -4675,11 +4675,11 @@ void *page_frag_alloc(struct page_frag_cache *nc,
>  		/* Even if we own the page, we do not use atomic_set().
>  		 * This would break get_page_unless_zero() users.
>  		 */
> -		page_ref_add(page, size - 1);
> +		page_ref_add(page, size);
>  
>  		/* reset page count bias and offset to start of new frag */
>  		nc->pfmemalloc = page_is_pfmemalloc(page);
> -		nc->pagecnt_bias = size;
> +		nc->pagecnt_bias = size + 1;
>  		nc->offset = size;
>  	}
>  
> @@ -4695,10 +4695,10 @@ void *page_frag_alloc(struct page_frag_cache *nc,
>  		size = nc->size;
>  #endif
>  		/* OK, page count is 0, we can safely set it */
> -		set_page_count(page, size);
> +		set_page_count(page, size + 1);
>  
>  		/* reset page count bias and offset to start of new frag */
> -		nc->pagecnt_bias = size;
> +		nc->pagecnt_bias = size + 1;
>  		offset = size - fragsz;
>  	}

This is probably more a davem patch than a -mm one.
