Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61F63C04EBF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 14:34:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 137462087F
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 14:34:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="DFIyTJBz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 137462087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727710AbeLEOeP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 09:34:15 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:47310 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727103AbeLEOeP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 09:34:15 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20181205143413euoutp02ab45433c39c3056c0775f510e8340c13~tdmwdiPnt2134921349euoutp02S
        for <linux-kernel@vger.kernel.org>; Wed,  5 Dec 2018 14:34:13 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20181205143413euoutp02ab45433c39c3056c0775f510e8340c13~tdmwdiPnt2134921349euoutp02S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1544020454;
        bh=360O++Tlu3Gj+SOnGunFRnOgxXL62bacYenlerGi2k4=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=DFIyTJBzIIPQCyHCsZ6IxlLAr7gtOv6f2TxKDCEEds7XzVlT4Kb/LvXSp11Z1h8r7
         Hob1Moy61djYjHb6xvRPRTexJ63+HcjhDVqDfV9emjejuc7neArlLpicQlUPSrCgRo
         msfZo/7antCKNqXkngxBLHDrQ4jFw+0HT1oj8ZI0=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20181205143413eucas1p1e470a976f378a58f9eae1cba87837828~tdmv1h4b82432124321eucas1p1r;
        Wed,  5 Dec 2018 14:34:13 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 84.3A.04294.4E1E70C5; Wed,  5
        Dec 2018 14:34:12 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20181205143412eucas1p20fd9f69a63caa071cbe8004f0de7521b~tdmvIqcE50544005440eucas1p2E;
        Wed,  5 Dec 2018 14:34:12 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20181205143412eusmtrp2a3dc2a4777c952877a3c5d94e345b073~tdmu6RJ9g1909919099eusmtrp2Y;
        Wed,  5 Dec 2018 14:34:12 +0000 (GMT)
X-AuditID: cbfec7f4-835ff700000010c6-5e-5c07e1e46dda
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 63.60.04128.4E1E70C5; Wed,  5
        Dec 2018 14:34:12 +0000 (GMT)
Received: from [106.116.147.30] (unknown [106.116.147.30]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20181205143411eusmtip12464e37de1217050df236cca12a2efb7~tdmugiX1q1839518395eusmtip17;
        Wed,  5 Dec 2018 14:34:11 +0000 (GMT)
Subject: Re: [PATCH 10/15 v3] gpio: devres: Handle nonexclusive GPIOs
To:     Linus Walleij <linus.walleij@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <626564ae-8dd6-d271-7a4f-11071df2d7e8@samsung.com>
Date:   Wed, 5 Dec 2018 15:34:11 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
        Thunderbird/60.3.2
MIME-Version: 1.0
In-Reply-To: <20181205124721.26624-11-linus.walleij@linaro.org>
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0hTcRTH++3e3XtdTn5Oy4NJ6YjCKF8lDDIzSBnZHxIUUobOvKno1DZn
        +aBGpukKGZKoVyP/0HwQFStNh1hpubSX2TbNRygZpWCG2sPykdeb5X/fc87nfM85cBhCVi92
        ZxJT0llNiipZTknIps65V7vGRukov5rSIMXs9W5SUTI6RimseSak+G4tECmuzdeKFG/NlVQI
        pZzqz6OVLdwwrTQ1FFLKIXsrpSytXELKGdPmCOq4JCiOTU7MYDW+wTGShGnTLJlm8zhnv/mU
        0qPhjQbkwADeA1PDzaQBSRgZrkNQVjH+N5hFoH9oIIRgBsHgrzbxaot1YQ7xWoZrEQzcEgvQ
        FIL3dT3L7QzjgkPhS1Mcz7jidKjONyOeIXAeApOxjeALFPYHw6SB4rUUB0OnpWLFlMRbYdDW
        hXifDTgKzJ9yBMQZusrHSF474P1QXVK1ogm8BXIbKwhBu8HA2A0RPwuwiQa7vZHmfQAfBK7o
        grC/C0xY7tOC9oClllU+F8HlMo4WgqsIGiubKYHaCx2WN2LeiMDecMfsK6QPwEXrPST4O0H/
        pLOwgxMUN5USQloKBfkygd4GnOX2v7GPe3oJI5Jzay7j1lzDrbmG+z+3CpENyI3VadXxrDYg
        hT3ro1WptbqUeJ9TqWoTWn6g54uW2WZkno9tR5hBckfp5xE6SiZWZWgz1e0IGELuKq0LWk5J
        41SZWawmNVqjS2a17WgTQ8rdpNnrRk7IcLwqnU1i2TRWs1oVMQ7uehQekBM65PNiqSG29Ij/
        zr5nlO7Mvg+BlUMtE4eo8MIffTZL/fThkezMS0ZbtVeglxGORre2GvzCrkzMJckdA15OPqrv
        15dv/7i+V9FB31V97XzHBn578psJ4zxfH6v5uRvGiwbp88W9MQsRuu7IxZxhR8vJyNMGTZnY
        +8GoZ0iWnNQmqPx3EBqt6g8Iw/BTPAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrHIsWRmVeSWpSXmKPExsVy+t/xu7pPHrLHGLTd4rX4MvcUi8XUh0/Y
        LK60bmK0+Halg8liyp/lTBaXd81hc2DzeH+jld1j56y77B6bVnWyedy5tofNY/qc/4wenzfJ
        BbBF6dkU5ZeWpCpk5BeX2CpFG1oY6RlaWugZmVjqGRqbx1oZmSrp29mkpOZklqUW6dsl6GV8
        2vSFpeCqTMW1ZUfZGhjvinUxcnJICJhIXPn7k7GLkYtDSGApo8SZBZdZIRIyEienNUDZwhJ/
        rnWxQRS9ZZR43vaCqYuRg0NYwFXi3bYUkBoRgRKJD/t3soPUMAu0Mko8enwDquEYo8TVtrfM
        IFVsAoYSXW9BJnFy8ArYSRw7PpsRxGYRUJG4ffUkmC0qECMx5fJrVogaQYmTM5+wgNicAvYS
        S6YuALOZBdQl/sy7xAxhy0s0b50NZYtL3Hoyn2kCo9AsJO2zkLTMQtIyC0nLAkaWVYwiqaXF
        uem5xUZ6xYm5xaV56XrJ+bmbGIFxt+3Yzy07GLveBR9iFOBgVOLhffGAPUaINbGsuDL3EKME
        B7OSCO8KG6AQb0piZVVqUX58UWlOavEhRlOg5yYyS4km5wNTQl5JvKGpobmFpaG5sbmxmYWS
        OO95g8ooIYH0xJLU7NTUgtQimD4mDk6pBkZ+d7uvuhN6TibmCunbW+mf4Kw6dc5G0sGYS3JB
        mFiNd4rwVv0Ag5WVU2f4zMz4kfl4mb9ng5NB39s7c/bKe6lOM3g7ZRbDfenCN6tSt64QXpmQ
        klm6vcJwZuzWKTMUc2XmWgZZl+9VmlL/iSv3xiH3+98ZGWyDT2uUXszql3wg/XV64vu4u0os
        xRmJhlrMRcWJAIwQII/RAgAA
X-CMS-MailID: 20181205143412eucas1p20fd9f69a63caa071cbe8004f0de7521b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20181205124826epcas2p13d03e4a183731f285add6c87a8a1a42a
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181205124826epcas2p13d03e4a183731f285add6c87a8a1a42a
References: <20181205124721.26624-1-linus.walleij@linaro.org>
        <CGME20181205124826epcas2p13d03e4a183731f285add6c87a8a1a42a@epcas2p1.samsung.com>
        <20181205124721.26624-11-linus.walleij@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

On 2018-12-05 13:47, Linus Walleij wrote:
> When we get a nonexeclusive GPIO descriptor using managed
> resources, we should only add it to the list of managed
> resources once: on the first user. Augment the
> devm_gpiod_get_index() and devm_gpiod_get_from_of_node()
> calls to account for this by checking if the descriptor
> is already resource managed before we proceed to allocate
> a new resource management struct.
>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> Fixes: b0ce7b29bfcd ("regulator/gpio: Allow nonexclusive GPIO access")
> Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ChangeLog v1->v3:
> - New patch.
> - This fix is in response to an issue Marek saw in the fixups
>   for resource-managed GPIO descriptors used with ena_gpiod
>   in the regulator subsystem.
> - I first thought to apply it to the GPIO tree directly, but
>   since it is not a regression it is better to put it into
>   the regulator tree with the rest of the patches.
> ---
>  drivers/gpio/gpiolib-devres.c | 50 ++++++++++++++++++++++++++---------
>  1 file changed, 38 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/gpio/gpiolib-devres.c b/drivers/gpio/gpiolib-devres.c
> index 01959369360b..a57e968025a8 100644
> --- a/drivers/gpio/gpiolib-devres.c
> +++ b/drivers/gpio/gpiolib-devres.c
> @@ -98,15 +98,28 @@ struct gpio_desc *__must_check devm_gpiod_get_index(struct device *dev,
>  	struct gpio_desc **dr;
>  	struct gpio_desc *desc;
>  
> +	desc = gpiod_get_index(dev, con_id, idx, flags);
> +	if (IS_ERR(desc))
> +		return desc;
> +
> +	/*
> +	 * For non-exclusive GPIO descriptors, check if this descriptor is
> +	 * already under resource management by this device.
> +	 */
> +	if (flags & GPIOD_FLAGS_BIT_NONEXCLUSIVE) {
> +		struct devres *dres;
> +
> +		dres = devres_find(dev, devm_gpiod_release,
> +				   devm_gpiod_match, desc);

    devres_find(dev, devm_gpiod_release, devm_gpiod_match, &desc);

> +		if (dres)
> +			return desc;
> +	}
> +
>  	dr = devres_alloc(devm_gpiod_release, sizeof(struct gpio_desc *),
>  			  GFP_KERNEL);
> -	if (!dr)
> +	if (!dr) {
> +		gpiod_put(desc);
>  		return ERR_PTR(-ENOMEM);
> -
> -	desc = gpiod_get_index(dev, con_id, idx, flags);
> -	if (IS_ERR(desc)) {
> -		devres_free(dr);
> -		return desc;
>  	}
>  
>  	*dr = desc;
> @@ -140,15 +153,28 @@ struct gpio_desc *devm_gpiod_get_from_of_node(struct device *dev,
>  	struct gpio_desc **dr;
>  	struct gpio_desc *desc;
>  
> +	desc = gpiod_get_from_of_node(node, propname, index, dflags, label);
> +	if (IS_ERR(desc))
> +		return desc;
> +
> +	/*
> +	 * For non-exclusive GPIO descriptors, check if this descriptor is
> +	 * already under resource management by this device.
> +	 */
> +	if (dflags & GPIOD_FLAGS_BIT_NONEXCLUSIVE) {
> +		struct devres *dres;
> +
> +		dres = devres_find(dev, devm_gpiod_release,
> +				   devm_gpiod_match, desc);

 	devres_find(dev, devm_gpiod_release, devm_gpiod_match, &desc);

> +		if (dres)
> +			return desc;
> +	}
> +
>  	dr = devres_alloc(devm_gpiod_release, sizeof(struct gpio_desc *),
>  			  GFP_KERNEL);
> -	if (!dr)
> +	if (!dr) {
> +		gpiod_put(desc);
>  		return ERR_PTR(-ENOMEM);
> -
> -	desc = gpiod_get_from_of_node(node, propname, index, dflags, label);
> -	if (IS_ERR(desc)) {
> -		devres_free(dr);
> -		return desc;
>  	}
>  
>  	*dr = desc;

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

