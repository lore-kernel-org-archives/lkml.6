Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755925AbeDWQHr (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 12:07:47 -0400
Received: from foss.arm.com ([217.140.101.70]:42752 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755383AbeDWQHq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 12:07:46 -0400
Subject: Re: [RFC 1/2] iommu/arm-smmu-v3: Remove bypass in
 arm_smmu_reset_device
To: Yisheng Xie <xieyisheng1@huawei.com>, will.deacon@arm.com,
        joro@8bytes.org
Cc: linux-arm-kernel@lists.infradead.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, liubo95@huawei.com,
        dingtianhong@huawei.com
References: <1524483959-54940-1-git-send-email-xieyisheng1@huawei.com>
 <1524483959-54940-2-git-send-email-xieyisheng1@huawei.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <9e2f8646-482a-e721-d1b6-e674de48e276@arm.com>
Date: Mon, 23 Apr 2018 17:07:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1524483959-54940-2-git-send-email-xieyisheng1@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/04/18 12:45, Yisheng Xie wrote:
> Add a bypass parameter in arm_smmu_device to keep whether smmu device
> should pypass or not, so parameter bypass in arm_smmu_reset_device can
> be removed.

Given that the GBPA configuration implied by the bypass argument here is 
only there to avoid initialising a full stream table when the firmware 
is terminally broken, I wonder if it would make sense to simply skip 
allocating a stream table at all in that case. Then we could just base 
the subsequent SMMUEN/GPBA decision on whether strtab_cfg.strtab is 
valid or not.

Robin.

> This should not have any functional change, but prepare for later patch.
> 
> Signed-off-by: Yisheng Xie <xieyisheng1@huawei.com>
> ---
>   drivers/iommu/arm-smmu-v3.c | 11 ++++++-----
>   1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
> index 1d64710..044df6e 100644
> --- a/drivers/iommu/arm-smmu-v3.c
> +++ b/drivers/iommu/arm-smmu-v3.c
> @@ -587,6 +587,8 @@ struct arm_smmu_device {
>   
>   	u32				sync_count;
>   
> +	bool				bypass;
> +
>   	/* IOMMU core code handle */
>   	struct iommu_device		iommu;
>   };
> @@ -2384,7 +2386,7 @@ static int arm_smmu_device_disable(struct arm_smmu_device *smmu)
>   	return ret;
>   }
>   
> -static int arm_smmu_device_reset(struct arm_smmu_device *smmu, bool bypass)
> +static int arm_smmu_device_reset(struct arm_smmu_device *smmu)
>   {
>   	int ret;
>   	u32 reg, enables;
> @@ -2487,7 +2489,7 @@ static int arm_smmu_device_reset(struct arm_smmu_device *smmu, bool bypass)
>   
>   
>   	/* Enable the SMMU interface, or ensure bypass */
> -	if (!bypass || disable_bypass) {
> +	if (!smmu->bypass || disable_bypass) {
>   		enables |= CR0_SMMUEN;
>   	} else {
>   		ret = arm_smmu_update_gbpa(smmu, 0, GBPA_ABORT);
> @@ -2778,7 +2780,6 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
>   	resource_size_t ioaddr;
>   	struct arm_smmu_device *smmu;
>   	struct device *dev = &pdev->dev;
> -	bool bypass;
>   
>   	smmu = devm_kzalloc(dev, sizeof(*smmu), GFP_KERNEL);
>   	if (!smmu) {
> @@ -2796,7 +2797,7 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
>   	}
>   
>   	/* Set bypass mode according to firmware probing result */
> -	bypass = !!ret;
> +	smmu->bypass = !!ret;
>   
>   	/* Base address */
>   	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> @@ -2842,7 +2843,7 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
>   	platform_set_drvdata(pdev, smmu);
>   
>   	/* Reset the device */
> -	ret = arm_smmu_device_reset(smmu, bypass);
> +	ret = arm_smmu_device_reset(smmu);
>   	if (ret)
>   		return ret;
>   
> 
