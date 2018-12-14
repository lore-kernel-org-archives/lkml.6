Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7469C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 18:07:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D21F8206DD
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 18:07:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730498AbeLNSHD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 13:07:03 -0500
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:33315 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730457AbeLNSHB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 13:07:01 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0TFhbeja_1544810804;
Received: from US-143344MP.local(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0TFhbeja_1544810804)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sat, 15 Dec 2018 02:06:47 +0800
Subject: Re: [PATCH] mm: Reuse only-pte-mapped KSM page in do_wp_page()
To:     Kirill Tkhai <ktkhai@virtuozzo.com>, akpm@linux-foundation.org,
        kirill@shutemov.name, hughd@google.com, aarcange@redhat.com
Cc:     christian.koenig@amd.com, imbrenda@linux.vnet.ibm.com,
        riel@surriel.com, ying.huang@intel.com, minchan@kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <154471491016.31352.1168978849911555609.stgit@localhost.localdomain>
 <5d5bfbd2-8411-e707-1628-18bde66a6793@linux.alibaba.com>
 <a394a604-20d6-e261-1735-bc225e39f2a2@virtuozzo.com>
From:   Yang Shi <yang.shi@linux.alibaba.com>
Message-ID: <00af5cd2-e226-89e3-3506-de5e6de05060@linux.alibaba.com>
Date:   Fri, 14 Dec 2018 10:06:42 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <a394a604-20d6-e261-1735-bc225e39f2a2@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/14/18 1:26 AM, Kirill Tkhai wrote:
> On 13.12.2018 22:15, Yang Shi wrote:
>>
>> On 12/13/18 7:29 AM, Kirill Tkhai wrote:
>>> This patch adds an optimization for KSM pages almost
>>> in the same way, that we have for ordinary anonymous
>>> pages. If there is a write fault in a page, which is
>>> mapped to an only pte, and it is not related to swap
>>> cache; the page may be reused without copying its
>>> content.
>>>
>>> [Note, that we do not consider PageSwapCache() pages
>>>    at least for now, since we don't want to complicate
>>>    __get_ksm_page(), which has nice optimization based
>>>    on this (for the migration case). Currenly it is
>>>    spinning on PageSwapCache() pages, waiting for when
>>>    they have unfreezed counters (i.e., for the migration
>>>    finish). But we don't want to make it also spinning
>>>    on swap cache pages, which we try to reuse, since
>>>    there is not a very high probability to reuse them.
>>>    So, for now we do not consider PageSwapCache() pages
>>>    at all.]
>>>
>>> So, in reuse_ksm_page() we check for 1)PageSwapCache()
>>> and 2)page_stable_node(), to skip a page, which KSM
>>> is currently trying to link to stable tree. Then we
>>> do page_ref_freeze() to prohibit KSM to merge one more
>>> page into the page, we are reusing. After that, nobody
>>> can refer to the reusing page: KSM skips !PageSwapCache()
>>> pages with zero refcount; and the protection against
>>> of all other participants is the same as for reused
>>> ordinary anon pages pte lock, page lock and mmap_sem.
>>>
>>> Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
>>> ---
>>>    include/linux/ksm.h |    7 +++++++
>>>    mm/ksm.c            |   25 +++++++++++++++++++++++--
>>>    mm/memory.c         |   16 ++++++++++++++--
>>>    3 files changed, 44 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/include/linux/ksm.h b/include/linux/ksm.h
>>> index 161e8164abcf..e48b1e453ff5 100644
>>> --- a/include/linux/ksm.h
>>> +++ b/include/linux/ksm.h
>>> @@ -53,6 +53,8 @@ struct page *ksm_might_need_to_copy(struct page *page,
>>>      void rmap_walk_ksm(struct page *page, struct rmap_walk_control *rwc);
>>>    void ksm_migrate_page(struct page *newpage, struct page *oldpage);
>>> +bool reuse_ksm_page(struct page *page,
>>> +            struct vm_area_struct *vma, unsigned long address);
>>>      #else  /* !CONFIG_KSM */
>>>    @@ -86,6 +88,11 @@ static inline void rmap_walk_ksm(struct page *page,
>>>    static inline void ksm_migrate_page(struct page *newpage, struct page *oldpage)
>>>    {
>>>    }
>>> +static inline bool reuse_ksm_page(struct page *page,
>>> +            struct vm_area_struct *vma, unsigned long address)
>>> +{
>>> +    return false;
>>> +}
>>>    #endif /* CONFIG_MMU */
>>>    #endif /* !CONFIG_KSM */
>>>    diff --git a/mm/ksm.c b/mm/ksm.c
>>> index 383f961e577a..fbd14264d784 100644
>>> --- a/mm/ksm.c
>>> +++ b/mm/ksm.c
>>> @@ -707,8 +707,9 @@ static struct page *__get_ksm_page(struct stable_node *stable_node,
>>>         * case this node is no longer referenced, and should be freed;
>>>         * however, it might mean that the page is under page_ref_freeze().
>>>         * The __remove_mapping() case is easy, again the node is now stale;
>>> -     * but if page is swapcache in migrate_page_move_mapping(), it might
>>> -     * still be our page, in which case it's essential to keep the node.
>>> +     * the same is in reuse_ksm_page() case; but if page is swapcache
>>> +     * in migrate_page_move_mapping(), it might still be our page,
>>> +     * in which case it's essential to keep the node.
>>>         */
>>>        while (!get_page_unless_zero(page)) {
>>>            /*
>>> @@ -2666,6 +2667,26 @@ void rmap_walk_ksm(struct page *page, struct rmap_walk_control *rwc)
>>>            goto again;
>>>    }
>>>    +bool reuse_ksm_page(struct page *page,
>>> +            struct vm_area_struct *vma,
>>> +            unsigned long address)
>>> +{
>>> +    VM_BUG_ON_PAGE(is_zero_pfn(page_to_pfn(page)), page);
>>> +    VM_BUG_ON_PAGE(!page_mapped(page), page);
>>> +    VM_BUG_ON_PAGE(!PageLocked(page), page);
>>> +
>>> +    if (PageSwapCache(page) || !page_stable_node(page))
>>> +        return false;
>>> +    /* Prohibit parallel get_ksm_page() */
>>> +    if (!page_ref_freeze(page, 1))
>>> +        return false;
>>> +
>>> +    page_move_anon_rmap(page, vma);
>> Once the mapping is changed, it is not KSM mapping anymore. It looks later get_ksm_page() would always fail on this page. Is this expected?
> Yes, this is the thing that the patch makes. Let's look at the actions,
> we have without the patch, when there is a writing to an only-pte-mapped
> KSM page.
>
> We enter to do_wp_page() with page_count() == 1, since KSM page is mapped
> in only pte (and we do not get extra reference to a page, when we add it
> to KSM stable tree). Then:
>
>    do_wp_page()
>      get_page(vmf->page) <- page_count() is 2
>      wp_page_copy()
>        ..
>        cow_user_page() /* Copy user page to a new one */
>        ..
>        put_page(vmf->page) <- page_count() is 1
>        put_page(vmf->page) <- page_count() is 0
>
> Second put_page() frees the page (and also zeroes page->mapping),
> and since that it's not a PageKsm() page anymore. Further
> __get_ksm_page() calls will fail on this page (since the mapping
> was zeroed), and its node will be unlinked from ksm stable tree:
>
> __get_ksm_page()
> {
> 	/* page->mapping == NULL, expected_mapping != NULL */
> 	if (READ_ONCE(page->mapping) != expected_mapping)
> 		goto stale;
> 	.......
> stale:
> 	remove_node_from_stable_tree(stable_node);
> }
>
>
> The patch optimizes do_wp_page(), and makes it to avoid the copying
> (like we have for ordinary anon pages). Since KSM page is freed anyway,
> after we dropped the last reference to it; we reuse it instead of this.
> So, the thing will now work in this way:
>
> do_wp_page()
>    lock_page(vmf->page)
>    reuse_ksm_page()
>      check PageSwapCache() and page_stable_node()
>      page_ref_freeze(page, 1) <- Freeze the page to make parallel
>                                  __get_ksm_page() (if any) waiting
>      page_move_anon_rmap()    <- Write new mapping, so __get_ksm_page()
>                                  sees this is not a KSM page anymore,
>                                  and it removes stable node.
>
> So, the result is the same, but after the patch we achieve it faster :)
>
> Also, note, that in the most probably case, do_wp_page() does not cross
> with __get_ksm_page() (the race window is very small; __get_ksm_page()
> is spinning, only when reuse_ksm_page() is between page_ref_freeze()
> and page_move_anon_rmap(), which are on neighboring lines).
>
> So, this is the idea. Please, let me know in case of something is unclear
> for you.

Thanks for elaborating this. It sounds reasonable. You can add 
Reviewed-by: Yang Shi <yang.shi@linux.alibaba.com>

>
> Kirill

