Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBF6BC67863
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 13:03:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B30E62064A
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 13:03:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WVOUeero"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B30E62064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726773AbeJXVbL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 17:31:11 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:51610 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726267AbeJXVbL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 17:31:11 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w9OCx8Cb058450;
        Wed, 24 Oct 2018 13:03:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=lDywC7hpCEld8sIKGFZHYn9iyq3sjxcQ1VmKwG19t9A=;
 b=WVOUeero/kmkem/SbPw0arET4Ze/fgswsVc9NjMdUCyB2zdjb1ayTgINFVy6priaHgLM
 adphCWBLkA8yoqwaShn5FjxaTs/FnyCe/qUiHoBIxDJ2URoniAcPP0/t2vBfhPKl3oV1
 8/l7zItCgMwdHTPQuE+wEfd9SbqM2t0GOZfkgCfAPbpcMC4To9uhSr8GMVQKnIVLqN/O
 AfrPF+CZ9zwwcRO5dfmnsKsOoDLKbQx+d1py/RY8LcNjPAaWp+LOoh+VGvYMsqei/2yJ
 HVspwv1URwwqJmnwcezsjF+WCg6ENLvhedsK+D7wLTAFMeT7zc5sQvsXwEdeGLMFLcqD GA== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2120.oracle.com with ESMTP id 2n7w0qua9k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Oct 2018 13:03:02 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w9OD2unq005568
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Oct 2018 13:02:57 GMT
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w9OD2u2A026388;
        Wed, 24 Oct 2018 13:02:56 GMT
Received: from localhost.localdomain (/209.6.36.129)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 24 Oct 2018 06:02:55 -0700
Date:   Wed, 24 Oct 2018 09:02:46 -0400
From:   Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To:     Joe Jin <joe.jin@oracle.com>
Cc:     "DONGLI.ZHANG" <dongli.zhang@oracle.com>, konrad@kernel.org,
        Christoph Helwig <hch@lst.de>,
        John Sobecki <john.sobecki@oracle.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        "linux-kernel@vger.kernel.org\"" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] xen-swiotlb: exchange memory with Xen only when pages
 are contiguous
Message-ID: <20181024130246.GA22616@localhost.localdomain>
References: <bb6d87b4-c371-c6c0-8c48-bc95df018ad1@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bb6d87b4-c371-c6c0-8c48-bc95df018ad1@oracle.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9055 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1810240113
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 23, 2018 at 08:09:04PM -0700, Joe Jin wrote:
> Commit 4855c92dbb7 "xen-swiotlb: fix the check condition for
> xen_swiotlb_free_coherent" only fixed memory address check condition
> on xen_swiotlb_free_coherent(), when memory was not physically
> contiguous and tried to exchanged with Xen via 
> xen_destroy_contiguous_region it will lead kernel panic.

s/it will lead/which lead to/?

> 
> The correct check condition should be memory is in DMA area and
> physically contiguous.

"The correct check condition to make Xen hypercall to revert the
memory back from its 32-bit pool is if it is:
 1) Above its DMA bit mask (for example 32-bit devices can only address
up to 4GB, and we may want 4GB+2K), and
 2) If it not physically contingous

N.B. The logic in the code is inverted, which leads to all sorts of
confusions."

Does that sound correct?

> 
> Thank you Boris for pointing it out.
> 

Fixes: 4855c92dbb7 ("xen-sw..") ?

> Signed-off-by: Joe Jin <joe.jin@oracle.com>
> Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>

Reported-by: Boris Ostrovs... ?
> Cc: Christoph Helwig <hch@lst.de>
> Cc: Dongli Zhang <dongli.zhang@oracle.com>
> Cc: John Sobecki <john.sobecki@oracle.com>
> ---
>  drivers/xen/swiotlb-xen.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/xen/swiotlb-xen.c b/drivers/xen/swiotlb-xen.c
> index f5c1af4ce9ab..aed92fa019f9 100644
> --- a/drivers/xen/swiotlb-xen.c
> +++ b/drivers/xen/swiotlb-xen.c
> @@ -357,8 +357,8 @@ xen_swiotlb_free_coherent(struct device *hwdev, size_t size, void *vaddr,
>  	/* Convert the size to actually allocated. */
>  	size = 1UL << (order + XEN_PAGE_SHIFT);
>  
> -	if (((dev_addr + size - 1 <= dma_mask)) ||
> -	    range_straddles_page_boundary(phys, size))
> +	if ((dev_addr + size - 1 <= dma_mask) &&
> +	    !range_straddles_page_boundary(phys, size))
>  		xen_destroy_contiguous_region(phys, order);
>  
>  	xen_free_coherent_pages(hwdev, size, vaddr, (dma_addr_t)phys, attrs);
> -- 
> 2.17.1 (Apple Git-112)
> 
