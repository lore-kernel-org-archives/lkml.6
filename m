Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35558ECDE43
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 00:33:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED6B021476
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 00:33:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="YKaWuaGc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED6B021476
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726784AbeJSIhG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 04:37:06 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:33814 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725910AbeJSIhG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 04:37:06 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w9J0SjVb152239;
        Fri, 19 Oct 2018 00:33:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=h+l/SnjYV41gb32mb2mum5YsglQiQDCBJ15eCJb3Rro=;
 b=YKaWuaGcpiPTqIJaOMkZcdcXq4QnzHnRrLvSd3k2xfV0mKofrQSnCJW0Q+W7hsFuKfV0
 HNQbppOxBt2exO1ydbxpr2i0mBLAIlrNtBBZKtbo1tEfatCp9H6mQNGqRJhQTo0uVn7W
 nx4FPtUyWhxyKJcT3vpaB+DOXrASq6M8dSmkkHpqqh0odgF5DeEWf6s21scfikSEWkLc
 2w4yXF7wnCmvX0E/MgTr23QGWJ9seCsIG6ISXkO4pOKtID6nAMD1cSl5aHRrrZHp9O2i
 7SpBMVP6HTu9zcKX+6PJwmZoetIclEX0bH39hyppRUjpWrr5Q/ROjV1mZj5zTDR3NjPk Zg== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2120.oracle.com with ESMTP id 2n39brsddm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 Oct 2018 00:33:11 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w9J0X9vD020134
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 Oct 2018 00:33:10 GMT
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w9J0X9Yv005651;
        Fri, 19 Oct 2018 00:33:09 GMT
Received: from char.us.oracle.com (/10.152.32.25)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 18 Oct 2018 17:33:09 -0700
Received: by char.us.oracle.com (Postfix, from userid 1000)
        id 163AB6A0136; Thu, 18 Oct 2018 20:33:08 -0400 (EDT)
Date:   Thu, 18 Oct 2018 20:33:08 -0400
From:   Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 06/10] swiotlb: use swiotlb_map_page in
 swiotlb_map_sg_attrs
Message-ID: <20181019003308.GH1251@char.us.oracle.com>
References: <20181008080246.20543-1-hch@lst.de>
 <20181008080246.20543-7-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181008080246.20543-7-hch@lst.de>
User-Agent: Mutt/1.8.3 (2017-05-23)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9050 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1810190003
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 08, 2018 at 10:02:42AM +0200, Christoph Hellwig wrote:
> No need to duplicate the code - map_sg is equivalent to map_page
> for each page in the scatterlist.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>

Thank you!
> ---
>  kernel/dma/swiotlb.c | 34 ++++++++++++----------------------
>  1 file changed, 12 insertions(+), 22 deletions(-)
> 
> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> index 15335f3a1bf3..15755d7a5242 100644
> --- a/kernel/dma/swiotlb.c
> +++ b/kernel/dma/swiotlb.c
> @@ -845,37 +845,27 @@ swiotlb_sync_single_for_device(struct device *hwdev, dma_addr_t dev_addr,
>   * same here.
>   */
>  int
> -swiotlb_map_sg_attrs(struct device *hwdev, struct scatterlist *sgl, int nelems,
> +swiotlb_map_sg_attrs(struct device *dev, struct scatterlist *sgl, int nelems,
>  		     enum dma_data_direction dir, unsigned long attrs)
>  {
>  	struct scatterlist *sg;
>  	int i;
>  
> -	BUG_ON(dir == DMA_NONE);
> -
>  	for_each_sg(sgl, sg, nelems, i) {
> -		phys_addr_t paddr = sg_phys(sg);
> -		dma_addr_t dev_addr = phys_to_dma(hwdev, paddr);
> -
> -		if (swiotlb_force == SWIOTLB_FORCE ||
> -		    !dma_capable(hwdev, dev_addr, sg->length)) {
> -			phys_addr_t map = map_single(hwdev, sg_phys(sg),
> -						     sg->length, dir, attrs);
> -			if (map == SWIOTLB_MAP_ERROR) {
> -				/* Don't panic here, we expect map_sg users
> -				   to do proper error handling. */
> -				attrs |= DMA_ATTR_SKIP_CPU_SYNC;
> -				swiotlb_unmap_sg_attrs(hwdev, sgl, i, dir,
> -						       attrs);
> -				sg_dma_len(sgl) = 0;
> -				return 0;
> -			}
> -			sg->dma_address = __phys_to_dma(hwdev, map);
> -		} else
> -			sg->dma_address = dev_addr;
> +		sg->dma_address = swiotlb_map_page(dev, sg_page(sg), sg->offset,
> +				sg->length, dir, attrs);
> +		if (sg->dma_address == DIRECT_MAPPING_ERROR)
> +			goto out_error;
>  		sg_dma_len(sg) = sg->length;
>  	}
> +
>  	return nelems;
> +
> +out_error:
> +	swiotlb_unmap_sg_attrs(dev, sgl, i, dir,
> +			attrs | DMA_ATTR_SKIP_CPU_SYNC);
> +	sg_dma_len(sgl) = 0;
> +	return 0;
>  }
>  
>  /*
> -- 
> 2.19.0
> 
