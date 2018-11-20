Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A8A1C41536
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 17:26:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1B1C20831
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 17:25:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="oHsJqEL/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1B1C20831
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729539AbeKUDz7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 22:55:59 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:57455 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726314AbeKUDz7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 22:55:59 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20181120172542euoutp0128d496b8b59deff437141afdc758fdec~o5RMWznPC1727417274euoutp01M
        for <linux-kernel@vger.kernel.org>; Tue, 20 Nov 2018 17:25:42 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20181120172542euoutp0128d496b8b59deff437141afdc758fdec~o5RMWznPC1727417274euoutp01M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1542734742;
        bh=OK3+KtbLau+jKjMd/mxEwuw63ufehGU+XV+pENUVG1s=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=oHsJqEL/wDopymtYrRcqjbcFv1Ek2J8hEoB7pB/UIm+0oUaCwN2YtNReLEddn9rru
         kozfyP8M86twRYM2mS+sbC0nsfrPRno0vnJ01TovJCchD7d5jWCXSGoLW+jNQzt+wy
         VcgHckMtNWiIUP/KBVNs7J0wdu8fo59+oZtmhMCU=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20181120172541eucas1p2153bd44cb4735ced8bb3b7f289dbb152~o5RLKX_1B1183511835eucas1p2p;
        Tue, 20 Nov 2018 17:25:41 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 95.08.04806.49344FB5; Tue, 20
        Nov 2018 17:25:40 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20181120172540eucas1p29bb48c51d2f0d10cd0ad3a1b889534cf~o5RKBQYR40512305123eucas1p2l;
        Tue, 20 Nov 2018 17:25:40 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20181120172539eusmtrp2c3d88cd2513b588535636b5241023ac5~o5RJyLOol3179831798eusmtrp2e;
        Tue, 20 Nov 2018 17:25:39 +0000 (GMT)
X-AuditID: cbfec7f5-367ff700000012c6-dd-5bf44394c916
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id C9.D7.04128.39344FB5; Tue, 20
        Nov 2018 17:25:39 +0000 (GMT)
Received: from [106.116.147.30] (unknown [106.116.147.30]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20181120172539eusmtip20e2d1731b8d8c03492bba6717eefa9ce~o5RJbtD5F0300703007eusmtip2X;
        Tue, 20 Nov 2018 17:25:39 +0000 (GMT)
Subject: Re: [PATCH] regulator: wm8994: Don't use devres for enable GPIOs
To:     Charles Keepax <ckeepax@opensource.cirrus.com>, broonie@kernel.org
Cc:     linus.walleij@linaro.org, lgirdwood@gmail.com,
        linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <c426f174-dc45-3a25-4c7e-018972c2ceef@samsung.com>
Date:   Tue, 20 Nov 2018 18:25:38 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
        Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <20181120170152.24652-1-ckeepax@opensource.cirrus.com>
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrCKsWRmVeSWpSXmKPExsWy7djPc7pTnL9EG0ybZWYx9eETNosrrZsY
        Lb5d6WCymPJnOZPF5V1z2Cw+v9/P6sDmsXPWXXaPTas62TzuXNvD5jF9zn9Gj8+b5AJYo7hs
        UlJzMstSi/TtErgyTvR8ZCn4YVCx/O9E1gbGO5pdjBwcEgImEmvnxHYxcnIICaxglFi5M7mL
        kQvI/sIosfrRE3YI5zOjxLIPP9lAqkAajjx9BpVYzihx5v8TZgjnPaPE0yXXGUGqhAU8JW5s
        Owhmiwi4Sby+v4YZxGYWKJD41vsEzGYTMJToetvFBnIGr4CdxMRGMZAwi4CqxMa/u5hAbFGB
        GIljK2+AjeEVEJQ4OfMJC4jNKeAssf3kVaiR8hLNW2dD2eISt57MZwK5R0JgFbvE4t+b2SGu
        dpHo7fvBBGELS7w6vgUqLiPxfydMQzOjRPuMWewQTg+jxNY5O6B+tpY4fPwiK8ilzAKaEut3
        6UOEHSVuzdvCCAlHPokbbwUhjuCTmLRtOjNEmFeio00IolpNYtbxdXBrD164xDyBUWkWktdm
        IXlnFpJ3ZiHsXcDIsopRPLW0ODc9tdg4L7Vcrzgxt7g0L10vOT93EyMw7Zz+d/zrDsZ9f5IO
        MQpwMCrx8CYIf4kWYk0sK67MPcQowcGsJMJ7TgsoxJuSWFmVWpQfX1Sak1p8iFGag0VJnLea
        4UG0kEB6YklqdmpqQWoRTJaJg1OqgTHzguuVFpGHQjdneml+FuQ6av/mhJNbr0P0A5/lnr/v
        3dW5PmfqalUzVY2zfDqd145xrmMW2lIceZdzSWbP9D0B8/cqPBZPk/km8nLmwpbtWSXPziuu
        eGn0R6JPWHdlUOui4DzHjasnaE+eUJte0cAWIXySg/1PwJxTb8/8C17+5r9L1pnQf2uUWIoz
        Eg21mIuKEwF1LN0/NwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrBIsWRmVeSWpSXmKPExsVy+t/xe7qTnb9EG8x5oWUx9eETNosrrZsY
        Lb5d6WCymPJnOZPF5V1z2Cw+v9/P6sDmsXPWXXaPTas62TzuXNvD5jF9zn9Gj8+b5AJYo/Rs
        ivJLS1IVMvKLS2yVog0tjPQMLS30jEws9QyNzWOtjEyV9O1sUlJzMstSi/TtEvQyTvR8ZCn4
        YVCx/O9E1gbGO5pdjJwcEgImEkeePmPvYuTiEBJYyihxpXMPK0RCRuLktAYoW1jiz7UuNoii
        t4wSWx9OYwdJCAt4StzYdpARxBYRcJN4fX8NM4jNLFAgcbLlLtTUaYwSjR9+sYAk2AQMJbre
        gkzi4OAVsJOY2CgGEmYRUJXY+HcXE4gtKhAj0Xl9HhuIzSsgKHFy5hOwVk4BZ4ntJ69CzVeX
        +DPvEpQtL9G8dTaULS5x68l8pgmMQrOQtM9C0jILScssJC0LGFlWMYqklhbnpucWG+kVJ+YW
        l+al6yXn525iBMbatmM/t+xg7HoXfIhRgINRiYc3QfhLtBBrYllxZe4hRgkOZiUR3nNaQCHe
        lMTKqtSi/Pii0pzU4kOMpkDPTWSWEk3OB6aBvJJ4Q1NDcwtLQ3Njc2MzCyVx3vMGlVFCAumJ
        JanZqakFqUUwfUwcnFINjKEh3zz/dBX8jwkyz7M+oH18cviajXF8s98w3Jx27VuG4dPdBZ+f
        7DJP26xW0ZUbxb3Y/3l3q0Wl0YJ1H/jLP2/kL7Px+33vz/I5yypyp/tM3JEUf23fWX0Z48hn
        SxukPcMe7F9xIrDh7uSpZvtPLNxXd7Rom8ihV7+Or05clTpDPv31KXfPZAMlluKMREMt5qLi
        RADegF7pywIAAA==
X-CMS-MailID: 20181120172540eucas1p29bb48c51d2f0d10cd0ad3a1b889534cf
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20181120170248epcas1p2a93ec9ff7f74ad4908166590ed548386
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181120170248epcas1p2a93ec9ff7f74ad4908166590ed548386
References: <CGME20181120170248epcas1p2a93ec9ff7f74ad4908166590ed548386@epcas1p2.samsung.com>
        <20181120170152.24652-1-ckeepax@opensource.cirrus.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Charles,

On 2018-11-20 18:01, Charles Keepax wrote:
> We need to manage the life time of the enable GPIO against the regulator
> device but the OF node lives on the parent MFD device. As such we can't
> use the devm functions which assume the same device will be used for
> both.
>
> Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> ---
>
> This patch is only build tested so it would be good to get a
> tested by from Marek before applying.

Sadly it looks that it is not enough. The issue is still there:

wm8994 4-001a: Failed to get supply 'DBVDD1': -517
wm8994 4-001a: Failed to get supplies: -517
------------[ cut here ]------------
WARNING: CPU: 0 PID: 1 at drivers/gpio/gpiolib.c:2421
regulator_ena_gpio_free+0x70/0xa0
Modules linked in:
CPU: 0 PID: 1 Comm: swapper/0 Not tainted
4.20.0-rc3-next-20181120-00001-g330f37c7fb0c #5090
Hardware name: SAMSUNG EXYNOS (Flattened Device Tree)
[<c0111a54>] (unwind_backtrace) from [<c010d900>] (show_stack+0x10/0x14)
[<c010d900>] (show_stack) from [<c09e5878>] (dump_stack+0x90/0xc8)
[<c09e5878>] (dump_stack) from [<c0125998>] (__warn+0xf8/0x124)
[<c0125998>] (__warn) from [<c0125a04>] (warn_slowpath_null+0x40/0x48)
[<c0125a04>] (warn_slowpath_null) from [<c04a5b68>]
(regulator_ena_gpio_free+0x70/0xa0)
[<c04a5b68>] (regulator_ena_gpio_free) from [<c04aa03c>]
(regulator_unregister+0x134/0x17c)
[<c04aa03c>] (regulator_unregister) from [<c054b5f8>]
(release_nodes+0x164/0x1dc)
[<c054b5f8>] (release_nodes) from [<c054810c>]
(device_release_driver_internal+0x18c/0x21c)
[<c054810c>] (device_release_driver_internal) from [<c054698c>]
(bus_remove_device+0xdc/0x12c)
[<c054698c>] (bus_remove_device) from [<c05434bc>] (device_del+0x108/0x2e0)
[<c05434bc>] (device_del) from [<c0549c38>] (platform_device_del+0x20/0x8c)
[<c0549c38>] (platform_device_del) from [<c0549cb0>]
(platform_device_unregister+0xc/0x18)
[<c0549cb0>] (platform_device_unregister) from [<c0575120>]
(mfd_remove_devices_fn+0x58/0x64)
[<c0575120>] (mfd_remove_devices_fn) from [<c05425a8>]
(device_for_each_child_reverse+0x34/0x74)
[<c05425a8>] (device_for_each_child_reverse) from [<c0574f18>]
(mfd_remove_devices+0x20/0x30)
[<c0574f18>] (mfd_remove_devices) from [<c0573b1c>]
(wm8994_i2c_probe+0x2dc/0x8d0)
[<c0573b1c>] (wm8994_i2c_probe) from [<c068bce4>]
(i2c_device_probe+0x234/0x2b0)
[<c068bce4>] (i2c_device_probe) from [<c0547774>] (really_probe+0x224/0x3f4)
[<c0547774>] (really_probe) from [<c0547b98>]
(driver_probe_device+0x70/0x1c4)
[<c0547b98>] (driver_probe_device) from [<c0547e0c>]
(__driver_attach+0x120/0x144)
[<c0547e0c>] (__driver_attach) from [<c05459f0>]
(bus_for_each_dev+0x58/0x7c)
[<c05459f0>] (bus_for_each_dev) from [<c0546b50>]
(bus_add_driver+0x174/0x250)
[<c0546b50>] (bus_add_driver) from [<c0548db8>] (driver_register+0x7c/0x110)
[<c0548db8>] (driver_register) from [<c068ddcc>]
(i2c_register_driver+0x38/0xa8)
[<c068ddcc>] (i2c_register_driver) from [<c01030fc>]
(do_one_initcall+0x80/0x408)
[<c01030fc>] (do_one_initcall) from [<c0f011e4>]
(kernel_init_freeable+0x3a0/0x4fc)
[<c0f011e4>] (kernel_init_freeable) from [<c09fdd6c>]
(kernel_init+0x8/0x118)
[<c09fdd6c>] (kernel_init) from [<c01010b4>] (ret_from_fork+0x14/0x20)
Exception stack(0xef0e3fb0 to 0xef0e3ff8)
3fa0:                                     00000000 00000000 00000000
00000000
3fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000
00000000
3fe0: 00000000 00000000 00000000 00000000 00000013 00000000
irq event stamp: 176913
hardirqs last  enabled at (176921): [<c018b1c0>] console_unlock+0x460/0x6ec
hardirqs last disabled at (176940): [<c018ae18>] console_unlock+0xb8/0x6ec
softirqs last  enabled at (176956): [<c01024e4>] __do_softirq+0x3a4/0x66c
softirqs last disabled at (176967): [<c012d618>] irq_exit+0x140/0x168

I will check more tomorrow.


> Thanks,
> Charles
>
>  drivers/regulator/wm8994-regulator.c | 28 +++++++++++++++++++++++-----
>  1 file changed, 23 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/regulator/wm8994-regulator.c b/drivers/regulator/wm8994-regulator.c
> index d7fec533c403..f2592c30d0ca 100644
> --- a/drivers/regulator/wm8994-regulator.c
> +++ b/drivers/regulator/wm8994-regulator.c
> @@ -31,6 +31,7 @@ struct wm8994_ldo {
>  	struct wm8994 *wm8994;
>  	struct regulator_consumer_supply supply;
>  	struct regulator_init_data init_data;
> +	struct gpio_desc *ena_gpiod;
>  };
>  
>  #define WM8994_LDO1_MAX_SELECTOR 0x7
> @@ -147,14 +148,19 @@ static int wm8994_ldo_probe(struct platform_device *pdev)
>  	config.regmap = wm8994->regmap;
>  	config.init_data = &ldo->init_data;
>  
> -	/* Look up LDO enable GPIO from the parent device node */
> -	gpiod = devm_gpiod_get_optional(pdev->dev.parent,
> -					id ? "wlf,ldo2ena" : "wlf,ldo1ena",
> -					GPIOD_OUT_LOW |
> -					GPIOD_FLAGS_BIT_NONEXCLUSIVE);
> +	/*
> +	 * Look up LDO enable GPIO from the parent device node, we can't
> +	 * use devm because it assumes the device we want to allocate
> +	 * against is the same one that holds the OF node
> +	 */
> +	gpiod = gpiod_get_optional(pdev->dev.parent,
> +				   id ? "wlf,ldo2ena" : "wlf,ldo1ena",
> +				   GPIOD_OUT_LOW |
> +				   GPIOD_FLAGS_BIT_NONEXCLUSIVE);
>  	if (IS_ERR(gpiod))
>  		return PTR_ERR(gpiod);
>  	config.ena_gpiod = gpiod;
> +	ldo->ena_gpiod = gpiod;
>  
>  	/* Use default constraints if none set up */
>  	if (!pdata || !pdata->ldo[id].init_data || wm8994->dev->of_node) {
> @@ -184,11 +190,23 @@ static int wm8994_ldo_probe(struct platform_device *pdev)
>  	return 0;
>  
>  err:
> +	gpiod_put(gpiod);
>  	return ret;
>  }
>  
> +static int wm8994_ldo_remove(struct platform_device *pdev)
> +{
> +	struct wm8994_ldo *ldo = platform_get_drvdata(pdev);
> +
> +	if (ldo->ena_gpiod)
> +		gpiod_put(ldo->ena_gpiod);
> +
> +	return 0;
> +}
> +
>  static struct platform_driver wm8994_ldo_driver = {
>  	.probe = wm8994_ldo_probe,
> +	.remove = wm8994_ldo_remove,
>  	.driver		= {
>  		.name	= "wm8994-ldo",
>  	},

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

