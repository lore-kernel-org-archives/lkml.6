Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 84FE5C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 12:36:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31234208B1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 12:36:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31234208B1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754353AbeFLMgB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 08:36:01 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:49528 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754223AbeFLMf7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 08:35:59 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 42482FEC6A8DF;
        Tue, 12 Jun 2018 20:35:56 +0800 (CST)
Received: from [127.0.0.1] (10.177.23.164) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.382.0; Tue, 12 Jun 2018
 20:35:50 +0800
Subject: Re: [PATCH v2 0/5] add non-strict mode support for arm-smmu-v3
To:     Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        iommu <iommu@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <1528628843-10280-1-git-send-email-thunder.leizhen@huawei.com>
 <d6f46de0-f8c3-2c9e-4de3-5949db0cf7b5@arm.com>
CC:     Xinwei Hu <huxinwei@huawei.com>, Hanjun Guo <guohanjun@huawei.com>,
        "Guozhu Li" <liguozhu@hisilicon.com>,
        Libin <huawei.libin@huawei.com>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <5B1FBE1C.3060205@huawei.com>
Date:   Tue, 12 Jun 2018 20:35:40 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <d6f46de0-f8c3-2c9e-4de3-5949db0cf7b5@arm.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.23.164]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018/6/11 19:05, Jean-Philippe Brucker wrote:
> Hi Zhen Lei,
> 
> On 10/06/18 12:07, Zhen Lei wrote:
>> v1 -> v2:
>> Use the lowest bit of the io_pgtable_ops.unmap's iova parameter to pass the strict mode:
>> 0, IOMMU_STRICT;
>> 1, IOMMU_NON_STRICT;
>> Treat 0 as IOMMU_STRICT, so that the unmap operation can compatible with
>> other IOMMUs which still use strict mode. In other words, this patch series
>> will not impact other IOMMU drivers. I tried add a new quirk IO_PGTABLE_QUIRK_NON_STRICT
>> in io_pgtable_cfg.quirks, but it can not pass the strict mode of the domain from SMMUv3
>> driver to io-pgtable module. 
>>
>> Add a new member domain_non_strict in struct iommu_dma_cookie, this member will only be
>> initialized when the related domain and IOMMU driver support non-strict mode.
> 
> It's not obvious from the commit messages or comments what the
> non-strict mode involves exactly. Could you add a description, and point
> out the trade-off associated with it?

Sorry, I described it in V1, but remove it in V2.
https://lkml.org/lkml/2018/5/31/131

> 
> In this mode you don't send an invalidate commands when removing a leaf
> entry, but instead send invalidate-all commands at regular interval.
> This improves performance but introduces a vulnerability window, which
> should be pointed out to users.
> 
> IOVA allocation isn't the only problem, I'm concerned about the page
> allocator. If unmap() returns early, the TLB entry is still valid after
> the kernel reallocate the page. The device can then perform a
> use-after-free (instead of getting a translation fault), so a buggy
> device will corrupt memory and an untrusted one will access arbitrary data.

I have constrained VFIO to still use strict mode, so all other devices will only
access memory in the kernel state, these related drivers are unlikely to attack
kernel. The devices as part of the commercial product, the probability of such a
bug is very low, at least the bug will not be reserved for the purpose of the
attack. But the attackers may replace it as illegal devices on the spot.

Take a step back, IOMMU disabled is also supported, non-strict mode is better
than disabled. So maybe we should add a boot option, allowing the admin choose
which mode to be used.


> 
> Or is there a way in mm to ensure that the page isn't reallocated until
> the invalidation succeeds? Could dma-iommu help with this? Having

It's too hard. In some cases the memory is allocated by non dma-iommu API.

> support from the mm would also help consolidate ATS, mark a page stale
> when an ATC invalidation times out. But last time I checked it seemed
> quite difficult to implement, and ATS is inherently insecure so I didn't
> bother.
> 
> At the very least I think it might be worth warning users in dmesg about
> this pitfall (and add_taint?). Tell them that an IOMMU in this mode is
> good for scatter-gather performance but lacks full isolation. The
> "non-strict" name seems somewhat harmless, and people should know what
> they're getting into before enabling this.

Yes, warning or add comments in source code will be better.

> 
> Thanks,
> Jean
> 
> .
> 

-- 
Thanks!
BestRegards

