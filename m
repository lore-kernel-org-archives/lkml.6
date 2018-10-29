Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73886C0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 17:59:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24F89204FD
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 17:59:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24F89204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728240AbeJ3Csk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 22:48:40 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:44024 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728104AbeJ3Csk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 22:48:40 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0742A1596;
        Mon, 29 Oct 2018 10:58:59 -0700 (PDT)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id CC2BC3F6A8;
        Mon, 29 Oct 2018 10:58:58 -0700 (PDT)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id DE44D1AE091C; Mon, 29 Oct 2018 17:59:05 +0000 (GMT)
Date:   Mon, 29 Oct 2018 17:59:05 +0000
From:   Will Deacon <will.deacon@arm.com>
To:     Zhen Lei <thunder.leizhen@huawei.com>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        iommu <iommu@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        LinuxArm <linuxarm@huawei.com>
Subject: Re: [PATCH v2 1/1] iommu/arm-smmu-v3: eliminate a potential memory
 corruption on Hi16xx soc
Message-ID: <20181029175905.GC16739@arm.com>
References: <1540021014-8176-1-git-send-email-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1540021014-8176-1-git-send-email-thunder.leizhen@huawei.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 20, 2018 at 03:36:54PM +0800, Zhen Lei wrote:
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
> It's good to explicitly add a workaround:
> 1. Add gcc __attribute__((aligned(8))) to make sure that "sync_count" is
>    always aligned by 8 bytes.
> 2. Add a "int" struct member to make sure the 4 bytes padding is always
>    exist.
> 
> There is no functional change.
> 
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>  drivers/iommu/arm-smmu-v3.c | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
> index 5059d09..624fdd0 100644
> --- a/drivers/iommu/arm-smmu-v3.c
> +++ b/drivers/iommu/arm-smmu-v3.c
> @@ -586,7 +586,20 @@ struct arm_smmu_device {
>  
>  	struct arm_smmu_strtab_cfg	strtab_cfg;
>  
> -	u32				sync_count;
> +	/*
> +	 * The alignment and padding is required by Hi16xx of Hisilicon.
> +	 * Because the ITS hardware on Hi16xx will truncate the MSIAddress(Here
> +	 * it's the address of "sync_count") to 8 bytes boundary first, then
> +	 * write 32 bits MSIdata at offset 0, and 32 bits IMPDEF data at offset
> +	 * 4. Without this workaround, the adjacent member maybe overwritten.
> +	 *
> +	 *                    |---4bytes---|---4bytes---|
> +	 * MSIAddress & (~0x7):   MSIdata  | IMPDEF data|
> +	 */
> +	struct {
> +		u32			sync_count;
> +		int			padding;
> +	} __attribute__((aligned(8)));

I thought the conclusion after reviewing your original patch was to maintain
the union and drop the alignment directive? e.g.

	union {
		u32	sync_count;
		u64	padding; /* Hi16xx writes an extra 32 bits of goodness */
	};

Will
