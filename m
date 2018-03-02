Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936345AbeCBQOt (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 11:14:49 -0500
Received: from foss.arm.com ([217.140.101.70]:57476 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932319AbeCBQOr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 11:14:47 -0500
Subject: Re: [PATCH 2/3] rpmsg: core: make rpmsg bus DMA capable
To: srinivas.kandagatla@linaro.org, will.deacon@arm.com,
        bjorn.andersson@linaro.org
Cc: joro@8bytes.org, ohad@wizery.com, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-remoteproc@vger.kernel.org
References: <20180302145531.20463-1-srinivas.kandagatla@linaro.org>
 <20180302145531.20463-3-srinivas.kandagatla@linaro.org>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <07503032-b08b-10ea-9d34-ddf85c682a9d@arm.com>
Date: Fri, 2 Mar 2018 16:14:44 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180302145531.20463-3-srinivas.kandagatla@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/03/18 14:55, srinivas.kandagatla@linaro.org wrote:
> From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> 
> Many of the rpmsg clients like audio drivers need to allocate
> dma memory. Make this bus DMA capable so that the child devices
> can use dma apis.

AFAICS after 15 minutes in the docs and code, the rpmsg "bus" is a 
virtual one based around shared-memory mailbox communication, so I don't 
really see how DMA exists in that context - I think maybe that 
abstraction needs looking at.

However, from grepping through the DTs it seems at first glance like the 
non-trivial things under the "qcom,smd" bus mostly map to actual 
platform devices via the "qcom,smd-edge" property - if those platform 
devices are the physical DMA masters, they should be the ones used for 
DMA API operations.

> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>   drivers/rpmsg/rpmsg_core.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/rpmsg/rpmsg_core.c b/drivers/rpmsg/rpmsg_core.c
> index e84c71f8d6ab..540a3f3567b8 100644
> --- a/drivers/rpmsg/rpmsg_core.c
> +++ b/drivers/rpmsg/rpmsg_core.c
> @@ -472,6 +472,7 @@ struct bus_type rpmsg_bus = {
>   	.uevent		= rpmsg_uevent,
>   	.probe		= rpmsg_dev_probe,
>   	.remove		= rpmsg_dev_remove,
> +	.force_dma	= true,

Regardless of the above, would you really need to use this brute force 
hack instead of just fixing the DTs? I'm struggling to find which 
drivers might currently be relying on this :/

Robin.

>   };
>   EXPORT_SYMBOL(rpmsg_bus);
>   
> 
