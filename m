Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59860C6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 16:14:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 196432147E
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 16:14:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 196432147E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933809AbeGCQON (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 12:14:13 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:52042 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932392AbeGCQOK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 12:14:10 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6D8567A9;
        Tue,  3 Jul 2018 09:14:10 -0700 (PDT)
Received: from [10.1.210.23] (e110467-lin.cambridge.arm.com [10.1.210.23])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ABD543F5BA;
        Tue,  3 Jul 2018 09:14:06 -0700 (PDT)
Subject: Re: [PATCH 5/7 v5] bus: fsl-mc: support dma configure for devices on
 fsl-mc bus
To:     Nipun Gupta <nipun.gupta@nxp.com>, will.deacon@arm.com,
        robh+dt@kernel.org, robh@kernel.org, mark.rutland@arm.com,
        catalin.marinas@arm.com, gregkh@linuxfoundation.org,
        laurentiu.tudor@nxp.com, bhelgaas@google.com
Cc:     hch@lst.de, joro@8bytes.org, m.szyprowski@samsung.com,
        shawnguo@kernel.org, frowand.list@gmail.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
        bharat.bhushan@nxp.com, stuyoder@gmail.com, leoyang.li@nxp.com
References: <1526824191-7000-1-git-send-email-nipun.gupta@nxp.com>
 <1526824191-7000-6-git-send-email-nipun.gupta@nxp.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <b4cf1e86-0297-97ed-d10e-9b430ecb0bc7@arm.com>
Date:   Tue, 3 Jul 2018 17:14:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1526824191-7000-6-git-send-email-nipun.gupta@nxp.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/05/18 14:49, Nipun Gupta wrote:
> This patch adds support of dma configuration for devices on fsl-mc
> bus using 'dma_configure' callback for busses. Also, directly calling
> arch_setup_dma_ops is removed from the fsl-mc bus.

Looks like this is the final arch_setup_dma_ops offender, yay!

> Signed-off-by: Nipun Gupta <nipun.gupta@nxp.com>
> Reviewed-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
> ---
>   drivers/bus/fsl-mc/fsl-mc-bus.c | 15 +++++++++++----
>   1 file changed, 11 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/bus/fsl-mc/fsl-mc-bus.c b/drivers/bus/fsl-mc/fsl-mc-bus.c
> index 5d8266c..fa43c7d 100644
> --- a/drivers/bus/fsl-mc/fsl-mc-bus.c
> +++ b/drivers/bus/fsl-mc/fsl-mc-bus.c
> @@ -127,6 +127,16 @@ static int fsl_mc_bus_uevent(struct device *dev, struct kobj_uevent_env *env)
>   	return 0;
>   }
>   
> +static int fsl_mc_dma_configure(struct device *dev)
> +{
> +	struct device *dma_dev = dev;
> +
> +	while (dev_is_fsl_mc(dma_dev))
> +		dma_dev = dma_dev->parent;
> +
> +	return of_dma_configure(dev, dma_dev->of_node, 0);
> +}
> +
>   static ssize_t modalias_show(struct device *dev, struct device_attribute *attr,
>   			     char *buf)
>   {
> @@ -148,6 +158,7 @@ struct bus_type fsl_mc_bus_type = {
>   	.name = "fsl-mc",
>   	.match = fsl_mc_bus_match,
>   	.uevent = fsl_mc_bus_uevent,
> +	.dma_configure  = fsl_mc_dma_configure,
>   	.dev_groups = fsl_mc_dev_groups,
>   };
>   EXPORT_SYMBOL_GPL(fsl_mc_bus_type);
> @@ -633,10 +644,6 @@ int fsl_mc_device_add(struct fsl_mc_obj_desc *obj_desc,
>   			goto error_cleanup_dev;
>   	}
>   
> -	/* Objects are coherent, unless 'no shareability' flag set. */
> -	if (!(obj_desc->flags & FSL_MC_OBJ_FLAG_NO_MEM_SHAREABILITY))

Although it seems we do end up without any handling of this 
"non-coherent object behind coherent MC" case, and I'm not sure how 
easily that could be accommodated by generic code... :/ How important is 
the quirk?

Robin.

> -		arch_setup_dma_ops(&mc_dev->dev, 0, 0, NULL, true);
> -
>   	/*
>   	 * The device-specific probe callback will get invoked by device_add()
>   	 */
> 
