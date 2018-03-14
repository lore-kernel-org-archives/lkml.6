Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751660AbeCNRvC (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 13:51:02 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:57586 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751414AbeCNRur (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 13:50:47 -0400
Subject: Re: [PATCH v9 4/5] iommu/arm-smmu: Add the device_link between
 masters and smmu
To: Vivek Gautam <vivek.gautam@codeaurora.org>, joro@8bytes.org,
        robh+dt@kernel.org, iommu@lists.linux-foundation.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: mark.rutland@arm.com, will.deacon@arm.com, robdclark@gmail.com,
        tfiga@chromium.org, sricharan@codeaurora.org, m.szyprowski@samsung.com,
        architt@codeaurora.org, linux-arm-msm@vger.kernel.org
References: <20180313085534.11650-1-vivek.gautam@codeaurora.org>
 <20180313085534.11650-5-vivek.gautam@codeaurora.org>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <8b427ea2-5c13-4712-13d1-e4c1aed0779e@arm.com>
Date: Wed, 14 Mar 2018 17:50:42 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180313085534.11650-5-vivek.gautam@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/03/18 08:55, Vivek Gautam wrote:
> From: Sricharan R <sricharan@codeaurora.org>
> 
> Finally add the device link between the master device and
> smmu, so that the smmu gets runtime enabled/disabled only when the
> master needs it. This is done from add_device callback which gets
> called once when the master is added to the smmu.
> 
> Signed-off-by: Sricharan R <sricharan@codeaurora.org>
> Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
> Reviewed-by: Tomasz Figa <tfiga@chromium.org>
> ---
>   drivers/iommu/arm-smmu.c | 29 +++++++++++++++++++++++++++++
>   1 file changed, 29 insertions(+)
> 
> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> index 56a04ae80bf3..64953ff2281f 100644
> --- a/drivers/iommu/arm-smmu.c
> +++ b/drivers/iommu/arm-smmu.c
> @@ -1460,10 +1460,31 @@ static int arm_smmu_add_device(struct device *dev)
>   
>   	iommu_device_link(&smmu->iommu, dev);
>   
> +	if (pm_runtime_enabled(smmu->dev)) {
> +		struct device_link *link;
> +
> +		/*
> +		 * Establish the link between smmu and master, so that the
> +		 * smmu gets runtime enabled/disabled as per the master's
> +		 * needs.
> +		 */
> +		link = device_link_add(dev, smmu->dev, DL_FLAG_PM_RUNTIME);
> +		if (!link) {

FWIW, given that we don't really care about link itself, I'd be quite 
happy to simplify that lot down to:

	if (pm_runtime_enabled(smmu_dev) &&
	    !device_link_add(dev, smmu->dev, DL_FLAG_PM_RUNTIME)) {

> +			dev_warn(smmu->dev,
> +				 "Unable to add link to the consumer %s\n",
> +				 dev_name(dev));

(side note: since device_link_add() already prints a message on success, 
maybe it could print its own failure message too?)

Robin.

> +			ret = -ENODEV;
> +			goto out_unlink;
> +		}
> +	}
> +
>   	arm_smmu_rpm_put(smmu);
>   
>   	return 0;
>   
> +out_unlink:
> +	iommu_device_unlink(&smmu->iommu, dev);
> +	arm_smmu_master_free_smes(fwspec);
>   out_rpm_put:
>   	arm_smmu_rpm_put(smmu);
>   out_cfg_free:
> @@ -1486,6 +1507,14 @@ static void arm_smmu_remove_device(struct device *dev)
>   	cfg  = fwspec->iommu_priv;
>   	smmu = cfg->smmu;
>   
> +	if (pm_runtime_enabled(smmu->dev)) {
> +		struct device_link *link;
> +
> +		link = device_link_find(dev, smmu->dev);
> +		if (link)
> +			device_link_del(link);
> +	}
> +
>   	ret = arm_smmu_rpm_get(smmu);
>   	if (ret < 0)
>   		return;
> 
