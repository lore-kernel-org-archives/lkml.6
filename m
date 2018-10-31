Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E13BC0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 11:43:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBE4120685
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 11:43:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBE4120685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728660AbeJaUli (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 16:41:38 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:39814 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725897AbeJaUli (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 16:41:38 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 22C2280D;
        Wed, 31 Oct 2018 04:43:56 -0700 (PDT)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C08423F71D;
        Wed, 31 Oct 2018 04:43:54 -0700 (PDT)
Subject: Re: [PATCH v3 1/1] iommu/arm-smmu-v3: eliminate a potential memory
 corruption on hi1620 and earlier
To:     Zhen Lei <thunder.leizhen@huawei.com>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will.deacon@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        iommu <iommu@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Cc:     LinuxArm <linuxarm@huawei.com>
References: <1540958527-15408-1-git-send-email-thunder.leizhen@huawei.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <ba9a0f3b-d150-c066-91a4-9ed9a380670b@arm.com>
Date:   Wed, 31 Oct 2018 11:43:50 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1540958527-15408-1-git-send-email-thunder.leizhen@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/10/2018 04:02, Zhen Lei wrote:
> The standard GITS_TRANSLATER register in ITS is only 4 bytes, but
> Hisilicon expands the next 4 bytes to carry some IMPDEF information. That
> means, total 8 bytes data will be written to MSIAddress each time.
> 
> MSIAddr: |----4bytes----|----4bytes----|
> 	 |    MSIData   |    IMPDEF    |
> 
> There is no problem for ITS, because the next 4 bytes space is reserved
> in ITS. But it will overwrite the 4 bytes memory following "sync_count".
> It's very fortunately that the previous and the next neighbour of the
> "sync_count" are both aligned by 8 bytes, so no problem is met now.
> 
> It's good to explicitly add a workaround. Let's enclose the "sync_count"
> into a union and companion with a new member "padding" of type u64.
> 
> There is no functional change.

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>   drivers/iommu/arm-smmu-v3.c | 18 +++++++++++++++++-
>   1 file changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
> index 6947ccf..4e94730 100644
> --- a/drivers/iommu/arm-smmu-v3.c
> +++ b/drivers/iommu/arm-smmu-v3.c
> @@ -576,7 +576,23 @@ struct arm_smmu_device {
> 
>   	struct arm_smmu_strtab_cfg	strtab_cfg;
> 
> -	u32				sync_count;
> +	/*
> +	 * The member "padding" is used to make sure the member "sync_count" to
> +	 * be aligned at 8 bytes boundary, and 4 bytes padding memory followed.
> +	 *
> +	 * These are required by hi1620 and earlier of Hisilicon. Because the
> +	 * ITS hardware on hi1620 and earlier will truncate the MSIAddress(Here
> +	 * it's the address of "sync_count") to 8 bytes boundary first, then
> +	 * write 32 bits MSIdata at offset 0, and 32 bits IMPDEF data at offset
> +	 * 4. Without this workaround, the adjacent member maybe overwritten.
> +	 *
> +	 *                    |---4bytes---|---4bytes---|
> +	 * MSIAddress & (~0x7):   MSIdata  | IMPDEF data|
> +	 */
> +	union {
> +		u32			sync_count;
> +		u64			padding;
> +	};
> 
>   	/* IOMMU core code handle */
>   	struct iommu_device		iommu;
> --
> 1.8.3
> 
> 
