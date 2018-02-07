Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753599AbeBGJye (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 04:54:34 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:50861 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752682AbeBGJyc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 04:54:32 -0500
X-Google-Smtp-Source: AH8x227KTv1rm8LktyLJtUpOIdGBvdPsKRVe3PSRkqOI0vHympnIhmWeBkXJkZzEWyvB5YH7Mu1ZzQ==
Subject: Re: [PATCH v2] pwm: mediatek: fix up PWM4 and PWM5 malfunction on
 MT7623
To: sean.wang@mediatek.com, thierry.reding@gmail.com
Cc: linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Zhi Mao <zhi.mao@mediatek.com>, John Crispin <john@phrozen.org>
References: <f94b2d4146ebe0f8eaae02b0dd951f39af0972d4.1517994540.git.sean.wang@mediatek.com>
From: Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <45d75d8d-d1ed-fe69-e936-c369ccb2fd6b@gmail.com>
Date: Wed, 7 Feb 2018 10:54:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <f94b2d4146ebe0f8eaae02b0dd951f39af0972d4.1517994540.git.sean.wang@mediatek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 02/07/2018 10:14 AM, sean.wang@mediatek.com wrote:
> From: Sean Wang <sean.wang@mediatek.com>
> 
> Since the offset for both registers, PWMDWIDTH and PWMTHRES, used to
> control PWM4 or PWM5 are distinct from the other PWMs, whose wrong
> programming on PWM hardware causes waveform cannot be output as expected.
> Thus, the patch adds the extra condition for fixing up the weird case to
> let PWM4 or PWM5 able to work on MT7623.
> 
> v1 -> v2: use pwm45_fixup naming instead of pwm45_quirk
> 
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> Cc: Zhi Mao <zhi.mao@mediatek.com>
> Cc: John Crispin <john@phrozen.org>
> Cc: Matthias Brugger <matthias.bgg@gmail.com>
> ---
>  drivers/pwm/pwm-mediatek.c | 24 +++++++++++++++++++++---
>  1 file changed, 21 insertions(+), 3 deletions(-)
> 

Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>

> diff --git a/drivers/pwm/pwm-mediatek.c b/drivers/pwm/pwm-mediatek.c
> index f5d97e0..796baea 100644
> --- a/drivers/pwm/pwm-mediatek.c
> +++ b/drivers/pwm/pwm-mediatek.c
> @@ -29,7 +29,9 @@
>  #define PWMGDUR			0x0c
>  #define PWMWAVENUM		0x28
>  #define PWMDWIDTH		0x2c
> +#define PWM45DWIDTH_FIXUP	0x30
>  #define PWMTHRES		0x30
> +#define PWM45THRES_FIXUP	0x34
>  
>  #define PWM_CLK_DIV_MAX		7
>  
> @@ -54,6 +56,7 @@ static const char * const mtk_pwm_clk_name[MTK_CLK_MAX] = {
>  
>  struct mtk_pwm_platform_data {
>  	unsigned int num_pwms;
> +	bool pwm45_fixup;
>  };
>  
>  /**
> @@ -66,6 +69,7 @@ struct mtk_pwm_chip {
>  	struct pwm_chip chip;
>  	void __iomem *regs;
>  	struct clk *clks[MTK_CLK_MAX];
> +	const struct mtk_pwm_platform_data *soc;
>  };
>  
>  static const unsigned int mtk_pwm_reg_offset[] = {
> @@ -131,7 +135,8 @@ static int mtk_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
>  {
>  	struct mtk_pwm_chip *pc = to_mtk_pwm_chip(chip);
>  	struct clk *clk = pc->clks[MTK_CLK_PWM1 + pwm->hwpwm];
> -	u32 resolution, clkdiv = 0;
> +	u32 resolution, clkdiv = 0, reg_width = PWMDWIDTH,
> +	    reg_thres = PWMTHRES;
>  	int ret;
>  
>  	ret = mtk_pwm_clk_enable(chip, pwm);
> @@ -151,9 +156,18 @@ static int mtk_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
>  		return -EINVAL;
>  	}
>  
> +	if (pc->soc->pwm45_fixup && pwm->hwpwm > 2) {
> +		/*
> +		 * PWM[4,5] has distinct offset for PWMDWIDTH and PWMTHRES
> +		 * from the other PWMs on MT7623.
> +		 */
> +		reg_width = PWM45DWIDTH_FIXUP;
> +		reg_thres = PWM45THRES_FIXUP;
> +	}
> +
>  	mtk_pwm_writel(pc, pwm->hwpwm, PWMCON, BIT(15) | clkdiv);
> -	mtk_pwm_writel(pc, pwm->hwpwm, PWMDWIDTH, period_ns / resolution);
> -	mtk_pwm_writel(pc, pwm->hwpwm, PWMTHRES, duty_ns / resolution);
> +	mtk_pwm_writel(pc, pwm->hwpwm, reg_width, period_ns / resolution);
> +	mtk_pwm_writel(pc, pwm->hwpwm, reg_thres, duty_ns / resolution);
>  
>  	mtk_pwm_clk_disable(chip, pwm);
>  
> @@ -211,6 +225,7 @@ static int mtk_pwm_probe(struct platform_device *pdev)
>  	data = of_device_get_match_data(&pdev->dev);
>  	if (data == NULL)
>  		return -EINVAL;
> +	pc->soc = data;
>  
>  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  	pc->regs = devm_ioremap_resource(&pdev->dev, res);
> @@ -251,14 +266,17 @@ static int mtk_pwm_remove(struct platform_device *pdev)
>  
>  static const struct mtk_pwm_platform_data mt2712_pwm_data = {
>  	.num_pwms = 8,
> +	.pwm45_fixup = false,
>  };
>  
>  static const struct mtk_pwm_platform_data mt7622_pwm_data = {
>  	.num_pwms = 6,
> +	.pwm45_fixup = false,
>  };
>  
>  static const struct mtk_pwm_platform_data mt7623_pwm_data = {
>  	.num_pwms = 5,
> +	.pwm45_fixup = true,
>  };
>  
>  static const struct of_device_id mtk_pwm_of_match[] = {
> 
