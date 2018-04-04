Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751842AbeDDLMk (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 07:12:40 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:43274 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751759AbeDDLMh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 07:12:37 -0400
Subject: Re: [PATCH] iommu: rockchip: fix building without CONFIG_OF
To: Arnd Bergmann <arnd@arndb.de>, Joerg Roedel <joro@8bytes.org>,
        Heiko Stuebner <heiko@sntech.de>
Cc: Jeffy Chen <jeffy.chen@rock-chips.com>,
        Tomasz Figa <tfiga@chromium.org>, Simon Xue <xxm@rock-chips.com>,
        Marc Zyngier <marc.zyngier@arm.com>, iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20180404102401.3634085-1-arnd@arndb.de>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <94d8f18d-28a3-1602-ea92-a821a2b9183c@arm.com>
Date: Wed, 4 Apr 2018 12:12:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180404102401.3634085-1-arnd@arndb.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

On 04/04/18 11:23, Arnd Bergmann wrote:
> We get a build error when compiling the iommu driver without CONFIG_OF:
> 
> drivers/iommu/rockchip-iommu.c: In function 'rk_iommu_of_xlate':
> drivers/iommu/rockchip-iommu.c:1101:2: error: implicit declaration of function 'of_dev_put'; did you mean 'of_node_put'? [-Werror=implicit-function-declaration]
> 
> This replaces the of_dev_put() with the equivalent platform_device_put(),
> and adds an error check for of_find_device_by_node() returning NULL,
> which seems to be appropriate here given that we pass the device into
> platform_get_drvdata() next, and that of_find_device_by_node() might
> theoretically return a NULL pointer.
> 
> Fixes: 5fd577c3eac3 ("iommu/rockchip: Use OF_IOMMU to attach devices automatically")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> This warning appears to only have been introduced in linux-next after
> the merge window opened.
> ---
>   drivers/iommu/rockchip-iommu.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iommu.c
> index 5fc8656c60f9..fe9c9cc1a9d4 100644
> --- a/drivers/iommu/rockchip-iommu.c
> +++ b/drivers/iommu/rockchip-iommu.c
> @@ -1094,11 +1094,15 @@ static int rk_iommu_of_xlate(struct device *dev,
>   		return -ENOMEM;
>   
>   	iommu_dev = of_find_device_by_node(args->np);
> +	if (!iommu_dev) {

Actually, though the logic is perhaps a bit subtle, this cannot 
reasonably happen - .of_xlate is only called via a set of iommu_ops 
associated with the IOMMU node (args->np here); those ops are only 
registered for the given node at the end of rk_iommu_probe(), by which 
point the IOMMU device exists and is otherwise successfully probed, so 
the platform bus lookup should never be able to fail.

> +		kfree(data);
> +		return -ENODEV;
> +	}
>   
>   	data->iommu = platform_get_drvdata(iommu_dev);
>   	dev->archdata.iommu = data;
>   
> -	of_dev_put(iommu_dev);
> +	platform_device_put(iommu_dev);

This bit looks reasonable, thanks for the fix.

Robin.

>   
>   	return 0;
>   }
> 
