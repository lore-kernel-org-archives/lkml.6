Return-Path: <SRS0=F2HD=PG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD29EC43387
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 21:40:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A28472146F
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 21:40:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728531AbeL2VkU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Dec 2018 16:40:20 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:37384 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725902AbeL2VkU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Dec 2018 16:40:20 -0500
Received: from localhost.localdomain (c-24-6-170-16.hsd1.ca.comcast.net [24.6.170.16])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 1A9A340C;
        Sat, 29 Dec 2018 21:40:18 +0000 (UTC)
Date:   Sat, 29 Dec 2018 13:40:17 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Kirill Tkhai <ktkhai@virtuozzo.com>
Cc:     kirill@shutemov.name, hughd@google.com, aarcange@redhat.com,
        christian.koenig@amd.com, imbrenda@linux.vnet.ibm.com,
        yang.shi@linux.alibaba.com, riel@surriel.com, ying.huang@intel.com,
        minchan@kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH] mm: Reuse only-pte-mapped KSM page in do_wp_page()
Message-Id: <20181229134017.0264b5cab7e3ebb483b49f65@linux-foundation.org>
In-Reply-To: <154471491016.31352.1168978849911555609.stgit@localhost.localdomain>
References: <154471491016.31352.1168978849911555609.stgit@localhost.localdomain>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Dec 2018 18:29:08 +0300 Kirill Tkhai <ktkhai@virtuozzo.com> wrote:

> This patch adds an optimization for KSM pages almost
> in the same way, that we have for ordinary anonymous
> pages. If there is a write fault in a page, which is
> mapped to an only pte, and it is not related to swap
> cache; the page may be reused without copying its
> content.
> 
> [Note, that we do not consider PageSwapCache() pages
>  at least for now, since we don't want to complicate
>  __get_ksm_page(), which has nice optimization based
>  on this (for the migration case). Currenly it is
>  spinning on PageSwapCache() pages, waiting for when
>  they have unfreezed counters (i.e., for the migration
>  finish). But we don't want to make it also spinning
>  on swap cache pages, which we try to reuse, since
>  there is not a very high probability to reuse them.
>  So, for now we do not consider PageSwapCache() pages
>  at all.]
> 
> So, in reuse_ksm_page() we check for 1)PageSwapCache()
> and 2)page_stable_node(), to skip a page, which KSM
> is currently trying to link to stable tree. Then we
> do page_ref_freeze() to prohibit KSM to merge one more
> page into the page, we are reusing. After that, nobody
> can refer to the reusing page: KSM skips !PageSwapCache()
> pages with zero refcount; and the protection against
> of all other participants is the same as for reused
> ordinary anon pages pte lock, page lock and mmap_sem.
> 
> ...
>
> +bool reuse_ksm_page(struct page *page,
> +		    struct vm_area_struct *vma,
> +		    unsigned long address)
> +{
> +	VM_BUG_ON_PAGE(is_zero_pfn(page_to_pfn(page)), page);
> +	VM_BUG_ON_PAGE(!page_mapped(page), page);
> +	VM_BUG_ON_PAGE(!PageLocked(page), page);
> +
> +	if (PageSwapCache(page) || !page_stable_node(page))
> +		return false;
> +	/* Prohibit parallel get_ksm_page() */
> +	if (!page_ref_freeze(page, 1))
> +		return false;
> +
> +	page_move_anon_rmap(page, vma);
> +	page->index = linear_page_index(vma, address);
> +	page_ref_unfreeze(page, 1);
> +
> +	return true;
> +}

Can we avoid those BUG_ON()s?

Something like this:

--- a/mm/ksm.c~mm-reuse-only-pte-mapped-ksm-page-in-do_wp_page-fix
+++ a/mm/ksm.c
@@ -2649,9 +2649,14 @@ bool reuse_ksm_page(struct page *page,
 		    struct vm_area_struct *vma,
 		    unsigned long address)
 {
-	VM_BUG_ON_PAGE(is_zero_pfn(page_to_pfn(page)), page);
-	VM_BUG_ON_PAGE(!page_mapped(page), page);
-	VM_BUG_ON_PAGE(!PageLocked(page), page);
+#ifdef CONFIG_DEBUG_VM
+	if (WARN_ON(is_zero_pfn(page_to_pfn(page))) ||
+			WARN_ON(!page_mapped(page)) ||
+			WARN_ON(!PageLocked(page))) {
+		dump_page(page, "reuse_ksm_page");
+		return false;
+	}
+#endif
 
 	if (PageSwapCache(page) || !page_stable_node(page))
 		return false;

We don't have a VM_WARN_ON_PAGE() and we can't provide one because the
VM_foo() macros don't return a value.  It's irritating and I keep
forgetting why we ended up doing them this way.
