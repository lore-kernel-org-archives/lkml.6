Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FORGED_MUA_MOZILLA,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A240C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 08:14:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF9362089D
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 08:14:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="l64eorXb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF9362089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727500AbeIZO0c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 10:26:32 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:38860 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726467AbeIZO0b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 10:26:31 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20180926081446euoutp01ed9cc1f8be31a36ca974cda45ab7e6bf~X5ReB2UB42917929179euoutp01t
        for <linux-kernel@vger.kernel.org>; Wed, 26 Sep 2018 08:14:46 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20180926081446euoutp01ed9cc1f8be31a36ca974cda45ab7e6bf~X5ReB2UB42917929179euoutp01t
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1537949686;
        bh=pz2Y70Z3cV42OwQa3RmI4P1dTljFMWBoR7JfmuNxQBI=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=l64eorXbFkcsG0vUlU/An1BfXor8ywEjlNztzGszZeY52XDjUQ1zpIk2Cewn5U+N6
         EnmephEigRzM2Png0ToGrlB0d1WMMA8qI79gml2pSE2O7UluRAM4bBPBD02wxz2TAg
         IF0aSCq0ig7EGcllG99cMjfHPer3fGM8yPiEg3RE=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20180926081446eucas1p18cebe36c5b4535ca02a77f2cc73676f2~X5RdRLUTx0201902019eucas1p1m;
        Wed, 26 Sep 2018 08:14:46 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id C9.AC.04294.5FF3BAB5; Wed, 26
        Sep 2018 09:14:45 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20180926081445eucas1p265a9e6e80a1dbb35b2fe66c5f035dff5~X5RcU8klm1224512245eucas1p29;
        Wed, 26 Sep 2018 08:14:45 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20180926081444eusmtrp12cfb6a50cced59c91e174b9de2c3affb~X5RcD71ae1633516335eusmtrp1R;
        Wed, 26 Sep 2018 08:14:44 +0000 (GMT)
X-AuditID: cbfec7f4-84fff700000010c6-87-5bab3ff52605
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id DF.E6.04128.4FF3BAB5; Wed, 26
        Sep 2018 09:14:44 +0100 (BST)
Received: from [106.116.147.30] (unknown [106.116.147.30]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20180926081444eusmtip21a99cd8f7dd9180a5a30fa1e5612aea3~X5RbponUi1807618076eusmtip2M;
        Wed, 26 Sep 2018 08:14:44 +0000 (GMT)
Subject: Re: [PATCH] mmc: pwrseq_simple: Fix incorrect handling of GPIO
 bitmap
To:     Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Linux Samsung SOC <linux-samsung-soc@vger.kernel.org>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Date:   Wed, 26 Sep 2018 10:14:43 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
        Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180925192433.1377-1-jmkrzyszt@gmail.com>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrFKsWRmVeSWpSXmKPExsWy7djPc7pf7VdHG5x4pGNxZdssZovz5zew
        W0z5s5zJYvP8P4wWl3fNYbM48r+f0WLG+X1MFsfXhjtweOycdZfdY9OqTjaPO9f2sHl83iQX
        wBLFZZOSmpNZllqkb5fAlbF152Hmgl3iFUdunGVuYPwm1MXIySEhYCJxYe1pti5GLg4hgRWM
        EvP2dkM5Xxgl9n1eDOV8ZpTY1TuNHabl17FtjCC2kMByRonlT7Qgit4zSrzY9pIVJCEsECCx
        f8MSMFtEIEJiw/IGZpAiZoGHjBL3jmxjAUmwCRhKdL3tYgOxWQRUJebPPgg0lYNDVCBG4vcu
        a5Awr4CgxMmZT8DKOQUsJI63HgMrZxaQl9j+dg4zhC0ucevJfCaQ+RICm9gljuyZzwbRXCax
        seUp1NUuEitnTYWyhSVeHd8CZctInJ7cwwLR3Mwo0T5jFjuE08MosXXODjaIKmuJw8cvsoJc
        xyygKbF+lz5E2FHiwcVzYEdLCPBJ3HgrCHEQn8SkbdOZIcK8Eh1t0LBWk5h1fB3c2oMXLjFP
        YFSaheTNWUhem4XktVkIexcwsqxiFE8tLc5NTy02ykst1ytOzC0uzUvXS87P3cQITEGn/x3/
        soNx15+kQ4wCHIxKPLwctquihVgTy4orcw8xSnAwK4nw5huujhbiTUmsrEotyo8vKs1JLT7E
        KM3BoiTOy6eVFi0kkJ5YkpqdmlqQWgSTZeLglGpg1HNzz2fqiu5Memn+iS1q+6SypSo2H14t
        NIoID7y2RClGxezkVuW3s9I4IyQXFDNecH+nLPG3keG67EeWzd68Bx5eaOTRVJrC+ZE7S2If
        a35Hfqu3303pnu66u/xtyb8kf6z5cWC3weRbrz/oKhR0ZSv3XXo3KXzx2QkHb3q8vj63rF50
        ybIQJZbijERDLeai4kQAnMpRQD0DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrHIsWRmVeSWpSXmKPExsVy+t/xe7pf7FdHGyz+pmNxZdssZovz5zew
        W0z5s5zJYvP8P4wWl3fNYbM48r+f0WLG+X1MFsfXhjtweOycdZfdY9OqTjaPO9f2sHl83iQX
        wBKlZ1OUX1qSqpCRX1xiqxRtaGGkZ2hpoWdkYqlnaGwea2VkqqRvZ5OSmpNZllqkb5egl7F1
        52Hmgl3iFUdunGVuYPwm1MXIySEhYCLx69g2xi5GLg4hgaWMEndnLmCFSMhInJzWAGULS/y5
        1sUGUfSWUeJSzztGkISwgJ/EhIWT2UBsEYEIiRXTe5hAipgFHjJK7J/ylRWi4xKjRG/vUrAO
        NgFDia63XWAdvAJ2EptWLGAHsVkEVCXmzz4IViMqECNxdHILVI2gxMmZT1hAbE4BC4njrcfA
        4swCZhLzNj9khrDlJba/nQNli0vcejKfaQKj0Cwk7bOQtMxC0jILScsCRpZVjCKppcW56bnF
        RnrFibnFpXnpesn5uZsYgXG37djPLTsYu94FH2IU4GBU4uHlsF0VLcSaWFZcmXuIUYKDWUmE
        N99wdbQQb0piZVVqUX58UWlOavEhRlOg5yYyS4km5wNTQl5JvKGpobmFpaG5sbmxmYWSOO95
        g8ooIYH0xJLU7NTUgtQimD4mDk6pBsal93z2ax0t2cR0ep9PCOsBn9A7dxfk86ldmX3Ab9q8
        z+J65hqy+z3iXB+JvrjP96r07GLLOQJv383qO3XB/uiy8kmVvy6brVn5sM7sdofvuphr8Q11
        y3qOT8hvfasgf2O+lqHxY78knaO/dh1gdH8113i1lek3/Xu//qn/uehoXxnRZCtwtUREiaU4
        I9FQi7moOBEAk4wrztECAAA=
Message-Id: <20180926081445eucas1p265a9e6e80a1dbb35b2fe66c5f035dff5~X5RcU8klm1224512245eucas1p29@eucas1p2.samsung.com>
X-CMS-MailID: 20180926081445eucas1p265a9e6e80a1dbb35b2fe66c5f035dff5
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20180925192325epcas1p41b5c57a1ff7c9bc00f9a6d3b2e601820
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180925192325epcas1p41b5c57a1ff7c9bc00f9a6d3b2e601820
References: <CAGfqbt4n4g_24kWGPhXojooiQQOmVeq-TfYucFERXJGMci87Xw@mail.gmail.com>
        <CGME20180925192325epcas1p41b5c57a1ff7c9bc00f9a6d3b2e601820@epcas1p4.samsung.com>
        <20180925192433.1377-1-jmkrzyszt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Janusz,

On 2018-09-25 21:24, Janusz Krzysztofik wrote:
> Commit b9762bebc633 ("gpiolib: Pass bitmaps, not integer arrays, to
> get/set array") changed the way GPIO values are passed to
> gpiod_get/set_array_value() and friends.  The updated code of
> mmc_pwrseq_simple_set_gpios_value() incorrectly uses the 'value'
> argument as a bitmap of GPIO values and assigns it directly to the
> 'values' bitmap variable passed to gpiod_set_array_value_cansleep()
> instead of filling that bitmap with bits equal to the 'value' argument.
> As a result, boot hanging caused by incorrectly handled MMC device
> has been observed.
>
> As a side effect of that incorrect interpreation of the 'value'
> argument, wrong assumption is taken about the 'values' bitmap size
> never exceding the number of bits of the 'value' argument type.
>
> Fix it.
>
> Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
> ---
> Hi,
>
> I hope I've finally identified the root cause of the boot hang reported
> by Marek Szyprowski.  I've reviewed the code of other divers updated for
> the modified GPIO API and found no more issues of that kind.
>
> Marek, can you please test this fix on top of next-20180920 with the fix
> "gpiolib: Fix missing updates of bitmap index" also applied?

Yes, I've just did such test (next-20180920 + "gpiolib: Fix missing
updates of bitmap index" + "mmc: pwrseq_simple: Fix incorrect handling
of GPIO bitmap") and sadly it doesn't fix the boot hang.

With some more debugs in mmc_pwrseq_simple I've noticed that
gpiod_set_array_value_cansleep() never ends and busyloops somewhere.
I'm checking this now.

> I've assumed this fix, if tested successfully, will be merged via GPIO
> tree, hence I've selected Linus as the main recipient of this message.
>
> Thanks,
> Janusz
>
>   drivers/mmc/core/pwrseq_simple.c | 13 +++++++++++--
>   1 file changed, 11 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/core/pwrseq_simple.c b/drivers/mmc/core/pwrseq_simple.c
> index 7f882a2bb872..ece34c734693 100644
> --- a/drivers/mmc/core/pwrseq_simple.c
> +++ b/drivers/mmc/core/pwrseq_simple.c
> @@ -40,13 +40,22 @@ static void mmc_pwrseq_simple_set_gpios_value(struct mmc_pwrseq_simple *pwrseq,
>   	struct gpio_descs *reset_gpios = pwrseq->reset_gpios;
>   
>   	if (!IS_ERR(reset_gpios)) {
> -		DECLARE_BITMAP(values, BITS_PER_TYPE(value));
> +		unsigned long *values;
>   		int nvalues = reset_gpios->ndescs;
>   
> -		values[0] = value;
> +		values = bitmap_alloc(nvalues, GFP_KERNEL);
> +		if (!values)
> +			return;
> +
> +		if (value)
> +			bitmap_fill(values, nvalues);
> +		else
> +			bitmap_zero(values, nvalues);
>   
>   		gpiod_set_array_value_cansleep(nvalues, reset_gpios->desc,
>   					       reset_gpios->info, values);
> +
> +		kfree(values);
>   	}
>   }
>   

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

