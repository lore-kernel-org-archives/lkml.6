Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF132C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 14:30:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69F6320878
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 14:30:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="FbsxNMF+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69F6320878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727675AbeLEOa1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 09:30:27 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:36762 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727025AbeLEOa1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 09:30:27 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20181205143025euoutp019a8ab85716aae19a788aabe6b58758ec~tdjbwhIBD2980029800euoutp01W
        for <linux-kernel@vger.kernel.org>; Wed,  5 Dec 2018 14:30:25 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20181205143025euoutp019a8ab85716aae19a788aabe6b58758ec~tdjbwhIBD2980029800euoutp01W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1544020225;
        bh=/ULkljs0PabWBtRi9Unqkq2tmd26R1gFZ9DWJ1WV4Vk=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=FbsxNMF+wA9Ulkcsy2xPBRyNyGhtNb2P03a8PF5UbFEGzfy1ct0lkgyjj7k0JSWyo
         CJnMuLn/Kr1W4Jj5yfq+IHXZqhjdsa4Xqu/wKu8zvrXHMOqDI7rOZBKpI2sHzgxBTu
         JHv8DIgROLimALUNMUuKz0Hr8dVUFp9Kd9GJnZmM=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20181205143024eucas1p14a3b9c891cb377c2d95bb67400c0088b~tdjbFkpu92872228722eucas1p1E;
        Wed,  5 Dec 2018 14:30:24 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id BF.6A.04806.001E70C5; Wed,  5
        Dec 2018 14:30:24 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20181205143023eucas1p2427b6b2c4a4c342230a8d24ba37e2abb~tdjaKIJ7q1536615366eucas1p2E;
        Wed,  5 Dec 2018 14:30:23 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20181205143023eusmtrp1ad160491ed0b605d4584ec63b8a587db~tdjZ7ynl12156021560eusmtrp1a;
        Wed,  5 Dec 2018 14:30:23 +0000 (GMT)
X-AuditID: cbfec7f5-34dff700000012c6-f6-5c07e100a59a
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id C6.DF.04128.FF0E70C5; Wed,  5
        Dec 2018 14:30:23 +0000 (GMT)
Received: from [106.116.147.30] (unknown [106.116.147.30]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20181205143023eusmtip28bc2b365da99c22f44204630359459de~tdjZnQpOI1373913739eusmtip2i;
        Wed,  5 Dec 2018 14:30:23 +0000 (GMT)
Subject: Re: [PATCH 00/13 v2] Regulator ena_gpiod fixups
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <b1ecf322-92bd-79e9-9c8c-b87a534afc11@samsung.com>
Date:   Wed, 5 Dec 2018 15:30:22 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
        Thunderbird/60.3.2
MIME-Version: 1.0
In-Reply-To: <CACRpkdbVSEYJpSb6Uzji158gL7WHu_Bfpw2gK-qo2s66dWjY7Q@mail.gmail.com>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA01SfyyUcRz2vfe9931Pjq+jfCbTdlMmIemP25Ip/XH/VWsTsnLyDssdux9C
        5Lb86qJVTrhdaf3jUNquXDpK1FzRCtHMCOuaVqFFlibl9VL+e57n83z2PJ/twxCSRqEvk67S
        smqVIkNKuZK27sXXIS6TdOLuPqO/bP5GDymrmnRSssFiK5ItDJYJZMaleoHsrd1MRVPy2eFi
        Wv7INEbLrY0XKfnou3ZKXm3+g+RzVv8jVIJrZAqbkZ7NqsOiklzTpt87UdZHj5zbd/WEHn1w
        MyARA3gvXG16QxmQKyPBFgS27/UCnswjuGmsWCNzCCyjDeT6in1oiuAH9Qhq2gw0T2YRlHVX
        Ic7lhWVwp3tsFXvjXXDJtijkTASeQaDvbie4AYXDwTBtWElnGDGOgp6eQk4mcQBUNjUIOHkz
        TgT7VD4ni7EnvKx1kpwswkeh+Us4JxN4GzycNhM89oERZ91qacA2GkZK6oR86UPw07FI89gL
        PjserGE/6K0sJ/mFCwhKa0w0T8oRtJhbKd61D545+oVcMoGD4J49jJcPgH1yfLUnYHcYnvbk
        S7jDNVs1wctiKCuR8O4dYHI0/4vt7BsgriCpacNlpg3nmDacY/qfewuRjciH1WmUqawmQsWe
        DdUolBqdKjX0dKbSilY+qHfZ8aMVPVlK7kKYQVI3MRipRIlQka3JVXYhYAipt9gSSSdKxCmK
        3DxWnXlKrctgNV1oK0NKfcTnXCZOSHCqQsueYdksVr0+FTAiXz3aErS/82aq0PKY/v0iak/l
        r4CUeWfeuD7vubUtbibm+FBIXHBa8NOqHI/rfl4nDeaYVy1TX4WBC9L++CJbQVzgxPg37faD
        uZKa/Hjd5ahkZ5G+8Nhk20BV0kDtcmyJ8HBBR8ScsrZGpC36NBZboe0wbyotVHqKo6kEk501
        nr8fLCU1aYrwnYRao/gLIT9MED0DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrNIsWRmVeSWpSXmKPExsVy+t/xe7r/H7DHGOy8qmLxZe4pFoupD5+w
        WVxp3cRo8e1KB5PFlD/LmSwu75rD5sDm8f5GK7vHzll32T02repk87hzbQ+bx/Q5/xk9Pm+S
        C2CL0rMpyi8tSVXIyC8usVWKNrQw0jO0tNAzMrHUMzQ2j7UyMlXSt7NJSc3JLEst0rdL0Mt4
        e+8JY8FT/opFaxuYGxgf83QxcnJICJhI7Lr6nBnEFhJYyijxeFYeRFxG4uS0BlYIW1jiz7Uu
        Noiat4wSu35KgdjCAhYSa47dZQSxRQR0JLq3/QSq5+JgFnjHKHH75C4WEEdIoJNZYmvHVRaQ
        KjYBQ4mutyCTODh4BewkTp2qBwmzCKhITF69kgnEFhWIkZhy+TXYYl4BQYmTM5+wgJRzCgRK
        rHttCBJmFlCX+DPvEjOELS+x/e0cKFtc4taT+UwTGIVmIemehaRlFpKWWUhaFjCyrGIUSS0t
        zk3PLTbSK07MLS7NS9dLzs/dxAiMuG3Hfm7Zwdj1LvgQowAHoxIPr8QUthgh1sSy4srcQ4wS
        HMxKIrwrbNhjhHhTEiurUovy44tKc1KLDzGaAv02kVlKNDkfmAzySuINTQ3NLSwNzY3Njc0s
        lMR5zxtURgkJpCeWpGanphakFsH0MXFwSjUwippHVXVMLQlnyOh/YKov2sbxctmUQ0F9mqwK
        DZPuP5sRnhlcfnJ1LP/D5MDLLEd/8xSf+vjKwTetVKr8lWPMoskNHIVG0hc21gW/ZuZ59PdF
        xRnR9b+j+NmsPz2vKJtVaSDwL3bS4szcHXwHTmy9q/aa7YB+ntmlScwvHTZU/71f3a89a909
        JZbijERDLeai4kQA0BR61M4CAAA=
X-CMS-MailID: 20181205143023eucas1p2427b6b2c4a4c342230a8d24ba37e2abb
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20181201154428epcas4p3a1a5c9c576027b1c56f8dd1510b32187
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181201154428epcas4p3a1a5c9c576027b1c56f8dd1510b32187
References: <CGME20181201154428epcas4p3a1a5c9c576027b1c56f8dd1510b32187@epcas4p3.samsung.com>
        <20181201154151.14890-1-linus.walleij@linaro.org>
        <d6b5f384-51aa-0e99-7e88-a1debcf5eca3@samsung.com>
        <CACRpkdYQ5cy1-8wu--deF0kdzrRGVJ_teNh2LRF7tr9vyh+oHw@mail.gmail.com>
        <455ced52-e444-66f2-7dec-9d37bdd5116c@samsung.com>
        <CACRpkdbVSEYJpSb6Uzji158gL7WHu_Bfpw2gK-qo2s66dWjY7Q@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

On 2018-12-04 13:44, Linus Walleij wrote:
> On Tue, Dec 4, 2018 at 11:33 AM Marek Szyprowski
> <m.szyprowski@samsung.com> wrote:
>
>>>> Artik5 evaluation board (arch/arm/boot/dts/exynos3250-artik5-eval.dtb):
>>>> s2mps11-pmic s2mps14-regulator: Failed to get control GPIO for 11/LDO12
>>> Question: this is supposed to fail, right? It is something
>>> like a probe deferral or nonexisting GPIO controller?
>> It looks that the issue has been introduced earlier, but I didn't notice it.
> Sorry :(
>
>> gpiod_get_from_of_node() doesn't handle GPIOD_FLAGS_BIT_NONEXCLUSIVE
>> flag, the rest is just a result of it.
> OK I see.
>
>> Here we have a case, where 2 regulators provided by s2mps11 driver have
>> a common gpio enable line (by PMIC design), so s2mps11 calls
>> devm_gpiod_get_from_of_node() 2 times for exactly the same gpio descriptor.
>>
>> Fixing gpiod_get_from_of_node() for GPIOD_FLAGS_BIT_NONEXCLUSIVE is trivial:
> I will add a patch like this to the series!
>
>> With the above fix I still however get 2 warnings from devres functions,
>> but this is probably caused by adding the same entry 2 times to the list
>> without proper refcounting... I will check that later.
> Ah I see this regulator driver really excercise all corner cases of
> these nonexclusive GPIO lines. (Which is good!)
>
> Indeed devres is not going to like adding the same thing twice.
>
> I just sent a fix for that, subject:
> "gpio: devres: Handle nonexclusive GPIOs"
> you could perhaps try it on top of this
> series? I intend to merge that separately as a fix for current,
> as it is a bug.

Those 2 warnings were worrying me and I finally found! devres_*
functions require to pass a pointer to the pointer as match_data, so
desc must be passed as &desc to devres_find() and devres_destroy()
functions, otherwise they always return -ENOENT. I will comment
respective lines in your patches then.


Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

