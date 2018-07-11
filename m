Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 645D6C5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 16:15:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2586720C0C
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 16:15:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2586720C0C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387793AbeGKQUU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 12:20:20 -0400
Received: from mail.bootlin.com ([62.4.15.54]:33909 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726457AbeGKQUU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 12:20:20 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 18D182069C; Wed, 11 Jul 2018 18:15:16 +0200 (CEST)
Received: from localhost (242.171.71.37.rev.sfr.net [37.71.171.242])
        by mail.bootlin.com (Postfix) with ESMTPSA id E965920766;
        Wed, 11 Jul 2018 18:14:43 +0200 (CEST)
Date:   Wed, 11 Jul 2018 18:14:43 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] ARM: at91: remove unnecessary
 of_platform_default_populate calls
Message-ID: <20180711161443.GY16084@piout.net>
References: <20180619214020.18608-1-robh@kernel.org>
 <CAL_JsqLfnSOgOMdaJU3Q4h5_PGnNgd4rx+vKXdFVZnNEo6+JZA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_JsqLfnSOgOMdaJU3Q4h5_PGnNgd4rx+vKXdFVZnNEo6+JZA@mail.gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 09/07/2018 09:50:47-0600, Rob Herring wrote:
> On Tue, Jun 19, 2018 at 3:40 PM Rob Herring <robh@kernel.org> wrote:
> >
> > The DT core will call of_platform_default_populate, so it is not
> > necessary for machine specific code to call it unless there are custom
> > match entries, auxdata or parent device. Neither of those apply here, so
> > remove the call.
> >
> > Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
> > Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
> > Cc: linux-arm-kernel@lists.infradead.org
> > Signed-off-by: Rob Herring <robh@kernel.org>
> > ---
> >  arch/arm/mach-at91/at91rm9200.c | 5 -----
> >  arch/arm/mach-at91/at91sam9.c   | 5 -----
> >  arch/arm/mach-at91/sama5.c      | 5 -----
> >  3 files changed, 15 deletions(-)
> 
> Ping?
> 

This breaks the platform in two different ways:
 - PM is not working anymore because of the missing SRAM node
 - the pinctrl driver fails to probe and so many drivers are
   deferring the probe forever

Relevant messages (once the earlycon crap is removed to let earlyprintk
do its job):

at91_pm_sram_init: failed to find sram device!
AT91: PM not supported, due to no SRAM allocated

pinctrl-at91 ahb:apb:pinctrl@fc06a000: you need to specify at least one gpio-controller
pinctrl-at91: probe of ahb:apb:pinctrl@fc06a000 failed with error -22
gpio-at91 fc06a000.gpio: at address (ptrval)
gpio-at91 fc06b000.gpio: at address (ptrval)
gpio-at91 fc06c000.gpio: at address (ptrval)
gpio-at91 fc068000.gpio: at address (ptrval)
gpio-at91 fc06d000.gpio: at address (ptrval)

at91_i2c f8014000.i2c: could not find pctldev for node /ahb/apb/pinctrl@fc06a000/i2c0/i2c0-0, deferring probe
atmel_usart f8004000.serial: could not find pctldev for node /ahb/apb/pinctrl@fc06a000/uart0/uart0-0, deferring probe
atmel_usart fc00c000.serial: could not find pctldev for node /ahb/apb/pinctrl@fc06a000/usart3/usart3-0, deferring probe
atmel_usart fc010000.serial: could not find pctldev for node /ahb/apb/pinctrl@fc06a000/usart4/usart4-0, deferring probe
atmel_spi f8010000.spi: could not find pctldev for node /ahb/apb/pinctrl@fc06a000/spi0/spi0-0, deferring probe
atmel_spi fc018000.spi: could not find pctldev for node /ahb/apb/pinctrl@fc06a000/spi1/spi1-0, deferring probe
macb f8020000.ethernet: could not find pctldev for node /ahb/apb/pinctrl@fc06a000/macb0/macb0_rmii-0, deferring probe
atmel_mci fc000000.mmc: could not find pctldev for node /ahb/apb/pinctrl@fc06a000/mmc1/mmc1_clk_cmd_dat0, deferring probe
at91_adc fc034000.adc: could not find pctldev for node /ahb/apb/pinctrl@fc06a000/adc0/adc0_ad0, deferring probe
gpio-keys gpio_keys: could not find pctldev for node /ahb/apb/pinctrl@fc06a000/board/key_gpio_0, deferring probe


-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
