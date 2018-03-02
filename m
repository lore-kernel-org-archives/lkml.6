Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1426918AbeCBQ7R (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 11:59:17 -0500
Received: from foss.arm.com ([217.140.101.70]:58602 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1424699AbeCBQ7Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 11:59:16 -0500
Subject: Re: [PATCH 3/3] iommu: armsmmu: set iommu ops for rpmsg bus
To: srinivas.kandagatla@linaro.org, will.deacon@arm.com,
        bjorn.andersson@linaro.org
Cc: joro@8bytes.org, ohad@wizery.com, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-remoteproc@vger.kernel.org
References: <20180302145531.20463-1-srinivas.kandagatla@linaro.org>
 <20180302145531.20463-4-srinivas.kandagatla@linaro.org>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <57fc5480-c57e-dfd3-e6af-5e5bba296430@arm.com>
Date: Fri, 2 Mar 2018 16:59:12 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180302145531.20463-4-srinivas.kandagatla@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/03/18 14:55, srinivas.kandagatla@linaro.org wrote:
> From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> 
> On Qualcomm SoCs, ADSP exposes many functions like audio and
> others. These services need iommu access to allocate any
> memory for the DSP. As these drivers are childeren of
> rpmsg bus, able to allocate memory from iommus is basic
> requirement. So set arm smmu iommu ops for this bus type.

Documentation/rpmsg.txt: "Every rpmsg device is a communication channel 
with a remote processor (thus rpmsg devices are called channels)."

I'd instinctively assume that a remote processor already has its own 
memory, and that a communication channel doesn't somehow go directly 
through an IOMMU, so that "basic requirement" seems like a pretty big 
assumption.

> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>   drivers/iommu/arm-smmu.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> index e6920d32ac9e..9b63489af15c 100644
> --- a/drivers/iommu/arm-smmu.c
> +++ b/drivers/iommu/arm-smmu.c
> @@ -53,6 +53,7 @@
>   #include <linux/spinlock.h>
>   
>   #include <linux/amba/bus.h>
> +#include <linux/rpmsg.h>
>   
>   #include "io-pgtable.h"
>   #include "arm-smmu-regs.h"
> @@ -2168,6 +2169,10 @@ static void arm_smmu_bus_init(void)
>   		bus_set_iommu(&pci_bus_type, &arm_smmu_ops);
>   	}
>   #endif
> +#ifdef CONFIG_RPMSG

Ah, so this will at least build OK with RPMSG=m, but I doubt it does 
what you want it to in that case.

Robin.

> +	if (!iommu_present(&rpmsg_bus))
> +		bus_set_iommu(&rpmsg_bus, &arm_smmu_ops);
> +#endif
>   }
>   
>   static int arm_smmu_device_probe(struct platform_device *pdev)
> 
