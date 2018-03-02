Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1429121AbeCBPZl (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 10:25:41 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:56572 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1427661AbeCBPZb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 10:25:31 -0500
Subject: Re: [PATCH 1/3] rpmsg: core: export rpmsg bus type
To: srinivas.kandagatla@linaro.org, will.deacon@arm.com,
        bjorn.andersson@linaro.org
Cc: joro@8bytes.org, ohad@wizery.com, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-remoteproc@vger.kernel.org
References: <20180302145531.20463-1-srinivas.kandagatla@linaro.org>
 <20180302145531.20463-2-srinivas.kandagatla@linaro.org>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <96ca6e59-071d-4eca-704f-8bb646f072dd@arm.com>
Date: Fri, 2 Mar 2018 15:25:27 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180302145531.20463-2-srinivas.kandagatla@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/03/18 14:55, srinivas.kandagatla@linaro.org wrote:
> From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> 
> Export rpmsg bus type so that iommu drivers iommu ops to
> rpmsg bus type.
> 
> On Qualcomm SoCs ADSP exposes functions like audio and
> other which need iommu access, as these drivers are part
> of rpmsg bus, able to allocate memory from iommus is basic
> requirement. So expose this bus so that iommu drivers can
> add ops to this.

IOMMU drivers are built-in while rpmsg can be built as a module, so that 
isn't always going to work.

Robin.

> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>   drivers/rpmsg/rpmsg_core.c | 3 ++-
>   include/linux/rpmsg.h      | 2 +-
>   2 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/rpmsg/rpmsg_core.c b/drivers/rpmsg/rpmsg_core.c
> index 5a081762afcc..e84c71f8d6ab 100644
> --- a/drivers/rpmsg/rpmsg_core.c
> +++ b/drivers/rpmsg/rpmsg_core.c
> @@ -465,7 +465,7 @@ static int rpmsg_dev_remove(struct device *dev)
>   	return err;
>   }
>   
> -static struct bus_type rpmsg_bus = {
> +struct bus_type rpmsg_bus = {
>   	.name		= "rpmsg",
>   	.match		= rpmsg_dev_match,
>   	.dev_groups	= rpmsg_dev_groups,
> @@ -473,6 +473,7 @@ static struct bus_type rpmsg_bus = {
>   	.probe		= rpmsg_dev_probe,
>   	.remove		= rpmsg_dev_remove,
>   };
> +EXPORT_SYMBOL(rpmsg_bus);
>   
>   int rpmsg_register_device(struct rpmsg_device *rpdev)
>   {
> diff --git a/include/linux/rpmsg.h b/include/linux/rpmsg.h
> index ca07366c4c33..869e5946b7df 100644
> --- a/include/linux/rpmsg.h
> +++ b/include/linux/rpmsg.h
> @@ -49,7 +49,7 @@ struct rpmsg_device;
>   struct rpmsg_endpoint;
>   struct rpmsg_device_ops;
>   struct rpmsg_endpoint_ops;
> -
> +extern struct bus_type rpmsg_bus;
>   /**
>    * struct rpmsg_channel_info - channel info representation
>    * @name: name of service
> 
