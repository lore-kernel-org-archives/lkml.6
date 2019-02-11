Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77553C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:59:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1ECC1218D8
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:59:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="uQrCTy8r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728927AbfBKP7P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 10:59:15 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:63757 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730452AbfBKOcV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:32:21 -0500
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20190211143218epoutp02d1adb177a00b3f745a8f7f9ecb712f0a~CVcfDKrK32356823568epoutp02X;
        Mon, 11 Feb 2019 14:32:18 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20190211143218epoutp02d1adb177a00b3f745a8f7f9ecb712f0a~CVcfDKrK32356823568epoutp02X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1549895538;
        bh=i7L/uh6XAH2XKxhFeYWD39pphmL0qGBrQppwYLOGdeU=;
        h=Subject:To:Cc:From:Date:In-reply-to:References:From;
        b=uQrCTy8rwa6KXPFhGk6dhcvu/YaGwRoZhlE1gBYHsYAKKCt8Py7kN0reQvBslejnd
         ikb7j0UE1Sw5IW20tSkhcI798OMMBc2PP3aFWl1jkdWMQWqhSPH4f1CFG8i29D8ytU
         M5Z6c0MMSnYDZ6AcATmSVHqOThqDa0ccc35TXAzY=
Received: from epsmges1p5.samsung.com (unknown [182.195.42.57]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20190211143217epcas1p4b35bb7a7d9ca2b8ebe44681c44c3d872~CVcesaXN_1388213882epcas1p40;
        Mon, 11 Feb 2019 14:32:17 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        88.F5.04206.177816C5; Mon, 11 Feb 2019 23:32:17 +0900 (KST)
Received: from epsmgms2p1new.samsung.com (unknown [182.195.42.142]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20190211143217epcas1p3197d88d332630c27a6f1e7b3ae2eea8d~CVceZYFy01381513815epcas1p3L;
        Mon, 11 Feb 2019 14:32:17 +0000 (GMT)
X-AuditID: b6c32a39-d7dff7000000106e-ad-5c618771a9ca
Received: from epmmp1.local.host ( [203.254.227.16]) by
        epsmgms2p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        29.C2.04015.177816C5; Mon, 11 Feb 2019 23:32:17 +0900 (KST)
Received: from [106.116.147.40] by mmp1.samsung.com (Oracle Communications
        Messaging Server 7.0.5.31.0 64bit (built May  5 2014)) with ESMTPA id
        <0PMR00AY0N1PUG90@mmp1.samsung.com>; Mon, 11 Feb 2019 23:32:17 +0900 (KST)
Subject: Re: [PATCH 04/22] ASoC: samsung: i2s: Fix prescaler setting for the
 secondary DAI
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     broonie@kernel.org, lgirdwood@gmail.com, sbkim73@samsung.com,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        =?UTF-8?Q?Bart=c5=82omiej_=c5=bbo=c5=82nierkiewicz?= 
        <b.zolnierkie@samsung.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
Message-id: <62ea88ed-6916-f7a5-6806-6b9c5ba08f13@samsung.com>
Date:   Mon, 11 Feb 2019 15:32:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.4.0
MIME-version: 1.0
In-reply-to: <CAJKOXPdar1q8oz4KHEVoQ6_NbD+hUYfFE3u97VLGUV7azEnZwA@mail.gmail.com>
Content-type: text/plain; charset="utf-8"
Content-language: en-GB
Content-transfer-encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmplleLIzCtJLcpLzFFi42LZdlhTV7ewPTHGoOWwgcWVi4eYLDbOWM9q
        MfXhEzaL8+c3sFt8u9LBZHF51xw2ixnn9zFZrD1yl93i4oovTA6cHhs+N7F57Jx1l91j06pO
        No++LasYPT5vkgtgjeKySUnNySxLLdK3S+DKmLlkCWtBP0vFi+UtrA2MC5m7GDk5JARMJI52
        7QGyuTiEBHYwSsw9cJ8VJCEk8J1R4vnfCpiin99fsEEU7WaUuLbqCCNE0X1GiY7HdiC2sECM
        xOqv59hBbBEBTYnrf7+zgjQwC5xhkrjRcwmsgU3AUKL3aB+YzStgJ7GsexHYGSwCqhJXd19n
        A7FFBSIkDve+g6oRlPgx+R4LiM0pECwxu2ExWD0z0IIXXyaxQNjiEsfu32SEsOUlNq95C/aO
        hMBjNom5L26wQrzgIrFi+jMgmwPIlpa4dNQWIlwtsWt7N1R9B6NEy4Xt0HCxljh8/CIrxFA+
        iXdfe6B6eSU62oQgSjwklrauZYWESguTxIMvk9kmMMrMQnL3LCS3zkJy6ywkty5gZFnFKJZa
        UJybnlpsWGCqV5yYW1yal66XnJ+7iRGcOLQsdzAeO+dziFGAg1GJh1chNzFGiDWxrLgy9xCj
        BAezkgivQxtQiDclsbIqtSg/vqg0J7X4EKM0B4uSOO96B+cYIYH0xJLU7NTUgtQimCwTB6dU
        A+MstSje7Q9rn/1a38nr4tJ2tPut9InFm/4XPuOdbMv15cs0tu6ds/eqvMyS1+X8fvz2FTbX
        2Mhld9L/neq/Ff/a8t2ec3uTd1/vXeiRpVp97fi2JTttLrCXSTlfvB8YXci51+ni72gmE9dv
        QjM7768JzdVNmCiUa2M24fv7hy8Y3C8s37rTTnG6EktxRqKhFnNRcSIAOhlQaRgDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrGLMWRmVeSWpSXmKPExsVy+t9jAd3C9sQYgxP/ZSyuXDzEZLFxxnpW
        i6kPn7BZnD+/gd3i25UOJovLu+awWcw4v4/JYu2Ru+wWF1d8YXLg9NjwuYnNY+esu+wem1Z1
        snn0bVnF6PF5k1wAaxSXTUpqTmZZapG+XQJXxswlS1gL+lkqXixvYW1gXMjcxcjJISFgIvHz
        +wu2LkYuDiGBnYwSuxedYIJwHjJKvJw9kxWkSlggRmL113PsILaIgKbE9b/fWUGKmAXOMEm8
        WvOcHaKjjUni9ekeFpAqNgFDid6jfYwgNq+AncSy7kVg+1gEVCWu7r7OBmKLCkRIfHy6jwmi
        RlDix+R7YL2cAsES7Rd+AcU5gDaoS0yZkgsSZhYQlzh2/yYjhC0vsXnNW+YJjAKzkHTPQuiY
        haRjFpKOBYwsqxglUwuKc9Nzi40KDPNSy/WKE3OLS/PS9ZLzczcxAmNj22Gtvh2M95fEH2IU
        4GBU4uFVyE2MEWJNLCuuzD3EKMHBrCTC69AGFOJNSaysSi3Kjy8qzUktPsQozcGiJM57O+9Y
        pJBAemJJanZqakFqEUyWiYNTqoHRTvHyhJrW23v/FZuvS+h6pBLZ15Z+5dilhcLfP6UU3hZ9
        YbPp1D6OG8V/5b2mH7/4vO5N6XlFMTaXSm3J2uMTfb7J8u20d2P89jX2xPMN56c2/5q47Vqw
        EGdzUHPIg6rPp5Pn2t8pf/7Ax7/xu5bzjN7zRRnhnn9Kdk9R6tsku/TZ3ENRUku+KrEUZyQa
        ajEXFScCANxBUROJAgAA
X-CMS-MailID: 20190211143217epcas1p3197d88d332630c27a6f1e7b3ae2eea8d
CMS-TYPE: 101P
X-CMS-RootMailID: 20190207170058epcas1p4e2fadf4aae2ece3c47c0750a094a4fbb
References: <CGME20190207170058epcas1p4e2fadf4aae2ece3c47c0750a094a4fbb@epcas1p4.samsung.com>
        <20190207170028.720-1-s.nawrocki@samsung.com>
        <20190207170028.720-5-s.nawrocki@samsung.com>
        <CAJKOXPdar1q8oz4KHEVoQ6_NbD+hUYfFE3u97VLGUV7azEnZwA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/11/19 14:37, Krzysztof Kozlowski wrote:
>> @@ -784,6 +787,9 @@ static int i2s_hw_params(struct snd_pcm_substream *substream,
>>         i2s->frmclk = params_rate(params);
>>
>>         rclksrc = i2s->clk_table[CLK_I2S_RCLK_SRC];
>> +       if (!rclksrc || IS_ERR(rclksrc))

> IS_ERR_OR_NULL

Thanks for your review! That line will be removed by subsequent patch
(7/22) so I'd say such a change wouldn't make a difference anyway.
Besides not using IS_ERR_OR_NULL() was intentional.


-- 
Thanks,
Sylwester
