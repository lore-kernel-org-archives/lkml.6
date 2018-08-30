Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7745BC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 10:31:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BB192073D
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 10:31:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BB192073D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728420AbeH3Ocj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 10:32:39 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:49859 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728138AbeH3Oci (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 10:32:38 -0400
Received: from hsi-kbw-5-158-153-52.hsi19.kabel-badenwuerttemberg.de ([5.158.153.52] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fvKED-0000uP-CW; Thu, 30 Aug 2018 12:31:05 +0200
Date:   Thu, 30 Aug 2018 12:31:04 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Richard Fitzgerald <rf@opensource.cirrus.com>
cc:     jason@lakedaemon.net, marc.zyngier@arm.com, lee.jones@linaro.org,
        patches@opensource.cirrus.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10 2/2] irqchip: Add driver for Cirrus Logic Madera
 codecs
In-Reply-To: <20180828130934.18135-2-rf@opensource.cirrus.com>
Message-ID: <alpine.DEB.2.21.1808301154040.1210@nanos.tec.linutronix.de>
References: <20180828130934.18135-1-rf@opensource.cirrus.com> <20180828130934.18135-2-rf@opensource.cirrus.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Aug 2018, Richard Fitzgerald wrote:
> @@ -0,0 +1,244 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Interrupt support for Cirrus Logic Madera codecs
> + *
> + * Copyright (C) 2015-2018 Cirrus Logic
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by the
> + * Free Software Foundation; version 2.

You have the SPDX identifier above, which makes this boilerplate
superfluous. 

> +#ifdef CONFIG_PM_SLEEP
> +static int madera_suspend_noirq(struct device *dev)
> +{
> +	struct madera *madera = dev_get_drvdata(dev->parent);
> +
> +	dev_dbg(madera->irq_dev, "No IRQ suspend, reenabling IRQ\n");
> +
> +	enable_irq(madera->irq);
> +
> +	return 0;
> +}
> +
> +static int madera_suspend(struct device *dev)
> +{
> +	struct madera *madera = dev_get_drvdata(dev->parent);
> +
> +	dev_dbg(madera->irq_dev, "Suspend, disabling IRQ\n");
> +
> +	disable_irq(madera->irq);
> +
> +	return 0;
> +}

This really wants a comment why you are disabling it first and reenabling
it afterwards. I have no idea why you are doing this and it doesn't make
much sense from the S/R perspective either.

> +	/*
> +	 * Read the flags from the interrupt controller if not specified
> +	 * by pdata
> +	 */
> +	irq_flags = madera->pdata.irq_flags;
> +	if (!irq_flags) {
> +		irq_data = irq_get_irq_data(madera->irq);
> +		if (!irq_data) {
> +			dev_err(&pdev->dev, "Invalid IRQ: %d\n", madera->irq);
> +			return -EINVAL;
> +		}
> +
> +		irq_flags = irqd_get_trigger_type(irq_data);
> +
> +		/* Codec defaults to trigger low, use this if no flags given */
> +		if (irq_flags == IRQ_TYPE_NONE)
> +			irq_flags = IRQF_TRIGGER_LOW;
> +	}
> +
> +	if (irq_flags & (IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING)) {
> +		dev_err(&pdev->dev, "Host interrupt not level-triggered\n");
> +		return -EINVAL;
> +	}
> +
> +	if (irq_flags & IRQF_TRIGGER_HIGH) {
> +		ret = regmap_update_bits(madera->regmap, MADERA_IRQ1_CTRL,
> +					 MADERA_IRQ_POL_MASK, 0);
> +		if (ret) {
> +			dev_err(&pdev->dev,
> +				"Failed to set IRQ polarity: %d\n", ret);
> +			return ret;
> +		}
> +	}

This looks wrong. Why are you only updating the polarity for trigger HIGH?

> diff --git a/include/linux/irqchip/irq-madera.h b/include/linux/irqchip/irq-madera.h
> new file mode 100644
> index 000000000000..5aeb7e6adc82
> --- /dev/null
> +++ b/include/linux/irqchip/irq-madera.h
> @@ -0,0 +1,135 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Interrupt support for Cirrus Logic Madera codecs
> + *
> + * Copyright 2016-2018 Cirrus Logic
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by the
> + * Free Software Foundation; version 2.

See above.

Thanks,

	tglx
