Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752198AbeCCRBX (ORCPT <rfc822;w@1wt.eu>);
        Sat, 3 Mar 2018 12:01:23 -0500
Received: from mail-wr0-f193.google.com ([209.85.128.193]:45635 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752091AbeCCRBW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Mar 2018 12:01:22 -0500
X-Google-Smtp-Source: AG47ELvmbxAyKYjVcet/XkNaK8Jce2/SCbNGzOU9n6LMRQ7VvT3PhYXqKw99tuhsKUa4QcJ/778Oa9LYhHVVev/5Ljo=
MIME-Version: 1.0
In-Reply-To: <1519747558-17257-1-git-send-email-tharvey@gateworks.com>
References: <1519747558-17257-1-git-send-email-tharvey@gateworks.com>
From: Tim Harvey <tharvey@gateworks.com>
Date: Sat, 3 Mar 2018 09:01:19 -0800
Message-ID: <CAJ+vNU11cta+pCamO1SKAU=yOEnGyww1CZ=u4mdqeFS+2-qNeg@mail.gmail.com>
Subject: Re: [PATCH] regmap: irq: fix ack-invert
To: linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Lee Jones <lee.jones@linaro.org>, Tony Lindgren <tony@atomide.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 27, 2018 at 8:05 AM, Tim Harvey <tharvey@gateworks.com> wrote:
> When acking irqs we need to take into account the ack-invert case. Without
> this chips that require 0's to ACK interrupts will never clear the interrupt.
>
> I am working on an mfd driver that will use ack-invert and discovered
> this issue. The only user of ack_invert currently appears to be the
> motorola-cpcap driver. I'm not clear why that driver doesn't appear affected
> so I'm cc'ing those involved with that driver for review and testing.
>
> Cc: Benjamin Gaignard <benjamin.gaignard@linaro.org>
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: Tony Lindgren <tony@atomide.com>
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> ---
>  drivers/base/regmap/regmap-irq.c | 17 +++++++++++++----
>  1 file changed, 13 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/base/regmap/regmap-irq.c b/drivers/base/regmap/regmap-irq.c
> index 429ca8e..abfed41 100644
> --- a/drivers/base/regmap/regmap-irq.c
> +++ b/drivers/base/regmap/regmap-irq.c
> @@ -355,16 +355,25 @@ static irqreturn_t regmap_irq_thread(int irq, void *d)
>          * doing a write per register.
>          */
>         for (i = 0; i < data->chip->num_regs; i++) {
> -               data->status_buf[i] &= ~data->mask_buf[i];
> -
> -               if (data->status_buf[i] && (chip->ack_base || chip->use_ack)) {
> +               if ( (data->status_buf[i] & ~data->mask_buf[i]) &&
> +                    (chip->ack_base || chip->use_ack) ) {
>                         reg = chip->ack_base +
>                                 (i * map->reg_stride * data->irq_reg_stride);
> -                       ret = regmap_write(map, reg, data->status_buf[i]);
> +                       /* some chips ack by write 0 */
> +                       if (chip->ack_invert)
> +                               ret = regmap_write(map, reg,
> +                                                  ~data->status_buf[i] &
> +                                                  ~data->mask_buf[i]);
> +
> +                       else
> +                               ret = regmap_write(map, reg,
> +                                                  data->status_buf[i] &
> +                                                  ~data->mask_buf[i]);
>                         if (ret != 0)
>                                 dev_err(map->dev, "Failed to ack 0x%x: %d\n",
>                                         reg, ret);
>                 }
> +               data->status_buf[i] &= ~data->mask_buf[i];
>         }
>
>         for (i = 0; i < chip->num_irqs; i++) {
> --
> 2.7.4
>

This still needs some work. For the mask_invert=true and
ack_invert=true case which is the case for the driver I'm writing it
ends up setting bits that didn't even fire. I will revisit on Monday
with a patch that uses update_bits to ensure only the correct bits are
set or cleared on an ack regardless of akc_invert.

Regards,

Tim
