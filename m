Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932703AbeE2JX1 convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 05:23:27 -0400
Received: from mail.bootlin.com ([62.4.15.54]:49409 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932434AbeE2JXT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 05:23:19 -0400
Date: Tue, 29 May 2018 11:23:16 +0200
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Thierry Reding <thierry.reding@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>,
        "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>,
        Gustavo Padovan <gustavo@padovan.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 2/3] drm/panel: Add Ilitek ILI9881c panel driver
Message-ID: <20180529092316.twbwhjqutvnzzfse@flea>
References: <cover.0c9a2cb0b38deb7304c60c507f45cf50352b752a.1525447375.git-series.maxime.ripard@bootlin.com>
 <e9348b12b59e6236a7965ceba94011a1e5b72720.1525447375.git-series.maxime.ripard@bootlin.com>
 <CACRpkdY+W02YfJb1zswy40Q0TGKupCFEG7=w78_A3VmFJ97GaA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <CACRpkdY+W02YfJb1zswy40Q0TGKupCFEG7=w78_A3VmFJ97GaA@mail.gmail.com>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

On Fri, May 11, 2018 at 05:54:27PM +0200, Linus Walleij wrote:
> Hi Maxime,
> 
> sorry that noone had much time to look at the driver.
> But I can help out, hopefully.

Thanks for your feedback :)

> On Fri, May 4, 2018 at 5:23 PM, Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> 
> > The LHR050H41 panel is the panel shipped with the BananaPi M2-Magic, and is
> > based on the Ilitek ILI9881c Controller. Add a driver for it, modelled
> > after the other Ilitek controller drivers.
> >
> > Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
> 
> Nice, I have some experience with those.
> 
> > +config DRM_PANEL_ILITEK_ILI9881C
> > +       tristate "Ilitek ILI9881C-based panels"
> > +       depends on OF
> > +       depends on DRM_MIPI_DSI
> > +       depends on BACKLIGHT_CLASS_DEVICE
> 
> If it absolutely needs DRM_MIPI_DSI and
> BACKLIGHT_CLASS_DEVICE it maybe you should
> be more helpful to the user to just select it?
> 
> Depending on OF is fine, that is more of a platform
> property.

All the other panels in this file seems to be using a depends on for
these two, so I'd rather remain consistent on this.

> > +struct ili9881c {
> > +       struct drm_panel        panel;
> > +       struct mipi_dsi_device  *dsi;
> > +
> > +       struct backlight_device *backlight;
> > +       struct gpio_desc        *power;
> 
> Should this not be modeled using a fixed regulator instead?

Probably, yes. On my board it's a GPIO that goes through the
connector, but it seems like the controller itself takes a regulator,
so there's probably a GPIO-controlled regulator on the display PCB
somewhere. I'll change it.

> > +static const struct ili9881c_instr ili9881c_init[] = {
> > +       ILI9881C_SWITCH_PAGE_INSTR(3),
> > +       ILI9881C_COMMAND_INSTR(0x01, 0x00),
> > +       ILI9881C_COMMAND_INSTR(0x02, 0x00),
> > +       ILI9881C_COMMAND_INSTR(0x03, 0x73),
> > +       ILI9881C_COMMAND_INSTR(0x04, 0x03),
> > +       ILI9881C_COMMAND_INSTR(0x05, 0x00),
> > +       ILI9881C_COMMAND_INSTR(0x06, 0x06),
> > +       ILI9881C_COMMAND_INSTR(0x07, 0x06),
> (...)
> 
> This is a bit hard to understand to say the least.

I know :/

> If this comes from a datasheet some more elaborate construction of
> the commands would be nice, maybe using some #defines?
> 
> If this just comes from some code drop or reverse engineering,
> OK bad luck, I can live with it :)

This comes from a code drop (or rather, an obscure initialisation
sequence coming straight from the vendor without any documentation or
comment associated to it).

> It looks a bit like you're uploading a small firmware.
> 
> > +static int ili9881c_switch_page(struct ili9881c *ctx, u8 page)
> > +{
> > +       u8 buf[4] = { 0xff, 0x98, 0x81, page };
> 
> That is also a bit unclear wrt what is going on.

My understanding is that the controller maps some registers (that
might be accessible through other buses if the controller is setup to
use something other than DCS) to DCS commands. Since there's more
commands than DCS would allow, it's setup in several pages, with each
pages having its own set of commands, and the page 0 accepting the
usual standard DCS commands.

It really doesn't look to me like a firmware, but just a poorly
documented initialisation sequence.. I'll add a comment

> > +static const struct drm_display_mode default_mode = {
> > +       .clock          = 62000,
> > +       .vrefresh       = 60,
> > +
> > +       .hdisplay       = 720,
> > +       .hsync_start    = 720 + 10,
> > +       .hsync_end      = 720 + 10 + 20,
> > +       .htotal         = 720 + 10 + 20 + 30,
> > +
> > +       .vdisplay       = 1280,
> > +       .vsync_start    = 1280 + 10,
> > +       .vsync_end      = 1280 + 10 + 10,
> > +       .vtotal         = 1280 + 10 + 10 + 20,
> > +};
> 
> Is that the default mode for this Ilitek device or just for the
> BananaPi? If it is the latter it should be named
> bananapi_default_mode or something so as not to confuse
> the next user of this driver.

I'll do it, thanks!
Maxime

-- 
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
