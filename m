Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754492AbeCGMsP (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 07:48:15 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:50130 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754251AbeCGMrd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 07:47:33 -0500
Subject: Re: [PATCH v8 4/5] iommu/arm-smmu: Add the device_link between
 masters and smmu
To: Vivek Gautam <vivek.gautam@codeaurora.org>, joro@8bytes.org,
        robh+dt@kernel.org, mark.rutland@arm.com, rjw@rjwysocki.net,
        will.deacon@arm.com, robdclark@gmail.com,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: tfiga@chromium.org, jcrouse@codeaurora.org, sboyd@codeaurora.org,
        sricharan@codeaurora.org, m.szyprowski@samsung.com,
        architt@codeaurora.org, linux-arm-msm@vger.kernel.org
References: <20180302101050.6191-1-vivek.gautam@codeaurora.org>
 <20180302101050.6191-5-vivek.gautam@codeaurora.org>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <f3011ef1-7ffe-8c2b-b9d6-3fb094789656@arm.com>
Date: Wed, 7 Mar 2018 12:47:28 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180302101050.6191-5-vivek.gautam@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/03/18 10:10, Vivek Gautam wrote:
> From: Sricharan R <sricharan@codeaurora.org>
> 
> Finally add the device link between the master device and
> smmu, so that the smmu gets runtime enabled/disabled only when the
> master needs it. This is done from add_device callback which gets
> called once when the master is added to the smmu.
> 
> Signed-off-by: Sricharan R <sricharan@codeaurora.org>
> Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
> ---
>   drivers/iommu/arm-smmu.c | 21 +++++++++++++++++++++
>   1 file changed, 21 insertions(+)
> 
> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> index 3d6a1875431f..bb1ea82c1003 100644
> --- a/drivers/iommu/arm-smmu.c
> +++ b/drivers/iommu/arm-smmu.c
> @@ -217,6 +217,9 @@ struct arm_smmu_device {
>   
>   	/* IOMMU core code handle */
>   	struct iommu_device		iommu;
> +
> +	/* runtime PM link to master */
> +	struct device_link *link;

Just the one?

>   };
>   
>   enum arm_smmu_context_fmt {
> @@ -1470,10 +1473,26 @@ static int arm_smmu_add_device(struct device *dev)
>   
>   	iommu_device_link(&smmu->iommu, dev);
>   
> +	/*
> +	 * Establish the link between smmu and master, so that the
> +	 * smmu gets runtime enabled/disabled as per the master's
> +	 * needs.
> +	 */
> +	smmu->link = device_link_add(dev, smmu->dev, DL_FLAG_PM_RUNTIME);

Maybe I've misunderstood how the API works, but AFAICS the second and 
subsequent devices are all just going to overwrite (and leak) the link 
of the previous one...

> +	if (!smmu->link) {
> +		dev_warn(smmu->dev, "Unable to create device link between %s and %s\n",
> +			 dev_name(smmu->dev), dev_name(dev));
> +		ret = -ENODEV;
> +		goto out_unlink;
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
> @@ -1496,6 +1515,8 @@ static void arm_smmu_remove_device(struct device *dev)
>   	cfg  = fwspec->iommu_priv;
>   	smmu = cfg->smmu;
>   
> +	device_link_del(smmu->link);

...and equivalently you end up with a double-free (or more) here of a 
link which may not have belonged to dev anyway.

Robin.

> +
>   	ret = arm_smmu_rpm_get(smmu);
>   	if (ret < 0)
>   		return;
> 
