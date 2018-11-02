Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 825CDC32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 16:00:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B86520657
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 16:00:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qma06XtM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B86520657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726858AbeKCBIO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 21:08:14 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43149 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726085AbeKCBIN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 21:08:13 -0400
Received: by mail-pf1-f196.google.com with SMTP id h4-v6so1214893pfi.10
        for <linux-kernel@vger.kernel.org>; Fri, 02 Nov 2018 09:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cNVcU0fi4ZnuuHrs2zMXF4JSKLzsqgsWkwF8WpPBa+w=;
        b=qma06XtMMlJqCFfNeOq8acUtrBKgHQ0PjnHMaQ3Nty1tgUbLqZRsv6ko30FaWfcr5Q
         frEwqo3F334cpNbXS38BJgStPqt/hPkZPZ4uigjRDh2af1nWqxt1hOeyUSzjyeuvQGwE
         0vjqU/+s0rTMrWqhvJ1Smv3vnPF0bQOEmRQLV4S4yVqFvOVGeUK05DEjIRLo/DTe15Tm
         osY5nPjInWSFLGeeuXiQS1EaTTM30Llz1ZtHOF3Mfo8vDoU0K3KykzcTsXi0X3ACvUn+
         iGewL+fclc5TcztkpYFtRUcEeO53Dehl3CyAyBwDWD23hSKqIcMF5YmqR+jE0mCfBbXJ
         gNpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cNVcU0fi4ZnuuHrs2zMXF4JSKLzsqgsWkwF8WpPBa+w=;
        b=WOQH/Xr21jOaHV8A2ypbp+RSX4LLlJo8B9BQ95dU7s5CSyzd98+wGUjhTE/D0VXA9C
         ZpofSBfYd/C3hM/ilCJ3j4iJpTpkvSTXQMSGKPrIQ9ClMoXW5d/PquqUFDzZdPg6/+mI
         AJlLbiG0GniN9CuoBJRRiebg9/eXhb0doC++Va/6mJTDFqi7Gkii2b9JWvrJGfVtBiKU
         egR79nWAYuQuc2rhudW2SiJ9qv3tVYVZ1k7TPgGBblPWWT5K9Uet8qvLR6nLkjFWTlYm
         ajNGtTB6O00+Ehk1bS43b3vBGvyHiz4UVG5qvZdGFR5TMxbZpsF9TUZ4vqvUnapiF56T
         Yaag==
X-Gm-Message-State: AGRZ1gIuyqT0yvVZoRrVDqCzg6uTMP6sqly/B9aHa2Iodx9qmUGYz8+V
        icCamDHCrpr/zWIXwsVcWX4=
X-Google-Smtp-Source: AJdET5ejRh6MURz3CB8x80xzkKfrpRjfdw1I60KcN5Aql8kgowPYGqAPWd4lyN+Gpza7scbSUnzryQ==
X-Received: by 2002:a62:da0c:: with SMTP id c12-v6mr12565893pfh.52.1541174438674;
        Fri, 02 Nov 2018 09:00:38 -0700 (PDT)
Received: from anarsoul-thinkpad.localnet (216-71-193-140.dyn.novuscom.net. [216.71.193.140])
        by smtp.gmail.com with ESMTPSA id 5-v6sm68223371pgt.83.2018.11.02.09.00.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 02 Nov 2018 09:00:37 -0700 (PDT)
From:   Vasily Khoruzhick <anarsoul@gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, alsa-devel@alsa-project.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: sunxi: rename SND_SUN8I_ADDA_PR_REGMAP
Date:   Fri, 02 Nov 2018 09:00:36 -0700
Message-ID: <13542843.KjxkD9786N@anarsoul-thinkpad>
In-Reply-To: <20181102153406.1528053-1-arnd@arndb.de>
References: <20181102153406.1528053-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, November 2, 2018 8:33:40 AM PDT Arnd Bergmann wrote:
> The newly added SND_SUN50I_CODEC_ANALOG driver selects a nonexisting
> symbol SND_SUNXI_ADDA_PR_REGMAP, which was evidently intended to replace
> SND_SUN8I_ADDA_PR_REGMAP, but since they are now mismatched, we can run
> into link errors for some configurations:
> 
> sound/soc/sunxi/sun50i-codec-analog.o: In function
> `sun50i_codec_analog_probe': sun50i-codec-analog.c:(.text+0x62): undefined
> reference to `sun8i_adda_pr_regmap_init'
> 
> The new name appears to be more sensible, and as the symbol is hidden,
> there are no downsides in the rename, so use that consistently now.

Maxime asked it to be SND_SUN8I_ADDA_PR_REGMAP, and also it would be easier to 
fix it my renaming last remaining SND_SUNXI_ADDA_PR_REGMAP to 
SND_SUN8I_ADDA_PR_REGMAP.

> Fixes: 42371f327df0 ("ASoC: sunxi: Add new driver for Allwinner A64 codec's
> analog path controls") Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  sound/soc/sunxi/Kconfig  | 4 ++--
>  sound/soc/sunxi/Makefile | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/sound/soc/sunxi/Kconfig b/sound/soc/sunxi/Kconfig
> index 66aad0d3f9c7..0f992bdf1a10 100644
> --- a/sound/soc/sunxi/Kconfig
> +++ b/sound/soc/sunxi/Kconfig
> @@ -23,7 +23,7 @@ config SND_SUN8I_CODEC
>  config SND_SUN8I_CODEC_ANALOG
>  	tristate "Allwinner sun8i Codec Analog Controls Support"
>  	depends on MACH_SUN8I || (ARM64 && ARCH_SUNXI) || COMPILE_TEST
> -	select SND_SUN8I_ADDA_PR_REGMAP
> +	select SND_SUNXI_ADDA_PR_REGMAP
>  	help
>  	  Say Y or M if you want to add support for the analog controls for
>  	  the codec embedded in newer Allwinner SoCs.
> @@ -54,7 +54,7 @@ config SND_SUN4I_SPDIF
>  	  Say Y or M to add support for the S/PDIF audio block in the Allwinner
>  	  A10 and affiliated SoCs.
> 
> -config SND_SUN8I_ADDA_PR_REGMAP
> +config SND_SUNXI_ADDA_PR_REGMAP
>  	tristate
>  	select REGMAP
> 
> diff --git a/sound/soc/sunxi/Makefile b/sound/soc/sunxi/Makefile
> index a86be340a076..c4dd2803a011 100644
> --- a/sound/soc/sunxi/Makefile
> +++ b/sound/soc/sunxi/Makefile
> @@ -5,4 +5,4 @@ obj-$(CONFIG_SND_SUN4I_SPDIF) += sun4i-spdif.o
>  obj-$(CONFIG_SND_SUN8I_CODEC_ANALOG) += sun8i-codec-analog.o
>  obj-$(CONFIG_SND_SUN50I_CODEC_ANALOG) += sun50i-codec-analog.o
>  obj-$(CONFIG_SND_SUN8I_CODEC) += sun8i-codec.o
> -obj-$(CONFIG_SND_SUN8I_ADDA_PR_REGMAP) += sun8i-adda-pr-regmap.o
> +obj-$(CONFIG_SND_SUNXI_ADDA_PR_REGMAP) += sun8i-adda-pr-regmap.o




