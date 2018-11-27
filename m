Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5159C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 20:38:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA76721104
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 20:38:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="HomFAHjO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA76721104
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbeK1Hh7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 02:37:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:35530 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726068AbeK1Hh6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 02:37:58 -0500
Received: from localhost (c-67-164-102-47.hsd1.ca.comcast.net [67.164.102.47])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C9914208E4;
        Tue, 27 Nov 2018 20:38:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543351132;
        bh=2qeOJiUrw7NVOTYHjn6yUIchkNdcaWfykP2gU4BOqPg=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=HomFAHjO4F5HNcoYisDQsaxJykh5lNktinlsjaV6Ee7VFJ9GbZEQ8wlXD9OApQH7w
         E2TbOzVCS548blp8NxPQWZ1V30ta+v+GgfVkjxqqKPPXxAMOhTPdUtZqJm9/aNEGKL
         KzTkEU/3CQSOCpaiemK+T95Ez6D7RX0Zc2fy2UE4=
Date:   Tue, 27 Nov 2018 12:38:49 -0800 (PST)
From:   Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@sstabellini-ThinkPad-X260
To:     Robin Murphy <robin.murphy@arm.com>
cc:     hch@lst.de, konrad.wilk@oracle.com, m.szyprowski@samsung.com,
        john.stultz@linaro.org, iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        sstabellini@kernel.org
Subject: Re: [PATCH v2 2/2] swiotlb: Skip cache maintenance on map error
In-Reply-To: <cc6d91acc357235cbd6e0e134382c58caa188801.1542812807.git.robin.murphy@arm.com>
Message-ID: <alpine.DEB.2.10.1811271238290.4577@sstabellini-ThinkPad-X260>
References: <cover.1542812807.git.robin.murphy@arm.com> <cc6d91acc357235cbd6e0e134382c58caa188801.1542812807.git.robin.murphy@arm.com>
User-Agent: Alpine 2.10 (DEB 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Nov 2018, Robin Murphy wrote:
> If swiotlb_bounce_page() failed, calling arch_sync_dma_for_device() may
> lead to such delights as performing cache maintenance on whatever
> address phys_to_virt(SWIOTLB_MAP_ERROR) looks like, which is typically
> outside the kernel memory map and goes about as well as expected.
> 
> Don't do that.
> 
> Fixes: a4a4330db46a ("swiotlb: add support for non-coherent DMA")
> Tested-by: John Stultz <john.stultz@linaro.org>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>

Acked-by: Stefano Stabellini <sstabellini@kernel.org>

> ---
> 
> v2: Collect tags
> 
>  kernel/dma/swiotlb.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> index 5731daa09a32..045930e32c0e 100644
> --- a/kernel/dma/swiotlb.c
> +++ b/kernel/dma/swiotlb.c
> @@ -679,7 +679,8 @@ dma_addr_t swiotlb_map_page(struct device *dev, struct page *page,
>  	}
>  
>  	if (!dev_is_dma_coherent(dev) &&
> -	    (attrs & DMA_ATTR_SKIP_CPU_SYNC) == 0)
> +	    (attrs & DMA_ATTR_SKIP_CPU_SYNC) == 0 &&
> +	    dev_addr != DIRECT_MAPPING_ERROR)
>  		arch_sync_dma_for_device(dev, phys, size, dir);
>  
>  	return dev_addr;
> -- 
> 2.19.1.dirty
> 
