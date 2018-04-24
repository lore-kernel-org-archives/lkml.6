Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751296AbeDXQgT (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 12:36:19 -0400
Received: from mail-vk0-f67.google.com ([209.85.213.67]:41208 "EHLO
        mail-vk0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750827AbeDXQgS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 12:36:18 -0400
X-Google-Smtp-Source: AB8JxZo+/hsEJU3Mf7wgdo6v/XW1EKe3VUnu2nShjhk6Rweqhw18wAODPks8k5Up0+SCrkIHZFojfL5VmNgHQl5vtA4=
MIME-Version: 1.0
References: <1524539088-9043-1-git-send-email-Vijendar.Mukunda@amd.com> <1524539088-9043-2-git-send-email-Vijendar.Mukunda@amd.com>
In-Reply-To: <1524539088-9043-2-git-send-email-Vijendar.Mukunda@amd.com>
From: Daniel Kurtz <djkurtz@chromium.org>
Date: Tue, 24 Apr 2018 16:36:05 +0000
Message-ID: <CAGS+omDr8Jiwx0faMWZpASPrTUCcj97xSvG01JQX5Cj16vEeQw@mail.gmail.com>
Subject: Re: [PATCH 2/3] ASoC: AMD: Move clk enable from hw_params/free to startup/shutdown
To: Vijendar.Mukunda@amd.com
Cc: Akshu Agrawal <akshu.agrawal@amd.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        perex@perex.cz, tiwai@suse.com, alexander.deucher@amd.com,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 23, 2018 at 9:03 PM Vijendar Mukunda <Vijendar.Mukunda@amd.com>
wrote:

> From: Akshu Agrawal <akshu.agrawal@amd.com>

> hw_param can be called multiple times and thus we can have
> more clk enable. The clk may not get diabled due to refcounting.
> startup/shutdown ensures single clk enable/disable call.

> Signed-off-by: Akshu Agrawal <akshu.agrawal@amd.com>
> Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
> ---
>   sound/soc/amd/acp-da7219-max98357a.c | 54
++++++++++++++++++++++++------------
>   1 file changed, 37 insertions(+), 17 deletions(-)

> diff --git a/sound/soc/amd/acp-da7219-max98357a.c
b/sound/soc/amd/acp-da7219-max98357a.c
> index b205c78..0f16f6d 100644
> --- a/sound/soc/amd/acp-da7219-max98357a.c
> +++ b/sound/soc/amd/acp-da7219-max98357a.c
> @@ -38,8 +38,7 @@
>   #include "../codecs/da7219.h"
>   #include "../codecs/da7219-aad.h"

> -#define CZ_PLAT_CLK 24000000
> -#define MCLK_RATE 24576000
> +#define CZ_PLAT_CLK 25000000
>   #define DUAL_CHANNEL           2

>   static struct snd_soc_jack cz_jack;
> @@ -62,7 +61,7 @@ static int cz_da7219_init(struct snd_soc_pcm_runtime
*rtd)
>          }

>          ret = snd_soc_dai_set_pll(codec_dai, 0, DA7219_SYSCLK_PLL,
> -                                 CZ_PLAT_CLK, MCLK_RATE);
> +                                 CZ_PLAT_CLK, DA7219_PLL_FREQ_OUT_98304);

These are unrelated fixes that should be in their own patch.

>          if (ret < 0) {
>                  dev_err(rtd->dev, "can't set codec pll: %d\n", ret);
>                  return ret;
> @@ -85,8 +84,7 @@ static int cz_da7219_init(struct snd_soc_pcm_runtime
*rtd)
>          return 0;
>   }

> -static int cz_da7219_hw_params(struct snd_pcm_substream *substream,
> -                            struct snd_pcm_hw_params *params)
> +static int da7219_clk_enable(struct snd_pcm_substream *substream)
>   {
>          int ret = 0;
>          struct snd_soc_pcm_runtime *rtd = substream->private_data;
> @@ -100,11 +98,9 @@ static int cz_da7219_hw_params(struct
snd_pcm_substream *substream,
>          return ret;
>   }

> -static int cz_da7219_hw_free(struct snd_pcm_substream *substream)
> +static void da7219_clk_disable(void)
>   {
>          clk_disable_unprepare(da7219_dai_clk);
> -
> -       return 0;
>   }

>   static const unsigned int channels[] = {
> @@ -127,7 +123,7 @@ static const struct snd_pcm_hw_constraint_list
constraints_channels = {
>          .mask = 0,
>   };

> -static int cz_fe_startup(struct snd_pcm_substream *substream)
> +static int cz_da7219_startup(struct snd_pcm_substream *substream)
>   {
>          struct snd_pcm_runtime *runtime = substream->runtime;

> @@ -141,23 +137,47 @@ static int cz_fe_startup(struct snd_pcm_substream
*substream)
>          snd_pcm_hw_constraint_list(runtime, 0, SNDRV_PCM_HW_PARAM_RATE,
>                                     &constraints_rates);

> -       return 0;
> +       return da7219_clk_enable(substream);
> +}
> +
> +static void cz_da7219_shutdown(struct snd_pcm_substream *substream)
> +{
> +       da7219_clk_disable();
> +}
> +
> +static int cz_max_startup(struct snd_pcm_substream *substream)
> +{
> +       return da7219_clk_enable(substream);
> +}
> +
> +static void cz_max_shutdown(struct snd_pcm_substream *substream)
> +{
> +       da7219_clk_disable();
> +}
> +
> +static int cz_dmic_startup(struct snd_pcm_substream *substream)
> +{
> +       return da7219_clk_enable(substream);
> +}
> +
> +static void cz_dmic_shutdown(struct snd_pcm_substream *substream)
> +{
> +       da7219_clk_disable();
>   }

This is ok, or you could combine the common cz_max_* & cz_dmic_*.


>   static struct snd_soc_ops cz_da7219_cap_ops = {

I think these should all be "static const struct snd_soc_ops"  (please fix
in a separate patch).

> -       .hw_params = cz_da7219_hw_params,
> -       .hw_free = cz_da7219_hw_free,
> -       .startup = cz_fe_startup,
> +       .startup = cz_da7219_startup,
> +       .shutdown = cz_da7219_shutdown,
>   };

>   static struct snd_soc_ops cz_max_play_ops = {
> -       .hw_params = cz_da7219_hw_params,
> -       .hw_free = cz_da7219_hw_free,
> +       .startup = cz_max_startup,
> +       .shutdown = cz_max_shutdown,
>   };

>   static struct snd_soc_ops cz_dmic_cap_ops = {
> -       .hw_params = cz_da7219_hw_params,
> -       .hw_free = cz_da7219_hw_free,
> +       .startup = cz_dmic_startup,
> +       .shutdown = cz_dmic_shutdown,
>   };

>   static struct snd_soc_dai_link cz_dai_7219_98357[] = {
> --
> 2.7.4
