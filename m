Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753617AbeE3O6V (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 10:58:21 -0400
Received: from mail.bootlin.com ([62.4.15.54]:45828 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753113AbeE3O6S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 10:58:18 -0400
Date: Wed, 30 May 2018 16:58:16 +0200
From: Boris Brezillon <boris.brezillon@bootlin.com>
To: Frieder Schrempf <frieder.schrempf@exceet.de>
Cc: linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org,
        dwmw2@infradead.org, computersforpeace@gmail.com,
        marek.vasut@gmail.com, richard@nod.at, miquel.raynal@bootlin.com,
        broonie@kernel.org, david.wolfe@nxp.com, fabio.estevam@nxp.com,
        prabhakar.kushwaha@nxp.com, yogeshnarayan.gaur@nxp.com, han.xu@nxp.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/11] spi: Add a driver for the Freescale/NXP QuadSPI
 controller
Message-ID: <20180530165816.371dc39c@bbrezillon>
In-Reply-To: <1527686082-15142-4-git-send-email-frieder.schrempf@exceet.de>
References: <1527686082-15142-1-git-send-email-frieder.schrempf@exceet.de>
        <1527686082-15142-4-git-send-email-frieder.schrempf@exceet.de>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Frieder,

On Wed, 30 May 2018 15:14:32 +0200
Frieder Schrempf <frieder.schrempf@exceet.de> wrote:

> +
> +static const char *fsl_qspi_get_name(struct spi_mem *mem)
> +{
> +	struct fsl_qspi *q = spi_controller_get_devdata(mem->spi->master);
> +	struct device *dev = &mem->spi->dev;
> +	const char *name;
> +
> +	/*
> +	 * In order to keep mtdparts compatible with the old MTD driver at
> +	 * mtd/spi-nor/fsl-quadspi.c, we set a custom name derived from the
> +	 * platform_device of the controller.
> +	 */
> +	if (of_get_available_child_count(q->dev->of_node) == 1)
> +		name = dev_name(q->dev);
> +	else
> +		name = devm_kasprintf(dev, GFP_KERNEL,
> +				      "%s-%d", dev_name(q->dev),
> +				      mem->spi->chip_select);
> +
> +	if (!name) {
> +		dev_err(dev, "failed to get memory for custom flash name\n");
> +		return dev_name(q->dev);

Hm, not sure that's what we want. We should probably fail when the
allocation fails.

How about letting ->get_name() return an error pointer or NULL in case
of error. With the other I made suggestion in my review of patch 1
(calling ->get_name() at probe time) you could refuse to probe the
device when ->get_name() fails.

> +	}
> +
> +	return name;
> +}
> +

Regards,

Boris
