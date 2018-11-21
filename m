Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 599FAC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 09:26:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0529821479
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 09:26:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="hnugkDcP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0529821479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729411AbeKUUAS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 15:00:18 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:58361 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728467AbeKUUAR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 15:00:17 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20181121092633euoutp01e8d8719abd7cd81a70027c48f841b264~pGYH9Aaod2151121511euoutp01-
        for <linux-kernel@vger.kernel.org>; Wed, 21 Nov 2018 09:26:33 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20181121092633euoutp01e8d8719abd7cd81a70027c48f841b264~pGYH9Aaod2151121511euoutp01-
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1542792393;
        bh=1YImgLiMc3yuuyubE8ao6Cn2JjmAkSSoMqGwuD+ClNo=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=hnugkDcP5RFC8pB7h3hJvkQlq2+Jdij3H9bA+/w+Mlv9q3mes8NDmGHUIKVGmLxxV
         LjXIvRLPd3qYR6rB0Wn9RWA6aB8WN3Q2e48R7+0LaFE2R7ESmqz42WwfWaEGFnhkp3
         IFaRGB3LkZZkj71X1yz/owlaXSufxHGT25qo9V6c=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20181121092632eucas1p252c235ec446d65fbd62bead9043a7688~pGYHgsCm11842118421eucas1p2O;
        Wed, 21 Nov 2018 09:26:32 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id FE.42.04441.8C425FB5; Wed, 21
        Nov 2018 09:26:32 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20181121092631eucas1p1c153ccafac4a3c8a38439065003644ed~pGYGgLUWz2587825878eucas1p1F;
        Wed, 21 Nov 2018 09:26:31 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20181121092631eusmtrp1a08200c80427c5622026f71562ec054f~pGYGRy5PM2822228222eusmtrp1_;
        Wed, 21 Nov 2018 09:26:31 +0000 (GMT)
X-AuditID: cbfec7f2-5e3ff70000001159-b2-5bf524c8c8b0
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 69.E6.04284.7C425FB5; Wed, 21
        Nov 2018 09:26:31 +0000 (GMT)
Received: from [106.116.147.30] (unknown [106.116.147.30]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20181121092631eusmtip21130cd043e5c6db44edef4c20d0edec2~pGYF7ru8J0277202772eusmtip2s;
        Wed, 21 Nov 2018 09:26:31 +0000 (GMT)
Subject: Re: [PATCH] regulator: wm8994: Don't use devres for enable GPIOs
From:   Marek Szyprowski <m.szyprowski@samsung.com>
To:     Charles Keepax <ckeepax@opensource.cirrus.com>, broonie@kernel.org
Cc:     linus.walleij@linaro.org, lgirdwood@gmail.com,
        linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
Message-ID: <b7648606-b5d1-c42f-cf68-338fbc3cf4df@samsung.com>
Date:   Wed, 21 Nov 2018 10:26:30 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
        Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <c426f174-dc45-3a25-4c7e-018972c2ceef@samsung.com>
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrKKsWRmVeSWpSXmKPExsWy7djPc7onVL5GG7xarm0x9eETNosrrZsY
        Lb5d6WCymPJnOZPF5V1z2Cw+v9/P6sDmsXPWXXaPTas62TzuXNvD5jF9zn9Gj8+b5AJYo7hs
        UlJzMstSi/TtErgyvuy9wFSwwrxiw/TdrA2MT/S6GDk5JARMJK6+X8fSxcjFISSwglHiwMeH
        zBDOF0aJw+0v2ECqhAQ+M0osnpIG03H2/FVGiKLljBIv31yAct4zSnx48RWsQ1jAU+LGtoOM
        IDabgKFE19susLiIgJvE6/trmEFsZoECiW+9T8BsXgE7ifl/vrOC2CwCqhJfG76CxUUFYiSO
        rbzBCFEjKHFy5hMWEJtTwF7iz4fn7BBz5CWat86GmikucevJfCaQgyQEVrFLLNi8FyjBAeS4
        SCw8qgnxgbDEq+Nb2CFsGYnTk3tYIOqbGSXaZ8xih3B6GCW2ztnBBlFlLXH4+EVWkEHMApoS
        63fpQ4QdJW7N28IIMZ9P4sZbQYgb+CQmbZsOtZZXoqNNCKJaTWLW8XVwaw9euMQ8gVFpFpLP
        ZiH5ZhaSb2Yh7F3AyLKKUTy1tDg3PbXYMC+1XK84Mbe4NC9dLzk/dxMjMPGc/nf80w7Gr5eS
        DjEKcDAq8fAmCH+JFmJNLCuuzD3EKMHBrCTC2/scKMSbklhZlVqUH19UmpNafIhRmoNFSZy3
        muFBtJBAemJJanZqakFqEUyWiYNTqoHxwEdHxd5Fhipeze9jbne6eEwSv+k2+6X40U3nrgbf
        2V+y4/+Dy9z7+e+nN3o0z7X/tsTuxObGxcdFG8Oda5b+LC5tal6ZJZo499jLBRulEgJ4N2za
        JaLg3Bd7feaN110ef8+v/NayYc4FvazlV279bun4wZxjNpvx6Xf1SuMK/33HcxQZbDZxKrEU
        ZyQaajEXFScCAG25AiQ4AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrJIsWRmVeSWpSXmKPExsVy+t/xe7rHVb5GG0xbpmox9eETNosrrZsY
        Lb5d6WCymPJnOZPF5V1z2Cw+v9/P6sDmsXPWXXaPTas62TzuXNvD5jF9zn9Gj8+b5AJYo/Rs
        ivJLS1IVMvKLS2yVog0tjPQMLS30jEws9QyNzWOtjEyV9O1sUlJzMstSi/TtEvQyvuy9wFSw
        wrxiw/TdrA2MT/S6GDk5JARMJM6ev8rYxcjFISSwlFHi/NJ1LBAJGYmT0xpYIWxhiT/Xutgg
        it4ySkxeNoMJJCEs4ClxY9tBRhCbTcBQoustSBEnh4iAm8Tr+2uYQWxmgQKJky132SGaTzNK
        rDi2H6yZV8BOYv6f72AbWARUJb42fAVrEBWIkei8Po8NokZQ4uTMJ2AXcQrYS/z58JwdYqi6
        xJ95l6AWyEs0b50NZYtL3Hoyn2kCo9AsJO2zkLTMQtIyC0nLAkaWVYwiqaXFuem5xYZ6xYm5
        xaV56XrJ+bmbGIHRtu3Yz807GC9tDD7EKMDBqMTDmyD8JVqINbGsuDL3EKMEB7OSCG/vc6AQ
        b0piZVVqUX58UWlOavEhRlOg5yYyS4km5wMTQV5JvKGpobmFpaG5sbmxmYWSOO95g8ooIYH0
        xJLU7NTUgtQimD4mDk6pBkaPkv6Gh5kOHTPVX5cmGSRlsz/Qn5VT6cfl+P5/verB3ToxQVmM
        V/2FVn+832zPaDDlx5r7HizVTbG33Xvv/A2ZtHlDiv+kgHs7bf7fEhNyOMN/TfbS4rO9vJs6
        g27FCgYf8vspnnXgr8QKg65aFbEX63mW8Nw5cW5VdmWh/LJXCybVchQ6ySuxFGckGmoxFxUn
        AgAr5WqHzAIAAA==
X-CMS-MailID: 20181121092631eucas1p1c153ccafac4a3c8a38439065003644ed
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20181120170248epcas1p2a93ec9ff7f74ad4908166590ed548386
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181120170248epcas1p2a93ec9ff7f74ad4908166590ed548386
References: <CGME20181120170248epcas1p2a93ec9ff7f74ad4908166590ed548386@epcas1p2.samsung.com>
        <20181120170152.24652-1-ckeepax@opensource.cirrus.com>
        <c426f174-dc45-3a25-4c7e-018972c2ceef@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2018-11-20 18:25, Marek Szyprowski wrote:
> Hi Charles,
>
> On 2018-11-20 18:01, Charles Keepax wrote:
>> We need to manage the life time of the enable GPIO against the regulator
>> device but the OF node lives on the parent MFD device. As such we can't
>> use the devm functions which assume the same device will be used for
>> both.
>>
>> Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
>> Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
>> ---
>>
>> This patch is only build tested so it would be good to get a
>> tested by from Marek before applying.
> Sadly it looks that it is not enough. The issue is still there:
>
> wm8994 4-001a: Failed to get supply 'DBVDD1': -517
> wm8994 4-001a: Failed to get supplies: -517
> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 1 at drivers/gpio/gpiolib.c:2421
> regulator_ena_gpio_free+0x70/0xa0
> Modules linked in:
> CPU: 0 PID: 1 Comm: swapper/0 Not tainted
> 4.20.0-rc3-next-20181120-00001-g330f37c7fb0c #5090
> Hardware name: SAMSUNG EXYNOS (Flattened Device Tree)
> [<c0111a54>] (unwind_backtrace) from [<c010d900>] (show_stack+0x10/0x14)
> [<c010d900>] (show_stack) from [<c09e5878>] (dump_stack+0x90/0xc8)
> [<c09e5878>] (dump_stack) from [<c0125998>] (__warn+0xf8/0x124)
> [<c0125998>] (__warn) from [<c0125a04>] (warn_slowpath_null+0x40/0x48)
> [<c0125a04>] (warn_slowpath_null) from [<c04a5b68>]
> (regulator_ena_gpio_free+0x70/0xa0)
> [<c04a5b68>] (regulator_ena_gpio_free) from [<c04aa03c>]
> (regulator_unregister+0x134/0x17c)
> [<c04aa03c>] (regulator_unregister) from [<c054b5f8>]
> (release_nodes+0x164/0x1dc)
> [<c054b5f8>] (release_nodes) from [<c054810c>]
> (device_release_driver_internal+0x18c/0x21c)
> [<c054810c>] (device_release_driver_internal) from [<c054698c>]
> (bus_remove_device+0xdc/0x12c)
> [<c054698c>] (bus_remove_device) from [<c05434bc>] (device_del+0x108/0x2e0)
> [<c05434bc>] (device_del) from [<c0549c38>] (platform_device_del+0x20/0x8c)
> [<c0549c38>] (platform_device_del) from [<c0549cb0>]
> (platform_device_unregister+0xc/0x18)
> [<c0549cb0>] (platform_device_unregister) from [<c0575120>]
> (mfd_remove_devices_fn+0x58/0x64)
> [<c0575120>] (mfd_remove_devices_fn) from [<c05425a8>]
> (device_for_each_child_reverse+0x34/0x74)
> [<c05425a8>] (device_for_each_child_reverse) from [<c0574f18>]
> (mfd_remove_devices+0x20/0x30)
> [<c0574f18>] (mfd_remove_devices) from [<c0573b1c>]
> (wm8994_i2c_probe+0x2dc/0x8d0)
> [<c0573b1c>] (wm8994_i2c_probe) from [<c068bce4>]
> (i2c_device_probe+0x234/0x2b0)
> [<c068bce4>] (i2c_device_probe) from [<c0547774>] (really_probe+0x224/0x3f4)
> [<c0547774>] (really_probe) from [<c0547b98>]
> (driver_probe_device+0x70/0x1c4)
> [<c0547b98>] (driver_probe_device) from [<c0547e0c>]
> (__driver_attach+0x120/0x144)
> [<c0547e0c>] (__driver_attach) from [<c05459f0>]
> (bus_for_each_dev+0x58/0x7c)
> [<c05459f0>] (bus_for_each_dev) from [<c0546b50>]
> (bus_add_driver+0x174/0x250)
> [<c0546b50>] (bus_add_driver) from [<c0548db8>] (driver_register+0x7c/0x110)
> [<c0548db8>] (driver_register) from [<c068ddcc>]
> (i2c_register_driver+0x38/0xa8)
> [<c068ddcc>] (i2c_register_driver) from [<c01030fc>]
> (do_one_initcall+0x80/0x408)
> [<c01030fc>] (do_one_initcall) from [<c0f011e4>]
> (kernel_init_freeable+0x3a0/0x4fc)
> [<c0f011e4>] (kernel_init_freeable) from [<c09fdd6c>]
> (kernel_init+0x8/0x118)
> [<c09fdd6c>] (kernel_init) from [<c01010b4>] (ret_from_fork+0x14/0x20)
> Exception stack(0xef0e3fb0 to 0xef0e3ff8)
> 3fa0:                                     00000000 00000000 00000000
> 00000000
> 3fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000
> 00000000
> 3fe0: 00000000 00000000 00000000 00000000 00000013 00000000
> irq event stamp: 176913
> hardirqs last  enabled at (176921): [<c018b1c0>] console_unlock+0x460/0x6ec
> hardirqs last disabled at (176940): [<c018ae18>] console_unlock+0xb8/0x6ec
> softirqs last  enabled at (176956): [<c01024e4>] __do_softirq+0x3a4/0x66c
> softirqs last disabled at (176967): [<c012d618>] irq_exit+0x140/0x168
>
> I will check more tomorrow.

I've checked a bit more and it looks that the issue is caused by
gpiod_put() in regulator_ena_gpio_free(). I've removed gpiod_put() call
from wm8994_ldo_remove(), switched to regulator_register() in
wm8994_ldo_probe() and added regulator_unregister() in
wm8994_ldo_remove(). This way the warning is gone. If there is any
other, simpler way to fix it, let me know. When regulator_register()
fails, gpiod will be freed only in some cases, depending what caused
failure. It looks that this needs some clarification...

>
>> Thanks,
>> Charles
>>
>>  drivers/regulator/wm8994-regulator.c | 28 +++++++++++++++++++++++-----
>>  1 file changed, 23 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/regulator/wm8994-regulator.c b/drivers/regulator/wm8994-regulator.c
>> index d7fec533c403..f2592c30d0ca 100644
>> --- a/drivers/regulator/wm8994-regulator.c
>> +++ b/drivers/regulator/wm8994-regulator.c
>> @@ -31,6 +31,7 @@ struct wm8994_ldo {
>>  	struct wm8994 *wm8994;
>>  	struct regulator_consumer_supply supply;
>>  	struct regulator_init_data init_data;
>> +	struct gpio_desc *ena_gpiod;
>>  };
>>  
>>  #define WM8994_LDO1_MAX_SELECTOR 0x7
>> @@ -147,14 +148,19 @@ static int wm8994_ldo_probe(struct platform_device *pdev)
>>  	config.regmap = wm8994->regmap;
>>  	config.init_data = &ldo->init_data;
>>  
>> -	/* Look up LDO enable GPIO from the parent device node */
>> -	gpiod = devm_gpiod_get_optional(pdev->dev.parent,
>> -					id ? "wlf,ldo2ena" : "wlf,ldo1ena",
>> -					GPIOD_OUT_LOW |
>> -					GPIOD_FLAGS_BIT_NONEXCLUSIVE);
>> +	/*
>> +	 * Look up LDO enable GPIO from the parent device node, we can't
>> +	 * use devm because it assumes the device we want to allocate
>> +	 * against is the same one that holds the OF node
>> +	 */
>> +	gpiod = gpiod_get_optional(pdev->dev.parent,
>> +				   id ? "wlf,ldo2ena" : "wlf,ldo1ena",
>> +				   GPIOD_OUT_LOW |
>> +				   GPIOD_FLAGS_BIT_NONEXCLUSIVE);
>>  	if (IS_ERR(gpiod))
>>  		return PTR_ERR(gpiod);
>>  	config.ena_gpiod = gpiod;
>> +	ldo->ena_gpiod = gpiod;
>>  
>>  	/* Use default constraints if none set up */
>>  	if (!pdata || !pdata->ldo[id].init_data || wm8994->dev->of_node) {
>> @@ -184,11 +190,23 @@ static int wm8994_ldo_probe(struct platform_device *pdev)
>>  	return 0;
>>  
>>  err:
>> +	gpiod_put(gpiod);
>>  	return ret;
>>  }
>>  
>> +static int wm8994_ldo_remove(struct platform_device *pdev)
>> +{
>> +	struct wm8994_ldo *ldo = platform_get_drvdata(pdev);
>> +
>> +	if (ldo->ena_gpiod)
>> +		gpiod_put(ldo->ena_gpiod);
>> +
>> +	return 0;
>> +}
>> +
>>  static struct platform_driver wm8994_ldo_driver = {
>>  	.probe = wm8994_ldo_probe,
>> +	.remove = wm8994_ldo_remove,
>>  	.driver		= {
>>  		.name	= "wm8994-ldo",
>>  	},
> Best regards

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

