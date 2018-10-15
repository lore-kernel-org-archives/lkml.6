Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6A3CC04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 09:48:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB0992083C
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 09:48:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB0992083C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727254AbeJPRi1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 13:38:27 -0400
Received: from foss.arm.com ([217.140.101.70]:60844 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726581AbeJPRiP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 13:38:15 -0400
Received: by usa-sjc-mx-foss1.foss.arm.com (Postfix, from userid 105)
        id 876333652; Tue, 16 Oct 2018 03:28:32 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 260CD2EC5;
        Mon, 15 Oct 2018 05:46:41 -0700 (PDT)
Received: from localhost (unknown [10.37.6.11])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9FBD03F5B1;
        Mon, 15 Oct 2018 05:46:20 -0700 (PDT)
Date:   Mon, 15 Oct 2018 13:46:18 +0100
From:   Andrew Murray <andrew.murray@arm.com>
To:     Zhen Lei <thunder.leizhen@huawei.com>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        iommu <iommu@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        LinuxArm <linuxarm@huawei.com>
Subject: Re: [PATCH 1/1] iommu/arm-smmu-v3: eliminate a potential memory
 corruption on Hi16xx soc
Message-ID: <20181015124617.GA12972@e119886-lin.cambridge.arm.com>
References: <1539592576-24352-1-git-send-email-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1539592576-24352-1-git-send-email-thunder.leizhen@huawei.com>
User-Agent: Mutt/1.10.1+81 (426a6c1) (2018-08-26)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Zhen,

On Mon, Oct 15, 2018 at 04:36:16PM +0800, Zhen Lei wrote:
> ITS translation register map:
> 0x0000-0x003C	Reserved
> 0x0040		GITS_TRANSLATER
> 0x0044-0xFFFC	Reserved
> 
> The standard GITS_TRANSLATER register in ITS is only 4 bytes, but Hisilicon
> expands the next 4 bytes to carry some IMPDEF information. That means, 8 bytes
> data will be written to MSIAddress each time.
> 
> MSIAddr: |----4bytes----|----4bytes----|
> 	 |    MSIData   |    IMPDEF    |
> 
> There is no problem for ITS, because the next 4 bytes space is reserved in ITS.
> But it will overwrite the 4 bytes memory following "sync_count". It's very
> luckly that the previous and the next neighbour of "sync_count" are both aligned
> by 8 bytes, so no problem is met now.

My understanding is that MSI's are 32bit memory writes and as such the SMMU
performs a 32bit write in response to the MSI. If so then what is different
with the Hi16xx that causes a problem? Have you been able to able to adjust
the layout of the arm_smmu_device struct to demonstrate this?

Thanks,

Andrew Murray

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
>  	u32				sync_count;
> +	} __attribute__((aligned(8)));
>  
>  	/* IOMMU core code handle */
>  	struct iommu_device		iommu;
> -- 
> 1.8.3
> 
> 
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
