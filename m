Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751428AbeDDLFG (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 07:05:06 -0400
Received: from regular1.263xmail.com ([211.150.99.131]:41780 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751053AbeDDLFF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 07:05:05 -0400
X-263anti-spam: KSV:0;
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-KSVirus-check: 0
X-ABS-CHECKED: 4
X-RL-SENDER: jeffy.chen@rock-chips.com
X-FST-TO: arnd@arndb.de
X-SENDER-IP: 103.29.142.67
X-LOGIN-NAME: jeffy.chen@rock-chips.com
X-UNIQUE-TAG: <abb0640eaf49292a91091aeb46f58830>
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
Message-ID: <5AC4B151.7060307@rock-chips.com>
Date: Wed, 04 Apr 2018 19:04:49 +0800
From: JeffyChen <jeffy.chen@rock-chips.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:19.0) Gecko/20130126 Thunderbird/19.0
MIME-Version: 1.0
To: Arnd Bergmann <arnd@arndb.de>, Joerg Roedel <joro@8bytes.org>,
        Heiko Stuebner <heiko@sntech.de>
CC: Robin Murphy <robin.murphy@arm.com>, Tomasz Figa <tfiga@chromium.org>,
        Simon Xue <xxm@rock-chips.com>, Marc Zyngier <marc.zyngier@arm.com>,
        iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu: rockchip: fix building without CONFIG_OF
References: <20180404102401.3634085-1-arnd@arndb.de>
In-Reply-To: <20180404102401.3634085-1-arnd@arndb.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Amd,

Thanks for your patch.

On 04/04/2018 06:23 PM, Arnd Bergmann wrote:
> We get a build error when compiling the iommu driver without CONFIG_OF:
>
> drivers/iommu/rockchip-iommu.c: In function 'rk_iommu_of_xlate':
> drivers/iommu/rockchip-iommu.c:1101:2: error: implicit declaration of function 'of_dev_put'; did you mean 'of_node_put'? [-Werror=implicit-function-declaration]
>
oops, didn't notice that.

and checking other iommu drivers which call of_find_device_by_node() 
too, seems they didn't put() it? maybe we should fix them too

> This replaces the of_dev_put() with the equivalent platform_device_put(),
> and adds an error check for of_find_device_by_node() returning NULL,
> which seems to be appropriate here given that we pass the device into
> platform_get_drvdata() next, and that of_find_device_by_node() might
> theoretically return a NULL pointer.
hmm, i thought the of_iommu_xlate() checked that before calling us:


static int of_iommu_xlate(struct device *dev,
               struct of_phandle_args *iommu_spec)
{
...
     if ((ops && !ops->of_xlate) ||
         !of_device_is_available(iommu_spec->np) ||
         (!ops && !of_iommu_driver_present(iommu_spec->np)))
         return NO_IOMMU;
...
     return ops->of_xlate(dev, iommu_spec);


but it's better to check it ourself :)


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
> +		kfree(data);
> +		return -ENODEV;
> +	}
>
>   	data->iommu = platform_get_drvdata(iommu_dev);
>   	dev->archdata.iommu = data;
>
> -	of_dev_put(iommu_dev);
> +	platform_device_put(iommu_dev);
>
>   	return 0;
>   }
>
