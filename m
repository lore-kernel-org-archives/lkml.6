Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A052FC5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 16:08:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E38821473
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 16:08:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E38821473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728478AbeJSAK0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 20:10:26 -0400
Received: from foss.arm.com ([217.140.101.70]:40220 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727859AbeJSAK0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 20:10:26 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D41EF341;
        Thu, 18 Oct 2018 09:08:45 -0700 (PDT)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6B73A3F71A;
        Thu, 18 Oct 2018 09:08:42 -0700 (PDT)
Subject: Re: [PATCH 2/4] iommu/arm-smmu: Workaround for Marvell Armada-AP806
 SoC erratum #582743
To:     Hanna Hawa <hannah@marvell.com>, catalin.marinas@arm.com,
        will.deacon@arm.com, corbet@lwn.net, joro@8bytes.org,
        robh+dt@kernel.org, gregory.clement@bootlin.com,
        mark.rutland@arm.com, jason@lakedaemon.net, andrew@lunn.ch,
        sebastian.hesselbarth@gmail.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        devicetree@vger.kernel.org, thomas.petazzoni@bootlin.com,
        nadavh@marvell.com, omrii@marvell.com, nd@arm.com
References: <1539604846-21151-1-git-send-email-hannah@marvell.com>
 <1539604846-21151-3-git-send-email-hannah@marvell.com>
 <8a7eefcf-6a77-8dc1-2ce9-9bb7395a3bb7@arm.com>
 <2e4f2b02-4b02-877d-1f51-c617170398a6@marvell.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <38360fdf-8bc0-9fea-870f-fdb8b6103248@arm.com>
Date:   Thu, 18 Oct 2018 17:08:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <2e4f2b02-4b02-877d-1f51-c617170398a6@marvell.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/10/18 09:25, Hanna Hawa wrote:
> Hi Robin,
> 
> 
> On 10/15/2018 04:00 PM, Robin Murphy wrote:
>> Hi Hanna,
>>
>> On 15/10/18 13:00, hannah@marvell.com wrote:
>>> From: Hanna Hawa <hannah@marvell.com>
>>>
>>> Due to erratum #582743, the Marvell Armada-AP806 can't access 64bit
>>> to ARM SMMUv2 registers.
>>> This patch split the writeq/readq to two accesses of writel/readl.
>>>
>>> Note that separate writes/reads to 2 is not problem regards to 
>>> atomicity,
>>> because the driver use the readq/writeq while initialize the SMMU, 
>>> report
>>> for SMMU fault, and use spinlock in one case (iova_to_phys).
>>
>> In general, this doesn't work. Here's what the SMMU spec says about
>> SMMU_CBn_TLBIVA, but others are similar:
>>
>> "If SMMU_CBA2Rn.VA64 is one, then AArch64 format is selected. The
>> programmer should use 64 bit accesses to this register. If 32-bit
>> accesses are used then writes to the top 32 bits are ignored and writes
>> to the lower 32 bits are zero extended."
>>
>> If your interconnect won't let 64-bit transactions through, then you
>> can't use AArch64 format at stage 1 at all, since there's no way to
>> invalidate entries with the correct ASID, and you'll have to restrict
>> stage 2 formats to at most 44-bit IOVAs in order for TLBIIPAS2{L} not to
>> invalidate the wrong thing.
> Thanks for your suggestion.
> 
> To restrict the IOVAs i need to add another work-around to the driver to 
> limit the va_size, is that acceptable?

Yeah, constraining AArch64 stage 2 to 44 bits should just be a case of 
adjusting smmu->ipa_size at probe time, but you'd still need to add the 
writel()-based TLBI path to take advantage of it.

How big is the physical memory map on these SoCs? If everything fits 
into 40 bits then I think you could get away with simply hiding the 
SMMU_IDR2.PTFSv8 fields to sidestep the AArch64 formats altogether, and 
everything else should fall out in the wash. Otherwise, you'll have to 
just disable stage 1 support in addition to the stage 2 workaround as 
above.

> What the different in the driver between AARCH32_L & AARCH32_S?

AARCH32_L is the 3-level LPAE format, which gives you 32-bit 
input/40-bit output at stage 1 and 40-bit input/40-bit output at stage 
2. AARCH32_S is the legacy 2-level short-descriptor format which only 
supports stage 1 and is limited to 32-bit output addresses - MMU-500 
does support it, but you probably want to avoid it if possible ;)

Robin.
