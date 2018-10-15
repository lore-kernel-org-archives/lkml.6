Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FORGED_MUA_MOZILLA,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AF12C28CF8
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 08:32:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E091A20853
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 08:32:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Vw4U6nYy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E091A20853
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbeJOQQa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 12:16:30 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:52848 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726566AbeJOQQ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 12:16:29 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20181015083212euoutp023a605e35701ca6a86a9ec5677159706e~duxGj3ZRJ0452704527euoutp02I
        for <linux-kernel@vger.kernel.org>; Mon, 15 Oct 2018 08:32:12 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20181015083212euoutp023a605e35701ca6a86a9ec5677159706e~duxGj3ZRJ0452704527euoutp02I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1539592332;
        bh=aGTh/G0yhH9nSbdLno69o0fsxoeLwkYyKymuyAJsMI0=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=Vw4U6nYyRQ4B/T8skpGgLg0O4RUNFvwkNllMibuFdq0Eh7EEYv1C7kNFDFNPv0Aom
         PPuc+DhynvNh5xhRCzIqrvYtL6VHF5iGHjCtNLFaDMTb4tLlLihmVU6VW/5JqU2Jhv
         FPttzjefZEr6SLhpZoOEaK+noMCymcVs6cf2XOCo=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20181015083210eucas1p2ead61dd7860022e0f6ebd179bd375ef5~duxFfOFOq0289502895eucas1p2f;
        Mon, 15 Oct 2018 08:32:10 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 59.99.04806.A8054CB5; Mon, 15
        Oct 2018 09:32:10 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20181015083209eucas1p2fb3d1961745fdb3007dec317c6441142~duxEkRvmp2005320053eucas1p2D;
        Mon, 15 Oct 2018 08:32:09 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20181015083209eusmtrp1d973644d31eb59493cb2b9703f204dec~duxEUgTjJ0145401454eusmtrp1C;
        Mon, 15 Oct 2018 08:32:09 +0000 (GMT)
X-AuditID: cbfec7f5-34dff700000012c6-bd-5bc4508abeda
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 3C.78.04284.98054CB5; Mon, 15
        Oct 2018 09:32:09 +0100 (BST)
Received: from [106.116.147.30] (unknown [106.116.147.30]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20181015083208eusmtip2619747f46fe26bf73674c7a279993520~duxDXEtXG1270412704eusmtip2_;
        Mon, 15 Oct 2018 08:32:08 +0000 (GMT)
Subject: Re: [RFT PATCH] mmc: pwrseq_simple: Fix incorrect handling of GPIO
 bitmap
To:     Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-mmc@vger.kernel.org, linux-gpio@vger.kernel.org,
        Linux Samsung SOC <linux-samsung-soc@vger.kernel.org>,
        linux-kernel@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org,
        Kukjin Kim <kgene@kernel.org>,
        =?UTF-8?Q?Beno=c3=aet_Cousson?= <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>,
        Enric Balletbo i Serra <eballetbo@gmail.com>,
        Javier Martinez Canillas <javier@dowhile0.org>,
        linux-omap@vger.kernel.org, Heiko Stuebner <heiko@sntech.de>,
        linux-rockchip@lists.infradead.org,
        Carlo Caione <carlo@caione.org>,
        Kevin Hilman <khilman@baylibre.com>,
        linux-amlogic@lists.infradead.org
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Date:   Mon, 15 Oct 2018 10:32:08 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
        Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181012190901.1243-1-jmkrzyszt@gmail.com>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA01Se0hTURjv3HN3d9Wtbkvxy6RoZVTgSnodMqKHf1yCwkCK0qhVF4t0xb1p
        GUFWmjpKy4r0qim9tadzORMxnOaKUasssVpgWWQ+GrQemC5zXiv/+72+830/OCzWXWDC2J2m
        vYJoMibpmUC6urnPFWmObYqf62yYQtylPhVpv3Ebk6f95QyprHpDk8H33SrS2l/AkBfVMiYV
        Z+/RJK+jG5O+LCtFXK47anJm4CpFyoqCiKWjVUWqSgcQMf8qx6SltpghTYN5iBRdyqPJ1/ZB
        TApc9RTx2Sw06bSGkvsvVhHHzfXLJvI/vufTvKctU82bH+VSvK8oE/P35Ldq3lKRw/Du1jqG
        r7p0iK/8UkPxeb65vK31POa9lsmxmo2BS7YLSTtTBXHO0i2BO852f8J7ssP2e77a1enoYogZ
        BbDAzYcHpUcpMwpkddw1BB5rNlbINwRueyVSiBdBWaeT+Tvysua1SjGuImjLOcwoxIMgw+dG
        /tQELg7ePewZMlg2eAg/d2zxZzCXoYa6Cz8pf4bhosDcax5+leYi4Fph3XA+hEuA/tpov6zl
        xsOjwg+0HwdwBDI+v8J+jLkpYOstHsGh8PpD6XAH4NwslNiOUMpwKuT8dKqVq2PAlXWZVvAE
        6HJYR/RwcJ4+TivDRxFkFchqhRxHcLe4ZqRzNDQ6nqn812FuFtyunaPIy6G/8Qnll4EbC229
        45WDxkJ+9TmsyFrIPqZT0jNAdtz6t7bh6XN8EunlUTXlUdXkUdXk/3vLEF2BQoUUKTlRkOaZ
        hH0GyZgspZgSDdt2J1vQ0M91/nZ8r0H1A1vtiGORXqPlNE3xOpUxVUpLtiNgsT5YC3H2eJ12
        uzHtgCDu3iymJAmSHU1iaX2o9sr5yngdl2jcK+wShD2C+Nel2ICwdNRSFR2WrvF26BdaG6Z1
        dvasDSrPDxYfz6qXfkwel+CxTVtSGMt3iSXvvKsm5i5mrhfGBsUsmHpwZdwNed3+ioiP012n
        ViyanykuTqOy7kQtD6e8az57Vg8WLx0T2RxzpbEn3LDQcDihqz4kd2b7pAgTXfbesKGx5cRU
        TfPmyE22vl49Le0wRs3GomT8A3rnOpW1AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA02SfUgTYRzHfXa32zQn5+nwybKXiwgGLU9bPpZJINjhX1JB1AobdanlNrmb
        kREoqJRHZW+GTnGLjGootWm+hGStmVrBxGxUmuQLvWBqGBnLTXPTwP8+PN/v58fvgZ8cox5L
        Y+W5BhPHG3R5NBGGv57vHt5anunSxjt8m9CQxS9FnxseYqhv7gGB7E2DOFoYnZAiz1wVgQZa
        zBiyVbbjqGJsAkPeC80S5HY/kqGbvnsSZK1ZhRxjHilqsvgAEv8+wNDbJ7UEci1UAFRTX4Gj
        mc8LGKpyP5Ugf6sDR9+aY1DnQAbqbjy4ZzU7+/s6zk6/L5OxYu8VCeuvKcPYdvMnGeuwlRPs
        kKeDYJvqi1j7VJuErfDHs62eOoz95ViXGX5YncIbC0zchhyjYNpNaxmUoGaSkTphe7KaSUw6
        ujNBQ29LTTnB5eWe4fhtqcfUOZUTX7H8i7Fnp2ecsmJwRymCUDkkt8N3bR+lIgiTU+RdAAfr
        bPhSsBb23iqWLnEU9HlEYqk0CWBJSx0RCKLIA3Ck50eQoxe5WOySBEoYKcrgjaknWCCgyHYA
        v3yhA0yQDBQnxaCgIFPh0NN6WYBxcjO8X90RfFeSR2DXjdLlTiTsrR4PbhRKIlj6/UNwJkZu
        gb66/mVeD1sna5c5Bn4ct0iuAsq8QjevUMwrFPMKxQpwG4jmCgR9tl5g1IJOLxQYstXHjXoH
        WDyZlpfepjbQb9/vBKQc0OEKMtylpaS6M0Kh3gmgHKOjFfCAU0spTugKz3G8MYsvyOMEJ9As
        fu4aFqs8blw8QIMpi9EwSSiZSUpMStyB6BiFO77wMEVm60zcaY7L5/j/nkQeGlsMyvSu5uGx
        8KyTu9+8Cn3XrDmX8qL/7XmNaqPWqQyp5l1Ww67OBMw8kubNgHFzaTpvhCpysMSAH5qPUK3p
        Q+/Jyz32NemnhvtmG6Lz91bWvpH18CFjXupZevcv9/Pb5/dcatx3XfWz81rHn8HI8qLEkDhL
        7nDGlnHrQKne/31USeNCjo5RYbyg+wee/61xSAMAAA==
Message-Id: <20181015083209eucas1p2fb3d1961745fdb3007dec317c6441142~duxEkRvmp2005320053eucas1p2D@eucas1p2.samsung.com>
X-CMS-MailID: 20181015083209eucas1p2fb3d1961745fdb3007dec317c6441142
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20181012190748epcas5p3dc41f6d0f9c69f22351209b2e7ea66f3
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181012190748epcas5p3dc41f6d0f9c69f22351209b2e7ea66f3
References: <20180925192433.1377-1-jmkrzyszt@gmail.com>
        <CGME20181012190748epcas5p3dc41f6d0f9c69f22351209b2e7ea66f3@epcas5p3.samsung.com>
        <20181012190901.1243-1-jmkrzyszt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Janusz,

On 2018-10-12 21:09, Janusz Krzysztofik wrote:
> Commit b9762bebc633 ("gpiolib: Pass bitmaps, not integer arrays, to
> get/set array") changed the way GPIO values are passed to
> gpiod_get/set_array_value() and friends.  The new code introduced into
> mmc_pwrseq_simple_set_gpios_value() incorrectly interpretes the 'value'
> argument as a bitmap of GPIO values and assigns it directly to the
> 'values' bitmap variable passed to gpiod_set_array_value_cansleep()
> instead of filling that bitmap with bits equal to the 'value' argument.
> As a result, only member 0 of the array is handled correctly.
>
> Moreover, wrong assumption is taken about the 'values' bitmap size not
> exceding the number of bits of the 'value' argument type.
>
> Fix it.
>
> Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
> ---
> Hi,
>
> I think that patch has been missed while we were resolving issues 
> related to GPIO fast bitmap processing.  Since all issues other than the 
> one addreessed by this patch have been been hopefully identified and 
> fixed, GPIO tree seems now to be in good shape in regard to that. 
> However, I believe pwrseq_simple is still broken.  Hence, I'm 
> resubmitting this patch to Ulf for inclusion in MMC tree, Cc: many other 
> people who are kindly requested to test it if possible.
>
> I've identified the following DT files representing devices which may be 
> affected (have more than one GPIO assigned to pwrseq_simple):
> - arch/arm/boot/dts/imx6qdl-sr-som-brcm.dtsi
> - arch/arm/boot/dts/exynos5250-snow-common.dtsi

On Samsung Snow Chromebook it doesn't change anything. Board boots and
detects WiFi SDIO card before and after applying it on top on Linux
next-20181012.

Tested-by: Marek Szyprowski <m.szyprowski

> - arch/arm/boot/dts/imx6sl-warp.dts
> - arch/arm/boot/dts/omap3-igep0030.dts
> - arch/arm/boot/dts/omap3-igep0020.dts
> - arch/arm/boot/dts/rk3036-kylin.dts
> - arch/arm64/boot/dts/rockchip/rk3368-r88.dts
> - arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95.dtsi
>
> Please start with checking if pwrseq_simple from linux-next works for 
> you and if not, please test if this patch fixes the issue.
>
> Thanks,
> Janusz
>
>
>  drivers/mmc/core/pwrseq_simple.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/core/pwrseq_simple.c b/drivers/mmc/core/pwrseq_simple.c
> index 7f882a2bb872..ece34c734693 100644
> --- a/drivers/mmc/core/pwrseq_simple.c
> +++ b/drivers/mmc/core/pwrseq_simple.c
> @@ -40,13 +40,22 @@ static void mmc_pwrseq_simple_set_gpios_value(struct mmc_pwrseq_simple *pwrseq,
>  	struct gpio_descs *reset_gpios = pwrseq->reset_gpios;
>  
>  	if (!IS_ERR(reset_gpios)) {
> -		DECLARE_BITMAP(values, BITS_PER_TYPE(value));
> +		unsigned long *values;
>  		int nvalues = reset_gpios->ndescs;
>  
> -		values[0] = value;
> +		values = bitmap_alloc(nvalues, GFP_KERNEL);
> +		if (!values)
> +			return;
> +
> +		if (value)
> +			bitmap_fill(values, nvalues);
> +		else
> +			bitmap_zero(values, nvalues);
>  
>  		gpiod_set_array_value_cansleep(nvalues, reset_gpios->desc,
>  					       reset_gpios->info, values);
> +
> +		kfree(values);
>  	}
>  }
>  

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

