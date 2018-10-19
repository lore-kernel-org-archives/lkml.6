Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42AE3C67863
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 00:23:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBAB621477
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 00:23:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="paORR06+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBAB621477
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726935AbeJSI1I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 04:27:08 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:34012 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725945AbeJSI1H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 04:27:07 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w9J0F2Ga196288;
        Fri, 19 Oct 2018 00:23:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=/1R9E3YJb/QIkOSD9rMSPdd/3ubKoot41+2yqPX0BUg=;
 b=paORR06+mslIgyoT1g0tKNWxh5eBKbAMa+I92GN5Sw+XBKK3qnmKaBQURGfEfgXHQll/
 ZbMtO70fFIBfMvqOaZXAQIWbxNgZI+14ck5549yYlzMvkgoDUsyh1JKUJrybhF6AcGdV
 T1y700I2w0BHOpA64s+oizi9lIFj7SxVtTdmQxXqlNQx3TQMG8I3OsG9UQmSsZjlx6i2
 H5aySFiclWRnbqQWFDlzelW52BQ6wr5w7g2J2ed/4Zbq6Zjgpp8CqFcbxrA6gDkZZF2u
 kXaI/q0XDudL8EyWBfUBGoJgePbq87mo0MCe56N9Kl51LBZpXL2ckseKcGMJocaynhb8 cA== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by aserp2120.oracle.com with ESMTP id 2n38nqhf22-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 Oct 2018 00:23:14 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w9J0NEBo014903
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 Oct 2018 00:23:14 GMT
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w9J0NDjs000478;
        Fri, 19 Oct 2018 00:23:13 GMT
Received: from char.us.oracle.com (/10.152.32.25)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 18 Oct 2018 17:23:13 -0700
Received: by char.us.oracle.com (Postfix, from userid 1000)
        id 756566A0136; Thu, 18 Oct 2018 20:23:12 -0400 (EDT)
Date:   Thu, 18 Oct 2018 20:23:12 -0400
From:   Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/10] swiotlb: remove the overflow buffer
Message-ID: <20181019002312.GF1251@char.us.oracle.com>
References: <20181008080246.20543-1-hch@lst.de>
 <20181008080246.20543-5-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181008080246.20543-5-hch@lst.de>
User-Agent: Mutt/1.8.3 (2017-05-23)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9050 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1810190001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 08, 2018 at 10:02:40AM +0200, Christoph Hellwig wrote:
> Like all other dma mapping drivers just return an error code instead
> of an actual memory buffer.  The reason for the overflow buffer was
> that at the time swiotlb was invented there was no way to check for
> dma mapping errors, but this has long been fixed.

RIP overflow buffer.

Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>

Thank you!
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  arch/arm64/mm/dma-mapping.c       |  2 +-
>  arch/powerpc/kernel/dma-swiotlb.c |  4 +--
>  include/linux/dma-direct.h        |  2 ++
>  include/linux/swiotlb.h           |  3 --
>  kernel/dma/direct.c               |  2 --
>  kernel/dma/swiotlb.c              | 59 ++-----------------------------
>  6 files changed, 8 insertions(+), 64 deletions(-)
> 
> diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
> index 072c51fb07d7..8d91b927e09e 100644
> --- a/arch/arm64/mm/dma-mapping.c
> +++ b/arch/arm64/mm/dma-mapping.c
> @@ -324,7 +324,7 @@ static int __swiotlb_dma_supported(struct device *hwdev, u64 mask)
>  static int __swiotlb_dma_mapping_error(struct device *hwdev, dma_addr_t addr)
>  {
>  	if (swiotlb)
> -		return swiotlb_dma_mapping_error(hwdev, addr);
> +		return dma_direct_mapping_error(hwdev, addr);
>  	return 0;
>  }
>  
> diff --git a/arch/powerpc/kernel/dma-swiotlb.c b/arch/powerpc/kernel/dma-swiotlb.c
> index 88f3963ca30f..5fc335f4d9cd 100644
> --- a/arch/powerpc/kernel/dma-swiotlb.c
> +++ b/arch/powerpc/kernel/dma-swiotlb.c
> @@ -11,7 +11,7 @@
>   *
>   */
>  
> -#include <linux/dma-mapping.h>
> +#include <linux/dma-direct.h>
>  #include <linux/memblock.h>
>  #include <linux/pfn.h>
>  #include <linux/of_platform.h>
> @@ -59,7 +59,7 @@ const struct dma_map_ops powerpc_swiotlb_dma_ops = {
>  	.sync_single_for_device = swiotlb_sync_single_for_device,
>  	.sync_sg_for_cpu = swiotlb_sync_sg_for_cpu,
>  	.sync_sg_for_device = swiotlb_sync_sg_for_device,
> -	.mapping_error = swiotlb_dma_mapping_error,
> +	.mapping_error = dma_direct_mapping_error,
>  	.get_required_mask = swiotlb_powerpc_get_required,
>  };
>  
> diff --git a/include/linux/dma-direct.h b/include/linux/dma-direct.h
> index fbca184ff5a0..bd73e7a91410 100644
> --- a/include/linux/dma-direct.h
> +++ b/include/linux/dma-direct.h
> @@ -5,6 +5,8 @@
>  #include <linux/dma-mapping.h>
>  #include <linux/mem_encrypt.h>
>  
> +#define DIRECT_MAPPING_ERROR		0
> +
>  #ifdef CONFIG_ARCH_HAS_PHYS_TO_DMA
>  #include <asm/dma-direct.h>
>  #else
> diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
> index 7ef541ce8f34..f847c1b265c4 100644
> --- a/include/linux/swiotlb.h
> +++ b/include/linux/swiotlb.h
> @@ -106,9 +106,6 @@ extern void
>  swiotlb_sync_sg_for_device(struct device *hwdev, struct scatterlist *sg,
>  			   int nelems, enum dma_data_direction dir);
>  
> -extern int
> -swiotlb_dma_mapping_error(struct device *hwdev, dma_addr_t dma_addr);
> -
>  extern int
>  swiotlb_dma_supported(struct device *hwdev, u64 mask);
>  
> diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
> index 674a8da22844..12798abba55e 100644
> --- a/kernel/dma/direct.c
> +++ b/kernel/dma/direct.c
> @@ -14,8 +14,6 @@
>  #include <linux/pfn.h>
>  #include <linux/set_memory.h>
>  
> -#define DIRECT_MAPPING_ERROR		0
> -
>  /*
>   * Most architectures use ZONE_DMA for the first 16 Megabytes, but
>   * some use it for entirely different regions:
> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> index 69bf305ee5f8..11dbcd80b4a6 100644
> --- a/kernel/dma/swiotlb.c
> +++ b/kernel/dma/swiotlb.c
> @@ -72,13 +72,6 @@ static phys_addr_t io_tlb_start, io_tlb_end;
>   */
>  static unsigned long io_tlb_nslabs;
>  
> -/*
> - * When the IOMMU overflows we return a fallback buffer. This sets the size.
> - */
> -static unsigned long io_tlb_overflow = 32*1024;
> -
> -static phys_addr_t io_tlb_overflow_buffer;
> -
>  /*
>   * This is a free list describing the number of free entries available from
>   * each index
> @@ -126,7 +119,6 @@ setup_io_tlb_npages(char *str)
>  	return 0;
>  }
>  early_param("swiotlb", setup_io_tlb_npages);
> -/* make io_tlb_overflow tunable too? */
>  
>  unsigned long swiotlb_nr_tbl(void)
>  {
> @@ -194,16 +186,10 @@ void __init swiotlb_update_mem_attributes(void)
>  	bytes = PAGE_ALIGN(io_tlb_nslabs << IO_TLB_SHIFT);
>  	set_memory_decrypted((unsigned long)vaddr, bytes >> PAGE_SHIFT);
>  	memset(vaddr, 0, bytes);
> -
> -	vaddr = phys_to_virt(io_tlb_overflow_buffer);
> -	bytes = PAGE_ALIGN(io_tlb_overflow);
> -	set_memory_decrypted((unsigned long)vaddr, bytes >> PAGE_SHIFT);
> -	memset(vaddr, 0, bytes);
>  }
>  
>  int __init swiotlb_init_with_tbl(char *tlb, unsigned long nslabs, int verbose)
>  {
> -	void *v_overflow_buffer;
>  	unsigned long i, bytes;
>  
>  	bytes = nslabs << IO_TLB_SHIFT;
> @@ -212,17 +198,6 @@ int __init swiotlb_init_with_tbl(char *tlb, unsigned long nslabs, int verbose)
>  	io_tlb_start = __pa(tlb);
>  	io_tlb_end = io_tlb_start + bytes;
>  
> -	/*
> -	 * Get the overflow emergency buffer
> -	 */
> -	v_overflow_buffer = memblock_virt_alloc_low_nopanic(
> -						PAGE_ALIGN(io_tlb_overflow),
> -						PAGE_SIZE);
> -	if (!v_overflow_buffer)
> -		return -ENOMEM;
> -
> -	io_tlb_overflow_buffer = __pa(v_overflow_buffer);
> -
>  	/*
>  	 * Allocate and initialize the free list array.  This array is used
>  	 * to find contiguous free memory regions of size up to IO_TLB_SEGSIZE
> @@ -330,7 +305,6 @@ int
>  swiotlb_late_init_with_tbl(char *tlb, unsigned long nslabs)
>  {
>  	unsigned long i, bytes;
> -	unsigned char *v_overflow_buffer;
>  
>  	bytes = nslabs << IO_TLB_SHIFT;
>  
> @@ -341,19 +315,6 @@ swiotlb_late_init_with_tbl(char *tlb, unsigned long nslabs)
>  	set_memory_decrypted((unsigned long)tlb, bytes >> PAGE_SHIFT);
>  	memset(tlb, 0, bytes);
>  
> -	/*
> -	 * Get the overflow emergency buffer
> -	 */
> -	v_overflow_buffer = (void *)__get_free_pages(GFP_DMA,
> -						     get_order(io_tlb_overflow));
> -	if (!v_overflow_buffer)
> -		goto cleanup2;
> -
> -	set_memory_decrypted((unsigned long)v_overflow_buffer,
> -			io_tlb_overflow >> PAGE_SHIFT);
> -	memset(v_overflow_buffer, 0, io_tlb_overflow);
> -	io_tlb_overflow_buffer = virt_to_phys(v_overflow_buffer);
> -
>  	/*
>  	 * Allocate and initialize the free list array.  This array is used
>  	 * to find contiguous free memory regions of size up to IO_TLB_SEGSIZE
> @@ -390,10 +351,6 @@ swiotlb_late_init_with_tbl(char *tlb, unsigned long nslabs)
>  	                                                 sizeof(int)));
>  	io_tlb_list = NULL;
>  cleanup3:
> -	free_pages((unsigned long)v_overflow_buffer,
> -		   get_order(io_tlb_overflow));
> -	io_tlb_overflow_buffer = 0;
> -cleanup2:
>  	io_tlb_end = 0;
>  	io_tlb_start = 0;
>  	io_tlb_nslabs = 0;
> @@ -407,8 +364,6 @@ void __init swiotlb_exit(void)
>  		return;
>  
>  	if (late_alloc) {
> -		free_pages((unsigned long)phys_to_virt(io_tlb_overflow_buffer),
> -			   get_order(io_tlb_overflow));
>  		free_pages((unsigned long)io_tlb_orig_addr,
>  			   get_order(io_tlb_nslabs * sizeof(phys_addr_t)));
>  		free_pages((unsigned long)io_tlb_list, get_order(io_tlb_nslabs *
> @@ -416,8 +371,6 @@ void __init swiotlb_exit(void)
>  		free_pages((unsigned long)phys_to_virt(io_tlb_start),
>  			   get_order(io_tlb_nslabs << IO_TLB_SHIFT));
>  	} else {
> -		memblock_free_late(io_tlb_overflow_buffer,
> -				   PAGE_ALIGN(io_tlb_overflow));
>  		memblock_free_late(__pa(io_tlb_orig_addr),
>  				   PAGE_ALIGN(io_tlb_nslabs * sizeof(phys_addr_t)));
>  		memblock_free_late(__pa(io_tlb_list),
> @@ -790,7 +743,7 @@ dma_addr_t swiotlb_map_page(struct device *dev, struct page *page,
>  	/* Oh well, have to allocate and map a bounce buffer. */
>  	map = map_single(dev, phys, size, dir, attrs);
>  	if (map == SWIOTLB_MAP_ERROR)
> -		return __phys_to_dma(dev, io_tlb_overflow_buffer);
> +		return DIRECT_MAPPING_ERROR;
>  
>  	dev_addr = __phys_to_dma(dev, map);
>  
> @@ -801,7 +754,7 @@ dma_addr_t swiotlb_map_page(struct device *dev, struct page *page,
>  	attrs |= DMA_ATTR_SKIP_CPU_SYNC;
>  	swiotlb_tbl_unmap_single(dev, map, size, dir, attrs);
>  
> -	return __phys_to_dma(dev, io_tlb_overflow_buffer);
> +	return DIRECT_MAPPING_ERROR;
>  }
>  
>  /*
> @@ -985,12 +938,6 @@ swiotlb_sync_sg_for_device(struct device *hwdev, struct scatterlist *sg,
>  	swiotlb_sync_sg(hwdev, sg, nelems, dir, SYNC_FOR_DEVICE);
>  }
>  
> -int
> -swiotlb_dma_mapping_error(struct device *hwdev, dma_addr_t dma_addr)
> -{
> -	return (dma_addr == __phys_to_dma(hwdev, io_tlb_overflow_buffer));
> -}
> -
>  /*
>   * Return whether the given device DMA address mask can be supported
>   * properly.  For example, if your device can only drive the low 24-bits
> @@ -1033,7 +980,7 @@ void swiotlb_free(struct device *dev, size_t size, void *vaddr,
>  }
>  
>  const struct dma_map_ops swiotlb_dma_ops = {
> -	.mapping_error		= swiotlb_dma_mapping_error,
> +	.mapping_error		= dma_direct_mapping_error,
>  	.alloc			= swiotlb_alloc,
>  	.free			= swiotlb_free,
>  	.sync_single_for_cpu	= swiotlb_sync_single_for_cpu,
> -- 
> 2.19.0
> 
