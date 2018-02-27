Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752812AbeB0L13 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 06:27:29 -0500
Received: from mail-io0-f194.google.com ([209.85.223.194]:35087 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752444AbeB0L11 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 06:27:27 -0500
X-Google-Smtp-Source: AG47ELv3ypCAVXDfrCL1TM7OyeH+4hJ3lkZoA+Ugy/ZYqUhJFd8N045IllxwS5VGhQsBLGjb+1MKCEG7udghDC/liQ8=
MIME-Version: 1.0
In-Reply-To: <1519389859-14947-1-git-send-email-geert+renesas@glider.be>
References: <1519389859-14947-1-git-send-email-geert+renesas@glider.be>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 27 Feb 2018 12:27:26 +0100
Message-ID: <CAPDyKFrFKp7Bn+86jWN1t4Q7bLup0z3cnPM8zMMTdMTQLJSfQA@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: dw_mmc-k3: Fix out-of-bounds access through DT alias
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Jaehoon Chung <jh80.chung@samsung.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        devicetree-compiler@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23 February 2018 at 13:44, Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
> The hs_timing_cfg[] array is indexed using a value derived from the
> "mshcN" alias in DT, which may lead to an out-of-bounds access.
>
> Fix this by adding a range check.
>
> Fixes: 361c7fe9b02eee7e ("mmc: dw_mmc-k3: add sd support for hi3660")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Thanks, applied for fixes!

Should we add a stable tag as well?

Kind regards
Uffe

> ---
> v2:
>   - Fix Fixes reference.
>
> There is another possible out-of-bounds access in
> drivers/mmc/host/dw_mmc.c:dw_mci_init_slot():
>
>     if (drv_data && drv_data->caps)
>             mmc->caps |= drv_data->caps[ctrl_id];
>
> With ctrl_id derived from "mshcN".
>
> Unfortunately the upper bound is not known at run-time, without adding
> such a field to struct dw_mci_drv_data first.
> ---
>  drivers/mmc/host/dw_mmc-k3.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/mmc/host/dw_mmc-k3.c b/drivers/mmc/host/dw_mmc-k3.c
> index 73fd75c3c824904d..75ae5803b0db24dd 100644
> --- a/drivers/mmc/host/dw_mmc-k3.c
> +++ b/drivers/mmc/host/dw_mmc-k3.c
> @@ -135,6 +135,9 @@ static int dw_mci_hi6220_parse_dt(struct dw_mci *host)
>         if (priv->ctrl_id < 0)
>                 priv->ctrl_id = 0;
>
> +       if (priv->ctrl_id >= TIMING_MODE)
> +               return -EINVAL;
> +
>         host->priv = priv;
>         return 0;
>  }
> --
> 2.7.4
>
