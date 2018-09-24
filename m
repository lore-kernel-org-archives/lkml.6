Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FORGED_MUA_MOZILLA,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72ECFC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 11:39:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 166DA214AB
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 11:39:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="oo5JtESV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 166DA214AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729211AbeIXRkp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 13:40:45 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:40535 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726269AbeIXRkn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 13:40:43 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20180924113901euoutp01a33620a7ef39e597ab53a8a8eae6f36b~XUxOkHOkv1855318553euoutp01m;
        Mon, 24 Sep 2018 11:39:01 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20180924113901euoutp01a33620a7ef39e597ab53a8a8eae6f36b~XUxOkHOkv1855318553euoutp01m
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1537789141;
        bh=otrGG1Yb+cMvuXNARd4n1SIpqJgyUU3FRQ50b11u2Vc=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=oo5JtESVLlA1oGTztu//fjt2FatnJRJHhZWGh1VxNIjS6Ax6Uil8nlAjDOcw2w6Rw
         WQcurTrHtTYJsJapl7eMcwSDfHOQNEVF4sdYcB3AMg8ppChgOmqp/3Jc0kselmFHIl
         UI68RsUaHiDMY5dU6X8Hq3qzvZst0lDwiBi3fFeA=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20180924113901eucas1p14d79380b2152fa59250925d9a62892cd~XUxOGP-Fn3141231412eucas1p1Z;
        Mon, 24 Sep 2018 11:39:01 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 53.CC.04806.4DCC8AB5; Mon, 24
        Sep 2018 12:39:00 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20180924113859eucas1p160322f5844c771bc9c680d35de4877a3~XUxM0smXV0334103341eucas1p1s;
        Mon, 24 Sep 2018 11:38:59 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20180924113859eusmtrp200e35534f75dbbab7ffa284d076246f5~XUxMgMtDJ0893608936eusmtrp2N;
        Mon, 24 Sep 2018 11:38:59 +0000 (GMT)
X-AuditID: cbfec7f5-367ff700000012c6-b3-5ba8ccd47c7c
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 72.C1.04128.3DCC8AB5; Mon, 24
        Sep 2018 12:38:59 +0100 (BST)
Received: from [106.116.147.30] (unknown [106.116.147.30]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20180924113857eusmtip14349e9b8ccff189b9f6353135e0ef6fb~XUxLJLmWa2124321243eusmtip17;
        Mon, 24 Sep 2018 11:38:57 +0000 (GMT)
Subject: Re: [PATCH 0/2] gpiolib: Fix issues introduced by fast bitmap
 processing path
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
        Sebastien Bourdelin <sebastien.bourdelin@savoirfairelinux.com>,
        Lukas Wunner <lukas@wunner.de>,
        Rojhalat Ibrahim <imr@rtschenk.de>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Tony Lindgren <tony@atomide.com>,
        Yegor Yefremov <yegorslists@googlemail.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        linux-doc@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-mmc@vger.kernel.org, netdev@vger.kernel.org,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-serial@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Linux Samsung SOC <linux-samsung-soc@vger.kernel.org>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Date:   Mon, 24 Sep 2018 13:38:57 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
        Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAGfqbt6H8u_dUokB-pg51kCj09G8Mh7wB0879nKMw5Dw83tcSg@mail.gmail.com>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA01TbUxTVxjeuff0nltYybXoOJFlJk22qXM4s2V5F9RIMre77Y/LfmyRxa3a
        OzADJK3g3I/FiANWcYCQAXfVQiRWqs5KsZMKrRRCGR8rIDg+CsOkOAfiwA+ilY9Zrm78e97n
        fZ/3eZ+THJ7VhrnV/N6M/ZIxQ5+m46Kwq/VR4PW+zjPJb3jKEyAw4mMhdDUPgSVwBENDZ5hA
        +E4LgZtDjQzknLrAQWHbFIKxw3YG+lwyC6WOaQa6xws4cC/eZiEQcBCoLrGqoHTOxkBVbjUG
        p3UOQf78fQQnW+5guOa2cNCyWIigPOBhoPPUMQKVR6ZVcOuveChqdhIYLLtNoLXyBWj0WRH0
        u7owPHa3EugtLGZgvPEPDN6+D2G4uASB//yn4LdaEMxO3uC2vSp2lHlZcaI/Sbx2vYcVZx8c
        x+JPV38mYuP5ck6sqxlkxO76aHHU04zFenmEiNMzu8TxohIi1tp/4MTg9QZO9DXnI9F74hzZ
        Eb8zarNBStubLRk3bv0yKrXaGySZd9d8c9pzlxxCA9SM1DwV3qKD48OcGUXxWuEMoj8WdmKl
        uI/ojcliRinuIdpU0UHMiFckQ28rvA3RqomOp/J/EHW2n2MjQ7HCZ/ThGIpYrBQ20L8b8pYW
        sUIomob7Ty41OGETNU+ZuQjGwst0wF6limhXCZ/Tx+7ECK0RVtDfKkI4gtXCx7TUUUMimBXW
        0F+nLKyC4+hQyLq0nwqjatrWfgVH9miEbCrbVErMd2lXZR2n4Fg64a8jCn6RLtY/0+Ygmlcu
        E6UoQPSS5fJTRSJt9vcsHccK6+gF90aFTqKDliCjPEoMHZhaodwTQ4+7yliF1tD8XK0y/QqV
        /b/8Z9vU3csWIZ28LKW8LJm8LJn8v28lwnYUJ2WZ0lMk05sZ0oEEkz7dlJWRkrBnX3otevIj
        Ohb8Dy4jz9xuHxJ4pHte89yoLVmr0mebDqb7EOVZ3UrNe0NPKI1Bf/BbybjvC2NWmmTyoXge
        6+I0Meu/StYKKfr90teSlCkZn3UZXr36EHLuvrmHxC60hi6t0n406W1K8WFuWz8mp4c3bJkP
        x2yvK9hyK3jRHlATw8i6xMA7m2tnHGd3VqfNRttKgjnzpcaZYMO97UmO4kz7w9TvP3ntz5ds
        Pf7DRba56azeDxYqunJznc42Cy4b2bpj/vexA97v0PuuR2sNJ446mHaD5kqNDptS9ZvWs0aT
        /l+KuGPKDQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA02SfUwTdxjH/d1d7w60ya2g/oJLME2MyaaFgsDD4lCzjJwm0+n+mBEUq5yA
        0lZ7xQyiCUN8WacWLEMslWJEhSqRCKIgb5Y3CZiiKAIVhwx0KjRAphNEWUtdwn+fPPl+nidP
        8mVJ2Sk6gE3S6AWdRpUsp32p9k+t/Su7OopjgvuPyMDRbydhqOE4Aosjk4KajikGplxNDLzo
        qyXgyMXrNBjvjSIYyLAR8KjSTEJO2RgBncMnaaieGSHB4ShjoMhklUDO9BUCLhwroqDcOo3g
        xMd/EBQ0uSjoqrbQ0DRjRJDnqCOg4+IpBgozxyTw98slkNVYzkDv2REGWgoXQa3diuBx5X0K
        PlS3MPDQmE3AcO0TCuofbQBntglBa+nP0Gq1IHj35jm9djnffrae5F8/Xsd3dT8g+Xdvz1B8
        bkM+w9eW5tF8RUkvwXdWzeef1TVSfJW5n+HHxnfww1kmhr9h+43mn3bX0Ly98QTi689fY35c
        sk2xWqdN0QtLE7Wi/lt5jBJCFMpIUISsilQoQyO2fxMSJg+KWh0vJCcdFHRBUTsViUX1T5n9
        E4G/XK6bYNJRDzYglsXcKtzbF25AvqyMu4Rwt/MOZUA+7vmXuC03XeJlPzzdbaC9oVGE8wsG
        CY/sx23F7weQJ+PPrcCvao4THia5F/Nx1c193ryTwH+enppdSnNKbBj1LPJhpVwULrn0B+Nh
        iluGe2wXZo8t5GJxsynzc+YL3HZuaNb14TbjnLISxnsgHBeUPye9HIhvjVo+82LcN2QlspDM
        PEc3z1HMcxTzHKUQUTbkL6SI6gS1GKIQVWoxRZOg2K1V30DuKla2TFbcRgbXT3bEsUi+QFrs
        vBIjk6gOiqlqO8IsKfeXRve5R9J4VWqaoNPG6VKSBdGOwtzPZZMBC3dr3cXW6OOUYcoIiFRG
        hEaEhoN8sdQRnLpNxiWo9MI+Qdgv6P73CNYnIB1xE+sqoqdzP42ssXBk0d4Zl+tl1kbtG40r
        rdTFdgbammPYwcgPddeazujm/VWM9Y6j/xp/kMR/f+7X7xY4JzNcd8bze8N840p3rk/zE42x
        gw2Ta6Jjm7sOmYYqDgQ1tEuX77l7OOPu15u2yAaCJ4WrPQ9/30XfSxLT22JPzptYtnlcTomJ
        KuVXpE5U/QfICFIXoAMAAA==
Message-Id: <20180924113859eucas1p160322f5844c771bc9c680d35de4877a3~XUxM0smXV0334103341eucas1p1s@eucas1p1.samsung.com>
X-CMS-MailID: 20180924113859eucas1p160322f5844c771bc9c680d35de4877a3
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20180923235237epcas3p3aa946da71a07da1bc3cd0e8cce3473b2
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180923235237epcas3p3aa946da71a07da1bc3cd0e8cce3473b2
References: <2785169.v6aIfS3K2k@z50>
        <CGME20180923235237epcas3p3aa946da71a07da1bc3cd0e8cce3473b2@epcas3p3.samsung.com>
        <20180923235336.22148-1-jmkrzyszt@gmail.com>
        <20180924094339eucas1p282f2f7cb627c183fe87da044edb90fa5~XTMgQ4GFs1339913399eucas1p2N@eucas1p2.samsung.com>
        <CAGfqbt6H8u_dUokB-pg51kCj09G8Mh7wB0879nKMw5Dw83tcSg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Janusz,

On 2018-09-24 13:08, Janusz Krzysztofik wrote:
> 2018-09-24 11:43 GMT+02:00, Marek Szyprowski <m.szyprowski@samsung.com>:
>> On 2018-09-24 01:53, Janusz Krzysztofik wrote:
>>> While investigating possible reasons of GPIO fast bitmap processing
>>> related boot hang on Samsung Snow Chromebook, reported by Marek
>>> Szyprowski (thanks!), I've discovered one coding bug, addressed by
>>> PATCH 1/2 of this series, and one potential regression introduced at
>>> design level of the solution, hopefully fixed by PATCH 2/2.  See
>>> commit messages for details.
>>>
>>> Janusz Krzysztofik (2):
>>>         gpiolib: Fix missing updates of bitmap index
>>>         gpiolib: Fix array members of same chip processed separately
>>>
>>> The fixes should resolve the boot hang observed by Marek, however the
>>> second change excludes that particular case from fast bitmap processing
>>> and restores the old behaviour.
>> I confirm, that the above 2 patches fixes boot issue on Samsung Snow
>> Chromebook with next-20180920.
>>
>> Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
>>
>>> Hence, it is possible still another
>>> issue which have had an influence on that boot hang exists in the code.
>>> In order to fully verify the fix, it would have to be tested on a
>>> platform where an array of GPIO descriptors is used which starts from
>>> at least two consecutive pins of one GPIO chip in hardware order,
>>> starting ftom 0, followed by one or more pins belonging to other
>>> chip(s).
>>>
>>> In order to verify if separate calls to .set() chip callback for each
>>> pin instead of one call to .set_multiple() is actually the reason of
>>> boot hang on Samsung Snow Chromebook, the affected driver -
>>> drivers/mmc/core/pwrseq_simple.c - would have to be temporarily
>>> modified for testing purposes so it calls gpiod_set_value() for each
>>> pin instead of gpiod_set_array_value() for all of them.  If that would
>>> also result in boot hang, we could be sure the issue was really the
>>> one addressed by the second fix.  Marek, could you please try to
>>> perform such test?
>> Yes, I've just tested next-20180920 only with the first patch from this
>> patchset and the mentioned change to drivers/mmc/core/pwrseq_simple.c.
>> It boots fine, so indeed the issue is in handling of arrays of gpios.
>>
>> Just to be sure I did it right, this is my change to the mentioned file:
> Yeah, that's what I had on mind.  However, I'd be more lucky if it didn't work
> for you.  Setting the pins sequentially, not simultaneously as before, was
> exactly what I hoped was the reason of the hang.
>
>> diff --git a/drivers/mmc/core/pwrseq_simple.c
>> b/drivers/mmc/core/pwrseq_simple.c
>> index 7f882a2bb872..9397dc1f2e38 100644
>> --- a/drivers/mmc/core/pwrseq_simple.c
>> +++ b/drivers/mmc/core/pwrseq_simple.c
>> @@ -38,16 +38,11 @@ static void mmc_pwrseq_simple_set_gpios_value(struct
>> mmc_pwrseq_simple *pwrseq,
>>                                                 int value)
>>    {
>>           struct gpio_descs *reset_gpios = pwrseq->reset_gpios;
>> +       int i;
>>
>> -       if (!IS_ERR(reset_gpios)) {
>> -               DECLARE_BITMAP(values, BITS_PER_TYPE(value));
>> -               int nvalues = reset_gpios->ndescs;
>> -
>> -               values[0] = value;
>> -
>> -               gpiod_set_array_value_cansleep(nvalues, reset_gpios->desc,
>> -                                              reset_gpios->info, values);
>> -       }
>> +       if (!IS_ERR(reset_gpios))
>> +               for (i = 0; i < reset_gpios->ndescs; i++)
> The only difference from the behaviour when the hang was occurring is now
> the order the pins are manipulated.  Maybe that matters?
> Could you please retry the same with the order of pins reversed, either in
> the .dts file or here inside this for loop?

I've switched the order of pins in dts and next-20180920 + first patch + 
above
change also boots fine.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

