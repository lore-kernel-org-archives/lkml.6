Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E060EC6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 08:36:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1FFE20685
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 08:36:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1FFE20685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388639AbeGXJl5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 05:41:57 -0400
Received: from foss.arm.com ([217.140.101.70]:45188 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388531AbeGXJl5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 05:41:57 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 87F2080D;
        Tue, 24 Jul 2018 01:36:35 -0700 (PDT)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 58D843F237;
        Tue, 24 Jul 2018 01:36:35 -0700 (PDT)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id E74B81AE3B5E; Tue, 24 Jul 2018 09:36:34 +0100 (BST)
Date:   Tue, 24 Jul 2018 09:36:34 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Vivek Gautam <vivek.gautam@codeaurora.org>
Cc:     joro@8bytes.org, robh+dt@kernel.org, robin.murphy@arm.com,
        andy.gross@linaro.org, mark.rutland@arm.com,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, tfiga@chromium.org,
        sricharan@codeaurora.org, linux-arm-msm@vger.kernel.org,
        david.brown@linaro.org, linux-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 3/3] iommu/arm-smmu: Error out only if not enough context
 interrupts
Message-ID: <20180724083633.GA19324@arm.com>
References: <20180719175356.14753-1-vivek.gautam@codeaurora.org>
 <20180719175356.14753-4-vivek.gautam@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180719175356.14753-4-vivek.gautam@codeaurora.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 19, 2018 at 11:23:56PM +0530, Vivek Gautam wrote:
> Currently we check if the number of context banks is not equal to
> num_context_interrupts. However, there are booloaders such as, one
> on sdm845 that reserves few context banks and thus kernel views
> less than the total available context banks.
> So, although the hardware definition in device tree would mention
> the correct number of context interrupts, this number can be
> greater than the number of context banks visible to smmu in kernel.
> We should therefore error out only when the number of context banks
> is greater than the available number of context interrupts.
> 
> Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
> Suggested-by: Tomasz Figa <tfiga@chromium.org>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> ---
>  drivers/iommu/arm-smmu.c | 19 +++++++++++++------
>  1 file changed, 13 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> index 7c69736a30f8..4cb53bf4f423 100644
> --- a/drivers/iommu/arm-smmu.c
> +++ b/drivers/iommu/arm-smmu.c
> @@ -2229,12 +2229,19 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
>  	if (err)
>  		return err;
>  
> -	if (smmu->version == ARM_SMMU_V2 &&
> -	    smmu->num_context_banks != smmu->num_context_irqs) {
> -		dev_err(dev,
> -			"found only %d context interrupt(s) but %d required\n",
> -			smmu->num_context_irqs, smmu->num_context_banks);
> -		return -ENODEV;
> +	if (smmu->version == ARM_SMMU_V2) {
> +		if (smmu->num_context_banks > smmu->num_context_irqs) {
> +			dev_err(dev,
> +			      "found only %d context irq(s) but %d required\n",
> +			      smmu->num_context_irqs, smmu->num_context_banks);
> +			return -ENODEV;
> +		} else if (smmu->num_context_banks < smmu->num_context_irqs) {
> +			/* loose extra context interrupts */
> +			dev_notice(dev,
> +			      "found %d context irq(s) but only %d required\n",
> +			      smmu->num_context_irqs, smmu->num_context_banks);
> +			smmu->num_context_irqs = smmu->num_context_banks;
> +		}

I don't see the utility in the new message. Can you simplify with the patch
below on top? It's a bit weird that we only decide to ignore the extra irqs
after calling platform_get_irq() on them, but that seems to be harmless.

Will

--->8

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index aa46c1ed5bf9..5349e22b5c78 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -2109,13 +2109,10 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
 			      "found only %d context irq(s) but %d required\n",
 			      smmu->num_context_irqs, smmu->num_context_banks);
 			return -ENODEV;
-		} else if (smmu->num_context_banks < smmu->num_context_irqs) {
-			/* loose extra context interrupts */
-			dev_notice(dev,
-			      "found %d context irq(s) but only %d required\n",
-			      smmu->num_context_irqs, smmu->num_context_banks);
-			smmu->num_context_irqs = smmu->num_context_banks;
 		}
+
+		/* Ignore superfluous interrupts */
+		smmu->num_context_irqs = smmu->num_context_banks;
 	}
 
 	for (i = 0; i < smmu->num_global_irqs; ++i) {
