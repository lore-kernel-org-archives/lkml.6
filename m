Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6961BC2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 13:54:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 264D720827
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 13:54:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 264D720827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728074AbeJ3Wrk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 18:47:40 -0400
Received: from mail.bootlin.com ([62.4.15.54]:58281 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727650AbeJ3Wrk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 18:47:40 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 37F63207A3; Tue, 30 Oct 2018 14:54:04 +0100 (CET)
Received: from localhost (aaubervilliers-681-1-12-210.w90-88.abo.wanadoo.fr [90.88.133.210])
        by mail.bootlin.com (Postfix) with ESMTPSA id F1A11207A3;
        Tue, 30 Oct 2018 14:53:53 +0100 (CET)
Date:   Tue, 30 Oct 2018 14:53:54 +0100
From:   Antoine Tenart <antoine.tenart@bootlin.com>
To:     Marc Zyngier <marc.zyngier@arm.com>
Cc:     Antoine Tenart <antoine.tenart@bootlin.com>, davem@davemloft.net,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        thomas.petazzoni@bootlin.com, maxime.chevallier@bootlin.com,
        gregory.clement@bootlin.com, miquel.raynal@bootlin.com,
        nadavh@marvell.com, stefanc@marvell.com, ymarkman@marvell.com,
        mw@semihalf.com
Subject: Re: [PATCH net-next 11/12] net: mvpp2: handle cases where more CPUs
 are available than s/w threads
Message-ID: <20181030135354.GD3407@kwain>
References: <20180919092711.22296-1-antoine.tenart@bootlin.com>
 <20180919092711.22296-12-antoine.tenart@bootlin.com>
 <a3108c92-37b8-996e-01f6-72b7db532570@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a3108c92-37b8-996e-01f6-72b7db532570@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Marc,

On Mon, Oct 29, 2018 at 05:35:52PM +0000, Marc Zyngier wrote:
> On 19/09/18 10:27, Antoine Tenart wrote:
> 
> Really??? How on Earth are you testing this code?

Thank you for the feedback.

> I came up with the following fix, which fixes the issue for me.

I did not test your fix, but it looks good and does fix a real issue.
You can send it to netdev.

Antoine

> From ca25785bd1a679e72ed77e939b19360bfd0eecea Mon Sep 17 00:00:00 2001
> From: Marc Zyngier <marc.zyngier@arm.com>
> Date: Mon, 29 Oct 2018 17:07:25 +0000
> Subject: [PATCH] net: mvpp2: Fix affinity hint allocation
> 
> The mvpp2 driver has the curious behaviour of passing a stack variable
> to irq_set_affinity_hint(), which results in the kernel exploding
> the first time anyone accesses this information. News flash: userspace
> does, and irqbalance will happily take the machine down. Great stuff.
> 
> An easy fix is to track the mask within the queue_vector structure,
> and to make sure it has the same lifetime as the interrupt itself.
> 
> Fixes: e531f76757eb ("net: mvpp2: handle cases where more CPUs are available than s/w threads")
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
>  drivers/net/ethernet/marvell/mvpp2/mvpp2.h     |  1 +
>  .../net/ethernet/marvell/mvpp2/mvpp2_main.c    | 18 ++++++++++++++----
>  2 files changed, 15 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2.h b/drivers/net/ethernet/marvell/mvpp2/mvpp2.h
> index 176c6b56fdcc..398328f10743 100644
> --- a/drivers/net/ethernet/marvell/mvpp2/mvpp2.h
> +++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2.h
> @@ -796,6 +796,7 @@ struct mvpp2_queue_vector {
>  	int nrxqs;
>  	u32 pending_cause_rx;
>  	struct mvpp2_port *port;
> +	struct cpumask *mask;
>  };
>  
>  struct mvpp2_port {
> diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
> index 14f9679c957c..7a37a37e3fb3 100644
> --- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
> +++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
> @@ -3298,24 +3298,30 @@ static int mvpp2_irqs_init(struct mvpp2_port *port)
>  	for (i = 0; i < port->nqvecs; i++) {
>  		struct mvpp2_queue_vector *qv = port->qvecs + i;
>  
> -		if (qv->type == MVPP2_QUEUE_VECTOR_PRIVATE)
> +		if (qv->type == MVPP2_QUEUE_VECTOR_PRIVATE) {
> +			qv->mask = kzalloc(cpumask_size(), GFP_KERNEL);
> +			if (!qv->mask) {
> +				err = -ENOMEM;
> +				goto err;
> +			}
> +
>  			irq_set_status_flags(qv->irq, IRQ_NO_BALANCING);
> +		}
>  
>  		err = request_irq(qv->irq, mvpp2_isr, 0, port->dev->name, qv);
>  		if (err)
>  			goto err;
>  
>  		if (qv->type == MVPP2_QUEUE_VECTOR_PRIVATE) {
> -			unsigned long mask = 0;
>  			unsigned int cpu;
>  
>  			for_each_present_cpu(cpu) {
>  				if (mvpp2_cpu_to_thread(port->priv, cpu) ==
>  				    qv->sw_thread_id)
> -					mask |= BIT(cpu);
> +					cpumask_set_cpu(cpu, qv->mask);
>  			}
>  
> -			irq_set_affinity_hint(qv->irq, to_cpumask(&mask));
> +			irq_set_affinity_hint(qv->irq, qv->mask);
>  		}
>  	}
>  
> @@ -3325,6 +3331,8 @@ static int mvpp2_irqs_init(struct mvpp2_port *port)
>  		struct mvpp2_queue_vector *qv = port->qvecs + i;
>  
>  		irq_set_affinity_hint(qv->irq, NULL);
> +		kfree(qv->mask);
> +		qv->mask = NULL;
>  		free_irq(qv->irq, qv);
>  	}
>  
> @@ -3339,6 +3347,8 @@ static void mvpp2_irqs_deinit(struct mvpp2_port *port)
>  		struct mvpp2_queue_vector *qv = port->qvecs + i;
>  
>  		irq_set_affinity_hint(qv->irq, NULL);
> +		kfree(qv->mask);
> +		qv->mask = NULL;
>  		irq_clear_status_flags(qv->irq, IRQ_NO_BALANCING);
>  		free_irq(qv->irq, qv);
>  	}
> -- 
> 2.19.1
> 
> 
> -- 
> Jazz is not dead. It just smells funny...

-- 
Antoine Ténart, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
