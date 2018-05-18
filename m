Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752135AbeERUWD (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 16:22:03 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:41954 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751488AbeERUWC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 16:22:02 -0400
Date: Fri, 18 May 2018 16:21:52 -0400
From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To: Christoph Hellwig <hch@lst.de>
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/6] swiotlb: do not panic on mapping failures
Message-ID: <20180518202152.GH23713@char.us.oracle.com>
References: <20180515180523.3038-1-hch@lst.de>
 <20180515180523.3038-3-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180515180523.3038-3-hch@lst.de>
User-Agent: Mutt/1.8.3 (2017-05-23)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8897 signatures=668699
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1805180215
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 15, 2018 at 08:05:19PM +0200, Christoph Hellwig wrote:
> We now have error handling in map_single/map_page callers (most of them

Which ones are missing? Shouldn't we first fix those before we rip this out?

> anyway). As swiotlb_tbl_map_single already prints a useful warning
> when running out of swiotlb pool swace we can also remove swiotlb_full

s/swace/so/

> entirely as it serves no purpose now.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  lib/swiotlb.c | 33 +--------------------------------
>  1 file changed, 1 insertion(+), 32 deletions(-)
> 
> diff --git a/lib/swiotlb.c b/lib/swiotlb.c
> index 721f93677eee..4d36340bc4f9 100644
> --- a/lib/swiotlb.c
> +++ b/lib/swiotlb.c
> @@ -763,34 +763,6 @@ static bool swiotlb_free_buffer(struct device *dev, size_t size,
>  	return true;
>  }
>  
> -static void
> -swiotlb_full(struct device *dev, size_t size, enum dma_data_direction dir,
> -	     int do_panic)
> -{
> -	if (swiotlb_force == SWIOTLB_NO_FORCE)
> -		return;
> -
> -	/*
> -	 * Ran out of IOMMU space for this operation. This is very bad.
> -	 * Unfortunately the drivers cannot handle this operation properly.
> -	 * unless they check for dma_mapping_error (most don't)
> -	 * When the mapping is small enough return a static buffer to limit
> -	 * the damage, or panic when the transfer is too big.
> -	 */
> -	dev_err_ratelimited(dev, "DMA: Out of SW-IOMMU space for %zu bytes\n",
> -			    size);
> -
> -	if (size <= io_tlb_overflow || !do_panic)
> -		return;
> -
> -	if (dir == DMA_BIDIRECTIONAL)
> -		panic("DMA: Random memory could be DMA accessed\n");
> -	if (dir == DMA_FROM_DEVICE)
> -		panic("DMA: Random memory could be DMA written\n");
> -	if (dir == DMA_TO_DEVICE)
> -		panic("DMA: Random memory could be DMA read\n");
> -}
> -
>  /*
>   * Map a single buffer of the indicated size for DMA in streaming mode.  The
>   * physical address to use is returned.
> @@ -819,10 +791,8 @@ dma_addr_t swiotlb_map_page(struct device *dev, struct page *page,
>  
>  	/* Oh well, have to allocate and map a bounce buffer. */
>  	map = map_single(dev, phys, size, dir, attrs);
> -	if (map == SWIOTLB_MAP_ERROR) {
> -		swiotlb_full(dev, size, dir, 1);
> +	if (map == SWIOTLB_MAP_ERROR)
>  		return __phys_to_dma(dev, io_tlb_overflow_buffer);
> -	}
>  
>  	dev_addr = __phys_to_dma(dev, map);
>  
> @@ -950,7 +920,6 @@ swiotlb_map_sg_attrs(struct device *hwdev, struct scatterlist *sgl, int nelems,
>  			if (map == SWIOTLB_MAP_ERROR) {
>  				/* Don't panic here, we expect map_sg users
>  				   to do proper error handling. */
> -				swiotlb_full(hwdev, sg->length, dir, 0);
>  				attrs |= DMA_ATTR_SKIP_CPU_SYNC;
>  				swiotlb_unmap_sg_attrs(hwdev, sgl, i, dir,
>  						       attrs);
> -- 
> 2.17.0
> 
