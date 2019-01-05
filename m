Return-Path: <SRS0=xVxK=PN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81997C43387
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 12:08:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 465C72070C
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 12:08:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=onstation.org header.i=@onstation.org header.b="hlHzH2QT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726242AbfAEMIq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Jan 2019 07:08:46 -0500
Received: from onstation.org ([52.200.56.107]:42688 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726100AbfAEMIq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jan 2019 07:08:46 -0500
Received: from localhost (c-98-239-145-235.hsd1.wv.comcast.net [98.239.145.235])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: masneyb)
        by onstation.org (Postfix) with ESMTPSA id A9A6411;
        Sat,  5 Jan 2019 12:08:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=onstation.org;
        s=default; t=1546690124;
        bh=hOgbm0+M8TyF9n+7N36IsKhpLt3KMQz//jbn2TkuwdA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hlHzH2QTloBF7G7nzFh6l4JxzIe1lQesojy36IPqXNqCVj409/mwJBHYNrkDNtDn4
         /XK0xDJlbrblqQU7XRKSEGyoxx04r7Pqd5tJ3ADPb2/Vsla35zBeBgTNg4vwN2LedU
         p1WFD32M978owNKFedBSvbyIAUSjFiF+1iYSaRL8=
Date:   Sat, 5 Jan 2019 07:08:44 -0500
From:   Brian Masney <masneyb@onstation.org>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     andy.gross@linaro.org, bjorn.andersson@linaro.org,
        linus.walleij@linaro.org, marc.zyngier@arm.com,
        shawnguo@kernel.org, dianders@chromium.org,
        linux-gpio@vger.kernel.org, nicolas.dechesne@linaro.org,
        niklas.cassel@linaro.org, david.brown@linaro.org,
        robh+dt@kernel.org, mark.rutland@arm.com, thierry.reding@gmail.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 2/3] qcom: spmi-gpio: add support for hierarchical IRQ
 chip
Message-ID: <20190105120844.GA2298@basecamp>
References: <20181229114755.8711-1-masneyb@onstation.org>
 <20181229114755.8711-3-masneyb@onstation.org>
 <154656291378.15366.8661245319757182529@swboyd.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <154656291378.15366.8661245319757182529@swboyd.mtv.corp.google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 03, 2019 at 04:48:33PM -0800, Stephen Boyd wrote:
> I'd think we want the interrupt-cells for the pmic gpio controller to be
> 2 cells (pin and flags) instead of 4 like you have here to match the
> parent interrupt specifier.

I originally went with 4 interrupt cells for spmi-gpio to match the
number of cells on the parent (spmi-arb). From qcom-msm8974.dtsi:

spmi_bus: spmi@fc4cf000 {
	compatible = "qcom,spmi-pmic-arb";
	interrupt-controller;
	#interrupt-cells = <4>;
	...
};

I agree that we should go with 2 cells for spmi-gpio.

> I also seem to recall that GPIO numbering starts from 1 instead of
> 0, so please keep that in mind.

I'm using the pinctrl numbering, which is zero based.

/ # head /sys/kernel/debug/pinctrl/fc4cf000.spmi\:pm8941@0\:gpios@c000/pins 
registered pins: 36
pin 0 (gpio1) 
pin 1 (gpio2) 
pin 2 (gpio3) 
pin 3 (gpio4) 
pin 4 (gpio5) 
pin 5 (gpio6) 
pin 6 (gpio7) 
pin 7 (gpio8) 
pin 8 (gpio9) 

> > +static int pmic_gpio_irq_activate(struct irq_domain *domain,
> > +                                 struct irq_data *data, bool reserve)
> > +{
> > +       struct pmic_gpio_state *state = domain->host_data;
> 
> How about just storing the gpiochip in the domain->host_data?
> 
> > +
> > +       return gpiochip_lock_as_irq(&state->chip, data->hwirq);
> > +}
> > +
> > +static void pmic_gpio_irq_deactivate(struct irq_domain *domain,
> > +                                    struct irq_data *data)
> > +{
> > +       struct pmic_gpio_state *state = domain->host_data;
> > +
> > +       gpiochip_unlock_as_irq(&state->chip, data->hwirq);
> > +}
> > +
> 
> Then these could be generic gpiolib APIs?

I tried this:

static const struct irq_domain_ops pmic_gpio_domain_ops = {
        .activate = gpiochip_lock_as_irq,
        .alloc = pmic_gpio_domain_alloc,
        .deactivate = gpiochip_unlock_as_irq,
        .free = irq_domain_free_irqs_common,
        .translate = pmic_gpio_domain_translate,
};

But get an incompatible pointer types compiler error.

drivers/pinctrl/qcom/pinctrl-spmi-gpio.c:1003:14: error: initialization of
‘int (*)(struct irq_domain *, struct irq_data *, bool)’ {aka ‘int
(*)(struct irq_domain *, struct irq_data *, _Bool)’} from incompatible
pointer type ‘int (*)(struct gpio_chip *, unsigned int)’
[-Werror=incompatible-pointer-types]


> > +static int pmic_gpio_domain_alloc(struct irq_domain *domain, unsigned int virq,
> > +                                 unsigned int nr_irqs, void *data)
> > +{
> > +       struct pmic_gpio_state *state = domain->host_data;
> > +       struct irq_fwspec *fwspec = data;
> > +       struct irq_fwspec parent_fwspec;
> > +       irq_hw_number_t hwirq;
> > +       unsigned int type;
> > +       int ret, i;
> > +
> > +       ret = pmic_gpio_domain_translate(domain, fwspec, &hwirq, &type);
> > +       if (ret)
> > +               return ret;
> > +
> > +       for (i = 0; i < nr_irqs; i++)
> > +               irq_domain_set_info(domain, virq + i, hwirq + i,
> > +                                   &pmic_gpio_irq_chip, state,
> > +                                   handle_level_irq, NULL, NULL);
> 
> Does almost nobody pass a name for that last parameter?

I see 26 callers to irq_domain_set_info() outside this patch set and
only 3 of them actually set a name. I'm open to suggestions for what to
put here.

Brian
