Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FORGED_MUA_MOZILLA,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50B06ECE561
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 10:12:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D146B20880
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 10:11:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="kFt4zHW7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D146B20880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732380AbeITPyl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 11:54:41 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:36130 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730654AbeITPyk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 11:54:40 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20180920101152euoutp010457bc98d92ffbe703de76b9b7839c69~WE--4QO6U2734727347euoutp01D;
        Thu, 20 Sep 2018 10:11:52 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20180920101152euoutp010457bc98d92ffbe703de76b9b7839c69~WE--4QO6U2734727347euoutp01D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1537438313;
        bh=LYsSsWEcX3WHp2Zq9VGbfROhSvgXLYxvgEYp4yDqPTk=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=kFt4zHW7Y3imGpKibTe5U599q09/vJEx2a76pJAcj7mDFFBj9avfBK65peIEKj+lj
         kXtg9d7fdF77MxMQpE7O0T+p8lKnxn9DOOxm0nAzL80m5dOfWWIrS8Dc9V+uJsnj4p
         0GONTP0y75xvrQnUWhuk34xHs4p0YUZ/ux7LcRwc=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20180920101152eucas1p27e318127ea2aa3dd4320f2ff494329e5~WE--dhXdE2798827988eucas1p2D;
        Thu, 20 Sep 2018 10:11:52 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 13.72.04441.86273AB5; Thu, 20
        Sep 2018 11:11:52 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20180920101151eucas1p221f5a1715b8556bb9d99bf08fe09ce6f~WE-_cEf4l0754207542eucas1p27;
        Thu, 20 Sep 2018 10:11:51 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20180920101151eusmtrp192e5ae69fb9e1e25744475debda081d8~WE-_JdTNv2843728437eusmtrp1m;
        Thu, 20 Sep 2018 10:11:51 +0000 (GMT)
X-AuditID: cbfec7f2-5e3ff70000001159-81-5ba3726850ae
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id F6.8D.04128.66273AB5; Thu, 20
        Sep 2018 11:11:50 +0100 (BST)
Received: from [106.116.147.30] (unknown [106.116.147.30]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20180920101149eusmtip21605f6331196a5660e7652fccb785d77~WE-8tUUOZ0891008910eusmtip2M;
        Thu, 20 Sep 2018 10:11:49 +0000 (GMT)
Subject: Re: [PATCH v7 4/4] gpiolib: Implement fast processing path in
 get/set array
To:     Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
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
Date:   Thu, 20 Sep 2018 12:11:48 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
        Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180902120144.6855-5-jmkrzyszt@gmail.com>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA01TbUxTZxTee9/bey9lJZfixhtxI2mm22SDkczsLJpFM7LcLWT6Z7jZZXrF
        OyDyYVphaLKsASNIIFAggJdq68qCok7mRweVD22RbiKW4geTjcUhTNMBFid1Kwy0XLfx7znP
        Oc95zvMmL4e1IWY5l5W7WzLkitk6Rk07ev+++nqmwa5/o/+4CrwjLgxjF0oQWLz7aOi4EmIh
        NNXDwu/DnRQU208xUPnDJILbRS0UXHfIGGpbAxQMjJcz4FyYwOD1trLQVGNVQe1cMwVH9jfR
        cMY6h6D0n4cIDvdM0XDNaWGgZ6ESQYO3i4Ir9goWbPsCKrh3Nw6q3GdYuFU/wUKv7XnodFkR
        3HD00zDr7GVhsNJMwXjnEA3d1z+An801CDwnN4PHakEQ/OM3Zv3LQl99Nxb8NzYI1276sBCc
        qaaFuguNrNB5soERzh67RQkD7ZHCr11uWmiXR1ghMP2ZMF5VwwqnWw4wwi83OxjB5S5FQveh
        E+ymuC3qdTuk7KwCyZD0zjZ1prn4OLPrcEqhaW6VCZ1fU4YiOMK/SfyXTGwZUnNa/igiNp8V
        K8VDRK5OVz/t/InI6NCJJwW3KPHdXq/wzYhMHB19qriPSH/FEB3eG8OnkbvBkUW8jP+YtDab
        Focw74wkR2wTqnCD4ZNJ2WQZE8Y0v5K0jwVUYYfn+E/JrHNtmNbw0eTHg2N0mI7ggdw5pw/T
        mI8n309asIJjyfCYlQqvJ/xwBBms7cCKtoAcaJ3GSs4UIh900QqOIX7PWVbBK0hfTTmtiIsR
        KWmQWaUoR+ScpY1RptYSt8e3eBzmXyWnnEkKvYHMOOco5VWiyE+T0cpBUaTaUY8VWkNK92uV
        6VVE9nz7n+3FgUFchXTykpTykmjykmjy/742RLegWCnfmJMhGZNzpS8SjWKOMT83IzE9L+c0
        evIj+uY9D9rQzOB2F+I5pHtWc6/oa71WJRYY9+S4EOGwbplmQbTrtZod4p69kiFvqyE/WzK6
        UBxH62I1Uas/12v5DHG3tFOSdkmGf7sUF7HchA7tfPuTSH3TK9w3FVH6wo+yZurSZt8K9u/d
        fDmtO2nErkqLiZ9PeNS20cWl+n3rgnnvnh91f+jdEleBk2fbEzQliYHSFHbja0Oh6VDgfmHj
        sDm10XzpqzXqVF26f1PXgy/VCc+8oGl+33U5Or3OOv9o6qXvikwxL975K9ER/57Ib9+qo42Z
        YvJqbDCKjwGrYeFBDQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA02SfUwTdxjH87s77q5ik1vF8RvqXi4RjWaFK1QeFIk6kp1LNBqNTiviTW6g
        Ukp6RcXErAJxrLAVhAlWpCiiEzVWYShMCikIGjVVKxidOokwiVLCkkkUO5GKS/jvk3yfz/OS
        PCypKaQj2G2ZFtmcKWXw9BTq+tuux19+b64xRLsG48H7yENCX9uPCCq9+RRcvjHKwOhQBwN/
        P2ghIK/mHA32q34ET3LrCLjb6CChzDVMwK3+IhqaxwZJ8HpdDBwvdYZAWeAkAUf3H6eg3hlA
        UPDfvwiqOoYo8DVX0tAxZkdQ4XUTcKPmZwaq84dDYODZDChur2fgfvkgA53VH0OLx4mgu/Em
        BW+aOxm4Yy8hoL/lHgWtd7+BP0tKEXSdXQ9dzkoEIy966SVzxOvlraT4vHup6Ou5TYojLw9Q
        4sG2w4zYcraCFhtO3SfEW02h4mN3OyU2OR4x4vA/m8X+4lJGvFD3Ey0+7LlMi572AiS2HjnD
        rJqxUZtgNmVb5M/TTYplMW8QQKcV4kGri43XCjFxyQt1ej4qMSFVzti2UzZHJW7Rppfknaaz
        qpJ2WwORVvSH3oZYFnOx+PaTJTakYjVcLcLd+7cHGXMz8bWD1pAJnoYDPTbahqaM1/gRtvsP
        UMFgGrcO541aySCHcd/i38qLiCCTXFsoPtO+YkIoQ9jv+osOBjQnYJvf9p7VXCJ+XVXEBJni
        ZuOmvuH306Zzm/CV0vwPNR/ha4f6qOCiKg7w098NE/0X4Kr6XnKCP8MX/ZUfOBw/6HMSxUjj
        mGQ7JimOSYpjklKNqDoUJmcrxjSjotMqklHJzkzTbjUZL6DxR2zsfN1wCdmG1ngQxyJ+qnog
        95hBEyLtVHKMHoRZkg9Tj0k1Bo06VcrZI5tNKebsDFnxIP34bSVkxPStpvG3zrSkCHohDuKF
        uJi4mAXAh6u90TkbNVyaZJF3yHKWbP7fI1hVhBV56PN0weibyNodi6SvYmd9MXBiTe8ve327
        TEhV+GtsSujihlcrH2Ytyuh019K+5E/uRbkjRtgBw4hcsdedu1YovhKp+BwFqu7lc338wvD0
        6NTqCns9mbRU/2kCvz4p2jA79eQG0zLXkfmmq63JaF9gtVF357uoOf2+Hwq/fpqXtYynlHRJ
        mEeaFekdy/up3Z4DAAA=
Message-Id: <20180920101151eucas1p221f5a1715b8556bb9d99bf08fe09ce6f~WE-_cEf4l0754207542eucas1p27@eucas1p2.samsung.com>
X-CMS-MailID: 20180920101151eucas1p221f5a1715b8556bb9d99bf08fe09ce6f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20180920101151eucas1p221f5a1715b8556bb9d99bf08fe09ce6f
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180920101151eucas1p221f5a1715b8556bb9d99bf08fe09ce6f
References: <20180831225616.29221-1-jmkrzyszt@gmail.com>
        <20180902120144.6855-1-jmkrzyszt@gmail.com>
        <20180902120144.6855-5-jmkrzyszt@gmail.com>
        <CGME20180920101151eucas1p221f5a1715b8556bb9d99bf08fe09ce6f@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

On 2018-09-02 14:01, Janusz Krzysztofik wrote:
> Certain GPIO descriptor arrays returned by gpio_get_array() may contain
> information on direct mapping of array members to pins of a single GPIO
> chip in hardware order.  In such cases, bitmaps of values can be passed
> directly from/to the chip's .get/set_multiple() callbacks without
> wasting time on iterations.
>
> Add respective code to gpiod_get/set_array_bitmap_complex() functions.
> Pins not applicable for fast path are processed as before, skipping
> over the 'fast' ones.
>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>

I've just noticed that this patch landed in today's linux-next. Sadly it
breaks booting of Exynos5250-based Samsung Snow Chromebook (ARM 32bit,
device-tree source arch/arm/boot/dts/exynos5250-snow.dts).

Booting hangs after detecting MMC cards. Reverting this patch fixes the
boot. I will try later to add some debugs and investigate it further what
really happens when booting hangs.

> ---
>   Documentation/driver-api/gpio/board.rst    | 15 ++++++
>   Documentation/driver-api/gpio/consumer.rst |  8 +++
>   drivers/gpio/gpiolib.c                     | 87 ++++++++++++++++++++++++++++--
>   3 files changed, 105 insertions(+), 5 deletions(-)
>
> diff --git a/Documentation/driver-api/gpio/board.rst b/Documentation/driver-api/gpio/board.rst
> index 2c112553df84..c66821e033c2 100644
> --- a/Documentation/driver-api/gpio/board.rst
> +++ b/Documentation/driver-api/gpio/board.rst
> @@ -193,3 +193,18 @@ And the table can be added to the board code as follows::
>   
>   The line will be hogged as soon as the gpiochip is created or - in case the
>   chip was created earlier - when the hog table is registered.
> +
> +Arrays of pins
> +--------------
> +In addition to requesting pins belonging to a function one by one, a device may
> +also request an array of pins assigned to the function.  The way those pins are
> +mapped to the device determines if the array qualifies for fast bitmap
> +processing.  If yes, a bitmap is passed over get/set array functions directly
> +between a caller and a respective .get/set_multiple() callback of a GPIO chip.
> +
> +In order to qualify for fast bitmap processing, the pin mapping must meet the
> +following requirements:
> +- it must belong to the same chip as other 'fast' pins of the function,
> +- its index within the function must match its hardware number within the chip.
> +
> +Open drain and open source pins are excluded from fast bitmap output processing.
> diff --git a/Documentation/driver-api/gpio/consumer.rst b/Documentation/driver-api/gpio/consumer.rst
> index 0afd95a12b10..cf992e5ab976 100644
> --- a/Documentation/driver-api/gpio/consumer.rst
> +++ b/Documentation/driver-api/gpio/consumer.rst
> @@ -388,6 +388,14 @@ array_info should be set to NULL.
>   Note that for optimal performance GPIOs belonging to the same chip should be
>   contiguous within the array of descriptors.
>   
> +Still better performance may be achieved if array indexes of the descriptors
> +match hardware pin numbers of a single chip.  If an array passed to a get/set
> +array function matches the one obtained from gpiod_get_array() and array_info
> +associated with the array is also passed, the function may take a fast bitmap
> +processing path, passing the value_bitmap argument directly to the respective
> +.get/set_multiple() callback of the chip.  That allows for utilization of GPIO
> +banks as data I/O ports without much loss of performance.
> +
>   The return value of gpiod_get_array_value() and its variants is 0 on success
>   or negative on error. Note the difference to gpiod_get_value(), which returns
>   0 or 1 on success to convey the GPIO value. With the array functions, the GPIO
> diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
> index cef6ee31fe05..b9d083fb13ee 100644
> --- a/drivers/gpio/gpiolib.c
> +++ b/drivers/gpio/gpiolib.c
> @@ -2789,7 +2789,36 @@ int gpiod_get_array_value_complex(bool raw, bool can_sleep,
>   				  struct gpio_array *array_info,
>   				  unsigned long *value_bitmap)
>   {
> -	int i = 0;
> +	int err, i = 0;
> +
> +	/*
> +	 * Validate array_info against desc_array and its size.
> +	 * It should immediately follow desc_array if both
> +	 * have been obtained from the same gpiod_get_array() call.
> +	 */
> +	if (array_info && array_info->desc == desc_array &&
> +	    array_size <= array_info->size &&
> +	    (void *)array_info == desc_array + array_info->size) {
> +		if (!can_sleep)
> +			WARN_ON(array_info->chip->can_sleep);
> +
> +		err = gpio_chip_get_multiple(array_info->chip,
> +					     array_info->get_mask,
> +					     value_bitmap);
> +		if (err)
> +			return err;
> +
> +		if (!raw && !bitmap_empty(array_info->invert_mask, array_size))
> +			bitmap_xor(value_bitmap, value_bitmap,
> +				   array_info->invert_mask, array_size);
> +
> +		if (bitmap_full(array_info->get_mask, array_size))
> +			return 0;
> +
> +		i = find_first_zero_bit(array_info->get_mask, array_size);
> +	} else {
> +		array_info = NULL;
> +	}
>   
>   	while (i < array_size) {
>   		struct gpio_chip *chip = desc_array[i]->gdev->chip;
> @@ -2820,7 +2849,12 @@ int gpiod_get_array_value_complex(bool raw, bool can_sleep,
>   			int hwgpio = gpio_chip_hwgpio(desc);
>   
>   			__set_bit(hwgpio, mask);
> -			i++;
> +
> +			if (array_info)
> +				find_next_zero_bit(array_info->get_mask,
> +						   array_size, i);
> +			else
> +				i++;
>   		} while ((i < array_size) &&
>   			 (desc_array[i]->gdev->chip == chip));
>   
> @@ -2831,7 +2865,7 @@ int gpiod_get_array_value_complex(bool raw, bool can_sleep,
>   			return ret;
>   		}
>   
> -		for (j = first; j < i; j++) {
> +		for (j = first; j < i; ) {
>   			const struct gpio_desc *desc = desc_array[j];
>   			int hwgpio = gpio_chip_hwgpio(desc);
>   			int value = test_bit(hwgpio, bits);
> @@ -2840,6 +2874,11 @@ int gpiod_get_array_value_complex(bool raw, bool can_sleep,
>   				value = !value;
>   			__assign_bit(j, value_bitmap, value);
>   			trace_gpio_value(desc_to_gpio(desc), 1, value);
> +
> +			if (array_info)
> +				find_next_zero_bit(array_info->get_mask, i, j);
> +			else
> +				j++;
>   		}
>   
>   		if (mask != fastpath)
> @@ -3041,6 +3080,32 @@ int gpiod_set_array_value_complex(bool raw, bool can_sleep,
>   {
>   	int i = 0;
>   
> +	/*
> +	 * Validate array_info against desc_array and its size.
> +	 * It should immediately follow desc_array if both
> +	 * have been obtained from the same gpiod_get_array() call.
> +	 */
> +	if (array_info && array_info->desc == desc_array &&
> +	    array_size <= array_info->size &&
> +	    (void *)array_info == desc_array + array_info->size) {
> +		if (!can_sleep)
> +			WARN_ON(array_info->chip->can_sleep);
> +
> +		if (!raw && !bitmap_empty(array_info->invert_mask, array_size))
> +			bitmap_xor(value_bitmap, value_bitmap,
> +				   array_info->invert_mask, array_size);
> +
> +		gpio_chip_set_multiple(array_info->chip, array_info->set_mask,
> +				       value_bitmap);
> +
> +		if (bitmap_full(array_info->set_mask, array_size))
> +			return 0;
> +
> +		i = find_first_zero_bit(array_info->set_mask, array_size);
> +	} else {
> +		array_info = NULL;
> +	}
> +
>   	while (i < array_size) {
>   		struct gpio_chip *chip = desc_array[i]->gdev->chip;
>   		unsigned long fastpath[2 * BITS_TO_LONGS(FASTPATH_NGPIO)];
> @@ -3068,7 +3133,14 @@ int gpiod_set_array_value_complex(bool raw, bool can_sleep,
>   			int hwgpio = gpio_chip_hwgpio(desc);
>   			int value = test_bit(i, value_bitmap);
>   
> -			if (!raw && test_bit(FLAG_ACTIVE_LOW, &desc->flags))
> +			/*
> +			 * Pins applicable for fast input but not for
> +			 * fast output processing may have been already
> +			 * inverted inside the fast path, skip them.
> +			 */
> +			if (!raw && !(array_info &&
> +			    test_bit(i, array_info->invert_mask)) &&
> +			    test_bit(FLAG_ACTIVE_LOW, &desc->flags))
>   				value = !value;
>   			trace_gpio_value(desc_to_gpio(desc), 0, value);
>   			/*
> @@ -3087,7 +3159,12 @@ int gpiod_set_array_value_complex(bool raw, bool can_sleep,
>   					__clear_bit(hwgpio, bits);
>   				count++;
>   			}
> -			i++;
> +
> +			if (array_info)
> +				find_next_zero_bit(array_info->set_mask,
> +						   array_size, i);
> +			else
> +				i++;
>   		} while ((i < array_size) &&
>   			 (desc_array[i]->gdev->chip == chip));
>   		/* push collected bits to outputs */
>

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

