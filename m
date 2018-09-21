Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FORGED_MUA_MOZILLA,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8DE0ECE566
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 14:14:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45BB321550
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 14:14:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="i2DalOc+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45BB321550
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390142AbeIUUDT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 16:03:19 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:35088 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728184AbeIUUDS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 16:03:18 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20180921141411euoutp01cb700cfde6a17a601cc9b2a095132c7b~Wb813tBWC2628326283euoutp01D;
        Fri, 21 Sep 2018 14:14:11 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20180921141411euoutp01cb700cfde6a17a601cc9b2a095132c7b~Wb813tBWC2628326283euoutp01D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1537539251;
        bh=GvZp8nuwtVijAteiyulp3SKkdYv/J3IP6UHkupIZ8zw=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=i2DalOc+j6CF330X1r9ALCIMkmQt8sQPw0pB6yWihTASwMYiHUjGampiBZFGbHElW
         TAM9Be7iFoSK31YbQxwzFPpJJQJvaEP+yOuZMPZKDGx8HDMnxJ+rv51lUw4hFWVeHr
         VJhyWt1sXcK9rAmmkLusFNjdsRNnPkoPDU54nJI4=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20180921141410eucas1p2eb424aca42ebf40adc7036e4abfbb8f8~Wb81NiUQC1306913069eucas1p2n;
        Fri, 21 Sep 2018 14:14:10 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id CC.09.04806.1BCF4AB5; Fri, 21
        Sep 2018 15:14:10 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20180921141409eucas1p190a47e2608429870d23516ee5e75c191~Wb8z_FmwI1466414664eucas1p1F;
        Fri, 21 Sep 2018 14:14:09 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20180921141408eusmtrp106086b6e12679e25a8cd67dad7409ad4~Wb8zqCUM42831428314eusmtrp1v;
        Fri, 21 Sep 2018 14:14:08 +0000 (GMT)
X-AuditID: cbfec7f5-34dff700000012c6-e7-5ba4fcb1bd26
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id E5.A5.04128.0BCF4AB5; Fri, 21
        Sep 2018 15:14:08 +0100 (BST)
Received: from [106.116.147.30] (unknown [106.116.147.30]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20180921141407eusmtip14b73cfb4f9da548f0fb7325da2c9b933~Wb8ySCiPr1685416854eusmtip1S;
        Fri, 21 Sep 2018 14:14:07 +0000 (GMT)
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
        Linux Samsung SOC <linux-samsung-soc@vger.kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Date:   Fri, 21 Sep 2018 16:14:06 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
        Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAGfqbt7xJxGbq3oOJp9S0Sg7Z9=T6Dy52MDNWSDdsU==kPt1KQ@mail.gmail.com>
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA01TbWxTZRT2vfftvXfDzrsC7pWpM41iXGBIZvRE1ECiyfWLwA/BOBSucB3I
        VpZ2H4KSoIN9lJF1FN24FDqzLoMqgts6Rm27rVtWl6Ht2IdQHUHTOgUKnXZNoMO57gbdv+c8
        z3nOec6Pw9Ga28wSboeuWNLrxAItk4o7+m//uLx12pb3dPXb4B/30hDqrkRg8e/H4Lpwh4U7
        N/tY+D3opqC86QwDtd9HEFz9zE7BSIdMw5GzUQoC4RoGnDM3aPD7z7JgM1tVcGS6hYIvK2wY
        2qzTCKruxhCc6LuJYdhpYaBvphZBg99DwYWmQyw07o+q4I+JTDD1trFwuf4GC/2ND4Lba0Uw
        2vEDhoSzn4WLtXUUhN0/YegaeQ1+rjMj8J3eCD6rBUH8+q/M6ieFwfouWrg2ukYYHhuihfjU
        YSx80X2MFdynGxih/dRlSgicXyBc8fRi4bw8zgrRyfeEsMnMCq32akb4ZczFCN7eKiR0Hf+a
        XZf5TuoL26SCHaWSfsVLW1K3t8tRVVH3ox85/jqE96FbxIhSOMI/Q9yeA9iIUjkNfxKRZnsz
        pRQxROyJCaQUfyNSfakP37P4vj3HKELLrOXoQTYpaPhbiNgi2Um8kN9AJuLjc4ZF/DLyp6uS
        SmKa/20BGa7ZkMQMv5IYI0YmiTH/BIlVxFVGxHGL+U0k4VyVpNV8Ohk4Gpobk8KvJweOd2Jl
        TBYpdxyjFZxBgiHrXGrCB1PIQPAuo5hLyVVHEnOzwsvkyuRbSv6F5JqvnVXww2TQXIMVbzki
        lQ0yqxQ1iDgsnYzStYr0+obmwtH8U+SMc4VCryEzFhtW5qeRS5F0JU8aOdxRTyu0mlRVaJTu
        pUT2ffPf2p7ARdqEtPK8K+V5l8nzLpP/39uIsB1lSCWGwnzJkKuTynIMYqGhRJefs3VXYSua
        fYjBf3xTncgz/b4X8RzS3q++L2rL06jEUsPuQi8iHK1dpPYYZyn1NnH3Hkm/a7O+pEAyeFEm
        h7UZ6rTsD/I0fL5YLO2UpCJJf0+luJQl+5BcNPX53g9PnIq0PVvlCBfzuSPLNYnFaPhxd+wr
        U6ip7vqQLf/1mXPhnmxwvRL05TzftXn9uk/XilOerYnHCl7VuVoODpqKY1SgjApo9rzRM5Cb
        3vlm2Sd727Me2rhJ18zrxGVbMp4b/W6pGFodnxS1Jx+RPs4qWks90GDe+eLYu1iLDdvFldm0
        3iD+C2T09TYMBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0xTdxTH87v39t4idrlW1F9g2ZYmaOa0ekHowQeR/262LNli1AwGrNEb
        6qQUe4vKjJFIAW1UCjUgBSwG2AaZkUGtyHitMBCtKVrEFxhUcPIo1hdGwDEomPDfJ+d8Pyc5
        yVdKys10sHRfikHQp6iTFfQS6sZ/nf3ra6Yr4jZezwkFd7+ThMHWHAQlbiMFja5JBibH2xl4
        9qCJgMzySzTkXvMiGDheTUCPw0rC2RofAd1Dp2homBkjwe2uYaDCYpPA2enfCLiQXUFBnW0a
        wYkPbxCcbx+nwNNQQkP7TC6Cc+5mAlzlpxkoM/ok8PzfEDC31TFwv3CMgY6yldDktCG447hJ
        wVRDBwO3c/MIGGq6S0FLz9fwMM+CoPPibui0lSCYGH1Mb1/D3yhsIfmROzG8p/cWyU+8zaf4
        gtZihm+6eI7m7VX3Cb77aiD/qLmN4q9a+xne9zKBHzJbGL62+iTN9/U20ryz7QTiW0r/YL4L
        iVVu1evSDMIXGp1o2KaI4yBMyUWBMmxTlJILV8VvDotQbIjeuldI3ndQ0G+I/kmpsVt9ktTW
        zw5ffnWaykAvsAkFSDG7CXf+eYU2oSVSOVuJ8EiPh5xffIq7CjIk87wcT/eaFkJehHvu9fkX
        y9ldOHMywy8EsevwcGMOMRci2eeB+OnIB3LeGCTx1JO//Sma5bDJO3cqQCpjo3HtwC1ijik2
        FL/JnvBfXcH+iP+xGBcyy3BX0SA1xwHs9zirtN7PJBuJz9c9Juf5c5x5uXiBV+EHgzbCjOTW
        Rbp1kWJdpFgXKWWIqkZBQpqoTdKKYUpRrRXTUpKUe3TaWjTbRkfHe3s9Mo3vcCJWihRLZb97
        K+LkEvVBMV3rRFhKKoJkzabZkWyvOv0XQa9L1KclC6ITRcw+l0cGr9ijm+12iiGRi+BUEMWp
        wlXhkaBYJXNvTI+Vs0lqg7BfEFIF/UePkAYEZ6BCL528syhr2MXt1Nx8d6SgylVZWZe67JNs
        49TqmJmfNz/NCtrBmbmQ2JPhETHrD+V/E0WqLw2Epnq2dQ2rRvu6hJU/aA4vxYQlIf8rh/bA
        bXt8tONYvMf3a3exter1+7zRhCLH2rdG+9hf9a3fHk087nJG9iU0PAssfVV+5suONVsUlKhR
        c2tJvaj+HxIjJ8WjAwAA
Message-Id: <20180921141409eucas1p190a47e2608429870d23516ee5e75c191~Wb8z_FmwI1466414664eucas1p1F@eucas1p1.samsung.com>
X-CMS-MailID: 20180921141409eucas1p190a47e2608429870d23516ee5e75c191
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
        <20180921081806eucas1p182d4646e8510b5f0356214af7edba11e~WXF8Ptw4M0970709707eucas1p1p@eucas1p1.samsung.com>
        <CAGfqbt7xJxGbq3oOJp9S0Sg7Z9=T6Dy52MDNWSDdsU==kPt1KQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Janusz,


On 2018-09-21 12:51, Janusz Krzysztofik wrote:
> 2018-09-21 10:18 GMT+02:00, Marek Szyprowski <m.szyprowski@samsung.com>:
>> On 2018-09-20 18:21, Janusz Krzysztofik wrote:
>>> On Thursday, September 20, 2018 5:48:22 PM CEST Janusz Krzysztofik wrote:
>>>> On Thursday, September 20, 2018 12:11:48 PM CEST Marek Szyprowski wrote:
>>>>> On 2018-09-02 14:01, Janusz Krzysztofik wrote:
>>>>>> Certain GPIO descriptor arrays returned by gpio_get_array() may
>>>>>> contain
>>>>>> information on direct mapping of array members to pins of a single
>>>>>> GPIO
>>>>>> chip in hardware order.  In such cases, bitmaps of values can be
>>>>>> passed
>>>>>> directly from/to the chip's .get/set_multiple() callbacks without
>>>>>> wasting time on iterations.
>>>>>>
>>>>>> Add respective code to gpiod_get/set_array_bitmap_complex() functions.
>>>>>> Pins not applicable for fast path are processed as before, skipping
>>>>>> over the 'fast' ones.
>>>>>>
>>>>>> Cc: Jonathan Corbet <corbet@lwn.net>
>>>>>> Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
>>>>> I've just noticed that this patch landed in today's linux-next. Sadly
>>>>> it
>>>>> breaks booting of Exynos5250-based Samsung Snow Chromebook (ARM 32bit,
>>>>> device-tree source arch/arm/boot/dts/exynos5250-snow.dts).
>>>>>
>>>>> Booting hangs after detecting MMC cards. Reverting this patch fixes the
>>>>> boot. I will try later to add some debugs and investigate it further
>>>>> what
>>>>> really happens when booting hangs.
>>>> Hi Marek,
>>>>
>>>> Thanks for reporting. Could you please try the following fix?
>>> Hi again,
>>>
>>> I realized the patch was not correct, j, not i, should be updated in
>>> second
>>> hunk. Please try the following one.
>>>
>>> Thanks,
>>> Janusz
>>>
>>> >From a919c504850f6cb40e8e81267a3a37537f7c4fd4 Mon Sep 17 00:00:00 2001
>>> From: Janusz Krzysztofik <jmkrzyszt@gmail.com>
>>> Date: Thu, 20 Sep 2018 17:37:21 +0200
>>> Subject: [PATCH] gpiolib: Fix bitmap index not updated
>>> While skipping fast path bits, bitmap index is not updated with next
>>> found zero bit position. Fix it.
>>>
>>> Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
>> This one also doesn't help. A quick compare of logs with this version and
>> a working system shows, that with your patch (and fix) there are no calls
>> to
>> gpx0-2 pin (which are a part of mmc pwrseq), what causes mmc failure. If
>> you need any more information (what kind of logs will help?), let me know.
> There is a debug message on array_info content available at the end of
> gpiod_get_array(), could you please activate it and post the message so
> we can understand better what is going on?

With debug enabled on next-20180919:
[    2.499153] pwrseq_simple mmc3_pwrseq: GPIO array info: chip=gpx0, 
size=2, get_mask=2, set_mask=2, invert_mask=2

On next-20180920 I get no this message and booting hangs.

Same with next-20180920 + your second fix from this thread.

I will try to debug this more on Monday.

> On the other hand, I've had a look your device-tree configuration and
> it looks like that specific setup won't benefit from the fast bitmap path.
> You have pin 2 at position 0 and pin 1 at position 1 of the array.
> Hence, the fast bitmap path covers only pin 1, and pin 2 is processed
> by the old path with apparently buggy code for skipping over fast pins.
>
> As a temporary workaround, you could try to revert the order of pins in
> your dts file (pin 1 at position 0, pin 2 at 1) and the mmc pwrseq code
> should work for you again by taking the original old path, not skipping
> over fast pins.  Results of such check may also help us to better
> understand and resolve the issue.

Changing the order of mmc pwrseq gpio pins fixes boot hang.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

