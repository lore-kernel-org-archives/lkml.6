Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E3A3C64EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 16:58:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6363214DA
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 16:58:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="dioTa8Br"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6363214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726671AbeJJAP5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 20:15:57 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:33891 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726445AbeJJAP4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 20:15:56 -0400
Received: by mail-pl1-f196.google.com with SMTP id f18-v6so1137242plr.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 09:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=peF5BIpAOde4WiBCpsaCeG7SLfiQqYSE7xnzYkEUGZk=;
        b=dioTa8BrrrOjCUqjYBGlINUK/QJw/meaNA62vBgFcISsWB1Zsinz7lhw1BS+Wb07CM
         3OBWnCT/B1B//v0qcEARtIV4E2/gkfI0p+o6SH6+/DZCkkL5xaWdLWhDMDQ8EJ7+5w1p
         iQeFszlYjiXmJn/bXj98js04Ru6WVy4OpuIpU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=peF5BIpAOde4WiBCpsaCeG7SLfiQqYSE7xnzYkEUGZk=;
        b=qfT9mvZ28LN6Tf/lK6hj6DXtDqnsxr8Sx2aL+fJTvS31A5h4qdlVDMnPLdBAXhr/BE
         T9iLjclhYFB3MSs16SCGAo1KRVR7bhKndVILpa6OezJy35SlgCPrlWV5Evfa4m3wVygz
         kf17CCAS4moij5lCSk1FgbCZkC21QIl4GPV5CkYnkbThbBimnFi/DrT/m5vrSfCxt4kT
         ebZyLpDKZ/3wkRNqwWGB2ZDROxUjMgIFFZTzWf7FBMqvspdTTxCo9MuJNexx6J8amXIN
         b3tzj6uc3iJjzxebxc7TGOclCBVhvwq1DycAdGqsw2kpdZFauakKHq+f0Hf3Uj5CSQhi
         3USg==
X-Gm-Message-State: ABuFfoiCC5iy4a5LpoAdw+hcFSl8TR6tuJcNn8zHl0CBVzj3UpsN9Yfw
        cV7PlEhXlYDxHyNJwjvTBTIipw==
X-Google-Smtp-Source: ACcGV63m0OXLeaxQ6fwU6VpFSjkpLPYPMV1d/rCPe0Dpw/Mfwz7ytRO4wmXgVet4OkKfy7qm8r+2HA==
X-Received: by 2002:a17:902:ceb:: with SMTP id 98-v6mr19060701plt.331.1539104282722;
        Tue, 09 Oct 2018 09:58:02 -0700 (PDT)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id e9-v6sm20524179pgs.92.2018.10.09.09.58.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 09 Oct 2018 09:58:01 -0700 (PDT)
Date:   Tue, 9 Oct 2018 09:57:59 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Stephen Boyd <swboyd@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: Re: [PATCH 4.4 093/113] pinctrl: msm: Really mask level interrupts
 to prevent latching
Message-ID: <20181009165759.GB28399@tuxbook-pro>
References: <20181008175530.864641368@linuxfoundation.org>
 <20181008175536.405502473@linuxfoundation.org>
 <20181009063338.GA22218@flashbox>
 <20181009092359.GD19241@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181009092359.GD19241@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 09 Oct 02:23 PDT 2018, Greg Kroah-Hartman wrote:

> On Mon, Oct 08, 2018 at 11:33:38PM -0700, Nathan Chancellor wrote:
> > On Mon, Oct 08, 2018 at 08:31:34PM +0200, Greg Kroah-Hartman wrote:
> > > 4.4-stable review patch.  If anyone has any objections, please let me know.
> > > 
> > > ------------------
> > > 
> > > From: Stephen Boyd <swboyd@chromium.org>
> > > 
> > > [ Upstream commit b55326dc969ea2d704a008d9a97583b128f54f4f ]
> > > 
> > > The interrupt controller hardware in this pin controller has two status
> > > enable bits. The first "normal" status enable bit enables or disables
> > > the summary interrupt line being raised when a gpio interrupt triggers
> > > and the "raw" status enable bit allows or prevents the hardware from
> > > latching an interrupt into the status register for a gpio interrupt.
> > > Currently we just toggle the "normal" status enable bit in the mask and
> > > unmask ops so that the summary irq interrupt going to the CPU's
> > > interrupt controller doesn't trigger for the masked gpio interrupt.
> > > 
> > > For a level triggered interrupt, the flow would be as follows: the pin
> > > controller sees the interrupt, latches the status into the status
> > > register, raises the summary irq to the CPU, summary irq handler runs
> > > and calls handle_level_irq(), handle_level_irq() masks and acks the gpio
> > > interrupt, the interrupt handler runs, and finally unmask the interrupt.
> > > When the interrupt handler completes, we expect that the interrupt line
> > > level will go back to the deasserted state so the genirq code can unmask
> > > the interrupt without it triggering again.
> > > 
> > > If we only mask the interrupt by clearing the "normal" status enable bit
> > > then we'll ack the interrupt but it will continue to show up as pending
> > > in the status register because the raw status bit is enabled, the
> > > hardware hasn't deasserted the line, and thus the asserted state latches
> > > into the status register again. When the hardware deasserts the
> > > interrupt the pin controller still thinks there is a pending unserviced
> > > level interrupt because it latched it earlier. This behavior causes
> > > software to see an extra interrupt for level type interrupts each time
> > > the interrupt is handled.
> > > 
> > > Let's fix this by clearing the raw status enable bit for level type
> > > interrupts so that the hardware stops latching the status of the
> > > interrupt after we ack it. We don't do this for edge type interrupts
> > > because it seems that toggling the raw status enable bit for edge type
> > > interrupts causes spurious edge interrupts.
> > > 
> > > Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> > > Reviewed-by: Douglas Anderson <dianders@chromium.org>
> > > Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> > > Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> > > Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
> > > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > ---
> > >  drivers/pinctrl/qcom/pinctrl-msm.c |   24 ++++++++++++++++++++++++
> > >  1 file changed, 24 insertions(+)
> > > 
> > > --- a/drivers/pinctrl/qcom/pinctrl-msm.c
> > > +++ b/drivers/pinctrl/qcom/pinctrl-msm.c
> > > @@ -577,6 +577,29 @@ static void msm_gpio_irq_mask(struct irq
> > >  	spin_lock_irqsave(&pctrl->lock, flags);
> > >  
> > >  	val = readl(pctrl->regs + g->intr_cfg_reg);
> > > +	/*
> > > +	 * There are two bits that control interrupt forwarding to the CPU. The
> > > +	 * RAW_STATUS_EN bit causes the level or edge sensed on the line to be
> > > +	 * latched into the interrupt status register when the hardware detects
> > > +	 * an irq that it's configured for (either edge for edge type or level
> > > +	 * for level type irq). The 'non-raw' status enable bit causes the
> > > +	 * hardware to assert the summary interrupt to the CPU if the latched
> > > +	 * status bit is set. There's a bug though, the edge detection logic
> > > +	 * seems to have a problem where toggling the RAW_STATUS_EN bit may
> > > +	 * cause the status bit to latch spuriously when there isn't any edge
> > > +	 * so we can't touch that bit for edge type irqs and we have to keep
> > > +	 * the bit set anyway so that edges are latched while the line is masked.
> > > +	 *
> > > +	 * To make matters more complicated, leaving the RAW_STATUS_EN bit
> > > +	 * enabled all the time causes level interrupts to re-latch into the
> > > +	 * status register because the level is still present on the line after
> > > +	 * we ack it. We clear the raw status enable bit during mask here and
> > > +	 * set the bit on unmask so the interrupt can't latch into the hardware
> > > +	 * while it's masked.
> > > +	 */
> > > +	if (irqd_get_trigger_type(d) & IRQ_TYPE_LEVEL_MASK)
> > > +		val &= ~BIT(g->intr_raw_status_bit);
> > > +
> > >  	val &= ~BIT(g->intr_enable_bit);
> > >  	writel(val, pctrl->regs + g->intr_cfg_reg);
> > >  
> > > @@ -598,6 +621,7 @@ static void msm_gpio_irq_unmask(struct i
> > >  	spin_lock_irqsave(&pctrl->lock, flags);
> > >  
> > >  	val = readl(pctrl->regs + g->intr_cfg_reg);
> > > +	val |= BIT(g->intr_raw_status_bit);
> > >  	val |= BIT(g->intr_enable_bit);
> > >  	writel(val, pctrl->regs + g->intr_cfg_reg);
> > >  
> > > 
> > > 
> > 
> > Sigh, sorry, I caught this after I sent my initial all good email but
> > this commit breaks NFC on my Pixel 2 XL (toggle becomes greyed out and
> > apps that want to use it ask to enable it). I can't say why, I'm more
> > than happy to debug but I'm assuming it's some voodoo that Qualcomm has
> > done out of tree. I'll leave it up to you how to proceed given that I
> > can't run mainline :(

The patch corrects an issue that all level interrupts where delivered
twice, so if that breaks NFC then there's something quite broken in that
driver - or more likely something else broke.

Can you please do some level of investigation to see where in the stack
this broke, even if you can't run mainline.

> 
> Ugh, I hate the qualcomm changes...
> 

Noted...

Regards,
Bjorn

> Given the mess that all of the msm driver changes have, I'll go drop
> this patch from the stable tree as I don't want to deal with the
> fall-out for when people merge this to their device-specific trees.
> 
> thanks for testing and letting me know about this.
> 
