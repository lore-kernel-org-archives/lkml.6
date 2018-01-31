Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753839AbeAaQMT (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 11:12:19 -0500
Received: from mail-qk0-f193.google.com ([209.85.220.193]:38455 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753372AbeAaQMR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 11:12:17 -0500
X-Google-Smtp-Source: AH8x224fV+Vn1CojwJSXiMIfCIwqTyt5bPhawROE4UEqQLvolzlRrv4HMfAJqdEYLBIN56jtBOu0BLT4mBvGNDa4oUo=
MIME-Version: 1.0
In-Reply-To: <1517403459-6668-1-git-send-email-daniel.baluta@nxp.com>
References: <1517403459-6668-1-git-send-email-daniel.baluta@nxp.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 31 Jan 2018 18:12:15 +0200
Message-ID: <CAHp75Vdd58U1y-LOQGg=rePOWf1LeQsZxn2ykzBhXL013ztW3Q@mail.gmail.com>
Subject: Re: [PATCH] ASoC: codecs: Add support for AK5558 ADC driver
To: Daniel Baluta <daniel.baluta@nxp.com>
Cc: Mark Brown <broonie@kernel.org>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        wakasugi.jb@om.asahi-kasei.co.jp, shengjiu.wang@nxp.com,
        mihai.serban@gmail.com, cosmin.samoila@nxp.com, linux-imx@nxp.com,
        Mihai Serban <mihai.serban@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 31, 2018 at 2:57 PM, Daniel Baluta <daniel.baluta@nxp.com> wrote:
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
> Signed-off-by: Mihai Serban <mihai.serban@nxp.com>
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>

4 authors of the code?!


> +/*
> + * ak5558.c  --  audio driver for AK5558 ADC
> + *
> + * Copyright (C) 2015 Asahi Kasei Microdevices Corporation
> + * Copyright 2018 NXP

> + *
> + * This software is licensed under the terms of the GNU General Public
> + * License version 2, as published by the Free Software Foundation, and
> + * may be copied, distributed, and modified under those terms.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.

SPDX instead?

> + */

> +#include <linux/module.h>
> +#include <linux/init.h>

It would be one of them, not both.

> +#include <linux/i2c.h>
> +#include <linux/delay.h>
> +#include <linux/slab.h>
> +#include <linux/gpio/consumer.h>
> +#include <sound/soc.h>
> +#include <sound/soc-dapm.h>
> +#include <sound/pcm.h>
> +#include <sound/pcm_params.h>
> +#include <sound/initval.h>
> +#include <sound/tlv.h>

> +#include <linux/of_gpio.h>

It seems redundant. See below.

> +#include <linux/regmap.h>
> +#include <linux/pm_runtime.h>

Better to keep list ordered.

> +/* AK5558 Codec Private Data */
> +struct ak5558_priv {
> +       struct snd_soc_codec codec;
> +       struct regmap *regmap;
> +       struct i2c_client *i2c;
> +       int fs;         /* Sampling Frequency */
> +       int rclk;       /* Master Clock */

> +       int pdn_gpio;   /* Power on / Reset GPIO */

struct gpio_desc *power_gpio;

> +       int slots;
> +       int slot_width;
> +};

> +static int ak5558_set_mcki(struct snd_soc_codec *codec, int fs, int rclk)
> +{
> +       u8  mode;
> +#ifndef AK5558_SLAVE_CKS_AUTO
> +       int mcki_rate;
> +#endif
> +

> +       dev_dbg(codec->dev, "%s fs=%d rclk=%d\n", __func__, fs, rclk);

__func__ is useless with dev_dbg(). See the run time options of Dynamic Debug.

> +
> +       mode = snd_soc_read(codec, AK5558_02_CONTROL1);
> +       mode &= ~AK5558_CKS;
> +
> +#ifdef AK5558_SLAVE_CKS_AUTO
> +       mode |= AK5558_CKS_AUTO;
> +#else

> +       if (fs != 0 && rclk != 0) {

if (fs && rclk) { ?

> +               if (rclk % fs)
> +                       return -EINVAL;
> +               mcki_rate = rclk / fs;

> +       }
> +#endif
> +       snd_soc_update_bits(codec, AK5558_02_CONTROL1, AK5558_CKS,  mode);
> +
> +       return 0;
> +}
> +

> +static int ak5558_set_dai_sysclk(struct snd_soc_dai *dai, int clk_id,
> +                                unsigned int freq, int dir)
> +{
> +       struct snd_soc_codec *codec = dai->codec;
> +       struct ak5558_priv *ak5558 = snd_soc_codec_get_drvdata(codec);
> +

> +       dev_dbg(dai->dev, "%s(%d)\n", __func__, __LINE__);

Useless. Function tracer can do this for you.

> +
> +       ak5558->rclk = freq;
> +       ak5558_set_mcki(codec, ak5558->fs, ak5558->rclk);
> +
> +       return 0;
> +}
> +
> +static int ak5558_set_dai_fmt(struct snd_soc_dai *dai, unsigned int fmt)
> +{
> +       struct snd_soc_codec *codec = dai->codec;
> +       u8 format;
> +
> +       dev_dbg(dai->dev, "%s(%d)\n", __func__, __LINE__);

> +       default:
> +               dev_err(codec->dev, "Clock mode unsupported");

dai->dev vs. codec->dev?

> +               return -EINVAL;
> +       }

> +}

> +static int ak5558_set_dai_mute(struct snd_soc_dai *dai, int mute)
> +{
> +       struct snd_soc_codec *codec = dai->codec;
> +       struct ak5558_priv *ak5558 = snd_soc_codec_get_drvdata(codec);
> +       int ndt;
> +
> +       if (mute) {

if (!mute)
 return 0;

?

> +               ndt = 0;
> +               if (ak5558->fs != 0)
> +                       ndt = 583000 / ak5558->fs;

> +               if (ndt < 5)
> +                       ndt = 5;
> +               msleep(ndt);

msleep(max(ndt, 5));

> +}

> +static int ak5558_set_tdm_slot(struct snd_soc_dai *dai, unsigned int tx_mask,
> +                              unsigned int rx_mask, int slots,
> +                              int slot_width)
> +{
> +       struct snd_soc_codec *codec = dai->codec;
> +       struct ak5558_priv *ak5558 = snd_soc_codec_get_drvdata(codec);

> +       int tdm_mode = 0;

Useless assignment.

> +       int reg;
> +
> +       ak5558->slots = slots;
> +       ak5558->slot_width = slot_width;
> +
> +       switch (slots * slot_width) {
> +       case 128:
> +               tdm_mode = AK5558_MODE_TDM128;
> +               break;
> +       case 256:
> +               tdm_mode = AK5558_MODE_TDM256;
> +               break;
> +       case 512:
> +               tdm_mode = AK5558_MODE_TDM512;
> +               break;
> +       default:
> +               tdm_mode = AK5558_MODE_NORMAL;
> +               break;
> +       }

> +       return 0;
> +}

> +static int ak5558_startup(struct snd_pcm_substream *substream,
> +                         struct snd_soc_dai *dai)
> +{
> +       int ret;
> +
> +       ret = snd_pcm_hw_constraint_list(substream->runtime, 0,
> +                                        SNDRV_PCM_HW_PARAM_RATE,
> +                                        &ak5558_rate_constraints);
> +       return ret;

return snd_pcm_hw_constraint_list(...); ?

> +}

> +static int ak5558_init_reg(struct snd_soc_codec *codec)
> +{
> +       int  ret;
> +       struct ak5558_priv *ak5558 = snd_soc_codec_get_drvdata(codec);
> +

> +       dev_dbg(codec->dev, "%s(%d)\n", __func__, __LINE__);

Useless.

> +       usleep_range(10000, 11000);

> +       if (gpio_is_valid(ak5558->pdn_gpio)) {
> +               gpio_set_value_cansleep(ak5558->pdn_gpio, 0);
> +               usleep_range(1000, 2000);
> +               gpio_set_value_cansleep(ak5558->pdn_gpio, 1);
> +               usleep_range(1000, 2000);
> +       }

static void ak5558_power_off(...)
{
 if (!ak5558->power_gpiod)
    return;

               gpiod_set_value_cansleep(ak5558->power_gpiod, 0);
               usleep_range(1000, 2000);

}

static void ak5558_power_on(...)
{
 if (!ak5558->power_gpiod)
    return;

               gpiod_set_value_cansleep(ak5558->power_gpiod, 1);
               usleep_range(1000, 2000);
}

_power_off();
_power_on();


> +       return 0;
> +}

> +static int ak5558_remove(struct snd_soc_codec *codec)
> +{
> +       struct ak5558_priv *ak5558 = snd_soc_codec_get_drvdata(codec);
> +
> +       ak5558_set_bias_level(codec, SND_SOC_BIAS_OFF);
> +

> +       if (gpio_is_valid(ak5558->pdn_gpio)) {
> +               gpio_set_value_cansleep(ak5558->pdn_gpio, 0);
> +               usleep_range(1000, 2000);
> +       }

_power_off();

> +
> +       return 0;
> +}
> +

> +#ifdef CONFIG_PM
> +static int ak5558_runtime_suspend(struct device *dev)

static int __maybe_unused ...

> +{
> +       struct ak5558_priv *ak5558 = dev_get_drvdata(dev);
> +
> +       regcache_cache_only(ak5558->regmap, true);

> +       if (gpio_is_valid(ak5558->pdn_gpio)) {
> +               gpio_set_value_cansleep(ak5558->pdn_gpio, 0);
> +               usleep_range(1000, 2000);
> +       }

_power_off();

> +
> +       return 0;
> +}
> +

> +static int ak5558_runtime_resume(struct device *dev)

__maybe_unused

> +{
> +       struct ak5558_priv *ak5558 = dev_get_drvdata(dev);
> +

> +       if (gpio_is_valid(ak5558->pdn_gpio)) {
> +               gpio_set_value_cansleep(ak5558->pdn_gpio, 0);
> +               usleep_range(1000, 2000);

Why power off again?

> +               gpio_set_value_cansleep(ak5558->pdn_gpio, 1);
> +               usleep_range(1000, 2000);
> +       }

_power_off(); // why?
_power_on();


> +}

> +#endif

ugly #ifdef.

> +static int ak5558_i2c_probe(struct i2c_client *i2c,
> +                           const struct i2c_device_id *id)
> +{
> +       struct device_node *np = i2c->dev.of_node;
> +       struct ak5558_priv *ak5558;
> +       int ret = 0;
> +
> +       dev_err(&i2c->dev, "%s(%d)\n", __func__, __LINE__);
> +
> +       ak5558 = devm_kzalloc(&i2c->dev, sizeof(struct ak5558_priv),
> +                             GFP_KERNEL);

sizeof(*ak5558) ?

> +       if (!ak5558)
> +               return -ENOMEM;

> +
> +       ak5558->regmap = devm_regmap_init_i2c(i2c, &ak5558_regmap);
> +       if (IS_ERR(ak5558->regmap))
> +               return PTR_ERR(ak5558->regmap);
> +
> +       i2c_set_clientdata(i2c, ak5558);
> +       ak5558->i2c = i2c;
> +

> +       ak5558->pdn_gpio = of_get_named_gpio(np, "ak5558,pdn-gpio", 0);
> +       if (gpio_is_valid(ak5558->pdn_gpio)) {
> +               ret = devm_gpio_request_one(&i2c->dev, ak5558->pdn_gpio,
> +                                           GPIOF_OUT_INIT_LOW, "ak5558,pdn");
> +               if (ret) {
> +                       dev_err(&i2c->dev, "unable to get pdn gpio\n");
> +                       return ret;
> +               }
> +       }

devm_gpiod_get_optional();

> +}

> +static const struct i2c_device_id ak5558_i2c_id[] = {
> +       { "ak5558", 0 },
> +       { }
> +};
> +MODULE_DEVICE_TABLE(i2c, ak5558_i2c_id);

Do you really need this? (->probe_new() callback doesn't require above
to be present)

> +MODULE_AUTHOR("Junichi Wakasugi <wakasugi.jb@om.asahi-kasei.co.jp>");
> +MODULE_AUTHOR("Mihai Serban <mihai.serban@nxp.com>");

4 SoBs, 2 Authors. Please, fix accordingly.

> +MODULE_DESCRIPTION("ASoC AK5558 ADC driver");

> +MODULE_LICENSE("GPL");

It is not consistent with the header.


> + * ak5558.h  --  audio driver for AK5558

SPDX?

No name of file in the file is a good practice as well.

> + *
> + * Copyright (C) 2016 Asahi Kasei Microdevices Corporation
> + * Copyright 2018 NXP


> +/* AK5558_02_CONTROL1 fields */
> +#define AK5558_DIF                     0x02

GENMASK() ?

> +#define AK5558_BITS                    0x04

Ditto.

> +#define AK5558_CKS                     0x78

Ditto.

> +#define AK5558_MODE_BITS       0x60

Ditto.

-- 
With Best Regards,
Andy Shevchenko
