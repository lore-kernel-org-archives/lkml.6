Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A153C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 12:42:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16EA22086B
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 12:42:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16EA22086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728694AbeK1XoJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 18:44:09 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:38352 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727945AbeK1XoJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 18:44:09 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F134C37D8;
        Wed, 28 Nov 2018 04:42:36 -0800 (PST)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A7FD03F59C;
        Wed, 28 Nov 2018 04:42:33 -0800 (PST)
Subject: Re: [PATCH 8/9] iommu: arm-smmu: make it explicitly non-modular
To:     Paul Gortmaker <paul.gortmaker@windriver.com>,
        Joerg Roedel <joro@8bytes.org>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Will Deacon <will.deacon@arm.com>,
        Nate Watterson <nwatters@codeaurora.org>,
        linux-arm-kernel@lists.infradead.org
References: <1543271498-28966-1-git-send-email-paul.gortmaker@windriver.com>
 <1543271498-28966-9-git-send-email-paul.gortmaker@windriver.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <755c95d7-882c-0dec-207e-20bf8f22b159@arm.com>
Date:   Wed, 28 Nov 2018 12:42:31 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1543271498-28966-9-git-send-email-paul.gortmaker@windriver.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

On 26/11/2018 22:31, Paul Gortmaker wrote:
> The Kconfig currently controlling compilation of this code is:
> 
> drivers/iommu/Kconfig:config ARM_SMMU
> drivers/iommu/Kconfig:  bool "ARM Ltd. System MMU (SMMU) Support"
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
> We also delete the MODULE_LICENSE tag etc. since all that information
> is already contained at the top of the file in the comments.
> 
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Joerg Roedel <joro@8bytes.org>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Cc: Nate Watterson <nwatters@codeaurora.org>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: iommu@lists.linux-foundation.org
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
> ---
>   drivers/iommu/arm-smmu.c | 32 +++++++++++++-------------------
>   1 file changed, 13 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> index 5a28ae892504..4a2e143fdf52 100644
> --- a/drivers/iommu/arm-smmu.c
> +++ b/drivers/iommu/arm-smmu.c
> @@ -41,7 +41,8 @@
>   #include <linux/io-64-nonatomic-hi-lo.h>
>   #include <linux/iommu.h>
>   #include <linux/iopoll.h>
> -#include <linux/module.h>
> +#include <linux/init.h>
> +#include <linux/moduleparam.h>
>   #include <linux/of.h>
>   #include <linux/of_address.h>
>   #include <linux/of_device.h>
> @@ -101,6 +102,10 @@
>   #define MSI_IOVA_LENGTH			0x100000
>   
>   static int force_stage;
> +/*
> + * not really modular, but the easiest way to keep compat with existing
> + * bootargs behaviour is to continue using module_param() here.
> + */

Is it worth introducing builtin_param() and friends for this sort of 
thing, to echo the *_platform_driver() helpers? It seems like that could 
be justifiable under the motivation described in the cover letter.

Otherwise, the changes look reasonable. I still hold out hope that one 
day we'll be able to make IOMMU drivers modular (it can work with 
minimal hacks today, but it's far from robust in general), but for now I 
agree this makes sense (and it'll be easy enough to revert for playing 
with further hacks). With the title fixed up as Joerg asked,

Acked-by: Robin Murphy <robin.murphy@arm.com>

>   module_param(force_stage, int, S_IRUGO);
>   MODULE_PARM_DESC(force_stage,
>   	"Force SMMU mappings to be installed at a particular stage of translation. A value of '1' or '2' forces the corresponding stage. All other values are ignored (i.e. no stage is forced). Note that selecting a specific stage will disable support for nested translation.");
> @@ -1964,7 +1969,6 @@ static const struct of_device_id arm_smmu_of_match[] = {
>   	{ .compatible = "cavium,smmu-v2", .data = &cavium_smmuv2 },
>   	{ },
>   };
> -MODULE_DEVICE_TABLE(of, arm_smmu_of_match);
>   
>   #ifdef CONFIG_ACPI
>   static int acpi_smmu_get_data(u32 model, struct arm_smmu_device *smmu)
> @@ -2224,24 +2228,18 @@ static int arm_smmu_legacy_bus_init(void)
>   }
>   device_initcall_sync(arm_smmu_legacy_bus_init);
>   
> -static int arm_smmu_device_remove(struct platform_device *pdev)
> +static void arm_smmu_device_shutdown(struct platform_device *pdev)
>   {
>   	struct arm_smmu_device *smmu = platform_get_drvdata(pdev);
>   
>   	if (!smmu)
> -		return -ENODEV;
> +		return;
>   
>   	if (!bitmap_empty(smmu->context_map, ARM_SMMU_MAX_CBS))
>   		dev_err(&pdev->dev, "removing device with active domains!\n");
>   
>   	/* Turn the thing off */
>   	writel(sCR0_CLIENTPD, ARM_SMMU_GR0_NS(smmu) + ARM_SMMU_GR0_sCR0);
> -	return 0;
> -}
> -
> -static void arm_smmu_device_shutdown(struct platform_device *pdev)
> -{
> -	arm_smmu_device_remove(pdev);
>   }
>   
>   static int __maybe_unused arm_smmu_pm_resume(struct device *dev)
> @@ -2256,16 +2254,12 @@ static SIMPLE_DEV_PM_OPS(arm_smmu_pm_ops, NULL, arm_smmu_pm_resume);
>   
>   static struct platform_driver arm_smmu_driver = {
>   	.driver	= {
> -		.name		= "arm-smmu",
> -		.of_match_table	= of_match_ptr(arm_smmu_of_match),
> -		.pm		= &arm_smmu_pm_ops,
> +		.name			= "arm-smmu",
> +		.of_match_table		= of_match_ptr(arm_smmu_of_match),
> +		.pm			= &arm_smmu_pm_ops,
> +		.suppress_bind_attrs	= true,
>   	},
>   	.probe	= arm_smmu_device_probe,
> -	.remove	= arm_smmu_device_remove,
>   	.shutdown = arm_smmu_device_shutdown,
>   };
> -module_platform_driver(arm_smmu_driver);
> -
> -MODULE_DESCRIPTION("IOMMU API for ARM architected SMMU implementations");
> -MODULE_AUTHOR("Will Deacon <will.deacon@arm.com>");
> -MODULE_LICENSE("GPL v2");
> +builtin_platform_driver(arm_smmu_driver);
> 
