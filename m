Return-Path: <SRS0=F2HD=PG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2AC8C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 09:34:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB4772081B
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 09:34:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729193AbeL2Jeg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Dec 2018 04:34:36 -0500
Received: from relay.sw.ru ([185.231.240.75]:56174 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726561AbeL2Jeg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Dec 2018 04:34:36 -0500
Received: from [172.16.25.169]
        by relay.sw.ru with esmtp (Exim 4.91)
        (envelope-from <ktkhai@virtuozzo.com>)
        id 1gdB0i-0000NS-En; Sat, 29 Dec 2018 12:34:24 +0300
Subject: Re: [PATCH] mm: Reuse only-pte-mapped KSM page in do_wp_page()
To:     akpm@linux-foundation.org
Cc:     kirill@shutemov.name, hughd@google.com, aarcange@redhat.com,
        christian.koenig@amd.com, imbrenda@linux.vnet.ibm.com,
        yang.shi@linux.alibaba.com, riel@surriel.com, ying.huang@intel.com,
        minchan@kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
References: <154471491016.31352.1168978849911555609.stgit@localhost.localdomain>
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <3ffdbc4d-6344-d209-3062-1f5b6b2146b4@virtuozzo.com>
Date:   Sat, 29 Dec 2018 12:34:23 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <154471491016.31352.1168978849911555609.stgit@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Andrew!

How do you look at this patch? It had been reviewed.

Thanks,
Kirill

On 13.12.2018 18:29, Kirill Tkhai wrote:
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
> Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
> ---
>  include/linux/ksm.h |    7 +++++++
>  mm/ksm.c            |   25 +++++++++++++++++++++++--
>  mm/memory.c         |   16 ++++++++++++++--
>  3 files changed, 44 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/ksm.h b/include/linux/ksm.h
> index 161e8164abcf..e48b1e453ff5 100644
> --- a/include/linux/ksm.h
> +++ b/include/linux/ksm.h
> @@ -53,6 +53,8 @@ struct page *ksm_might_need_to_copy(struct page *page,
>  
>  void rmap_walk_ksm(struct page *page, struct rmap_walk_control *rwc);
>  void ksm_migrate_page(struct page *newpage, struct page *oldpage);
> +bool reuse_ksm_page(struct page *page,
> +			struct vm_area_struct *vma, unsigned long address);
>  
>  #else  /* !CONFIG_KSM */
>  
> @@ -86,6 +88,11 @@ static inline void rmap_walk_ksm(struct page *page,
>  static inline void ksm_migrate_page(struct page *newpage, struct page *oldpage)
>  {
>  }
> +static inline bool reuse_ksm_page(struct page *page,
> +			struct vm_area_struct *vma, unsigned long address)
> +{
> +	return false;
> +}
>  #endif /* CONFIG_MMU */
>  #endif /* !CONFIG_KSM */
>  
> diff --git a/mm/ksm.c b/mm/ksm.c
> index 383f961e577a..fbd14264d784 100644
> --- a/mm/ksm.c
> +++ b/mm/ksm.c
> @@ -707,8 +707,9 @@ static struct page *__get_ksm_page(struct stable_node *stable_node,
>  	 * case this node is no longer referenced, and should be freed;
>  	 * however, it might mean that the page is under page_ref_freeze().
>  	 * The __remove_mapping() case is easy, again the node is now stale;
> -	 * but if page is swapcache in migrate_page_move_mapping(), it might
> -	 * still be our page, in which case it's essential to keep the node.
> +	 * the same is in reuse_ksm_page() case; but if page is swapcache
> +	 * in migrate_page_move_mapping(), it might still be our page,
> +	 * in which case it's essential to keep the node.
>  	 */
>  	while (!get_page_unless_zero(page)) {
>  		/*
> @@ -2666,6 +2667,26 @@ void rmap_walk_ksm(struct page *page, struct rmap_walk_control *rwc)
>  		goto again;
>  }
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
>  #ifdef CONFIG_MIGRATION
>  void ksm_migrate_page(struct page *newpage, struct page *oldpage)
>  {
> diff --git a/mm/memory.c b/mm/memory.c
> index 532061217e03..5817527f1877 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -2509,8 +2509,11 @@ static vm_fault_t do_wp_page(struct vm_fault *vmf)
>  	 * Take out anonymous pages first, anonymous shared vmas are
>  	 * not dirty accountable.
>  	 */
> -	if (PageAnon(vmf->page) && !PageKsm(vmf->page)) {
> +	if (PageAnon(vmf->page)) {
>  		int total_map_swapcount;
> +		if (PageKsm(vmf->page) && (PageSwapCache(vmf->page) ||
> +					   page_count(vmf->page) != 1))
> +			goto copy;
>  		if (!trylock_page(vmf->page)) {
>  			get_page(vmf->page);
>  			pte_unmap_unlock(vmf->pte, vmf->ptl);
> @@ -2525,6 +2528,15 @@ static vm_fault_t do_wp_page(struct vm_fault *vmf)
>  			}
>  			put_page(vmf->page);
>  		}
> +		if (PageKsm(vmf->page)) {
> +			bool reused = reuse_ksm_page(vmf->page, vmf->vma,
> +						     vmf->address);
> +			unlock_page(vmf->page);
> +			if (!reused)
> +				goto copy;
> +			wp_page_reuse(vmf);
> +			return VM_FAULT_WRITE;
> +		}
>  		if (reuse_swap_page(vmf->page, &total_map_swapcount)) {
>  			if (total_map_swapcount == 1) {
>  				/*
> @@ -2545,7 +2557,7 @@ static vm_fault_t do_wp_page(struct vm_fault *vmf)
>  					(VM_WRITE|VM_SHARED))) {
>  		return wp_page_shared(vmf);
>  	}
> -
> +copy:
>  	/*
>  	 * Ok, we need to copy. Oh, well..
>  	 */
> 
