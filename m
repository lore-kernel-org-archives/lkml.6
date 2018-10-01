Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FORGED_MUA_MOZILLA,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 358E8C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 06:46:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D11462084C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 06:46:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="IxgofUGr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D11462084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728757AbeJANWg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 09:22:36 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:40214 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726486AbeJANWf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 09:22:35 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20181001064620euoutp022dde97e8f40ddc5b69e1166a5104b0ed~ZaSrO6Pj20753007530euoutp02M;
        Mon,  1 Oct 2018 06:46:20 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20181001064620euoutp022dde97e8f40ddc5b69e1166a5104b0ed~ZaSrO6Pj20753007530euoutp02M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1538376380;
        bh=rdYEjRZezE/cKY58GXsgYvc4WfmTr0DXbMy3ceWLe2U=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=IxgofUGrkvWaVCHzzWMyMGNlvHZ73oW+DS5i6cSKYfmu49Bx35LXy2vm+/d0RO974
         mQstsZUpkHyCDNCpEaKR5MA7dTWVk7s1PFpq/gMW58IhJk6hMleJp6shnLziK+06Af
         g2v9ub11kZbetqfoZPtQe6iedBrvkpjr9daCOQxY=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20181001064619eucas1p1dcab342ee92a0eb01754786458dd6bfc~ZaSqtnzM10813708137eucas1p1U;
        Mon,  1 Oct 2018 06:46:19 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id C0.9B.04806.BB2C1BB5; Mon,  1
        Oct 2018 07:46:19 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20181001064618eucas1p28ccab6242ec7f562912a83584a65e768~ZaSpX0FfS1643816438eucas1p2f;
        Mon,  1 Oct 2018 06:46:18 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20181001064617eusmtrp12c17a9003d46ec99b2699e6127a14345~ZaSpEt7ij2053720537eusmtrp1P;
        Mon,  1 Oct 2018 06:46:17 +0000 (GMT)
X-AuditID: cbfec7f5-34dff700000012c6-05-5bb1c2bb1301
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id E7.89.04128.9B2C1BB5; Mon,  1
        Oct 2018 07:46:17 +0100 (BST)
Received: from [106.116.147.30] (unknown [106.116.147.30]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20181001064616eusmtip11650b70a1b797085c962b3207aaf9bfc~ZaSn0Hmq_3141931419eusmtip1v;
        Mon,  1 Oct 2018 06:46:16 +0000 (GMT)
Subject: Re: [PATCH] gpiolib: Fix incorrect use of find_next_zero_bit()
To:     Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>,
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
        Sebastien Bourdelin <sebastien.bourdelin@savoirfairelinux.com>,
        Lukas Wunner <lukas@wunner.de>,
        Rojhalat Ibrahim <imr@rtschenk.de>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Tony Lindgren <tony@atomide.com>,
        Yegor Yefremov <yegorslists@googlemail.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-gpio@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-mmc@vger.kernel.org, netdev@vger.kernel.org,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-serial@vger.kernel.org,
        Linux Samsung SOC <linux-samsung-soc@vger.kernel.org>,
        linux-kernel@vger.kernel.org
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Date:   Mon, 1 Oct 2018 08:46:16 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
        Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180929122022.6825-1-jmkrzyszt@gmail.com>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA01Tb0wTZxzOe3e9O7rVHJXJC8yZlI2FZcoM2/LbcGYmy3bZh4WYzLnVOOo8
        wUHRtMCmn4gwhQYCUiJQiyU4KTKh9c+gFCl6FLpZpFgBka2bS4Q5EQSKJgrCPA83vv2e5/c8
        7+95PrwsqZ6lY9m92TmCIVuXpaGVVGvvo8D6DvGs9q2frmIIhEQSrIFCCi72PWbg8ZSXgfHR
        TgIKTjpoKPtlEsGtQ00EDLZaSKh0ThMwMFZCg3vpHgmBgJOBH802BVQu2Ak4b1tAUPRkDsEJ
        7xQF191WGrxLZQiqAx4C+k6WMlBXOK2AO3/HQXn3eQZuVt1joLduDXSKNgRDrVcpmHf3MhAs
        O0rAWOcNCroGP4XfjpoR+Jq/AJ/NiuDhxF/0h6/x/qoukr87tIW/PnyN5B8+qKD4Y5eOM3xn
        czXNXzh9k+AH2l/g//B0U3y7JcTw0zM7+bFyM8Ofayqm+d+HL9K82F2E+K7aM0xq7FfKTbuF
        rL15giFpc5oyIzw7TO1vWfN9m89P5qP6SBOKYDH3Np7q+JMyISWr5hoR7vCP0zKYQ9gVrkUy
        CCNc3DbHPLeM11Qo5IUd4ZEr1mVwH+HgRAslqVZzn+CpoaZnjihuO3ba80lJRHKPlNjtPvxM
        RHMbsWnSREszxb2KQ8f6n4pY9iVuB553p0i0iovEv9bcpiQ6ggPcOJsg0SS3DrdNWkl5jsaj
        t22E9DzmRiNwT+08LXvzcM8/9UhO/RG2DjqX59X4ru/CcpuXsd9cQsnmAoSPVFsYGZQg/LPV
        RcuqFNztu6aQUpBcIna4k2R6C77imSUkGnOr8MhkpBxoFa5orSJlWoWLDqtldQK2+Fr+O3t5
        IEiWI41lRUvLimqWFdUs/9+tQ1QTihZyjfp0wZicLXy3wajTG3Oz0zd8s09/Dj39Cf5F3wMX
        8izsEhHHIs2LqlTRoVUrdHnGA3oRYZbURKm2Djq1atVu3YGDgmHf14bcLMEoojiW0kSrGk6c
        1aq5dF2OkCkI+wXD8y3BRsTmo+AuT5Atnb60ub1Hc8q7vnGmv37Ifujdd+riMxJC23aWmaPW
        3YlxrE0p3fFx4ZmDSe+tzUysHP2B/qDBnqYPvx73pCFmRsypX9S4kj9TFadqB27tifV+vvTl
        JotjLlgwVtEfqT/StjjySk3ijeMxmf3x4TfjTa5v70Oye6Jva/P7oTQNZczQbXyDNBh1/wIt
        MEYbBQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA02SfUwTZxjA895d7w60yVkQ3rAZXXXDmFhsgfVhQ8L8Y7uZxbj5h0r9WIcX
        IKOU9IobJmwo3cYaDSCklY5RMl10DQioAVstuIJ8DKFKKZsi6hI+/CpjTklEELl1S/jvl+f5
        /d7kTR6WVFjoODYnzyyY8vS5SjqS6nvZPbrR7WvWbbL2asE/6iOhxm+h4PK1WQZmpzoZmLjl
        JaDkZCMNZT0hBPeOuAgYanGQUNU0TcD18aM0eBYek+D3NzFwqtIpg6q50wScd84hKJ1/iqC2
        c4qCgKeGhs6FMgQn/G0EXDt5jIE6y7QM7k++BuUd5xm4aX/MQFddDHh9TgTBln4KXni6GBgs
        qyBg3Ps7Be1DW2GkohJBd8NO6HbWIJh59Ced/ibfZ28n+YfB9/jA8A2Sn3l2nOJtV35geG/D
        CZq/8MtNgr/uXsbfaeugeLdjlOGn/97Hj5dXMvw51/c0f3v4Ms37OkoR3/5jPbM9LkOVajIW
        mIU12UbRvFmpU4NGpU4BlSYpRaVO1O59R5OsTEhLPSDk5hwUTAlpn6qy/3kyTOWfjfmytbuP
        LEY/rbCiCBZzSXii+rjMiiJZBfczwnfLq6nw4nXcayuWhTkKzw1b6bAUQniirgRJiyjuAzwV
        dDESR3O78Bn7UUKSSG4+Egfnn5HhwoNw66l7pGTRnBpbQ9JTLCvn0nDp5B5pTHHr8Kht4F9l
        JbcHX6200BLLuRW4t3qMkvQIDvCZJ29JY5KLx3O1g2SYV+PWUM1/HItvjTmJcqRwLKkdSxLH
        ksSxJKlDlAtFCwWiIcsgalSi3iAW5GWpMo2Gc2jxAlu6nl+4iKxTO3yIY5FyuXy7r1GnkOkP
        ioUGH8IsqYyWfzLUpFPID+gLDwkm435TQa4g+lDy4t8qyLiVmcbFe84z71cnq7WQotYmahPf
        BmWs3L+pMEPBZenNwueCkC+Y/u8INiKuGGUWfV3CzGoP30jh5r8amQ00PffY3GtON8cWfZY+
        gP39yw/t6LG/+2u95XbRd19EHBuIMv+2fqz5wbd/rB1JcuesKrRv3Tnz4W5Tfu2gENBl3s+F
        mY/WbgnaQBVq++vjS1e3vJ/e440PrtbEP8ieHp+8EgxUfdOe+sa2oCshZpmtpX9BSYnZevUG
        0iTqXwEhq4lYlwMAAA==
Message-Id: <20181001064618eucas1p28ccab6242ec7f562912a83584a65e768~ZaSpX0FfS1643816438eucas1p2f@eucas1p2.samsung.com>
X-CMS-MailID: 20181001064618eucas1p28ccab6242ec7f562912a83584a65e768
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20180929121916epcas4p2eb8be6cdd6b11d675510f0a54b546bb5
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180929121916epcas4p2eb8be6cdd6b11d675510f0a54b546bb5
References: <20180923235336.22148-2-jmkrzyszt@gmail.com>
        <CGME20180929121916epcas4p2eb8be6cdd6b11d675510f0a54b546bb5@epcas4p2.samsung.com>
        <20180929122022.6825-1-jmkrzyszt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Janusz,

On 2018-09-29 14:20, Janusz Krzysztofik wrote:
> Commit b17566a6b08b ("gpiolib: Implement fast processing path in
> get/set array"), already fixed to some extent with commit 5d581d7e8cdc
> ("gpiolib: Fix missing updates of bitmap index"), introduced a new mode
> of processing bitmaps where bits applicable for fast bitmap processing
> path are supposed to be skipped while iterating bits which don't apply.
> Unfortunately, find_next_zero_bit() function supposed to skip over
> those fast bits is always called with a 'start' argument equal to an
> index of last zero bit found and returns that index value again an
> again, causing an infinite loop.
>
> Fix it by incrementing the index uncoditionally before
> find_next_zero_bit() is optionally called.
>
> Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>

Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>

> ---
> Marek,
>
> Could you please test it on top of next-20180920 with "gpiolib: Fix
> missing updates of bitmap index" and optionally "mmc: pwrseq_simple:
> Fix incorrect handling of GPIO bitmap" also applied?

This patch finally fixes the boot issue on Samsung Chromebook Snow.
Thanks!

>
> Thanks,
> Janusz
>
>
>  drivers/gpio/gpiolib.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
> index 6ae13e3e05f1..940b543e966d 100644
> --- a/drivers/gpio/gpiolib.c
> +++ b/drivers/gpio/gpiolib.c
> @@ -2878,12 +2878,11 @@ int gpiod_get_array_value_complex(bool raw, bool can_sleep,
>  			int hwgpio = gpio_chip_hwgpio(desc);
>  
>  			__set_bit(hwgpio, mask);
> +			i++;
>  
>  			if (array_info)
>  				i = find_next_zero_bit(array_info->get_mask,
>  						       array_size, i);
> -			else
> -				i++;
>  		} while ((i < array_size) &&
>  			 (desc_array[i]->gdev->chip == chip));
>  
> @@ -2903,12 +2902,11 @@ int gpiod_get_array_value_complex(bool raw, bool can_sleep,
>  				value = !value;
>  			__assign_bit(j, value_bitmap, value);
>  			trace_gpio_value(desc_to_gpio(desc), 1, value);
> +			j++;
>  
>  			if (array_info)
>  				j = find_next_zero_bit(array_info->get_mask, i,
>  						       j);
> -			else
> -				j++;
>  		}
>  
>  		if (mask != fastpath)
> @@ -3191,12 +3189,11 @@ int gpiod_set_array_value_complex(bool raw, bool can_sleep,
>  					__clear_bit(hwgpio, bits);
>  				count++;
>  			}
> +			i++;
>  
>  			if (array_info)
>  				i = find_next_zero_bit(array_info->set_mask,
>  						       array_size, i);
> -			else
> -				i++;
>  		} while ((i < array_size) &&
>  			 (desc_array[i]->gdev->chip == chip));
>  		/* push collected bits to outputs */

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

