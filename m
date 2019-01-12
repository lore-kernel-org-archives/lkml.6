Return-Path: <SRS0=UXoZ=PU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD0F4C43612
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 16:43:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B036C2133F
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 16:43:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726387AbfALQnd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Jan 2019 11:43:33 -0500
Received: from mail.bootlin.com ([62.4.15.54]:50179 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725842AbfALQnc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jan 2019 11:43:32 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 11A352074D; Sat, 12 Jan 2019 17:43:30 +0100 (CET)
Received: from localhost (lfbn-1-10718-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.bootlin.com (Postfix) with ESMTPSA id CEAFE20714;
        Sat, 12 Jan 2019 17:43:19 +0100 (CET)
Date:   Sat, 12 Jan 2019 17:43:19 +0100
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
Message-ID: <20190112164319.whr7gwvl4oux5svz@flea>
References: <20181210161729.29720-1-jagan@amarulasolutions.com>
 <20181210161729.29720-8-jagan@amarulasolutions.com>
 <20181211164900.wfmkmbrbj3nmlb3h@flea>
 <CAMty3ZB5F5jD9iJT1soXSA5HtQOf5W9rKO9nCdGFUfVo0hpO4Q@mail.gmail.com>
 <20190107141158.zaimizk4rlqa6xli@flea>
 <CAMty3ZBb8byOwh=_W83Ta0Dse1qkoqccOeaBEY9oHPaxDxe9QA@mail.gmail.com>
 <20190108085829.clianbtjovu3oieq@flea>
 <CAMty3ZC9OQtwT-iH=S1LhHsBPc_jFKGAnCYYeR9nuKuDWSKLQw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMty3ZC9OQtwT-iH=S1LhHsBPc_jFKGAnCYYeR9nuKuDWSKLQw@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 09, 2019 at 06:57:57PM +0530, Jagan Teki wrote:
> On Tue, Jan 8, 2019 at 2:28 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> >
> > On Mon, Jan 07, 2019 at 08:48:21PM +0530, Jagan Teki wrote:
> > > On Mon, Jan 7, 2019 at 7:42 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> > > >
> > > > On Fri, Dec 21, 2018 at 02:26:11AM +0530, Jagan Teki wrote:
> > > > > On Tue, Dec 11, 2018 at 10:19 PM Maxime Ripard
> > > > > <maxime.ripard@bootlin.com> wrote:
> > > > > >
> > > > > > On Mon, Dec 10, 2018 at 09:47:19PM +0530, Jagan Teki wrote:
> > > > > > > Video start delay can be computed by subtracting total vertical
> > > > > > > timing with front porch timing and with adding 1 delay line for TCON.
> > > > > > >
> > > > > > > BSP code form BPI-M64-bsp is computing video start delay as
> > > > > > > (from linux-sunxi/
> > > > > > > drivers/video/sunxi/disp2/disp/de/lowlevel_sun50iw1/de_dsi.c)
> > > > > > >
> > > > > > > u32 vfp = panel->lcd_vt - panel->lcd_y - panel->lcd_vbp;
> > > > > > > => (panel->lcd_vt) - panel->lcd_y - (panel->lcd_vbp)
> > > > > > > => (timmings->ver_front_porch + panel->lcd_vbp + panel->lcd_y)
> > > > > > >    - panel->lcd_y - (panel->lcd_vbp)
> > > > > > > => timmings->ver_front_porch + panel->lcd_vbp + panel->lcd_y
> > > > > > >                            - panel->lcd_y - panel->lcd_vbp
> > > > > > > => timmings->ver_front_porch
> > > > > > >
> > > > > > > So, update the start delay computation accordingly.
> > > > > > >
> > > > > > > Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> > > > > >
> > > > > > Even though it's a bit better now on my A33 board and I don't have the
> > > > > > white stripes on the bottom of the display, there's still some
> > > > > > flickering with your patches applied.
> > > > > >
> > > > > > Bisecting it seems to point at that patch, but reverting it doesn't
> > > > > > make the issue go away, so it's not really clear which one exactly is
> > > > > > at fault.
> > > > >
> > > > > Is reverting this patch, work fine or not?
> > > >
> > > > As I was saying, it doesn't.
> > > >
> > > > > This patch is trying to make use of front porch instead of existing
> > > > > back porch to compute the delay. Since we revert the VBP fix patch[1]
> > > > > to assume VBP as VFP value look like your setup would also require to
> > > > > revert this change. But as per BSP or drm_mode details all of my
> > > > > displays even work with and w/o reverting these two.
> > > >
> > > > Again, I cannot help you without the datasheet for the panels you're
> > > > trying to submit.
> > >
> > > The panel bound with Sitronix ST7701 IC
> > > http://www.startek-lcd.com/res/starteklcd/pdres/201705/20170512144242904.pdf
> >
> > It's the controller, not the panel
> 
> As I said before, the datasheet of that panel doesn't have any
> information except electrical characteristics and used IC which is
> ST7701.
> 
> I have one more panel, which is from Bananapi, S070WV20-CT16 ICN621
> please find the attachment for the same.
> 
> Here is some more details of the same.
> 
> https://github.com/yesnoandor/x300/blob/master/kernel/arch/arm/boot/dts/erobbing/x300/x300.dtsi#L81
> https://github.com/wxzed/Raspberry_5MIPI_Display/blob/master/I2C_Slave/USER/main.c#L15
> 
> https://github.com/eliot-shao/qcom/blob/master/icn6211_cxn0102/kernel/drivers/video/msm/mdss/mdss_i2c_interface.c#L152
> matches timings for
> https://github.com/eliot-shao/qcom/blob/master/icn6211_cxn0102/kernel/arch/arm/boot/dts/qcom/dsi-mipi-2-rgb_1280p_video.dtsi#L20
> 
> https://github.com/zestroly/micromat/blob/master/test/raspberry/ICN6211.cpp#L169

Where did you get the timings from then?

Maxime

-- 
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
