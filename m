Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB614C64EAD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 09:24:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8013A2086D
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 09:24:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="m2cNllNc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8013A2086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726656AbeJIQkA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 12:40:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:41854 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726461AbeJIQkA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 12:40:00 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4E3672086D;
        Tue,  9 Oct 2018 09:24:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539077041;
        bh=ZKYGqu6LMfUWbzlCrWCpP08Od0S5J5Dtf5ZoXla05NU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=m2cNllNc5CpXqsd7wJMaXld+Is+XpfTTXcfwUY0wKM/MSdkfFUWZBBUZh9pxCgxHK
         h1XSmGV7bu5P87oKTNNypiPY+xDZCR31JnpeLWn/GZmsgf6h/tnJDSxKlG4bOkFDxu
         9yAK2FqE2waC/78maSqEhuWmiSM8bZPvGmlgkdjE=
Date:   Tue, 9 Oct 2018 11:23:59 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Stephen Boyd <swboyd@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: Re: [PATCH 4.4 093/113] pinctrl: msm: Really mask level interrupts
 to prevent latching
Message-ID: <20181009092359.GD19241@kroah.com>
References: <20181008175530.864641368@linuxfoundation.org>
 <20181008175536.405502473@linuxfoundation.org>
 <20181009063338.GA22218@flashbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181009063338.GA22218@flashbox>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 08, 2018 at 11:33:38PM -0700, Nathan Chancellor wrote:
> On Mon, Oct 08, 2018 at 08:31:34PM +0200, Greg Kroah-Hartman wrote:
> > 4.4-stable review patch.  If anyone has any objections, please let me know.
> > 
> > ------------------
> > 
> > From: Stephen Boyd <swboyd@chromium.org>
> > 
> > [ Upstream commit b55326dc969ea2d704a008d9a97583b128f54f4f ]
> > 
> > The interrupt controller hardware in this pin controller has two status
> > enable bits. The first "normal" status enable bit enables or disables
> > the summary interrupt line being raised when a gpio interrupt triggers
> > and the "raw" status enable bit allows or prevents the hardware from
> > latching an interrupt into the status register for a gpio interrupt.
> > Currently we just toggle the "normal" status enable bit in the mask and
> > unmask ops so that the summary irq interrupt going to the CPU's
> > interrupt controller doesn't trigger for the masked gpio interrupt.
> > 
> > For a level triggered interrupt, the flow would be as follows: the pin
> > controller sees the interrupt, latches the status into the status
> > register, raises the summary irq to the CPU, summary irq handler runs
> > and calls handle_level_irq(), handle_level_irq() masks and acks the gpio
> > interrupt, the interrupt handler runs, and finally unmask the interrupt.
> > When the interrupt handler completes, we expect that the interrupt line
> > level will go back to the deasserted state so the genirq code can unmask
> > the interrupt without it triggering again.
> > 
> > If we only mask the interrupt by clearing the "normal" status enable bit
> > then we'll ack the interrupt but it will continue to show up as pending
> > in the status register because the raw status bit is enabled, the
> > hardware hasn't deasserted the line, and thus the asserted state latches
> > into the status register again. When the hardware deasserts the
> > interrupt the pin controller still thinks there is a pending unserviced
> > level interrupt because it latched it earlier. This behavior causes
> > software to see an extra interrupt for level type interrupts each time
> > the interrupt is handled.
> > 
> > Let's fix this by clearing the raw status enable bit for level type
> > interrupts so that the hardware stops latching the status of the
> > interrupt after we ack it. We don't do this for edge type interrupts
> > because it seems that toggling the raw status enable bit for edge type
> > interrupts causes spurious edge interrupts.
> > 
> > Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> > Reviewed-by: Douglas Anderson <dianders@chromium.org>
> > Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> > Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> > Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > ---
> >  drivers/pinctrl/qcom/pinctrl-msm.c |   24 ++++++++++++++++++++++++
> >  1 file changed, 24 insertions(+)
> > 
> > --- a/drivers/pinctrl/qcom/pinctrl-msm.c
> > +++ b/drivers/pinctrl/qcom/pinctrl-msm.c
> > @@ -577,6 +577,29 @@ static void msm_gpio_irq_mask(struct irq
> >  	spin_lock_irqsave(&pctrl->lock, flags);
> >  
> >  	val = readl(pctrl->regs + g->intr_cfg_reg);
> > +	/*
> > +	 * There are two bits that control interrupt forwarding to the CPU. The
> > +	 * RAW_STATUS_EN bit causes the level or edge sensed on the line to be
> > +	 * latched into the interrupt status register when the hardware detects
> > +	 * an irq that it's configured for (either edge for edge type or level
> > +	 * for level type irq). The 'non-raw' status enable bit causes the
> > +	 * hardware to assert the summary interrupt to the CPU if the latched
> > +	 * status bit is set. There's a bug though, the edge detection logic
> > +	 * seems to have a problem where toggling the RAW_STATUS_EN bit may
> > +	 * cause the status bit to latch spuriously when there isn't any edge
> > +	 * so we can't touch that bit for edge type irqs and we have to keep
> > +	 * the bit set anyway so that edges are latched while the line is masked.
> > +	 *
> > +	 * To make matters more complicated, leaving the RAW_STATUS_EN bit
> > +	 * enabled all the time causes level interrupts to re-latch into the
> > +	 * status register because the level is still present on the line after
> > +	 * we ack it. We clear the raw status enable bit during mask here and
> > +	 * set the bit on unmask so the interrupt can't latch into the hardware
> > +	 * while it's masked.
> > +	 */
> > +	if (irqd_get_trigger_type(d) & IRQ_TYPE_LEVEL_MASK)
> > +		val &= ~BIT(g->intr_raw_status_bit);
> > +
> >  	val &= ~BIT(g->intr_enable_bit);
> >  	writel(val, pctrl->regs + g->intr_cfg_reg);
> >  
> > @@ -598,6 +621,7 @@ static void msm_gpio_irq_unmask(struct i
> >  	spin_lock_irqsave(&pctrl->lock, flags);
> >  
> >  	val = readl(pctrl->regs + g->intr_cfg_reg);
> > +	val |= BIT(g->intr_raw_status_bit);
> >  	val |= BIT(g->intr_enable_bit);
> >  	writel(val, pctrl->regs + g->intr_cfg_reg);
> >  
> > 
> > 
> 
> Sigh, sorry, I caught this after I sent my initial all good email but
> this commit breaks NFC on my Pixel 2 XL (toggle becomes greyed out and
> apps that want to use it ask to enable it). I can't say why, I'm more
> than happy to debug but I'm assuming it's some voodoo that Qualcomm has
> done out of tree. I'll leave it up to you how to proceed given that I
> can't run mainline :(

Ugh, I hate the qualcomm changes...

Given the mess that all of the msm driver changes have, I'll go drop
this patch from the stable tree as I don't want to deal with the
fall-out for when people merge this to their device-specific trees.

thanks for testing and letting me know about this.

greg k-h
