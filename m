Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752615AbeFEPA0 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 11:00:26 -0400
Received: from mail.bootlin.com ([62.4.15.54]:49226 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752057AbeFEPAZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 11:00:25 -0400
Date: Tue, 5 Jun 2018 17:00:23 +0200
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
Message-ID: <20180605170023.24eeaaaa@bbrezillon>
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

On Wed, 30 May 2018 15:14:32 +0200
Frieder Schrempf <frieder.schrempf@exceet.de> wrote:

> +
> +static void fsl_qspi_read_ahb(struct fsl_qspi *q, const struct spi_mem_op *op)
> +{
> +	static int seq;
> +
> +	/*
> +	 * We want to avoid needing to invalidate the cache by issueing
> +	 * a reset to the AHB and Serial Flash domain, as this needs
> +	 * time. So we change the address on each read to trigger an
> +	 * actual read operation on the flash. The actual address for
> +	 * the flash memory is set by programming the LUT.
> +	 */
> +	memcpy_fromio(op->data.buf.in,
> +		      q->ahb_addr +
> +		      (seq * q->devtype_data->ahb_buf_size),
> +		      op->data.nbytes);
> +
> +	seq = seq ? 0 : 1;

We should get rid of this hack. Yogesh, Han, do you know if there's an
easy way to invalidate the AHB buffer without resetting the IP?

> +}
