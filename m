Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B738DC433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 22:47:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CBEC20652
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 22:47:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="G8I7dxC/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CBEC20652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726687AbeIHDbG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 23:31:06 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:54074 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726010AbeIHDbG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 23:31:06 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w87MeGdw115093;
        Fri, 7 Sep 2018 22:47:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=QxQo5DuGr8kyL19cp3OSEZITpsam7eNwbvZdYwLG4Cg=;
 b=G8I7dxC/S8AkRVgMaqQBsid6JiS/KTd5fm5WDpMGffvry9UlZ/BquUXpJ3IWXnTbg0Hu
 T1LmC+WmkVsIs/Xp9/VwThXWJtcZ4eGowYfWXR29tGKyaCqmLwrd6FKbBTQAWPw+Hkgc
 D5DBrxM6hwRM6Gl0UE+BfPYDNKiwpheMDv6YKsDRe7Pp5QpqLh61fq2K3CvImeGYtjQH
 ctXmFWJR6KiL6f+QqSxdhuQCu6/tlNnSZLaMC2bm4aqVGNnOYFTtsi+1I+/sP+3d348M
 6YOKP7fSgtqxjtRmVSqiYlfu/qZrnm/yzs3zcfvgj4NBVu16RzaSwktesH3hlT/Gps9U dA== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2130.oracle.com with ESMTP id 2m7j6u52aq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 07 Sep 2018 22:47:53 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w87Mlqna008397
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 7 Sep 2018 22:47:52 GMT
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w87MlplF027412;
        Fri, 7 Sep 2018 22:47:51 GMT
Received: from [10.211.202.81] (/10.211.202.81)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 07 Sep 2018 15:47:51 -0700
Subject: Re: [Xen-devel] [PATCH] xen-swiotlb: use actually allocated size on
 check physical contiguous
To:     Dongli Zhang <dongli.zhang@oracle.com>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>
Cc:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        John Sobecki <john.sobecki@oracle.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <d578b69a-848b-2c86-175a-1b1933d82a36@oracle.com>
 <f3befca2-fc65-81b8-c9ed-311de7967958@oracle.com>
From:   Joe Jin <joe.jin@oracle.com>
Message-ID: <5bb5e41f-ed6c-87d0-a1b1-d053c191a8d5@oracle.com>
Date:   Fri, 7 Sep 2018 15:47:50 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <f3befca2-fc65-81b8-c9ed-311de7967958@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9009 signatures=668708
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1809070223
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Anybody would like to help review this patch?

Thanks,
Joe

On 09/05/2018 02:16 AM, Joe Jin wrote                                           
> xen_swiotlb_{alloc,free}_coherent() actually allocate/free size by order      
> but used the required size to check if address is physical contiguous,        
> if first pages are physical contiguous also passed                            
> range_straddles_page_boundary() check, but others were not it will            
> lead kernel panic.                                                            
>                                                                               
> Signed-off-by: Joe Jin <joe.jin@oracle.com>                                   
> Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>                            
> ---                                                                           
>  drivers/xen/swiotlb-xen.c | 6 ++++++                                         
>  1 file changed, 6 insertions(+)                                              
>                                                                               
> diff --git a/drivers/xen/swiotlb-xen.c b/drivers/xen/swiotlb-xen.c            
> index a6f9ba85dc4b..aa081f806728 100644                                       
> --- a/drivers/xen/swiotlb-xen.c                                               
> +++ b/drivers/xen/swiotlb-xen.c                                               
> @@ -303,6 +303,9 @@ xen_swiotlb_alloc_coherent(struct device *hwdev, size_t size,
>       */                                                                      
>       flags &= ~(__GFP_DMA | __GFP_HIGHMEM);                                  
>                                                                               
> +     /* Convert the size to actually allocated. */                           
> +     size = 1UL << (order + XEN_PAGE_SHIFT);                                 
> +                                                                             
>       /* On ARM this function returns an ioremap'ped virtual address for      
>        * which virt_to_phys doesn't return the corresponding physical         
>        * address. In fact on ARM virt_to_phys only works for kernel direct    
> @@ -351,6 +354,9 @@ xen_swiotlb_free_coherent(struct device *hwdev, size_t size, void *vaddr,
>        * physical address */                                                  
>       phys = xen_bus_to_phys(dev_addr);                                       
>                                                                               
> +     /* Convert the size to actually allocated. */                           
> +     size = 1UL << (order + XEN_PAGE_SHIFT);                                 
> +                                                                             
>       if (((dev_addr + size - 1 <= dma_mask)) ||                              
>           range_straddles_page_boundary(phys, size))                          
>               xen_destroy_contiguous_region(phys, order);                     
>                                                                               
