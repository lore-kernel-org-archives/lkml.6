Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33A2CC1B0E3
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 19:42:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5AD420873
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 19:42:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5AD420873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389813AbeGKTsG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 15:48:06 -0400
Received: from mail.bootlin.com ([62.4.15.54]:38544 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732848AbeGKTsG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 15:48:06 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 4662820940; Wed, 11 Jul 2018 21:42:14 +0200 (CEST)
Received: from localhost (unknown [88.191.26.124])
        by mail.bootlin.com (Postfix) with ESMTPSA id 83BCB2097D;
        Wed, 11 Jul 2018 21:41:47 +0200 (CEST)
Date:   Wed, 11 Jul 2018 21:41:47 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Shawn Guo <shawnguo@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] ARM: at91: remove unnecessary
 of_platform_default_populate calls
Message-ID: <20180711194147.GZ16084@piout.net>
References: <20180619214020.18608-1-robh@kernel.org>
 <CAL_JsqLfnSOgOMdaJU3Q4h5_PGnNgd4rx+vKXdFVZnNEo6+JZA@mail.gmail.com>
 <20180711161443.GY16084@piout.net>
 <CAL_JsqKzv4=Vpej3kbjMBkFFOpJE_KQRgYr=Svftd_xs-Bj3-g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_JsqKzv4=Vpej3kbjMBkFFOpJE_KQRgYr=Svftd_xs-Bj3-g@mail.gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/07/2018 12:13:17-0600, Rob Herring wrote:
> On Wed, Jul 11, 2018 at 10:15 AM Alexandre Belloni
> <alexandre.belloni@bootlin.com> wrote:
> >
> > Hi,
> >
> > On 09/07/2018 09:50:47-0600, Rob Herring wrote:
> > > On Tue, Jun 19, 2018 at 3:40 PM Rob Herring <robh@kernel.org> wrote:
> > > >
> > > > The DT core will call of_platform_default_populate, so it is not
> > > > necessary for machine specific code to call it unless there are custom
> > > > match entries, auxdata or parent device. Neither of those apply here, so
> > > > remove the call.
> > > >
> > > > Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
> > > > Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
> > > > Cc: linux-arm-kernel@lists.infradead.org
> > > > Signed-off-by: Rob Herring <robh@kernel.org>
> > > > ---
> > > >  arch/arm/mach-at91/at91rm9200.c | 5 -----
> > > >  arch/arm/mach-at91/at91sam9.c   | 5 -----
> > > >  arch/arm/mach-at91/sama5.c      | 5 -----
> > > >  3 files changed, 15 deletions(-)
> > >
> > > Ping?
> > >
> >
> > This breaks the platform in two different ways:
> >  - PM is not working anymore because of the missing SRAM node
> >  - the pinctrl driver fails to probe and so many drivers are
> >    deferring the probe forever
> >
> > Relevant messages (once the earlycon crap is removed to let earlyprintk
> > do its job):
> >
> > at91_pm_sram_init: failed to find sram device!
> > AT91: PM not supported, due to no SRAM allocated
> 
> So the at91_pm_sram_init function tries to get SRAM platform device,
> but it doesn't exist yet. Of course, that is fragile because while the
> device may exist, it's just luck that it's driver has probed already.
> Would using .init_late hook instead of .init_machine work for you?
> 
> Ideally, couldn't much of this code be converted to a driver? It's a
> bit strange for initcall code to have a driver dependency.
> 

.init_late seems to work after testing quickly

You probably didn't see it because they still have a soc_device parent
but Arnd wanted us to remove it so it is gone.

> >
> > pinctrl-at91 ahb:apb:pinctrl@fc06a000: you need to specify at least one gpio-controller
> > pinctrl-at91: probe of ahb:apb:pinctrl@fc06a000 failed with error -22
> 
> So this one has the strange dependency that the child nodes probe
> before the parent node. That's backwards. Probe order is probably
> changing from link order (all the devices are created before drivers
> register) to device creation order. I think the fix is the pinctrl
> driver should just count the gpio child nodes rather than relying on
> aliases (which I'm not a fan of either). I can write a patch to do
> that.

I'll let you do that.

-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
