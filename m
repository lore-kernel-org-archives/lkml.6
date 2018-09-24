Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FORGED_MUA_MOZILLA,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6A7CC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 09:43:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5180E2086E
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 09:43:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="BjdjvdwO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5180E2086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728373AbeIXPpA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 11:45:00 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:54584 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725982AbeIXPo7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 11:44:59 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20180924094342euoutp0154a34d80780d17f8613d0d4b0e9971c5~XTMiVAOTr2119121191euoutp01O;
        Mon, 24 Sep 2018 09:43:42 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20180924094342euoutp0154a34d80780d17f8613d0d4b0e9971c5~XTMiVAOTr2119121191euoutp01O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1537782222;
        bh=726bnIJMb0wLjQreKFN5gJWwhAg/m1QD0m/DhMsrOTk=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=BjdjvdwOxMTMEfZ+Rw3RWRY7qkAoqwLT4iHKxsJ81GfH0RJReQWu3PUFyH5kdpdNo
         W2gs3W95q3vdi0y2yibnrthP8Z7lhcFggUz9WxRjy9NZzXk0FSK+qw3y6pU1n5lRPQ
         Knc2fy5/KbR8AGFhEHNDN6O58F3FeytSBC51NYzo=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20180924094341eucas1p11938ef2f0e9b2940afaf061eeb10878f~XTMhfgzon0949609496eucas1p1E;
        Mon, 24 Sep 2018 09:43:41 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id EE.FC.04806.CC1B8AB5; Mon, 24
        Sep 2018 10:43:40 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20180924094339eucas1p282f2f7cb627c183fe87da044edb90fa5~XTMgQ4GFs1339913399eucas1p2N;
        Mon, 24 Sep 2018 09:43:39 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20180924094339eusmtrp2bbf0b24381befcb603a462e828eb120f~XTMf70DTU1162911629eusmtrp2T;
        Mon, 24 Sep 2018 09:43:39 +0000 (GMT)
X-AuditID: cbfec7f5-79db79c0000012c6-4d-5ba8b1ccaece
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id FE.C1.04128.BC1B8AB5; Mon, 24
        Sep 2018 10:43:39 +0100 (BST)
Received: from [106.116.147.30] (unknown [106.116.147.30]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20180924094338eusmtip1c0e7ab75c421028ebf5e323898e1008f~XTMen-Fr-2500325003eusmtip1o;
        Mon, 24 Sep 2018 09:43:38 +0000 (GMT)
Subject: Re: [PATCH 0/2] gpiolib: Fix issues introduced by fast bitmap
 processing path
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
Date:   Mon, 24 Sep 2018 11:43:37 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
        Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180923235336.22148-1-jmkrzyszt@gmail.com>
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA01TfUwTdxje7+64u5aVHPWD38DE2G2wkUw0w+RddEYXs9yWuCzZli1j2Tzh
        Vsj40J6wuWRJBwZZw1IEN/CoFgdJkcGKqHx0fK2tlAW0VBGlImGmOJGPMQWDBccoBxv/Pe/7
        Ps/7vM8fL0tqg3Q0m5Z5RDRkCuk6Wk01dj25+krv+eqkbcWXE8F7x0lCoPM4Aov3GAWtvUEG
        glNuBu752wjIq7TTYO6eRDCSW0NAf6NMwsn6aQL6RgtpcCxOkOD11jNQVWINg5MLNgLO5ldR
        cMG6gKDg6QyCM+4pCq47LDS4F80IyrztBPRWfs9AxbHpMLj/ZwwUuS4wMFg6wUBXxUZoc1oR
        3Gi8QsG8o4uBa+YTBIy23aSgo/9tuH2iBIGn7kPwWC0IHo//Qe+J43tKO0j+wY29/PUBH8k/
        ni2m+B87yxm+ra6M5i+eGyT4vpZwfrjdRfEt8h2Gn/77U360qIThG2q+o/mhgVaad7oKEN9x
        upZ5N+Zj9a4UMT0tRzQk7D6gTm1yz9OHBmO++vZpLW1EP0SZkIrFXCK+EvwZmZCa1XLVCJtn
        8xmlmEF45uo4qRSPEB7uuUysSjqdDwllYEN4bqBzRfIXwja/HGZCLLuO+wjPjaCQYP0SrLcZ
        lzeRnCMc99+8T4cGNLcdmyZNdIhPcS/isbN7QnAD9wmed+wMMTRcJP79VIAKYRX3GvY5ZskQ
        JrnNOO9S+QqOwv6AdfkezA2rcJW5m1DEObjWXU2GdmJuHx4f2aHcvw4/8FxkFLwJL7asavMQ
        Pl4mM0pRiPAlSzOtsHZil8e3nIvkXsZ2R4LS3osHLUOEsj8C35qMVO6JwMWNpSu2GlyQr1XY
        sVj2/PKf7W9918gipJPXpJTXJJPXJJP/961AVA2KErOlDL0ovZopfrlVEjKk7Ez91uSsjAa0
        9BE9/3hmm1H7wkEn4like1bzzLAtSRsm5EhHM5wIs6RuveZN/1JLkyIc/Vo0ZH1myE4XJSeK
        YSldlCYi/vMkLacXjohfiOIh0bA6JVhVtBH1UGNDd6OnqjvCLYHx+ecNradeaohMCBjjs4Ty
        pjr9fn2t3fdTycDrW9KMYx6040lqINkePPf+aKA1yej33Yp95J5IbIp7r5vbfODwr4vNHzxX
        HnubO9/7Ts1bu3ThG1WCektu8Vzc7so3Njw8sy/Zvj/67uHcFO1B16bCF7Z9I1Xd01FSqrA9
        njRIwr+UKGFEDQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA02SbUxTVxjHPfde7r3AmtwVhCP4lmaGbWaVFrEPhhH5oifLNrf5YZsIrtM7
        MKPU9LZGliXibDZoVEAQXGUWAhNGdDjATkgL5LajMjCVCSggRgz4DmMLMCc414ImfPudc/6/
        k+dJ/jytPMbG8PtyzKIpR5+tYsOY7v98I291/1KXFu/pWQv+EZmGsY7vEFT4rQy4ep5y8HTS
        y8HdITcFR6obWCi8PIHg9jf1FPQ57TSUXpii4Or4URZanz+mwe+/wEFNiSMESudrKaj6toaB
        Jsc8gvxn0wjOeCcZuNZawYL3eSGCU/42Cnqqj3FQaZ0Kgfv3YqHI08TBYPljDjoro8AtOxD0
        O68wMNfaycEfhcUUjLuvM9De9w4MF5cg8J3/GHyOCgSzj0bZLXGku7ydJg/7U8m1gV6azM6c
        YEhZx2mOuM+fYknzT4MUudoSTm61eRjSYh/hyNRfGWS8qIQjjfUFLLk54GKJ7MlHpP2Hc9wH
        sTvVySajxSyuzTJK5rdVaRrQqjVJoNZuTFJrEnTpm7WJqg0pyXvF7H0HRNOGlM/UWb9659j9
        g7EHDz87x+ahk9E2FMpjYSPukP+mbCiMVwo/Ijwiu9jFh5W4qywvZJEj8PyAjV0MTSB8eLo0
        cOD5COET/OQ2CmYiA1hXfnThI1pwheOG8kZuUahFuMuev5BiBQ22TdgWZIWQgs96ooLICOvw
        g6otwcRyYRf+rcS6MINCeBV3fT/GBDlUSMK9rTN0kGlhEz7TNPqC1+AjF0+/4Gg8NOagipDS
        vkS3L1HsSxT7EqUSMfUoUrRIhkyDpFVLeoNkyclU7zEaGlGgis7Of5svIdvkDhkJPFK9oqgb
        rk1ThugPSLkGGWGeVkUqtg4FrhR79blfiSbjbpMlW5RklBjYrZiOWb7HGCh2jnm3JlGjgySN
        LkGXsAlU0Qp/fO5OpZCpN4tfiuJ+0fTSo/jQmDwkOvDqllWmz6dT78Rd0icfSq3KNFbvOHQ5
        LvWjn73ZGc7j68tka8b2d6Mj3l+PA9LN4fZVTvdFTmm1rpgoeG9NlIuc1b4RPhP1WvO6wV01
        6enLlsX3bm/49J8bYcaCL2Y3q2z3V37dxvYp5y3b+gue+O5dGf1wbquv7nfjn7qMrteRipGy
        9Jo3aZOk/x8pQTLVoAMAAA==
Message-Id: <20180924094339eucas1p282f2f7cb627c183fe87da044edb90fa5~XTMgQ4GFs1339913399eucas1p2N@eucas1p2.samsung.com>
X-CMS-MailID: 20180924094339eucas1p282f2f7cb627c183fe87da044edb90fa5
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20180923235237epcas3p3aa946da71a07da1bc3cd0e8cce3473b2
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180923235237epcas3p3aa946da71a07da1bc3cd0e8cce3473b2
References: <2785169.v6aIfS3K2k@z50>
        <CGME20180923235237epcas3p3aa946da71a07da1bc3cd0e8cce3473b2@epcas3p3.samsung.com>
        <20180923235336.22148-1-jmkrzyszt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Janusz,

On 2018-09-24 01:53, Janusz Krzysztofik wrote:
> While investigating possible reasons of GPIO fast bitmap processing
> related boot hang on Samsung Snow Chromebook, reported by Marek
> Szyprowski (thanks!), I've discovered one coding bug, addressed by
> PATCH 1/2 of this series, and one potential regression introduced at
> design level of the solution, hopefully fixed by PATCH 2/2.  See
> commit messages for details.
>
> Janusz Krzysztofik (2):
>        gpiolib: Fix missing updates of bitmap index
>        gpiolib: Fix array members of same chip processed separately
>
> The fixes should resolve the boot hang observed by Marek, however the
> second change excludes that particular case from fast bitmap processing
> and restores the old behaviour.

I confirm, that the above 2 patches fixes boot issue on Samsung Snow
Chromebook with next-20180920.

Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>

> Hence, it is possible still another
> issue which have had an influence on that boot hang exists in the code.
> In order to fully verify the fix, it would have to be tested on a
> platform where an array of GPIO descriptors is used which starts from
> at least two consecutive pins of one GPIO chip in hardware order,
> starting ftom 0, followed by one or more pins belonging to other
> chip(s).
>
> In order to verify if separate calls to .set() chip callback for each
> pin instead of one call to .set_multiple() is actually the reason of
> boot hang on Samsung Snow Chromebook, the affected driver -
> drivers/mmc/core/pwrseq_simple.c - would have to be temporarily
> modified for testing purposes so it calls gpiod_set_value() for each
> pin instead of gpiod_set_array_value() for all of them.  If that would
> also result in boot hang, we could be sure the issue was really the
> one addressed by the second fix.  Marek, could you please try to
> perform such test?

Yes, I've just tested next-20180920 only with the first patch from this
patchset and the mentioned change to drivers/mmc/core/pwrseq_simple.c.
It boots fine, so indeed the issue is in handling of arrays of gpios.

Just to be sure I did it right, this is my change to the mentioned file:

diff --git a/drivers/mmc/core/pwrseq_simple.c 
b/drivers/mmc/core/pwrseq_simple.c
index 7f882a2bb872..9397dc1f2e38 100644
--- a/drivers/mmc/core/pwrseq_simple.c
+++ b/drivers/mmc/core/pwrseq_simple.c
@@ -38,16 +38,11 @@ static void mmc_pwrseq_simple_set_gpios_value(struct 
mmc_pwrseq_simple *pwrseq,
                                               int value)
  {
         struct gpio_descs *reset_gpios = pwrseq->reset_gpios;
+       int i;

-       if (!IS_ERR(reset_gpios)) {
-               DECLARE_BITMAP(values, BITS_PER_TYPE(value));
-               int nvalues = reset_gpios->ndescs;
-
-               values[0] = value;
-
-               gpiod_set_array_value_cansleep(nvalues, reset_gpios->desc,
-                                              reset_gpios->info, values);
-       }
+       if (!IS_ERR(reset_gpios))
+               for (i = 0; i < reset_gpios->ndescs; i++)
+ gpiod_set_value_cansleep(reset_gpios->desc[i], value);
  }

  static void mmc_pwrseq_simple_pre_power_on(struct mmc_host *host)


Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

