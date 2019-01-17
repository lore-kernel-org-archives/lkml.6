Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74E59C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 08:20:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42E4120856
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 08:20:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730585AbfAQIUE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 03:20:04 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:54561 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728621AbfAQIUE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 03:20:04 -0500
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1gk2u5-00071q-OB; Thu, 17 Jan 2019 09:19:57 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1gk2u4-00065B-Lm; Thu, 17 Jan 2019 09:19:56 +0100
Date:   Thu, 17 Jan 2019 09:19:56 +0100
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
Message-ID: <20190117081956.hpj4ewdihpwuoonz@pengutronix.de>
References: <1547194964-16718-1-git-send-email-yash.shah@sifive.com>
 <1547194964-16718-3-git-send-email-yash.shah@sifive.com>
 <20190115220046.etgbno6ymsux75dk@pengutronix.de>
 <CAJ2_jOEuU_=bpbVmdsq7FFEKEm_wHza-h7Hu8QmZ3BgsGgi-ng@mail.gmail.com>
 <20190116164640.mi3zjbhbhc6k5v7p@pengutronix.de>
 <alpine.DEB.2.21.9999.1901160909540.19681@viisi.sifive.com>
 <20190116172849.h5qdfa5wc3vaprbn@pengutronix.de>
 <alpine.DEB.2.21.9999.1901161015400.19681@viisi.sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <alpine.DEB.2.21.9999.1901161015400.19681@viisi.sifive.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Paul,

On Wed, Jan 16, 2019 at 11:29:35AM -0800, Paul Walmsley wrote:
> COMPILE_TEST made slightly more sense before the broad availability of 
> open-source soft cores, SoC integration, and IP; and before powerful, 
> inexpensive FPGAs and SoCs with FPGA fabrics were common.
> 
> Even back then, COMPILE_TEST was starting to look questionable.  IP blocks 
> from CPU- and SoC vendor-independent libraries, like DesignWare and the 
> Cadence IP libraries, were integrated on SoCs across varying CPU 
> architectures.  (Fortunately, looking at the tree, subsystem maintainers 
> with DesignWare drivers seem to have largely avoided adding architecture 
> or SoC-specific Kconfig restrictions there - and thus have also avoided 
> the need for COMPILE_TEST.)  If an unnecessary architecture Kconfig 
> dependency was added for a leaf driver, that Kconfig line would either 
> need to be patched out by hand, or if present, COMPILE_TEST would need to 
> be enabled.
> 
> This was less of a problem then.  There were very few FPGA Linux users, 
> and they were mostly working on internal proprietary projects. FPGAs that 
> could run Linux at a reasonable speed, including MMUs and FPUs, were 
> expensive or were missing good tool support.  So most FPGA Linux 
> development was restricted to ASIC vendors - the Samsungs, Qualcomms, 
> NVIDIAs of the world - for prototyping, and those FPGA platforms never 
> made it outside those companies.
> 
> The situation is different now.  The major FPGA vendors have inexpensive 
> FPGA SoCs with full-featured CPU hard macros.  The development boards can 
> be quite affordable (< USD 300 for the Xilinx Ultra96).  There are also 
> now open-source SoC HDL implementations - including MMUs, FPUs, and 
> peripherals like PWM and UART - for the conventional FPGA market.  These 
> can run at mid-1990's clock rates - slow by modern standards but still 
> quite usable.

In my eyes it's better to make a driver not possible to enable out of
the box than offering to enable it while it most probably won't be used.

People who configure their own kernel and distribution kernel
maintainers will thank you. (Well ok, they won't notice, so they won't
actually tell you, but anyhow.) I'm a member of the Debian kernel team
and I see how many config items there are that are not explicitly
handled for the various different kernel images. If they were restricted
using COMPILE_TEST to just be possible to enable on machines where it is
known (or at least likely) to make sense that would help. Also when I do
a kernel version bump for a machine with a tailored kernel running (say)
on an ARM/i.MX SoC, I could more easily be careful about the relevant
changes when doing oldconfig if I were not asked about a whole bunch of
drivers that are sure to be irrelevant.

And if someone synthesizes this sifive PWM into an FPGA that is
connected to an OMAP, changing

	depends RISCV || COMPILE_TEST

to something like

	depends RISCV || MACH_OMAP || COMPILE_TEST

is a relatively low effort. (Or we introduce a symbol that tells that
the machine has an FPGA and based on that enable the sifive pwm driver.)
And if a single person comes up saying they need that driver on OMAP
I happily support such a change.

> So or vendor-specific IP blocks that are unlikely to ever be reused by 
> anyone else, like the NVIDIA or TI PWM blocks, maybe there's still some 
> justification for COMPILE_TEST.  But for drivers for open-source, 
> SoC-independent peripheral IP blocks - or even for proprietary IP blocks 
> from library vendors like Synopsys or Cadence - like this PWM driver, we 
> shouldn't add unnecessary architecture, SoC vendor, or COMPILE_TEST 
> Kconfig dependencies.  They will just force users to patch the kernel or 
> enable COMPILE_TEST for kernels that are actually meant to run on real 
> hardware.

I understand that downside. I just think that people who synthesize an
open source core into their machine and then run Linux on it are very
likely easily able to patch the Kconfig file to enable the needed
drivers and tell us. Also if you compare the number of people who hit
this problem to the number of people to have to decide if they need
PWM_SIFIVE and don't need it, I guess there will be an at least
big two-digit factor between them. And as soon as this OMAP machine with
the FPGA becomes mainstream enough that tutorials pop up in the web that
give you a copy&paste template to put the sifive pwm into it, I expect
the dependency is already fixed.

Yes, there is no big harm if you enable this driver and don't need
it. But there are hundreds of drivers, and together they do hurt.
Also if you support a "newbie" configuring their first kernel, this is
much less frightening and gives a much better impression if at least
most of the presented options matter. Also it is easier to pick your pwm
driver if it's presented in a list of ten driver than if the list has
100 items.

There are reasons for both approaches and we need to weight the
respective interests. In my eyes it's clear which is the better
approach, but obviously YMMV. So if you choose to not restrict the
kconfig symbol, at least do it consciously with the arguments for the
other side in mind. And please also consider that your position is
subjective because you're a kernel developer and personally don't care
much if configuring a kernel is difficult to a newcomer.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
