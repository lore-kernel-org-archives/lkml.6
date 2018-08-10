Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FORGED_MUA_MOZILLA,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FC58C46464
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 08:23:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FADF223F8
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 08:23:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="dHo+M3Oj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FADF223F8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727543AbeHJKwh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 06:52:37 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:55302 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726961AbeHJKwh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 06:52:37 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20180810082345euoutp0118749b975f60e550bc4e88a15ed972b5~JeE5Sp0OM0857208572euoutp01j
        for <linux-kernel@vger.kernel.org>; Fri, 10 Aug 2018 08:23:45 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20180810082345euoutp0118749b975f60e550bc4e88a15ed972b5~JeE5Sp0OM0857208572euoutp01j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1533889425;
        bh=WjL5HvqJjlMFc5ekNZ+iYlyfPVHOSAYYEhEjCg1uOak=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=dHo+M3OjI6B+MQ3hzJlvYqdLrayNVxKSEg6NHwb/ylCm0wixCdNDexueRxEYAmLjF
         EPvJLGPViYTN5JUwVVRrTturB1HgY4n/sVeI2oLEFWATr/BN36F6Apsfgjo2N23JDW
         vs1MzSHVkJYJ/GCtQb73n+wZEJY/0O1LBTAWPPWA=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20180810082345eucas1p1a75c75dd6d043c01bb1fcb45acc98a21~JeE4kfEbf0417504175eucas1p1v;
        Fri, 10 Aug 2018 08:23:45 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id E7.F5.04441.09B4D6B5; Fri, 10
        Aug 2018 09:23:44 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20180810082344eucas1p2c525a61cb176b4ab1dab22347afd539b~JeE3uTBkU1731217312eucas1p2T;
        Fri, 10 Aug 2018 08:23:44 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20180810082343eusmtrp1973ca0d8092c6f76f2f05d5216ea85b2~JeE3en4Vn2012320123eusmtrp1Q;
        Fri, 10 Aug 2018 08:23:43 +0000 (GMT)
X-AuditID: cbfec7f2-5c9ff70000001159-32-5b6d4b908915
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id EA.C5.04284.F8B4D6B5; Fri, 10
        Aug 2018 09:23:43 +0100 (BST)
Received: from [106.116.147.30] (unknown [106.116.147.30]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20180810082343eusmtip24f71948d0b152714d0614d6ba8ddfbc6~JeE3GLFBG0269602696eusmtip2S;
        Fri, 10 Aug 2018 08:23:43 +0000 (GMT)
Subject: Re: [PATCH] Input: cros_ec_keyb: Remove check before calling
 pm_wakeup_event.
From:   Marek Szyprowski <m.szyprowski@samsung.com>
To:     Ravi Chandra Sadineni <ravisadineni@chromium.org>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Ravi Chandra Sadineni <ravisadineni@google.com>,
        Todd Broch <tbroch@google.com>, linux-kernel@vger.kernel.org,
        linux-input@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        Tomasz Figa <tfiga@chromium.org>
Date:   Fri, 10 Aug 2018 10:23:43 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
        Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <85a59afc-9dc0-b9fb-7e8f-32731337884c@samsung.com>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrBKsWRmVeSWpSXmKPExsWy7djP87oTvHOjDT5NN7Y4vOgFo8XNT99Y
        LS7vmsNmMeP8PiaLdS3fGC3Ov/3NarHo+0NWi8+t/9gcODxmN1xk8dg56y67x4JNpR6fN8kF
        sERx2aSk5mSWpRbp2yVwZTy7+p+l4J5MxepFU9kbGDeJdzFyckgImEi0dL5h7WLk4hASWMEo
        8fHpGUYI5wujxJk7S1ggnM+MEvOfTGKGaZn7/xIriC0ksJxR4tDCAoii94wSn/vfghUJC0RI
        vO9ZwQ5iswkYSnS97WIDsUUETCXO/twAto9ZoI1J4sTlTywgCRYBVYnG+7OBbA4OUYEYid+7
        rEHCvAKCEidnPgEr4RSwlzh3pw9sJrOAvMT2t3OYIWxxiVtP5jNBHLeOXaLxRDZEb5nEwYZV
        UEe7SHy/spgFwhaWeHV8CzuELSNxenIP2JcSAs2MEu0zZrFDOD2MElvn7GCDqLKWOHz8IivI
        ccwCmhLrd+mDmBICjhJ/J0lAmHwSN94KQpzDJzFp23RmiDCvREebEMQMNYlZx9fBbT144RLz
        BEalWUienIXksVlIHpuFsHYBI8sqRvHU0uLc9NRiw7zUcr3ixNzi0rx0veT83E2MwPRz+t/x
        TzsYv15KOsQowMGoxMPLkJoTLcSaWFZcmXuIUYKDWUmEN9M0N1qINyWxsiq1KD++qDQntfgQ
        ozQHi5I4L59WWrSQQHpiSWp2ampBahFMlomDU6qBkVlwf6vFiil7XdaU7LPK9lv9ovZO9zff
        J5IGzdV/HkWYvlpmq/rv2uK2c1eZv+ZY+eY0SxvvFbieGmp+Tqtg8bdNLfe1NvNJOk0SL/er
        y6i+ryJ307IvT3aClLE859oWm0u2U83PbNf/3Cd8bULCLv6eqIx+Prlrf6OvbxC7cio/mS3g
        seUVJZbijERDLeai4kQA0C5PRzsDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrHIsWRmVeSWpSXmKPExsVy+t/xe7r93rnRBg3NFhaHF71gtLj56Rur
        xeVdc9gsZpzfx2SxruUbo8X5t79ZLRZ9f8hq8bn1H5sDh8fshossHjtn3WX3WLCp1OPzJrkA
        lig9m6L80pJUhYz84hJbpWhDCyM9Q0sLPSMTSz1DY/NYKyNTJX07m5TUnMyy1CJ9uwS9jGdX
        /7MU3JOpWL1oKnsD4ybxLkZODgkBE4m5/y+xdjFycQgJLGWU+PellQUiISNxcloDK4QtLPHn
        WhcbRNFbRokrK/qZQRLCAhES73tWsIPYbAKGEl1vQYo4OUQETCXO/twANpVZoINJYu2BBVAr
        drBL3O27AtbBK2AncW/hGjCbRUBVovH+bLDVogIxEkcnt7BB1AhKnJz5BCzOKWAvce5OH1g9
        s4CZxLzND5khbHmJ7W/nQNniEreezGeawCg0C0n7LCQts5C0zELSsoCRZRWjSGppcW56brGh
        XnFibnFpXrpecn7uJkZg3G079nPzDsZLG4MPMQpwMCrx8DKk5kQLsSaWFVfmHmKU4GBWEuHN
        NM2NFuJNSaysSi3Kjy8qzUktPsRoCvTcRGYp0eR8YErIK4k3NDU0t7A0NDc2NzazUBLnPW9Q
        GSUkkJ5YkpqdmlqQWgTTx8TBKdXAqKX88c+LhH9ur6avmHah+2Nd2S+rKuEYyxYl9dKfXE+2
        n4phcpLfL3RYxf804zW5+wHc+kdXLPp9UvLDL6AHtkUFyvpoJPrE2jeGipkIt+6e4r8g4cKU
        HX82vK7MnK/9bcNyx0kPM761G+Tln9d++Cty9p5pNh+U5Y46XN+1R+PFEqM3pidilFiKMxIN
        tZiLihMBvWQojNECAAA=
Message-Id: <20180810082344eucas1p2c525a61cb176b4ab1dab22347afd539b~JeE3uTBkU1731217312eucas1p2T@eucas1p2.samsung.com>
X-CMS-MailID: 20180810082344eucas1p2c525a61cb176b4ab1dab22347afd539b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20180803072628eucas1p26abe0cb121b974401759502f8807bb96
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180803072628eucas1p26abe0cb121b974401759502f8807bb96
References: <CGME20180803072628eucas1p26abe0cb121b974401759502f8807bb96@eucas1p2.samsung.com>
        <20180605224458.62692-1-ravisadineni@chromium.org>
        <20180803072628eucas1p26abe0cb121b974401759502f8807bb96~HTx4BGQjl1119311193eucas1p2U@eucas1p2.samsung.com>
        <CAEZbON7qLheHFuU6zwArCz=CG03JvnFjcehBGjE4RqROYrMLhQ@mail.gmail.com>
        <CAKdAkRQG08d_duPiKFi_=xUNO93c0Rcw9kpaYFFJahjJM-NdGw@mail.gmail.com>
        <CAEZbON4O0X8Fo6eAbmPOSiB1_Tw7x+Ox3ROoGfZQn72uQGQLkg@mail.gmail.com>
        <20180806052949eucas1p2483800c02730febd03d4a661a25fa405~INH40XvCx2719627196eucas1p2X@eucas1p2.samsung.com>
        <CAKdAkRSvLq-L3FrODUqxXqDs2FymM9k5dZRxnOpc44rFiHaWAQ@mail.gmail.com>
        <20180806071543eucas1p233ac5016e1a586594cf8ecd1fe3214b0~IOkV1Zt7j2129321293eucas1p20@eucas1p2.samsung.com>
        <CAEZbON72eVUCNT3ePEZKrB5B6+6YYgO7=X0TY0eBqUb3ws0sLA@mail.gmail.com>
        <CAEZbON5vMOiYRsnN1MyuSov3URByeAp-z3EEsEH6tqY23U32wQ@mail.gmail.com>
        <85a59afc-9dc0-b9fb-7e8f-32731337884c@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ravi,

Just to let you know - I hope I've finally bisected all the issues related
to suspend/resume on Samsung Chromebooks with mainline kernel. I did my
tests on Linux next-20180809. The mentioned commit 38ba34a43dbc ("Input:
cros_ec_keyb - mark cros_ec_keyb driver as wake enabled device.") breaks
suspend/resume operation also on Samsung Exynos5420-based Peach-Pit
Chromebook. Here is some more information how to get suspend/resume
working with mainline on that board:
https://patchwork.kernel.org/patch/10562419/

Best regards
Marek Szyprowski, PhD
Samsung R&D Institute Poland

On 2018-08-08 07:03, Marek Szyprowski wrote:
> Hi Ravi,
>
> On 2018-08-07 23:59, Ravi Chandra Sadineni wrote:
>> hi Merek,
>>
>> I tried booting a snow device and could not get it to boot it to the
>> console. I assume i don't have right kernel config. Can you share your
>> config if possible.
>
> I use standard exynos_defconfig bundled with Linux kernel. I've followed
> this instruction to boot in on Snow:
>
> https://s-opensource.org/2016/03/24/use-mainline-u-boot-non-signed-kernels-exynos-chromebooks/ 
>
>
>>
>> Thanks,
>> RaviOn Mon, Aug 6, 2018 at 4:05 PM Ravi Chandra Sadineni
>> <ravisadineni@chromium.org> wrote:
>>> Hi Merek,
>>>
>>> Thanks for the info. Lemme understand what's going on. Will update the
>>> thread once I have more info.
>>>
>>> Thanks,
>>> Ravi
>>> On Mon, Aug 6, 2018 at 12:15 AM Marek Szyprowski
>>> <m.szyprowski@samsung.com> wrote:
>>>> Hi Dmitry
>>>>
>>>> On 2018-08-06 08:16, Dmitry Torokhov wrote:
>>>>> On Sun, Aug 5, 2018 at 10:29 PM Marek Szyprowski
>>>>> <m.szyprowski@samsung.com> wrote:
>>>>>> Hi Ravi,
>>>>>>
>>>>>> On 2018-08-03 18:53, Ravi Chandra Sadineni wrote:
>>>>>>> Understood. I am trying to reproduce this issue locally. Wanted to
>>>>>>> know the version of the kernel so I can give a try. Marek, can you
>>>>>>> please confirm the kernel version.
>>>>>>>
>>>>>> Yes, sorry for the missing context, I was in hurry writing the 
>>>>>> report and
>>>>>> I wanted to send it before leaving the office. I'm testing 
>>>>>> mainline on Snow
>>>>>> with exynos_defconfig.
>>>>>>
>>>>>> Suspend/resume is partially broken already with mainline, but if 
>>>>>> you disable
>>>>>> CPUfreq support, it works fine on Linux v4.17.
>>>>>>
>>>>>> I've posted CPUfreq related fixes here if you are interested:
>>>>>> https://patchwork.kernel.org/patch/10554607/
>>>>>> https://patchwork.kernel.org/patch/10554603/
>>>>>>
>>>>>> The issue with cros_ec_keyb patch appears first on Linux 
>>>>>> v4.18-rc1, which is
>>>>>> the first release with that patch.
>>>>> Marek, this patch should only be in -next, I do not believe I sent it
>>>>> to Linus just yet. If mainline is broken for you it can't be 
>>>>> caused by
>>>>> this patch.
>>>> Aaahh. My fault then. The suspend/resume issue is cause by commit
>>>> 38ba34a43dbc ("Input: cros_ec_keyb - mark cros_ec_keyb driver as wake
>>>> enabled device."), which has been merged to v4.18-rc1.
>>>>
>>>> It looks that I've downloaded wrong patch from the patchwork to 
>>>> reply it
>>>> with a a bug report. :( I'm really sorry for the noise in the wrong 
>>>> thread.
>>>>
>>>> Ravi: please let me know how can I help you to debug this issue.
>>>>
>>>>>> Linux -next from 20180803, which has a few
>>>>>> more patches for cros_ec_keyb suffers from the same issue.
>>>>> Just to confirm, if you revert only this patch from -next you get
>>>>> suspend/resume back?
>>>>>
>>>>> Thanks.
>>>> Best regards
>>>> -- 
>>>> Marek Szyprowski, PhD
>>>> Samsung R&D Institute Poland
>>>>
>>
>
> Best regards

