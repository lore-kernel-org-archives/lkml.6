Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751788AbeCNMQo (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 08:16:44 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:43968 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751386AbeCNMQn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 08:16:43 -0400
X-Google-Smtp-Source: AG47ELsq+N9kaRbZ10M+u7AvShc92X+R3SIZuGJ64+YSp0+jKi4SpOXS5vh3Q4X9QXBx0cnyOaBUxPlPWBqzmh4XQp0=
MIME-Version: 1.0
In-Reply-To: <1521018736-20980-2-git-send-email-hl@rock-chips.com>
References: <1521018736-20980-1-git-send-email-hl@rock-chips.com> <1521018736-20980-2-git-send-email-hl@rock-chips.com>
From: Emil Velikov <emil.l.velikov@gmail.com>
Date: Wed, 14 Mar 2018 12:16:41 +0000
Message-ID: <CACvgo511gXZfu1kPPQLs4oguCxYUmpcTEioZFk58=522KPHhNQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] drm/panel: support Innolux P097PFG panel
To: Lin Huang <hl@rock-chips.com>
Cc: Thierry Reding <thierry.reding@gmail.com>,
        Brian Norris <briannorris@chromium.org>,
        Rob Herring <robh+dt@kernel.org>, Sean Paul <seanpaul@chromium.org>,
        David Airlie <airlied@linux.ie>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        ML dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14 March 2018 at 09:12, Lin Huang <hl@rock-chips.com> wrote:
> Support Innolux P097PFG 9.7" 1536x2048 TFT LCD panel, it reuse
> the Innolux P079ZCA panel driver.
>
> Change-Id: I97923aa3735f707332681691b0231c9421b427d0
> Signed-off-by: Lin Huang <hl@rock-chips.com>
> ---
> Changes in v2:
> - None
> Changes in v3:
> - None
> Changes in v4:
> - download panel initial code
>
>  drivers/gpu/drm/panel/panel-innolux-p079zca.c | 192 +++++++++++++++++++++++++-
>  1 file changed, 187 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/panel/panel-innolux-p079zca.c b/drivers/gpu/drm/panel/panel-innolux-p079zca.c
> index 2075a9d..883b279 100644
> --- a/drivers/gpu/drm/panel/panel-innolux-p079zca.c
> +++ b/drivers/gpu/drm/panel/panel-innolux-p079zca.c
> @@ -20,6 +20,15 @@
>
>  #include <video/mipi_display.h>
>
> +struct panel_init_cmd {
> +       int len;
> +       const char *data;
> +};
> +
> +#define _INIT_CMD(...) { \
> +       .len = sizeof((char[]){__VA_ARGS__}), \
> +       .data = (char[]){__VA_ARGS__} }
> +
>  struct panel_desc {
>         const struct drm_display_mode *modes;
>         unsigned int bpc;
> @@ -30,6 +39,7 @@ struct panel_desc {
>
>         unsigned long flags;
>         enum mipi_dsi_pixel_format format;
> +       const struct panel_init_cmd *init_cmds;
>         unsigned int lanes;
>  };
>
> @@ -88,9 +98,12 @@ static int innolux_panel_unprepare(struct drm_panel *panel)
>                 return err;
>         }
>
> +       /* p097pfg: t15 */
> +       msleep(100);
> +
Based on the comment this is not needed for p079zca, yet still executed.

>         gpiod_set_value_cansleep(innolux->enable_gpio, 0);
>
> -       /* T8: 80ms - 1000ms */
> +       /* p079zca: t8*/
>         msleep(80);
>
And this is seem the opposite - zca only, yet executed on pfg.

One way to to avoid these and use the appropriate sleep throughout is
to store have the numbers in the respective panel_desc entries.



>         regulator_disable(innolux->avee);
> @@ -124,13 +137,43 @@ static int innolux_panel_prepare(struct drm_panel *panel)
>         if (err < 0)
>                 goto disable_avdd;
>
> -       /* T2: 15ms - 1000ms */
> -       usleep_range(15000, 16000);
> +       /* p079zca: t2 (20ms), p097pfg: t4 (15ms) */
> +       usleep_range(20000, 21000);
>
>         gpiod_set_value_cansleep(innolux->enable_gpio, 1);
>
> -       /* T4: 15ms - 1000ms */
> -       usleep_range(15000, 16000);
> +       /* p079zca: t4, p097pfg: t5 */
> +       usleep_range(20000, 21000);
> +
> +       if (innolux->desc->init_cmds) {
> +               const struct panel_init_cmd *cmds =
> +                                       innolux->desc->init_cmds;
> +               int i;
> +
> +               for (i = 0; cmds[i].len != 0; i++) {
> +                       const struct panel_init_cmd *cmd = &cmds[i];
> +
> +                       err = mipi_dsi_generic_write(innolux->link, cmd->data,
> +                                                    cmd->len);
> +                       if (err < 0) {
> +                               dev_err(panel->dev,
> +                                       "failed to write command %d\n", i);
> +                               goto poweroff;
> +                       }
> +
> +                       /*
> +                        * Included by random guessing, because without this
> +                        * (or at least, some delay), the panel sometimes
> +                        * didn't appear to pick up the command sequence.
> +                        */
This seems a bit hackish. Adding a reference to a bugreport/mailing
list discussion would be a nice move.
It'll save you/next person a lot of time searching for the specifics
of the problem.

> +                       err = mipi_dsi_dcs_nop(innolux->link);
> +                       if (err < 0) {
> +                               dev_err(panel->dev,
> +                                       "failed to send DCS nop: %d\n", err);
> +                               goto poweroff;
> +                       }
> +               }
> +       }
>
>         err = mipi_dsi_dcs_exit_sleep_mode(innolux->link);
>         if (err < 0) {
> @@ -213,6 +256,142 @@ static const struct panel_desc innolux_p079zca_panel_desc = {
>         .lanes = 4,
>  };
>
> +static const struct drm_display_mode innolux_p097pfg_mode = {
> +       .clock = 229000,
> +       .hdisplay = 1536,
> +       .hsync_start = 1536 + 100,
> +       .hsync_end = 1536 + 100 + 24,
> +       .htotal = 1536 + 100 + 24 + 100,
> +       .vdisplay = 2048,
> +       .vsync_start = 2048 + 100,
> +       .vsync_end = 2048 + 100 + 2,
> +       .vtotal = 2048 + 100 + 2 + 18,
> +       .vrefresh = 60,
> +};
> +
> +static const struct panel_init_cmd innolux_p097pfg_init_cmds[] = {

A lot of magic numbers :-(

Please reference the source of these - say XX spec. vY.
We could get a vY+1, which makes the nop workaround obsolete.

HTH
Emil
