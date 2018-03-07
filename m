Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754456AbeCGNAA (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 08:00:00 -0500
Received: from foss.arm.com ([217.140.101.70]:50310 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751257AbeCGM77 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 07:59:59 -0500
Subject: Re: [PATCH v7 02/14] iommu/rockchip: Fix error handling in probe
To: Jeffy Chen <jeffy.chen@rock-chips.com>, linux-kernel@vger.kernel.org
Cc: jcliang@chromium.org, xxm@rock-chips.com, tfiga@chromium.org,
        Heiko Stuebner <heiko@sntech.de>, linux-rockchip@lists.infradead.org,
        iommu@lists.linux-foundation.org, Joerg Roedel <joro@8bytes.org>,
        linux-arm-kernel@lists.infradead.org
References: <20180306030252.3197-1-jeffy.chen@rock-chips.com>
 <20180306030252.3197-3-jeffy.chen@rock-chips.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <ac9eb221-8483-45e5-6f87-6dcc5decfb45@arm.com>
Date: Wed, 7 Mar 2018 12:59:55 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180306030252.3197-3-jeffy.chen@rock-chips.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/03/18 03:02, Jeffy Chen wrote:
> Add missing iommu_device_sysfs_remove in error path.

Acked-by: Robin Murphy <robin.murphy@arm.com>

(strictly you don't need to introduce the additional return, but it's 
only a couple of lines and definitely not worth respinning just for that)

> Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
> Reviewed-by: Tomasz Figa <tfiga@chromium.org>
> ---
> 
> Changes in v7: None
> Changes in v6: None
> Changes in v5: None
> Changes in v4: None
> Changes in v3: None
> Changes in v2: None
> 
>   drivers/iommu/rockchip-iommu.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iommu.c
> index 16cd8780c289..c2ef3cbd4401 100644
> --- a/drivers/iommu/rockchip-iommu.c
> +++ b/drivers/iommu/rockchip-iommu.c
> @@ -1193,8 +1193,12 @@ static int rk_iommu_probe(struct platform_device *pdev)
>   
>   	iommu_device_set_ops(&iommu->iommu, &rk_iommu_ops);
>   	err = iommu_device_register(&iommu->iommu);
> +	if (err) {
> +		iommu_device_sysfs_remove(&iommu->iommu);
> +		return err;
> +	}
>   
> -	return err;
> +	return 0;
>   }
>   
>   static const struct of_device_id rk_iommu_dt_ids[] = {
> 
