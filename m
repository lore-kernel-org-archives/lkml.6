Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751430AbeCNMCS (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 08:02:18 -0400
Received: from mail-wm0-f52.google.com ([74.125.82.52]:37270 "EHLO
        mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750855AbeCNMCQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 08:02:16 -0400
X-Google-Smtp-Source: AG47ELv+N58Y9J6pQij87jUT+4cDqG9zeEwmIaQF0/b22im8wHRXwSrWcdzN32qU//Sm5o3T9I3/BokwUhv5fnFYU5A=
MIME-Version: 1.0
In-Reply-To: <1521018736-20980-1-git-send-email-hl@rock-chips.com>
References: <1521018736-20980-1-git-send-email-hl@rock-chips.com>
From: Emil Velikov <emil.l.velikov@gmail.com>
Date: Wed, 14 Mar 2018 12:02:13 +0000
Message-ID: <CACvgo50UGi97RYQkYLMmVNKcfi39BSVVKkxHnLTvsEks737+-Q@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] drm/panel: refactor INNOLUX P079ZCA panel driver
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

Hi Lin,

On 14 March 2018 at 09:12, Lin Huang <hl@rock-chips.com> wrote:
> From: huang lin <hl@rock-chips.com>
>
> Refactor Innolux P079ZCA panel driver, let it support
> multi panel.
>
> Change-Id: If89be5e56dba8cb498e2d50c1bbeb0e8016123a2
> Signed-off-by: Lin Huang <hl@rock-chips.com>
> ---
> Changes in v2:
> - Change regulator property name to meet the panel datasheet
> Changes in v3:
> - this patch only refactor P079ZCA panel to support multi panel, support P097PFG panel in another patch
> Changes in v4:
> - Modify the patch which suggest by Thierry
>
Thanks for splitting this up. I think there's another piece that fell
through the cracks.
I'm not deeply familiar with the driver, so just sharing some quick notes.


>  struct innolux_panel {
>         struct drm_panel base;
>         struct mipi_dsi_device *link;
> +       const struct panel_desc *desc;
>
>         struct backlight_device *backlight;
> -       struct regulator *supply;
> +       struct regulator *vddi;

> +       struct regulator *avdd;
> +       struct regulator *avee;
These two seem are new addition, as opposed to a dummy refactor.
Are they optional, does one need them for the existing panel (separate
patch?) or only for the new one (squash with the new panel code)?


>         struct gpio_desc *enable_gpio;
>
>         bool prepared;
> @@ -77,9 +93,9 @@ static int innolux_panel_unprepare(struct drm_panel *panel)
>         /* T8: 80ms - 1000ms */
>         msleep(80);
>
> -       err = regulator_disable(innolux->supply);
> -       if (err < 0)
> -               return err;
Good call on dropping the early return here.


> @@ -207,19 +248,28 @@ static const struct drm_panel_funcs innolux_panel_funcs = {

>
> -       innolux->supply = devm_regulator_get(dev, "power");
> -       if (IS_ERR(innolux->supply))
> -               return PTR_ERR(innolux->supply);
> +       innolux = devm_kzalloc(dev, sizeof(*innolux), GFP_KERNEL);
> +       if (!innolux)
> +               return -ENOMEM;
> +
> +       innolux->desc = desc;
> +       innolux->vddi = devm_regulator_get(dev, "power");
> +       innolux->avdd = devm_regulator_get(dev, "avdd");
> +       innolux->avee = devm_regulator_get(dev, "avee");
>
AFAICT devm_regulator_get returns a pointer which is unsuitable to be
passed into regulator_{enable,disable}.
Hence, the IS_ERR check should stay. If any of the regulators are
optional, you want to call regulator_{enable,disable} only as
applicable.


> @@ -318,5 +377,6 @@ static struct mipi_dsi_driver innolux_panel_driver = {
>  module_mipi_dsi_driver(innolux_panel_driver);
>
>  MODULE_AUTHOR("Chris Zhong <zyw@rock-chips.com>");
> +MODULE_AUTHOR("Lin Huang <hl@rock-chips.com>");
I don't think refactoring existing code classify as being the module author.
Then again, I could be wrong.

HTH
Emil
