Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FORGED_MUA_MOZILLA,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02246C6778F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 13:32:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0DFD20878
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 13:32:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="qRm9hB89"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0DFD20878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754572AbeGINcX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 09:32:23 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:58441 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754547AbeGINcT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 09:32:19 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20180709133217euoutp029e284ffa77ec78e3b276e884d921042a~-tpIfNPal0647006470euoutp02_
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jul 2018 13:32:17 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20180709133217euoutp029e284ffa77ec78e3b276e884d921042a~-tpIfNPal0647006470euoutp02_
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1531143137;
        bh=ZMOZn0nsO1hnI2Cp7/v0Du8olOzdeO1Rv6UKQTMrZRw=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=qRm9hB890Mr1atPVL5cVehPq7O2GY7bvEI6W7JpXbH6fOUAwgZIqEMo7m2SCPJILz
         iv6Z70ql4Si0Qy1IANkpy4uGDL3QVQrNPTNdOsyKVkiFs4mmDMMrnlr/XwQQG7laEm
         U318D2CGm7fzZ/x1+34zxTuk1Hr7g6X5w0rB5T+w=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20180709133216eucas1p26b184e2227772dbd14061221b3e950be~-tpHvb6fo2679826798eucas1p2g;
        Mon,  9 Jul 2018 13:32:16 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id B3.18.10409.FD3634B5; Mon,  9
        Jul 2018 14:32:15 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20180709133215eucas1p138cd9714d802a446973ce90058ef0afb~-tpG-E94E1650416504eucas1p1I;
        Mon,  9 Jul 2018 13:32:15 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20180709133215eusmtrp151a13b9be0d302ba95a2ce48f0df7ccf~-tpGwhy4c3005030050eusmtrp1h;
        Mon,  9 Jul 2018 13:32:15 +0000 (GMT)
X-AuditID: cbfec7f5-b45ff700000028a9-88-5b4363df2825
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id A5.3E.04178.FD3634B5; Mon,  9
        Jul 2018 14:32:15 +0100 (BST)
Received: from [106.116.147.30] (unknown [106.116.147.30]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20180709133214eusmtip2f1cf00c83a0340342bd271edc39d0185~-tpGYM1f30499004990eusmtip2E;
        Mon,  9 Jul 2018 13:32:14 +0000 (GMT)
Subject: Re: [PATCH] regulator: core: Don't link consumers on the same
 device
To:     Mark Brown <broonie@kernel.org>, pascal paillet <p.paillet@st.com>,
        benjamin.gaignard@linaro.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-kernel@vger.kernel.org
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Date:   Mon, 9 Jul 2018 15:32:14 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
        Thunderbird/52.9.0
MIME-Version: 1.0
In-Reply-To: <20180709125402.32427-1-broonie@kernel.org>
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrKKsWRmVeSWpSXmKPExsWy7djP87r3k52jDZa9sLLYOGM9q0XToVNs
        FlMfPmGzOH9+A7vF5V1z2CzenXnK7sDmsWlVJ5vHnWt72Dz6tqxi9Hj6Yy+zx+dNcgGsUVw2
        Kak5mWWpRfp2CVwZFy5sZSz4LlhxquEmawPjBr4uRk4OCQETidcb+pm6GLk4hARWMEocnDaN
        DcL5wiix8kEzVOYzo8TlV7/Yuxg5wFqWH+GCiC9nlPjd9hCq6D2jxK2WGUwgc4UF/CVats1n
        BrFFBNIkbvw4ygJiMwvUSxw7cAIsziZgKNH1tosNxGYRUJHYOa8XrFdUIEZi3qK/YPW8AoIS
        J2c+YQFZzClgIfGhXwVijLxE89bZzBC2uMStJ/PBbpAQWMcuMbf5DyNEb5nEwe4PrBB/ukjs
        +/aZBcIWlnh1fAs7hC0jcXpyDwtEczOjRPuMWewQTg+jxNY5O9ggqqwlDh+/yApyBbOApsT6
        XfoQYUeJldfWskJChU/ixltBiIP4JCZtm84MEeaV6GgTgqhWk5h1fB3c2oMXLjFPYFSaheTL
        WUhem4XktVkIexcwsqxiFE8tLc5NTy02zkst1ytOzC0uzUvXS87P3cQITDyn/x3/uoNx35+k
        Q4wCHIxKPLwfCp2ihVgTy4orcw8xSnAwK4nwJloBhXhTEiurUovy44tKc1KLDzFKc7AoifPG
        adRFCQmkJ5akZqemFqQWwWSZODilGhg1hHbP021Nbkpnkbk+gYnp9btI/g6X043BeWp8LQ2t
        smocrAGxQr2qCZJs7mF/I5mOrnVQVPwjxGchZCY9cVpA3pSNNrLJStkf7108ai603eNGyKpI
        PdEcofm5LoEc3JObFin1Ra/cPuOzM3f2ekPLGTvOfXg+aanJRqeF3/pXV/K5NP5/psRSnJFo
        qMVcVJwIABF0yqY4AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrBIsWRmVeSWpSXmKPExsVy+t/xe7r3k52jDf4tY7XYOGM9q0XToVNs
        FlMfPmGzOH9+A7vF5V1z2CzenXnK7sDmsWlVJ5vHnWt72Dz6tqxi9Hj6Yy+zx+dNcgGsUXo2
        RfmlJakKGfnFJbZK0YYWRnqGlhZ6RiaWeobG5rFWRqZK+nY2Kak5mWWpRfp2CXoZFy5sZSz4
        LlhxquEmawPjBr4uRg4OCQETieVHuLoYuTiEBJYySqyZPpmti5ETKC4jcXJaAyuELSzx51oX
        G0TRW0aJud3/wBLCAr4SO7e9ZgGxRQTSJI4c3ssCUsQs0MgoMe92GztERzejxOM9u5hBqtgE
        DCW63naBreAVsJP4se4Q2CQWARWJnfN6mUBsUYEYiZWbX0PVCEqcnPmEBeRUTgELiQ/9KiBh
        ZgEziXmbHzJD2PISzVtnQ9niEreezGeawCg0C0n3LCQts5C0zELSsoCRZRWjSGppcW56brGh
        XnFibnFpXrpecn7uJkZgrG079nPzDsZLG4MPMQpwMCrx8H4odIoWYk0sK67MPcQowcGsJMKb
        aAUU4k1JrKxKLcqPLyrNSS0+xGgK9NtEZinR5HxgGsgriTc0NTS3sDQ0NzY3NrNQEuc9b1AZ
        JSSQnliSmp2aWpBaBNPHxMEp1cBoG5e90npbfcHWK8w5Z7RsOJ8uKe5nmR5lo9l5+dwC3ZB3
        3JcOrOHI6Jm03bOfr4Xhbn8337xJCvcK1D5nHG6T/yKasHJK8vyTM5iYLKb8Ulh4kkfn0m/R
        gxt1nXpap8gubLhoOJXbxT2rtrw0dPtZhT+84o53bUy+3pOUe78z+as687op6V+VWIozEg21
        mIuKEwFxuuzAywIAAA==
Message-Id: <20180709133215eucas1p138cd9714d802a446973ce90058ef0afb~-tpG-E94E1650416504eucas1p1I@eucas1p1.samsung.com>
X-CMS-MailID: 20180709133215eucas1p138cd9714d802a446973ce90058ef0afb
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20180709125425epcas1p2343265d3a6a826b2ace0ef584d062dac
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180709125425epcas1p2343265d3a6a826b2ace0ef584d062dac
References: <CGME20180709125425epcas1p2343265d3a6a826b2ace0ef584d062dac@epcas1p2.samsung.com>
        <20180709125402.32427-1-broonie@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

On 2018-07-09 14:54, Mark Brown wrote:
> In some cases a device may end up supplying itself, for example when a
> DCDC is used to improve the efficiency of LDOs or when a LDO is provided
> to clean up sensitive supplies.  In these cases the driver core will
> warn loudly about attempts to add links so suppress them here.
>
> Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>
> Compile tested only.

This patch doesn't help, because wm8994 creates separate struct device for
each registered regulator, so you need to check the regulator parents too,
see my fixes below in the patch.

I don't like such fixes for this specific case. It's not that uncommon
that a complex device provides various functionalities used by its
components, so it is not a bad design to use regulator provided by
its parent/grandparent/other ancestor device.

Frankly, either the device_is_dependent() function should be exported and
used in regulator core or device_link_add() should have another flag:
DL_FLAG_SKIP_DEPENDANT.

>   drivers/regulator/core.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
> index b5db0257bc40..1302e66e80ac 100644
> --- a/drivers/regulator/core.c
> +++ b/drivers/regulator/core.c
> @@ -1741,7 +1741,8 @@ struct regulator *_regulator_get(struct device *dev, const char *id,
>   			rdev->use_count = 0;
>   	}
>   
> -	device_link_add(dev, &rdev->dev, DL_FLAG_STATELESS);
> +	if (dev != &rdev->dev)

    if (dev != &rdev->dev && dev != rdev->dev.parent)

> +		device_link_add(dev, &rdev->dev, DL_FLAG_STATELESS);
>   
>   	return regulator;
>   }
> @@ -1840,7 +1841,7 @@ static void _regulator_put(struct regulator *regulator)
>   			if (r->dev == regulator->dev)
>   				count++;
>   
> -		if (count == 1)
> +		if (count == 1 && regulator->dev != &rdev->dev)

    if (count == 1 && regulator->dev != &rdev->dev &&
                     regulator->dev != rdev->dev.parent)

>   			device_link_remove(regulator->dev, &rdev->dev);
>   
>   		/* remove any sysfs entries */

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

