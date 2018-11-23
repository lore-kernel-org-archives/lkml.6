Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61E07C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 09:24:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E627208E3
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 09:24:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="aO8w5D0N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E627208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408903AbeKWUIQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 15:08:16 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:39210 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390458AbeKWUIP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 15:08:15 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20181123092449euoutp026ce0d745b58871e77f9f7f8fd0e7110d~ptpLeP9g70403804038euoutp02I
        for <linux-kernel@vger.kernel.org>; Fri, 23 Nov 2018 09:24:49 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20181123092449euoutp026ce0d745b58871e77f9f7f8fd0e7110d~ptpLeP9g70403804038euoutp02I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1542965089;
        bh=DkonihV2hXgvtMc9ttfHltxahVM4WMfqTstWPra7mIc=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=aO8w5D0NSDcml6NCY6sDzh2DEN1H9yMZDqfRamPXlKQbXd3ye9fuA0ivVUjg79M5v
         sJtlEGT6LmMv7wK68bLjivcSf3zd4ZJ2FDZPVdD9/cd93m0O5z9/ZOKcWG/efFZPQc
         yYVqZeRDM8u0bblmLwbirvkDsJL8wqnJEOx/+CC8=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20181123092448eucas1p1efb2f8d9bdb33e6ee51afcfa11092768~ptpKz4fJp0777607776eucas1p1K;
        Fri, 23 Nov 2018 09:24:48 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 35.56.04441.067C7FB5; Fri, 23
        Nov 2018 09:24:48 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20181123092447eucas1p21bfca1eb072bec871b8ace1c9ae61bc1~ptpKBU0A31468414684eucas1p2a;
        Fri, 23 Nov 2018 09:24:47 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20181123092447eusmtrp1828e224fcc3c21d01e49d4e37011ff33~ptpJxOZCV0122901229eusmtrp18;
        Fri, 23 Nov 2018 09:24:47 +0000 (GMT)
X-AuditID: cbfec7f2-5e3ff70000001159-c5-5bf7c760eef6
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 49.E5.04284.F57C7FB5; Fri, 23
        Nov 2018 09:24:47 +0000 (GMT)
Received: from [106.116.147.30] (unknown [106.116.147.30]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20181123092447eusmtip1c53997817a243eb912e4b12bd5207f9a~ptpJcaKK21537715377eusmtip1C;
        Fri, 23 Nov 2018 09:24:47 +0000 (GMT)
Subject: Re: [PATCH 2/3] regulator: Only free GPIOs if the core requested
 them
To:     Charles Keepax <ckeepax@opensource.cirrus.com>, broonie@kernel.org
Cc:     linus.walleij@linaro.org, lgirdwood@gmail.com,
        linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <0716cd43-2f2d-cac9-5bb7-dffcbd3a4795@samsung.com>
Date:   Fri, 23 Nov 2018 10:24:46 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
        Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <20181122173015.23905-2-ckeepax@opensource.cirrus.com>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrGKsWRmVeSWpSXmKPExsWy7djPc7oJx79HGyzaJGAx9eETNosrrZsY
        Lb5d6WCymPJnOZPF5V1z2Cw+v9/P6sDmsXPWXXaPTas62TzuXNvD5jF9zn9Gj8+b5AJYo7hs
        UlJzMstSi/TtErgyzr3Yy1qwVaii9+kV5gbGXXxdjJwcEgImEvcau9m6GLk4hARWMEocXbmK
        DSQhJPCFUeLhF22IxGdGiee71jHBdKx6fACqYzmjxOMTL6Gc94wSU1f+YAapEhYIkJi5Zgc7
        iC0i4Cbx+v4asDizQIHEt94nYDabgKFE19susHW8AnYS295+B7NZBFQlvn+fCWaLCsRIHFt5
        gxGiRlDi5MwnLCA2p4CzxL6NRxghZspLbH87B2q+uMStJ/OZQA6SEFjFLrF04imos10k+nZs
        ZoGwhSVeHd/CDmHLSJye3MMC0dDMKNE+YxY7hNPDKLF1zg42iCpricPHL7J2MXIArdCUWL9L
        HyLsKHHzeQ8zSFhCgE/ixltBiCP4JCZtmw4V5pXoaBOCqFaTmHV8HdzagxcuMU9gVJqF5LVZ
        SN6ZheSdWQh7FzCyrGIUTy0tzk1PLTbMSy3XK07MLS7NS9dLzs/dxAhMPaf/Hf+0g/HrpaRD
        jAIcjEo8vBs2fosWYk0sK67MPcQowcGsJMLbpPg9Wog3JbGyKrUoP76oNCe1+BCjNAeLkjhv
        NcODaCGB9MSS1OzU1ILUIpgsEwenVANj67QV3cffGqUu7K3x6JrEZrn+pBafh6R4r5FxeFFF
        EFNG340OiQUW09ivTOUvmymr2+n4R3vF4scigWLi96R/+NYxtl66svX1euPzXlXy57b+j+qZ
        v++HJuOO9S+7V0Wvu3zltsucqN7dfbxTuFJcfq7ZdOnEip9pqza/c2ULn9y3znFf7OrJSizF
        GYmGWsxFxYkAz4ITGjkDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrBIsWRmVeSWpSXmKPExsVy+t/xu7rxx79HG/Q+krCY+vAJm8WV1k2M
        Ft+udDBZTPmznMni8q45bBaf3+9ndWDz2DnrLrvHplWdbB53ru1h85g+5z+jx+dNcgGsUXo2
        RfmlJakKGfnFJbZK0YYWRnqGlhZ6RiaWeobG5rFWRqZK+nY2Kak5mWWpRfp2CXoZ517sZS3Y
        KlTR+/QKcwPjLr4uRk4OCQETiVWPD7B1MXJxCAksZZTo/nqEESIhI3FyWgMrhC0s8edaF1TR
        W0aJ/3f62bsYOTiEBfwkLt3hBakREXCTeH1/DTOIzSxQIHGy5S47RP15RolT86+DJdgEDCW6
        3oIM4uTgFbCT2Pb2O5jNIqAq8f37TDBbVCBGovP6PKgaQYmTM5+wgNicAs4S+zZCHMcsoC7x
        Z94lqGXyEtvfzoGyxSVuPZnPNIFRaBaS9llIWmYhaZmFpGUBI8sqRpHU0uLc9NxiQ73ixNzi
        0rx0veT83E2MwFjbduzn5h2MlzYGH2IU4GBU4uHdsPFbtBBrYllxZe4hRgkOZiUR3ibF79FC
        vCmJlVWpRfnxRaU5qcWHGE2BnpvILCWanA9MA3kl8YamhuYWlobmxubGZhZK4rznDSqjhATS
        E0tSs1NTC1KLYPqYODilGhgTt9uuSkt9vXLe9aOl2vMlWUIVJXdKN8UIX1rqnC5yeFVu2XKO
        fVOPOJo99bxT5OhRFzTBZcm3ipOSH4Nv+XJ/4Bd4vMF535lOvbjd09Y2P48OMJV2Y8lg5+ON
        +MN+99Eenke1224ck1UMMHPRiCvd4Lp3ytrfd1gWaP20Z8q5NOHFtG2HFB4psRRnJBpqMRcV
        JwIAJo12n8sCAAA=
X-CMS-MailID: 20181123092447eucas1p21bfca1eb072bec871b8ace1c9ae61bc1
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20181122173037epcas1p2f0b7577cd0babcc6fc42bdc305c58376
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181122173037epcas1p2f0b7577cd0babcc6fc42bdc305c58376
References: <20181122173015.23905-1-ckeepax@opensource.cirrus.com>
        <CGME20181122173037epcas1p2f0b7577cd0babcc6fc42bdc305c58376@epcas1p2.samsung.com>
        <20181122173015.23905-2-ckeepax@opensource.cirrus.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Charles,

On 2018-11-22 18:30, Charles Keepax wrote:
> Currently, the regulator core will take ownership of any GPIO passed
> into it. Makes end driver code fairly error prone as the normal devm_
> patterns of allocation don't work. Update the regulator core to only
> free the GPIO if it requested it, this allows the drivers to manage the
> GPIO lifetime as they normally would.
>
> Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>

> ---
>  drivers/regulator/core.c | 19 +++++++++++--------
>  1 file changed, 11 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
> index dbe2f2e6e6254..9da7d27c7145e 100644
> --- a/drivers/regulator/core.c
> +++ b/drivers/regulator/core.c
> @@ -83,6 +83,7 @@ struct regulator_enable_gpio {
>  	u32 enable_count;	/* a number of enabled shared GPIO */
>  	u32 request_count;	/* a number of requested shared GPIO */
>  	unsigned int ena_gpio_invert:1;
> +	unsigned int locally_requested:1;
>  };
>  
>  /*
> @@ -2233,19 +2234,20 @@ static int regulator_ena_gpio_request(struct regulator_dev *rdev,
>  		}
>  	}
>  
> +	pin = kzalloc(sizeof(struct regulator_enable_gpio), GFP_KERNEL);
> +	if (pin == NULL)
> +		return -ENOMEM;
> +
>  	if (!config->ena_gpiod) {
>  		ret = gpio_request_one(config->ena_gpio,
>  				       GPIOF_DIR_OUT | config->ena_gpio_flags,
>  				       rdev_get_name(rdev));
> -		if (ret)
> +		if (ret) {
> +			kfree(pin);
>  			return ret;
> -	}
> +		}
>  
> -	pin = kzalloc(sizeof(struct regulator_enable_gpio), GFP_KERNEL);
> -	if (pin == NULL) {
> -		if (!config->ena_gpiod)
> -			gpio_free(config->ena_gpio);
> -		return -ENOMEM;
> +		pin->locally_requested = 1;
>  	}
>  
>  	pin->gpiod = gpiod;
> @@ -2270,7 +2272,8 @@ static void regulator_ena_gpio_free(struct regulator_dev *rdev)
>  		if (pin->gpiod == rdev->ena_pin->gpiod) {
>  			if (pin->request_count <= 1) {
>  				pin->request_count = 0;
> -				gpiod_put(pin->gpiod);
> +				if (pin->locally_requested)
> +					gpiod_put(pin->gpiod);
>  				list_del(&pin->list);
>  				kfree(pin);
>  				rdev->ena_pin = NULL;

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

