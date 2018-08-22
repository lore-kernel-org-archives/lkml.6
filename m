Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BB67C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 13:44:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5456321528
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 13:44:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5456321528
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729111AbeHVRJz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 13:09:55 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:11160 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728947AbeHVRJz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 13:09:55 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 7C1293B39CA00;
        Wed, 22 Aug 2018 21:44:52 +0800 (CST)
Received: from [127.0.0.1] (10.202.226.41) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.399.0; Wed, 22 Aug 2018
 21:44:43 +0800
Subject: Re: [PATCH 0/4] numa, iommu/smmu: IOMMU/SMMU driver optimization for
 NUMA systems
To:     Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>
References: <20170921085922.11659-1-ganapatrao.kulkarni@cavium.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "Will.Deacon@arm.com" <Will.Deacon@arm.com>,
        "gklkml16@gmail.com" <gklkml16@gmail.com>,
        "Tomasz.Nowicki@cavium.com" <Tomasz.Nowicki@cavium.com>,
        "Robert.Richter@cavium.com" <Robert.Richter@cavium.com>,
        "mhocko@suse.com" <mhocko@suse.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "vbabka@suse.cz" <vbabka@suse.cz>,
        "jnair@caviumnetworks.com" <jnair@caviumnetworks.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        "thunder.leizhen@huawei.com" <thunder.leizhen@huawei.com>,
        Linuxarm <linuxarm@huawei.com>, "Christoph Hellwig" <hch@lst.de>
From:   John Garry <john.garry@huawei.com>
Message-ID: <452f1665-eb3a-5e8c-f671-099ef4a15d84@huawei.com>
Date:   Wed, 22 Aug 2018 14:44:33 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20170921085922.11659-1-ganapatrao.kulkarni@cavium.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.41]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/09/2017 09:59, Ganapatrao Kulkarni wrote:
> Adding numa aware memory allocations used for iommu dma allocation and
> memory allocated for SMMU stream tables, page walk tables and command queues.
>
> With this patch, iperf testing on ThunderX2, with 40G NIC card on
> NODE 1 PCI shown same performance(around 30% improvement) as NODE 0.
>
> Ganapatrao Kulkarni (4):
>   mm: move function alloc_pages_exact_nid out of __meminit
>   numa, iommu/io-pgtable-arm: Use NUMA aware memory allocation for smmu
>     translation tables
>   iommu/arm-smmu-v3: Use NUMA memory allocations for stream tables and
>     comamnd queues
>   iommu/dma, numa: Use NUMA aware memory allocations in
>     __iommu_dma_alloc_pages
>
>  drivers/iommu/arm-smmu-v3.c    | 57 +++++++++++++++++++++++++++++++++++++-----
>  drivers/iommu/dma-iommu.c      | 17 +++++++------
>  drivers/iommu/io-pgtable-arm.c |  4 ++-
>  include/linux/gfp.h            |  2 +-
>  mm/page_alloc.c                |  3 ++-
>  5 files changed, 67 insertions(+), 16 deletions(-)
>

Hi Ganapatrao,

Have you any plans for further work on this patchset? I have not seen 
anything since this v1 was posted+discussed.

Thanks,
John

> --
> 2.9.4
>
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
>
> .
>


