Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F14EC65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 12:32:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4F7D20858
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 12:32:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4F7D20858
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726393AbeJHToN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 15:44:13 -0400
Received: from mail.bootlin.com ([62.4.15.54]:44268 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725849AbeJHToN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 15:44:13 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 28901207F3; Mon,  8 Oct 2018 14:32:40 +0200 (CEST)
Received: from bbrezillon (AAubervilliers-681-1-28-153.w90-88.abo.wanadoo.fr [90.88.148.153])
        by mail.bootlin.com (Postfix) with ESMTPSA id CCA6420726;
        Mon,  8 Oct 2018 14:32:39 +0200 (CEST)
Date:   Mon, 8 Oct 2018 14:32:40 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
Cc:     "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "robh@kernel.org" <robh@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "frieder.schrempf@exceet.de" <frieder.schrempf@exceet.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/5] spi: spi-mem: Add driver for NXP FlexSPI
 controller
Message-ID: <20181008143240.00e784a8@bbrezillon>
In-Reply-To: <AM2PR04MB1027555CED1534472C6B8A3C99E60@AM2PR04MB1027.eurprd04.prod.outlook.com>
References: <1537525323-20730-1-git-send-email-yogeshnarayan.gaur@nxp.com>
        <1537525323-20730-2-git-send-email-yogeshnarayan.gaur@nxp.com>
        <20180929174023.51b1e284@bbrezillon>
        <AM2PR04MB1027555CED1534472C6B8A3C99E60@AM2PR04MB1027.eurprd04.prod.outlook.com>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Oct 2018 11:21:13 +0000
Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com> wrote:

> > > +static void nxp_fspi_read_ahb(struct nxp_fspi *f, const struct
> > > +spi_mem_op *op) {
> > > +	u32 len = op->data.nbytes;
> > > +
> > > +	/* Read out the data directly from the AHB buffer. */
> > > +	memcpy_fromio(op->data.buf.in, (f->ahb_addr + op->addr.val), len);  
> > 
> > Don't know if it's supported, but if it is, I recommend using DMA to do this copy,
> > because otherwise you might stall the CPU for quite a long time if the flash is
> > operating in a low-speed mode, and RT maintainers will complain about that at
> > some point ;-).
> >   
> Read using DMA is not supported by the controller in AHB mode, only supported in IP mode.
> Have to use memcpy_fromio() calls. Maximum data size can be read in single call is 0x800 using AHB read.
> 

Still, blocking the CPU until the SPI controller has read 0x800 bytes
is enough to make you miss a real-time deadline. Don't you have a
controller that supports mem2mem transfers (I'm pretty sure a mem2mem
DMA transfer would do the trick here)?

Regards,

Boris
