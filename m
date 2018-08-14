Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA2FAC46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 10:02:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A25321765
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 10:02:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A25321765
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731957AbeHNMtX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 08:49:23 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:40822 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728483AbeHNMtX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 08:49:23 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 98B9080D;
        Tue, 14 Aug 2018 03:02:55 -0700 (PDT)
Received: from [10.4.12.131] (e110467-lin.emea.arm.com [10.4.12.131])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3F9443F5D0;
        Tue, 14 Aug 2018 03:02:54 -0700 (PDT)
Subject: Re: [PATCH v3 4/6] iommu/io-pgtable-arm: add support for non-strict
 mode
To:     Will Deacon <will.deacon@arm.com>,
        "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Cc:     "Yang, Shunyong" <shunyong.yang@hxt-semitech.com>,
        Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        iommu <iommu@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <1531376312-2192-1-git-send-email-thunder.leizhen@huawei.com>
 <1531376312-2192-5-git-send-email-thunder.leizhen@huawei.com>
 <89cc2201-99ab-3f3b-a2d1-1766515d4375@arm.com> <5B597628.2020103@huawei.com>
 <04239cfa-bcf2-a33a-e662-ebc75e66782b@arm.com>
 <1d24541340334954969c58980ef85444@HXTBJIDCEMVIW01.hxtcorp.net>
 <5B7293E5.7040702@huawei.com> <20180814083500.GA28101@arm.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <feabf4a3-db1e-a22b-daab-fad831b473f9@arm.com>
Date:   Tue, 14 Aug 2018 11:02:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180814083500.GA28101@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/08/18 09:35, Will Deacon wrote:
> On Tue, Aug 14, 2018 at 04:33:41PM +0800, Leizhen (ThunderTown) wrote:
>> On 2018/8/6 9:32, Yang, Shunyong wrote:
>>> On 2018/7/26 22:37, Robin Murphy wrote:
>>>> Because DMA code is not the only caller of iommu_map/unmap. It's
>>>> perfectly legal in the IOMMU API to partially unmap a previous mapping
>>>> such that a block entry needs to be split. The DMA API, however, is a
>>>> lot more constrined, and thus by construction the iommu-dma layer will
>>>> never generate a block-splitting iommu_unmap() except as a result of
>>>> illegal DMA API usage, and we obviously do not need to optimise for that
>>>> (you will get a warning about mismatched unmaps under dma-debug, but
>>>> it's a bit too expensive to police in the general case).
>>>>
>>>
>>> When I was reading the code around arm_lpae_split_blk_unmap(), I was
>>> curious in which scenario a block will be split. Now with your comments
>>> "Because DMA code is not the only caller of iommu_map/unmap", it seems
>>> depending on the user.
>>>
>>> Would you please explain this further? I mean besides DMA, which user
>>> will use iommu_map/umap and how it split a block.
>>
>> I also think that arm_lpae_split_blk_unmap() scenario is not exist, maybe
>> we should remove it, and give a warning for this wrong usage.
> 
> Can't it happen with VFIO?

...or GPU drivers, or anyone else managing their own IOMMU domain 
directly. A sequence like this is perfectly legal:

	iommu_map(domain, iova, paddr, SZ_8M, prot);
	...
	iommu_unmap(domain, iova + SZ_1M * 5, SZ_1M * 3);

where if iova and paddr happen to be suitably aligned, the map will lay 
down blocks, and the unmap will then have to split one of them into 
pages to remove half of it. We don't tear our hair out maintaining 
split_blk_unmap() for the fun of it :(

Robin.
