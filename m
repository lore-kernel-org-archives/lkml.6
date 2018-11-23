Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E6AAC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 09:25:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B14C20863
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 09:25:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="VWcX0WWN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B14C20863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408914AbeKWUIi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 15:08:38 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:39334 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390457AbeKWUIi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 15:08:38 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20181123092510euoutp023a8fc60f0b49b647af83357db0d8dac0~ptpfgqwxR0407704077euoutp02H
        for <linux-kernel@vger.kernel.org>; Fri, 23 Nov 2018 09:25:10 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20181123092510euoutp023a8fc60f0b49b647af83357db0d8dac0~ptpfgqwxR0407704077euoutp02H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1542965110;
        bh=xnIiNwoExWqbDIFPzNeTIRq4lPS4ObQxd7JM1Vz7SFk=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=VWcX0WWNL6zoT6Hxk1RKxZChrHgfsuyLF0ox42sOWXxJjAOROF5ACuY1Lp4mCDBiy
         7+pEXD5ISj3Qbl+iJ2w2s9mVycs3SJRSvbFUOuOzaR2wWidjrlDVosOoAOcZ4/jmju
         vGJFt31qjyJXhRkvwW7f8h5jmnz4ak5+jwc98wtU=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20181123092510eucas1p142b7e7ff7c8dc71f5c0942a963650df4~ptpezT9740792607926eucas1p1o;
        Fri, 23 Nov 2018 09:25:10 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 7D.71.04806.577C7FB5; Fri, 23
        Nov 2018 09:25:09 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20181123092509eucas1p1cf47e0ae03129b806e0358ca15c9fb86~ptpeEpyik0780607806eucas1p1l;
        Fri, 23 Nov 2018 09:25:09 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20181123092508eusmtrp1a18176fa8c1b3f2fc36a7c2454475cc9~ptpd0zTV10152301523eusmtrp1H;
        Fri, 23 Nov 2018 09:25:08 +0000 (GMT)
X-AuditID: cbfec7f5-34dff700000012c6-48-5bf7c775d02b
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 57.F5.04284.477C7FB5; Fri, 23
        Nov 2018 09:25:08 +0000 (GMT)
Received: from [106.116.147.30] (unknown [106.116.147.30]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20181123092508eusmtip1330270818c022152afa48ad8d413a4b4~ptpdgqHKb1462014620eusmtip1H;
        Fri, 23 Nov 2018 09:25:08 +0000 (GMT)
Subject: Re: [PATCH 3/3] gpio: Add reference counting for non-exclusive
 GPIOs
To:     Charles Keepax <ckeepax@opensource.cirrus.com>, broonie@kernel.org
Cc:     linus.walleij@linaro.org, lgirdwood@gmail.com,
        linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <56d4a613-21a6-7a51-a9ef-a8e010a6945a@samsung.com>
Date:   Fri, 23 Nov 2018 10:25:08 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
        Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <20181122173015.23905-3-ckeepax@opensource.cirrus.com>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrKKsWRmVeSWpSXmKPExsWy7djPc7qlx79HG3yeq2sx9eETNosrrZsY
        Lb5d6WCymPJnOZPF5V1z2Cw+v9/P6sDmsXPWXXaPTas62TzuXNvD5jF9zn9Gj8+b5AJYo7hs
        UlJzMstSi/TtErgytu/+y1ZwQaji2A3FBsbHfF2MnBwSAiYSe07/YgSxhQRWMEo0Ho7vYuQC
        sr8wSpy/18UC4XxmlPi6cwETTMe6W3+hEssZJR51L2GFcN4zSjQ9a2EFqRIW8JfYP+MFG4gt
        IuAm8fr+GmYQm1mgQOJb7xMwm03AUKLrbRdYDa+AncS7pc/YQWwWAVWJ+z+/sYDYogIxEsdW
        3mCEqBGUODnzCVicU8BZ4k//CkaImfIS29/OgZovLnHryXwmkIMkBFaxS7yf9xTqbBeJCxf/
        sUDYwhKvjm9hh7BlJE5P7mGBaGhmlGifMYsdwulhlNg6ZwcbRJW1xOHjF4Fe4wBaoSmxfpc+
        RNhRYt7FLUwgYQkBPokbbwUhjuCTmLRtOjNEmFeio00IolpNYtbxdXBrD164xDyBUWkWktdm
        IXlnFpJ3ZiHsXcDIsopRPLW0ODc9tdg4L7Vcrzgxt7g0L10vOT93EyMw8Zz+d/zrDsZ9f5IO
        MQpwMCrx8G7Y+C1aiDWxrLgy9xCjBAezkghvk+L3aCHelMTKqtSi/Pii0pzU4kOM0hwsSuK8
        1QwPooUE0hNLUrNTUwtSi2CyTBycUg2MDEKNC5v2di46WLVxYodfycvPJZ82fM9ys0vI3sbu
        d/RgktQT0aqJ2uVhG9Jd5rD2JoX4KSa8j/5whqVj1jPmg6LCkRuap/95X5l5t2Pt2aX7w/vc
        5pfWlgfpXdXiF5eXuHrtUb3W+TkHhet+f6t333d0405r7bU/Lt/aIPHvgZvxs59eTmevKLEU
        ZyQaajEXFScCAMZgEH44AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrOIsWRmVeSWpSXmKPExsVy+t/xu7olx79HG6z/Z2kx9eETNosrrZsY
        Lb5d6WCymPJnOZPF5V1z2Cw+v9/P6sDmsXPWXXaPTas62TzuXNvD5jF9zn9Gj8+b5AJYo/Rs
        ivJLS1IVMvKLS2yVog0tjPQMLS30jEws9QyNzWOtjEyV9O1sUlJzMstSi/TtEvQytu/+y1Zw
        Qaji2A3FBsbHfF2MnBwSAiYS6279Zeli5OIQEljKKHF4zUN2iISMxMlpDawQtrDEn2tdbBBF
        bxklpj75x9jFyMEhLOArsfFbNkiNiICbxOv7a5hBbGaBAomTLXfZIerPM0pMaNoBNpRNwFCi
        6y3IIE4OXgE7iXdLn4HFWQRUJe7//MYCYosKxEh0Xp8HVSMocXLmE7A4p4CzxJ/+FYwQC9Ql
        /sy7BLVMXmL72zlQtrjErSfzmSYwCs1C0j4LScssJC2zkLQsYGRZxSiSWlqcm55bbKhXnJhb
        XJqXrpecn7uJERhp24793LyD8dLG4EOMAhyMSjy8GzZ+ixZiTSwrrsw9xCjBwawkwtuk+D1a
        iDclsbIqtSg/vqg0J7X4EKMp0HMTmaVEk/OBSSCvJN7Q1NDcwtLQ3Njc2MxCSZz3vEFllJBA
        emJJanZqakFqEUwfEwenVAOjbXH27Dkd6zO+3Y/myvq3JfaDmvwuDv1LYRH7p99oU2Kw3rYq
        Nv2//L7SjccE9Fc8ORL0W7E87/vuihjdbymS55/FpjUlfnB4w9h5lF+rNynI/He3zOLAKd0L
        JZKFkzdPLy+r3rDEZJvbrqkdy0pv50+b+aBBI+DBB4lC5s0CJ4LLuMQm/TulxFKckWioxVxU
        nAgAAKRVQsoCAAA=
X-CMS-MailID: 20181123092509eucas1p1cf47e0ae03129b806e0358ca15c9fb86
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20181122173053epcas5p1a9b2170d5755bcb31d50d493c6618d25
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181122173053epcas5p1a9b2170d5755bcb31d50d493c6618d25
References: <20181122173015.23905-1-ckeepax@opensource.cirrus.com>
        <CGME20181122173053epcas5p1a9b2170d5755bcb31d50d493c6618d25@epcas5p1.samsung.com>
        <20181122173015.23905-3-ckeepax@opensource.cirrus.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Charles,

On 2018-11-22 18:30, Charles Keepax wrote:
> Currently, a GPIO can be requested multiple times when the
> NONEXCLUSIVE flag is set, however it must still be freed a single
> time. This makes client code rather complex, since multiple drivers
> may request the GPIO but only a single one can free it. Rather than
> manually handling this in each driver add some basic reference
> counting into the core.  Currently, this is fairly primitive but
> so is the support for the NONEXCLUSIVE flag and the implementation
> covers those use-cases.
>
> Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  drivers/gpio/gpiolib.c | 13 ++++++++++++-
>  drivers/gpio/gpiolib.h |  2 ++
>  2 files changed, 14 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
> index 230e41562462b..42ba86fb495a5 100644
> --- a/drivers/gpio/gpiolib.c
> +++ b/drivers/gpio/gpiolib.c
> @@ -2407,6 +2407,13 @@ static bool gpiod_free_commit(struct gpio_desc *desc)
>  
>  	might_sleep();
>  
> +	if (desc->n_users > 1) {
> +		desc->n_users--;
> +		return true;
> +	} else {
> +		desc->n_users = 0;
> +	}
> +
>  	gpiod_unexport(desc);
>  
>  	spin_lock_irqsave(&gpio_lock, flags);
> @@ -4142,7 +4149,8 @@ struct gpio_desc *__must_check gpiod_get_index(struct device *dev,
>  			 */
>  			dev_info(dev, "nonexclusive access to GPIO for %s\n",
>  				 con_id ? con_id : devname);
> -			return desc;
> +
> +			goto done;
>  		} else {
>  			return ERR_PTR(status);
>  		}
> @@ -4155,6 +4163,9 @@ struct gpio_desc *__must_check gpiod_get_index(struct device *dev,
>  		return ERR_PTR(status);
>  	}
>  
> +done:
> +	desc->n_users++;
> +
>  	return desc;
>  }
>  EXPORT_SYMBOL_GPL(gpiod_get_index);
> diff --git a/drivers/gpio/gpiolib.h b/drivers/gpio/gpiolib.h
> index 087d865286a0c..f96eda90281a3 100644
> --- a/drivers/gpio/gpiolib.h
> +++ b/drivers/gpio/gpiolib.h
> @@ -230,6 +230,8 @@ struct gpio_desc {
>  	const char		*label;
>  	/* Name of the GPIO */
>  	const char		*name;
> +
> +	unsigned int		n_users;
>  };
>  
>  int gpiod_request(struct gpio_desc *desc, const char *label);

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

