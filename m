Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753608AbeBBTd2 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 14:33:28 -0500
Received: from mail-qt0-f193.google.com ([209.85.216.193]:36538 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751959AbeBBTdT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 14:33:19 -0500
X-Google-Smtp-Source: AH8x227YRBx/lZ8V0IG9LYPIqg6tPgeV+NDLfFPWP8GFghmxh6du2GXQcl/P4ODn17C2Q3Q+/jJK37aW+hT6Xiyj1ZA=
MIME-Version: 1.0
In-Reply-To: <1517588406-3295-2-git-send-email-daniel.baluta@nxp.com>
References: <1517588406-3295-1-git-send-email-daniel.baluta@nxp.com> <1517588406-3295-2-git-send-email-daniel.baluta@nxp.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 2 Feb 2018 21:33:18 +0200
Message-ID: <CAHp75VfyVfGdCfjV_iaXFcRcanbgwFSgJRfu8eojdbMONMUOaQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] ASoC: codecs: Add support for AK5558 ADC driver
To: Daniel Baluta <daniel.baluta@nxp.com>
Cc: Mark Brown <broonie@kernel.org>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>,
        devicetree <devicetree@vger.kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        wakasugi.jb@om.asahi-kasei.co.jp, "S.j. Wang" <shengjiu.wang@nxp.com>,
        Mihai Serban <mihai.serban@gmail.com>,
        Cosmin Samoila <cosmin.samoila@nxp.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Daniel Baluta <daniel.baluta@gmail.com>,
        Mihai Serban <mihai.serban@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 2, 2018 at 6:20 PM, Daniel Baluta <daniel.baluta@nxp.com> wrote:
> AK5558 is a 32-bit, 768 kHZ sampling, differential input ADC
> for digital audio systems.
>
> Datasheet is available at:
>
> https://www.akm.com/akm/en/file/datasheet/AK5558VN.pdf
>
> Initial patch includes support for normal and TDM modes.
>
> Signed-off-by: Junichi Wakasugi <wakasugi.jb@om.asahi-kasei.co.jp>
> [initial coding for 3.18 kernel]
> Signed-off-by: Mihai Serban <mihai.serban@nxp.com>
> [cleanups and porting to 4.9 kernel]
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> [tdm support]
> Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
> [pm support, cleanups and porting to latest kernel]

Thanks for an update.

Couple of nitpicks below, otherwise FWIW,
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>


> @@ -0,0 +1,626 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*

> + * ak5558.c  --  audio driver for AK5558 ADC

I would remove filename. If file is ever be renamed this will make an
additional noise.

> + *
> + * Copyright (C) 2015 Asahi Kasei Microdevices Corporation
> + * Copyright 2018 NXP
> + */

> +#include <linux/module.h>
> +#include <linux/delay.h>
> +#include <linux/slab.h>
> +#include <linux/gpio/consumer.h>
> +#include <sound/soc.h>
> +#include <sound/soc-dapm.h>
> +#include <sound/pcm.h>
> +#include <sound/pcm_params.h>
> +#include <linux/pm_runtime.h>
> +#include <sound/initval.h>
> +#include <linux/i2c.h>
> +#include <sound/tlv.h>
> +#include <linux/of_gpio.h>
> +#include <linux/regmap.h>

I would rather keep it sorted

 +#include <linux/delay.h>
 +#include <linux/gpio/consumer.h>
 +#include <linux/i2c.h>
 +#include <linux/module.h>
 +#include <linux/pm_runtime.h>
 +#include <linux/regmap.h>
 +#include <linux/slab.h>
      // yeah keep an empty line here to split groups
 +#include <sound/initval.h>
 +#include <sound/pcm.h>
 +#include <sound/pcm_params.h>
 +#include <sound/soc.h>
 +#include <sound/soc-dapm.h>
 +#include <sound/tlv.h>

+#include <linux/of_gpio.h>

This one is redundant.

> +static int ak5558_set_dai_mute(struct snd_soc_dai *dai, int mute)
> +{
> +       struct snd_soc_codec *codec = dai->codec;
> +       struct ak5558_priv *ak5558 = snd_soc_codec_get_drvdata(codec);

> +       int ndt = 0;

It might be even

      int ndt = max(ak5558->fs ? 583000 / ak5558->fs : 5, 5);

> +       if (!mute)
> +               return 0;
> +

> +       if (ak5558->fs != 0)
> +               ndt = 583000 / ak5558->fs;
> +
> +       msleep(max(ndt, 5));

...and here just

       msleep(ndt);

But I don't know if Mark is okay with that.

> +
> +       return 0;
> +}

> +       pm_runtime_enable(&i2c->dev);
> +       pm_runtime_disable(&client->dev);

I'm also not sure about these calls, but I leave it to you.

> +static const struct i2c_device_id ak5558_i2c_id[] = {
> +       { "ak5558", 0 },
> +       { }
> +};
> +MODULE_DEVICE_TABLE(i2c, ak5558_i2c_id);

I dunno if it's really helpful to have. Though it's up to Mark and you.

-- 
With Best Regards,
Andy Shevchenko
