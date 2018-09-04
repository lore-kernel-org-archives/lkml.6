Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70A27C43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 23:13:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0811C206BA
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 23:13:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="J+fZxYR1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0811C206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727145AbeIEDlD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 23:41:03 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:48606 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725825AbeIEDlD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 23:41:03 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w84N8vl4111460;
        Tue, 4 Sep 2018 23:13:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : cc : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=ijy4bSRxN3VBVL6dKmesoFAmGh+KFc4f4cNr9vLQdV8=;
 b=J+fZxYR1EQ/qpnGF+CDLod391K0gyPxFIqO2N7USyVdYdAIWaO+Io8a/xPPYBA1+N5j+
 E/5Hv4M9KjWq5iUvTbXrFttgxi8qbwAXR6+U7dwfIh2wpRpoHLc09nkeuzs4T2sj2n6z
 R8pihClrAzs/se+VgUyAY4y7J7VXxgjwYxGz7MoNP07pX+mnEyuUGRW5oXaEA76L9uJa
 VI6k3LcNlTT4E9EqfB0IwaZjCg5yF2lqPZCgNyQYQA2ftUmjnzehMWDQlNyz0cs7FiC/
 hkN9UK9wQ/g0yUX7bNsUumYhPQkVApw35FFRJF60bXoVDvi11VdjKcivF+C1gCEPWFPf BA== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2130.oracle.com with ESMTP id 2m7j6tg6nw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 04 Sep 2018 23:13:41 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w84NDeOl000617
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 4 Sep 2018 23:13:40 GMT
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w84NDe4c016757;
        Tue, 4 Sep 2018 23:13:40 GMT
Received: from [10.182.70.168] (/10.182.70.168)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 04 Sep 2018 23:13:40 +0000
Subject: Re: [Xen-devel] [PATCH] xen-swiotlb: use actually allocated size on
 check physical contiguous
To:     "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>
References: <d578b69a-848b-2c86-175a-1b1933d82a36@oracle.com>
Cc:     Joe Jin <joe.jin@oracle.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        John Sobecki <john.sobecki@oracle.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        stable@vger.kernel.org
From:   Dongli Zhang <dongli.zhang@oracle.com>
Message-ID: <f3befca2-fc65-81b8-c9ed-311de7967958@oracle.com>
Date:   Wed, 5 Sep 2018 07:14:26 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <d578b69a-848b-2c86-175a-1b1933d82a36@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9006 signatures=668708
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1809040231
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Below module would help people reproduce the issue to understand the symptom:

https://github.com/finallyjustice/patchset/blob/master/xen-swiotlb-panic.c

In addition, on the xen hypervisor side, the memory_exchange() in xen hypervisor
does not check if the the pfn of input mfn belong to the same extent are
continuous in guest domain. As a result, the wrong page is stolen from guest domain.

Can we assume it is fine to not check if pfn of mfn are continuous in xen
hypervisor?

I think it is OK as the guest domain is responsible to maintain its memory
pages. xen is happy to serve any operations from guest domain, unless such
operation is harmful to xen hypervisor or other domains. In the worst cause, the
dom0 (or domU with passthrough) would panic itself.

 496 static long memory_exchange(...
... ...
 609         /* Steal a chunk's worth of input pages from the domain. */
 610         for ( j = 0; j < (1UL << in_chunk_order); j++ )
 611         {
 612             if ( unlikely(__copy_from_guest_offset(
 613                 &gmfn, exch.in.extent_start, (i<<in_chunk_order)+j, 1)) )
 614             {
 615                 rc = -EFAULT;
 616                 goto fail;
 617             }
 618

 -------> not checking if the gfn of gmfn are continuous in below 'for loop' for
each extent.

 619             for ( k = 0; k < (1UL << exch.in.extent_order); k++ )
 620             {
 621 #ifdef CONFIG_X86
 622                 p2m_type_t p2mt;
 623
 624                 /* Shared pages cannot be exchanged */
 625                 mfn = get_gfn_unshare(d, gmfn + k, &p2mt);
 626                 if ( p2m_is_shared(p2mt) )
 627                 {
 628                     put_gfn(d, gmfn + k);
 629                     rc = -ENOMEM;
 630                     goto fail;
 631                 }
 632 #else /* !CONFIG_X86 */
 633                 mfn = gfn_to_mfn(d, _gfn(gmfn + k));
 634 #endif
 635                 if ( unlikely(!mfn_valid(mfn)) )
 636                 {
 637                     put_gfn(d, gmfn + k);
 638                     rc = -EINVAL;
 639                     goto fail;
 640                 }
 641
 642                 page = mfn_to_page(mfn);
 643

-----> As a result, the wrong page is stolen.

 644                 rc = steal_page(d, page, MEMF_no_refcount);
 645                 if ( unlikely(rc) )
 646                 {
 647                     put_gfn(d, gmfn + k);
 648                     goto fail;
 649                 }
 650
 651                 page_list_add(page, &in_chunk_list);
 652                 put_gfn(d, gmfn + k);
 653             }
 654         }


Dongli Zhang



On 09/05/2018 02:16 AM, Joe Jin wrote:
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
> 
