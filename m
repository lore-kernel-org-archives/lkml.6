Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754438AbeCGNAc (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 08:00:32 -0500
Received: from foss.arm.com ([217.140.101.70]:50328 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933251AbeCGNA1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 08:00:27 -0500
Subject: Re: [PATCH v7 03/14] iommu/rockchip: Request irqs in rk_iommu_probe()
To: Jeffy Chen <jeffy.chen@rock-chips.com>, linux-kernel@vger.kernel.org
Cc: jcliang@chromium.org, xxm@rock-chips.com, tfiga@chromium.org,
        Heiko Stuebner <heiko@sntech.de>, linux-rockchip@lists.infradead.org,
        iommu@lists.linux-foundation.org, Joerg Roedel <joro@8bytes.org>,
        linux-arm-kernel@lists.infradead.org
References: <20180306030252.3197-1-jeffy.chen@rock-chips.com>
 <20180306030252.3197-4-jeffy.chen@rock-chips.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <3c3aa82e-2a06-4ced-fb7e-8e219b25b812@arm.com>
Date: Wed, 7 Mar 2018 13:00:24 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180306030252.3197-4-jeffy.chen@rock-chips.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/03/18 03:02, Jeffy Chen wrote:
> Move request_irq to the end of rk_iommu_probe().

Acked-by: Robin Murphy <robin.murphy@arm.com>

> Suggested-by: Robin Murphy <robin.murphy@arm.com>
> Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
> Reviewed-by: Tomasz Figa <tfiga@chromium.org>
> ---
> 
> Changes in v7: None
> Changes in v6: None
> Changes in v5: None
> Changes in v4: None
> Changes in v3:
> Loop platform_get_irq() as Robin suggested.
> 
> Changes in v2: None
> 
>   drivers/iommu/rockchip-iommu.c | 38 +++++++++-----------------------------
>   1 file changed, 9 insertions(+), 29 deletions(-)
> 
> diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iommu.c
> index c2ef3cbd4401..b743d82e6fe1 100644
> --- a/drivers/iommu/rockchip-iommu.c
> +++ b/drivers/iommu/rockchip-iommu.c
> @@ -90,8 +90,6 @@ struct rk_iommu {
>   	struct device *dev;
>   	void __iomem **bases;
>   	int num_mmu;
> -	int *irq;
> -	int num_irq;
>   	bool reset_disabled;
>   	struct iommu_device iommu;
>   	struct list_head node; /* entry in rk_iommu_domain.iommus */
> @@ -830,13 +828,6 @@ static int rk_iommu_attach_device(struct iommu_domain *domain,
>   
>   	iommu->domain = domain;
>   
> -	for (i = 0; i < iommu->num_irq; i++) {
> -		ret = devm_request_irq(iommu->dev, iommu->irq[i], rk_iommu_irq,
> -				       IRQF_SHARED, dev_name(dev), iommu);
> -		if (ret)
> -			return ret;
> -	}
> -
>   	for (i = 0; i < iommu->num_mmu; i++) {
>   		rk_iommu_write(iommu->bases[i], RK_MMU_DTE_ADDR,
>   			       rk_domain->dt_dma);
> @@ -885,9 +876,6 @@ static void rk_iommu_detach_device(struct iommu_domain *domain,
>   	}
>   	rk_iommu_disable_stall(iommu);
>   
> -	for (i = 0; i < iommu->num_irq; i++)
> -		devm_free_irq(iommu->dev, iommu->irq[i], iommu);
> -
>   	iommu->domain = NULL;
>   
>   	dev_dbg(dev, "Detached from iommu domain\n");
> @@ -1138,7 +1126,7 @@ static int rk_iommu_probe(struct platform_device *pdev)
>   	struct rk_iommu *iommu;
>   	struct resource *res;
>   	int num_res = pdev->num_resources;
> -	int err, i;
> +	int err, i, irq;
>   
>   	iommu = devm_kzalloc(dev, sizeof(*iommu), GFP_KERNEL);
>   	if (!iommu)
> @@ -1165,23 +1153,15 @@ static int rk_iommu_probe(struct platform_device *pdev)
>   	if (iommu->num_mmu == 0)
>   		return PTR_ERR(iommu->bases[0]);
>   
> -	iommu->num_irq = platform_irq_count(pdev);
> -	if (iommu->num_irq < 0)
> -		return iommu->num_irq;
> -	if (iommu->num_irq == 0)
> -		return -ENXIO;
> +	i = 0;
> +	while ((irq = platform_get_irq(pdev, i++)) != -ENXIO) {
> +		if (irq < 0)
> +			return irq;
>   
> -	iommu->irq = devm_kcalloc(dev, iommu->num_irq, sizeof(*iommu->irq),
> -				  GFP_KERNEL);
> -	if (!iommu->irq)
> -		return -ENOMEM;
> -
> -	for (i = 0; i < iommu->num_irq; i++) {
> -		iommu->irq[i] = platform_get_irq(pdev, i);
> -		if (iommu->irq[i] < 0) {
> -			dev_err(dev, "Failed to get IRQ, %d\n", iommu->irq[i]);
> -			return -ENXIO;
> -		}
> +		err = devm_request_irq(iommu->dev, irq, rk_iommu_irq,
> +				       IRQF_SHARED, dev_name(dev), iommu);
> +		if (err)
> +			return err;
>   	}
>   
>   	iommu->reset_disabled = device_property_read_bool(dev,
> 
