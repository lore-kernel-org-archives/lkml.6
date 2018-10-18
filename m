Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 254E7ECDE43
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 23:52:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC48B208E4
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 23:52:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="pJCn1d1y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC48B208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727474AbeJSH4C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 03:56:02 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:47202 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727141AbeJSH4C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 03:56:02 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w9INnjMo174668;
        Thu, 18 Oct 2018 23:52:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=xfo3eqj8a4f5X6bsd+KI4rXWngqYQa4mS+Ipp5Q2lJE=;
 b=pJCn1d1ysTORdj7vVjG9s90/b+pR6+G1Z5f2hDsy0N6r850TnjC5q3S3Lvnj/jRG8w1b
 G+it7BxeCOuLt0F/N/Me9JWUAzasCVECVToqXH7mndWs2W9eBn3/tQRgYUwn2vANfshP
 Ss4TDYKUYo6pw/1Y5IS98iZ6exzJsMheG77mxVL8f4F23zO8AcQPCp4Twlhp2Yufsvlo
 PBmr0SsEz9144lewkCgoJJePKJBsVIBP430X6cgFRDpBRaEhwaNt61hIqROS1iMCpy7C
 LlpTat/oAgYzf44CIFOxYyHUveYF2jSZWs0x+4Xl+RwKJsrjRusMsxC4WD+P/yXKBXR4 Rg== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2130.oracle.com with ESMTP id 2n384uhm6r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 Oct 2018 23:52:33 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w9INqXne024464
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 Oct 2018 23:52:33 GMT
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w9INqWmE000509;
        Thu, 18 Oct 2018 23:52:33 GMT
Received: from konrads-mbp.lan (/209.6.36.129)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 18 Oct 2018 16:52:32 -0700
Date:   Thu, 18 Oct 2018 19:52:25 -0400
From:   Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To:     Joe Jin <joe.jin@oracle.com>
Cc:     John Sobecki <john.sobecki@oracle.com>,
        "DONGLI.ZHANG" <dongli.zhang@oracle.com>, konrad@kernel.org,
        Christoph Helwig <hch@lst.de>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V2] xen-swiotlb: use actually allocated size on check
 physical continuous
Message-ID: <20181018235219.GA36047@konrads-mbp.lan>
References: <0453c762-1f8b-079f-5fdf-548e90909318@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0453c762-1f8b-079f-5fdf-548e90909318@oracle.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9050 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1810180199
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 16, 2018 at 03:21:16PM -0700, Joe Jin wrote:
> xen_swiotlb_{alloc,free}_coherent() allocate/free memory by order,
> but passed required size to range_straddles_page_boundary(),
> when first pages are physical continuous,
> range_straddles_page_boundary() returned true, then did not
> exchanged memory with Xen, later on free memory, it tried to
> exchanged non-contiguous memory with Xen, then kernel panic.

I have a hard time understanding the commit message.

I think you mean to say:

xen_swiotlb_{alloc,free}_coherent() allocate/free memory based on the
order of the pages and not size argument (bytes). This is inconsistent with
range_straddles_page_boundary and memset which use the 'size' value,
which may lead to not exchanging memory with Xen (range_straddles_page_boundary()
returned true). And then the call to xen_swiotlb_free_coherent() would
actually try to exchange the memory with Xen, leading to the kernel
hitting an BUG (as the hypercall returned an error).

This patch fixes it by making the 'size' variable be of the same size
as the amount of memory allocated.

I checked it as such..
> 
> Signed-off-by: Joe Jin <joe.jin@oracle.com>
> Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
> Cc: Christoph Helwig <hch@lst.de>
> Cc: Dongli Zhang <dongli.zhang@oracle.com>
> Cc: John Sobecki <john.sobecki@oracle.com>
> 
> ---
>  drivers/xen/swiotlb-xen.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/xen/swiotlb-xen.c b/drivers/xen/swiotlb-xen.c
> index a6f9ba85dc4b..aa081f806728 100644
> --- a/drivers/xen/swiotlb-xen.c
> +++ b/drivers/xen/swiotlb-xen.c
> @@ -303,6 +303,9 @@ xen_swiotlb_alloc_coherent(struct device *hwdev, size_t size,
>  	*/
>  	flags &= ~(__GFP_DMA | __GFP_HIGHMEM);
>  
> +	/* Convert the size to actually allocated. */
> +	size = 1UL << (order + XEN_PAGE_SHIFT);
> +
>  	/* On ARM this function returns an ioremap'ped virtual address for
>  	 * which virt_to_phys doesn't return the corresponding physical
>  	 * address. In fact on ARM virt_to_phys only works for kernel direct
> @@ -351,6 +354,9 @@ xen_swiotlb_free_coherent(struct device *hwdev, size_t size, void *vaddr,
>  	 * physical address */
>  	phys = xen_bus_to_phys(dev_addr);
>  
> +	/* Convert the size to actually allocated. */
> +	size = 1UL << (order + XEN_PAGE_SHIFT);
> +
>  	if (((dev_addr + size - 1 <= dma_mask)) ||
>  	    range_straddles_page_boundary(phys, size))
>  		xen_destroy_contiguous_region(phys, order);
> -- 
> 2.15.2 (Apple Git-101.1)
> 
> 
