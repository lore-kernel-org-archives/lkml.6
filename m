Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FORGED_MUA_MOZILLA,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAAAFC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 08:27:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 857EB2089D
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 08:27:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="XYDsIP1U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 857EB2089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727443AbeIZOjW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 10:39:22 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:51637 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726467AbeIZOjW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 10:39:22 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20180926082733euoutp02894d9160d27a4d0054553fcf8af15f3f~X5cn3tjo42254422544euoutp02T
        for <linux-kernel@vger.kernel.org>; Wed, 26 Sep 2018 08:27:33 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20180926082733euoutp02894d9160d27a4d0054553fcf8af15f3f~X5cn3tjo42254422544euoutp02T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1537950453;
        bh=DGaYL5oWkvxy60NOlTLIXb/Qq//F7CpBP0jVZsjbJjE=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=XYDsIP1UWpXLFzpXjALS8Ggs1qPvvP4rfhfh84+3g2vAKv+VJf+VBrGJCNbnJ7zj+
         nhvcF66XG4qozUVIef355NhjhsFPTKnWA/T5UqZHOXNA8DoCezueXe6PUHyr4aXeAW
         eY8mMpIr8NWeopiDzijrkDpxrKi0zXdpSDH7trBA=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20180926082732eucas1p1caa59554a2e470e6adcb6c8c0961d9da~X5cnfCWiR0635006350eucas1p1T;
        Wed, 26 Sep 2018 08:27:32 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 74.2F.04294.4F24BAB5; Wed, 26
        Sep 2018 09:27:32 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20180926082731eucas1p1fb936eedca21be0b8cd4dd281e422f27~X5cmfM67m0415004150eucas1p1b;
        Wed, 26 Sep 2018 08:27:31 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20180926082731eusmtrp1a54607885494047c0bdc2ce71978eee8~X5cmOPvq01963619636eusmtrp1U;
        Wed, 26 Sep 2018 08:27:31 +0000 (GMT)
X-AuditID: cbfec7f4-c77a99c0000010c6-24-5bab42f41b23
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 29.AB.04284.3F24BAB5; Wed, 26
        Sep 2018 09:27:31 +0100 (BST)
Received: from [106.116.147.30] (unknown [106.116.147.30]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20180926082731eusmtip2f4c7b31850598aacc766403e964b8416~X5clz6v0k2121621216eusmtip2M;
        Wed, 26 Sep 2018 08:27:31 +0000 (GMT)
Subject: Re: [PATCH] mmc: pwrseq_simple: Fix incorrect handling of GPIO
 bitmap
From:   Marek Szyprowski <m.szyprowski@samsung.com>
To:     Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Linux Samsung SOC <linux-samsung-soc@vger.kernel.org>
Date:   Wed, 26 Sep 2018 10:27:30 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
        Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <7a4906d9-ffb1-f2af-07e7-d5815dcd0d8c@samsung.com>
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA01SfUhTcRTlt/f29hRnP6fixbJoYKSStrKYaWZptP7SQEhcpEtfKjknm7OU
        IMM0E81wgfq0FBH8GJZNXbosmZlDJOcXEZWhsiL8QEqxD01re1r+d+45595zL1yaEOn53nRa
        RhajzlCkiyln0jjw03pg+ZRefnB1zlc6YWQJqdXaJpDeX2vkSdtr15B03FRDSfs3ypC00vqC
        J7W0no+gZd3spEBmaLlDyT686aFkS4bdMWS8c1gyk56WzaiDwhOdU7+xNirz845rY6V1RB5a
        cSlGTjTgYKjqeUAWI2dahJsQLEzrCK5YRjBSdndTWUJQP9/B32opHKzfFBoRPOu+hbhiEcFE
        a7PD5Y5joLetwYEpLIHihWLKjj1wHLQ15jkyCDyN4GO/kbQLJPaF4SX7WJr2xBdg1RRqp4XY
        DQarbA6LEz4B7YsbDkzgPZDfWU1w2Ave2Wp59pmADQKo/DRPcc3Z8HDWjLi1o+B7d/kmdodZ
        S4eAw7tgSFdCcs35CG5XsgKuKEHQWdNFca5QeGkZ5du3I7AfPDYFcfRJmBodRnYasCu8XXDj
        FnKFcmMFwdFCKCoUce59wFoe/Ys1j4wR95CY3XYmu+00dttp7P/cOkS2IC9Gq1GmMJpDGczV
        QI1CqdFmpAQmqZQG9PeFhtYty13ItHapD2EaiV2E9PEWuYivyNbkKPsQ0ITYQ6iS6OUiYbIi
        J5dRqxLU2nRG04d20qTYS+jqf1kuwimKLOYKw2Qy6i2VRzt556GGm6NVkTrvOdkvyPoRURLw
        6uj7lBCVbUAX23+xNmx+/Vy9fkA1VKE8NlNWat5vHkwMCR5YWW2KjooOmzmy9+GN2OEg/PTw
        pLnotaf169jZqS5Wsq7Llfh8SdA2+yWdKRqqexIZ0TnHKzgdPk5fD/MpiHepDvCN+20Y9uwV
        P6cDxaQmVSHxJ9QaxR8+NiVPPgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrHIsWRmVeSWpSXmKPExsVy+t/xe7qfnVZHGyzpVbS4sm0Ws8X58xvY
        Lab8Wc5ksXn+H0aLy7vmsFkc+d/PaDHj/D4mi+Nrwx04PHbOusvusWlVJ5vHnWt72Dw+b5IL
        YInSsynKLy1JVcjILy6xVYo2tDDSM7S00DMysdQzNDaPtTIyVdK3s0lJzcksSy3St0vQy/g0
        6wlbwTP+iku9C5gbGL/xdDFyckgImEi0nVzE0sXIxSEksJRRYtHHz6wQCRmJk9MaoGxhiT/X
        utggit4yShzY9gksISzgJzFh4WQ2EJtNwFCi620XmC0iECGxYnoPE0gDs8BDRon9U76yQnS3
        M0mcubCWEaSKV8BO4uyr2ewgNouAqsS5zyB3cHKICsRIHJ3cwgZRIyhxcuYTsDingL3E5vf/
        wWxmATOJeZsfMkPY8hLNW2dD2eISt57MZ5rAKDQLSfssJC2zkLTMQtKygJFlFaNIamlxbnpu
        saFecWJucWleul5yfu4mRmDcbTv2c/MOxksbgw8xCnAwKvHwctiuihZiTSwrrsw9xCjBwawk
        wptvuDpaiDclsbIqtSg/vqg0J7X4EKMp0HMTmaVEk/OBKSGvJN7Q1NDcwtLQ3Njc2MxCSZz3
        vEFllJBAemJJanZqakFqEUwfEwenVAOjuY1euWxSXhenCUNp0ubcCycecns2xepdORMVk7ev
        9IuCS8iCNtZG1998DHKfNpRVcjC90lJs/fs9w/+hYbKP4cmTEwzjvt8+FvmlqvfbSm6tYtEM
        r2r33ytOLcs9tbLt4fYnK5eoWLq+Zl9jv6AopXvjQu/sN6ZrGmx/7hHQfM7GtHffhDVKLMUZ
        iYZazEXFiQD3FF5o0QIAAA==
Message-Id: <20180926082731eucas1p1fb936eedca21be0b8cd4dd281e422f27~X5cmfM67m0415004150eucas1p1b@eucas1p1.samsung.com>
X-CMS-MailID: 20180926082731eucas1p1fb936eedca21be0b8cd4dd281e422f27
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20180925192325epcas1p41b5c57a1ff7c9bc00f9a6d3b2e601820
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180925192325epcas1p41b5c57a1ff7c9bc00f9a6d3b2e601820
References: <CAGfqbt4n4g_24kWGPhXojooiQQOmVeq-TfYucFERXJGMci87Xw@mail.gmail.com>
        <CGME20180925192325epcas1p41b5c57a1ff7c9bc00f9a6d3b2e601820@epcas1p4.samsung.com>
        <20180925192433.1377-1-jmkrzyszt@gmail.com>
        <7a4906d9-ffb1-f2af-07e7-d5815dcd0d8c@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi again,

On 2018-09-26 10:14, Marek Szyprowski wrote:
> On 2018-09-25 21:24, Janusz Krzysztofik wrote:
>> Commit b9762bebc633 ("gpiolib: Pass bitmaps, not integer arrays, to
>> get/set array") changed the way GPIO values are passed to
>> gpiod_get/set_array_value() and friends.  The updated code of
>> mmc_pwrseq_simple_set_gpios_value() incorrectly uses the 'value'
>> argument as a bitmap of GPIO values and assigns it directly to the
>> 'values' bitmap variable passed to gpiod_set_array_value_cansleep()
>> instead of filling that bitmap with bits equal to the 'value' argument.
>> As a result, boot hanging caused by incorrectly handled MMC device
>> has been observed.
>>
>> As a side effect of that incorrect interpreation of the 'value'
>> argument, wrong assumption is taken about the 'values' bitmap size
>> never exceding the number of bits of the 'value' argument type.
>>
>> Fix it.
>>
>> Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
>> Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
>> ---
>> Hi,
>>
>> I hope I've finally identified the root cause of the boot hang reported
>> by Marek Szyprowski.  I've reviewed the code of other divers updated for
>> the modified GPIO API and found no more issues of that kind.
>>
>> Marek, can you please test this fix on top of next-20180920 with the fix
>> "gpiolib: Fix missing updates of bitmap index" also applied?
>
> Yes, I've just did such test (next-20180920 + "gpiolib: Fix missing
> updates of bitmap index" + "mmc: pwrseq_simple: Fix incorrect handling
> of GPIO bitmap") and sadly it doesn't fix the boot hang.
>
> With some more debugs in mmc_pwrseq_simple I've noticed that
> gpiod_set_array_value_cansleep() never ends and busyloops somewhere.
> I'm checking this now.

I busyloops inside the internal do { } while loop (lines 3163-3201) in
gpiod_set_array_value_complex(). 'i' is never incremented.

 > ...

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

