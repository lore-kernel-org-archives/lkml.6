Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FORGED_MUA_MOZILLA,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43604ECE562
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 08:18:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C66FE21531
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 08:18:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="sH+74FMZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C66FE21531
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389448AbeIUOF6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 10:05:58 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:55196 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388909AbeIUOF4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 10:05:56 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20180921081808euoutp01e325329236ec06f1e0b5967a4b768078~WXF_ANv860207202072euoutp01_;
        Fri, 21 Sep 2018 08:18:08 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20180921081808euoutp01e325329236ec06f1e0b5967a4b768078~WXF_ANv860207202072euoutp01_
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1537517888;
        bh=hGFqaZUCupr+lrJzPVvoMy4VazWZX2OR+dcZpgrV2EY=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=sH+74FMZ3nvZyiUUvL0YwU+qaXRS72tKmeCisxSq4EG6QErFEVblgjnm0YUXsXL4I
         WJ4tLxrXa2/+89zu6Lgk1TDwy9+DWszAwYOpqMIKpTC4hNR9wYgwz0BTA3uCvl6012
         Nb2lEyySWvtkkFFd5iRzjo7Rp2qkCPw0oGK/kNWE=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20180921081807eucas1p111ace4ada25239982711eb0b991f9cb3~WXF9ev1Pv0749907499eucas1p1h;
        Fri, 21 Sep 2018 08:18:07 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id A9.1C.04294.F39A4AB5; Fri, 21
        Sep 2018 09:18:07 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20180921081806eucas1p182d4646e8510b5f0356214af7edba11e~WXF8Ptw4M0970709707eucas1p1p;
        Fri, 21 Sep 2018 08:18:06 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20180921081805eusmtrp1319111806d37e3e25b5e5b0b7300dbed~WXF778yFG2128521285eusmtrp1R;
        Fri, 21 Sep 2018 08:18:05 +0000 (GMT)
X-AuditID: cbfec7f4-84fff700000010c6-cc-5ba4a93f4121
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 1F.C6.04128.D39A4AB5; Fri, 21
        Sep 2018 09:18:05 +0100 (BST)
Received: from [106.116.147.30] (unknown [106.116.147.30]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20180921081804eusmtip24004dc82555db6de203bf7cc7c3b21e8~WXF6hDJuJ1973419734eusmtip2x;
        Fri, 21 Sep 2018 08:18:04 +0000 (GMT)
Subject: Re: [PATCH v7 4/4] gpiolib: Implement fast processing path in
 get/set array
To:     Janusz Krzysztofik <jmkrzyszt@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>,
        Peter Korsgaard <peter.korsgaard@barco.com>,
        Peter Rosin <peda@axentia.se>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jiri Slaby <jslaby@suse.com>, Willy Tarreau <w@1wt.eu>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-doc@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-mmc@vger.kernel.org, netdev@vger.kernel.org,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-serial@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sebastien Bourdelin <sebastien.bourdelin@savoirfairelinux.com>,
        Lukas Wunner <lukas@wunner.de>,
        Rojhalat Ibrahim <imr@rtschenk.de>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Tony Lindgren <tony@atomide.com>,
        Yegor Yefremov <yegorslists@googlemail.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        'Linux Samsung SOC' <linux-samsung-soc@vger.kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Date:   Fri, 21 Sep 2018 10:18:03 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
        Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <15226900.TQMLYV7PZ0@z50>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA01Tb0xTVxzN7Xt971FW8iwOrnRB020uuqGwLNtvcXEz2Ye3PyZmW1gcc/o2
        3tCNgnkVBtsXN1GwwYGUWHxWy9KaaiPaqau1tsBa0roULUJxyobZlrZsKMomkgl1jPJw49s5
        555z7zkfLkNopqg8ZlvFDkGs4Mt1lIp0h+5fLnj5uL2kMNTGQHQ4QEC8ux6BJVpHgq93ioap
        2z00JIf8CthlO0VB08UxBL985VRAzC0R0OoaV0BfopEC78wtAqJRFw12k1UJrSmHAr7ZYyfh
        jDWFoOHBBIIjPbdJGPBaKOiZaULQFu1UQK9tHw3tdeNK+H1EC83BMzRcN9+iIdSeA/6AFcGg
        +xIJ094QDf1N+xWQ8P9IQlfsdfhpvwlBuONdCFstCCZv/kq98hQXMXcR3OjgOm7g6hWCm7zX
        QnIHug/RnL+jjeLOHr+u4PrOZ3I3OoMkd14aprnxPz/gEs0mmjvt3EtxP1/1UVwg2IC4rsMn
        6A3a91QvlQrl26oFcfXaLaqtKbdZuf2GtqY/YSZ2on05RpTBYPY5/JujlzYiFaNhjyE8dHJU
        KZMJhL+L9pAyuYvw9AWP4mEk4uiejzgQvubbTcjkDsK+vfV02pXNFuORyWEyjRezz+A/fPVz
        aYKNZ+KWB1+kMcUWYeOYkUpjkn0SjzRLs36GeZR9H09716RlNbsI/3AwPidnsMtx5zGNfMtS
        fG7MQsg4Fw/FrfPdkhl4QKqRo9X4RMyHZP1VfDkem/dk49HwWVrGj+GIqXFuJGZ3IVzfJtEy
        aZydb/FQsmsNDoavKNMlCHYFPuVdLcvr8IzFPtcNs1n42tgiuU8WbnGbCVlW44Y9Gtm9HEvh
        k/89+31fP9GMdNKCkdKCZdKCZdL/77Yj0olyhSqDvkwwPFshfLbKwOsNVRVlqz6q1J9Gsz8i
        8k94woO8qQ8DiGWQ7hF1oc1WolHy1YZafQBhhtAtVnca7SUadSlf+7kgVm4Wq8oFQwBpGVKX
        q85a+XGJhi3jdwifCsJ2QXx4qmAy8naiQzP335x0vJN/k3zh4MX2kYmCZZy+zul4rUsMVj6+
        sYqhVZ637iUOX/AvKTha9LQr9mJSemJ9i7M2aird6H4+OfX125eW9n5JJf/urnWJ6/M2rc38
        JL+4LD9a80Z/qiPbc3RZzR2mOFoYCbXm7A4N3VVVHtFa+QLb5kHxAP+X69slOtKwlS9aSYgG
        /l9ZdDbSDQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA02ScUyUdRjH+73ve+/7It32eqL8BmXtrWRLO3hBvIeGVCvpt7Zara2ah9ql
        r+DkOHbv4aKtPBRFbxJHmOB1eLCDQMRk4FAYd9BBkIM8FIUwZeG4MOUYrXJ1EcRxtvHfd8/z
        +TzPnu3haU0ZG8fvy7PI5jxDrsiuYgYXBiZe2Hq2Tp90pHYT+O/4aJjqKUHg9Bcz0DUU4iA0
        28fBL7c8FBx2X2Ch7Psggp8PNVFwo91Bw8mWOQqGAydY6FycocHvb+GgrsKlgpPzDRTUHq1j
        oM01j+DYv38gONM3y8BIp5OFvsUyBFV+LwVD7lIOaornVHBvOh7svW0cjFfOcNBfsw48PheC
        m+0/MPBPZz8H18vKKQh4xhjovvEG/FRegWDg/Psw4HIiePhgkn05gQxWdtPk/s1XyMjoNZo8
        /PMLhpzq+YojnvNVLLl4dpwiwx3RZMLby5AOxx2OzP22kwTsFRxpbTrOktujXSzx9R5DpLu6
        mXs7frs23WwqsMhP55gUy1ZRL0GyVkoDbfLmNK2UotvxYnKqmJiRvkfO3XdANidmfKjNmW+v
        VOVPxH98PVBJW1HpOhuK4rGwGQ829HA2tIrXCPUIj9q/ZCKNJ/CVU1ZVJK/B86M2NgIFES4a
        L1qG1gjv4cMhKx3OMcIm/GtXCRWGaOF+ND46PEVHjBYK3z79gApTrCBhWzA8KopXCxm4yFa8
        vIIRnsPTdsfy1LVCFv6uovgRsxpfOT21VOf5KGED9jZqwmVa2ILPtE3SkfwUvhR0Psqx+NaU
        i7IjjWOF7VihOFYojhVKDWKaUIxcoBizjUqyVjEYlYK8bO1uk7EVLT1je//fFy8j2+y7PiTw
        SHxcneR26zUqwwGl0OhDmKfFGLXXVqfXqPcYCj+RzaZd5oJcWfGh1KXbyum4tbtNS6+dZ9kl
        pUo6SJN0KbqULSDGqv1Jhds1QrbBIu+X5XzZ/L9H8VFxVtRU4naH9v6oGUnHjXvvfX43rd71
        zrd8z4mJ1gRLbNZGlDXZ8Nez+Z8e2VBb+vt4prl6xnruUvW2Z4aacX7nZLpX/ubg6879C4FD
        4rnVHZmhJx8rTTwYvPpB1kvTpPE13froBUX66OtrocsxYx5Tc33mq+JVdcZbnxkW744dr9r2
        ZsJ6vcgoOQbpedqsGP4Dr4dwiKIDAAA=
Message-Id: <20180921081806eucas1p182d4646e8510b5f0356214af7edba11e~WXF8Ptw4M0970709707eucas1p1p@eucas1p1.samsung.com>
X-CMS-MailID: 20180921081806eucas1p182d4646e8510b5f0356214af7edba11e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20180920161947epcas3p491e6c136fe05d9672c81b7b4b8328f64
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180920161947epcas3p491e6c136fe05d9672c81b7b4b8328f64
References: <20180831225616.29221-1-jmkrzyszt@gmail.com>
        <20180920101151eucas1p221f5a1715b8556bb9d99bf08fe09ce6f~WE-_cEf4l0754207542eucas1p27@eucas1p2.samsung.com>
        <9860023.SlBYqtbjDV@z50>
        <CGME20180920161947epcas3p491e6c136fe05d9672c81b7b4b8328f64@epcas3p4.samsung.com>
        <15226900.TQMLYV7PZ0@z50>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Janusz,

On 2018-09-20 18:21, Janusz Krzysztofik wrote:
> On Thursday, September 20, 2018 5:48:22 PM CEST Janusz Krzysztofik wrote:
>> On Thursday, September 20, 2018 12:11:48 PM CEST Marek Szyprowski wrote:
>>> On 2018-09-02 14:01, Janusz Krzysztofik wrote:
>>>> Certain GPIO descriptor arrays returned by gpio_get_array() may contain
>>>> information on direct mapping of array members to pins of a single GPIO
>>>> chip in hardware order.  In such cases, bitmaps of values can be passed
>>>> directly from/to the chip's .get/set_multiple() callbacks without
>>>> wasting time on iterations.
>>>>
>>>> Add respective code to gpiod_get/set_array_bitmap_complex() functions.
>>>> Pins not applicable for fast path are processed as before, skipping
>>>> over the 'fast' ones.
>>>>
>>>> Cc: Jonathan Corbet <corbet@lwn.net>
>>>> Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
>>> I've just noticed that this patch landed in today's linux-next. Sadly it
>>> breaks booting of Exynos5250-based Samsung Snow Chromebook (ARM 32bit,
>>> device-tree source arch/arm/boot/dts/exynos5250-snow.dts).
>>>
>>> Booting hangs after detecting MMC cards. Reverting this patch fixes the
>>> boot. I will try later to add some debugs and investigate it further what
>>> really happens when booting hangs.
>> Hi Marek,
>>
>> Thanks for reporting. Could you please try the following fix?
> Hi again,
>
> I realized the patch was not correct, j, not i, should be updated in second
> hunk. Please try the following one.
>
> Thanks,
> Janusz
>
> >From a919c504850f6cb40e8e81267a3a37537f7c4fd4 Mon Sep 17 00:00:00 2001
> From: Janusz Krzysztofik <jmkrzyszt@gmail.com>
> Date: Thu, 20 Sep 2018 17:37:21 +0200
> Subject: [PATCH] gpiolib: Fix bitmap index not updated
> While skipping fast path bits, bitmap index is not updated with next
> found zero bit position. Fix it.
>
> Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>

This one also doesn't help. A quick compare of logs with this version and
a working system shows, that with your patch (and fix) there are no calls to
gpx0-2 pin (which are a part of mmc pwrseq), what causes mmc failure. If
you need any more information (what kind of logs will help?), let me know.

> ---
>   drivers/gpio/gpiolib.c | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
> index a53d17745d21..369bdd358fcc 100644
> --- a/drivers/gpio/gpiolib.c
> +++ b/drivers/gpio/gpiolib.c
> @@ -2880,7 +2880,7 @@ int gpiod_get_array_value_complex(bool raw, bool can_sleep,
>   			__set_bit(hwgpio, mask);
>   
>   			if (array_info)
> -				find_next_zero_bit(array_info->get_mask,
> +				i = find_next_zero_bit(array_info->get_mask,
>   						   array_size, i);
>   			else
>   				i++;
> @@ -2905,7 +2905,8 @@ int gpiod_get_array_value_complex(bool raw, bool can_sleep,
>   			trace_gpio_value(desc_to_gpio(desc), 1, value);
>   
>   			if (array_info)
> -				find_next_zero_bit(array_info->get_mask, i, j);
> +				j = find_next_zero_bit(array_info->get_mask, i,
> +						       j);
>   			else
>   				j++;
>   		}
> @@ -3192,7 +3193,7 @@ int gpiod_set_array_value_complex(bool raw, bool can_sleep,
>   			}
>   
>   			if (array_info)
> -				find_next_zero_bit(array_info->set_mask,
> +				i = find_next_zero_bit(array_info->set_mask,
>   						   array_size, i);
>   			else
>   				i++;

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

