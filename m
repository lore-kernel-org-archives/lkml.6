Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753333AbeD3L4y (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 07:56:54 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:41378 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751696AbeD3L4w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 07:56:52 -0400
X-Google-Smtp-Source: AB8JxZrMtI+4/FKSt+nMrofiseNWUQOz3LKZaED7KY9czNdyiuk1Hq6Wdmmjl9idjSsb3/uUx+9mcAYgbUnZnMlI6eM=
MIME-Version: 1.0
In-Reply-To: <20180418104019.31344-1-stschake@gmail.com>
References: <20180418104019.31344-1-stschake@gmail.com>
From: Stefan Schake <stschake@gmail.com>
Date: Mon, 30 Apr 2018 13:56:29 +0200
Message-ID: <CAOZHkRypy2cBKuUJMOSHq200C+5Xsz7kYBySCi_DbUOU8Uwp5w@mail.gmail.com>
Subject: Re: [PATCH] drm/tegra: hub: Use state directly
To: Thierry Reding <thierry.reding@gmail.com>
Cc: David Airlie <airlied@linux.ie>, jonathanh@nvidia.com,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stefan Schake <stschake@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 18, 2018 at 12:40 PM, Stefan Schake <stschake@gmail.com> wrote:
> Using drm_atomic_get_private_obj_state after state has been swapped
> will return old state.
>
> Fixes: 0281c4149021 ("drm/tegra: hub: Use private object for global state")
> Signed-off-by: Stefan Schake <stschake@gmail.com>
> ---
>  drivers/gpu/drm/tegra/hub.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/tegra/hub.c b/drivers/gpu/drm/tegra/hub.c
> index 9a3f23d4780f..bdd2cdd0745c 100644
> --- a/drivers/gpu/drm/tegra/hub.c
> +++ b/drivers/gpu/drm/tegra/hub.c
> @@ -683,12 +683,11 @@ void tegra_display_hub_atomic_commit(struct drm_device *drm,
>  {
>         struct tegra_drm *tegra = drm->dev_private;
>         struct tegra_display_hub *hub = tegra->hub;
> -       struct tegra_display_hub_state *hub_state;
> +       struct tegra_display_hub_state *hub_state =
> +               to_tegra_display_hub_state(hub->base.state);
>         struct device *dev = hub->client.dev;
>         int err;
>
> -       hub_state = tegra_display_hub_get_state(hub, state);
> -
>         if (hub_state->clk) {
>                 err = clk_set_rate(hub_state->clk, hub_state->rate);
>                 if (err < 0)
> --
> 2.14.1
>

Ping. I don't really have Tegra hardware to begin with but this is
one of the few examples of DRM private driver state so I figured
I'd send a quick fixup before anyone else tries to copy it.

Thanks,
Stefan
