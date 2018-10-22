Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1227AC004D3
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 10:41:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CC712064E
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 10:41:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="v3DATsAk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CC712064E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728640AbeJVS7t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 14:59:49 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:55234 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728306AbeJVS7t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 14:59:49 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id w9MAfDki046051;
        Mon, 22 Oct 2018 05:41:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1540204873;
        bh=udwgnpd0WUQTSWNJ0IspA6YTrMWnG0E3j0YfO5oSwL8=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=v3DATsAkYVn3gYVZ9bSsg3/VurRyZThSs3+d1OYPrfWnQh+IlGt9cRStedwFJTJdz
         I1gJh7OtMiVLg8B/DkDoBq/19Fjd9YnblRMpQpY25nUge6LqdoGQ1HtwUhcL+vcMUH
         9ZRzvDS7UzccIpuCSZxwup9qku16RriYUQ2+C9d4=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w9MAfDEG026716;
        Mon, 22 Oct 2018 05:41:13 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Mon, 22
 Oct 2018 05:41:10 -0500
Received: from dflp32.itg.ti.com (10.64.6.15) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Mon, 22 Oct 2018 05:41:10 -0500
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w9MAf7N8000920;
        Mon, 22 Oct 2018 05:41:08 -0500
Subject: Re: [PATCH v2 09/10] irqchip: ti-sci-inta: Add support for Interrupt
 Aggregator driver
To:     Lokesh Vutla <lokeshvutla@ti.com>, Nishanth Menon <nm@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, <tglx@linutronix.de>,
        <jason@lakedaemon.net>, <marc.zyngier@arm.com>
CC:     Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Tero Kristo <t-kristo@ti.com>,
        Sekhar Nori <nsekhar@ti.com>,
        Device Tree Mailing List <devicetree@vger.kernel.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>
References: <20181018154017.7112-1-lokeshvutla@ti.com>
 <20181018154017.7112-10-lokeshvutla@ti.com>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <6b112f34-cae3-fcd4-0d36-80b39c575fe4@ti.com>
Date:   Mon, 22 Oct 2018 13:42:15 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181018154017.7112-10-lokeshvutla@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lokesh,

On 2018-10-18 18:40, Lokesh Vutla wrote:
> Texas Instruments' K3 generation SoCs has an IP Interrupt Aggregator
> which is an interrupt controller that does the following:
> - Converts events to interrupts that can be understood by
>   an interrupt router.
> - Allows for multiplexing of events to interrupts.
> - Allows for grouping of multiple events to a single interrupt.
> 
> Configuration of the interrupt aggregator registers can only be done by
> a system co-processor and the driver needs to send a message to this
> co processor over TISCI protocol.
> 
> Add support for Interrupt Aggregator driver over TISCI protocol.

Have you compiled this?

...

> diff --git a/drivers/irqchip/irq-ti-sci-inta.c b/drivers/irqchip/irq-ti-sci-inta.c
> new file mode 100644
> index 000000000000..ef0a2e8b782c
> --- /dev/null
> +++ b/drivers/irqchip/irq-ti-sci-inta.c

...

> +/**
> + * ti_sci_inta_register_event() - Register a event to an interrupt aggregator
> + * @dev:	Device pointer to source generating the event
> + * @src_id:	TISCI device ID of the event source
> + * @src_index:	Event source index within the device.
> + * @virq:	Linux Virtual IRQ number
> + * @flags:	Corresponding IRQ flags
> + * @ack_needed:	If explicit clearing of event is required.
> + *
> + * Creates a new irq and attaches to IA domain if virq is not specified
> + * else attaches the event to vint corresponding to virq.
> + * When using TISCI within the client drivers, source indexes are always
> + * generated dynamically and cannot be represented in DT. So client
> + * drivers should call this API instead of platform_get_irq().
> + *
> + * Return virq if all went well else appropriate error value.
> + */
> +int ti_sci_inta_register_event(struct device *dev, u16 src_id, u16 src_index,
> +			       unsigned int virq, u32 flags, bool ack_needed)
> +{

...

> diff --git a/include/linux/irqchip/irq-ti-sci-inta.h b/include/linux/irqchip/irq-ti-sci-inta.h
> new file mode 100644
> index 000000000000..c078234fda3f
> --- /dev/null
> +++ b/include/linux/irqchip/irq-ti-sci-inta.h
> @@ -0,0 +1,35 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Texas Instruments' System Control Interface (TI-SCI) irqchip
> + *
> + * Copyright (C) 2018 Texas Instruments Incorporated - http://www.ti.com/
> + *	Lokesh Vutla <lokeshvutla@ti.com>
> + */
> +
> +#ifndef __INCLUDE_LINUX_IRQCHIP_TI_SCI_INTA_H
> +#define __INCLUDE_LINUX_IRQCHIP_TI_SCI_INTA_H
> +
> +#if IS_ENABLED(CONFIG_TI_SCI_INTA_IRQCHIP)
> +int ti_sci_inta_register_event(struct device *dev, u16 src_id, u16 src_index,
> +			       unsigned int virq, u32 flags);

You are missing the ack_needed

> +int ti_sci_inta_unregister_event(struct device *dev, u16 src_id, u16 src_index,
> +				 unsigned int virq);
> +
> +#else /* CONFIG_TI_SCI_INTA_IRQCHIP */
> +
> +static inline int ti_sci_inta_register_event(struct device *dev, u16 src_id,
> +					     u16 src_index, unsigned int virq,
> +					     u32 flags)

Here as well.

> +{
> +	return -EINVAL;
> +}
> +
> +static inline int ti_sci_inta_unregister_event(struct device *dev, u16 src_id,
> +					       u16 src_index, unsigned int virq)
> +{
> +	return -EINVAL;
> +}
> +
> +#endif /* CONFIG_TI_SCI_INTA_IRQCHIP */
> +
> +#endif /* __INCLUDE_LINUX_IRQCHIP_TI_SCI_INTA_H */
> 

- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
