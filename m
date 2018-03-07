Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754184AbeCGMz7 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 07:55:59 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:50220 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751156AbeCGMz6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 07:55:58 -0500
Subject: Re: [PATCH v7 01/14] iommu/rockchip: Prohibit unbind and remove
To: Jeffy Chen <jeffy.chen@rock-chips.com>, linux-kernel@vger.kernel.org
Cc: jcliang@chromium.org, xxm@rock-chips.com, tfiga@chromium.org,
        Heiko Stuebner <heiko@sntech.de>, linux-rockchip@lists.infradead.org,
        iommu@lists.linux-foundation.org, Joerg Roedel <joro@8bytes.org>,
        linux-arm-kernel@lists.infradead.org
References: <20180306030252.3197-1-jeffy.chen@rock-chips.com>
 <20180306030252.3197-2-jeffy.chen@rock-chips.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <713e01c9-4850-dd03-841f-060c1eec1cbd@arm.com>
Date: Wed, 7 Mar 2018 12:55:54 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180306030252.3197-2-jeffy.chen@rock-chips.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/03/18 03:02, Jeffy Chen wrote:
> Removal of IOMMUs cannot be done reliably.
> 
> This is similar to exynos iommu driver.

Acked-by: Robin Murphy <robin.murphy@arm.com>

> Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
> Reviewed-by: Tomasz Figa <tfiga@chromium.org>
> ---
> 
> Changes in v7: None
> Changes in v6: None
> Changes in v5: None
> Changes in v4:
> Rewrite commit message.
> 
> Changes in v3:
> Also remove remove() and module_exit() as Tomasz suggested.
> 
> Changes in v2: None
> 
>   drivers/iommu/rockchip-iommu.c | 21 +--------------------
>   1 file changed, 1 insertion(+), 20 deletions(-)
> 
> diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iommu.c
> index 9d991c2d8767..16cd8780c289 100644
> --- a/drivers/iommu/rockchip-iommu.c
> +++ b/drivers/iommu/rockchip-iommu.c
> @@ -1197,18 +1197,6 @@ static int rk_iommu_probe(struct platform_device *pdev)
>   	return err;
>   }
>   
> -static int rk_iommu_remove(struct platform_device *pdev)
> -{
> -	struct rk_iommu *iommu = platform_get_drvdata(pdev);
> -
> -	if (iommu) {
> -		iommu_device_sysfs_remove(&iommu->iommu);
> -		iommu_device_unregister(&iommu->iommu);
> -	}
> -
> -	return 0;
> -}
> -
>   static const struct of_device_id rk_iommu_dt_ids[] = {
>   	{ .compatible = "rockchip,iommu" },
>   	{ /* sentinel */ }
> @@ -1217,10 +1205,10 @@ MODULE_DEVICE_TABLE(of, rk_iommu_dt_ids);
>   
>   static struct platform_driver rk_iommu_driver = {
>   	.probe = rk_iommu_probe,
> -	.remove = rk_iommu_remove,
>   	.driver = {
>   		   .name = "rk_iommu",
>   		   .of_match_table = rk_iommu_dt_ids,
> +		   .suppress_bind_attrs = true,
>   	},
>   };
>   
> @@ -1248,14 +1236,7 @@ static int __init rk_iommu_init(void)
>   		platform_driver_unregister(&rk_iommu_domain_driver);
>   	return ret;
>   }
> -static void __exit rk_iommu_exit(void)
> -{
> -	platform_driver_unregister(&rk_iommu_driver);
> -	platform_driver_unregister(&rk_iommu_domain_driver);
> -}
> -
>   subsys_initcall(rk_iommu_init);
> -module_exit(rk_iommu_exit);
>   
>   MODULE_DESCRIPTION("IOMMU API for Rockchip");
>   MODULE_AUTHOR("Simon Xue <xxm@rock-chips.com> and Daniel Kurtz <djkurtz@chromium.org>");
> 
