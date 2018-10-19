Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AE46C67863
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 00:50:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EB9421476
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 00:50:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="1jdbgWfA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EB9421476
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726918AbeJSIxv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 04:53:51 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:52268 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725945AbeJSIxu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 04:53:50 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w9J0ctvd016274;
        Fri, 19 Oct 2018 00:49:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=+aviRhHuXnGHUloZhn1Ix9qGz1ulfSAKvO5Yca48pCM=;
 b=1jdbgWfAVLihNkN/xzlpLrVf8uHwo5/y4Ep76kYb01yzKl5EY8TOczKs2stC9rALvzrS
 igsFuonv17TpYvszMKjrOAOCheC1iYFsymvmMzY5ibk3v/aCt2y3Cjiiz5LimAp5e212
 V91XCLifLN+exl0Rqh5ZHjl2IfgJlMYavBWr4r4KKQftVX356B7J8BAL7o1U7yNj7YOf
 7BGClc0k1YRKUaHZshG1WcqyunRbVHkYE/aPfb0qLf/wyOkswan5BQjT8UFlRgBZiiti
 tjYbM6nYvCyBD5YrNlpLZ6eVVTHsYyBYVc0sUwjXFRoe3Ob8OglW6E5HHxE/EAoi6sZs rQ== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by aserp2120.oracle.com with ESMTP id 2n38nqhgyn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 Oct 2018 00:49:52 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w9J0njHu013952
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 Oct 2018 00:49:46 GMT
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w9J0nj4C023410;
        Fri, 19 Oct 2018 00:49:45 GMT
Received: from char.us.oracle.com (/10.152.32.25)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 18 Oct 2018 17:49:45 -0700
Received: by char.us.oracle.com (Postfix, from userid 1000)
        id CC4D56A0136; Thu, 18 Oct 2018 20:49:43 -0400 (EDT)
Date:   Thu, 18 Oct 2018 20:49:43 -0400
From:   Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/10] swiotlb: add support for non-coherent DMA
Message-ID: <20181019004943.GK1251@char.us.oracle.com>
References: <20181008080246.20543-1-hch@lst.de>
 <20181008080246.20543-10-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181008080246.20543-10-hch@lst.de>
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

On Mon, Oct 08, 2018 at 10:02:45AM +0200, Christoph Hellwig wrote:
> Handle architectures that are not cache coherent directly in the main
> swiotlb code by calling arch_sync_dma_for_{device,cpu} in all the right
> places from the various dma_map/unmap/sync methods when the device is
> non-coherent.
> 
> Because swiotlb now uses dma_direct_alloc for the coherent allocation
> that side is already taken care of by the dma-direct code calling into
> arch_dma_{alloc,free} for devices that are non-coherent.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
Acked-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>

Thank you!
> ---
>  kernel/dma/swiotlb.c | 23 +++++++++++++++++------
>  1 file changed, 17 insertions(+), 6 deletions(-)
> 
> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> index 475a41eff3dc..52885b274368 100644
> --- a/kernel/dma/swiotlb.c
> +++ b/kernel/dma/swiotlb.c
> @@ -21,6 +21,7 @@
>  
>  #include <linux/cache.h>
>  #include <linux/dma-direct.h>
> +#include <linux/dma-noncoherent.h>
>  #include <linux/mm.h>
>  #include <linux/export.h>
>  #include <linux/spinlock.h>
> @@ -677,6 +678,10 @@ dma_addr_t swiotlb_map_page(struct device *dev, struct page *page,
>  		dma_addr = swiotlb_bounce_page(dev, &phys, size, dir, attrs);
>  	}
>  
> +	if (!dev_is_dma_coherent(dev) &&
> +	    (attrs & DMA_ATTR_SKIP_CPU_SYNC) == 0)
> +		arch_sync_dma_for_device(dev, phys, size, dir);
> +
>  	return dma_addr;
>  }
>  
> @@ -696,6 +701,10 @@ void swiotlb_unmap_page(struct device *hwdev, dma_addr_t dev_addr,
>  
>  	BUG_ON(dir == DMA_NONE);
>  
> +	if (!dev_is_dma_coherent(hwdev) &&
> +	    (attrs & DMA_ATTR_SKIP_CPU_SYNC) == 0)
> +		arch_sync_dma_for_cpu(hwdev, paddr, size, dir);
> +
>  	if (is_swiotlb_buffer(paddr)) {
>  		swiotlb_tbl_unmap_single(hwdev, paddr, size, dir, attrs);
>  		return;
> @@ -732,15 +741,17 @@ swiotlb_sync_single(struct device *hwdev, dma_addr_t dev_addr,
>  
>  	BUG_ON(dir == DMA_NONE);
>  
> -	if (is_swiotlb_buffer(paddr)) {
> +	if (!dev_is_dma_coherent(hwdev) && target == SYNC_FOR_CPU)
> +		arch_sync_dma_for_cpu(hwdev, paddr, size, dir);
> +
> +	if (is_swiotlb_buffer(paddr))
>  		swiotlb_tbl_sync_single(hwdev, paddr, size, dir, target);
> -		return;
> -	}
>  
> -	if (dir != DMA_FROM_DEVICE)
> -		return;
> +	if (!dev_is_dma_coherent(hwdev) && target == SYNC_FOR_DEVICE)
> +		arch_sync_dma_for_device(hwdev, paddr, size, dir);
>  
> -	dma_mark_clean(phys_to_virt(paddr), size);
> +	if (!is_swiotlb_buffer(paddr) && dir == DMA_FROM_DEVICE)
> +		dma_mark_clean(phys_to_virt(paddr), size);
>  }
>  
>  void
> -- 
> 2.19.0
> 
