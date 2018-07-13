Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EE54ECDFB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 01:48:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14EFD214AB
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 01:48:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14EFD214AB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388010AbeGMCAr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 22:00:47 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:9229 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387956AbeGMCAr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 22:00:47 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 26C91F327B296;
        Fri, 13 Jul 2018 09:48:16 +0800 (CST)
Received: from [127.0.0.1] (10.177.23.164) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.382.0; Fri, 13 Jul 2018
 09:48:07 +0800
Subject: Re: [PATCH 1/1] iommu/arm-smmu-v3: prevent any devices access to
 memory without registration
To:     Will Deacon <will.deacon@arm.com>
References: <1531387723-3592-1-git-send-email-thunder.leizhen@huawei.com>
 <20180712170120.GC26935@arm.com>
CC:     Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        iommu <iommu@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "guohanjun (Hanjun Guo)" <guohanjun@huawei.com>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <5B4804D6.4050508@huawei.com>
Date:   Fri, 13 Jul 2018 09:48:06 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <20180712170120.GC26935@arm.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.23.164]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018/7/13 1:01, Will Deacon wrote:
> On Thu, Jul 12, 2018 at 05:28:43PM +0800, Zhen Lei wrote:
>> Stream bypass is not security. A malicious device can be hot plugged
>> without match any drivers, but it can access to any memory. So change to
>> disable bypass by default.
>>
>> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
>> ---
>>  drivers/iommu/arm-smmu-v3.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Whilst this sounds nice, I *bet* you it will break some systems. In
> particular, those where the SMMU is described but the toplogical information
> is either incorrect or incomplete.

Suppose this scene exists, maybe we should consider updating IORT specification,
to indicate whether a smmu treats all unregistered devices as stream bypass or not, --- global control
to indicate whether a single device default use stream bypass or not, --- local control
that will be more flexible. But we still disable bypass by default.

> 
> I guess we could put it into next and see if anybody complains. What do
> others think?
> 
> Will
> 
>> diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
>> index 1d64710..b0ec28d 100644
>> --- a/drivers/iommu/arm-smmu-v3.c
>> +++ b/drivers/iommu/arm-smmu-v3.c
>> @@ -366,7 +366,7 @@
>>  #define MSI_IOVA_BASE			0x8000000
>>  #define MSI_IOVA_LENGTH			0x100000
>>
>> -static bool disable_bypass;
>> +static bool disable_bypass = 1;
>>  module_param_named(disable_bypass, disable_bypass, bool, S_IRUGO);
>>  MODULE_PARM_DESC(disable_bypass,
>>  	"Disable bypass streams such that incoming transactions from devices that are not attached to an iommu domain will report an abort back to the device and will not be allowed to pass through the SMMU.");
>> --
>> 1.8.3
>>
>>
> 
> .
> 

-- 
Thanks!
BestRegards

