Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C3EFC433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 19:27:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12E6E2075A
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 19:27:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12E6E2075A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936370AbeFRT1z (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 15:27:55 -0400
Received: from mail.bootlin.com ([62.4.15.54]:50581 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935859AbeFRT1w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 15:27:52 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 98172207C2; Mon, 18 Jun 2018 21:27:50 +0200 (CEST)
Received: from bbrezillon (91-160-177-164.subs.proxad.net [91.160.177.164])
        by mail.bootlin.com (Postfix) with ESMTPSA id 32CD920733;
        Mon, 18 Jun 2018 21:27:40 +0200 (CEST)
Date:   Mon, 18 Jun 2018 21:27:40 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Frieder Schrempf <frieder.schrempf@exceet.de>
Cc:     linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org,
        dwmw2@infradead.org, computersforpeace@gmail.com,
        marek.vasut@gmail.com, richard@nod.at, miquel.raynal@bootlin.com,
        broonie@kernel.org, david.wolfe@nxp.com, fabio.estevam@nxp.com,
        prabhakar.kushwaha@nxp.com, yogeshnarayan.gaur@nxp.com,
        han.xu@nxp.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/11] spi: Add a driver for the Freescale/NXP QuadSPI
 controller
Message-ID: <20180618212740.6b25c089@bbrezillon>
In-Reply-To: <1527686082-15142-4-git-send-email-frieder.schrempf@exceet.de>
References: <1527686082-15142-1-git-send-email-frieder.schrempf@exceet.de>
        <1527686082-15142-4-git-send-email-frieder.schrempf@exceet.de>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yogesh,

On Wed, 30 May 2018 15:14:32 +0200
Frieder Schrempf <frieder.schrempf@exceet.de> wrote:

> +static void fsl_qspi_select_mem(struct fsl_qspi *q, struct spi_device *spi)
> +{
> +	unsigned long rate = spi->max_speed_hz;
> +	int ret, i;
> +	u32 map_addr;
> +
> +	if (q->selected == spi->chip_select)
> +		return;
> +
> +	/*
> +	 * In HW there can be a maximum of four chips on two buses with
> +	 * two chip selects on each bus. We use four chip selects in SW
> +	 * to differentiate between the four chips.
> +	 * We use the SFA1AD, SFA2AD, SFB1AD, SFB2AD registers to select
> +	 * the chip we want to access.
> +	 */
> +	for (i = 0; i < 4; i++) {
> +		if (i < spi->chip_select)

Can you try with:

		if (i <= spi->chip_select)

and let me know if it fixes the problem you have when CS != 0?

> +			map_addr = q->memmap_phy;
> +		else
> +			map_addr = q->memmap_phy +
> +				   2 * q->devtype_data->ahb_buf_size;
> +
> +		qspi_writel(q, map_addr, q->iobase + QUADSPI_SFA1AD + (i * 4));
> +	}
> +
> +	if (needs_4x_clock(q))
> +		rate *= 4;
> +
> +	fsl_qspi_clk_disable_unprep(q);
> +
> +	ret = clk_set_rate(q->clk, rate);
> +	if (ret)
> +		return;
> +
> +	ret = fsl_qspi_clk_prep_enable(q);
> +	if (ret)
> +		return;
> +
> +	q->selected = spi->chip_select;
> +}
