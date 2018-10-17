Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92D78ECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 15:52:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 536F72152F
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 15:52:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 536F72152F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727837AbeJQXsx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 19:48:53 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:46883 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727013AbeJQXsx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 19:48:53 -0400
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1gCo7d-0003Us-62; Wed, 17 Oct 2018 17:52:33 +0200
Message-ID: <1539791552.4729.13.camel@pengutronix.de>
Subject: Re: [PATCHv2] reset: socfpga: add an early reset driver for SoCFPGA
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Dinh Nguyen <dinguyen@kernel.org>
Cc:     linux-kernel@vger.kernel.org, marex@denx.de
Date:   Wed, 17 Oct 2018 17:52:32 +0200
In-Reply-To: <5944ac0a-ba43-43fa-9985-c84644023ae8@kernel.org>
References: <20181011135241.13614-1-dinguyen@kernel.org>
         <1539787061.4729.11.camel@pengutronix.de>
         <5944ac0a-ba43-43fa-9985-c84644023ae8@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dinh,

On Wed, 2018-10-17 at 10:02 -0500, Dinh Nguyen wrote:
[...]
> > > diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
> > > index 13d28fdbdbb5..f10de5ce4753 100644
> > > --- a/drivers/reset/Kconfig
> > > +++ b/drivers/reset/Kconfig
> > > @@ -100,7 +100,7 @@ config RESET_QCOM_AOSS
> > >  
> > >  config RESET_SIMPLE
> > >  	bool "Simple Reset Controller Driver" if COMPILE_TEST
> > > -	default ARCH_SOCFPGA || ARCH_STM32 || ARCH_STRATIX10 || ARCH_SUNXI || ARCH_ZX || ARCH_ASPEED
> > > +	default ARCH_STM32 || ARCH_STRATIX10 || ARCH_SUNXI || ARCH_ZX || ARCH_ASPEED
> > >  	help
> > >  	  This enables a simple reset controller driver for reset lines that
> > >  	  that can be asserted and deasserted by toggling bits in a contiguous,
> > > @@ -119,6 +119,13 @@ config RESET_STM32MP157
> > >  	help
> > >  	  This enables the RCC reset controller driver for STM32 MPUs.
> > >  
> > > +config RESET_SOCFPGA
> > > +	bool "SoCFPGA Reset Driver" if COMPILE_TEST && !ARCH_SOCFPGA
> > > +	default ARCH_SOCFPGA && !ARCH_STRATIX10
> > > +	select RESET_SIMPLE
[...]
> > > +static const struct of_device_id socfpga_early_reset_dt_ids[] __initconst = {
> > > +	{ .compatible = "altr,rst-mgr", },
> > 
> > That doesn't seem right. If you don't remove the altr,rst-mgr compatible
> > from reset-simple.c anymore, we suddenly have two device drivers for the
> > same compatible.
> 
> You're right, and that's why I am not building reset-simple for
> ARCH_SOCFPGA anymore. I am only building reset-simple for ARCH_STRATIX10.

RESET_SOCFPGA still selects RESET_SIMPLE, so reset-simple should be
built in both cases.

> > (Also I liked removing altr,modrst-offset from reset-simple.c)
> 
> I can remove it since it's just 0x20 of ARCH_STRATIX10.

As long as there is another driver handling that compatible,
altr,rst-mgr support should be removed from the platform driver in
reset-simple.c altogether.

> > Would there be any issue with calling socfpga_reset_init() on Stratix10
> > as well?
> 
> I don't see any place in the arm64 common code where I can do this.

This is one of the reasons why there should always be a SoC specific
compatible as well as the generic one. If the device trees contained
something like

	compatible = "altr,socfpga-a10-rst-mgr", "altr,rst-mgr";

and

	compatible = "altr,socfpga-s10-rst-mgr", "altr,rst-mgr";

we could now easily match the specific compatibles for the different
cases (s10 in reset-simple, a10 in reset-socfpga).

I suppose one way to handle this with the shared compatible would be to
add a platform driver for s10 to reset-socfpga.c, but register it only
if socfpga_reset_init() was not called earlier.

regards
Philipp
