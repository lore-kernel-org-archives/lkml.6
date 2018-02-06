Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752970AbeBFM0v (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 07:26:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:55576 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752392AbeBFM0o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 07:26:44 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE7FD20835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=krzk@kernel.org
X-Google-Smtp-Source: AH8x226Xr2BNrkX7Eiq6j37W3hsQ6YC0jgJ6VRE64NKM4rEO+S2FTq6qsAHhxvUqk8ER3gIEcD7bHaEMCV42rWgCKUg=
MIME-Version: 1.0
In-Reply-To: <20180205154403.13520-5-s.nawrocki@samsung.com>
References: <CGME20180205154520epcas1p4132421a187a4d767a2f75badfef5eec4@epcas1p4.samsung.com>
 <20180205154403.13520-1-s.nawrocki@samsung.com> <20180205154403.13520-5-s.nawrocki@samsung.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Tue, 6 Feb 2018 13:26:41 +0100
X-Gmail-Original-Message-ID: <CAJKOXPf-6wFDSPttdDbc34Y2hiuc=TG2j5bb+2uQeScxGuxjZg@mail.gmail.com>
Message-ID: <CAJKOXPf-6wFDSPttdDbc34Y2hiuc=TG2j5bb+2uQeScxGuxjZg@mail.gmail.com>
Subject: Re: [PATCH 4/8] ASoC: samsung: i2s: Define the parameters list for SAMSUNG_I2S_OPCLK
To: Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc: broonie@kernel.org, lgirdwood@gmail.com, alsa-devel@alsa-project.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, jcsing.lee@samsung.com,
        sbkim73@samsung.com, linux-kernel@vger.kernel.org,
        =?UTF-8?B?QmFydMWCb21pZWogxbtvxYJuaWVya2lld2ljeg==?=
        <b.zolnierkie@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 5, 2018 at 4:43 PM, Sylwester Nawrocki
<s.nawrocki@samsung.com> wrote:
> The SAMSUNG_I2S_OPCLK is not currently used by any card driver thus we can
> safely change semantics of 'dir' argument of the I2S set_sysclk() callback.
> Now an anumeration is exported instead of directly using register bitfield
> values.
>
> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> ---
>  sound/soc/samsung/i2s-regs.h | 11 ++++++-----
>  sound/soc/samsung/i2s.c      |  2 +-
>  sound/soc/samsung/i2s.h      | 11 ++++++++---
>  3 files changed, 15 insertions(+), 9 deletions(-)
>
> diff --git a/sound/soc/samsung/i2s-regs.h b/sound/soc/samsung/i2s-regs.h
> index fe6914005494..964985ea2e80 100644
> --- a/sound/soc/samsung/i2s-regs.h
> +++ b/sound/soc/samsung/i2s-regs.h
> @@ -65,11 +65,12 @@
>  #define CON_RXDMA_ACTIVE       (1 << 1)
>  #define CON_ACTIVE             (1 << 0)
>
> -#define MOD_OPCLK_CDCLK_OUT    (0 << 30)
> -#define MOD_OPCLK_CDCLK_IN     (1 << 30)
> -#define MOD_OPCLK_BCLK_OUT     (2 << 30)
> -#define MOD_OPCLK_PCLK         (3 << 30)
> -#define MOD_OPCLK_MASK         (3 << 30)
> +#define MOD_OPCLK_SHIFT                30
> +#define MOD_OPCLK_CDCLK_OUT    (0 << MOD_OPCLK_SHIFT)
> +#define MOD_OPCLK_CDCLK_IN     (1 << MOD_OPCLK_SHIFT)
> +#define MOD_OPCLK_BCLK_OUT     (2 << MOD_OPCLK_SHIFT)
> +#define MOD_OPCLK_PCLK         (3 << MOD_OPCLK_SHIFT)
> +#define MOD_OPCLK_MASK         (3 << MOD_OPCLK_SHIFT)
>  #define MOD_TXS_IDMA           (1 << 28) /* Sec_TXFIFO use I-DMA */
>
>  #define MOD_BLCS_SHIFT         26
> diff --git a/sound/soc/samsung/i2s.c b/sound/soc/samsung/i2s.c
> index 1c05170e4999..6d768cdb4326 100644
> --- a/sound/soc/samsung/i2s.c
> +++ b/sound/soc/samsung/i2s.c
> @@ -489,7 +489,7 @@ static int i2s_set_sysclk(struct snd_soc_dai *dai,
>         switch (clk_id) {
>         case SAMSUNG_I2S_OPCLK:
>                 mask = MOD_OPCLK_MASK;
> -               val = dir;
> +               val = (dir << MOD_OPCLK_SHIFT) & MOD_OPCLK_MASK;
>                 break;
>         case SAMSUNG_I2S_CDCLK:
>                 mask = 1 << i2s_regs->cdclkcon_off;
> diff --git a/sound/soc/samsung/i2s.h b/sound/soc/samsung/i2s.h
> index 79781de2f247..a9832a9555cb 100644
> --- a/sound/soc/samsung/i2s.h
> +++ b/sound/soc/samsung/i2s.h
> @@ -16,11 +16,16 @@
>  #define SAMSUNG_I2S_DAI        "samsung-i2s"
>  #define SAMSUNG_I2S_DAI_SEC    "samsung-i2s-sec"
>
> -#define SAMSUNG_I2S_DIV_BCLK   1
> +#define SAMSUNG_I2S_DIV_BCLK           1
>
> -#define SAMSUNG_I2S_RCLKSRC_0  0
> -#define SAMSUNG_I2S_RCLKSRC_1  1
> +#define SAMSUNG_I2S_RCLKSRC_0          0
> +#define SAMSUNG_I2S_RCLKSRC_1          1
>  #define SAMSUNG_I2S_CDCLK              2
> +/* Operation clock for IIS logic */
>  #define SAMSUNG_I2S_OPCLK              3
> +#define  SAMSUNG_I2S_OPCLK_CDCLK_OUT   0       /* CODEC clock out */
> +#define  SAMSUNG_I2S_OPCLK_CDCLK_IN    1       /* CODEC clock in */
> +#define  SAMSUNG_I2S_OPCLK_BCLK_OUT    2       /* Bit clock out */
> +#define  SAMSUNG_I2S_OPCLK_PCLK                3       /* Audio bus clock */
>
>  #endif /* __SND_SOC_SAMSUNG_I2S_H */

This part of patch seems to be unrelated (and it includes some cleanups).

Best regards,
Krzysztof
