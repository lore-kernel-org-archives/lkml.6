Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0A2BC67863
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 00:41:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D5DB21480
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 00:41:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GnBZnhvl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D5DB21480
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726627AbeJSIpR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 04:45:17 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:39138 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725910AbeJSIpR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 04:45:17 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w9J0d14q159919;
        Fri, 19 Oct 2018 00:40:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=Eoq81b1jj0db9rvXBVs9vmDZ/R/FglvGc4MiC6l7+kM=;
 b=GnBZnhvlDPxuxKh0OpHRDfoanOrFngAhV2WmIhZH8LWCed90b21xjF4irRSehDNM9SnD
 saBql0JmRGWUlgkiW3pgOhrJl5LN+lZ4oROVc5n9gnnMcVZOQKRQj9yifkCtqXpLPAYq
 BhaMsUp8gPM1Zcc4OdvYt8Z8xjsuSwnXIyxLM8AOvJzfvVztE10akYV4ql9In4QbBYOu
 PjuXKcBewulrFIQvkPjBDO8+krN3V1ZAD29Uj73LaT/LlQyIey8yNVl3GgcC0zrzas1L
 fo7hOtmWElWQrhsr3/1f58wU6Ke+tEOf1gZaM2S6+xeTtyK+w3h13EPHBd7DbI1ejmps 6w== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2120.oracle.com with ESMTP id 2n39brsdts-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 Oct 2018 00:40:52 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w9J0elJ9030891
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 Oct 2018 00:40:47 GMT
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w9J0ekTQ019532;
        Fri, 19 Oct 2018 00:40:46 GMT
Received: from char.us.oracle.com (/10.152.32.25)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 18 Oct 2018 17:40:46 -0700
Received: by char.us.oracle.com (Postfix, from userid 1000)
        id 0C8AF6A0136; Thu, 18 Oct 2018 20:40:45 -0400 (EDT)
Date:   Thu, 18 Oct 2018 20:40:44 -0400
From:   Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/10] swiotlb: don't dip into swiotlb pool for coherent
 allocations
Message-ID: <20181019004044.GJ1251@char.us.oracle.com>
References: <20181008080246.20543-1-hch@lst.de>
 <20181008080246.20543-9-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181008080246.20543-9-hch@lst.de>
User-Agent: Mutt/1.8.3 (2017-05-23)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9050 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1810190005
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 08, 2018 at 10:02:44AM +0200, Christoph Hellwig wrote:
> All architectures that support swiotlb also have a zone that backs up
> these less than full addressing allocations (usually ZONE_DMA32).
> 
> Because of that it is rather pointless to fall back to the global swiotlb
> buffer if the normal dma direct allocation failed - the only thing this
> will do is to eat up bounce buffers that would be more useful to serve
> streaming mappings.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
Acked-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>

Thank you!
> ---
>  arch/arm64/mm/dma-mapping.c |   6 +--
>  include/linux/swiotlb.h     |   5 --
>  kernel/dma/swiotlb.c        | 105 +-----------------------------------
>  3 files changed, 5 insertions(+), 111 deletions(-)
> 
> diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
> index 8d91b927e09e..eee6cfcfde9e 100644
> --- a/arch/arm64/mm/dma-mapping.c
> +++ b/arch/arm64/mm/dma-mapping.c
> @@ -112,7 +112,7 @@ static void *__dma_alloc(struct device *dev, size_t size,
>  		return addr;
>  	}
>  
> -	ptr = swiotlb_alloc(dev, size, dma_handle, flags, attrs);
> +	ptr = dma_direct_alloc_pages(dev, size, dma_handle, flags, attrs);
>  	if (!ptr)
>  		goto no_mem;
>  
> @@ -133,7 +133,7 @@ static void *__dma_alloc(struct device *dev, size_t size,
>  	return coherent_ptr;
>  
>  no_map:
> -	swiotlb_free(dev, size, ptr, *dma_handle, attrs);
> +	dma_direct_free_pages(dev, size, ptr, *dma_handle, attrs);
>  no_mem:
>  	return NULL;
>  }
> @@ -151,7 +151,7 @@ static void __dma_free(struct device *dev, size_t size,
>  			return;
>  		vunmap(vaddr);
>  	}
> -	swiotlb_free(dev, size, swiotlb_addr, dma_handle, attrs);
> +	dma_direct_free_pages(dev, size, swiotlb_addr, dma_handle, attrs);
>  }
>  
>  static dma_addr_t __swiotlb_map_page(struct device *dev, struct page *page,
> diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
> index f847c1b265c4..a387b59640a4 100644
> --- a/include/linux/swiotlb.h
> +++ b/include/linux/swiotlb.h
> @@ -67,11 +67,6 @@ extern void swiotlb_tbl_sync_single(struct device *hwdev,
>  
>  /* Accessory functions. */
>  
> -void *swiotlb_alloc(struct device *hwdev, size_t size, dma_addr_t *dma_handle,
> -		gfp_t flags, unsigned long attrs);
> -void swiotlb_free(struct device *dev, size_t size, void *vaddr,
> -		dma_addr_t dma_addr, unsigned long attrs);
> -
>  extern dma_addr_t swiotlb_map_page(struct device *dev, struct page *page,
>  				   unsigned long offset, size_t size,
>  				   enum dma_data_direction dir,
> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> index 4d7a4d85d71e..475a41eff3dc 100644
> --- a/kernel/dma/swiotlb.c
> +++ b/kernel/dma/swiotlb.c
> @@ -622,78 +622,6 @@ void swiotlb_tbl_sync_single(struct device *hwdev, phys_addr_t tlb_addr,
>  	}
>  }
>  
> -static inline bool dma_coherent_ok(struct device *dev, dma_addr_t addr,
> -		size_t size)
> -{
> -	u64 mask = DMA_BIT_MASK(32);
> -
> -	if (dev && dev->coherent_dma_mask)
> -		mask = dev->coherent_dma_mask;
> -	return addr + size - 1 <= mask;
> -}
> -
> -static void *
> -swiotlb_alloc_buffer(struct device *dev, size_t size, dma_addr_t *dma_handle,
> -		unsigned long attrs)
> -{
> -	phys_addr_t phys_addr;
> -
> -	if (swiotlb_force == SWIOTLB_NO_FORCE)
> -		goto out_warn;
> -
> -	phys_addr = swiotlb_tbl_map_single(dev,
> -			__phys_to_dma(dev, io_tlb_start),
> -			0, size, DMA_FROM_DEVICE, attrs);
> -	if (phys_addr == SWIOTLB_MAP_ERROR)
> -		goto out_warn;
> -
> -	*dma_handle = __phys_to_dma(dev, phys_addr);
> -	if (!dma_coherent_ok(dev, *dma_handle, size))
> -		goto out_unmap;
> -
> -	memset(phys_to_virt(phys_addr), 0, size);
> -	return phys_to_virt(phys_addr);
> -
> -out_unmap:
> -	dev_warn(dev, "hwdev DMA mask = 0x%016Lx, dev_addr = 0x%016Lx\n",
> -		(unsigned long long)dev->coherent_dma_mask,
> -		(unsigned long long)*dma_handle);
> -
> -	/*
> -	 * DMA_TO_DEVICE to avoid memcpy in unmap_single.
> -	 * DMA_ATTR_SKIP_CPU_SYNC is optional.
> -	 */
> -	swiotlb_tbl_unmap_single(dev, phys_addr, size, DMA_TO_DEVICE,
> -			DMA_ATTR_SKIP_CPU_SYNC);
> -out_warn:
> -	if (!(attrs & DMA_ATTR_NO_WARN) && printk_ratelimit()) {
> -		dev_warn(dev,
> -			"swiotlb: coherent allocation failed, size=%zu\n",
> -			size);
> -		dump_stack();
> -	}
> -	return NULL;
> -}
> -
> -static bool swiotlb_free_buffer(struct device *dev, size_t size,
> -		dma_addr_t dma_addr)
> -{
> -	phys_addr_t phys_addr = dma_to_phys(dev, dma_addr);
> -
> -	WARN_ON_ONCE(irqs_disabled());
> -
> -	if (!is_swiotlb_buffer(phys_addr))
> -		return false;
> -
> -	/*
> -	 * DMA_TO_DEVICE to avoid memcpy in swiotlb_tbl_unmap_single.
> -	 * DMA_ATTR_SKIP_CPU_SYNC is optional.
> -	 */
> -	swiotlb_tbl_unmap_single(dev, phys_addr, size, DMA_TO_DEVICE,
> -				 DMA_ATTR_SKIP_CPU_SYNC);
> -	return true;
> -}
> -
>  static dma_addr_t swiotlb_bounce_page(struct device *dev, phys_addr_t *phys,
>  		size_t size, enum dma_data_direction dir, unsigned long attrs)
>  {
> @@ -928,39 +856,10 @@ swiotlb_dma_supported(struct device *hwdev, u64 mask)
>  	return __phys_to_dma(hwdev, io_tlb_end - 1) <= mask;
>  }
>  
> -void *swiotlb_alloc(struct device *dev, size_t size, dma_addr_t *dma_handle,
> -		gfp_t gfp, unsigned long attrs)
> -{
> -	void *vaddr;
> -
> -	/* temporary workaround: */
> -	if (gfp & __GFP_NOWARN)
> -		attrs |= DMA_ATTR_NO_WARN;
> -
> -	/*
> -	 * Don't print a warning when the first allocation attempt fails.
> -	 * swiotlb_alloc_coherent() will print a warning when the DMA memory
> -	 * allocation ultimately failed.
> -	 */
> -	gfp |= __GFP_NOWARN;
> -
> -	vaddr = dma_direct_alloc(dev, size, dma_handle, gfp, attrs);
> -	if (!vaddr)
> -		vaddr = swiotlb_alloc_buffer(dev, size, dma_handle, attrs);
> -	return vaddr;
> -}
> -
> -void swiotlb_free(struct device *dev, size_t size, void *vaddr,
> -		dma_addr_t dma_addr, unsigned long attrs)
> -{
> -	if (!swiotlb_free_buffer(dev, size, dma_addr))
> -		dma_direct_free(dev, size, vaddr, dma_addr, attrs);
> -}
> -
>  const struct dma_map_ops swiotlb_dma_ops = {
>  	.mapping_error		= dma_direct_mapping_error,
> -	.alloc			= swiotlb_alloc,
> -	.free			= swiotlb_free,
> +	.alloc			= dma_direct_alloc,
> +	.free			= dma_direct_free,
>  	.sync_single_for_cpu	= swiotlb_sync_single_for_cpu,
>  	.sync_single_for_device	= swiotlb_sync_single_for_device,
>  	.sync_sg_for_cpu	= swiotlb_sync_sg_for_cpu,
> -- 
> 2.19.0
> 
