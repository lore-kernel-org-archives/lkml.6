Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63545C43144
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 06:04:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1240524DFB
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 06:04:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="d7FrFujc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1240524DFB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753953AbeF2GES (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 02:04:18 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:54414 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753116AbeF2GER (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 02:04:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=+Jy+DzfqU9I0iBCIPQQRdQd5XQzgmxw4O2/lcuWTl90=; b=d7FrFujc3f6cGLZfhCLeCK9Pt
        KaLyXTepcoJJONDr6qbffcxcjfVy3XMHcKosnnus72PCfEygi7XfwXo2KeqGSylun31Ir9hPjWN5P
        LGS2HdPt8vJfBEAIvIF+UOqFQq/x53EJwmD4oFlm0fbF5+Zy8DEb/3ZlkZc/XcstNFv027lAv1APm
        opRtoUwKdoxpQCEsEVivv7CwIXV0+3vMlfe8+pswCJROqRIjFXwkWKuw+rlehoMuOdDzTmYd29S7R
        WLj9ThTDMFbLXQxpyYaqE7I3BFNjkhdkR4FcQZlO7340JX9kROlHRS0RGVkHBOxYmjIAUqkB5N/wD
        W6wVhoa4A==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fYmVw-0006mr-6n; Fri, 29 Jun 2018 06:04:12 +0000
Date:   Thu, 28 Jun 2018 23:04:12 -0700
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
Subject: Re: [PATCH -mm -v4 03/21] mm, THP, swap: Support PMD swap mapping in
 swap_duplicate()
Message-ID: <20180629060412.GI7646@bombadil.infradead.org>
References: <20180622035151.6676-1-ying.huang@intel.com>
 <20180622035151.6676-4-ying.huang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180622035151.6676-4-ying.huang@intel.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 22, 2018 at 11:51:33AM +0800, Huang, Ying wrote:
> +++ b/mm/swap_state.c
> @@ -433,7 +433,7 @@ struct page *__read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
>  		/*
>  		 * Swap entry may have been freed since our caller observed it.
>  		 */
> -		err = swapcache_prepare(entry);
> +		err = swapcache_prepare(entry, false);
>  		if (err == -EEXIST) {
>  			radix_tree_preload_end();
>  			/*

This commit should be just a textual conflict.

