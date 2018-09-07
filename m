Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E2C0C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 15:36:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 193452075E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 15:36:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 193452075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730254AbeIGURo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 16:17:44 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:33706 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728430AbeIGURo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 16:17:44 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 49DF518A;
        Fri,  7 Sep 2018 08:36:17 -0700 (PDT)
Received: from [10.4.12.131] (e110467-lin.emea.arm.com [10.4.12.131])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 04F2C3F5BC;
        Fri,  7 Sep 2018 08:36:14 -0700 (PDT)
Subject: Re: [PATCH v2 1/4] acpi: arm64: add iort support for PMCG
To:     Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
        lorenzo.pieralisi@arm.com
Cc:     will.deacon@arm.com, mark.rutland@arm.com, guohanjun@huawei.com,
        john.garry@huawei.com, pabba@codeaurora.org,
        vkilari@codeaurora.org, rruigrok@codeaurora.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linuxarm@huawei.com,
        neil.m.leeder@gmail.com
References: <20180724114515.21764-1-shameerali.kolothum.thodi@huawei.com>
 <20180724114515.21764-2-shameerali.kolothum.thodi@huawei.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <40e762a2-0b53-d88d-936c-a0cff190682a@arm.com>
Date:   Fri, 7 Sep 2018 16:36:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180724114515.21764-2-shameerali.kolothum.thodi@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/07/18 12:45, Shameer Kolothum wrote:
> From: Neil Leeder <nleeder@codeaurora.org>
> 
> Add support for the SMMU Performance Monitor Counter Group
> information from ACPI. This is in preparation for its use
> in the SMMU v3 PMU driver.
> 
> Signed-off-by: Neil Leeder <nleeder@codeaurora.org>
> Signed-off-by: Hanjun Guo <guohanjun@huawei.com>
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> ---
>   drivers/acpi/arm64/iort.c | 95 +++++++++++++++++++++++++++++++++++++++++------
>   1 file changed, 83 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
> index 7a3a541..ac4d0d6 100644
> --- a/drivers/acpi/arm64/iort.c
> +++ b/drivers/acpi/arm64/iort.c
> @@ -356,7 +356,8 @@ static struct acpi_iort_node *iort_node_get_id(struct acpi_iort_node *node,
>   	if (map->flags & ACPI_IORT_ID_SINGLE_MAPPING) {
>   		if (node->type == ACPI_IORT_NODE_NAMED_COMPONENT ||
>   		    node->type == ACPI_IORT_NODE_PCI_ROOT_COMPLEX ||
> -		    node->type == ACPI_IORT_NODE_SMMU_V3) {
> +		    node->type == ACPI_IORT_NODE_SMMU_V3 ||
> +		    node->type == ACPI_IORT_NODE_PMCG) {
>   			*id_out = map->output_base;
>   			return parent;
>   		}
> @@ -394,6 +395,8 @@ static int iort_get_id_mapping_index(struct acpi_iort_node *node)
>   		}
>   
>   		return smmu->id_mapping_index;
> +	case ACPI_IORT_NODE_PMCG:
> +		return 0;

Why do we need a PMCG case here? AIUI this whole get_id_mapping_index 
business is only relevant to SMMUv3 nodes where we have some need to 
disambiguate the difference between the SMMU's own IDs and 
StreamID-to-DeviceID mappings within the same table. PMCGs simply have 
zero or one single ID mappings so should be equivalent to most named 
components (other than their mappings pointing straight to the ITS).

>   	default:
>   		return -EINVAL;
>   	}
> @@ -1287,6 +1290,63 @@ static bool __init arm_smmu_is_coherent(struct acpi_iort_node *node)
>   	return smmu->flags & ACPI_IORT_SMMU_COHERENT_WALK;
>   }
>   
> +static void __init arm_smmu_common_dma_configure(struct device *dev,
> +						enum dev_dma_attr attr)
> +{
> +	/* We expect the dma masks to be equivalent for	all SMMUs set-ups */
> +	dev->dma_mask = &dev->coherent_dma_mask;
> +
> +	/* Configure DMA for the page table walker */
> +	acpi_dma_configure(dev, attr);

Hmm, I don't think we actually need this call any more, since it should 
now happen later anyway via platform_dma_configure() as the relevant 
SMMU/PMCG driver binds.

> +}
> +
> +static int __init arm_smmu_v3_pmu_count_resources(struct acpi_iort_node *node)

Can we be consistent with "pmcg" rather than "pmu" within IORT please?

> +{
> +	struct acpi_iort_pmcg *pmcg;
> +
> +	/* Retrieve PMCG specific data */
> +	pmcg = (struct acpi_iort_pmcg *)node->node_data;
> +
> +	/*
> +	 * There are always 2 memory resources.
> +	 * If the overflow_gsiv is present then add that for a total of 3.
> +	 */
> +	return pmcg->overflow_gsiv > 0 ? 3 : 2;
> +}
> +
> +static void __init arm_smmu_v3_pmu_init_resources(struct resource *res,
> +					       struct acpi_iort_node *node)
> +{
> +	struct acpi_iort_pmcg *pmcg;
> +
> +	/* Retrieve PMCG specific data */
> +	pmcg = (struct acpi_iort_pmcg *)node->node_data;
> +
> +	res[0].start = pmcg->page0_base_address;
> +	res[0].end = pmcg->page0_base_address + SZ_4K - 1;
> +	res[0].flags = IORESOURCE_MEM;
> +	res[1].start = pmcg->page1_base_address;
> +	res[1].end = pmcg->page1_base_address + SZ_4K - 1;
> +	res[1].flags = IORESOURCE_MEM;
> +
> +	if (pmcg->overflow_gsiv)
> +		acpi_iort_register_irq(pmcg->overflow_gsiv, "overflow",
> +				       ACPI_EDGE_SENSITIVE, &res[2]);
> +}
> +
> +static struct acpi_iort_node *iort_find_pmcg_ref(struct acpi_iort_node *node)
> +{
> +	struct acpi_iort_pmcg *pmcg;
> +	struct acpi_iort_node *ref_node = NULL;
> +
> +	/* Retrieve PMCG specific data */
> +	pmcg = (struct acpi_iort_pmcg *)node->node_data;
> +	if (pmcg->node_reference)
> +		ref_node = ACPI_ADD_PTR(struct acpi_iort_node,
> +					iort_table,  pmcg->node_reference);
> +	return ref_node;
> +}
> +
>   struct iort_dev_config {
>   	const char *name;
>   	int (*dev_init)(struct acpi_iort_node *node);
> @@ -1296,6 +1356,8 @@ struct iort_dev_config {
>   				     struct acpi_iort_node *node);
>   	void (*dev_set_proximity)(struct device *dev,
>   				    struct acpi_iort_node *node);
> +	void (*dev_dma_configure)(struct device *dev,
> +					enum dev_dma_attr attr);
>   };
>   
>   static const struct iort_dev_config iort_arm_smmu_v3_cfg __initconst = {
> @@ -1304,23 +1366,38 @@ static const struct iort_dev_config iort_arm_smmu_v3_cfg __initconst = {
>   	.dev_count_resources = arm_smmu_v3_count_resources,
>   	.dev_init_resources = arm_smmu_v3_init_resources,
>   	.dev_set_proximity = arm_smmu_v3_set_proximity,
> +	.dev_dma_configure = arm_smmu_common_dma_configure
>   };
>   
>   static const struct iort_dev_config iort_arm_smmu_cfg __initconst = {
>   	.name = "arm-smmu",
>   	.dev_is_coherent = arm_smmu_is_coherent,
>   	.dev_count_resources = arm_smmu_count_resources,
> -	.dev_init_resources = arm_smmu_init_resources
> +	.dev_init_resources = arm_smmu_init_resources,
> +	.dev_dma_configure = arm_smmu_common_dma_configure
> +};
> +
> +static const struct iort_dev_config iort_arm_smmu_v3_pmcg_cfg __initconst = {
> +	.name = "arm-smmu-v3-pmu",
> +	.dev_count_resources = arm_smmu_v3_pmu_count_resources,
> +	.dev_init_resources = arm_smmu_v3_pmu_init_resources
>   };
>   
>   static __init const struct iort_dev_config *iort_get_dev_cfg(
>   			struct acpi_iort_node *node)
>   {
> +	struct acpi_iort_node *ref_node;
> +
>   	switch (node->type) {
>   	case ACPI_IORT_NODE_SMMU_V3:
>   		return &iort_arm_smmu_v3_cfg;
>   	case ACPI_IORT_NODE_SMMU:
>   		return &iort_arm_smmu_cfg;
> +	case ACPI_IORT_NODE_PMCG:
> +		/* Check this is associated with SMMUv3 */
> +		ref_node = iort_find_pmcg_ref(node);

This seems overly restrictive - admittedly the only non-SMMU DTI 
components I know of don't actually implement a PMCG for their internal 
TBU, but I'm sure something will eventually, and there doesn't seem to 
be any good reason for Linux to forcibly ignore it when it does.

> +		if (ref_node && ref_node->type == ACPI_IORT_NODE_SMMU_V3)
> +			return &iort_arm_smmu_v3_pmcg_cfg;
>   	default:
>   		return NULL;
>   	}
> @@ -1376,12 +1453,6 @@ static int __init iort_add_platform_device(struct acpi_iort_node *node,
>   	if (ret)
>   		goto dev_put;
>   
> -	/*
> -	 * We expect the dma masks to be equivalent for
> -	 * all SMMUs set-ups
> -	 */
> -	pdev->dev.dma_mask = &pdev->dev.coherent_dma_mask;
> -
>   	fwnode = iort_get_fwnode(node);
>   
>   	if (!fwnode) {
> @@ -1391,11 +1462,11 @@ static int __init iort_add_platform_device(struct acpi_iort_node *node,
>   
>   	pdev->dev.fwnode = fwnode;
>   
> -	attr = ops->dev_is_coherent && ops->dev_is_coherent(node) ?
> +	if (ops->dev_dma_configure) {
> +		attr = ops->dev_is_coherent && ops->dev_is_coherent(node) ?
>   			DEV_DMA_COHERENT : DEV_DMA_NON_COHERENT;

Oh, right, these guys don't have an ACPI companion or a standard DMA 
attr because they're from a static table, so platform_dma_configure() 
won't pick them up. Oh well. We probably don't want to start dragging 
IORT internals into the platform bus code, so I guess it's not worth 
trying to change that.

Robin.

> -
> -	/* Configure DMA for the page table walker */
> -	acpi_dma_configure(&pdev->dev, attr);
> +		ops->dev_dma_configure(&pdev->dev, attr);
> +	}
>   
>   	iort_set_device_domain(&pdev->dev, node);
>   
> 
