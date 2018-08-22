Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 030CEC4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 14:56:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B584D21480
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 14:56:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B584D21480
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729290AbeHVSWE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 14:22:04 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:33964 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729273AbeHVSWE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 14:22:04 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 185FDED1;
        Wed, 22 Aug 2018 07:56:51 -0700 (PDT)
Received: from [10.4.12.131] (e110467-lin.Emea.Arm.com [10.4.12.131])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3A5963F2EA;
        Wed, 22 Aug 2018 07:56:48 -0700 (PDT)
From:   Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH 0/4] numa, iommu/smmu: IOMMU/SMMU driver optimization for
 NUMA systems
To:     John Garry <john.garry@huawei.com>,
        Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
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
        "thunder.leizhen@huawei.com" <thunder.leizhen@huawei.com>,
        Linuxarm <linuxarm@huawei.com>, Christoph Hellwig <hch@lst.de>
References: <20170921085922.11659-1-ganapatrao.kulkarni@cavium.com>
 <452f1665-eb3a-5e8c-f671-099ef4a15d84@huawei.com>
Message-ID: <a7fc1e43-3652-562a-1e59-499be80b567c@arm.com>
Date:   Wed, 22 Aug 2018 15:56:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <452f1665-eb3a-5e8c-f671-099ef4a15d84@huawei.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi John,

On 22/08/18 14:44, John Garry wrote:
> On 21/09/2017 09:59, Ganapatrao Kulkarni wrote:
>> Adding numa aware memory allocations used for iommu dma allocation and
>> memory allocated for SMMU stream tables, page walk tables and command 
>> queues.
>>
>> With this patch, iperf testing on ThunderX2, with 40G NIC card on
>> NODE 1 PCI shown same performance(around 30% improvement) as NODE 0.
>>
>> Ganapatrao Kulkarni (4):
>>   mm: move function alloc_pages_exact_nid out of __meminit
>>   numa, iommu/io-pgtable-arm: Use NUMA aware memory allocation for smmu
>>     translation tables
>>   iommu/arm-smmu-v3: Use NUMA memory allocations for stream tables and
>>     comamnd queues
>>   iommu/dma, numa: Use NUMA aware memory allocations in
>>     __iommu_dma_alloc_pages
>>
>>  drivers/iommu/arm-smmu-v3.c    | 57 
>> +++++++++++++++++++++++++++++++++++++-----
>>  drivers/iommu/dma-iommu.c      | 17 +++++++------
>>  drivers/iommu/io-pgtable-arm.c |  4 ++-
>>  include/linux/gfp.h            |  2 +-
>>  mm/page_alloc.c                |  3 ++-
>>  5 files changed, 67 insertions(+), 16 deletions(-)
>>
> 
> Hi Ganapatrao,
> 
> Have you any plans for further work on this patchset? I have not seen 
> anything since this v1 was posted+discussed.

Looks like I ended up doing the version of the io-pgtable change that I 
suggested here, which was merged recently (4b123757eeaa). Patch #3 
should also be effectively obsolete now since the SWIOTLB/dma-direct 
rework (21f237e4d085). Apparently I also started reworking patch #4 in 
my tree at some point but sidelined it - I think that was at least 
partly due to another thread[1] which made it seem less clear-cut 
whether this is always the right thing to do.

Robin.

[1] 
https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1693026.html
