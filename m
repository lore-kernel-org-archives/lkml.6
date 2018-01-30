Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751632AbeA3Kjc convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 05:39:32 -0500
Received: from lhrrgout.huawei.com ([194.213.3.17]:23795 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751262AbeA3Kjb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 05:39:31 -0500
From: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
To: Neil Leeder <nleeder@codeaurora.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>
CC: Mark Langsdorf <mlangsdo@redhat.com>, Jon Masters <jcm@redhat.com>,
        Timur Tabi <timur@codeaurora.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>, Mark Salter <msalter@redhat.com>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        Will Deacon <will.deacon@arm.com>, Mark Rutland <mark.rutland@arm.com>,
        Linuxarm <linuxarm@huawei.com>
Subject: RE: [PATCH 1/2] acpi: arm64: add iort support for PMCG
Thread-Topic: [PATCH 1/2] acpi: arm64: add iort support for PMCG
Thread-Index: AQHTDV2/CQ/dFwJGo0+KDC6Dtk3j06ONSjEg
Date: Tue, 30 Jan 2018 10:39:20 +0000
Message-ID: <5FC3163CFD30C246ABAA99954A238FA8386400F7@FRAEML521-MBX.china.huawei.com>
References: <1501876754-1064-1-git-send-email-nleeder@codeaurora.org>
 <1501876754-1064-2-git-send-email-nleeder@codeaurora.org>
In-Reply-To: <1501876754-1064-2-git-send-email-nleeder@codeaurora.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.202.227.237]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Neil/Lorenzo,

> -----Original Message-----
> From: linux-arm-kernel [mailto:linux-arm-kernel-bounces@lists.infradead.org]
> On Behalf Of Neil Leeder
> Sent: Friday, August 04, 2017 8:59 PM
> To: Will Deacon <will.deacon@arm.com>; Mark Rutland
> <mark.rutland@arm.com>
> Cc: Mark Langsdorf <mlangsdo@redhat.com>; Jon Masters
> <jcm@redhat.com>; Timur Tabi <timur@codeaurora.org>; linux-
> kernel@vger.kernel.org; Mark Brown <broonie@kernel.org>; Mark Salter
> <msalter@redhat.com>; nleeder@codeaurora.org; linux-arm-
> kernel@lists.infradead.org
> Subject: [PATCH 1/2] acpi: arm64: add iort support for PMCG
> 
> Add support for the SMMU Performance Monitor Counter Group
> information from ACPI. This is in preparation for its use
> in the SMMU v3 PMU driver.

[...]

>  static __init
>  const struct iort_iommu_config *iort_get_iommu_cfg(struct acpi_iort_node
> *node)
>  {
> @@ -1001,6 +1041,8 @@ const struct iort_iommu_config
> *iort_get_iommu_cfg(struct acpi_iort_node *node)
>  		return &iort_arm_smmu_v3_cfg;
>  	case ACPI_IORT_NODE_SMMU:
>  		return &iort_arm_smmu_cfg;
> +	case ACPI_IORT_NODE_PMCG:
> +		return &iort_arm_smmu_pmcg_cfg;

I understand this series will be revised based on the iort spec update.

This Is to clarify few queries we have with respect to one of our hisilicon 
platform which has support for SMMU v3 PMCG. In our implementation
the base address for the PMCG is defined at a IMP DEF address offset
within the SMMUv3 page 0 address space. And as per SMMU spec, 

" The Performance Monitor Counter Groups are standalone monitoring 
facilities  and, as such, can be implemented in separate components that
are all associated with (but not necessarily part of) an SMMU"

It looks like PMCG can be part of SMMU,  it is not clear whether this kind
of address mapping is forbidden or not. If this is an accepted  scenario, then
the devm_ioremap_resource() call in SMMv3 probe will fail as it reports conflict.

As far as I can see, the above code just checks the iort node type is PMCG
and assumes that its SMMU PMCG. As per IORT spec, it make sense to check
the node reference filed and make that call. 

And to fix the resource conflict issue we have, is it possible to treat the PMCG
node as the child of the SMMU and call the platform_device_add() appropriately
to avoid the conflict? I am not sure this will fix the issue and also about the order
in which SMMU and PMCG devices will be populated will have an impact on this.

Please let me know your thoughts on this.

Thanks,
Shameer
  
>  	default:
>  		return NULL;
>  	}
> @@ -1056,6 +1098,15 @@ static int __init
> iort_add_smmu_platform_device(struct acpi_iort_node *node)
>  	if (ret)
>  		goto dev_put;
> 
> +	/* End of init for PMCG */
> +	if (node->type == ACPI_IORT_NODE_PMCG) {
> +		ret = platform_device_add(pdev);
> +		if (ret)
> +			goto dev_put;
> +
> +		return 0;
> +	}
> +
>  	/*
>  	 * We expect the dma masks to be equivalent for
>  	 * all SMMUs set-ups
> @@ -1131,6 +1182,9 @@ static void __init iort_init_platform_devices(void)
>  				acpi_free_fwnode_static(fwnode);
>  				return;
>  			}
> +		} else if (iort_node->type == ACPI_IORT_NODE_PMCG) {
> +			if (iort_add_smmu_platform_device(iort_node))
> +				return;
>  		}
> 
>  		iort_node = ACPI_ADD_PTR(struct acpi_iort_node, iort_node,
> diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h
> index 707dda74..2169b6f 100644
> --- a/include/acpi/actbl2.h
> +++ b/include/acpi/actbl2.h
> @@ -695,7 +695,8 @@ enum acpi_iort_node_type {
>  	ACPI_IORT_NODE_NAMED_COMPONENT = 0x01,
>  	ACPI_IORT_NODE_PCI_ROOT_COMPLEX = 0x02,
>  	ACPI_IORT_NODE_SMMU = 0x03,
> -	ACPI_IORT_NODE_SMMU_V3 = 0x04
> +	ACPI_IORT_NODE_SMMU_V3 = 0x04,
> +	ACPI_IORT_NODE_PMCG = 0x05
>  };
> 
>  struct acpi_iort_id_mapping {
> @@ -811,6 +812,12 @@ struct acpi_iort_smmu_v3 {
>  #define ACPI_IORT_SMMU_V3_COHACC_OVERRIDE   (1)
>  #define ACPI_IORT_SMMU_V3_HTTU_OVERRIDE     (1<<1)
> 
> +struct acpi_iort_pmcg {
> +	u64 base_address;	/* PMCG base address */
> +	u32 overflow_gsiv;
> +	u32 node_reference;
> +};
> +
> 
> /****************************************************************
> ***************
>   *
>   * IVRS - I/O Virtualization Reporting Structure
> --
> Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm
> Technologies Inc.
> Qualcomm Technologies, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project.
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
