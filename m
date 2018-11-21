Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07312C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 12:24:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C134F2147D
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 12:24:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="F81vdJTP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C134F2147D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730328AbeKUW6T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 17:58:19 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:44234 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728428AbeKUW6S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 17:58:18 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20181121122406euoutp01e8f67250edbb6a6d409160babb362806~pIzJwiibP2545825458euoutp01b
        for <linux-kernel@vger.kernel.org>; Wed, 21 Nov 2018 12:24:06 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20181121122406euoutp01e8f67250edbb6a6d409160babb362806~pIzJwiibP2545825458euoutp01b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1542803046;
        bh=SyiWUoKRoNBRVExW/Erzk13waQtiTyavdHFg2frYbWY=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=F81vdJTPETxOLrXP0FGgH6sp42i5hrDJ8upFmMLz6dJVqb9PMVKKvLr2Eixd3P5Gm
         LwXsYPVcVMkWF2lmhjMzfC6+Byrx5WfOlE2/J8yqCF5vfv9GVYuP5XKLXKPbHUyWoQ
         E+Ovhiacyyv9xoR58t6ZaTHAEZNAA8WyJlkw7Sr0=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20181121122406eucas1p2ed236d7067e0c719106b3b7e89ab8d8e~pIzJKeDW50693506935eucas1p2z;
        Wed, 21 Nov 2018 12:24:06 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 78.DF.04294.56E45FB5; Wed, 21
        Nov 2018 12:24:05 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20181121122405eucas1p2a30394f5a0ca105ca63bde5c262de4f8~pIzIQvEgi0501205012eucas1p23;
        Wed, 21 Nov 2018 12:24:05 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20181121122405eusmtrp1d8b5353cc414cf9fd6f86f246119d2b2~pIzIB5jwn1853718537eusmtrp1Q;
        Wed, 21 Nov 2018 12:24:05 +0000 (GMT)
X-AuditID: cbfec7f4-84fff700000010c6-90-5bf54e658d9d
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 35.51.04284.46E45FB5; Wed, 21
        Nov 2018 12:24:04 +0000 (GMT)
Received: from [106.116.147.30] (unknown [106.116.147.30]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20181121122404eusmtip29ec21fc84c42dc7541f0bbbba5b210ab~pIzHnWBBY1970519705eusmtip2L;
        Wed, 21 Nov 2018 12:24:04 +0000 (GMT)
Subject: Re: [PATCH] regulator: wm8994: Don't use devres for enable GPIOs
To:     Mark Brown <broonie@kernel.org>
Cc:     Charles Keepax <ckeepax@opensource.cirrus.com>,
        linus.walleij@linaro.org, lgirdwood@gmail.com,
        linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <d9aebaa5-93d0-6b3d-c3b2-f7ef1dbbc4de@samsung.com>
Date:   Wed, 21 Nov 2018 13:24:04 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
        Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <20181121121907.GB8059@sirena.org.uk>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA01SbUhTYRj13b27u44mr5vlg2nF+rACNU1j4VdFwUJK69+alatdnKVTNnVq
        EVJqOixKDW0MjYqW68Oaa5qloplD/JH5hUlSwuyHNUTUQlozt6vlv/Occx7Oc+ChCeEjbhCd
        oc5lNGpFppjik7bexQ9hzPEF+Z7qXonkzqSDkgyXWpDk53A5R1LjMnEkQ21GSjI308k9QElf
        GyZ4Uou5gpJ+Hn1LSWuNS0g6Z9mUwj3Fj1MymRn5jCYiIY2vKq4wc3JquAXfy2a5xchI6pEv
        DTgaOppquHrEp4X4MQKb+5lXEOJ5BCVVMlaYQ9BnHuGsbrgfukhWMCGoe3CTYocZBCMDjV6X
        CB+FMVsX8uAAvBVGfrV7Nwh8H8FSsYnnESgcCXqnnvJgAU6A2t9WbzaJt0P1yx4vXo9Tobdx
        DLEef+i761jmadoXR8HU+3gPTeDN0OI0EiwOhHFHA8eTBdjMg45S58rZh2GixLpSWgTTdiuP
        xcHQX11JsgvXEFyvM/DYoRLBK2Mrxbpi4Z39I9eTTOBd0NQWwdIHYbzeijw0YD8Yc/qzR/hB
        la2WYGkBlJcJWfcOMNif/4vtGhgkbiGxYU0zw5o6hjV1DP9z7yHSjAKZPG1WOqONUjO6cK0i
        S5unTg8/n51lQcvf0++2z7eiNte5boRpJF4nSBPNy4VcRb62MKsbAU2IAwSyuAW5UKBUFBYx
        muyzmrxMRtuNNtKkOFBwyeerXIjTFbnMRYbJYTSrKof2DSpGulih8c2o7kdZbryrteXPEZ88
        p8MZ9unqeIw7tMAvQzf1pWLsifJ0c1FDV89tMsYekRJs/pbdmfTipCh1A6ku2baz3a7P6RA0
        hyrOHEq+oZIlhizWB5s6p5VXZE+3TI7ipGiRb4emu9Bnb/I+VciFkcQpYv/s5WP1zkF0Yoi2
        iUmtShG5m9BoFX8BMmefGTkDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrJIsWRmVeSWpSXmKPExsVy+t/xe7opfl+jDXr3WlhMffiEzeJK6yZG
        i29XOpgspvxZzmRxedccNovP7/ezOrB57Jx1l91j06pONo871/aweUyf85/R4/MmuQDWKD2b
        ovzSklSFjPziElulaEMLIz1DSws9IxNLPUNj81grI1MlfTublNSczLLUIn27BL2Mhs5VTAVT
        WCtet31kbWCcw9LFyMkhIWAi8W/JHyCbi0NIYCmjxJGOE+wQCRmJk9MaWCFsYYk/17rYIIre
        Mkr8fLiDGSQhLOApcWPbQUYQW0RAWeLq971gk5gFFjFKTFg7lwmiYwWTxNFZV8A62AQMJbre
        gozi5OAVsJOY/nsL2B0sAqoSkzceAbNFBWIkOq/Pg6oRlDg58wlQnIODU8BI4ulRW5Aws4C6
        xJ95l5ghbHmJ7W/nQNniEreezGeawCg0C0n3LCQts5C0zELSsoCRZRWjSGppcW56brGhXnFi
        bnFpXrpecn7uJkZgtG079nPzDsZLG4MPMQpwMCrx8CYIf4kWYk0sK67MPcQowcGsJMIbafM1
        Wog3JbGyKrUoP76oNCe1+BCjKdBvE5mlRJPzgYkgryTe0NTQ3MLS0NzY3NjMQkmc97xBZZSQ
        QHpiSWp2ampBahFMHxMHp1QDYzOz39vO7fNdNCw751lNEH/8YMrnHZ1r5/689kLCU+XT8aUh
        JxfvZCsquDef73DyXas1D3SOuxyZK9Wey7GYYfbedf1SH08yr5N9OUsn4oL4n2iXttCHn/W6
        3E4vjiw5FMu7pES8eSdj4YLjf7zv/GiMV67577AqrqPe8PJK74AudRnhCxzN/5RYijMSDbWY
        i4oTAUszk+PMAgAA
X-CMS-MailID: 20181121122405eucas1p2a30394f5a0ca105ca63bde5c262de4f8
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20181120170248epcas1p2a93ec9ff7f74ad4908166590ed548386
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181120170248epcas1p2a93ec9ff7f74ad4908166590ed548386
References: <CGME20181120170248epcas1p2a93ec9ff7f74ad4908166590ed548386@epcas1p2.samsung.com>
        <20181120170152.24652-1-ckeepax@opensource.cirrus.com>
        <c426f174-dc45-3a25-4c7e-018972c2ceef@samsung.com>
        <b7648606-b5d1-c42f-cf68-338fbc3cf4df@samsung.com>
        <20181121121907.GB8059@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

On 2018-11-21 13:19, Mark Brown wrote:
> On Wed, Nov 21, 2018 at 10:26:30AM +0100, Marek Szyprowski wrote:
>
>> from wm8994_ldo_remove(), switched to regulator_register() in
>> wm8994_ldo_probe() and added regulator_unregister() in
>> wm8994_ldo_remove(). This way the warning is gone. If there is any
> I don't understand why you'd need to switch to regulator_register()?

I mixed a few things. This was just a first version of my experiments,
which worked without the warning. In the final solution it was not
needed, see https://lkml.org/lkml/2018/11/21/542

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

