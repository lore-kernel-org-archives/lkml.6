Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A56BC67863
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 00:18:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E239421476
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 00:18:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BTARdLq2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E239421476
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727014AbeJSIWO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 04:22:14 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:50948 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725945AbeJSIWO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 04:22:14 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w9J0EZoi143500;
        Fri, 19 Oct 2018 00:18:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=iK7BR+7JN+IZuh47YI3hyIHy7r1pb7htFurZINZ3eJI=;
 b=BTARdLq2r2rRvU77KzMKnrUWlf2foQ07X2VfI78X/5FqCZ1RR0pxPJxSZtGDI0XdemGv
 G9ishzxn4Wr6TexFUFJ2f6wBNysnTBEBEKa/ls8hvIAjVNR7yEGL8GYMroXHD3H3F1ob
 4k9TWO0xPOCUBvu9y2jhRd3s1tVOrxgIbs8rVn8rrAxMtFb/U6AQe2FiPLsMyRIxkLDt
 iVU42QRiEn4gg26e57UD5QTBuICXodr0HgHPtUQeJGXK2nh/atJlA+Kma1uce1XH3YGU
 pqoY/AVtmVEeVmvb+z5bOXyBWPSPrcvBQ9T34Je8qZuEmcuOKc71CUlDTcdIcOapyqSa EA== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2120.oracle.com with ESMTP id 2n39brsc2j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 Oct 2018 00:18:05 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w9J0I5t6026113
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 Oct 2018 00:18:05 GMT
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w9J0I4Cu030545;
        Fri, 19 Oct 2018 00:18:05 GMT
Received: from char.us.oracle.com (/10.152.32.25)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 18 Oct 2018 17:18:04 -0700
Received: by char.us.oracle.com (Postfix, from userid 1000)
        id C23B26A0136; Thu, 18 Oct 2018 20:18:03 -0400 (EDT)
Date:   Thu, 18 Oct 2018 20:18:03 -0400
From:   Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Christoph Hellwig <hch@lst.de>, Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/10] swiotlb: do not panic on mapping failures
Message-ID: <20181019001803.GE1251@char.us.oracle.com>
References: <20181008080246.20543-1-hch@lst.de>
 <20181008080246.20543-4-hch@lst.de>
 <ff847d0d-a2a1-65ba-ed18-aa71f632194d@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ff847d0d-a2a1-65ba-ed18-aa71f632194d@arm.com>
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

On Thu, Oct 11, 2018 at 07:06:31PM +0100, Robin Murphy wrote:
> On 08/10/18 09:02, Christoph Hellwig wrote:
> > All properly written drivers now have error handling in the
> > dma_map_single / dma_map_page callers.  As swiotlb_tbl_map_single already
> > prints a useful warning when running out of swiotlb pool swace we can
> > also remove swiotlb_full entirely as it serves no purpose now.
> 
> $ git grep -l 'dma_map_\(page\|single\)' drivers/ | wc -l
> 385
> $ git grep -l dma_mapping_error drivers/ | wc -l
> 396
> 
> Close enough, to first approximation :D
> 
> I agree the other (non-fatal) warning seems sufficient, and frankly the
> panic can be a bit of a pain for development sometimes.

What would you recommend instead?
> 
> Reviewed-by: Robin Murphy <robin.murphy@arm.com>
> 
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > ---
> >   kernel/dma/swiotlb.c | 33 +--------------------------------
> >   1 file changed, 1 insertion(+), 32 deletions(-)
> > 
> > diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> > index 26d3af52956f..69bf305ee5f8 100644
> > --- a/kernel/dma/swiotlb.c
> > +++ b/kernel/dma/swiotlb.c
> > @@ -761,34 +761,6 @@ static bool swiotlb_free_buffer(struct device *dev, size_t size,
> >   	return true;
> >   }
> > -static void
> > -swiotlb_full(struct device *dev, size_t size, enum dma_data_direction dir,
> > -	     int do_panic)
> > -{
> > -	if (swiotlb_force == SWIOTLB_NO_FORCE)
> > -		return;
> > -
> > -	/*
> > -	 * Ran out of IOMMU space for this operation. This is very bad.
> > -	 * Unfortunately the drivers cannot handle this operation properly.
> > -	 * unless they check for dma_mapping_error (most don't)
> > -	 * When the mapping is small enough return a static buffer to limit
> > -	 * the damage, or panic when the transfer is too big.
> > -	 */
> > -	dev_err_ratelimited(dev, "DMA: Out of SW-IOMMU space for %zu bytes\n",
> > -			    size);
> > -
> > -	if (size <= io_tlb_overflow || !do_panic)
> > -		return;
> > -
> > -	if (dir == DMA_BIDIRECTIONAL)
> > -		panic("DMA: Random memory could be DMA accessed\n");
> > -	if (dir == DMA_FROM_DEVICE)
> > -		panic("DMA: Random memory could be DMA written\n");
> > -	if (dir == DMA_TO_DEVICE)
> > -		panic("DMA: Random memory could be DMA read\n");
> > -}
> > -
> >   /*
> >    * Map a single buffer of the indicated size for DMA in streaming mode.  The
> >    * physical address to use is returned.
> > @@ -817,10 +789,8 @@ dma_addr_t swiotlb_map_page(struct device *dev, struct page *page,
> >   	/* Oh well, have to allocate and map a bounce buffer. */
> >   	map = map_single(dev, phys, size, dir, attrs);
> > -	if (map == SWIOTLB_MAP_ERROR) {
> > -		swiotlb_full(dev, size, dir, 1);
> > +	if (map == SWIOTLB_MAP_ERROR)
> >   		return __phys_to_dma(dev, io_tlb_overflow_buffer);
> > -	}
> >   	dev_addr = __phys_to_dma(dev, map);
> > @@ -948,7 +918,6 @@ swiotlb_map_sg_attrs(struct device *hwdev, struct scatterlist *sgl, int nelems,
> >   			if (map == SWIOTLB_MAP_ERROR) {
> >   				/* Don't panic here, we expect map_sg users
> >   				   to do proper error handling. */
> > -				swiotlb_full(hwdev, sg->length, dir, 0);
> >   				attrs |= DMA_ATTR_SKIP_CPU_SYNC;
> >   				swiotlb_unmap_sg_attrs(hwdev, sgl, i, dir,
> >   						       attrs);
> > 
