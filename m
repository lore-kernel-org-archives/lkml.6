Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81846C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 14:15:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 520FD2070B
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 14:15:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QiF8l3sY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727078AbfAGOPs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 09:15:48 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:42806 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726746AbfAGOPs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 09:15:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=tyjMoiH4P3KcOYrj6SCeq/q34vEUy4KTBkQwzS3aQwg=; b=QiF8l3sYPxS+7nBq81w47X0/C
        M+5pdqzRbJzZjshXvLgC1r1+0fbf6p6L+9CQpFzdkdJ+7FzmB7dEjub6x+w+p06HBwhjqhDdZL/6T
        iiem+3WhumYKWpviuVSX5tDHF/ycB2n7zL8j11cwAX7M2MRkoZec+el23PcVoBWdjszsb6ys5YpP7
        bRYsUsh0QrYCvDDz9QimqECiifUJ1Ar6H6JjmL02Tkx9mdwE0GaBeZ4/7MnaqvtWP/zaaxv4Vwi+W
        boYjdBkwY2c5UFVoNnu2Q6yy9YYHDrWk/50wDRUVwRvSDkTCs0xfpX5LintP/qPJ8Ukoy/Ak7yUI0
        svvV0EFcQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1ggVgv-0002Qa-KS; Mon, 07 Jan 2019 14:15:45 +0000
Date:   Mon, 7 Jan 2019 06:15:45 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>
Cc:     akpm@linux-foundation.org, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, mcgrof@kernel.org,
        keescook@chromium.org, corbet@lwn.net, linux-doc@vger.kernel.org,
        Vincent Whitchurch <rabinv@axis.com>
Subject: Re: [PATCH] drop_caches: Allow unmapping pages
Message-ID: <20190107141545.GX6310@bombadil.infradead.org>
References: <20190107130239.3417-1-vincent.whitchurch@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190107130239.3417-1-vincent.whitchurch@axis.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 07, 2019 at 02:02:39PM +0100, Vincent Whitchurch wrote:
> +++ b/Documentation/sysctl/vm.txt
> @@ -222,6 +222,10 @@ To increase the number of objects freed by this operation, the user may run
>  number of dirty objects on the system and create more candidates to be
>  dropped.
>  
> +By default, pages which are currently mapped are not dropped from the
> +pagecache.  If you want to unmap and drop these pages too, echo 9 or 11 instead
> +of 1 or 3 respectively (set bit 4).

Typically we number bits from 0, so this would be bit 3, not 4.  I do see
elsewhere in this file somebody else got this wrong:

: with your system.  To disable them, echo 4 (bit 3) into drop_caches.

but that should also be fixed.

> +static int __invalidate_inode_page(struct page *page, bool unmap)
> +{
> +	struct address_space *mapping = page_mapping(page);
> +	if (!mapping)
> +		return 0;
> +	if (PageDirty(page) || PageWriteback(page))
> +		return 0;
> +	if (page_mapped(page)) {
> +		if (!unmap)
> +			return 0;
> +		if (!try_to_unmap(page, TTU_IGNORE_ACCESS))
> +			return 0;

You're going to get data corruption doing this.  try_to_unmap_one() does:

                /* Move the dirty bit to the page. Now the pte is gone. */
                if (pte_dirty(pteval))
                        set_page_dirty(page);

so PageDirty() can be false above, but made true by calling try_to_unmap().

I also think the way you've done this is expedient at the cost of
efficiency and layering violations.  I think you should first tear
down the mappings of userspace processes (which will reclaim a lot
of pages allocated to page tables), then you won't need to touch the
invalidate_inode_pages paths at all.

