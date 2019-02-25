Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C08C5C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 10:34:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96DDB2087C
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 10:34:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbfBYKet (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 05:34:49 -0500
Received: from mga17.intel.com ([192.55.52.151]:26351 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726669AbfBYKes (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 05:34:48 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Feb 2019 02:34:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,411,1544515200"; 
   d="scan'208";a="120580722"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by orsmga008.jf.intel.com with ESMTP; 25 Feb 2019 02:34:45 -0800
Received: from andy by smile with local (Exim 4.92-RC6)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1gyDau-00088v-2i; Mon, 25 Feb 2019 12:34:44 +0200
Date:   Mon, 25 Feb 2019 12:34:44 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Ludovic Desroches <ludovic.desroches@microchip.com>
Cc:     linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        me@jue.yt, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com, linux-kernel@vger.kernel.org,
        wsa@the-dreams.de
Subject: Re: [PATCH v5 2/3] i2c: at91: split driver into core and master file
Message-ID: <20190225103444.GR9224@smile.fi.intel.com>
References: <20190222092522.4913-1-ludovic.desroches@microchip.com>
 <20190222092522.4913-3-ludovic.desroches@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190222092522.4913-3-ludovic.desroches@microchip.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 22, 2019 at 10:25:21AM +0100, Ludovic Desroches wrote:
> From: Juergen Fitschen <me@jue.yt>
> 
> The single file i2c-at91.c has been split into core code (i2c-at91-core.c)
> and master mode specific code (i2c-at91-master.c). This should enhance
> maintainability and reduce ifdeffery for slave mode related code.
> 
> The code itself hasn't been touched. Shared functions only had to be made
> non-static. Furthermore, includes have been cleaned up.

Since it's a split of existing code, consider my comments as a way to improve
it afterwards.

> +static struct at91_twi_pdata *at91_twi_get_driver_data(
> +					struct platform_device *pdev)
> +{
> +	if (pdev->dev.of_node) {
> +		const struct of_device_id *match;
> +		match = of_match_node(atmel_twi_dt_ids, pdev->dev.of_node);
> +		if (!match)
> +			return NULL;
> +		return (struct at91_twi_pdata *)match->data;
> +	}
> +	return (struct at91_twi_pdata *) platform_get_device_id(pdev)->driver_data;



One may do the following instead:
	struct at91_twi_pdata *data;

	data = device_get_match_data(&pdev->dev);
	if (data)
		return data;
	return ...

And if you ever will switch old platform to somelike unified interface for
device properties, I would recommend to use device_property_* instead of
of_property_* and so on.

> +}

> +#include <linux/clk.h>
> +#include <linux/completion.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/dmaengine.h>
> +#include <linux/i2c.h>
> +#include <linux/platform_data/dma-atmel.h>
> +#include <linux/platform_device.h>

Are all those anyhow in use in this header file?

> +#define AT91_I2C_TIMEOUT	msecs_to_jiffies(100)	/* transfer timeout */

Wouldn't be better to use _MS here and call actual conversion whenever it's
needed?

> +#define AT91_I2C_DMA_THRESHOLD	8			/* enable DMA if transfer size is bigger than this threshold */

> +#define AUTOSUSPEND_TIMEOUT		2000

_MS ?

> +#define	AT91_TWI_SR		0x0020	/* Status Register */
> +#define	AT91_TWI_TXCOMP		BIT(0)	/* Transmission Complete */
> +#define	AT91_TWI_RXRDY		BIT(1)	/* Receive Holding Register Ready */
> +#define	AT91_TWI_TXRDY		BIT(2)	/* Transmit Holding Register Ready */
> +#define	AT91_TWI_OVRE		BIT(6)	/* Overrun Error */
> +#define	AT91_TWI_UNRE		BIT(7)	/* Underrun Error */
> +#define	AT91_TWI_NACK		BIT(8)	/* Not Acknowledged */
> +#define	AT91_TWI_LOCK		BIT(23) /* TWI Lock due to Frame Errors */
> +
> +#define	AT91_TWI_INT_MASK \
> +	(AT91_TWI_TXCOMP | AT91_TWI_RXRDY | AT91_TWI_TXRDY | AT91_TWI_NACK)
> +
> +#define	AT91_TWI_IER		0x0024	/* Interrupt Enable Register */
> +#define	AT91_TWI_IDR		0x0028	/* Interrupt Disable Register */
> +#define	AT91_TWI_IMR		0x002c	/* Interrupt Mask Register */
> +#define	AT91_TWI_RHR		0x0030	/* Receive Holding Register */
> +#define	AT91_TWI_THR		0x0034	/* Transmit Holding Register */
> +
> +#define	AT91_TWI_ACR		0x0040	/* Alternative Command Register */
> +#define	AT91_TWI_ACR_DATAL(len)	((len) & 0xff)
> +#define	AT91_TWI_ACR_DIR	BIT(8)
> +
> +#define	AT91_TWI_FMR		0x0050	/* FIFO Mode Register */
> +#define	AT91_TWI_FMR_TXRDYM(mode)	(((mode) & 0x3) << 0)

> +#define	AT91_TWI_FMR_TXRDYM_MASK	(0x3 << 0)

GENMASK() ?

> +#define	AT91_TWI_FMR_RXRDYM(mode)	(((mode) & 0x3) << 4)

> +#define	AT91_TWI_FMR_RXRDYM_MASK	(0x3 << 4)

Ditto.

-- 
With Best Regards,
Andy Shevchenko


