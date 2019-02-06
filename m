Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D10BAC169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 09:47:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9322F20844
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 09:47:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="tQ66QJOr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728853AbfBFJrG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 04:47:06 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:24629 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726715AbfBFJrG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 04:47:06 -0500
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20190206094701epoutp031b2a5706307254e8ffaa85bb18733e8b~AvU_xXji92635626356epoutp03B;
        Wed,  6 Feb 2019 09:47:01 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20190206094701epoutp031b2a5706307254e8ffaa85bb18733e8b~AvU_xXji92635626356epoutp03B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1549446421;
        bh=I9M8zpgyUcg49ZjMGfwICWUPbbLGEdFGxZxHF68vLaw=;
        h=Subject:To:Cc:From:Date:In-reply-to:References:From;
        b=tQ66QJOro5ZMBA2834JMF6EQYgkRxJ8QjPseckv21RJAAbRyjZBtzO2IklcbS47Ls
         2m1FTMskMPylWjUG8FZabRLoMew3jNsI9bCZ6Go8KolR8i190iZooSbv380wqLVcHe
         f0EIpWyDOaJwkoGBrQKPny5yToQAIfsA9jfn2q9k=
Received: from epsmges2p3.samsung.com (unknown [182.195.42.71]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTP id
        20190206094700epcas2p304f0e187df7b420192460ea7cbd4c356~AvU9rW_Y21526915269epcas2p3q;
        Wed,  6 Feb 2019 09:47:00 +0000 (GMT)
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
        epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        70.28.04134.41DAA5C5; Wed,  6 Feb 2019 18:47:00 +0900 (KST)
Received: from epsmgms2p2new.samsung.com (unknown [182.195.42.143]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTP id
        20190206094700epcas2p27287a46402e9eb44fabd528a217557d6~AvU9SC6fw0529205292epcas2p2X;
        Wed,  6 Feb 2019 09:47:00 +0000 (GMT)
X-AuditID: b6c32a47-8abff70000001026-b1-5c5aad14b73f
Received: from epmmp2 ( [203.254.227.17]) by epsmgms2p2new.samsung.com
        (Symantec Messaging Gateway) with SMTP id B7.09.03689.41DAA5C5; Wed,  6 Feb
        2019 18:47:00 +0900 (KST)
Received: from [106.116.147.40] by mmp2.samsung.com (Oracle Communications
        Messaging Server 7.0.5.31.0 64bit (built May  5 2014)) with ESMTPA id
        <0PMI00IWG0I70PA0@mmp2.samsung.com>; Wed, 06 Feb 2019 18:47:00 +0900 (KST)
Subject: Re: [BUG BISECT] NULL pointer after commit
 "ASoC: dapm: Only power up active channels from a DAI"
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Cc:     linux-samsung-soc@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        ckeepax@opensource.cirrus.com
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
Message-id: <844c3f34-f7db-6b26-169a-994922367c78@samsung.com>
Date:   Wed, 06 Feb 2019 10:46:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.4.0
MIME-version: 1.0
In-reply-to: <20190205211622.GA5891@kozik-lap>
Content-type: text/plain; charset="utf-8"
Content-language: en-GB
Content-transfer-encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprBKsWRmVeSWpSXmKPExsWy7bCmha7I2qgYgy/zFSyuXDzEZDH14RM2
        iyutmxgtzp/fwG7x7UoHk8XlXXPYLGac38dksfbIXXaLzl39rBYbvq9ldODy2PC5ic1j56y7
        7B6bVnWyeUyf85/RY9/bZWwefVtWMXqs33KVxePzJrkAjigum5TUnMyy1CJ9uwSujP2PjzEX
        NPJU9N28wdTA+JCzi5GTQ0LAROLDo/OsXYxcHEICOxgl5t7fyQaSEBL4zihxZVIUTFHD/GXs
        EEUbGCXmNV5ggii6zyhx5KIfiC0skCNxfMoFFpAiEYGPjBKTmo8xgiSYBYolph/6DtbAJmAo
        0Xu0DyjOwcErYCfxtp0ZJMwioCrx4t9idhBbVCBC4nDvO7BWXgFBiR+T77GA2JwCehIrb81k
        gxipKfHiyyQWCFtc4tj9m1Cr5CU2r3nLDHKDhMB/NonVL/ewQ3zgInG+7xYbhC0t8WzVRkYI
        u1pi1/ZuqIYORomWC9uZIRLWEoePX2SFmMon0XH4LzvI0RICvBIdbUIQJR4SfYvbWCAB0cgo
        sXmr5QRGmVlI7p6F5NZZSG6dheTWBYwsqxjFUguKc9NTi40KjPWKE3OLS/PS9ZLzczcxgtOL
        lvsOxm3nfA4xCnAwKvHwanRHxgixJpYVV+YeYpTgYFYS4TWfERUjxJuSWFmVWpQfX1Sak1p8
        iFGag0VJnPeh9NxoIYH0xJLU7NTUgtQimCwTB6dUA2NGwzy/H0Z637fxPn1RMpel69WxxNJ5
        +2YedElfMfvsgnkVkjLftI/P3Nv/+M7MloR5Pj4Xz4RIbBTprhObaXTbSMP32OaUnRlxrsuU
        BSbujDtTFvZly+wa750tGgw5L9YoPjry3SHn2jILqdpcTwO3qHct0+9GXBRx65u8m2/O77Zi
        J84LN6crsRRnJBpqMRcVJwIA0qM6ISsDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupgkeLIzCtJLcpLzFFi42I5/e+xoK7I2qgYgy+rOS2uXDzEZDH14RM2
        iyutmxgtzp/fwG7x7UoHk8XlXXPYLGac38dksfbIXXaLzl39rBYbvq9ldODy2PC5ic1j56y7
        7B6bVnWyeUyf85/RY9/bZWwefVtWMXqs33KVxePzJrkAjigum5TUnMyy1CJ9uwSujP2PjzEX
        NPJU9N28wdTA+JCzi5GTQ0LARKJh/jL2LkYuDiGBdYwS61oeQDkPGSX+r73ODlIlLJAjcXzK
        BRaQhIjAR0aJWc/3AyU4OJgFiiX6notCNDQzSjS33GQGaWATMJToPdrHCFLDK2An8bYdLMwi
        oCrx4t9isJmiAhESH5/uYwKxeQUEJX5MvscCYnMK6EmsvDWTDWK8usSUKbkgYWYBcYlj928y
        QtjyEpvXvGWewCgwC0n3LISOWUg6ZiHpWMDIsopRMrWgODc9t9iowCgvtVyvODG3uDQvXS85
        P3cTIzB+th3W6t/B+HhJ/CFGAQ5GJR5eje7IGCHWxLLiytxDjBIczEoivOYzomKEeFMSK6tS
        i/Lji0pzUosPMUpzsCiJ8/LnH4sUEkhPLEnNTk0tSC2CyTJxcEo1MOot8paPZ/p8615fgaz4
        k68MC6R+V4ben5ycrLRnR+NJfeEZkxtSn3ayTjsccaev96zzzPNOn8/1WR0WXdm27e3cl8de
        M6680DHD8uBaH/GNv7fJ/4moF572uY7zlfjzW94ito9DxKZ3/m7dtlr0gcu2rK9WF25bn6lx
        OnNjOXO2Xthh2xO3g/iUWIozEg21mIuKEwFc50TYmwIAAA==
X-CMS-MailID: 20190206094700epcas2p27287a46402e9eb44fabd528a217557d6
CMS-TYPE: 102P
X-CMS-RootMailID: 20190205211638epcas3p409823d4acac8073473153d745151ea5f
References: <CGME20190205211638epcas3p409823d4acac8073473153d745151ea5f@epcas3p4.samsung.com>
        <20190205211622.GA5891@kozik-lap>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

Cc: Charles

On 2/5/19 22:16, Krzysztof Kozlowski wrote:
> Bisect pointed to commit:
>     commit 078a85f2806f0ffd11289009462a6a390f9adb5c
>     Author: Charles Keepax <ckeepax@opensource.cirrus.com>
>     Date:   Thu Jan 31 13:30:18 2019 +0000
>         ASoC: dapm: Only power up active channels from a DAI
> 
> as a bad commit for NULL pointer on my Odroid XU3 and Odroid U3 board when
> doing "aplay /usr/share/sounds/alsa/Front_Right.wav".
> 
> 1. Arch ARM Linux
> 2. exynos_defconfig
> 3. Odroid U3, XU3, Exynos SoC, ARMv7
> 
> Last address is in calltrace:
> c079552c
> dapm_update_dai_unlocked
> sound/soc/soc-dapm.c:2586

Thanks for bisecting this, I ran into same issue last night and I'm starting
to debug this now. I have added some debug prints and it looks like it oopses
on NULL playback_widget of the dummy DAI.

[   30.701182] hdmi-audio-codec hdmi-audio-codec.0.auto: Update DAI routes for i2s-hifi playback
[   30.709630] dapm_update_dai_unlocked:2586 w=8bd27d28
[   30.714403] dapm_update_dai_unlocked:2594 w=8bd27d28
[   30.724688] max98090 5-0010: Update DAI routes for HiFi playback
[   30.730163] dapm_update_dai_unlocked:2586 w=3fc942af
[   30.735154] dapm_update_dai_unlocked:2594 w=3fc942af
[   30.745051] snd-soc-dummy snd-soc-dummy: Update DAI routes for snd-soc-dummy-dai playback
[   30.753128] dapm_update_dai_unlocked:2586 w=  (null)
[   30.758114] Unable to handle kernel NULL pointer dereference at virtual address 0000007c

-- 
Regards,
Sylwester
