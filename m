Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751350AbeEDHEC (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 03:04:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:55152 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751172AbeEDHD6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 03:03:58 -0400
Date: Fri, 4 May 2018 15:03:40 +0800
From: Shawn Guo <shawnguo@kernel.org>
To: =?iso-8859-1?B?VPxyayw=?= Jan <Jan.Tuerk@emtrion.de>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>, Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Russell King <linux@armlinux.org.uk>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        LinuxArmKernelMailingListe <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v4 6/7] ARM: dts: Add support for emtrion emCON-MX6 series
Message-ID: <20180504070339.GS3443@dragon>
References: <20180420125108.14197-1-jan.tuerk@emtrion.com>
 <20180427132445.3458-1-jan.tuerk@emtrion.com>
 <20180427132445.3458-7-jan.tuerk@emtrion.com>
 <20180428031231.GB3693@dragon>
 <95F51F4B902CAC40AF459205F6322F01B83109E5C3@BMK019S01.emtrion.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <95F51F4B902CAC40AF459205F6322F01B83109E5C3@BMK019S01.emtrion.local>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 03, 2018 at 12:00:06PM +0200, Türk, Jan wrote:
> > > +/ {
> > > +   aliases {
> > > +           mmc0 = &usdhc3;
> > > +           mmc2 = &usdhc1;
> > > +           mmc1 = &usdhc2;
> > > +           mmc3 = &usdhc4;
> > > +           boardID = &boardID;
> >
> > Why do you need this boardID alias?
> I wanted to have a generic entry point to address the board-id on all CPU-modules with their different SoC's resulting in different devicetree paths.
> Also as it now has the generic "gpio@3a" name, there would be no other way in differencing the board Identifying GPIO-expander from an additionally
> attached one (except platform code etc.)
> With the alias every code could look up the information required over the alias path with the same piece of code.

Okay.  But no uppercase please.  Otherwise, you introduce the following
DTC warnings (with W=1 switch) we are trying to clean up.

 Warning (alias_paths): /aliases: aliases property name must include only lowercase and '-'

> >
> > > +   };

<snip>

> > > &pinctrl_nor_flash
> > > +            &pinctrl_usdhc2
> > > +            &pinctrl_spdif_out     &pinctrl_spdif_in
> > > +            &pinctrl_cpi1          &pinctrl_cpi2
> > > +           >;
> >
> > Again, please do not put consumer device specific pins in hog group.
> > Also, it's confusing to have the same pinctrl in both hog and consumer device
> > node, like pinctrl_nor_flash and pinctrl_usdhc2 here.
> 
> About pinctrl_nor_flash I fully agree, that's a mistake.
> pinctrl_usdhc2 is not connected on the avari, and therefore not enabled.
> As told before it is added to the Hog group to force the default pinmuxing without enabling the hardware itself.

If you want to do such default pinmuxing, please do it in your firmware.
We generally do not want to use hog group too much, because that makes
it difficult to find out which client devices consume which pins.

> 
> >
> > > +};

<snip>

> > > +&i2c1 {
> > > +   clock-frequency = <100000>;
> > > +   pinctrl-names = "default";
> > > +   pinctrl-0 = <&pinctrl_i2c1>;
> > > +   status = "okay";
> > > +
> > > +   rtc: rtc@68 {
> >
> > Is the label actually used?  If yes, I would suggest a more specific name like
> > ds1307.
> Really? Why should it be a generic name for "gpio" and "pmic" but not a generic name for an "rtc" chip?

I'm talking about label not node name.  That said I was suggesting
something like:

	ds1307: rtc@68

> 
> >
> > > +           compatible = "dallas,ds1307";
> > > +           reg = <0x68>;
> > > +   };

Shawn
