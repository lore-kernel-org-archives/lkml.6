Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754923AbeBOHm0 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 02:42:26 -0500
Received: from lelnx193.ext.ti.com ([198.47.27.77]:41453 "EHLO
        lelnx193.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754824AbeBOHmZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 02:42:25 -0500
Subject: Re: [alsa-devel] [PATCH] ASoC: dmic: Add optional wakeup delay
To: Matthias Kaehlcke <mka@chromium.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
CC: <devicetree@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        huang lin <hl@rock-chips.com>, Brian Norris <briannorris@chromium.org>,
        <linux-kernel@vger.kernel.org>, Dylan Reid <dgreid@chromium.org>
References: <20180214235156.81589-1-mka@chromium.org>
From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <7c9d5202-bcac-f989-6be2-f286de15a5de@ti.com>
Date: Thu, 15 Feb 2018 09:42:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180214235156.81589-1-mka@chromium.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018-02-15 01:51, Matthias Kaehlcke wrote:
> On some systems a delay is needed after switching on the clocks, to allow
> the DMIC output to stabilize and avoid a popping noise at the beginning
> of the recording. Add the optional device tree property 'wakeup-delay-ms'
> and apply the specified delay in the new dmic_daiops_prepare().
> 
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
>  .../devicetree/bindings/sound/dmic.txt        |  2 +
>  sound/soc/codecs/dmic.c                       | 54 ++++++++++++++-----
>  2 files changed, 42 insertions(+), 14 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/sound/dmic.txt b/Documentation/devicetree/bindings/sound/dmic.txt
> index 54c8ef6498a8..de741c6609d0 100644
> --- a/Documentation/devicetree/bindings/sound/dmic.txt
> +++ b/Documentation/devicetree/bindings/sound/dmic.txt
> @@ -7,10 +7,12 @@ Required properties:
>  
>  Optional properties:
>  	- dmicen-gpios: GPIO specifier for dmic to control start and stop
> +	- wakeup-delay-ms: Delay (in ms) after enabling the DMIC
>  
>  Example node:
>  
>  	dmic_codec: dmic@0 {
>  		compatible = "dmic-codec";
>  		dmicen-gpios = <&gpio4 3 GPIO_ACTIVE_HIGH>;
> +		wakeup-delay-ms <50>;
>  	};
> diff --git a/sound/soc/codecs/dmic.c b/sound/soc/codecs/dmic.c
> index b88a1ee66f80..11f6abf11074 100644
> --- a/sound/soc/codecs/dmic.c
> +++ b/sound/soc/codecs/dmic.c
> @@ -19,6 +19,7 @@
>   *
>   */
>  
> +#include <linux/delay.h>
>  #include <linux/gpio.h>
>  #include <linux/gpio/consumer.h>
>  #include <linux/platform_device.h>
> @@ -29,24 +30,38 @@
>  #include <sound/soc.h>
>  #include <sound/soc-dapm.h>
>  
> +struct dmic {
> +	struct gpio_desc *gpio_en;
> +	int wakeup_delay;
> +};
> +
> +static int dmic_daiops_prepare(struct snd_pcm_substream *substream,
> +				struct snd_soc_dai *dai)
> +{
> +	struct dmic *dmic = snd_soc_dai_get_drvdata(dai);
> +
> +	if (dmic->gpio_en)
> +		gpiod_set_value(dmic->gpio_en, 1);

You don't need the 'if (dmic->gpio_en)'

> +
> +	if (dmic->wakeup_delay)
> +		msleep(dmic->wakeup_delay);
> +
> +	return 0;
> +}
> +
>  static int dmic_daiops_trigger(struct snd_pcm_substream *substream,
>  		int cmd, struct snd_soc_dai *dai)
>  {
> -	struct gpio_desc *dmic_en = snd_soc_dai_get_drvdata(dai);
> +	struct dmic *dmic = snd_soc_dai_get_drvdata(dai);
>  
> -	if (!dmic_en)
> +	if (!dmic->gpio_en)
>  		return 0;
>  
>  	switch (cmd) {
> -	case SNDRV_PCM_TRIGGER_START:
> -	case SNDRV_PCM_TRIGGER_RESUME:
> -	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
> -		gpiod_set_value(dmic_en, 1);
> -		break;
>  	case SNDRV_PCM_TRIGGER_STOP:
>  	case SNDRV_PCM_TRIGGER_SUSPEND:
>  	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
> -		gpiod_set_value(dmic_en, 0);
> +		gpiod_set_value(dmic->gpio_en, 0);
>  		break;
>  	}

What if instead of this trickery we try to handle the gpio/delay via
DAPM? SND_SOC_DAPM_AIF_OUT_E() might be just what we need?

We could remove the trigger, and will have no need for the prepare
callback either..

>  
> @@ -54,6 +69,7 @@ static int dmic_daiops_trigger(struct snd_pcm_substream *substream,
>  }
>  
>  static const struct snd_soc_dai_ops dmic_dai_ops = {
> +	.prepare	= dmic_daiops_prepare,
>  	.trigger	= dmic_daiops_trigger,
>  };
>  
> @@ -73,14 +89,24 @@ static struct snd_soc_dai_driver dmic_dai = {
>  
>  static int dmic_codec_probe(struct snd_soc_codec *codec)
>  {
> -	struct gpio_desc *dmic_en;
> +	struct dmic *dmic;
> +	int err;
> +
> +	dmic = devm_kzalloc(codec->dev, sizeof(*dmic), GFP_KERNEL);
> +	if (!dmic)
> +		return -ENOMEM;
> +
> +	dmic->gpio_en = devm_gpiod_get_optional(codec->dev,
> +						"dmicen", GPIOD_OUT_LOW);
> +	if (IS_ERR(dmic->gpio_en))
> +		return PTR_ERR(dmic->gpio_en);
>  
> -	dmic_en = devm_gpiod_get_optional(codec->dev,
> -					"dmicen", GPIOD_OUT_LOW);
> -	if (IS_ERR(dmic_en))
> -		return PTR_ERR(dmic_en);
> +	err = device_property_read_u32(codec->dev, "wakeup-delay-ms",
> +				       &dmic->wakeup_delay);
> +	if (err && (err != -EINVAL))
> +		return err;
>  
> -	snd_soc_codec_set_drvdata(codec, dmic_en);
> +	snd_soc_codec_set_drvdata(codec, dmic);
>  
>  	return 0;
>  }
> 

- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
