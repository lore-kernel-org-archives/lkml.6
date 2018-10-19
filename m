Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07445C67863
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 00:25:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BCBC21477
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 00:25:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DqoT/i2u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BCBC21477
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbeJSI33 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 04:29:29 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:35598 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbeJSI33 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 04:29:29 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w9J0O1Ef006118;
        Fri, 19 Oct 2018 00:25:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=wzeVS6tuWR2QVl9TH7jAt0eCADhPAc5AjKfKCWPvRAQ=;
 b=DqoT/i2uHcq3TYBCD13f+c6iPCZZyyYXbmFndDOnvqk3z3Aa56prGmGu7h6OiR40smJB
 QLAqQ6yUHRlwkjx47FpRYlVi616okbp82qUiIXD3KbsZE1GD+c0xAzbPsM6ic0BBVUmP
 nAkNRDsqJu6MKdnosPTaj0ALRwSg4Le7fI0kobKhdwVmKpoaA02vOY2UQ0Di+a3F7zh4
 uwF7Yvr5R3iWnkK/Zf85me/dkh8luPIqqaI9BnRq02yjQhrNE2m2Pb1S+6xwGD+yARhC
 WDJLsuzbY6wTvRLXfYkparEDIHO/QQUK6lp2MgnUo9AvmrkzRpAHR3ncKCneAXikKxRf Vw== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by aserp2120.oracle.com with ESMTP id 2n38nqhf6n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 Oct 2018 00:25:37 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w9J0PbDt023457
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 Oct 2018 00:25:37 GMT
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w9J0Pb3Z001470;
        Fri, 19 Oct 2018 00:25:37 GMT
Received: from char.us.oracle.com (/10.152.32.25)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 18 Oct 2018 17:25:36 -0700
Received: by char.us.oracle.com (Postfix, from userid 1000)
        id C52A36A0136; Thu, 18 Oct 2018 20:25:35 -0400 (EDT)
Date:   Thu, 18 Oct 2018 20:25:35 -0400
From:   Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/10] swiotlb: merge swiotlb_unmap_page and unmap_single
Message-ID: <20181019002535.GG1251@char.us.oracle.com>
References: <20181008080246.20543-1-hch@lst.de>
 <20181008080246.20543-6-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181008080246.20543-6-hch@lst.de>
User-Agent: Mutt/1.8.3 (2017-05-23)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9050 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=992
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1810190002
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 08, 2018 at 10:02:41AM +0200, Christoph Hellwig wrote:
> Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>

Thank you!
> ---
>  kernel/dma/swiotlb.c | 15 ++++-----------
>  1 file changed, 4 insertions(+), 11 deletions(-)
> 
> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> index 11dbcd80b4a6..15335f3a1bf3 100644
> --- a/kernel/dma/swiotlb.c
> +++ b/kernel/dma/swiotlb.c
> @@ -765,9 +765,9 @@ dma_addr_t swiotlb_map_page(struct device *dev, struct page *page,
>   * After this call, reads by the cpu to the buffer are guaranteed to see
>   * whatever the device wrote there.
>   */
> -static void unmap_single(struct device *hwdev, dma_addr_t dev_addr,
> -			 size_t size, enum dma_data_direction dir,
> -			 unsigned long attrs)
> +void swiotlb_unmap_page(struct device *hwdev, dma_addr_t dev_addr,
> +			size_t size, enum dma_data_direction dir,
> +			unsigned long attrs)
>  {
>  	phys_addr_t paddr = dma_to_phys(hwdev, dev_addr);
>  
> @@ -790,13 +790,6 @@ static void unmap_single(struct device *hwdev, dma_addr_t dev_addr,
>  	dma_mark_clean(phys_to_virt(paddr), size);
>  }
>  
> -void swiotlb_unmap_page(struct device *hwdev, dma_addr_t dev_addr,
> -			size_t size, enum dma_data_direction dir,
> -			unsigned long attrs)
> -{
> -	unmap_single(hwdev, dev_addr, size, dir, attrs);
> -}
> -
>  /*
>   * Make physical memory consistent for a single streaming mode DMA translation
>   * after a transfer.
> @@ -900,7 +893,7 @@ swiotlb_unmap_sg_attrs(struct device *hwdev, struct scatterlist *sgl,
>  	BUG_ON(dir == DMA_NONE);
>  
>  	for_each_sg(sgl, sg, nelems, i)
> -		unmap_single(hwdev, sg->dma_address, sg_dma_len(sg), dir,
> +		swiotlb_unmap_page(hwdev, sg->dma_address, sg_dma_len(sg), dir,
>  			     attrs);
>  }
>  
> -- 
> 2.19.0
> 
