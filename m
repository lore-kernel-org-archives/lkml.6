Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7575FC282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 17:47:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E63C21473
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 17:47:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732662AbfA3Rr3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 12:47:29 -0500
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:48927 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732271AbfA3Rr3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 12:47:29 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07417;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0TJHNlRE_1548870440;
Received: from US-143344MP.local(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0TJHNlRE_1548870440)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 31 Jan 2019 01:47:23 +0800
Subject: Re: [v3 PATCH] mm: ksm: do not block on page lock when searching
 stable tree
To:     John Hubbard <jhubbard@nvidia.com>, ktkhai@virtuozzo.com,
        hughd@google.com, aarcange@redhat.com, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <1548793753-62377-1-git-send-email-yang.shi@linux.alibaba.com>
 <82ba1395-baab-3b95-a3f7-47e219551881@nvidia.com>
From:   Yang Shi <yang.shi@linux.alibaba.com>
Message-ID: <7cf16cfb-3190-dfbd-ce72-92a94d9277f5@linux.alibaba.com>
Date:   Wed, 30 Jan 2019 09:47:19 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <82ba1395-baab-3b95-a3f7-47e219551881@nvidia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/29/19 11:14 PM, John Hubbard wrote:
> On 1/29/19 12:29 PM, Yang Shi wrote:
>> ksmd need search stable tree to look for the suitable KSM page, but the
>> KSM page might be locked for a while due to i.e. KSM page rmap walk.
>> Basically it is not a big deal since commit 2c653d0ee2ae
>> ("ksm: introduce ksm_max_page_sharing per page deduplication limit"),
>> since max_page_sharing limits the number of shared KSM pages.
>>
>> But it still sounds not worth waiting for the lock, the page can be 
>> skip,
>> then try to merge it in the next scan to avoid potential stall if its
>> content is still intact.
>>
>> Introduce trylock mode to get_ksm_page() to not block on page lock, like
>> what try_to_merge_one_page() does.  And, define three possible
>> operations (nolock, lock and trylock) as enum type to avoid stacking up
>> bools and make the code more readable.
>>
>> Return -EBUSY if trylock fails, since NULL means not find suitable KSM
>> page, which is a valid case.
>>
>> With the default max_page_sharing setting (256), there is almost no
>> observed change comparing lock vs trylock.
>>
>> However, with ksm02 of LTP, the reduced ksmd full scan time can be
>> observed, which has set max_page_sharing to 786432.  With lock version,
>> ksmd may tak 10s - 11s to run two full scans, with trylock version ksmd
>> may take 8s - 11s to run two full scans.  And, the number of
>> pages_sharing and pages_to_scan keep same.  Basically, this change has
>> no harm >
>> Cc: Hugh Dickins <hughd@google.com>
>> Cc: Andrea Arcangeli <aarcange@redhat.com>
>> Suggested-by: John Hubbard <jhubbard@nvidia.com>
>> Reviewed-by: Kirill Tkhai <ktkhai@virtuozzo.com>
>> Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
>> ---
>> Hi folks,
>>
>> This patch was with "mm: vmscan: skip KSM page in direct reclaim if 
>> priority
>> is low" in the initial submission.  Then Hugh and Andrea pointed out 
>> commit
>> 2c653d0ee2ae ("ksm: introduce ksm_max_page_sharing per page 
>> deduplication
>> limit") is good enough for limiting the number of shared KSM page to 
>> prevent
>> from softlock when walking ksm page rmap.  This commit does solve the 
>> problem.
>> So, the series was dropped by Andrew from -mm tree.
>>
>> However, I thought the second patch (this one) still sounds useful.  
>> So, I did
>> some test and resubmit it.  The first version was reviewed by Krill 
>> Tkhai, so
>> I keep his Reviewed-by tag since there is no change to the patch 
>> except the
>> commit log.
>>
>> So, would you please reconsider this patch?
>>
>> v3: Use enum to define get_ksm_page operations (nolock, lock and 
>> trylock) per
>>      John Hubbard
>> v2: Updated the commit log to reflect some test result and latest 
>> discussion
>>
>>   mm/ksm.c | 46 ++++++++++++++++++++++++++++++++++++----------
>>   1 file changed, 36 insertions(+), 10 deletions(-)
>>
>> diff --git a/mm/ksm.c b/mm/ksm.c
>> index 6c48ad1..5647bc1 100644
>> --- a/mm/ksm.c
>> +++ b/mm/ksm.c
>> @@ -667,6 +667,12 @@ static void remove_node_from_stable_tree(struct 
>> stable_node *stable_node)
>>       free_stable_node(stable_node);
>>   }
>>   +enum get_ksm_page_flags {
>> +    GET_KSM_PAGE_NOLOCK,
>> +    GET_KSM_PAGE_LOCK,
>> +    GET_KSM_PAGE_TRYLOCK
>> +};
>> +
>>   /*
>>    * get_ksm_page: checks if the page indicated by the stable node
>>    * is still its ksm page, despite having held no reference to it.
>> @@ -686,7 +692,8 @@ static void remove_node_from_stable_tree(struct 
>> stable_node *stable_node)
>>    * a page to put something that might look like our key in 
>> page->mapping.
>>    * is on its way to being freed; but it is an anomaly to bear in mind.
>>    */
>> -static struct page *get_ksm_page(struct stable_node *stable_node, 
>> bool lock_it)
>> +static struct page *get_ksm_page(struct stable_node *stable_node,
>> +                 enum get_ksm_page_flags flags)
>>   {
>>       struct page *page;
>>       void *expected_mapping;
>> @@ -728,8 +735,15 @@ static struct page *get_ksm_page(struct 
>> stable_node *stable_node, bool lock_it)
>>           goto stale;
>>       }
>>   -    if (lock_it) {
>> +    if (flags == GET_KSM_PAGE_TRYLOCK) {
>> +        if (!trylock_page(page)) {
>> +            put_page(page);
>> +            return ERR_PTR(-EBUSY);
>> +        }
>> +    } else if (flags == GET_KSM_PAGE_LOCK)
>>           lock_page(page);
>> +
>> +    if (flags != GET_KSM_PAGE_NOLOCK) {
>>           if (READ_ONCE(page->mapping) != expected_mapping) {
>>               unlock_page(page);
>>               put_page(page);
>> @@ -763,7 +777,7 @@ static void remove_rmap_item_from_tree(struct 
>> rmap_item *rmap_item)
>>           struct page *page;
>>             stable_node = rmap_item->head;
>> -        page = get_ksm_page(stable_node, true);
>> +        page = get_ksm_page(stable_node, GET_KSM_PAGE_LOCK);
>>           if (!page)
>>               goto out;
>>   @@ -863,7 +877,7 @@ static int remove_stable_node(struct 
>> stable_node *stable_node)
>>       struct page *page;
>>       int err;
>>   -    page = get_ksm_page(stable_node, true);
>> +    page = get_ksm_page(stable_node, GET_KSM_PAGE_LOCK);
>>       if (!page) {
>>           /*
>>            * get_ksm_page did remove_node_from_stable_tree itself.
>> @@ -1385,7 +1399,7 @@ static struct page *stable_node_dup(struct 
>> stable_node **_stable_node_dup,
>>            * stable_node parameter itself will be freed from
>>            * under us if it returns NULL.
>>            */
>> -        _tree_page = get_ksm_page(dup, false);
>> +        _tree_page = get_ksm_page(dup, GET_KSM_PAGE_NOLOCK);
>>           if (!_tree_page)
>>               continue;
>>           nr += 1;
>> @@ -1508,7 +1522,7 @@ static struct page *__stable_node_chain(struct 
>> stable_node **_stable_node_dup,
>>       if (!is_stable_node_chain(stable_node)) {
>>           if (is_page_sharing_candidate(stable_node)) {
>>               *_stable_node_dup = stable_node;
>> -            return get_ksm_page(stable_node, false);
>> +            return get_ksm_page(stable_node, GET_KSM_PAGE_NOLOCK);
>>           }
>>           /*
>>            * _stable_node_dup set to NULL means the stable_node
>> @@ -1613,7 +1627,8 @@ static struct page *stable_tree_search(struct 
>> page *page)
>>                * wrprotected at all times. Any will work
>>                * fine to continue the walk.
>>                */
>> -            tree_page = get_ksm_page(stable_node_any, false);
>> +            tree_page = get_ksm_page(stable_node_any,
>> +                         GET_KSM_PAGE_NOLOCK);
>>           }
>>           VM_BUG_ON(!stable_node_dup ^ !!stable_node_any);
>>           if (!tree_page) {
>> @@ -1673,7 +1688,12 @@ static struct page *stable_tree_search(struct 
>> page *page)
>>                * It would be more elegant to return stable_node
>>                * than kpage, but that involves more changes.
>>                */
>> -            tree_page = get_ksm_page(stable_node_dup, true);
>> +            tree_page = get_ksm_page(stable_node_dup,
>> +                         GET_KSM_PAGE_TRYLOCK);
>> +
>> +            if (PTR_ERR(tree_page) == -EBUSY)
>> +                return ERR_PTR(-EBUSY);
>
> or just:
>
>     if (PTR_ERR(tree_page) == -EBUSY)
>         return tree_page;
>
> right?

Either looks fine to me. Returning errno may look more explicit? Anyway 
I really don't have preference.

>
>> +
>>               if (unlikely(!tree_page))
>>                   /*
>>                    * The tree may have been rebalanced,
>> @@ -1842,7 +1862,8 @@ static struct stable_node 
>> *stable_tree_insert(struct page *kpage)
>>                * wrprotected at all times. Any will work
>>                * fine to continue the walk.
>>                */
>> -            tree_page = get_ksm_page(stable_node_any, false);
>> +            tree_page = get_ksm_page(stable_node_any,
>> +                         GET_KSM_PAGE_NOLOCK);
>>           }
>>           VM_BUG_ON(!stable_node_dup ^ !!stable_node_any);
>>           if (!tree_page) {
>> @@ -2060,6 +2081,10 @@ static void cmp_and_merge_page(struct page 
>> *page, struct rmap_item *rmap_item)
>>         /* We first start with searching the page inside the stable 
>> tree */
>>       kpage = stable_tree_search(page);
>> +
>> +    if (PTR_ERR(kpage) == -EBUSY)
>> +        return;
>> +
>>       if (kpage == page && rmap_item->head == stable_node) {
>>           put_page(kpage);
>>           return;
>> @@ -2242,7 +2267,8 @@ static struct rmap_item 
>> *scan_get_next_rmap_item(struct page **page)
>>                 list_for_each_entry_safe(stable_node, next,
>>                            &migrate_nodes, list) {
>> -                page = get_ksm_page(stable_node, false);
>> +                page = get_ksm_page(stable_node,
>> +                            GET_KSM_PAGE_NOLOCK);
>>                   if (page)
>>                       put_page(page);
>>                   cond_resched();
>>
>
> Hi Yang,
>
> The patch looks correct as far doing what it claims to do. I'll leave it
> to others to decide if a trylock-based approach is really what you want,
> for KSM scans. It seems reasonable from my very limited knowledge of
> KSM: there shouldn't be any cases where you really *need* to wait for
> a page lock, because the whole system is really sort of an optimization
> anyway.

Thanks!

Yang

>
>
> thanks,

