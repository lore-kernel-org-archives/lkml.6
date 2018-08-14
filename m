Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF821C46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 16:59:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98B032172B
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 16:59:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98B032172B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733026AbeHNTrK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 15:47:10 -0400
Received: from foss.arm.com ([217.140.101.70]:46204 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732191AbeHNTrK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 15:47:10 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A066018A;
        Tue, 14 Aug 2018 09:59:12 -0700 (PDT)
Received: from [10.4.12.131] (e110467-lin.Emea.Arm.com [10.4.12.131])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 83D113F5BD;
        Tue, 14 Aug 2018 09:59:10 -0700 (PDT)
Subject: Re: [PATCH 4/5] iommu/arm-smmu: Make way to add Qcom's smmu-500
 errata handling
To:     Vivek Gautam <vivek.gautam@codeaurora.org>, joro@8bytes.org,
        andy.gross@linaro.org, will.deacon@arm.com,
        bjorn.andersson@linaro.org, iommu@lists.linux-foundation.org
Cc:     mark.rutland@arm.com, david.brown@linaro.org, tfiga@chromium.org,
        swboyd@chromium.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20180814105528.20592-1-vivek.gautam@codeaurora.org>
 <20180814105528.20592-5-vivek.gautam@codeaurora.org>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <cfca5369-eacd-bb4b-6f1e-68a56f72c327@arm.com>
Date:   Tue, 14 Aug 2018 17:59:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180814105528.20592-5-vivek.gautam@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/08/18 11:55, Vivek Gautam wrote:
> Cleanup to re-use some of the stuff
> 
> Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
> ---
>   drivers/iommu/arm-smmu.c | 32 +++++++++++++++++++++++++-------
>   1 file changed, 25 insertions(+), 7 deletions(-)

I think the overall diffstat would be an awful lot smaller if the 
erratum workaround just has its own readl_poll_timeout() as it does in 
the vendor kernel. The burst-polling loop is for minimising latency in 
high-throughput situations, and if you're in a workaround which has to 
lock *every* register write and issue two firmware calls around each 
sync I think you're already well out of that game.

> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> index 32e86df80428..75c146751c87 100644
> --- a/drivers/iommu/arm-smmu.c
> +++ b/drivers/iommu/arm-smmu.c
> @@ -391,21 +391,31 @@ static void __arm_smmu_free_bitmap(unsigned long *map, int idx)
>   	clear_bit(idx, map);
>   }
>   
> -/* Wait for any pending TLB invalidations to complete */
> -static void __arm_smmu_tlb_sync(struct arm_smmu_device *smmu,
> -				void __iomem *sync, void __iomem *status)
> +static int __arm_smmu_tlb_sync_wait(void __iomem *status)
>   {
>   	unsigned int spin_cnt, delay;
>   
> -	writel_relaxed(0, sync);
>   	for (delay = 1; delay < TLB_LOOP_TIMEOUT; delay *= 2) {
>   		for (spin_cnt = TLB_SPIN_COUNT; spin_cnt > 0; spin_cnt--) {
>   			if (!(readl_relaxed(status) & sTLBGSTATUS_GSACTIVE))
> -				return;
> +				return 0;
>   			cpu_relax();
>   		}
>   		udelay(delay);
>   	}
> +
> +	return -EBUSY;
> +}
> +
> +/* Wait for any pending TLB invalidations to complete */
> +static void __arm_smmu_tlb_sync(struct arm_smmu_device *smmu,
> +				void __iomem *sync, void __iomem *status)
> +{
> +	writel_relaxed(0, sync);
> +
> +	if (!__arm_smmu_tlb_sync_wait(status))
> +		return;
> +
>   	dev_err_ratelimited(smmu->dev,
>   			    "TLB sync timed out -- SMMU may be deadlocked\n");
>   }
> @@ -461,8 +471,9 @@ static void arm_smmu_tlb_inv_context_s2(void *cookie)
>   	arm_smmu_tlb_sync_global(smmu);
>   }
>   
> -static void arm_smmu_tlb_inv_range_nosync(unsigned long iova, size_t size,
> -					  size_t granule, bool leaf, void *cookie)
> +static void __arm_smmu_tlb_inv_range_nosync(unsigned long iova, size_t size,
> +					    size_t granule, bool leaf,
> +					    void *cookie)
>   {
>   	struct arm_smmu_domain *smmu_domain = cookie;
>   	struct arm_smmu_cfg *cfg = &smmu_domain->cfg;
> @@ -498,6 +509,13 @@ static void arm_smmu_tlb_inv_range_nosync(unsigned long iova, size_t size,
>   	}
>   }
>   
> +static void arm_smmu_tlb_inv_range_nosync(unsigned long iova, size_t size,
> +					  size_t granule, bool leaf,
> +					  void *cookie)
> +{
> +	__arm_smmu_tlb_inv_range_nosync(iova, size, granule, leaf, cookie);
> +}
> +

AFAICS even after patch #5 this does absolutely nothing except make the 
code needlessly harder to read :(

Robin.

>   /*
>    * On MMU-401 at least, the cost of firing off multiple TLBIVMIDs appears
>    * almost negligible, but the benefit of getting the first one in as far ahead
> 
