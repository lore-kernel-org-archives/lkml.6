Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E50CC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 07:03:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34A52206B2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 07:03:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34A52206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502230AbeKWRqI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 12:46:08 -0500
Received: from relay.sw.ru ([185.231.240.75]:57032 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389987AbeKWRqI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 12:46:08 -0500
Received: from [172.16.25.169]
        by relay.sw.ru with esmtp (Exim 4.91)
        (envelope-from <ktkhai@virtuozzo.com>)
        id 1gQ5UX-0000hx-Qp; Fri, 23 Nov 2018 10:03:05 +0300
Subject: Re: [PATCH 2/2] mm: ksm: do not block on page lock when searching
 stable tree
To:     Yang Shi <yang.shi@linux.alibaba.com>, mhocko@kernel.org,
        vbabka@suse.cz, hannes@cmpxchg.org, hughd@google.com,
        akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <1541618201-120667-1-git-send-email-yang.shi@linux.alibaba.com>
 <1541618201-120667-2-git-send-email-yang.shi@linux.alibaba.com>
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <302f3116-7e53-2750-ec2d-b90feb4cafec@virtuozzo.com>
Date:   Fri, 23 Nov 2018 10:03:04 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <1541618201-120667-2-git-send-email-yang.shi@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07.11.2018 22:16, Yang Shi wrote:
> ksmd need search stable tree to look for the suitable KSM page, but the
> KSM page might be locked for long time due to i.e. KSM page rmap walk.
> 
> It sounds not worth waiting for the lock, the page can be skip, then try
> to merge it in the next scan to avoid long stall if its content is
> still intact.
> 
> Introduce async mode to get_ksm_page() to not block on page lock, like
> what try_to_merge_one_page() does.
> 
> Return -EBUSY if trylock fails, since NULL means not find suitable KSM
> page, which is a valid case.
> 
> Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>

Reviewed-by: Kirill Tkhai <ktkhai@virtuozzo.com>

> ---
>  mm/ksm.c | 29 +++++++++++++++++++++++++----
>  1 file changed, 25 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/ksm.c b/mm/ksm.c
> index 5b0894b..576803d 100644
> --- a/mm/ksm.c
> +++ b/mm/ksm.c
> @@ -667,7 +667,7 @@ static void remove_node_from_stable_tree(struct stable_node *stable_node)
>  }
>  
>  /*
> - * get_ksm_page: checks if the page indicated by the stable node
> + * __get_ksm_page: checks if the page indicated by the stable node
>   * is still its ksm page, despite having held no reference to it.
>   * In which case we can trust the content of the page, and it
>   * returns the gotten page; but if the page has now been zapped,
> @@ -685,7 +685,8 @@ static void remove_node_from_stable_tree(struct stable_node *stable_node)
>   * a page to put something that might look like our key in page->mapping.
>   * is on its way to being freed; but it is an anomaly to bear in mind.
>   */
> -static struct page *get_ksm_page(struct stable_node *stable_node, bool lock_it)
> +static struct page *__get_ksm_page(struct stable_node *stable_node,
> +				   bool lock_it, bool async)
>  {
>  	struct page *page;
>  	void *expected_mapping;
> @@ -728,7 +729,14 @@ static struct page *get_ksm_page(struct stable_node *stable_node, bool lock_it)
>  	}
>  
>  	if (lock_it) {
> -		lock_page(page);
> +		if (async) {
> +			if (!trylock_page(page)) {
> +				put_page(page);
> +				return ERR_PTR(-EBUSY);
> +			}
> +		} else
> +			lock_page(page);
> +
>  		if (READ_ONCE(page->mapping) != expected_mapping) {
>  			unlock_page(page);
>  			put_page(page);
> @@ -751,6 +759,11 @@ static struct page *get_ksm_page(struct stable_node *stable_node, bool lock_it)
>  	return NULL;
>  }
>  
> +static struct page *get_ksm_page(struct stable_node *stable_node, bool lock_it)
> +{
> +	return __get_ksm_page(stable_node, lock_it, false);
> +}
> +
>  /*
>   * Removing rmap_item from stable or unstable tree.
>   * This function will clean the information from the stable/unstable tree.
> @@ -1675,7 +1688,11 @@ static struct page *stable_tree_search(struct page *page)
>  			 * It would be more elegant to return stable_node
>  			 * than kpage, but that involves more changes.
>  			 */
> -			tree_page = get_ksm_page(stable_node_dup, true);
> +			tree_page = __get_ksm_page(stable_node_dup, true, true);
> +
> +			if (PTR_ERR(tree_page) == -EBUSY)
> +				return ERR_PTR(-EBUSY);
> +
>  			if (unlikely(!tree_page))
>  				/*
>  				 * The tree may have been rebalanced,
> @@ -2062,6 +2079,10 @@ static void cmp_and_merge_page(struct page *page, struct rmap_item *rmap_item)
>  
>  	/* We first start with searching the page inside the stable tree */
>  	kpage = stable_tree_search(page);
> +
> +	if (PTR_ERR(kpage) == -EBUSY)
> +		return;
> +
>  	if (kpage == page && rmap_item->head == stable_node) {
>  		put_page(kpage);
>  		return;
> 
