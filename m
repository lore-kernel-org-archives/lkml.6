Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E10B7C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 10:41:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC85D2082F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 10:41:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC85D2082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726716AbeLJKl3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 05:41:29 -0500
Received: from mail.bootlin.com ([62.4.15.54]:55144 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726167AbeLJKl3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 05:41:29 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id EF34C20CE3; Mon, 10 Dec 2018 11:41:25 +0100 (CET)
Received: from bbrezillon (unknown [91.160.177.164])
        by mail.bootlin.com (Postfix) with ESMTPSA id A2F972037D;
        Mon, 10 Dec 2018 11:41:15 +0100 (CET)
Date:   Mon, 10 Dec 2018 11:41:15 +0100
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Schrempf Frieder <frieder.schrempf@kontron.de>
Cc:     Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "robh@kernel.org" <robh@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 1/5] spi: spi-mem: Add driver for NXP FlexSPI
 controller
Message-ID: <20181210114115.3f3c1958@bbrezillon>
In-Reply-To: <b616a9c7-40cf-d2da-b164-0d56a82c6cbc@kontron.de>
References: <1542366701-16065-1-git-send-email-yogeshnarayan.gaur@nxp.com>
 <1542366701-16065-2-git-send-email-yogeshnarayan.gaur@nxp.com>
 <eb8a31d8-2ba6-f27c-addf-545c77921b77@kontron.de>
 <VI1PR04MB57267D9F69719B4BEF38BF8699A50@VI1PR04MB5726.eurprd04.prod.outlook.com>
 <b616a9c7-40cf-d2da-b164-0d56a82c6cbc@kontron.de>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Dec 2018 10:35:35 +0000
Schrempf Frieder <frieder.schrempf@kontron.de> wrote:

> >>> +
> >>> +static int nxp_fspi_exec_op(struct spi_mem *mem, const struct
> >>> +spi_mem_op *op) {
> >>> +	struct nxp_fspi *f = spi_controller_get_devdata(mem->spi->master);
> >>> +	int err = 0;
> >>> +
> >>> +	mutex_lock(&f->lock);
> >>> +
> >>> +	/* Wait for controller being ready. */
> >>> +	err = fspi_readl_poll_tout(f, f->iobase + FSPI_STS0,
> >>> +				   FSPI_STS0_ARB_IDLE, 1, POLL_TOUT, true);
> >>> +	WARN_ON(err);
> >>> +
> >>> +	nxp_fspi_select_mem(f, mem->spi);
> >>> +
> >>> +	nxp_fspi_prepare_lut(f, op);
> >>> +	/*
> >>> +	 * If we have large chunks of data, we read them through the AHB bus
> >>> +	 * by accessing the mapped memory. In all other cases we use
> >>> +	 * IP commands to access the flash.
> >>> +	 */
> >>> +	if (op->data.nbytes > (f->devtype_data->rxfifo - 4) &&
> >>> +	    op->data.dir == SPI_MEM_DATA_IN) {
> >>> +		nxp_fspi_read_ahb(f, op);
> >>> +	} else {
> >>> +		if (op->data.nbytes && op->data.dir == SPI_MEM_DATA_OUT)
> >>> +			nxp_fspi_fill_txfifo(f, op);
> >>> +
> >>> +		err = nxp_fspi_do_op(f, op);
> >>> +
> >>> +		/* Invalidate the data in the AHB buffer. */
> >>> +		if (op->data.nbytes && op->data.dir == SPI_MEM_DATA_OUT)
> >>> +			nxp_fspi_invalid(f);  
> >>
> >> E.g. in case of an erase operation or a NAND load page operation, the
> >> invalidation is not triggered, but flash/buffer contents have changed.
> >> So I'm not sure if this is enough...  
> > Ok, would change this and have invalidate for all operations.  
> 
> Maybe you can find out the correct way through testing with NOR and NAND.

Or just invalidate the buffer every time you're doing a read through the
AHB. This should always work.

I also think we should quickly move to a model where AHB accesses are
reserved for dirmap, and regular spi-mem op are limited to non-ahb
reads.
