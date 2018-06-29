Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE109C43144
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 06:21:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9913427B33
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 06:21:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dOZME6Nd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9913427B33
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933891AbeF2GVo (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 02:21:44 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:56394 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933673AbeF2GV3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 02:21:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ebZ2v2c6aypxo5GBpQA28oz8ZOr6I8YtAVamOmEXT30=; b=dOZME6NdhtgYROZohXiHRELuI
        7K2TNXnEZAFU9c+6OhreuewXWXBUqJVjr21yDuLQptsP4hO06XjOjvvZ0BdOoosVeAsTGsZYDpW0R
        VHHqsa1LtIueUD7slhYJFK0UMLCL+6a7o2AY5zumOMymL2VEjXTK4vHOVF5FzGXL3L4jd3pg940QI
        ssFwo4ikthjp8OZq555l1pYnYoZpYXL9/CHvQ5i5Ki1Nolg1TW8HxEeK0QlEM1mQ2Ehfl5mu5ZHBS
        Pl7oUQ+DqdcnWgbdGHwuo0PXLIL1YY/V6RkSE8sfd/YMN5/kmdZQqxQeHSIP2olYwBl5Fjqc7ch+w
        p+xK1UGqw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fYmmc-0004si-Mz; Fri, 29 Jun 2018 06:21:26 +0000
Date:   Thu, 28 Jun 2018 23:21:26 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shaohua Li <shli@kernel.org>, Hugh Dickins <hughd@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Rik van Riel <riel@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Zi Yan <zi.yan@cs.rutgers.edu>,
        Daniel Jordan <daniel.m.jordan@oracle.com>
Subject: Re: [PATCH -mm -v4 08/21] mm, THP, swap: Support to read a huge swap
 cluster for swapin a THP
Message-ID: <20180629062126.GJ7646@bombadil.infradead.org>
References: <20180622035151.6676-1-ying.huang@intel.com>
 <20180622035151.6676-9-ying.huang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180622035151.6676-9-ying.huang@intel.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 22, 2018 at 11:51:38AM +0800, Huang, Ying wrote:
> +++ b/mm/swap_state.c
> @@ -426,33 +447,37 @@ struct page *__read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
>  		/*
>  		 * call radix_tree_preload() while we can wait.
>  		 */
> -		err = radix_tree_maybe_preload(gfp_mask & GFP_KERNEL);
> +		err = radix_tree_maybe_preload_order(gfp_mask & GFP_KERNEL,
> +						     compound_order(new_page));
>  		if (err)
>  			break;

There's no more preloading in the XArray world, so this can just be dropped.

>  		/*
>  		 * Swap entry may have been freed since our caller observed it.
>  		 */
> +		err = swapcache_prepare(hentry, huge_cluster);
> +		if (err) {
>  			radix_tree_preload_end();
> -			break;
> +			if (err == -EEXIST) {
> +				/*
> +				 * We might race against get_swap_page() and
> +				 * stumble across a SWAP_HAS_CACHE swap_map
> +				 * entry whose page has not been brought into
> +				 * the swapcache yet.
> +				 */
> +				cond_resched();
> +				continue;
> +			} else if (err == -ENOTDIR) {
> +				/* huge swap cluster is split under us */
> +				continue;
> +			} else		/* swp entry is obsolete ? */
> +				break;

I'm not entirely happy about -ENOTDIR being overloaded to mean this.
Maybe we can return a new enum rather than an errno?

Also, I'm not sure that a true/false parameter is the right approach for
"is this a huge page".  I think we'll have usecases for swap entries which
are both larger and smaller than PMD_SIZE.

I was hoping to encode the swap entry size into the entry; we only need one
extra bit to do that (no matter the size of the entry).  I detailed the
encoding scheme here:

https://plus.google.com/117536210417097546339/posts/hvctn17WUZu

(let me know if that doesn't work for you; I'm not very experienced with
this G+ thing)
