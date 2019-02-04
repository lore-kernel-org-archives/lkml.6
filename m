Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E40AC282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:20:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 078BF20823
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:20:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=onstation.org header.i=@onstation.org header.b="DfnzVihF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728563AbfBDKUL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 05:20:11 -0500
Received: from onstation.org ([52.200.56.107]:51478 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726928AbfBDKUL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 05:20:11 -0500
Received: from localhost (c-98-239-145-235.hsd1.wv.comcast.net [98.239.145.235])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: masneyb)
        by onstation.org (Postfix) with ESMTPSA id C5A0916B;
        Mon,  4 Feb 2019 10:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=onstation.org;
        s=default; t=1549275610;
        bh=rckaVT6R7xDIEVjIOcdulpCsDe5bZfAtOa9VdXpvmu4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DfnzVihFUVGAjlcbRCgpAtHbUQ5UIetVMzLSUm31+gPqIX6ES7DMuOW1gVAwBokEK
         3lFyDQCt225xvnnOAKgpe0sIex142f21Q+UsJzLsPo6l8FWlKYtq3zMKonldqBfAor
         S4pg9M/tyPSEy7yIxK2PYiqKIOtnHjTp5UEjhm4s=
Date:   Mon, 4 Feb 2019 05:20:09 -0500
From:   Brian Masney <masneyb@onstation.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linus.walleij@linaro.org, sboyd@kernel.org,
        bjorn.andersson@linaro.org, andy.gross@linaro.org,
        marc.zyngier@arm.com, tglx@linutronix.de, shawnguo@kernel.org,
        dianders@chromium.org, linux-gpio@vger.kernel.org,
        nicolas.dechesne@linaro.org, niklas.cassel@linaro.org,
        david.brown@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        thierry.reding@gmail.com, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 3/9] mfd: pm8xxx: convert to v2 irq interfaces to support
 hierarchical IRQ chips
Message-ID: <20190204102009.GA1887@basecamp>
References: <20190125162302.14036-1-masneyb@onstation.org>
 <20190125162302.14036-4-masneyb@onstation.org>
 <20190130132739.GE4701@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190130132739.GE4701@dell>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 30, 2019 at 01:27:39PM +0000, Lee Jones wrote:
> > @@ -303,6 +303,7 @@ static int pm8xxx_irq_set_type(struct irq_data *d, unsigned int flow_type)
> >  {
> >  	struct pm_irq_chip *chip = irq_data_get_irq_chip_data(d);
> >  	unsigned int pmirq = irqd_to_hwirq(d);
> > +	irq_flow_handler_t flow_handler;
> >  	int irq_bit;
> >  	u8 block, config;
> >  
> > @@ -316,6 +317,8 @@ static int pm8xxx_irq_set_type(struct irq_data *d, unsigned int flow_type)
> >  			chip->config[pmirq] &= ~PM_IRQF_MASK_RE;
> >  		if (flow_type & IRQF_TRIGGER_FALLING)
> >  			chip->config[pmirq] &= ~PM_IRQF_MASK_FE;
> > +
> > +		flow_handler = handle_edge_irq;
> >  	} else {
> >  		chip->config[pmirq] |= PM_IRQF_LVL_SEL;
> >  
> > @@ -323,8 +326,12 @@ static int pm8xxx_irq_set_type(struct irq_data *d, unsigned int flow_type)
> >  			chip->config[pmirq] &= ~PM_IRQF_MASK_RE;
> >  		else
> >  			chip->config[pmirq] &= ~PM_IRQF_MASK_FE;
> > +
> > +		flow_handler = handle_level_irq;
> >  	}
> >  
> > +	irq_set_handler_locked(d, flow_handler);
> > +
> 
> Why don't you save yourself 3 lines of code and a variable and just
> call irq_set_handler_locked() where you set flow_handler?
> 
> Apart from that nit, the code looks good to me.

OK.... I'll fix this up in v2.

I'll let this ssbi-gpio series sit on the list for a few weeks before I
send out v2. I ordered a Sony Xperia Z on eBay but it won't be here
until the beginning of March. I'd like to have this series tested on
actual hardware before this series is merged just to be sure it works
properly. If someone else has time to test it sooner, then please do.

Brian
