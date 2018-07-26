Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95578C28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 07:36:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BA4520673
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 07:36:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BA4520673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728974AbeGZIwE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 04:52:04 -0400
Received: from mx2.suse.de ([195.135.220.15]:43862 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728547AbeGZIwD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 04:52:03 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5C066AD83;
        Thu, 26 Jul 2018 07:36:29 +0000 (UTC)
Date:   Thu, 26 Jul 2018 09:36:27 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Jiang Biao <jiang.biao2@zte.com.cn>
Cc:     akpm@linux-foundation.org, hannes@cmpxchg.org,
        hillf.zj@alibaba-inc.com, minchan@kernel.org, ying.huang@intel.com,
        mgorman@techsingularity.net, n-horiguchi@ah.jp.nec.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        zhong.weidong@zte.com.cn
Subject: Re: [PATCH v2] mm: fix page_freeze_refs and page_unfreeze_refs in
 comments.
Message-ID: <20180726073627.GT28386@dhcp22.suse.cz>
References: <1532590226-106038-1-git-send-email-jiang.biao2@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1532590226-106038-1-git-send-email-jiang.biao2@zte.com.cn>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 26-07-18 15:30:26, Jiang Biao wrote:
> page_freeze_refs/page_unfreeze_refs have already been relplaced by
> page_ref_freeze/page_ref_unfreeze , but they are not modified in
> the comments.
> 
> Signed-off-by: Jiang Biao <jiang.biao2@zte.com.cn>

This looks better.

Acked-by: Michal Hocko <mhocko@suse.com>

Thanks!

> ---
> v1: fix comments in vmscan.
> v2: fix other two places and fix typoes.
> 
>  mm/ksm.c            | 4 ++--
>  mm/memory-failure.c | 2 +-
>  mm/vmscan.c         | 2 +-
>  3 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/ksm.c b/mm/ksm.c
> index a6d43cf..4c39cb67 100644
> --- a/mm/ksm.c
> +++ b/mm/ksm.c
> @@ -703,7 +703,7 @@ static struct page *get_ksm_page(struct stable_node *stable_node, bool lock_it)
>  	 * We cannot do anything with the page while its refcount is 0.
>  	 * Usually 0 means free, or tail of a higher-order page: in which
>  	 * case this node is no longer referenced, and should be freed;
> -	 * however, it might mean that the page is under page_freeze_refs().
> +	 * however, it might mean that the page is under page_ref_freeze().
>  	 * The __remove_mapping() case is easy, again the node is now stale;
>  	 * but if page is swapcache in migrate_page_move_mapping(), it might
>  	 * still be our page, in which case it's essential to keep the node.
> @@ -714,7 +714,7 @@ static struct page *get_ksm_page(struct stable_node *stable_node, bool lock_it)
>  		 * work here too.  We have chosen the !PageSwapCache test to
>  		 * optimize the common case, when the page is or is about to
>  		 * be freed: PageSwapCache is cleared (under spin_lock_irq)
> -		 * in the freeze_refs section of __remove_mapping(); but Anon
> +		 * in the ref_freeze section of __remove_mapping(); but Anon
>  		 * page->mapping reset to NULL later, in free_pages_prepare().
>  		 */
>  		if (!PageSwapCache(page))
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index 9d142b9..c83a174 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -1167,7 +1167,7 @@ int memory_failure(unsigned long pfn, int flags)
>  	 *    R/W the page; let's pray that the page has been
>  	 *    used and will be freed some time later.
>  	 * In fact it's dangerous to directly bump up page count from 0,
> -	 * that may make page_freeze_refs()/page_unfreeze_refs() mismatch.
> +	 * that may make page_ref_freeze()/page_ref_unfreeze() mismatch.
>  	 */
>  	if (!(flags & MF_COUNT_INCREASED) && !get_hwpoison_page(p)) {
>  		if (is_free_buddy_page(p)) {
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 03822f8..02d0c20 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -744,7 +744,7 @@ static int __remove_mapping(struct address_space *mapping, struct page *page,
>  		refcount = 2;
>  	if (!page_ref_freeze(page, refcount))
>  		goto cannot_free;
> -	/* note: atomic_cmpxchg in page_freeze_refs provides the smp_rmb */
> +	/* note: atomic_cmpxchg in page_ref_freeze provides the smp_rmb */
>  	if (unlikely(PageDirty(page))) {
>  		page_ref_unfreeze(page, refcount);
>  		goto cannot_free;
> -- 
> 2.7.4
> 

-- 
Michal Hocko
SUSE Labs
