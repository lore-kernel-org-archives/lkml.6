Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A55BC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 10:42:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA33121479
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 10:42:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="gBOYXYya"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA33121479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728923AbeKUVQE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 16:16:04 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:33228 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726849AbeKUVQD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 16:16:03 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20181121104209euoutp0189829a43dc30bc5dc9270598bad5396a~pHaITcgFf0105401054euoutp01Z
        for <linux-kernel@vger.kernel.org>; Wed, 21 Nov 2018 10:42:09 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20181121104209euoutp0189829a43dc30bc5dc9270598bad5396a~pHaITcgFf0105401054euoutp01Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1542796929;
        bh=OE2Ofg/Z2F3jD2kYIYIdQaLaRFk3hZo6XgaPXck4xoU=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=gBOYXYyaOf9Jymig1UwcD2l7blDJbdqMPjp0Zv6o4LwioGxlEW0TY4qErwaaX6VOZ
         ci3O5E4/+8SUQQCOrs7N4/8ZcM0yc0YaEmrkiH+N90jvYUnjL9mLzwoORO+RQvo0Tu
         KwN8TH2AS/I/Z5z7mr1Gob3vuKKOqOeWzvwkY0i4=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20181121104208eucas1p1bd1851e2f546c7a7db336b7c96f43f91~pHaHh7h3O0514605146eucas1p1U;
        Wed, 21 Nov 2018 10:42:08 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 6A.EE.04441.08635FB5; Wed, 21
        Nov 2018 10:42:08 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20181121104207eucas1p2cd2fcbff22d365b5f5c66c3cffded2ad~pHaGjNA9s0319803198eucas1p2N;
        Wed, 21 Nov 2018 10:42:07 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20181121104207eusmtrp2e555dfc8e48d68a5199be309472bcc04~pHaGiVT4q1948819488eusmtrp2T;
        Wed, 21 Nov 2018 10:42:07 +0000 (GMT)
X-AuditID: cbfec7f2-5e3ff70000001159-79-5bf536802901
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id E8.F2.04284.F7635FB5; Wed, 21
        Nov 2018 10:42:07 +0000 (GMT)
Received: from [106.116.147.30] (unknown [106.116.147.30]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20181121104207eusmtip12e27bfdc0b994fd1adaaeffce3735e59~pHaGLa5H32709227092eusmtip1F;
        Wed, 21 Nov 2018 10:42:06 +0000 (GMT)
Subject: Re: [PATCH v2] regulator: wm8994: Don't use devres for enable GPIOs
To:     Charles Keepax <ckeepax@opensource.cirrus.com>, broonie@kernel.org
Cc:     linus.walleij@linaro.org, lgirdwood@gmail.com,
        linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <c0a2d30d-b18e-e72a-f369-c8678f1854ff@samsung.com>
Date:   Wed, 21 Nov 2018 11:42:06 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
        Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <20181121101316.32194-1-ckeepax@opensource.cirrus.com>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrCKsWRmVeSWpSXmKPExsWy7djPc7oNZl+jDf7/4baY+vAJm8WV1k2M
        Ft+udDBZTPmznMni8q45bBaf3+9ndWDz2DnrLrvHplWdbB53ru1h85g+5z+jx+dNcgGsUVw2
        Kak5mWWpRfp2CVwZkxdcYSt4JFTx+LtXA2M7fxcjJ4eEgInE0ZZ5TF2MXBxCAisYJdoXXIBy
        vjBKLGs+xAbhfGaUOHDsDxNMy9tlB6ASyxklFrcvg2p5zyjR9PUvaxcjB4ewgI/E1yUiIA0i
        Am4Sr++vYQaxmQUKJL71PgGz2QQMJbredrGB2LwCdhILl2xiAbFZBFQl9m1/BFYjKhAjcWzl
        DUaIGkGJkzOfgNVwCjhLnPg9ix1iprzE9rdzoOaLS9x6Mh/sHgmBVewSHa/OskFc7SLRv/I9
        I4QtLPHq+BZ2CFtG4v9OmIZmYADMAJkK4vQwSmydswOq21ri8PGLYJ8xC2hKrN+lD2JKCDhK
        7HvqCmHySdx4KwhxA5/EpG3TmSHCvBIdbUIQM9QkZh1fB7f14IVLzBMYlWYh+WwWkm9mIflm
        FsLaBYwsqxjFU0uLc9NTiw3zUsv1ihNzi0vz0vWS83M3MQLTzul/xz/tYPx6KekQowAHoxIP
        b4Lwl2gh1sSy4srcQ4wSHMxKIry/VL5GC/GmJFZWpRblxxeV5qQWH2KU5mBREuetZngQLSSQ
        nliSmp2aWpBaBJNl4uCUamAsbep0O3GqzF/IWMOox9dh4icp4T2Mfg2F2+4ufdRlGl+SPe+N
        U2Hs+U73yglX2pWjb078+rDZfd1TPpF/hVnb82QvOBmE8epnxRUdDXOykG0786pmS/3SyDcp
        Bj7qt26v5zZR6utasMHrZS3DowLtm+LLbp58Ktcq/myG5wWPLe8mrLnCXafEUpyRaKjFXFSc
        CABX2E+mNwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrOIsWRmVeSWpSXmKPExsVy+t/xu7r1Zl+jDdYuELeY+vAJm8WV1k2M
        Ft+udDBZTPmznMni8q45bBaf3+9ndWDz2DnrLrvHplWdbB53ru1h85g+5z+jx+dNcgGsUXo2
        RfmlJakKGfnFJbZK0YYWRnqGlhZ6RiaWeobG5rFWRqZK+nY2Kak5mWWpRfp2CXoZkxdcYSt4
        JFTx+LtXA2M7fxcjJ4eEgInE22UH2LoYuTiEBJYySjy+epYRIiEjcXJaAyuELSzx51oXVNFb
        Rome5u9MXYwcHMICPhJfl4iA1IgIuEm8vr+GGcRmFiiQONlylx2ifhqjxIM5XWBD2QQMJbre
        ggzi5OAVsJNYuGQTC4jNIqAqsW/7I7BmUYEYic7r86BqBCVOznwCVsMp4Cxx4vcsdogF6hJ/
        5l2CWiYvsf3tHChbXOLWk/lMExiFZiFpn4WkZRaSlllIWhYwsqxiFEktLc5Nzy021CtOzC0u
        zUvXS87P3cQIjLRtx35u3sF4aWPwIUYBDkYlHt4E4S/RQqyJZcWVuYcYJTiYlUR4f6l8jRbi
        TUmsrEotyo8vKs1JLT7EaAr03ERmKdHkfGASyCuJNzQ1NLewNDQ3Njc2s1AS5z1vUBklJJCe
        WJKanZpakFoE08fEwSnVwFjecm9ibQH3tfAlie62m3by3P78ZtNvV+n8HBOz+5UM9pOidkiv
        dz7kVd1z+ovirdsCaR9EF2xqDOc5/N73TJuyxv+VXMl7mYvTXPxaGbqm7dx0wmyJ3KufLaZ6
        z3OPbHDYIMT8wNxmx9Fmd1t3hX7XiRrG7i8T/gR0LZm66mQG08770/y3TlRiKc5INNRiLipO
        BADbDpDsygIAAA==
X-CMS-MailID: 20181121104207eucas1p2cd2fcbff22d365b5f5c66c3cffded2ad
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20181121101410epcas3p27a2a577c3b5a0608f7808ff733fab9d1
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181121101410epcas3p27a2a577c3b5a0608f7808ff733fab9d1
References: <CGME20181121101410epcas3p27a2a577c3b5a0608f7808ff733fab9d1@epcas3p2.samsung.com>
        <20181121101316.32194-1-ckeepax@opensource.cirrus.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Charles,

On 2018-11-21 11:13, Charles Keepax wrote:
> The regulator core takes over managing the lifetime of the enable GPIO
> once the regulator is registered. As such we shouldn't register the
> enable GPIO using devm, or it will be freed twice.
>
> Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> ---
>
> Again only build tested.

Thanks for the patch. It fixes the observed GPIOlib warning.

Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>

It might sense to add:

Fixes: 1d2f46814d20 ("regulator: wm8994: Pass descriptor instead of GPIO
number")


Linus, Mark: Similar issue is probably in the other regulator drivers,
which use enable GPIO allocated by devm_gpio_get*(). This driver is
simply the first one, which we observed it. It would be great if one
would take a look into regulator_register() error path, because for some
cases the GPIO will be freed, for the other - not.

> Thanks,
> Charles
>
>  drivers/regulator/wm8994-regulator.c | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/regulator/wm8994-regulator.c b/drivers/regulator/wm8994-regulator.c
> index d7fec533c4032..46e6b4ee1491a 100644
> --- a/drivers/regulator/wm8994-regulator.c
> +++ b/drivers/regulator/wm8994-regulator.c
> @@ -147,11 +147,14 @@ static int wm8994_ldo_probe(struct platform_device *pdev)
>  	config.regmap = wm8994->regmap;
>  	config.init_data = &ldo->init_data;
>  
> -	/* Look up LDO enable GPIO from the parent device node */
> -	gpiod = devm_gpiod_get_optional(pdev->dev.parent,
> -					id ? "wlf,ldo2ena" : "wlf,ldo1ena",
> -					GPIOD_OUT_LOW |
> -					GPIOD_FLAGS_BIT_NONEXCLUSIVE);
> +	/*
> +	 * Look up LDO enable GPIO from the parent device node, we don't
> +	 * use devm because the regulator core will free the GPIO
> +	 */
> +	gpiod = gpiod_get_optional(pdev->dev.parent,
> +				   id ? "wlf,ldo2ena" : "wlf,ldo1ena",
> +				   GPIOD_OUT_LOW |
> +				   GPIOD_FLAGS_BIT_NONEXCLUSIVE);
>  	if (IS_ERR(gpiod))
>  		return PTR_ERR(gpiod);
>  	config.ena_gpiod = gpiod;
> @@ -184,6 +187,7 @@ static int wm8994_ldo_probe(struct platform_device *pdev)
>  	return 0;
>  
>  err:
> +	gpiod_put(gpiod);
>  	return ret;
>  }
>  

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

