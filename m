Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81D40C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 12:42:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C72E2086D
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 12:42:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=onstation.org header.i=@onstation.org header.b="unWnQRzA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727777AbfARMmX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 07:42:23 -0500
Received: from onstation.org ([52.200.56.107]:59690 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727708AbfARMmX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 07:42:23 -0500
Received: from localhost (c-98-239-145-235.hsd1.wv.comcast.net [98.239.145.235])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: masneyb)
        by onstation.org (Postfix) with ESMTPSA id 42F1F14D;
        Fri, 18 Jan 2019 12:42:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=onstation.org;
        s=default; t=1547815342;
        bh=lvgYTUkIJwuxIngth9Zpmb590KKOWErzxArQCZSRYTU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=unWnQRzA5yRAMhpIN5ASgklVtC6SODpeEQ+j+n1teVuMlh0Pbse9A5BLwNnF9S2U+
         Sx/XfdOGN1VhZjAeLz4qnXjBhUoz5kz8WwRJ0Pm1vXiThuhKcDlDEZ+H6E6n6pfbvs
         FWlOI5HRmpQomzvOIi/sEI7K5xxagnGrny3GKctU=
Date:   Fri, 18 Jan 2019 07:42:21 -0500
From:   Brian Masney <masneyb@onstation.org>
To:     Marc Zyngier <marc.zyngier@arm.com>
Cc:     linus.walleij@linaro.org, sboyd@kernel.org,
        bjorn.andersson@linaro.org, andy.gross@linaro.org,
        shawnguo@kernel.org, dianders@chromium.org,
        linux-gpio@vger.kernel.org, nicolas.dechesne@linaro.org,
        niklas.cassel@linaro.org, david.brown@linaro.org,
        robh+dt@kernel.org, mark.rutland@arm.com, thierry.reding@gmail.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v5 07/14] qcom: spmi-gpio: add support for hierarchical
 IRQ chip
Message-ID: <20190118124221.GB32143@basecamp>
References: <20190117003234.22127-1-masneyb@onstation.org>
 <20190117003234.22127-8-masneyb@onstation.org>
 <e9234c48-9fce-1ec4-48f1-dff134559eed@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e9234c48-9fce-1ec4-48f1-dff134559eed@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

On Thu, Jan 17, 2019 at 11:32:01AM +0000, Marc Zyngier wrote:
> >  static int pmic_gpio_to_irq(struct gpio_chip *chip, unsigned pin)
> >  {
> >  	struct pmic_gpio_state *state = gpiochip_get_data(chip);
> > -	struct pmic_gpio_pad *pad;
> > +	struct irq_fwspec fwspec;
> >  
> > -	pad = state->ctrl->desc->pins[pin].drv_data;
> > +	fwspec.fwnode = state->fwnode;
> > +	fwspec.param_count = 2;
> > +	fwspec.param[0] = pin + PMIC_GPIO_PHYSICAL_OFFSET;
> > +	fwspec.param[1] = IRQ_TYPE_NONE;
> 
> In my experience, IRQ_TYPE_NONE is rarely a good thing, unless you
> expect the trigger information to be found by some other mean. I guess
> that's one of the reasons why everything falls back to level in the SPMI
> driver...

I'm not sure how to determine what trigger to put here. I thought that
it would be up to the caller of request_any_context_irq() to explicitly
set the expected trigger type when a GPIO is used, which will overwrite
IRQ_TYPE_NONE with the proper trigger type.

For example, I've tested the hierarchical IRQ domains with gpio-keys and
when the gpio property is used, devm_request_any_context_irq() is called
with the flags IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING. This calls
__setup_irq(), which will call irq_set_type() and overwrite the trigger
type.

irq_set_type() is only called when the IRQ is not shared, so I'm not
sure if this would work as expected with a shared IRQ.

Brian
