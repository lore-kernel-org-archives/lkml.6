Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94E72C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 15:16:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D50D20663
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 15:16:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="LCmrXvoW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D50D20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=partner.samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726567AbeK0CLH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 21:11:07 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:46499 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726224AbeK0CLH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 21:11:07 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20181126151640euoutp02432687d9dafe9e4d168957f26d100a9b~qtYQEd_uG2734327343euoutp02j
        for <linux-kernel@vger.kernel.org>; Mon, 26 Nov 2018 15:16:40 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20181126151640euoutp02432687d9dafe9e4d168957f26d100a9b~qtYQEd_uG2734327343euoutp02j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1543245400;
        bh=w4rKCnheD8CBfxlE7zkgkat4Cz8+clE3Vy2B/YcrC44=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=LCmrXvoWgbwx+N3egCt9B5WpRJmHNBk/k+vOUDZ8+KaUJ7r2EFCI2pABVyafD4+WS
         aGGrPdasW4VNzWDzwYnJQh9UXJH/DL/FHKcFNSNkhQM9B7w3YcSlAAQxHIYatekb4j
         QShN6huRif2JW2bK/cCB4L1k3ZMMXMwXfK35+7Z0=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20181126151640eucas1p2a20205797234db67ad681fd357b5b756~qtYPZbIy92482724827eucas1p2e;
        Mon, 26 Nov 2018 15:16:40 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id F4.55.04441.75E0CFB5; Mon, 26
        Nov 2018 15:16:39 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20181126151639eucas1p281190275a83edc65df2a060e8084d68a~qtYOasK7c2302623026eucas1p2z;
        Mon, 26 Nov 2018 15:16:39 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20181126151638eusmtrp177d3b4a416b97209eebceb221e2db725~qtYOL35pA2945329453eusmtrp1z;
        Mon, 26 Nov 2018 15:16:38 +0000 (GMT)
X-AuditID: cbfec7f2-5c9ff70000001159-5a-5bfc0e57db35
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 4D.66.04128.65E0CFB5; Mon, 26
        Nov 2018 15:16:38 +0000 (GMT)
Received: from [106.120.51.18] (unknown [106.120.51.18]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20181126151638eusmtip27ae5b7f12bd606c937be629078e78462~qtYNwRM9W0804308043eusmtip25;
        Mon, 26 Nov 2018 15:16:38 +0000 (GMT)
Subject: Re: [PATCH 4/4] clk: samsung: exynos5433: add imem clock
To:     Chanwoo Choi <cw00.choi@samsung.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Kamil Konieczny <k.konieczny@partner.samsung.com>
Message-ID: <d4dd53a5-fb87-34db-e3b6-2d8d05feb261@partner.samsung.com>
Date:   Mon, 26 Nov 2018 16:16:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <5BF5520A.5050500@samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrCKsWRmVeSWpSXmKPExsWy7djP87rhfH+iDV7NMLO4/uU5q8X8I+dY
        Lfofv2a2OH9+A7vFpsfXWC0u75rDZjHj/D4mi6XXLzJZtO49wu7A6bFm3hpGj02rOtk8Ni+p
        9+jbsorR4/MmuQDWKC6blNSczLLUIn27BK6Mj2cfMBY0sFasmHiNqYHxN3MXIyeHhICJRGP/
        OsYuRi4OIYEVjBIr9u5nhnC+MEpsm7mHFcL5zChxa/oJRpiWNX0PoKqWM0p8ujkVquoto8Se
        b/9ZQaqEBRwl5p38xQZiiwhoSMz8ewVsCbPADCaJNce+giXYBMwlHm0/wwRi8wq4SUw7uwzs
        KhYBVYl/lxvZQWxRgQiJjvur2SBqBCVOznzCAmJzCmhLLFy0BuwkZgFxiVtP5jNB2PISzVtn
        g50nIbCPXeLMjjksEHe7SPTteARlC0u8Or6FHcKWkTg9uQcqXi6xe+szdojmFkaJuZMXMUEk
        rCUOH78I9BoH0AZNifW79EFMCaAv/82qgDD5JG68FYQ4gU9i0rbpzBBhXomONiGIGboS8/6f
        YYWwpSW6/q9jncCoNAvJY7OQPDMLyTOzENYuYGRZxSieWlqcm55abJiXWq5XnJhbXJqXrpec
        n7uJEZiWTv87/mkH49dLSYcYBTgYlXh4N3z/HS3EmlhWXJl7iFGCg1lJhNd3CVCINyWxsiq1
        KD++qDQntfgQozQHi5I4bzXDg2ghgfTEktTs1NSC1CKYLBMHp1QDo9K0Yy7bPk2YW+tVrhin
        OfnWSv5trVysUucv2r3ujpXe1LrCOXrS2oPxtW37jX+qP9mpcT6robJCJXXen1nJ0a0LRI26
        AtbL7sp6/4jJ1NzHOHly4el0s6h7D49K9B9STlf0/aC16uffG7b6c6WP7+Scxvh/85bFNgFX
        Lv3aJH9DQD/+8ZSDGkosxRmJhlrMRcWJAI3vtR5HAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrBIsWRmVeSWpSXmKPExsVy+t/xe7phfH+iDX68MLG4/uU5q8X8I+dY
        Lfofv2a2OH9+A7vFpsfXWC0u75rDZjHj/D4mi6XXLzJZtO49wu7A6bFm3hpGj02rOtk8Ni+p
        9+jbsorR4/MmuQDWKD2bovzSklSFjPziElulaEMLIz1DSws9IxNLPUNj81grI1MlfTublNSc
        zLLUIn27BL2Mj2cfMBY0sFasmHiNqYHxN3MXIyeHhICJxJq+B0A2F4eQwFJGicv7pjFBJKQl
        Gk+vhrKFJf5c62KDKHrNKLHz5QsWkISwgKPEvJO/2EBsEQENiZl/rzCCFDELzGCSaD2/DGrs
        F0aJqzMPg+1jEzCXeLT9DNhYXgE3iWlnl4HFWQRUJf5dbmQHsUUFIiTOvlzHCFEjKHFy5hOw
        bZwC2hILF60BizMLqEv8mXeJGcIWl7j1ZD4ThC0v0bx1NvMERqFZSNpnIWmZhaRlFpKWBYws
        qxhFUkuLc9Nzi430ihNzi0vz0vWS83M3MQJjcduxn1t2MHa9Cz7EKMDBqMTDu+H772gh1sSy
        4srcQ4wSHMxKIry+S4BCvCmJlVWpRfnxRaU5qcWHGE2BnpvILCWanA9ME3kl8YamhuYWlobm
        xubGZhZK4rznDSqjhATSE0tSs1NTC1KLYPqYODilGhj7brrtZFjSEel7IKzp+qr9M5SyHaLL
        OPf8CZv6LHvu5Gx5sZ12KV7/5obeOhd+9syzF0zf02/9/pSzmf3IMeb5BxOeHmQs4l/wwDz+
        tVzxyfSPUR/cCnfcm3b1ifYe/zOBO96xXzTP+vmlJOxE3OznuWu15TzeNpgnzdOKW5nkpD5p
        EkuxgvhaJZbijERDLeai4kQAngqMnNsCAAA=
X-CMS-MailID: 20181126151639eucas1p281190275a83edc65df2a060e8084d68a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20181121120524eucas1p166a26857df78947c9e08f0fb8dbf75e4
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181121120524eucas1p166a26857df78947c9e08f0fb8dbf75e4
References: <20181121120509.18892-1-k.konieczny@partner.samsung.com>
        <CGME20181121120524eucas1p166a26857df78947c9e08f0fb8dbf75e4@eucas1p1.samsung.com>
        <20181121120509.18892-5-k.konieczny@partner.samsung.com>
        <5BF5520A.5050500@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> On 2018년 11월 21일 21:05, Kamil Konieczny wrote:
>> Add imem clock for exynos5433.
> 
> It is diffcult to understand the meaning of 'imem' without the description.
> Please add more detailed description as the patch2 description.
> [...]

Thank you for review, will this be enough for description:

Add imem clock for exynos5433. This will enable to use crypto Security
SubSystem (in short SSS) and SlimSSS IP blocks.

In documentation there is no description of "imem" name origin. I can guess
"mem" stand for "memory", and 'i' ? internal ?

-- 
Best regards,
Kamil Konieczny
Samsung R&D Institute Poland

