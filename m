Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39552C04AA5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 18:52:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFCDD21470
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 18:52:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="qx0yaDQl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFCDD21470
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726914AbeJPCin (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 22:38:43 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:50654 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726707AbeJPCin (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 22:38:43 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w9FId6Te078044;
        Mon, 15 Oct 2018 18:52:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=LvlJKWLbOrAulcjHvwydWZksSapHFybt6NEQPd5hrgM=;
 b=qx0yaDQlOJ8JoxKtvHXqoLCR12fg+q06bvmsM6Di3ZHzxqCC/UOXmprNf14gPVhB+QGC
 bXEqZG1vCmAn3pjXf7gJ3QfjxHVzVSVqW54Ysj8PNd5m92cgcE0s6N6YYITzo+zkzs4g
 a7FitjbzqrhuVox2D2SVdpwYVsAYiYWcnVLdJN6+pJ5rCVVHWQkNs2iHvabeO6QxSFF+
 lJRS7aYVjMxb++EJiGP/iVkPd349PjMSpBXzvlJ+mZxtaAiXxVFhiB/cceMFsRm6uKgL
 xDIL+OhkBx3LVu9g/pBgwvnhbPTQ2y29WUolki6ABRjRDYLjL5f9psel3BeSzIcp/PoO vw== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by aserp2120.oracle.com with ESMTP id 2n38npv9jv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 Oct 2018 18:52:07 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w9FIq6kP014220
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 Oct 2018 18:52:06 GMT
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w9FIq6EQ001659;
        Mon, 15 Oct 2018 18:52:06 GMT
Received: from konrads-mbp.lan (/209.6.36.129)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 15 Oct 2018 11:52:06 -0700
Subject: Re: [PATCH] x86: enable swiotlb for > 4GiG ram on 32-bit kernels
To:     Christoph Hellwig <hch@lst.de>, x86@kernel.org
Cc:     tedheadster@gmail.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <20181014075208.2715-1-hch@lst.de>
From:   Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Organization: Oracle Corporation
Message-ID: <0a8d58b8-3c8b-c89f-e023-9d7d5d79f37c@oracle.com>
Date:   Mon, 15 Oct 2018 14:52:04 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:52.0)
 Gecko/20100101 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20181014075208.2715-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9047 signatures=668706
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1810150162
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/14/18 3:52 AM, Christoph Hellwig wrote:
> We already build the swiotlb code for 32b-t kernels with PAE support,
> but the code to actually use swiotlb has only been enabled for 64-bit
> kernel for an unknown reason.
> 
> Before Linux 4.18 we papers over this fact because the networking code,
> the scsi layer and some random block drivers implenented their own
> bounce buffering scheme.
> 
> Fixes: 21e07dba ("scsi: reduce use of block bounce buffers")
> Fixes: ab74cfeb ("net: remove the PCI_DMA_BUS_IS_PHYS check in illegal_highdma")
> Reported-by: tedheadster <tedheadster@gmail.com>
> Tested-by: tedheadster <tedheadster@gmail.com>

Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>

But since it is already in 'tip' feel free to ignore my tag.

Thanks!
> ---
>   arch/x86/kernel/pci-swiotlb.c | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/arch/x86/kernel/pci-swiotlb.c b/arch/x86/kernel/pci-swiotlb.c
> index 661583662430..71c0b01d93b1 100644
> --- a/arch/x86/kernel/pci-swiotlb.c
> +++ b/arch/x86/kernel/pci-swiotlb.c
> @@ -42,10 +42,8 @@ IOMMU_INIT_FINISH(pci_swiotlb_detect_override,
>   int __init pci_swiotlb_detect_4gb(void)
>   {
>   	/* don't initialize swiotlb if iommu=off (no_iommu=1) */
> -#ifdef CONFIG_X86_64
>   	if (!no_iommu && max_possible_pfn > MAX_DMA32_PFN)
>   		swiotlb = 1;
> -#endif
>   
>   	/*
>   	 * If SME is active then swiotlb will be set to 1 so that bounce
> 

