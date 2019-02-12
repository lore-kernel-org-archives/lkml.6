Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B5B9C4151A
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 21:12:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18EBC222B1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 21:12:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731530AbfBLVMx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 16:12:53 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:53656 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727932AbfBLVMx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 16:12:53 -0500
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id B7725E5FA;
        Tue, 12 Feb 2019 21:12:51 +0000 (UTC)
Date:   Tue, 12 Feb 2019 13:12:50 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Qian Cai <cai@lca.pw>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Kostya Serebryany <kcc@google.com>,
        Evgeniy Stepanov <eugenis@google.com>
Subject: Re: [PATCH 4/5] kasan, slub: move kasan_poison_slab hook before
 page_address
Message-Id: <20190212131250.0f98d6a9cea8e03ca47f980c@linux-foundation.org>
In-Reply-To: <cd895d627465a3f1c712647072d17f10883be2a1.1549921721.git.andreyknvl@google.com>
References: <cover.1549921721.git.andreyknvl@google.com>
        <cd895d627465a3f1c712647072d17f10883be2a1.1549921721.git.andreyknvl@google.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Feb 2019 22:59:53 +0100 Andrey Konovalov <andreyknvl@google.com> wrote:

> With tag based KASAN page_address() looks at the page flags to see
> whether the resulting pointer needs to have a tag set. Since we don't
> want to set a tag when page_address() is called on SLAB pages, we call
> page_kasan_tag_reset() in kasan_poison_slab(). However in allocate_slab()
> page_address() is called before kasan_poison_slab(). Fix it by changing
> the order.
> 
> ...
>
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -1642,12 +1642,15 @@ static struct page *allocate_slab(struct kmem_cache *s, gfp_t flags, int node)
>  	if (page_is_pfmemalloc(page))
>  		SetPageSlabPfmemalloc(page);
>  
> +	kasan_poison_slab(page);
> +
>  	start = page_address(page);
>  
> -	if (unlikely(s->flags & SLAB_POISON))
> +	if (unlikely(s->flags & SLAB_POISON)) {
> +		metadata_access_enable();
>  		memset(start, POISON_INUSE, PAGE_SIZE << order);
> -
> -	kasan_poison_slab(page);
> +		metadata_access_disable();
> +	}
>  
>  	shuffle = shuffle_freelist(s, page);

This doesn't compile when CONFIG_SLUB_DEBUG=n.  Please review carefully:

--- a/mm/slub.c~kasan-slub-move-kasan_poison_slab-hook-before-page_address-fix
+++ a/mm/slub.c
@@ -1357,6 +1357,14 @@ slab_flags_t kmem_cache_flags(unsigned i
 
 #define disable_higher_order_debug 0
 
+static inline void metadata_access_enable(void)
+{
+}
+
+static inline void metadata_access_disable(void)
+{
+}
+
 static inline unsigned long slabs_node(struct kmem_cache *s, int node)
 							{ return 0; }
 static inline unsigned long node_nr_slabs(struct kmem_cache_node *n)
_

