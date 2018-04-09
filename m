Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752076AbeDIXqE (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 19:46:04 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:36731 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751663AbeDIXqC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 19:46:02 -0400
X-Auth-Info: yv5Gx+ytTmD/8AZzlzOnGc2RBlILjm/VrNh/abD/A0c=
Subject: Re: [PATCH] ASoC: fsl_esai: Fix divisor calculation failure at lower
 ratio
To: Nicolin Chen <nicoleotsuka@gmail.com>, broonie@kernel.org
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        alsa-devel@alsa-project.org, tiwai@suse.com, perex@perex.cz,
        lgirdwood@gmail.com, fabio.estevam@nxp.com
References: <1523231855-7854-1-git-send-email-nicoleotsuka@gmail.com>
From: Marek Vasut <marex@denx.de>
Message-ID: <42010284-6fbd-2d1a-ffe1-8a825478d1d7@denx.de>
Date: Mon, 9 Apr 2018 23:43:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1523231855-7854-1-git-send-email-nicoleotsuka@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/09/2018 01:57 AM, Nicolin Chen wrote:
> When the desired ratio is less than 256, the savesub (tolerance)
> in the calculation would become 0. This will then fail the loop-
> search immediately without reporting any errors.
> 
> But if the ratio is smaller enough, there is no need to calculate
> the tolerance because PM divisor alone is enough to get the ratio.
> 
> So a simple fix could be just to set PM directly instead of going
> into the loop-search.
> 
> Reported-by: Marek Vasut <marex@denx.de>
> Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
> Cc: Marek Vasut <marex@denx.de>

On i.MX6Q with TI PCM1808
Tested-by: Marek Vasut <marex@denx.de>

> ---
>  sound/soc/fsl/fsl_esai.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/sound/soc/fsl/fsl_esai.c b/sound/soc/fsl/fsl_esai.c
> index 40a7004..da8fd98 100644
> --- a/sound/soc/fsl/fsl_esai.c
> +++ b/sound/soc/fsl/fsl_esai.c
> @@ -144,6 +144,13 @@ static int fsl_esai_divisor_cal(struct snd_soc_dai *dai, bool tx, u32 ratio,
>  
>  	psr = ratio <= 256 * maxfp ? ESAI_xCCR_xPSR_BYPASS : ESAI_xCCR_xPSR_DIV8;
>  
> +	/* Do not loop-search if PM (1 ~ 256) alone can serve the ratio */
> +	if (ratio <= 256) {
> +		pm = ratio;
> +		fp = 1;
> +		goto out;
> +	}
> +
>  	/* Set the max fluctuation -- 0.1% of the max devisor */
>  	savesub = (psr ? 1 : 8)  * 256 * maxfp / 1000;
>  
> 


-- 
Best regards,
Marek Vasut
