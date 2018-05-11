Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751865AbeEKPyc (ORCPT <rfc822;w@1wt.eu>);
        Fri, 11 May 2018 11:54:32 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:37767 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751634AbeEKPy3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 May 2018 11:54:29 -0400
X-Google-Smtp-Source: AB8JxZq5jKCYbH4qkT+Nk52TIxQrLPZF8DekkVkfd7n4/rp8koAOuLYgAYSEmRxfuesDiGYmp2v/IgqUg3xz5MwH91U=
MIME-Version: 1.0
In-Reply-To: <e9348b12b59e6236a7965ceba94011a1e5b72720.1525447375.git-series.maxime.ripard@bootlin.com>
References: <cover.0c9a2cb0b38deb7304c60c507f45cf50352b752a.1525447375.git-series.maxime.ripard@bootlin.com>
 <e9348b12b59e6236a7965ceba94011a1e5b72720.1525447375.git-series.maxime.ripard@bootlin.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 11 May 2018 17:54:27 +0200
Message-ID: <CACRpkdY+W02YfJb1zswy40Q0TGKupCFEG7=w78_A3VmFJ97GaA@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] drm/panel: Add Ilitek ILI9881c panel driver
To: Maxime Ripard <maxime.ripard@bootlin.com>
Cc: Thierry Reding <thierry.reding@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>,
        "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>,
        Gustavo Padovan <gustavo@padovan.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maxime,

sorry that noone had much time to look at the driver.
But I can help out, hopefully.

On Fri, May 4, 2018 at 5:23 PM, Maxime Ripard <maxime.ripard@bootlin.com> wrote:

> The LHR050H41 panel is the panel shipped with the BananaPi M2-Magic, and is
> based on the Ilitek ILI9881c Controller. Add a driver for it, modelled
> after the other Ilitek controller drivers.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>

Nice, I have some experience with those.

> +config DRM_PANEL_ILITEK_ILI9881C
> +       tristate "Ilitek ILI9881C-based panels"
> +       depends on OF
> +       depends on DRM_MIPI_DSI
> +       depends on BACKLIGHT_CLASS_DEVICE

If it absolutely needs DRM_MIPI_DSI and
BACKLIGHT_CLASS_DEVICE it maybe you should
be more helpful to the user to just select it?

Depending on OF is fine, that is more of a platform
property.

> +struct ili9881c {
> +       struct drm_panel        panel;
> +       struct mipi_dsi_device  *dsi;
> +
> +       struct backlight_device *backlight;
> +       struct gpio_desc        *power;

Should this not be modeled using a fixed regulator instead?

> +       struct gpio_desc        *reset;
> +};

> +enum ili9881c_op {
> +       ILI9881C_SWITCH_PAGE,
> +       ILI9881C_COMMAND,
> +};
> +
> +struct ili9881c_instr {
> +       enum ili9881c_op        op;
> +
> +       union arg {
> +               struct cmd {
> +                       u8      cmd;
> +                       u8      data;
> +               } cmd;
> +               u8      page;
> +       } arg;
> +};
> +
> +#define ILI9881C_SWITCH_PAGE_INSTR(_page)      \
> +       {                                       \
> +               .op = ILI9881C_SWITCH_PAGE,     \
> +               .arg = {                        \
> +                       .page = (_page),        \
> +               },                              \
> +       }
> +
> +#define ILI9881C_COMMAND_INSTR(_cmd, _data)            \
> +       {                                               \
> +               .op = ILI9881C_COMMAND,         \
> +               .arg = {                                \
> +                       .cmd = {                        \
> +                               .cmd = (_cmd),          \
> +                               .data = (_data),        \
> +                       },                              \
> +               },                                      \
> +       }

That looks clever.

> +static const struct ili9881c_instr ili9881c_init[] = {
> +       ILI9881C_SWITCH_PAGE_INSTR(3),
> +       ILI9881C_COMMAND_INSTR(0x01, 0x00),
> +       ILI9881C_COMMAND_INSTR(0x02, 0x00),
> +       ILI9881C_COMMAND_INSTR(0x03, 0x73),
> +       ILI9881C_COMMAND_INSTR(0x04, 0x03),
> +       ILI9881C_COMMAND_INSTR(0x05, 0x00),
> +       ILI9881C_COMMAND_INSTR(0x06, 0x06),
> +       ILI9881C_COMMAND_INSTR(0x07, 0x06),
(...)

This is a bit hard to understand to say the least. If this comes from
a datasheet some more elaborate construction of the commands
would be nice, maybe using some #defines?

If this just comes from some code drop or reverse engineering,
OK bad luck, I can live with it :)

It looks a bit like you're uploading a small firmware.

> +static int ili9881c_switch_page(struct ili9881c *ctx, u8 page)
> +{
> +       u8 buf[4] = { 0xff, 0x98, 0x81, page };

That is also a bit unclear wrt what is going on.

> +static int ili9881c_prepare(struct drm_panel *panel)
> +{
> +       struct ili9881c *ctx = panel_to_ili9881c(panel);
> +       unsigned int i;
> +       int ret;
> +
> +       /* Power the panel */
> +       gpiod_set_value(ctx->power, 1);
> +       msleep(5);

So isn't this a fixed regulator using a GPIO?

> +static const struct drm_display_mode default_mode = {
> +       .clock          = 62000,
> +       .vrefresh       = 60,
> +
> +       .hdisplay       = 720,
> +       .hsync_start    = 720 + 10,
> +       .hsync_end      = 720 + 10 + 20,
> +       .htotal         = 720 + 10 + 20 + 30,
> +
> +       .vdisplay       = 1280,
> +       .vsync_start    = 1280 + 10,
> +       .vsync_end      = 1280 + 10 + 10,
> +       .vtotal         = 1280 + 10 + 10 + 20,
> +};

Is that the default mode for this Ilitek device or just for the
BananaPi? If it is the latter it should be named
bananapi_default_mode or something so as not to confuse
the next user of this driver.

> +       ctx->power = devm_gpiod_get(&dsi->dev, "power", GPIOD_OUT_LOW);
> +       if (IS_ERR(ctx->power)) {
> +               dev_err(&dsi->dev, "Couldn't get our power GPIO\n");
> +               return PTR_ERR(ctx->power);
> +       }

So I'm a bit sceptical about this one.

Yours,
Linus Walleij
