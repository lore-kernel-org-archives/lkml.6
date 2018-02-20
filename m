Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753354AbeBTRHL (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 12:07:11 -0500
Received: from mail-wr0-f196.google.com ([209.85.128.196]:46561 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753293AbeBTRHJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 12:07:09 -0500
X-Google-Smtp-Source: AH8x225DGFCx7Z1xepqyNC7kNWJijxNWTCviasw/HhJpJTvx1rxNsmuzUqrcgTOLsGEtSRok+Kk6lw==
Subject: Re: [PATCH 2/2] ASoC: topology: Add missing clock gating parameter
 when parsing hw_configs
To: linux-kernel@vger.kernel.org
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        alsa-devel@alsa-project.org
References: <20180219060531.17276-1-k.marinushkin@gmail.com>
 <20180219060531.17276-2-k.marinushkin@gmail.com>
From: Kirill Marinushkin <k.marinushkin@gmail.com>
Message-ID: <1266ac89-cedc-24d9-3899-0aca4e0e05fa@gmail.com>
Date: Tue, 20 Feb 2018 18:07:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <20180219060531.17276-2-k.marinushkin@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/19/18 07:05, Kirill Marinushkin wrote:
> Clock gating parameter is a part of `dai_fmt`. It is supported by
> `alsa-lib` when creating a topology binary file, but ignored by kernel
> when loading this topology file.
>
> After applying this commit, the clock gating parameter is not ignored any
> more. The old behaviour is not broken, as by default the parameter value
> is 0.
>
> For example, the following config, based on
> alsa-lib/src/conf/topology/broadwell/broadwell.conf, is now supported:
>
> ~~~~
> SectionHWConfig."CodecHWConfig" {
>         id "1"
>         format "I2S"            # physical audio format.
>         bclk   "master"         # Platform is master of bit clock
>         fsync  "master"         # platform is master of fsync
>         pm_cont_clock "true"    # clock is continuous, and can not be gated
> }
>
> SectionLink."Codec" {
>
>         # used for binding to the physical link
>         id "0"
>
>         hw_configs [
>                 "CodecHWConfig"
>         ]
>
>         default_hw_conf_id "1"
> }
> ~~~~
>
> Signed-off-by: Kirill Marinushkin <k.marinushkin@gmail.com>
> Cc: Liam Girdwood <lgirdwood@gmail.com>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Jaroslav Kysela <perex@perex.cz>
> Cc: Takashi Iwai <tiwai@suse.com>
> Cc: alsa-devel@alsa-project.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  sound/soc/soc-topology.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/sound/soc/soc-topology.c b/sound/soc/soc-topology.c
> index 01a50413c66f..21bd4f96348d 100644
> --- a/sound/soc/soc-topology.c
> +++ b/sound/soc/soc-topology.c
> @@ -1981,6 +1981,12 @@ static void set_link_hw_format(struct snd_soc_dai_link *link,
>  
>  		link->dai_fmt = hw_config->fmt & SND_SOC_DAIFMT_FORMAT_MASK;
>  
> +		/* clock gating */
> +		if (hw_config->clock_cont)
> +			link->dai_fmt |= SND_SOC_DAIFMT_CONT;
> +		else
> +			link->dai_fmt |= SND_SOC_DAIFMT_GATED;
> +
>  		/* clock signal polarity */
>  		invert_bclk = hw_config->invert_bclk;
>  		invert_fsync = hw_config->invert_fsync;

This patch is outdated. Patch v2 is sent in a different thread to replace it.

Best Regards,
Kirill
