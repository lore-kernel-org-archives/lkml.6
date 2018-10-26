Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C57FC6786E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 04:17:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F76120834
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 04:17:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="s01QnAHv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F76120834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726065AbeJZMwo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 08:52:44 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:55012 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725849AbeJZMwo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 08:52:44 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w9Q49Tf9170092;
        Fri, 26 Oct 2018 04:17:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=Aj4OeuSFoQcmJZ1fRFOMjUgqrvUepn7096+IooR002k=;
 b=s01QnAHvOlKhYLIQ17Y2Hwpl10oLi8f5GZQvr2Q1spm3hulQERz2mDtTwjY0rbwkJkt0
 hwDFiotSI4CkduBqo8qD/uzIoU6ivxkshy9/Hx6ZfB1+yUIxpOiKighX1HiKsL2gJ2i7
 1yRJzr40RtOBDsdUdtLPJIN0rkYKVQZP1wy/M/jEeele5n3Y/7Zx+jA9k+p8g28e8eL+
 H4rD/gqULNZH4WBrSY0FkYoEb339IA6L1zE+RqXsWtKQRZznqPIQJIr7OdVvldqGXOTf
 H08+TJjYESmXVAEsgftzTqUKyts5E9x0DY6hXTGaU5ZyXGTPyFYHNn6cY1k5R6DP/BqZ pw== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2120.oracle.com with ESMTP id 2n7w0r506v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 26 Oct 2018 04:17:17 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w9Q4HC3k026620
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 26 Oct 2018 04:17:12 GMT
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w9Q4HBYH008020;
        Fri, 26 Oct 2018 04:17:12 GMT
Received: from [10.0.0.83] (/73.231.240.86)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 25 Oct 2018 21:17:11 -0700
Subject: Re: [PATCH] x86/xen: add physically contiguous check to
 xen_destroy_contiguous_region
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        "DONGLI.ZHANG" <dongli.zhang@oracle.com>,
        John Sobecki <john.sobecki@oracle.com>
Cc:     "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        konrad@kernel.org
References: <210fa20d-4abb-413f-7e58-d8079cf3c589@oracle.com>
From:   Joe Jin <joe.jin@oracle.com>
Message-ID: <a0302067-3273-e61a-b0f0-6cc6b1fdc31f@oracle.com>
Date:   Thu, 25 Oct 2018 21:17:10 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <210fa20d-4abb-413f-7e58-d8079cf3c589@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9057 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1810260036
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I did not realized range_straddles_page_boundary() only available
on xen-swiotlb, please ignore this patch.

Sorry for the bother.

Thanks,
Joe
On 10/25/18 5:16 PM, Joe Jin wrote:
> xen_destroy_contiguous_region() used to exchange physically
> contiguous memory with hypervisor, but it does not verify
> that the memory is physically contiguous or no, passing
> non-contiguous memory to xen_destroy_contiguous_region()
> will lead kernel panic.
> 
> Signed-off-by: Joe Jin <joe.jin@oracle.com>
> Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
> Cc: Juergen Gross <jgross@suse.com>
> ---
>  arch/x86/xen/mmu_pv.c     | 3 +++
>  drivers/xen/swiotlb-xen.c | 3 +--
>  2 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/xen/mmu_pv.c b/arch/x86/xen/mmu_pv.c
> index 70ea598a37d2..c2f081f8ebe3 100644
> --- a/arch/x86/xen/mmu_pv.c
> +++ b/arch/x86/xen/mmu_pv.c
> @@ -2649,6 +2649,9 @@ void xen_destroy_contiguous_region(phys_addr_t pstart, unsigned int order)
>  	if (unlikely(order > MAX_CONTIG_ORDER))
>  		return;
>  
> +	if (range_straddles_page_boundary(pstart, PAGE_SIZE << order))
> +		return;
> +
>  	vstart = (unsigned long)phys_to_virt(pstart);
>  	memset((void *) vstart, 0, PAGE_SIZE << order);
>  
> diff --git a/drivers/xen/swiotlb-xen.c b/drivers/xen/swiotlb-xen.c
> index f5c1af4ce9ab..432eeae02d7d 100644
> --- a/drivers/xen/swiotlb-xen.c
> +++ b/drivers/xen/swiotlb-xen.c
> @@ -357,8 +357,7 @@ xen_swiotlb_free_coherent(struct device *hwdev, size_t size, void *vaddr,
>  	/* Convert the size to actually allocated. */
>  	size = 1UL << (order + XEN_PAGE_SHIFT);
>  
> -	if (((dev_addr + size - 1 <= dma_mask)) ||
> -	    range_straddles_page_boundary(phys, size))
> +	if (dev_addr + size - 1 <= dma_mask)
>  		xen_destroy_contiguous_region(phys, order);
>  
>  	xen_free_coherent_pages(hwdev, size, vaddr, (dma_addr_t)phys, attrs);
> 
