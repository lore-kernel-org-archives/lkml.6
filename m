Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81AB6C04AA5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 14:56:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 476972089D
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 14:56:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 476972089D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726687AbeJOWlp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 18:41:45 -0400
Received: from muru.com ([72.249.23.125]:52088 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726422AbeJOWlp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 18:41:45 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 4639C80B7;
        Mon, 15 Oct 2018 14:56:06 +0000 (UTC)
Date:   Mon, 15 Oct 2018 07:56:01 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     Sekhar Nori <nsekhar@ti.com>
Cc:     Vignesh R <vigneshr@ti.com>, Mark Brown <broonie@kernel.org>,
        linux-spi@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] spi: omap2-mcspi: Add slave mode support
Message-ID: <20181015145601.GA5907@atomide.com>
References: <20181015063829.26978-1-vigneshr@ti.com>
 <20181015063829.26978-4-vigneshr@ti.com>
 <2bef1218-ef43-cdc1-303f-b85863887a6b@ti.com>
 <28333ef8-22ca-e95f-b9d5-c0aeece20603@ti.com>
 <87459424-1083-0716-0481-89d7b7e3f08c@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87459424-1083-0716-0481-89d7b7e3f08c@ti.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Sekhar Nori <nsekhar@ti.com> [181015 10:04]:
> On Monday 15 October 2018 03:12 PM, Vignesh R wrote:
> > Hi Sekhar,
> > 
> > On Monday 15 October 2018 01:53 PM, Sekhar Nori wrote:
> > 
> > [...]
> >>>  
> >>> +static irqreturn_t omap2_mcspi_irq_handler(int irq, void *data)
> >>> +{
> >>> +	struct omap2_mcspi *mcspi = data;
> >>> +	u32 irqstat;
> >>> +
> >>> +	irqstat	= mcspi_read_reg(mcspi->master, OMAP2_MCSPI_IRQSTATUS);
> >>> +	if (!irqstat)
> >>> +		return IRQ_NONE;
> >>> +
> >>> +	/* Disable IRQ and wakeup slave xfer task */
> >>> +	mcspi_write_reg(mcspi->master, OMAP2_MCSPI_IRQENABLE, 0);
> >>> +	if (irqstat & OMAP2_MCSPI_IRQSTATUS_EOW)
> >>> +		complete(&mcspi->txdone);
> >>> +
> >>> +	return IRQ_HANDLED;
> >>
> >> You need to have the:
> >>
> >> pm_runtime_get_sync();
> >>
> >> /* access registers */
> >>
> >> pm_runtime_mark_last_busy();
> >> pm_runtime_put_autosuspend();
> >>
> >> sequence here. I think thats also missing from the dma callbacks.
> >> Probably working by chance today.
> >>
> > 
> > This is taken care of by the SPI core as part of __spi_pump_messages():
> > pm_runtime_get_sync()
> > ...
> > spi_transfer_one_message
> > ...
> > 	omap2_mcspi_transfer_one
> > 	...
> > 		omap2_mcspi_txrx_dma
> > 
> > So, both in dma callbacks and in IRQ handler, SPI controller is in
> > active state.
> 
> Ah, okay then. False alarm :)

FYI, we never want to do pm_runtime_get_sync() from the irq handler as that
implies pm_runtime_irq_safe(). And pm_runtime_irq_safe() takes a permanent
use count on the parent device which is something we don't want to do. And
we need to fix in existing drivers to not rely on using pm_runtime_irq_safe().

The way to deal with having an event wake up a device is to configure a
generic wakeirq that then wakes up the device and have the interrupt handler
bail out early in the unlikely case the device is not awake when servicing
interrupts. And in some cases with clock autoidle we can just use cpu_pm
notifiers instead of PM runtime if the changes are related to SoC idle states.

Anyways, sounds like no need to do anything with these patches :)

Regards,

Tony
