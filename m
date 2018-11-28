Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98D39C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 12:44:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69ACA20660
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 12:44:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69ACA20660
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728426AbeK1Xpz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 18:45:55 -0500
Received: from foss.arm.com ([217.140.101.70]:38482 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727829AbeK1Xpz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 18:45:55 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 611AA37D8;
        Wed, 28 Nov 2018 04:44:22 -0800 (PST)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 27DB73F59C;
        Wed, 28 Nov 2018 04:44:21 -0800 (PST)
Subject: Re: [PATCH 9/9] iommu: arm-smmu-v3: make it explicitly non-modular
To:     Paul Gortmaker <paul.gortmaker@windriver.com>,
        Joerg Roedel <joro@8bytes.org>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Will Deacon <will.deacon@arm.com>,
        Nate Watterson <nwatters@codeaurora.org>,
        linux-arm-kernel@lists.infradead.org
References: <1543271498-28966-1-git-send-email-paul.gortmaker@windriver.com>
 <1543271498-28966-10-git-send-email-paul.gortmaker@windriver.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <148f1301-76fc-a64f-aeb3-d6d2483e74b1@arm.com>
Date:   Wed, 28 Nov 2018 12:44:19 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1543271498-28966-10-git-send-email-paul.gortmaker@windriver.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/11/2018 22:31, Paul Gortmaker wrote:
> The Kconfig currently controlling compilation of this code is:
> 
> drivers/iommu/Kconfig:config ARM_SMMU_V3
> drivers/iommu/Kconfig:  bool "ARM Ltd. System MMU Version 3 (SMMUv3) Support"
> 
> ...meaning that it currently is not being built as a module by anyone.
> 
> Lets remove the modular code that is essentially orphaned, so that
> when reading the driver there is no doubt it is builtin-only.
> 
> Since module_platform_driver() uses the same init level priority as
> builtin_platform_driver() the init ordering remains unchanged with
> this commit.
> 
> We explicitly disallow a driver unbind, since that doesn't have a
> sensible use case anyway, but unlike most drivers, we can't delete the
> function tied to the ".remove" field.  This is because as of commit
> 7aa8619a66ae ("iommu/arm-smmu-v3: Implement shutdown method") the
> .remove function was given a one line wrapper and re-used to provide a
> .shutdown service.  So we delete the wrapper and re-name the function
> from remove to shutdown.
> 
> We add a moduleparam.h include since the file does actually declare
> some module parameters, and leaving them as such is the easiest way
> currently to remain backwards compatible with existing use cases.
> 
> Also note that MODULE_DEVICE_TABLE is a no-op for non-modular code.
> 
> We also delete the MODULE_LICENSE tag etc. since all that information
> is already contained at the top of the file in the comments.

With the title fixed up,

Acked-by: Robin Murphy <robin.murphy@arm.com>

> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Joerg Roedel <joro@8bytes.org>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Cc: Nate Watterson <nwatters@codeaurora.org>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: iommu@lists.linux-foundation.org
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
> ---
>   drivers/iommu/arm-smmu-v3.c | 25 +++++++++----------------
>   1 file changed, 9 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
> index 6947ccf26512..1189c06079d4 100644
> --- a/drivers/iommu/arm-smmu-v3.c
> +++ b/drivers/iommu/arm-smmu-v3.c
> @@ -20,7 +20,8 @@
>   #include <linux/interrupt.h>
>   #include <linux/iommu.h>
>   #include <linux/iopoll.h>
> -#include <linux/module.h>
> +#include <linux/init.h>
> +#include <linux/moduleparam.h>
>   #include <linux/msi.h>
>   #include <linux/of.h>
>   #include <linux/of_address.h>
> @@ -356,6 +357,10 @@
>   #define MSI_IOVA_BASE			0x8000000
>   #define MSI_IOVA_LENGTH			0x100000
>   
> +/*
> + * not really modular, but the easiest way to keep compat with existing
> + * bootargs behaviour is to continue using module_param_named here.
> + */
>   static bool disable_bypass = 1;
>   module_param_named(disable_bypass, disable_bypass, bool, S_IRUGO);
>   MODULE_PARM_DESC(disable_bypass,
> @@ -2928,37 +2933,25 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
>   	return 0;
>   }
>   
> -static int arm_smmu_device_remove(struct platform_device *pdev)
> +static void arm_smmu_device_shutdown(struct platform_device *pdev)
>   {
>   	struct arm_smmu_device *smmu = platform_get_drvdata(pdev);
>   
>   	arm_smmu_device_disable(smmu);
> -
> -	return 0;
> -}
> -
> -static void arm_smmu_device_shutdown(struct platform_device *pdev)
> -{
> -	arm_smmu_device_remove(pdev);
>   }
>   
>   static const struct of_device_id arm_smmu_of_match[] = {
>   	{ .compatible = "arm,smmu-v3", },
>   	{ },
>   };
> -MODULE_DEVICE_TABLE(of, arm_smmu_of_match);
>   
>   static struct platform_driver arm_smmu_driver = {
>   	.driver	= {
>   		.name		= "arm-smmu-v3",
>   		.of_match_table	= of_match_ptr(arm_smmu_of_match),
> +		.suppress_bind_attrs = true,
>   	},
>   	.probe	= arm_smmu_device_probe,
> -	.remove	= arm_smmu_device_remove,
>   	.shutdown = arm_smmu_device_shutdown,
>   };
> -module_platform_driver(arm_smmu_driver);
> -
> -MODULE_DESCRIPTION("IOMMU API for ARM architected SMMUv3 implementations");
> -MODULE_AUTHOR("Will Deacon <will.deacon@arm.com>");
> -MODULE_LICENSE("GPL v2");
> +builtin_platform_driver(arm_smmu_driver);
> 
