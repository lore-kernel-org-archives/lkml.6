Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57F46C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 17:28:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F1F2206C2
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 17:28:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727122AbfAPR25 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 12:28:57 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:33677 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725978AbfAPR24 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 12:28:56 -0500
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1gjozi-00057w-8r; Wed, 16 Jan 2019 18:28:50 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1gjozh-00069W-Fn; Wed, 16 Jan 2019 18:28:49 +0100
Date:   Wed, 16 Jan 2019 18:28:49 +0100
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Paul Walmsley <paul.walmsley@sifive.com>
Cc:     Yash Shah <yash.shah@sifive.com>,
        Palmer Dabbelt <palmer@sifive.com>, linux-pwm@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Thierry Reding <thierry.reding@gmail.com>, robh+dt@kernel.org,
        mark.rutland@arm.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sachin Ghadi <sachin.ghadi@sifive.com>
Subject: Re: [PATCH 2/2] pwm: sifive: Add a driver for SiFive SoC PWM
Message-ID: <20190116172849.h5qdfa5wc3vaprbn@pengutronix.de>
References: <1547194964-16718-1-git-send-email-yash.shah@sifive.com>
 <1547194964-16718-3-git-send-email-yash.shah@sifive.com>
 <20190115220046.etgbno6ymsux75dk@pengutronix.de>
 <CAJ2_jOEuU_=bpbVmdsq7FFEKEm_wHza-h7Hu8QmZ3BgsGgi-ng@mail.gmail.com>
 <20190116164640.mi3zjbhbhc6k5v7p@pengutronix.de>
 <alpine.DEB.2.21.9999.1901160909540.19681@viisi.sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <alpine.DEB.2.21.9999.1901160909540.19681@viisi.sifive.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 16, 2019 at 09:18:45AM -0800, Paul Walmsley wrote:
> On Wed, 16 Jan 2019, Uwe Kleine-König wrote:
> 
> > On Wed, Jan 16, 2019 at 04:40:42PM +0530, Yash Shah wrote:
> > > On Wed, Jan 16, 2019 at 3:30 AM Uwe Kleine-König
> > > <u.kleine-koenig@pengutronix.de> wrote:
> > > > On Fri, Jan 11, 2019 at 01:52:44PM +0530, Yash Shah wrote:
> > > > > diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> > > > > index a8f47df..3bcaf6a 100644
> > > > > --- a/drivers/pwm/Kconfig
> > > > > +++ b/drivers/pwm/Kconfig
> > > > > @@ -380,6 +380,16 @@ config PWM_SAMSUNG
> > > > >         To compile this driver as a module, choose M here: the module
> > > > >         will be called pwm-samsung.
> > > > >
> > > > > +config PWM_SIFIVE
> > > > > +     tristate "SiFive PWM support"
> > > > > +     depends on OF
> > > > > +     depends on COMMON_CLK
> > > >
> > > > I'd say add:
> > > >
> > > >         depends on MACH_SIFIVE || COMPILE_TEST
> > > >
> > > > (I guess "MACH_SIFIVE" is wrong, but I assume you get what I mean.)
> > > 
> > > As of now, MACH_SIFIVE/ARCH_SIFIVE isn't available.
> > > @Paul, Do you have any comments on this?
> > 
> > If this is not going to be available at least protect it by
> > 
> > 	depends RISCV || COMPILE_TEST
> 
> There's nothing RISC-V or SiFive SoC-specific about this driver or IP 
> block.  The HDL for this IP block is open-source and posted on Github.  
> The IP block and driver would work unchanged on an ARM or MIPS SoC, and in 
> fact, SiFive does design ARM-based SoCs as well.  Likewise, any other SoC 
> vendor could take the HDL for this IP block from the git tree and 
> implement it on their own SoC.
> 
> More generally: it's a basic principle of Linux device drivers that they 
> should be buildable for any architecture.  The idea here is to prevent 
> developers from burying architecture or SoC-specific hacks into the 
> driver.  So there shouldn't be any architecture or SoC-specific code in 
> any device driver, unless it's abstracted in some way - ideally through a 
> common framework.
> 
> So from this point of view, neither "depends MACH_SIFIVE" nor "depends 
> RISCV" would be appropriate.  Similarly, the equivalents for other 
> architectures (e.g. "ARCH_ARM") or SoC manufacturers (e.g., 
> "MACH_SAMSUNG") wouldn't be appropriate for any generic IP block device 
> driver like this one.

The dependency serves two purposes:

 a) ensure that the build requirements are fulfilled.
 b) restrict configuration to actually existing machines

When considering b) it doesn't make sense to enable the driver for (say)
a machine that is powered by an ARM SoC by TI. If you still want to
compile test the sifive driver for ARM, enable COMPILE_TEST. That's what
this symbol is there for.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
