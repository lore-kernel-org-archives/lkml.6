Return-Path: <SRS0=Aihr=QY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0702C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 11:29:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A313721B69
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 11:29:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bILEhpIU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728581AbfBQL3s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Feb 2019 06:29:48 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:49630 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726168AbfBQL3r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Feb 2019 06:29:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=rXiUAXlA4Y4NVU1+nGtiu2iiqqDtjUNA9mpoGknFqWQ=; b=bILEhpIUWBFNWSR42Wf71Z99F
        AhGCHBIy/mlttSXoA1pWjgcAeH3AhOiAeg0yN7/YCU8hODtO/MYWkwW0jN/dbsttWYCYg3QuC8CFF
        uCeaspFD090sg7VcupXePFXHnDcCkLYG1gNKy/QtXP5MiPgpr6fFck+BRYN/69StopET93VAeQFFt
        3+2iDoxJcjncSU6R0++wShu3sMBLEZSxTKOytpXkzstjlMtZ5PybcJN6/KjtjlL0Uf2/KlcU/HCCM
        xCQgcLxIOFtUhrmOd5tUn+c//WQIYteh9BEp85M8HPNtrZ9pQgx2tfHjaah81uUelMvz/4PDYnD1q
        isJcGcoqg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gvKdm-0004aK-8D; Sun, 17 Feb 2019 11:29:46 +0000
Date:   Sun, 17 Feb 2019 03:29:46 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     ziy@nvidia.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Michal Hocko <mhocko@kernel.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        John Hubbard <jhubbard@nvidia.com>,
        Mark Hairgrove <mhairgrove@nvidia.com>,
        Nitin Gupta <nigupta@nvidia.com>,
        David Nellans <dnellans@nvidia.com>
Subject: Re: [RFC PATCH 01/31] mm: migrate: Add exchange_pages to exchange
 two lists of pages.
Message-ID: <20190217112943.GP12668@bombadil.infradead.org>
References: <20190215220856.29749-1-zi.yan@sent.com>
 <20190215220856.29749-2-zi.yan@sent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190215220856.29749-2-zi.yan@sent.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 15, 2019 at 02:08:26PM -0800, Zi Yan wrote:
> +struct page_flags {
> +	unsigned int page_error :1;
> +	unsigned int page_referenced:1;
> +	unsigned int page_uptodate:1;
> +	unsigned int page_active:1;
> +	unsigned int page_unevictable:1;
> +	unsigned int page_checked:1;
> +	unsigned int page_mappedtodisk:1;
> +	unsigned int page_dirty:1;
> +	unsigned int page_is_young:1;
> +	unsigned int page_is_idle:1;
> +	unsigned int page_swapcache:1;
> +	unsigned int page_writeback:1;
> +	unsigned int page_private:1;
> +	unsigned int __pad:3;
> +};

I'm not sure how to feel about this.  It's a bit fragile versus somebody adding
new page flags.  I don't know whether it's needed or whether you can just
copy page->flags directly because you're holding PageLock.

> +static void exchange_page(char *to, char *from)
> +{
> +	u64 tmp;
> +	int i;
> +
> +	for (i = 0; i < PAGE_SIZE; i += sizeof(tmp)) {
> +		tmp = *((u64 *)(from + i));
> +		*((u64 *)(from + i)) = *((u64 *)(to + i));
> +		*((u64 *)(to + i)) = tmp;
> +	}
> +}

I have a suspicion you'd be better off allocating a temporary page and
using copy_page().  Some architectures have put a lot of effort into
making copy_page() run faster.

> +		xa_lock_irq(&to_mapping->i_pages);
> +
> +		to_pslot = radix_tree_lookup_slot(&to_mapping->i_pages,
> +			page_index(to_page));

This needs to be converted to the XArray.  radix_tree_lookup_slot() is
going away soon.  You probably need:

	XA_STATE(to_xas, &to_mapping->i_pages, page_index(to_page));

This is a lot of code and I'm still trying to get my head aroud it all.
Thanks for putting in this work; it's good to see this approach being
explored.
