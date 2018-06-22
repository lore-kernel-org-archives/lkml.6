Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 925CAC43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 11:02:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 543F9240D6
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 11:02:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 543F9240D6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754363AbeFVLCX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 07:02:23 -0400
Received: from mail.bootlin.com ([62.4.15.54]:49750 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751307AbeFVLCW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 07:02:22 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 09A70206FF; Fri, 22 Jun 2018 13:02:20 +0200 (CEST)
Received: from localhost (unknown [37.71.171.242])
        by mail.bootlin.com (Postfix) with ESMTPSA id CE47020012;
        Fri, 22 Jun 2018 13:02:09 +0200 (CEST)
Date:   Fri, 22 Jun 2018 13:02:10 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Marc Zyngier <marc.zyngier@arm.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        linux-kernel@vger.kernel.org,
        Yang Yingliang <yangyingliang@huawei.com>,
        Sumit Garg <sumit.garg@linaro.org>
Subject: Re: [PATCH v2 2/7] irqchip/ls-scfg-msi: Fix MSI affinity handling
Message-ID: <20180622110210.GO7737@piout.net>
References: <20180622095254.5906-1-marc.zyngier@arm.com>
 <20180622095254.5906-3-marc.zyngier@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180622095254.5906-3-marc.zyngier@arm.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/06/2018 10:52:49+0100, Marc Zyngier wrote:
> The ls-scfs-msi driver is not dealing with the effective affinity
> as it should. Let's fix that, and make it clear that the effective
> affinity is restricted to a single CPU. Also prevent the driver from
> messing with the internals of the affinity setting infrastructure.
> 
> Reported-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

Tested-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

> ---
>  drivers/irqchip/irq-ls-scfg-msi.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/irqchip/irq-ls-scfg-msi.c b/drivers/irqchip/irq-ls-scfg-msi.c
> index 1ec3bfe56693..c671b3212010 100644
> --- a/drivers/irqchip/irq-ls-scfg-msi.c
> +++ b/drivers/irqchip/irq-ls-scfg-msi.c
> @@ -93,8 +93,12 @@ static void ls_scfg_msi_compose_msg(struct irq_data *data, struct msi_msg *msg)
>  	msg->address_lo = lower_32_bits(msi_data->msiir_addr);
>  	msg->data = data->hwirq;
>  
> -	if (msi_affinity_flag)
> -		msg->data |= cpumask_first(data->common->affinity);
> +	if (msi_affinity_flag) {
> +		const struct cpumask *mask;
> +
> +		mask = irq_data_get_effective_affinity_mask(data);
> +		msg->data |= cpumask_first(mask);
> +	}
>  
>  	iommu_dma_map_msi_msg(data->irq, msg);
>  }
> @@ -121,7 +125,7 @@ static int ls_scfg_msi_set_affinity(struct irq_data *irq_data,
>  		return -EINVAL;
>  	}
>  
> -	cpumask_copy(irq_data->common->affinity, mask);
> +	irq_data_update_effective_affinity(irq_data, cpumask_of(cpu));
>  
>  	return IRQ_SET_MASK_OK;
>  }
> -- 
> 2.17.1
> 

-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
