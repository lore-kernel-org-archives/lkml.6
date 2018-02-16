Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1423140AbeBPCrf (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 21:47:35 -0500
Received: from mail-it0-f66.google.com ([209.85.214.66]:34891 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1423102AbeBPCrd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 21:47:33 -0500
X-Google-Smtp-Source: AH8x226PWCPvUG080ReMlvREErvOVwKnMcBVNAQYBXJRXEGZjNDKuf3TILqIdwcEDTeN5gQ7kqMpCg==
Date: Thu, 15 Feb 2018 18:47:29 -0800
From: Brian Norris <briannorris@chromium.org>
To: Matthias Kaehlcke <mka@chromium.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dylan Reid <dgreid@chromium.org>, huang lin <hl@rock-chips.com>
Subject: Re: [PATCH v2] ASoC: dmic: Add optional wakeup delay
Message-ID: <20180216024728.GA93733@rodete-desktop-imager.corp.google.com>
References: <20180216022416.208265-1-mka@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180216022416.208265-1-mka@chromium.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Feb 15, 2018 at 06:24:16PM -0800, Matthias Kaehlcke wrote:
> On some systems a delay is needed after switching on the clocks, to allow
> the output to stabilize and avoid a popping noise at the beginning of
> the recording. Add the optional device tree property 'wakeup-delay-ms'
> and apply the specified delay after enabling the mic. A blocking delay
> can't be applied in dmic_daiops_trigger() since the function is called
> in atomic context. Instead use a DAPM event handler to set the enable
> GPIO and apply the delay in the handler.
> 
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
> Changes in v2:
> - use DAPM event handler instead of _prepare() and get rid of
>   _trigger()
> - skip error check for optional 'wakeup-delay-ms' property
> - updated commit message

Looks good to me in general:

Brian Norris <briannorris@chromium.org>

But I don't know much about the audio subsystem. One comment below.

> 
>  .../devicetree/bindings/sound/dmic.txt        |  2 +
>  sound/soc/codecs/dmic.c                       | 63 ++++++++++---------
>  2 files changed, 37 insertions(+), 28 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/sound/dmic.txt b/Documentation/devicetree/bindings/sound/dmic.txt
> index f7bf65611453..e957b4136716 100644
> --- a/Documentation/devicetree/bindings/sound/dmic.txt
> +++ b/Documentation/devicetree/bindings/sound/dmic.txt
> @@ -8,6 +8,7 @@ Required properties:
>  Optional properties:
>  	- dmicen-gpios: GPIO specifier for dmic to control start and stop
>  	- num-channels: Number of microphones on this DAI
> +	- wakeup-delay-ms: Delay (in ms) after enabling the DMIC
>  
>  Example node:
>  
> @@ -15,4 +16,5 @@ Example node:
>  		compatible = "dmic-codec";
>  		dmicen-gpios = <&gpio4 3 GPIO_ACTIVE_HIGH>;
>  		num-channels = <1>;
> +		wakeup-delay-ms <50>;
>  	};
> diff --git a/sound/soc/codecs/dmic.c b/sound/soc/codecs/dmic.c
> index cf83c423394d..b5f60ac22ace 100644
> --- a/sound/soc/codecs/dmic.c
> +++ b/sound/soc/codecs/dmic.c
[...]

>  static const struct snd_soc_dapm_widget dmic_dapm_widgets[] = {
> -	SND_SOC_DAPM_AIF_OUT("DMIC AIF", "Capture", 0,
> -			     SND_SOC_NOPM, 0, 0),
> +	SND_SOC_DAPM_AIF_OUT_E("DMIC AIF", "Capture", 0,
> +			       SND_SOC_NOPM, 0, 0, dmic_aif_event,
> +			       SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_POST_PMD),

Any good reason both are _POST_? It seems like you'd want them to be
inverses (e.g., power-power-up, and pre-power-down).

>  	SND_SOC_DAPM_INPUT("DMic"),
>  };
>  

Brian
