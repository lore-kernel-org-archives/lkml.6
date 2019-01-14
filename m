Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12DA8C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 16:02:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C13FF2086D
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 16:02:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="u6LF4EnM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726759AbfANQCB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 11:02:01 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:37550 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726674AbfANQCB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 11:02:01 -0500
Received: by mail-pg1-f196.google.com with SMTP id c25so9638697pgb.4
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 08:02:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=gxQ9Aw15DeoI4moC2VJqIEkTVG5aPdFcj18MDxQPjp8=;
        b=u6LF4EnMcOiNZleiyUm60OYosTyyMBuTJkgzetBREixHUihHy64QhffGHhRwVYZOgn
         713kL5F9xO9dm89eF9WjAHzRAo9ySU30/Xor0qQgljNkKYtirlBr2ctPAKNtRyu3GZ0g
         0lu9ZM3YTFTMje+A5P2sB32oliaBRbEHr9cvFx1wmBQ/pxXarJjPUN+xQKGCEmsNbsNr
         xFsYBusxfz0mf+1RZ0NRi3aDJa+eB2wXksZzBvsBggLpJXs+aB5ya90qjxEH/rAsbNZH
         MqZiodIr8P1grE54/VuD2RiwDlRCr6hvQXvqXHfxEZQshHJlLluiltwfu7OAyQMkKI4J
         u62g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=gxQ9Aw15DeoI4moC2VJqIEkTVG5aPdFcj18MDxQPjp8=;
        b=qY2yplQ6Q75sh0tBC5jL1DHl/MEtoPmOKnA/py2rQpkxwEjzGKMkYqrcoAZuYPBGVQ
         y8X3HwW3tIqZQVzotJB+GWZQRVVInlXCoXZ8tqSr1yg4fdvmdG7dYvcJ+HwK52MzBDSi
         /Sn86YCZAafCut7PqOeqhMP3r4a02TmC343Bn4ja4grtwnfnEtWvG4Or7G5vpMjGgdBD
         zt0dDygKZ8ue6n7yFgVwm0MgwXHGrbBpRMzlMTcN5qwD3HRiV3nYPzTNlNMKkyH8t3y2
         dK0Lc11s1bWWaoQ8nAel2McOJ3aXe4yJG2v0tISj8zzAlxY4zNm86pZqK0XQ415d2iqg
         V5Xg==
X-Gm-Message-State: AJcUukdCPq88DwnFBriZnFvEzeUAXza7nb++1Ka5fjpi/ed/G8ST6ORj
        6102WaupMfWBeTvdkos0a2dy3g==
X-Google-Smtp-Source: ALg8bN7V4VHmna7sTIrCzjOgXoN+d6ul2XCD6IFFD9PFMk7wYXCXYda1AUSEEWorhVnYNT+v2bGFng==
X-Received: by 2002:a62:3141:: with SMTP id x62mr25828025pfx.12.1547481719762;
        Mon, 14 Jan 2019 08:01:59 -0800 (PST)
Received: from localhost ([2601:602:9200:a1a5:55a3:6ea4:4b91:28a5])
        by smtp.googlemail.com with ESMTPSA id 5sm977151pfz.149.2019.01.14.08.01.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 14 Jan 2019 08:01:58 -0800 (PST)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Loys Ollivier <lollivier@baylibre.com>, devicetree@vger.kernel.org,
        linux-amlogic@lists.infradead.org
Cc:     Loys Ollivier <lollivier@baylibre.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: Re: [PATCH v4] arm64: dts: meson: Fix mmc cd-gpios polarity
In-Reply-To: <1547477061-31543-1-git-send-email-lollivier@baylibre.com>
References: <1547477061-31543-1-git-send-email-lollivier@baylibre.com>
Date:   Mon, 14 Jan 2019 08:01:58 -0800
Message-ID: <7hh8ebmdmx.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Loys Ollivier <lollivier@baylibre.com> writes:

> Commit 89a5e15bcba8 ("gpio/mmc/of: Respect polarity in the device tree")
> changed the behavior of "cd-inverted" to follow the device tree bindings
> specification:
> According to SDHCI standard, CD lines are specified as "active low".
> Using the "cd-inverted" property means that the CD line is "active high".
>
> Fix the SD card description for meson by setting the cd-gpios as
> "active low", according to the boards specifications, and dropping the
> "cd-inverted" property.
>
> Fixes: 89a5e15bcba8 ("gpio/mmc/of: Respect polarity in the device tree")
> Signed-off-by: Loys Ollivier <lollivier@baylibre.com>

Queued as fix for v5.0-rc. (I replaced v3 in my fixes branch with this
one)

Kevin

> ---
>
> v4: commit message clarification on the "cd-inverted" property and usage.
>
> v3: fix typos in the commit message.
>
> v2: fix more occurences, also in other meson boards.
>
>  arch/arm64/boot/dts/amlogic/meson-gx-p23x-q20x.dtsi            | 3 +--
>  arch/arm64/boot/dts/amlogic/meson-gxbb-nanopi-k2.dts           | 3 +--
>  arch/arm64/boot/dts/amlogic/meson-gxbb-nexbox-a95x.dts         | 3 +--
>  arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts            | 3 +--
>  arch/arm64/boot/dts/amlogic/meson-gxbb-p20x.dtsi               | 3 +--
>  arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95.dtsi           | 3 +--
>  arch/arm64/boot/dts/amlogic/meson-gxbb-wetek.dtsi              | 3 +--
>  arch/arm64/boot/dts/amlogic/meson-gxl-s905x-hwacom-amazetv.dts | 3 +--
>  arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts   | 3 +--
>  arch/arm64/boot/dts/amlogic/meson-gxl-s905x-nexbox-a95x.dts    | 3 +--
>  arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dtsi          | 3 +--
>  arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts          | 3 +--
>  arch/arm64/boot/dts/amlogic/meson-gxm-nexbox-a1.dts            | 3 +--
>  arch/arm64/boot/dts/amlogic/meson-gxm-rbox-pro.dts             | 3 +--
>  14 files changed, 14 insertions(+), 28 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/amlogic/meson-gx-p23x-q20x.dtsi b/arch/arm64/boot/dts/amlogic/meson-gx-p23x-q20x.dtsi
> index e14e0ce7e89f..016641a41694 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-gx-p23x-q20x.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-gx-p23x-q20x.dtsi
> @@ -187,8 +187,7 @@
>  	max-frequency = <100000000>;
>  	disable-wp;
>  
> -	cd-gpios = <&gpio CARD_6 GPIO_ACTIVE_HIGH>;
> -	cd-inverted;
> +	cd-gpios = <&gpio CARD_6 GPIO_ACTIVE_LOW>;
>  
>  	vmmc-supply = <&vddao_3v3>;
>  	vqmmc-supply = <&vddio_boot>;
> diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-nanopi-k2.dts b/arch/arm64/boot/dts/amlogic/meson-gxbb-nanopi-k2.dts
> index 8cd50b75171d..ade2ee09ae96 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-gxbb-nanopi-k2.dts
> +++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-nanopi-k2.dts
> @@ -305,8 +305,7 @@
>  	max-frequency = <200000000>;
>  	disable-wp;
>  
> -	cd-gpios = <&gpio CARD_6 GPIO_ACTIVE_HIGH>;
> -	cd-inverted;
> +	cd-gpios = <&gpio CARD_6 GPIO_ACTIVE_LOW>;
>  
>  	vmmc-supply = <&vddio_ao3v3>;
>  	vqmmc-supply = <&vddio_tf>;
> diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-nexbox-a95x.dts b/arch/arm64/boot/dts/amlogic/meson-gxbb-nexbox-a95x.dts
> index 4cf7f6e80c6a..25105ac96d55 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-gxbb-nexbox-a95x.dts
> +++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-nexbox-a95x.dts
> @@ -238,8 +238,7 @@
>  	max-frequency = <100000000>;
>  	disable-wp;
>  
> -	cd-gpios = <&gpio CARD_6 GPIO_ACTIVE_HIGH>;
> -	cd-inverted;
> +	cd-gpios = <&gpio CARD_6 GPIO_ACTIVE_LOW>;
>  
>  	vmmc-supply = <&vddao_3v3>;
>  	vqmmc-supply = <&vddio_card>;
> diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts b/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
> index 2e1cd5e3a246..1cc9dc68ef00 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
> +++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
> @@ -258,8 +258,7 @@
>  	max-frequency = <100000000>;
>  	disable-wp;
>  
> -	cd-gpios = <&gpio CARD_6 GPIO_ACTIVE_HIGH>;
> -	cd-inverted;
> +	cd-gpios = <&gpio CARD_6 GPIO_ACTIVE_LOW>;
>  
>  	vmmc-supply = <&tflash_vdd>;
>  	vqmmc-supply = <&tf_io>;
> diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-p20x.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxbb-p20x.dtsi
> index ce862266b9aa..0be0f2a5d2fe 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-gxbb-p20x.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-p20x.dtsi
> @@ -196,8 +196,7 @@
>  	max-frequency = <100000000>;
>  	disable-wp;
>  
> -	cd-gpios = <&gpio CARD_6 GPIO_ACTIVE_HIGH>;
> -	cd-inverted;
> +	cd-gpios = <&gpio CARD_6 GPIO_ACTIVE_LOW>;
>  
>  	vmmc-supply = <&vddao_3v3>;
>  	vqmmc-supply = <&vddio_card>;
> diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95.dtsi
> index 93a4acf2c46c..ad4d50bd9d77 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95.dtsi
> @@ -154,8 +154,7 @@
>  	max-frequency = <100000000>;
>  	disable-wp;
>  
> -	cd-gpios = <&gpio CARD_6 GPIO_ACTIVE_HIGH>;
> -	cd-inverted;
> +	cd-gpios = <&gpio CARD_6 GPIO_ACTIVE_LOW>;
>  
>  	vmmc-supply = <&vcc_3v3>;
>  };
> diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-wetek.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxbb-wetek.dtsi
> index ec09bb5792b7..2d2db783c44c 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-gxbb-wetek.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-wetek.dtsi
> @@ -211,8 +211,7 @@
>  	max-frequency = <100000000>;
>  	disable-wp;
>  
> -	cd-gpios = <&gpio CARD_6 GPIO_ACTIVE_HIGH>;
> -	cd-inverted;
> +	cd-gpios = <&gpio CARD_6 GPIO_ACTIVE_LOW>;
>  
>  	vmmc-supply = <&vddao_3v3>;
>  	vqmmc-supply = <&vcc_3v3>;
> diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-hwacom-amazetv.dts b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-hwacom-amazetv.dts
> index f1c410e2da2b..796baea7a0bf 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-hwacom-amazetv.dts
> +++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-hwacom-amazetv.dts
> @@ -131,8 +131,7 @@
>  	max-frequency = <100000000>;
>  	disable-wp;
>  
> -	cd-gpios = <&gpio CARD_6 GPIO_ACTIVE_HIGH>;
> -	cd-inverted;
> +	cd-gpios = <&gpio CARD_6 GPIO_ACTIVE_LOW>;
>  
>  	vmmc-supply = <&vddao_3v3>;
>  	vqmmc-supply = <&vddio_card>;
> diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts
> index db293440e4ca..255cede7b447 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts
> +++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts
> @@ -238,8 +238,7 @@
>  	max-frequency = <100000000>;
>  	disable-wp;
>  
> -	cd-gpios = <&gpio CARD_6 GPIO_ACTIVE_HIGH>;
> -	cd-inverted;
> +	cd-gpios = <&gpio CARD_6 GPIO_ACTIVE_LOW>;
>  
>  	vmmc-supply = <&vcc_3v3>;
>  	vqmmc-supply = <&vcc_card>;
> diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-nexbox-a95x.dts b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-nexbox-a95x.dts
> index 6739697be1de..9cbdb85fb591 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-nexbox-a95x.dts
> +++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-nexbox-a95x.dts
> @@ -183,8 +183,7 @@
>  	max-frequency = <100000000>;
>  	disable-wp;
>  
> -	cd-gpios = <&gpio CARD_6 GPIO_ACTIVE_HIGH>;
> -	cd-inverted;
> +	cd-gpios = <&gpio CARD_6 GPIO_ACTIVE_LOW>;
>  
>  	vmmc-supply = <&vddao_3v3>;
>  	vqmmc-supply = <&vddio_card>;
> diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dtsi
> index a1b31013ab6e..bc811a2faf42 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dtsi
> @@ -137,8 +137,7 @@
>  	max-frequency = <100000000>;
>  	disable-wp;
>  
> -	cd-gpios = <&gpio CARD_6 GPIO_ACTIVE_HIGH>;
> -	cd-inverted;
> +	cd-gpios = <&gpio CARD_6 GPIO_ACTIVE_LOW>;
>  
>  	vmmc-supply = <&vddao_3v3>;
>  	vqmmc-supply = <&vddio_boot>;
> diff --git a/arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts b/arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts
> index 3c3a667a8df8..3f086ed7de05 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts
> +++ b/arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts
> @@ -356,8 +356,7 @@
>  	max-frequency = <100000000>;
>  	disable-wp;
>  
> -	cd-gpios = <&gpio CARD_6 GPIO_ACTIVE_HIGH>;
> -	cd-inverted;
> +	cd-gpios = <&gpio CARD_6 GPIO_ACTIVE_LOW>;
>  
>  	vmmc-supply = <&vddao_3v3>;
>  	vqmmc-supply = <&vddio_boot>;
> diff --git a/arch/arm64/boot/dts/amlogic/meson-gxm-nexbox-a1.dts b/arch/arm64/boot/dts/amlogic/meson-gxm-nexbox-a1.dts
> index f7a1cffab4a8..8acfd40090d2 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-gxm-nexbox-a1.dts
> +++ b/arch/arm64/boot/dts/amlogic/meson-gxm-nexbox-a1.dts
> @@ -147,8 +147,7 @@
>  	max-frequency = <100000000>;
>  	disable-wp;
>  
> -	cd-gpios = <&gpio CARD_6 GPIO_ACTIVE_HIGH>;
> -	cd-inverted;
> +	cd-gpios = <&gpio CARD_6 GPIO_ACTIVE_LOW>;
>  
>  	vmmc-supply = <&vddao_3v3>;
>  	vqmmc-supply = <&vddio_boot>;
> diff --git a/arch/arm64/boot/dts/amlogic/meson-gxm-rbox-pro.dts b/arch/arm64/boot/dts/amlogic/meson-gxm-rbox-pro.dts
> index 7212dc4531e4..7fa20a8ede17 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-gxm-rbox-pro.dts
> +++ b/arch/arm64/boot/dts/amlogic/meson-gxm-rbox-pro.dts
> @@ -170,8 +170,7 @@
>  	max-frequency = <100000000>;
>  	disable-wp;
>  
> -	cd-gpios = <&gpio CARD_6 GPIO_ACTIVE_HIGH>;
> -	cd-inverted;
> +	cd-gpios = <&gpio CARD_6 GPIO_ACTIVE_LOW>;
>  
>  	vmmc-supply = <&vddao_3v3>;
>  	vqmmc-supply = <&vddio_boot>;
> -- 
> 2.7.4
