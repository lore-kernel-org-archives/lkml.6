Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE75BC169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 14:10:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD5DC20844
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 14:10:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=onstation.org header.i=@onstation.org header.b="bAc8CZWG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730857AbfBFOKg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 09:10:36 -0500
Received: from onstation.org ([52.200.56.107]:58712 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727868AbfBFOKg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 09:10:36 -0500
Received: from localhost (c-98-239-145-235.hsd1.wv.comcast.net [98.239.145.235])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: masneyb)
        by onstation.org (Postfix) with ESMTPSA id 2B1E616B;
        Wed,  6 Feb 2019 14:10:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=onstation.org;
        s=default; t=1549462235;
        bh=2TnP9ESy9keJMQWbrG60ZSy6RI/z9u+rrSkver8OKPc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bAc8CZWGyqDSDctVSQ1ZC2TbYXGk+QV7Kdin8wIpAR14AUhPVDy5KUQsPT/Mj8rqG
         AVI1MXPe+Cwl+oiRR1LGU/NdGdg/DlWLtYBd8OYg1cUn6JTLug85p0CnkwFdKhmqWa
         PsMxM426YeKns/TEObY1iwJVyyxnbIXVN+rXEPjk=
Date:   Wed, 6 Feb 2019 09:10:34 -0500
From:   Brian Masney <masneyb@onstation.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <andy.gross@linaro.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Lee Jones <lee.jones@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Doug Anderson <dianders@chromium.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Nicolas Dechesne <nicolas.dechesne@linaro.org>,
        Niklas Cassel <niklas.cassel@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        linux-arm-msm@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Subject: Re: [PATCH 3/9] mfd: pm8xxx: convert to v2 irq interfaces to support
 hierarchical IRQ chips
Message-ID: <20190206141034.GA5833@basecamp>
References: <20190125162302.14036-1-masneyb@onstation.org>
 <20190125162302.14036-4-masneyb@onstation.org>
 <CACRpkdZMe+JEQOa1yBfOoAErrC41Q9rggwxNb=_uwq1m2QKWyw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACRpkdZMe+JEQOa1yBfOoAErrC41Q9rggwxNb=_uwq1m2QKWyw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

On Wed, Feb 06, 2019 at 02:07:52PM +0100, Linus Walleij wrote:
> > +struct pm_irq_data {
> > +       int num_irqs;
> > +       struct irq_chip *irq_chip;
> > +       void (*irq_handler)(struct irq_desc *desc);
> > +};
> > +
> >  struct pm_irq_chip {
> >         struct regmap           *regmap;
> >         spinlock_t              pm_irq_lock;
> >         struct irq_domain       *irqdomain;
> > -       unsigned int            num_irqs;
> >         unsigned int            num_blocks;
> >         unsigned int            num_masters;
> >         u8                      config[0];
> > -};
> > -
> > -struct pm_irq_data {
> > -       int num_irqs;
> > -       const struct irq_domain_ops  *irq_domain_ops;
> > -       void (*irq_handler)(struct irq_desc *desc);
> > +       const struct pm_irq_data *pm_irq_data;
> >  };
> 
> This doesn't work: the config[0] must be the tail element
> of the struct since we allocate dynamically the trailing
> config[] bytes.
> 
> As it looks now, the *pm_irq_data gets overwritten by
> the configs and it crashes.

Thank you for testing all of this on actual hardware. You can either
send out the little issues like this that need corrected and I'll
collect everything up, and send out a V2 once you are done with testing.
Or, you can just take my patches, incorporate the fixes, and add me
with a Co-developed-by tag to the relevant patches. Whatever is easier
for you. I assume that the latter approach may be easier since you're
already making the changes in your tree for testing.

Brian
