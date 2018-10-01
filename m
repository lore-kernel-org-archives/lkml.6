Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94A28C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 20:22:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FAEC20666
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 20:22:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CnGgCaMe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FAEC20666
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726373AbeJBDBw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 23:01:52 -0400
Received: from merlin.infradead.org ([205.233.59.134]:42740 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbeJBDBv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 23:01:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=UVKeRRvdGHOd1nSOef61Zwf5bwv1Av0voJjkRCRFudI=; b=CnGgCaMeG9dJ1+NLNLQ3yehu0a
        TS2vpxtj9O8UIREHiEKwGhU0qpJHssFNohwCMWN8qgYgdU5Ie6cY398ToYqw1HNVW7cw0kK1+LGM7
        DqilsjqPZlhDBkexxlK+XwdPk44zgpFsV9NKGNwJ16HTRhF19qhcVdLi9dVZSrqgifHowWcZOA3ld
        GDDYt+texYiOaxtC+2TBkdot/6KFLFvbT1BhblXUKPj/HZIej62Y7LNxX6aQE2Qs29AOwxPuNn3Pd
        fmBVmHYNGpOkkyey0St+sD6xaN8YWBRhamPCRB7QWODhmKzh0FQQUg3N6eXVON/v6sjpGATeCCx9V
        D1qMz6GQ==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g74hq-0000qy-42; Mon, 01 Oct 2018 20:22:14 +0000
Subject: Re: [PATCH] dma-direct: document the zone selection logic
To:     Christoph Hellwig <hch@lst.de>, iommu@lists.linux-foundation.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linux-kernel@vger.kernel.org
References: <20181001201016.32639-1-hch@lst.de>
 <20181001201016.32639-2-hch@lst.de>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <4e9fd184-2ee4-1971-dcd9-34bfb8c05f65@infradead.org>
Date:   Mon, 1 Oct 2018 13:22:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20181001201016.32639-2-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/1/18 1:10 PM, Christoph Hellwig wrote:
> What we are doing here isn't quite obvious, so add a comment explaining
> it.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  kernel/dma/direct.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
> index ba6f5956a291..14b966e2349a 100644
> --- a/kernel/dma/direct.c
> +++ b/kernel/dma/direct.c
> @@ -84,7 +84,14 @@ static gfp_t __dma_direct_optimal_gfp_mask(struct device *dev, u64 dma_mask,
>  	else
>  		*phys_mask = dma_to_phys(dev, dma_mask);
>  
> -	/* GFP_DMA32 and GFP_DMA are no ops without the corresponding zones: */
> +	/*
> +	 * Optimistically try the zone that the physicall address mask falls

	                                        physical

> +	 * into first.  If that returns memory that isn't actually addressable
> +	 * we will fallback to the next lower zone and try again.
> +	 *
> +	 * Note that GFP_DMA32 and GFP_DMA are no ops without the corresponding
> +	 * zones.
> +	 */
>  	if (*phys_mask <= DMA_BIT_MASK(ARCH_ZONE_DMA_BITS))
>  		return GFP_DMA;
>  	if (*phys_mask <= DMA_BIT_MASK(32))
> 

thanks for the documentation.

-- 
~Randy
