Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752098AbeCWS53 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 14:57:29 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:33070 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751796AbeCWS52 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 14:57:28 -0400
Date: Fri, 23 Mar 2018 14:57:07 -0400
From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To: Christoph Hellwig <hch@lst.de>
Cc: tglx@linutronix.de, mingo@elte.hu, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org
Subject: Re: [PATCH] swiotlb: swiotlb_{alloc,free}_buffer should depend on
 CONFIG_DMA_DIRECT_OPS
Message-ID: <20180323185707.GD25533@char.us.oracle.com>
References: <20180323174930.17767-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180323174930.17767-1-hch@lst.de>
User-Agent: Mutt/1.8.3 (2017-05-23)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8841 signatures=668695
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803230205
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 23, 2018 at 06:49:30PM +0100, Christoph Hellwig wrote:
> Otherwise we might get unused symbol warnings for configs that built
> swiotlb.c only for use by xen-swiotlb.c and that don't otherwise select
> CONFIG_DMA_DIRECT_OPS, which is possible on arm.
> 
> Fixes: 16e73adbca76 ("dma/swiotlb: Remove swiotlb_{alloc,free}_coherent()")
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Signed-off-by: Christoph Hellwig <hch@lst.de>


Alternatively could we set the Kconfig to slect DMA_DIRECT_OPS?

> ---
>  lib/swiotlb.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/lib/swiotlb.c b/lib/swiotlb.c
> index 15954b86f09e..47aeb04c1997 100644
> --- a/lib/swiotlb.c
> +++ b/lib/swiotlb.c
> @@ -692,6 +692,7 @@ void swiotlb_tbl_sync_single(struct device *hwdev, phys_addr_t tlb_addr,
>  	}
>  }
>  
> +#ifdef CONFIG_DMA_DIRECT_OPS
>  static inline bool dma_coherent_ok(struct device *dev, dma_addr_t addr,
>  		size_t size)
>  {
> @@ -763,6 +764,7 @@ static bool swiotlb_free_buffer(struct device *dev, size_t size,
>  				 DMA_ATTR_SKIP_CPU_SYNC);
>  	return true;
>  }
> +#endif
>  
>  static void
>  swiotlb_full(struct device *dev, size_t size, enum dma_data_direction dir,
> -- 
> 2.14.2
> 
