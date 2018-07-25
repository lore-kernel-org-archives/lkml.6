Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1375BC67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 12:48:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC27120882
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 12:48:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC27120882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729073AbeGYOAT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 10:00:19 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:38222 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728927AbeGYOAS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 10:00:18 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B567380D;
        Wed, 25 Jul 2018 05:48:45 -0700 (PDT)
Received: from [10.4.12.131] (e110467-lin.emea.arm.com [10.4.12.131])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1F4083F237;
        Wed, 25 Jul 2018 05:48:41 -0700 (PDT)
Subject: Re: [PATCH 4/7 v6] iommu/arm-smmu: Add support for the fsl-mc bus
To:     Nipun Gupta <nipun.gupta@nxp.com>, will.deacon@arm.com,
        robh+dt@kernel.org, robh@kernel.org, mark.rutland@arm.com,
        catalin.marinas@arm.com, gregkh@linuxfoundation.org,
        laurentiu.tudor@nxp.com, bhelgaas@google.com, hch@lst.de
Cc:     joro@8bytes.org, m.szyprowski@samsung.com, shawnguo@kernel.org,
        frowand.list@gmail.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
        bharat.bhushan@nxp.com, stuyoder@gmail.com, leoyang.li@nxp.com
References: <1531135103-10699-1-git-send-email-nipun.gupta@nxp.com>
 <1531135103-10699-5-git-send-email-nipun.gupta@nxp.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <ffa08d6b-580a-93bf-fdf8-571b7d26ee73@arm.com>
Date:   Wed, 25 Jul 2018 13:48:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1531135103-10699-5-git-send-email-nipun.gupta@nxp.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/07/18 12:18, Nipun Gupta wrote:
> Implement bus specific support for the fsl-mc bus including
> registering arm_smmu_ops and bus specific device add operations.

I guess this is about as neat as it can get;

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

> Signed-off-by: Nipun Gupta <nipun.gupta@nxp.com>
> ---
>   drivers/iommu/arm-smmu.c |  7 +++++++
>   drivers/iommu/iommu.c    | 13 +++++++++++++
>   include/linux/fsl/mc.h   |  8 ++++++++
>   include/linux/iommu.h    |  2 ++
>   4 files changed, 30 insertions(+)
> 
> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> index f7a96bc..a011bb6 100644
> --- a/drivers/iommu/arm-smmu.c
> +++ b/drivers/iommu/arm-smmu.c
> @@ -52,6 +52,7 @@
>   #include <linux/spinlock.h>
>   
>   #include <linux/amba/bus.h>
> +#include <linux/fsl/mc.h>
>   
>   #include "io-pgtable.h"
>   #include "arm-smmu-regs.h"
> @@ -1459,6 +1460,8 @@ static struct iommu_group *arm_smmu_device_group(struct device *dev)
>   
>   	if (dev_is_pci(dev))
>   		group = pci_device_group(dev);
> +	else if (dev_is_fsl_mc(dev))
> +		group = fsl_mc_device_group(dev);
>   	else
>   		group = generic_device_group(dev);
>   
> @@ -2037,6 +2040,10 @@ static void arm_smmu_bus_init(void)
>   		bus_set_iommu(&pci_bus_type, &arm_smmu_ops);
>   	}
>   #endif
> +#ifdef CONFIG_FSL_MC_BUS
> +	if (!iommu_present(&fsl_mc_bus_type))
> +		bus_set_iommu(&fsl_mc_bus_type, &arm_smmu_ops);
> +#endif
>   }
>   
>   static int arm_smmu_device_probe(struct platform_device *pdev)
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index d227b86..df2f49e 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -32,6 +32,7 @@
>   #include <linux/pci.h>
>   #include <linux/bitops.h>
>   #include <linux/property.h>
> +#include <linux/fsl/mc.h>
>   #include <trace/events/iommu.h>
>   
>   static struct kset *iommu_group_kset;
> @@ -988,6 +989,18 @@ struct iommu_group *pci_device_group(struct device *dev)
>   	return iommu_group_alloc();
>   }
>   
> +/* Get the IOMMU group for device on fsl-mc bus */
> +struct iommu_group *fsl_mc_device_group(struct device *dev)
> +{
> +	struct device *cont_dev = fsl_mc_cont_dev(dev);
> +	struct iommu_group *group;
> +
> +	group = iommu_group_get(cont_dev);
> +	if (!group)
> +		group = iommu_group_alloc();
> +	return group;
> +}
> +
>   /**
>    * iommu_group_get_for_dev - Find or create the IOMMU group for a device
>    * @dev: target device
> diff --git a/include/linux/fsl/mc.h b/include/linux/fsl/mc.h
> index f27cb14..dddaca1 100644
> --- a/include/linux/fsl/mc.h
> +++ b/include/linux/fsl/mc.h
> @@ -351,6 +351,14 @@ struct fsl_mc_io {
>   #define dev_is_fsl_mc(_dev) (0)
>   #endif
>   
> +/* Macro to check if a device is a container device */
> +#define fsl_mc_is_cont_dev(_dev) (to_fsl_mc_device(_dev)->flags & \
> +	FSL_MC_IS_DPRC)
> +
> +/* Macro to get the container device of a MC device */
> +#define fsl_mc_cont_dev(_dev) (fsl_mc_is_cont_dev(_dev) ? \
> +	(_dev) : (_dev)->parent)
> +
>   /*
>    * module_fsl_mc_driver() - Helper macro for drivers that don't do
>    * anything special in module init/exit.  This eliminates a lot of
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 7447b0b..209891d 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -389,6 +389,8 @@ static inline size_t iommu_map_sg(struct iommu_domain *domain,
>   extern struct iommu_group *pci_device_group(struct device *dev);
>   /* Generic device grouping function */
>   extern struct iommu_group *generic_device_group(struct device *dev);
> +/* FSL-MC device grouping function */
> +struct iommu_group *fsl_mc_device_group(struct device *dev);
>   
>   /**
>    * struct iommu_fwspec - per-device IOMMU instance data
> 
