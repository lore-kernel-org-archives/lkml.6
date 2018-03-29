Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751341AbeC2HEB (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 03:04:01 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:42087 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750735AbeC2HEA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 03:04:00 -0400
Subject: Re: [PATCH 2/2] perf: add arm64 smmuv3 pmu driver
To: Neil Leeder <nleeder@codeaurora.org>,
        Will Deacon <will.deacon@arm.com>, Mark Rutland <mark.rutland@arm.com>
References: <1501876754-1064-1-git-send-email-nleeder@codeaurora.org>
 <1501876754-1064-3-git-send-email-nleeder@codeaurora.org>
CC: <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        Mark Langsdorf <mlangsdo@redhat.com>, Mark Salter <msalter@redhat.com>,
        "Jon Masters" <jcm@redhat.com>, Timur Tabi <timur@codeaurora.org>,
        Mark Brown <broonie@kernel.org>
From: Yisheng Xie <xieyisheng1@huawei.com>
Message-ID: <883d32ce-6581-ecf6-5088-ecb238322ebe@huawei.com>
Date: Thu, 29 Mar 2018 15:03:40 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.1.0
MIME-Version: 1.0
In-Reply-To: <1501876754-1064-3-git-send-email-nleeder@codeaurora.org>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.29.40]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Neil,

On 2017/8/5 3:59, Neil Leeder wrote:
> +	mem_resource_0 = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	mem_map_0 = devm_ioremap_resource(&pdev->dev, mem_resource_0);
> +
Can we use devm_ioremap instead? for the reg_base of smmu_pmu is
IMPLEMENTATION DEFINED. If the reg of smmu_pmu is inside smmu,
devm_ioremap_resource will failed and return -EBUSY, eg.:

 smmu reg ranges:		0x180000000 ~ 0x1801fffff
 its smmu_pmu reg ranges:	0x180001000 ~ 0x180001fff

> +	if (IS_ERR(mem_map_0)) {
> +		dev_err(&pdev->dev, "Can't map SMMU PMU @%pa\n",
> +			&mem_resource_0->start);
> +		return PTR_ERR(mem_map_0);
> +	}
> +
> +	smmu_pmu->reg_base = mem_map_0;
> +	smmu_pmu->pmu.name =
> +		devm_kasprintf(&pdev->dev, GFP_KERNEL, "smmu_0_%llx",
> +			       (mem_resource_0->start) >> SMMU_PA_SHIFT);
> +
> +	if (!smmu_pmu->pmu.name) {
> +		dev_err(&pdev->dev, "Failed to create PMU name");
> +		return -EINVAL;
> +	}
> +
> +	ceid_64 = readq(smmu_pmu->reg_base + SMMU_PMCG_CEID0);
> +	ceid[0] = ceid_64 & GENMASK(31, 0);
> +	ceid[1] = ceid_64 >> 32;
> +	ceid_64 = readq(smmu_pmu->reg_base + SMMU_PMCG_CEID1);
> +	ceid[2] = ceid_64 & GENMASK(31, 0);
> +	ceid[3] = ceid_64 >> 32;
> +	bitmap_from_u32array(smmu_pmu->supported_events, SMMU_MAX_EVENT_ID,
> +			     ceid, SMMU_NUM_EVENTS_U32);
> +
> +	/* Determine if page 1 is present */
> +	if (readl(smmu_pmu->reg_base + SMMU_PMCG_CFGR) &
> +	    SMMU_PMCG_CFGR_RELOC_CTRS) {
> +		mem_resource_1 = platform_get_resource(pdev, IORESOURCE_MEM, 1);
> +		mem_map_1 = devm_ioremap_resource(&pdev->dev, mem_resource_1);
> +
The same as above.

Thanks
Yisheng

> +		if (IS_ERR(mem_map_1)) {
> +			dev_err(&pdev->dev, "Can't map SMMU PMU @%pa\n",
> +				&mem_resource_1->start);
> +			return PTR_ERR(mem_map_1);
> +		}
> +		smmu_pmu->reloc_base = mem_map_1;
> +	} else {
> +		smmu_pmu->reloc_base = smmu_pmu->reg_base;
> +	}
> +
> +	irq = platform_get_irq(pdev, 0);
> +	if (irq < 0) {
> +		dev_err(&pdev->dev,
> +			"Failed to get valid irq for smmu @%pa\n",
> +			&mem_resource_0->start);
> +		return irq;
> +	}
