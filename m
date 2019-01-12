Return-Path: <SRS0=UXoZ=PU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60F67C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 10:14:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 348DA20870
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 10:14:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725857AbfALKOR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Jan 2019 05:14:17 -0500
Received: from asavdk4.altibox.net ([109.247.116.15]:56088 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725816AbfALKOQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jan 2019 05:14:16 -0500
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by asavdk4.altibox.net (Postfix) with ESMTPS id 2550F804D2;
        Sat, 12 Jan 2019 11:14:10 +0100 (CET)
Date:   Sat, 12 Jan 2019 11:14:09 +0100
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     David Airlie <airlied@linux.ie>,
        linux-amarula@amarulasolutions.com,
        linux-kernel <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        Sean Paul <sean@poorly.run>
Subject: Re: [PATCH V7 2/2] drm/panel: Add Sitronix ST7701 panel driver
Message-ID: <20190112101409.GA14273@ravnborg.org>
References: <20190111124714.19566-1-jagan@amarulasolutions.com>
 <20190111124714.19566-2-jagan@amarulasolutions.com>
 <20190111211931.GA29735@ravnborg.org>
 <CAMty3ZArGPf8+M5GVhkzoMDhtYwT3aUS9bNbKt8=gqeb6-b82Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMty3ZArGPf8+M5GVhkzoMDhtYwT3aUS9bNbKt8=gqeb6-b82Q@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=UpRNyd4B c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=kj9zAlcOel0A:10 a=7gkXJVJtAAAA:8 a=6-oEOvViAAAA:8
        a=LGALzHtsx367PvwkiA0A:9 a=XysytHMBpD90YD8v:21 a=fZ7kpXaeLR5VPvBn:21
        a=CjuIK1q_8ugA:10 a=E9Po1WZjFZOl8hwRPBS3:22 a=XKUzlloKlYS27tEbwpHE:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jagan.

> On Sat, Jan 12, 2019 at 2:49 AM Sam Ravnborg <sam@ravnborg.org> wrote:
> >
> > Hi Jagan.
> >
> > Gave this another more detailed read - triggered some additional comments.
> > Depite the comments it looks good, and this is all more or
> > less cosmetic improvements.
> 
> Thanks for the review.
> 
> >
> >         Sam
> >
> > > +struct st7701_panel_desc {
> > > +     const struct drm_display_mode *mode;
> > > +     unsigned int lanes;
> > > +     unsigned long flags;
> > > +     enum mipi_dsi_pixel_format format;
> > > +     const char *const *supply_names;
> > > +     unsigned int num_supplies;
> > > +     unsigned int panel_sleep_delay;
> > > +};
> > > +
> > > +struct st7701 {
> > > +     struct drm_panel panel;
> > > +     struct mipi_dsi_device *dsi;
> > > +     const struct st7701_panel_desc *desc;
> > > +
> > > +     struct backlight_device *backlight;
> > > +     struct regulator_bulk_data *supplies;
> > > +     unsigned int num_supplies;
> > I cannot see that num_supplies in this struct are used?
> 
> Yes it is used in the code, please check in struct st7701_panel_desc.
I have applied the patch and deleted num_supplies - now build errors.
So num_supplies in struct st7701 is not used and should be deleted.

> > > +static int st7701_prepare(struct drm_panel *panel)
> > > +{
> > > +     struct st7701 *st7701 = panel_to_st7701(panel);
> > > +     int ret;
> > > +
> > > +     gpiod_set_value(st7701->reset, 0);
> > > +     msleep(20);
> > > +
> > > +     ret = regulator_bulk_enable(st7701->desc->num_supplies,
> > > +                                 st7701->supplies);
> > > +     if (ret < 0)
> > > +             return ret;
> > > +     msleep(20);
> > > +
> > > +     gpiod_set_value(st7701->reset, 1);
> > > +     msleep(20);
> > > +
> > > +     gpiod_set_value(st7701->reset, 0);
> > > +     msleep(30);
> > > +
> > > +     gpiod_set_value(st7701->reset, 1);
> > > +     msleep(150);
> > > +
> > > +     st7701_init_sequence(st7701);
> > > +
> > > +     return 0;
> > > +}
> > > +
> >
> > > +static int st7701_unprepare(struct drm_panel *panel)
> > > +{
> > > +     struct st7701 *st7701 = panel_to_st7701(panel);
> > > +
> > > +     ST7701_DSI(st7701, MIPI_DCS_EXIT_SLEEP_MODE, 0x00);

Should this be MIPI_DCS_ENTER_SLEEP_MODE?

Note - you have shortcuts fot the standard commands like
in this case:

	mipi_dsi_dcs_enter_sleep_mode(st7701->dsi);

Thay could be introduced in many palces, but I also like how all the
commands follows a consistent way to be issued.
So consider this only if this was new for you.


> > > +
> > > +     msleep(st7701->sleep_delay);
> > > +
> > > +     gpiod_set_value(st7701->reset, 0);
> > > +
> > > +     gpiod_set_value(st7701->reset, 1);
> > > +
> > > +     gpiod_set_value(st7701->reset, 0);
> > No timing constrains here? In prepare there are sleeps intermixed.
> 
> Delay while doing unprare is not needed I suppose.

If the purpose is alone to reset the display then a single write '0'
should do it I think
And there is a requirement that it must be low for a minimum of 10 us
which would be good to have here.

I aslo found in chapter 9. (page 163 - second line) this statement:
"VDDA and VDDI must be powered down with minimum 120msec."

This is similar to the unprepare delay to be found in simple-panel.c
So an unprepare delay seems in order here.


> > > +static const struct st7701_panel_desc ts8550b_desc = {
> > > +     .mode = &ts8550b_mode,
> > > +     .lanes = 2,
> > > +     .flags = MIPI_DSI_MODE_VIDEO,
> > > +     .format = MIPI_DSI_FMT_RGB888,
> > > +     .supply_names = ts8550b_supply_names,
> > > +     .num_supplies = ARRAY_SIZE(ts8550b_supply_names),
> > > +     .panel_sleep_delay = 80, /* panel need extra 80ms for sleep out cmd */
> > In the only place this is used there is added 120 ms too.
> > Looks inconsistent - do we have the same delay twice?
> 
> 120ms is the one recommended by st7701 controller delay after a sleep
> out command, please check it in datasheet [1], page 188. And this 80ms
> is specific to TS8550B panel as per BSP code this doesn't have proper
> documentation but the BSP code doing this extra 80ms.

OK, thanks for the pointer to the datasheet.

> [1] http://www.startek-lcd.com/res/starteklcd/pdres/201705/20170512144242904.pdf


	Sam
