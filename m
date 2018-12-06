Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A63CC04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 13:27:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05C2220868
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 13:27:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="idro8KHB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05C2220868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729179AbeLFN1I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 08:27:08 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:37790 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728448AbeLFN1I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 08:27:08 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20181206132706euoutp0234b648dd746e74a771fa6deae80088bb~twVbamgEH2190321903euoutp02y
        for <linux-kernel@vger.kernel.org>; Thu,  6 Dec 2018 13:27:06 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20181206132706euoutp0234b648dd746e74a771fa6deae80088bb~twVbamgEH2190321903euoutp02y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1544102826;
        bh=nGQyXPerLu/gMEhYFmmX2VpTwLu6Le4sanBCmmLaY08=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=idro8KHB+9Eb1LGGNd2ic0WWHfisIcz9VMqeYs71FtxErzxFKK7YQEzLER0g7YykT
         heB21MmvGInGVAddMlUYTOzWEzw1nI1X0givNB10EL9d03C18ec+q8dxjjbKE8rXdr
         ge2H557LdcLZ+7EA2sj82citM54wVt0lR4KIrOTg=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20181206132705eucas1p29b611a31b472272dab997b033f5c3884~twVa9cDMP1621516215eucas1p24;
        Thu,  6 Dec 2018 13:27:05 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 7A.E6.04294.9A3290C5; Thu,  6
        Dec 2018 13:27:05 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20181206132704eucas1p1b0a55aa6d60a094088eb8576a021a612~twVaDELyD2822528225eucas1p1m;
        Thu,  6 Dec 2018 13:27:04 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20181206132704eusmtrp28ddcc3ce8f2b5d75184757d709ba81e9~twVZ0sBWk3213732137eusmtrp2-;
        Thu,  6 Dec 2018 13:27:04 +0000 (GMT)
X-AuditID: cbfec7f4-84fff700000010c6-be-5c0923a91d15
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id C2.93.04128.8A3290C5; Thu,  6
        Dec 2018 13:27:04 +0000 (GMT)
Received: from [106.116.147.30] (unknown [106.116.147.30]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20181206132703eusmtip26c35945174f85e3c4ad50e720dcca891~twVZXV4gb2984429844eusmtip2h;
        Thu,  6 Dec 2018 13:27:03 +0000 (GMT)
Subject: Re: [PATCH 00/15 v4] Regulator ena_gpiod fixups
To:     Linus Walleij <linus.walleij@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <b2dd4b32-9929-19b1-c849-63d8c793c187@samsung.com>
Date:   Thu, 6 Dec 2018 14:27:03 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
        Thunderbird/60.3.2
MIME-Version: 1.0
In-Reply-To: <20181206124351.10155-1-linus.walleij@linaro.org>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTYRjHfXfOzo7D2XEqe1JTmhYYqGlRBwpLMppCUX3qIuWpHVRyUzZ1
        mn2Q5tSNIKlEO0wcmVn7UDZN5+mCl3KpXcw0LxkYCZYgIkpUmubxZPnt/3+f33P5w0tiSqc0
        iMzQ57AGPZOpJuR4c9fPN1H3wr1Tto/MbqDnq3twuuLzBEEPWFyI/j5QJqFvLNZL6Pe8ndhP
        aGaGLTJNK/dJpnE5rYRm7MMTQlNpX0aaOVfoUeKUfK+WzczIYw0x8any9IVfv1F2bWj+7EgV
        KkJvVTbkTQK1Ezpct3AbkpNK6i6C8jqrVDTzCF6NeCSimUMw2LssWWvpv9r+t6UeQbfDQohm
        BsFlvmKV8qdo+PG0WiboACoHbpfwSIAwyoLAVf4MEwoEFQu2aRshaAUVD9cXi1YgksSpCCge
        3SXIQCoF+MlLIuEH3TcncEF7r9DmsiWpoDEqDFqm7ZioVTA6UbN6NVAuGdT1cBJhDlCJ0Fdu
        EgP4w5SnSSbqEFhuXePNCEqrOJloriB4ZHcTIrUHOj3vpMIgjIqEB3yM+JwAVfVOqTjfF4an
        /cQbfOFacyUmPiugrEQp0luB89z/t7a9rx8rR2puXTJuXRpuXRru/14Hwp1IxeYadWmsMU7P
        mqKNjM6Yq0+LPp+lc6GVH9S75Jl3I37xXAeiSKT2UXwdl6UopUyesUDXgYDE1AEKr2gyRanQ
        MgUXWUPWWUNuJmvsQMEkrlYpCr3GTyupNCaHvcCy2axhrSohvYOK0L5C7fMTPpPJ9NBcckND
        7ECS7bU20pJ+6MyW8FRP22HdrYQjNdaT+dJKKi4n5NsQn2TWM+72xJbdYY/dU8c3lTYfawze
        uGimTcEv7L1RXW2tDqzGwc87ar/U0v4fx9HBppbipcaHO6xxd9wDEVObDwQuZHUmBQ5G9vBj
        zEtTnBo3pjOx2zCDkfkDi9uHwD0DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrHIsWRmVeSWpSXmKPExsVy+t/xe7orlDljDP5d4Lf4MvcUi8XUh0/Y
        LK60bmK0+Halg8liyp/lTBaXd81hc2DzeH+jld1j56y77B6bVnWyedy5tofNY/qc/4wenzfJ
        BbBF6dkU5ZeWpCpk5BeX2CpFG1oY6RlaWugZmVjqGRqbx1oZmSrp29mkpOZklqUW6dsl6GX8
        /vWXsWCxXMXHmzMYGxjPi3cxcnJICJhIXOo/yNLFyMUhJLCUUeLr6UksEAkZiZPTGlghbGGJ
        P9e62CCK3jJK3Ppylx0kISxgIfFj71wwW0SgROLD/p3sIEXMAq2MEo8e34DqmMgoseN4J9hY
        NgFDia63IKM4OXgF7CQm/2lg7GLk4GARUJFouWUGEhYViJGYcvk1K0SJoMTJmU/AWjmByps7
        /oHFmQXUJf7Mu8QMYctLbH87B8oWl7j1ZD7TBEahWUjaZyFpmYWkZRaSlgWMLKsYRVJLi3PT
        c4uN9IoTc4tL89L1kvNzNzEC427bsZ9bdjB2vQs+xCjAwajEw/viAXuMEGtiWXFl7iFGCQ5m
        JRFeBj2OGCHelMTKqtSi/Pii0pzU4kOMpkC/TWSWEk3OB6aEvJJ4Q1NDcwtLQ3Njc2MzCyVx
        3vMGlVFCAumJJanZqakFqUUwfUwcnFINjIv7lL+oLnFb2ia0bQqv2bWItYseFJ76unLn5z8O
        zMJyCdsXLOmaF2NkL5avlMFzWyrCLfhF7b0oPdPfF9/pvLumvUBAcd+KZ1cj3ya253gv3sNg
        Fcxpwf++ev+EgKwjKQat3R/9/v4I0Fwb/Pf62TqvniU2ApnxiRbLpLS/s4g3XZVQFfhwQ4ml
        OCPRUIu5qDgRAJycha7RAgAA
X-CMS-MailID: 20181206132704eucas1p1b0a55aa6d60a094088eb8576a021a612
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20181206124518epcas4p2fd2837b5bc5e0c806e93ce752599e264
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181206124518epcas4p2fd2837b5bc5e0c806e93ce752599e264
References: <CGME20181206124518epcas4p2fd2837b5bc5e0c806e93ce752599e264@epcas4p2.samsung.com>
        <20181206124351.10155-1-linus.walleij@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

On 2018-12-06 13:43, Linus Walleij wrote:
> Here is a fourth iteration of these fixups after fixing
> the (hopefullt last) bugs found in the v3 version.
>
> Also available in git branch
> gpio-descriptors-regulator-fixup in the GPIO git tree:
> https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-gpio.git/log/?h=gpio-descriptors-regulator-fixup
>
> I added two fixup item to the list: making the gpiod
> from of node respect nonexlusive flags and fixing the
> shared regulators in devm_gpiod_get*.

Yeah! Finally it looks and works right. Feel free to add my:

Reviewed-by: Marek Szyprowski <m.szyprowski@samsung.com>

and

Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>

(to patches: 1-2, 5-10 and 13-15).


One more thing - if I got everything right, gpiod_put() in
*regulator_register() error path has to be removed also in
wm8994-regulator.c and arizona-ldo1.c.


> To make sure GPIO descriptors are never left dangling
> (as far as I can tell!) I use this stepwise approach:
>
> 1. Fix the regulator_register() in the core to guarantee
>    that after calling this with a valid GPIO descriptor
>    in ena_gpiod it will be gpiod_put() if there is any
>    problem.
>
> 2. Fix up simple descriptor consumers to just gpiod_get()
>    and let the core take over the descriptor. Only handle
>    the errorpath up to this point.
>
> 3. Export gpiod_get_from_of_node() and let max77686
>    obtain a GPIO descriptor from the device tree without
>    any devres make-up in the DT parsing callback.
>
> 4. Make gpiod_get_from_of_node() respect the
>    GPIOD_FLAGS_BIT_NONEXCLUSIVE flag.
>
> 5. Fix up devm_gpiod_get_* to respect the
>    GPIOD_FLAGS_BIT_NONEXCLUSIVE flag.
>
> 6. Invent devm_gpiod_unhinge() that will remove the devres
>    monitoring of a devm_* allocated GPIO descriptor
>    right before handling it over to the regulator core,
>    and use this in the otherwise hairy max8973, da9211,
>    s5m8767, tps65090 and s2mps11 drivers.
>
>
> Linus Walleij (15):
>   regulator: core: Track dangling GPIO descriptors
>   regulator: fixed: Let core handle GPIO descriptor
>   regulator: lm363x: Let core handle GPIO descriptor
>   regulator: lp8788-ldo: Let core handle GPIO descriptor
>   regulator: max8952: Let core handle GPIO descriptor
>   gpio: Export gpiod_get_from_of_node()
>   regulator: max77686: Let core handle GPIO descriptor
>   gpio: Enable nonexclusive gpiods from DT nodes
>   gpio: devres: Handle nonexclusive GPIOs
>   gpio: Add devm_gpiod_unhinge()
>   regulator: max8973: Let core handle GPIO descriptor
>   regulator: da9211: Hand over GPIO to regulator core
>   regulator: s5m8767: Hand over GPIO to regulator core
>   regulator: tps65090: Hand over GPIO to regulator core
>   regulator: s2mps11: Hand over GPIO to regulator core
>
>  Documentation/driver-model/devres.txt  |  1 +
>  drivers/gpio/gpiolib-devres.c          | 80 ++++++++++++++++++++++----
>  drivers/gpio/gpiolib.c                 |  2 +
>  drivers/gpio/gpiolib.h                 |  6 --
>  drivers/regulator/core.c               | 55 ++++++++++++++----
>  drivers/regulator/da9211-regulator.c   |  6 ++
>  drivers/regulator/fixed.c              |  6 +-
>  drivers/regulator/lm363x-regulator.c   |  8 ++-
>  drivers/regulator/lp8788-ldo.c         |  8 ++-
>  drivers/regulator/max77686-regulator.c | 14 +++--
>  drivers/regulator/max8952.c            | 10 +++-
>  drivers/regulator/max8973-regulator.c  |  8 ++-
>  drivers/regulator/s2mps11.c            |  7 ++-
>  drivers/regulator/s5m8767.c            |  9 ++-
>  drivers/regulator/tps65090-regulator.c |  6 ++
>  include/linux/gpio/consumer.h          | 23 ++++++++
>  16 files changed, 205 insertions(+), 44 deletions(-)
>
Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

