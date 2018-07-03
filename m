Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3BC9C6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 15:30:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B69824210
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 15:30:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B69824210
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932458AbeGCPan (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 11:30:43 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:51302 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932209AbeGCPal (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 11:30:41 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A14A57A9;
        Tue,  3 Jul 2018 08:30:40 -0700 (PDT)
Received: from [10.1.210.23] (e110467-lin.cambridge.arm.com [10.1.210.23])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F40013F5AD;
        Tue,  3 Jul 2018 08:30:36 -0700 (PDT)
Subject: Re: [PATCH 3/7 v5] iommu: support iommu configuration for fsl-mc
 devices
To:     Nipun Gupta <nipun.gupta@nxp.com>, will.deacon@arm.com,
        robh+dt@kernel.org, robh@kernel.org, mark.rutland@arm.com,
        catalin.marinas@arm.com, gregkh@linuxfoundation.org,
        laurentiu.tudor@nxp.com, bhelgaas@google.com
Cc:     hch@lst.de, joro@8bytes.org, m.szyprowski@samsung.com,
        shawnguo@kernel.org, frowand.list@gmail.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
        bharat.bhushan@nxp.com, stuyoder@gmail.com, leoyang.li@nxp.com
References: <1526824191-7000-1-git-send-email-nipun.gupta@nxp.com>
 <1526824191-7000-4-git-send-email-nipun.gupta@nxp.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <947a6e16-98ff-9389-b15c-d3025b7be4be@arm.com>
Date:   Tue, 3 Jul 2018 16:30:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1526824191-7000-4-git-send-email-nipun.gupta@nxp.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/05/18 14:49, Nipun Gupta wrote:
> With of_pci_map_rid available for all the busses, use the function
> for configuration of devices on fsl-mc bus

FWIW I had a quick hack at factoring out the commonality with 
of_pci_iommu_init(), at which point I reckon this change is easier to 
follow as-is for the moment, so:

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

> Signed-off-by: Nipun Gupta <nipun.gupta@nxp.com>
> ---
>   drivers/iommu/of_iommu.c | 20 ++++++++++++++++++++
>   1 file changed, 20 insertions(+)
> 
> diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
> index 811e160..284474d 100644
> --- a/drivers/iommu/of_iommu.c
> +++ b/drivers/iommu/of_iommu.c
> @@ -24,6 +24,7 @@
>   #include <linux/of_iommu.h>
>   #include <linux/of_pci.h>
>   #include <linux/slab.h>
> +#include <linux/fsl/mc.h>
>   
>   #define NO_IOMMU	1
>   
> @@ -159,6 +160,23 @@ static int of_pci_iommu_init(struct pci_dev *pdev, u16 alias, void *data)
>   	return err;
>   }
>   
> +static int of_fsl_mc_iommu_init(struct fsl_mc_device *mc_dev,
> +				struct device_node *master_np)
> +{
> +	struct of_phandle_args iommu_spec = { .args_count = 1 };
> +	int err;
> +
> +	err = of_map_rid(master_np, mc_dev->icid, "iommu-map",
> +			 "iommu-map-mask", &iommu_spec.np,
> +			 iommu_spec.args);
> +	if (err)
> +		return err == -ENODEV ? NO_IOMMU : err;
> +
> +	err = of_iommu_xlate(&mc_dev->dev, &iommu_spec);
> +	of_node_put(iommu_spec.np);
> +	return err;
> +}
> +
>   const struct iommu_ops *of_iommu_configure(struct device *dev,
>   					   struct device_node *master_np)
>   {
> @@ -190,6 +208,8 @@ const struct iommu_ops *of_iommu_configure(struct device *dev,
>   
>   		err = pci_for_each_dma_alias(to_pci_dev(dev),
>   					     of_pci_iommu_init, &info);
> +	} else if (dev_is_fsl_mc(dev)) {
> +		err = of_fsl_mc_iommu_init(to_fsl_mc_device(dev), master_np);
>   	} else {
>   		struct of_phandle_args iommu_spec;
>   		int idx = 0;
> 
