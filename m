Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75616C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 13:37:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43EBE21B1C
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 13:37:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549892239;
	bh=P1qRN2T8Du2uRQnv2ASpufGMWnJoTHxM+sHiShtW4PY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=xaAa21h+hzTNw6LCOZw8bDBGJIT1zPZDPmXNn5F8LRds25J7zWByThZF0DHRrAWgY
	 uIwKpJU1X9m6aAV5H6hmNZjQX9MCC+gPvUpdtGYnanwcCMYT44S7vYhFc33qtbO7z/
	 mlkbC9kFNISW5iRaJ7bhhJW1jGDaM98+HYsZ2kAE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728264AbfBKNhQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 08:37:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:37440 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727929AbfBKNhP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 08:37:15 -0500
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7846221B68;
        Mon, 11 Feb 2019 13:37:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549892234;
        bh=P1qRN2T8Du2uRQnv2ASpufGMWnJoTHxM+sHiShtW4PY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=eRY5BYE2nrlomTh1aIfB5qSuodqf75Gio+RzNiExZ4hym1gT/CLcbCAkEpvwSznfV
         iV9s4YA1CTfshpiCBsn2WlPLjlHBaLsLm9aVmJN/LG3TeBQzpfxin/BkxJBc+uJ3lO
         XVSjm+cqlYGCBVCF7XWvQywbNvNQD+r+BaG2j+YQ=
Received: by mail-lf1-f49.google.com with SMTP id t14so7748952lfk.7;
        Mon, 11 Feb 2019 05:37:14 -0800 (PST)
X-Gm-Message-State: AHQUAuZsNtFrNmz3UJjPEGISIvGIwEAqmu1b1GRD+MlY44uYsRTksKWr
        s+k04tZTCQnxp2uHkD1CNQU6k1Ssm8s8ag74I5E=
X-Google-Smtp-Source: AHgI3IbF2DPIcptp26gqAgEID9pofDryNgLHDXvHz/mdp/M5qSl8WQyjf9hPE7OJIbnAzlRQWB0q0E1TOJCQ3OXtNCo=
X-Received: by 2002:a19:f013:: with SMTP id p19mr3574318lfc.154.1549892232631;
 Mon, 11 Feb 2019 05:37:12 -0800 (PST)
MIME-Version: 1.0
References: <CGME20190207170058epcas1p4e2fadf4aae2ece3c47c0750a094a4fbb@epcas1p4.samsung.com>
 <20190207170028.720-1-s.nawrocki@samsung.com> <20190207170028.720-5-s.nawrocki@samsung.com>
In-Reply-To: <20190207170028.720-5-s.nawrocki@samsung.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Mon, 11 Feb 2019 14:37:01 +0100
X-Gmail-Original-Message-ID: <CAJKOXPdar1q8oz4KHEVoQ6_NbD+hUYfFE3u97VLGUV7azEnZwA@mail.gmail.com>
Message-ID: <CAJKOXPdar1q8oz4KHEVoQ6_NbD+hUYfFE3u97VLGUV7azEnZwA@mail.gmail.com>
Subject: Re: [PATCH 04/22] ASoC: samsung: i2s: Fix prescaler setting for the
 secondary DAI
To:     Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc:     broonie@kernel.org, lgirdwood@gmail.com, sbkim73@samsung.com,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        =?UTF-8?B?QmFydMWCb21pZWogxbtvxYJuaWVya2lld2ljeg==?= 
        <b.zolnierkie@samsung.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Feb 2019 at 18:01, Sylwester Nawrocki <s.nawrocki@samsung.com> wrote:
>
> Make sure i2s->rclk_srcrate is properly initialized also during
> playback through the secondary DAI.
>
> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> ---
>  sound/soc/samsung/i2s.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/sound/soc/samsung/i2s.c b/sound/soc/samsung/i2s.c
> index 9d3dcb2204fe..d5ddad23d5e5 100644
> --- a/sound/soc/samsung/i2s.c
> +++ b/sound/soc/samsung/i2s.c
> @@ -604,6 +604,7 @@ static int i2s_set_fmt(struct snd_soc_dai *dai,
>         unsigned int fmt)
>  {
>         struct i2s_dai *i2s = to_info(dai);
> +       struct i2s_dai *other = get_other_dai(i2s);
>         int lrp_shift, sdf_shift, sdf_mask, lrp_rlow, mod_slave;
>         u32 mod, tmp = 0;
>         unsigned long flags;
> @@ -661,7 +662,8 @@ static int i2s_set_fmt(struct snd_soc_dai *dai,
>                  * CLK_I2S_RCLK_SRC clock is not exposed so we ensure any
>                  * clock configuration assigned in DT is not overwritten.
>                  */
> -               if (i2s->rclk_srcrate == 0 && i2s->clk_data.clks == NULL)
> +               if (i2s->rclk_srcrate == 0 && i2s->clk_data.clks == NULL &&
> +                   other->clk_data.clks == NULL)
>                         i2s_set_sysclk(dai, SAMSUNG_I2S_RCLKSRC_0,
>                                                         0, SND_SOC_CLOCK_IN);
>                 break;
> @@ -699,6 +701,7 @@ static int i2s_hw_params(struct snd_pcm_substream *substream,
>         struct snd_pcm_hw_params *params, struct snd_soc_dai *dai)
>  {
>         struct i2s_dai *i2s = to_info(dai);
> +       struct i2s_dai *other = get_other_dai(i2s);
>         u32 mod, mask = 0, val = 0;
>         struct clk *rclksrc;
>         unsigned long flags;
> @@ -784,6 +787,9 @@ static int i2s_hw_params(struct snd_pcm_substream *substream,
>         i2s->frmclk = params_rate(params);
>
>         rclksrc = i2s->clk_table[CLK_I2S_RCLK_SRC];
> +       if (!rclksrc || IS_ERR(rclksrc))

IS_ERR_OR_NULL

Best regards,
Krzysztof

> +               rclksrc = other->clk_table[CLK_I2S_RCLK_SRC];
> +
>         if (rclksrc && !IS_ERR(rclksrc))
>                 i2s->rclk_srcrate = clk_get_rate(rclksrc);
>
> --
> 2.20.1
>
