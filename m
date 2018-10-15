Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D5FFC04AA5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 11:18:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0FED2064A
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 11:18:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0FED2064A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726581AbeJOTC4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 15:02:56 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:13637 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726453AbeJOTC4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 15:02:56 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 448E51DA1B201;
        Mon, 15 Oct 2018 19:18:03 +0800 (CST)
Received: from [127.0.0.1] (10.202.226.41) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.399.0; Mon, 15 Oct 2018
 19:17:57 +0800
From:   John Garry <john.garry@huawei.com>
Subject: Re: [PATCH 1/1] iommu/arm-smmu-v3: eliminate a potential memory
 corruption on Hi16xx soc
To:     Zhen Lei <thunder.leizhen@huawei.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        iommu <iommu@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <1539592576-24352-1-git-send-email-thunder.leizhen@huawei.com>
CC:     LinuxArm <linuxarm@huawei.com>
Message-ID: <4583617a-49ad-00b5-97fc-1ea35568c5cd@huawei.com>
Date:   Mon, 15 Oct 2018 12:17:51 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <1539592576-24352-1-git-send-email-thunder.leizhen@huawei.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.41]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/10/2018 09:36, Zhen Lei wrote:
> ITS translation register map:
> 0x0000-0x003C	Reserved
> 0x0040		GITS_TRANSLATER
> 0x0044-0xFFFC	Reserved
>

Can you add a better opening than the ITS translation register map?

> The standard GITS_TRANSLATER register in ITS is only 4 bytes, but Hisilicon
> expands the next 4 bytes to carry some IMPDEF information. That means, 8 bytes
> data will be written to MSIAddress each time.
>
> MSIAddr: |----4bytes----|----4bytes----|
> 	 |    MSIData   |    IMPDEF    |
>
> There is no problem for ITS, because the next 4 bytes space is reserved in ITS.
> But it will overwrite the 4 bytes memory following "sync_count". It's very

I think arm_smmu_device.sync_count is better, or "sync_count member in 
the the smmu driver control struct".

> luckly that the previous and the next neighbour of "sync_count" are both aligned

/s/luckly/luckily or fortunately/

> by 8 bytes, so no problem is met now.
>
> It's good to explicitly add a workaround:
> 1. Add gcc __attribute__((aligned(8))) to make sure that "sync_count" is always
>    aligned by 8 bytes.
> 2. Add a "u64" union member to make sure the 4 bytes padding is always exist.
>
> There is no functional change.
>
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>  drivers/iommu/arm-smmu-v3.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
> index 5059d09..a07bc0d 100644
> --- a/drivers/iommu/arm-smmu-v3.c
> +++ b/drivers/iommu/arm-smmu-v3.c
> @@ -586,7 +586,10 @@ struct arm_smmu_device {
>
>  	struct arm_smmu_strtab_cfg	strtab_cfg;
>
> +	union {
> +	u64				padding; /* workaround for Hisilicon */

I think that a more detailed comment is required.

>  	u32				sync_count;

Can you indent these 2 members? However - as discussed internally - this 
may have endian issue so better to declare full 64b struct.

> +	} __attribute__((aligned(8)));
>
>  	/* IOMMU core code handle */
>  	struct iommu_device		iommu;
>
Thanks



