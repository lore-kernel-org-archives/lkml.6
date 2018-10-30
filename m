Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 006E5C2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 14:03:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B6EB20823
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 14:03:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B6EB20823
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728069AbeJ3W4l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 18:56:41 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:44860 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727705AbeJ3W4l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 18:56:41 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 44B676AFD3A73;
        Tue, 30 Oct 2018 22:03:01 +0800 (CST)
Received: from [127.0.0.1] (10.177.23.164) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.408.0; Tue, 30 Oct 2018
 22:02:52 +0800
Subject: Re: [PATCH v2 1/1] iommu/arm-smmu-v3: eliminate a potential memory
 corruption on Hi16xx soc
To:     John Garry <john.garry@huawei.com>,
        Will Deacon <will.deacon@arm.com>
References: <1540021014-8176-1-git-send-email-thunder.leizhen@huawei.com>
 <20181029175905.GC16739@arm.com> <5BD7B97A.1050408@huawei.com>
 <5f8866ef-41f4-424b-7fc3-240a4ae7b9f2@huawei.com>
CC:     Joerg Roedel <joro@8bytes.org>, LinuxArm <linuxarm@huawei.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        iommu <iommu@lists.linux-foundation.org>,
        Robin Murphy <robin.murphy@arm.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <5BD8648B.8050001@huawei.com>
Date:   Tue, 30 Oct 2018 22:02:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <5f8866ef-41f4-424b-7fc3-240a4ae7b9f2@huawei.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.23.164]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018/10/30 17:26, John Garry wrote:
> On 30/10/2018 01:52, Leizhen (ThunderTown) wrote:
>>
>>
>> On 2018/10/30 1:59, Will Deacon wrote:
>>> On Sat, Oct 20, 2018 at 03:36:54PM +0800, Zhen Lei wrote:
>>>> The standard GITS_TRANSLATER register in ITS is only 4 bytes, but
>>>> Hisilicon expands the next 4 bytes to carry some IMPDEF information. That
>>>> means, total 8 bytes data will be written to MSIAddress each time.
>>>>
>>>> MSIAddr: |----4bytes----|----4bytes----|
>>>>      |    MSIData   |    IMPDEF    |
>>>>
>>>> There is no problem for ITS, because the next 4 bytes space is reserved
>>>> in ITS. But it will overwrite the 4 bytes memory following "sync_count".
>>>> It's very fortunately that the previous and the next neighbour of the
>>>> "sync_count" are both aligned by 8 bytes, so no problem is met now.
>>>>
>>>> It's good to explicitly add a workaround:
>>>> 1. Add gcc __attribute__((aligned(8))) to make sure that "sync_count" is
>>>>    always aligned by 8 bytes.
>>>> 2. Add a "int" struct member to make sure the 4 bytes padding is always
>>>>    exist.
>>>>
>>>> There is no functional change.
>>>>
>>>> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
>>>> ---
>>>>  drivers/iommu/arm-smmu-v3.c | 15 ++++++++++++++-
>>>>  1 file changed, 14 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
>>>> index 5059d09..624fdd0 100644
>>>> --- a/drivers/iommu/arm-smmu-v3.c
>>>> +++ b/drivers/iommu/arm-smmu-v3.c
>>>> @@ -586,7 +586,20 @@ struct arm_smmu_device {
>>>>
>>>>      struct arm_smmu_strtab_cfg    strtab_cfg;
>>>>
>>>> -    u32                sync_count;
>>>> +    /*
>>>> +     * The alignment and padding is required by Hi16xx of Hisilicon.
> 
> Nit: I know that there is no functional change related to this bug which depends on the chip version, but how about "hi1620 and earlier"? hi16xx is very broad.

OK, I will update it.

> 
> Thanks
> 
>>>> +     * Because the ITS hardware on Hi16xx will truncate the MSIAddress(Here
>>>> +     * it's the address of "sync_count") to 8 bytes boundary first, then
>>>> +     * write 32 bits MSIdata at offset 0, and 32 bits IMPDEF data at offset
>>>> +     * 4. Without this workaround, the adjacent member maybe overwritten.
>>>> +     *
>>>> +     *                    |---4bytes---|---4bytes---|
>>>> +     * MSIAddress & (~0x7):   MSIdata  | IMPDEF data|
>>>> +     */
>>>> +    struct {
>>>> +        u32            sync_count;
>>>> +        int            padding;
>>>> +    } __attribute__((aligned(8)));
>>>
>>> I thought the conclusion after reviewing your original patch was to maintain
>>> the union and drop the alignment directive? e.g.
>>>
>>>     union {
>>>         u32    sync_count;
>>>         u64    padding; /* Hi16xx writes an extra 32 bits of goodness */
>>>     };
>> OK, I will sent v3.
>>
>>>
>>> Will
>>>
>>> .
>>>
>>
> 
> 
> 
> .
> 

-- 
Thanks!
BestRegards

