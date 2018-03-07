Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754395AbeCGMUx (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 07:20:53 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:49608 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754345AbeCGMUu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 07:20:50 -0500
Subject: Re: [PATCH v8 1/5] iommu/arm-smmu: Destroy domain context in failure
 path
To: Vivek Gautam <vivek.gautam@codeaurora.org>, joro@8bytes.org,
        robh+dt@kernel.org, mark.rutland@arm.com, rjw@rjwysocki.net,
        will.deacon@arm.com, robdclark@gmail.com,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: tfiga@chromium.org, jcrouse@codeaurora.org, sboyd@codeaurora.org,
        sricharan@codeaurora.org, m.szyprowski@samsung.com,
        architt@codeaurora.org, linux-arm-msm@vger.kernel.org
References: <20180302101050.6191-1-vivek.gautam@codeaurora.org>
 <20180302101050.6191-2-vivek.gautam@codeaurora.org>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <d3500b33-8ce6-d767-7e9b-2fd75fea6cbb@arm.com>
Date: Wed, 7 Mar 2018 12:20:45 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180302101050.6191-2-vivek.gautam@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/03/18 10:10, Vivek Gautam wrote:
> If we fail after initializing domain_context, we should destroy
> the context to free up resources.

Have another think about why the "problem" this patch caters for cannot 
ever happen (hint: consider how domain->smmu is used in 
arm_smmu_init_domain_context()). And then also about the really 
catastrophically bad problem it actually introduces (hint: 
"iommu_attach(domain, good_dev); iommu_attach(domain, bad_dev);")

Robin.

> Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
> ---
> 
>   * New patch added in this series.
> 
>   drivers/iommu/arm-smmu.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> index 69e7c60792a8..ffc152c36002 100644
> --- a/drivers/iommu/arm-smmu.c
> +++ b/drivers/iommu/arm-smmu.c
> @@ -1223,11 +1223,16 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
>   		dev_err(dev,
>   			"cannot attach to SMMU %s whilst already attached to domain on SMMU %s\n",
>   			dev_name(smmu_domain->smmu->dev), dev_name(smmu->dev));
> -		return -EINVAL;
> +		ret = -EINVAL;
> +		goto destroy_domain;
>   	}
>   
>   	/* Looks ok, so add the device to the domain */
>   	return arm_smmu_domain_add_master(smmu_domain, fwspec);
> +
> +destroy_domain:
> +	arm_smmu_destroy_domain_context(domain);
> +	return ret;
>   }
>   
>   static int arm_smmu_map(struct iommu_domain *domain, unsigned long iova,
> 
