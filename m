Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AEA3C41518
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 00:24:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34045218A2
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 00:24:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="BtOwafei"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726519AbfAXAX6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 19:23:58 -0500
Received: from hqemgate14.nvidia.com ([216.228.121.143]:8067 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726078AbfAXAX6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 19:23:58 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c49058b0000>; Wed, 23 Jan 2019 16:23:39 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Wed, 23 Jan 2019 16:23:57 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Wed, 23 Jan 2019 16:23:57 -0800
Received: from [10.110.48.28] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 24 Jan
 2019 00:23:56 +0000
Subject: Re: [v2 PATCH] mm: ksm: do not block on page lock when searching
 stable tree
To:     Yang Shi <yang.shi@linux.alibaba.com>, <ktkhai@virtuozzo.com>,
        <hughd@google.com>, <aarcange@redhat.com>,
        <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
References: <1548287573-15084-1-git-send-email-yang.shi@linux.alibaba.com>
From:   John Hubbard <jhubbard@nvidia.com>
X-Nvconfidentiality: public
Message-ID: <aecc642c-d485-ed95-7935-19cda48800bc@nvidia.com>
Date:   Wed, 23 Jan 2019 16:23:56 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1548287573-15084-1-git-send-email-yang.shi@linux.alibaba.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US-large
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1548289419; bh=WKVPpYTc1aT5qPPOxmBAIk3y3CbZDzFD22w9FFX3QWw=;
        h=X-PGP-Universal:Subject:To:CC:References:From:X-Nvconfidentiality:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=BtOwafeiEXgC2KiqqX2pf2pRZIdk9LGkRl6qasfM+kOZV+o2jCz+I+IYU8oXynaBy
         CaS8P76IDotSoYwsshn/9WvHBQMcTlFRNaXL/sRxK2b27CDIGBhe5Q0QfACaKPOVjB
         Y9r9BNQrIyLdbBjjOXt6KADdukxmCmpQ1C/oEqL7FM36SXl7WZkELP3QfZKmtLyuDz
         HEyDS2gwZYOFpTljKQnyt1SRlnqutHdUALvLUt6RjBoLfQg8oF2aN1t2MPo9S59g9/
         DCZ08g6kQm2+TNPaPNVhheZ7f2nwyE7B0bURbFT7wtBOd7jDASRMKhdjP6+59cs0l7
         hjltB70Jf4N8g==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/23/19 3:52 PM, Yang Shi wrote:
> ksmd need search stable tree to look for the suitable KSM page, but the
> KSM page might be locked for a while due to i.e. KSM page rmap walk.
> Basically it is not a big deal since commit 2c653d0ee2ae
> ("ksm: introduce ksm_max_page_sharing per page deduplication limit"),
> since max_page_sharing limits the number of shared KSM pages.
> 
> But it still sounds not worth waiting for the lock, the page can be skip,
> then try to merge it in the next scan to avoid potential stall if its
> content is still intact.
> 
> Introduce async mode to get_ksm_page() to not block on page lock, like
> what try_to_merge_one_page() does.
> 
> Return -EBUSY if trylock fails, since NULL means not find suitable KSM
> page, which is a valid case.
> 
> With the default max_page_sharing setting (256), there is almost no
> observed change comparing lock vs trylock.
> 
> However, with ksm02 of LTP, the reduced ksmd full scan time can be
> observed, which has set max_page_sharing to 786432.  With lock version,
> ksmd may tak 10s - 11s to run two full scans, with trylock version ksmd
> may take 8s - 11s to run two full scans.  And, the number of
> pages_sharing and pages_to_scan keep same.  Basically, this change has
> no harm.
> 
> Cc: Hugh Dickins <hughd@google.com>
> Cc: Andrea Arcangeli <aarcange@redhat.com>
> Reviewed-by: Kirill Tkhai <ktkhai@virtuozzo.com>
> Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
> ---
> Hi folks,
> 
> This patch was with "mm: vmscan: skip KSM page in direct reclaim if priority
> is low" in the initial submission.  Then Hugh and Andrea pointed out commit
> 2c653d0ee2ae ("ksm: introduce ksm_max_page_sharing per page deduplication
> limit") is good enough for limiting the number of shared KSM page to prevent
> from softlock when walking ksm page rmap.  This commit does solve the problem.
> So, the series was dropped by Andrew from -mm tree.
> 
> However, I thought the second patch (this one) still sounds useful.  So, I did
> some test and resubmit it.  The first version was reviewed by Krill Tkhai, so
> I keep his Reviewed-by tag since there is no change to the patch except the
> commit log.
> 
> So, would you please reconsider this patch?
> 
> v2: Updated the commit log to reflect some test result and latest discussion
> 
>  mm/ksm.c | 29 +++++++++++++++++++++++++----
>  1 file changed, 25 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/ksm.c b/mm/ksm.c
> index 6c48ad1..f66405c 100644
> --- a/mm/ksm.c
> +++ b/mm/ksm.c
> @@ -668,7 +668,7 @@ static void remove_node_from_stable_tree(struct stable_node *stable_node)
>  }
>  
>  /*
> - * get_ksm_page: checks if the page indicated by the stable node
> + * __get_ksm_page: checks if the page indicated by the stable node
>   * is still its ksm page, despite having held no reference to it.
>   * In which case we can trust the content of the page, and it
>   * returns the gotten page; but if the page has now been zapped,
> @@ -686,7 +686,8 @@ static void remove_node_from_stable_tree(struct stable_node *stable_node)
>   * a page to put something that might look like our key in page->mapping.
>   * is on its way to being freed; but it is an anomaly to bear in mind.
>   */
> -static struct page *get_ksm_page(struct stable_node *stable_node, bool lock_it)
> +static struct page *__get_ksm_page(struct stable_node *stable_node,
> +				   bool lock_it, bool async)
>  {
>  	struct page *page;
>  	void *expected_mapping;
> @@ -729,7 +730,14 @@ static struct page *get_ksm_page(struct stable_node *stable_node, bool lock_it)
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
> @@ -752,6 +760,11 @@ static struct page *get_ksm_page(struct stable_node *stable_node, bool lock_it)
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
> @@ -1673,7 +1686,11 @@ static struct page *stable_tree_search(struct page *page)
>  			 * It would be more elegant to return stable_node
>  			 * than kpage, but that involves more changes.
>  			 */
> -			tree_page = get_ksm_page(stable_node_dup, true);
> +			tree_page = __get_ksm_page(stable_node_dup, true, true);

Hi Yang,

The bools are stacking up: now you've got two, and the above invocation is no longer
understandable on its own. At this point, we normally shift to flags and/or an
enum.

Also, I see little value in adding a stub function here, so how about something more
like the following approximation (untested, and changes to callers are not shown):

diff --git a/mm/ksm.c b/mm/ksm.c
index 6c48ad13b4c9..8390b7905b44 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -667,6 +667,12 @@ static void remove_node_from_stable_tree(struct stable_node *stable_node)
        free_stable_node(stable_node);
 }
 
+typedef enum {
+       GET_KSM_PAGE_NORMAL,
+       GET_KSM_PAGE_LOCK_PAGE,
+       GET_KSM_PAGE_TRYLOCK_PAGE
+} get_ksm_page_t;
+
 /*
  * get_ksm_page: checks if the page indicated by the stable node
  * is still its ksm page, despite having held no reference to it.
@@ -686,7 +692,8 @@ static void remove_node_from_stable_tree(struct stable_node *stable_node)
  * a page to put something that might look like our key in page->mapping.
  * is on its way to being freed; but it is an anomaly to bear in mind.
  */
-static struct page *get_ksm_page(struct stable_node *stable_node, bool lock_it)
+static struct page *get_ksm_page(struct stable_node *stable_node,
+                                get_ksm_page_t flags)
 {
        struct page *page;
        void *expected_mapping;
@@ -728,8 +735,17 @@ static struct page *get_ksm_page(struct stable_node *stable_node, bool lock_it)
                goto stale;
        }
 
-       if (lock_it) {
+       if (flags == GET_KSM_PAGE_TRYLOCK_PAGE) {
+               if (!trylock_page(page)) {
+                       put_page(page);
+                       return ERR_PTR(-EBUSY);
+               }
+       } else if (flags == GET_KSM_PAGE_LOCK_PAGE) {
                lock_page(page);
+       }
+
+       if (flags == GET_KSM_PAGE_LOCK_PAGE ||
+           flags == GET_KSM_PAGE_TRYLOCK_PAGE) {
                if (READ_ONCE(page->mapping) != expected_mapping) {
                        unlock_page(page);
                        put_page(page);


thanks,
-- 
John Hubbard
NVIDIA 

> +
> +			if (PTR_ERR(tree_page) == -EBUSY)
> +				return ERR_PTR(-EBUSY);
> +
>  			if (unlikely(!tree_page))
>  				/*
>  				 * The tree may have been rebalanced,
> @@ -2060,6 +2077,10 @@ static void cmp_and_merge_page(struct page *page, struct rmap_item *rmap_item)
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
