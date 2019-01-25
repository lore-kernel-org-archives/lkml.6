Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B9CDC282C2
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 21:21:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 648ED2184C
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 21:21:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729414AbfAYVVf convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 16:21:35 -0500
Received: from mail.bootlin.com ([62.4.15.54]:33791 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726179AbfAYVVf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 16:21:35 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 55484207B2; Fri, 25 Jan 2019 22:21:32 +0100 (CET)
Received: from localhost (lfbn-1-10718-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.bootlin.com (Postfix) with ESMTPSA id 113C620397;
        Fri, 25 Jan 2019 22:21:32 +0100 (CET)
Date:   Fri, 25 Jan 2019 22:21:32 +0100
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     Chen-Yu Tsai <wens@csie.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        linux-amarula@amarulasolutions.com
Subject: Re: [PATCH v5 07/17] drm/sun4i: sun6i_mipi_dsi: Refactor vertical
 video start delay
Message-ID: <20190125212132.ea2iq6tsgyawkemx@flea>
References: <CAMty3ZBb8byOwh=_W83Ta0Dse1qkoqccOeaBEY9oHPaxDxe9QA@mail.gmail.com>
 <20190108085829.clianbtjovu3oieq@flea>
 <CAMty3ZC9OQtwT-iH=S1LhHsBPc_jFKGAnCYYeR9nuKuDWSKLQw@mail.gmail.com>
 <20190112164319.whr7gwvl4oux5svz@flea>
 <CAMty3ZD8X9KmHjUtAo-+Y83a2j8NF3DjM9Yr3LPMxOvQ8kOV7g@mail.gmail.com>
 <20190116191756.ajzzaga43srk77dk@flea>
 <CAMty3ZCw8itG=nizA5E218HT5kg=-xDzLmShF51vRh4ENYKuBA@mail.gmail.com>
 <CAMty3ZDbTgo3EY12VC0X_XuaRobQXvHx=Y6-_sgSWxDm1ZXbHQ@mail.gmail.com>
 <20190122111118.db7bqppop4basxd7@flea>
 <CAMty3ZA0rhpQbumoVOGQRGDG0-iU84wcpUN2Q=ooT4iRD6y5hQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <CAMty3ZA0rhpQbumoVOGQRGDG0-iU84wcpUN2Q=ooT4iRD6y5hQ@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 22, 2019 at 05:21:08PM +0530, Jagan Teki wrote:
> On Tue, Jan 22, 2019 at 4:41 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> >
> > On Fri, Jan 18, 2019 at 09:14:19PM +0530, Jagan Teki wrote:
> > > On Thu, Jan 17, 2019 at 10:02 AM Jagan Teki <jagan@amarulasolutions.com> wrote:
> > > >
> > > > On Thu, Jan 17, 2019 at 12:48 AM Maxime Ripard
> > > > <maxime.ripard@bootlin.com> wrote:
> > > > >
> > > > > On Sun, Jan 13, 2019 at 01:07:41AM +0530, Jagan Teki wrote:
> > > > > > > > > > > Again, I cannot help you without the datasheet for the panels you're
> > > > > > > > > > > trying to submit.
> > > > > > > > > >
> > > > > > > > > > The panel bound with Sitronix ST7701 IC
> > > > > > > > > > http://www.startek-lcd.com/res/starteklcd/pdres/201705/20170512144242904.pdf
> > > > > > > > >
> > > > > > > > > It's the controller, not the panel
> > > > > > > >
> > > > > > > > As I said before, the datasheet of that panel doesn't have any
> > > > > > > > information except electrical characteristics and used IC which is
> > > > > > > > ST7701.
> > > > > > > >
> > > > > > > > I have one more panel, which is from Bananapi, S070WV20-CT16 ICN621
> > > > > > > > please find the attachment for the same.
> > > > > > > >
> > > > > > > > Here is some more details of the same.
> > > > > > > >
> > > > > > > > https://github.com/yesnoandor/x300/blob/master/kernel/arch/arm/boot/dts/erobbing/x300/x300.dtsi#L81
> > > > > > > > https://github.com/wxzed/Raspberry_5MIPI_Display/blob/master/I2C_Slave/USER/main.c#L15
> > > > > > > >
> > > > > > > > https://github.com/eliot-shao/qcom/blob/master/icn6211_cxn0102/kernel/drivers/video/msm/mdss/mdss_i2c_interface.c#L152
> > > > > > > > matches timings for
> > > > > > > > https://github.com/eliot-shao/qcom/blob/master/icn6211_cxn0102/kernel/arch/arm/boot/dts/qcom/dsi-mipi-2-rgb_1280p_video.dtsi#L20
> > > > > > > >
> > > > > > > > https://github.com/zestroly/micromat/blob/master/test/raspberry/ICN6211.cpp#L169
> > > > > > >
> > > > > > > Where did you get the timings from then?
> > > > > >
> > > > > > You mean drm_mode timings, the same panel with RGB available in
> > > > > > panel-simple[1], and dsi driver in Mailing list[2] and actual DSI
> > > > > > sequence commands from BSP[3]
> > > > > >
> > > > > > [1] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/drivers/gpu/drm/panel/panel-simple.c?id=7ad8b41cd8f5c2842646d01cdd576663caee04a7
> > > > > > [2] https://patchwork.kernel.org/patch/10680331/
> > > > > > [3] https://github.com/BPI-SINOVOIP/BPI-M64-bsp/blob/master/linux-sunxi/drivers/video/sunxi/disp2/disp/lcd/S070WV20_MIPI_RGB.c
> > > > >
> > > > > So you had no reliable source for the timings then? How do you know if
> > > > > all your patches that are timing related are right then?
> > > >
> > > > I don't understand your point, or may be I confused with many links
> > > > that I attached in previous mail.
> > > >
> > > > 1. Patch for same panel timings are already in Mainline that was
> > > > tested on one of the board. [1]
> > > > 2. Driver from AW, released bsp from BPI-M64-bsp [3]
> > > >
> > > > Do you think the above two points are not valid sources?
> > >
> > > fyi, the panel datasheet attached in above mail has timing information.
> >
> > Do you have a page number?
> 
> Page 4
> 5.2 Interface Timings

Which datasheet are we talking about here?

The only one I've seen is the Sitronix IC's and the page 4 is the summary.

Maxime

-- 
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
