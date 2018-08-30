Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FORGED_MUA_MOZILLA,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 421F4C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 13:27:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECBC92073D
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 13:27:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="W5S0iMII"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECBC92073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=partner.samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729042AbeH3R3o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 13:29:44 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:60174 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728865AbeH3R3o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 13:29:44 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20180830132734euoutp02bee0180fb97b2e0800fbe8e27af3ff9c~PrH3WieYa2817828178euoutp023
        for <linux-kernel@vger.kernel.org>; Thu, 30 Aug 2018 13:27:34 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20180830132734euoutp02bee0180fb97b2e0800fbe8e27af3ff9c~PrH3WieYa2817828178euoutp023
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1535635654;
        bh=ov/Y6Jp1uR/av87xaYzqcUY9UP5wH73TM0VnDA0e6Z0=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=W5S0iMIIdOlqtr3/JkvV80N7xu8rPamK+0XIRnuvjtHnGQhXpLljoZYc9bhTvqR6Z
         5WPCWxXm4SxZw8ykGAzeMngLM5UO5ysKJanST8XJ0w+Ti+3xx4t/QIVQlN7XwroXBg
         +vnaq0XsEbGyI+mH8BvoshOybfWkNmUi738qF1Cc=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20180830132733eucas1p17177293f264b5d520e1a9fab3d9f40ba~PrH2jubdB2407324073eucas1p1M;
        Thu, 30 Aug 2018 13:27:33 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 0B.0F.04441.5C0F78B5; Thu, 30
        Aug 2018 14:27:33 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20180830132732eucas1p12b941ed065276c0cbed6e7b1e01a30dc~PrH1zJtnY2603926039eucas1p1b;
        Thu, 30 Aug 2018 13:27:32 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20180830132732eusmtrp29618bdca321c90eacf00163f7a503698~PrH1yFcZS2986629866eusmtrp2z;
        Thu, 30 Aug 2018 13:27:32 +0000 (GMT)
X-AuditID: cbfec7f2-5c9ff70000001159-7b-5b87f0c5f167
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 4C.41.04128.4C0F78B5; Thu, 30
        Aug 2018 14:27:32 +0100 (BST)
Received: from [106.120.51.18] (unknown [106.120.51.18]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20180830132732eusmtip2d6eeeb3ed4a8bdd931b1e7ce9f1534be~PrH1b-EpY2315023150eusmtip2a;
        Thu, 30 Aug 2018 13:27:32 +0000 (GMT)
Subject: Re: Locking for HW crypto accelerators
To:     Krzysztof Kozlowski <krzk@kernel.org>, smueller@chronox.de
Cc:     herbert@gondor.apana.org.au, davem@davemloft.net,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Kamil Konieczny <k.konieczny@partner.samsung.com>
Date:   Thu, 30 Aug 2018 15:27:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
        Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAJKOXPd7JdzM2_PiHkS1ix1yU9hZmMbGDZaL07vbON0XzORH=w@mail.gmail.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sa0hTYRju29nlbLX1OQ1fVApW/nClZhecGVZgsCBIf0TlftTKs010U87x
        0oJAxLwFapZpQzPDMtdVWbOpkMxseMdbmKGGmKFhibNgGS23M8l/7+V5nwu8JCFt4AWRKYZM
        ijao02R8Edf63jUY3r1cqNrv/IAVNUP5XMXNxRDF0NArgWJm2sVRjLbV8BWVfc+5x/nKlbEx
        jtLS9JGjtHaGKlvMxXyls2VnAi9JdDSZSkvJpujIuEsiXcNyNT9jXnDVVmIR5KIxXgkSkoAP
        QbO5V1CCRKQUP0HwqfqGr1lF8Lhn1tc4EXSXOrgbJwPt/Rx20YjAPWXisc0Sgt9VdRwPyh9H
        wsJ4BeGpA3AcvC1b8AoSmAZT+VMvEx9Hw2xrvxfPxaEw0f3Ni9mBz8O7z/XIU4uxH/Tcm/Pi
        hTgRmhYn+SxPIEzOsVoE3gWtSzWExwRgswAqv5YS7HE2FK3V+mzHw7i1w5faHxYdFgFbh4Db
        xhIBzoH21/MCligfQe3th75FLHQ5htePyXW1MHjZFsmOT8Ca5TvyjAFLYGLJj/UjgQprFcGO
        xVBUIGXR4XDf3e9zEAwl7he8ciQzbUpp2pTMtCmZ6b/uA8Q1o0Aqi9FrKSbKQOVEMGo9k2XQ
        RlxJ17eg9d/p++tYeYN+jly2I0wi2Tbxlh+FKilPnc0Y9XYEJCELEIsGC1RScbLaeI2i0y/S
        WWkUY0fBJFcWKJbINSop1qozqVSKyqDojS2HFAblItzabHFsR5qlRk3PtCh1QvJlYdQ4fGBv
        8tnau0ZHne5YdEj9zJmRc66k+H21XTWSxMPFtnJ9/jODVf6rKGHl9J0B0a0/B49Q0tQ8beyq
        beuFwqlOTViOv84+n+ak97jo+OvqmEj/1o4Rm/DRiL3sVJ6u6GSvfNku6E5k5DG7ZVxGp46S
        EzSj/gfdrjD5NwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrGIsWRmVeSWpSXmKPExsVy+t/xe7pHPrRHG2y9oW4x53wLi0X3KxmL
        8+c3sFvcv/eTyeLyrjlsFlNPr2VxYPP4dOUKk8eWlTeZPLYdUPXYtKqTzePzJrkA1ig9m6L8
        0pJUhYz84hJbpWhDCyM9Q0sLPSMTSz1DY/NYKyNTJX07m5TUnMyy1CJ9uwS9jCUfZrAVPGOv
        2Nm1hb2B8QprFyMnh4SAicTZ3WeYuhi5OIQEljJK7NkzgxkiIS3ReHo1E4QtLPHnWhcbRNFr
        Ron+9ivsIAlhAX2Jl1cngTWICNhJ7O9/CTSVg4NZoEhieo8wRP1kJomJvz6xgdSwCZhLPNp+
        Bmwor4CbxLyZB8B6WQRUJW4cfQ12kahAhMTq5S9YIWoEJU7OfMICYnMKBEqsfHULbA6zgLrE
        n3mXmCFscYlbT+YzQdjyEtvfzmGewCg0C0n7LCQts5C0zELSsoCRZRWjSGppcW56brGRXnFi
        bnFpXrpecn7uJkZgnG079nPLDsaud8GHGAU4GJV4eBnet0cLsSaWFVfmHmKU4GBWEuHlOtcW
        LcSbklhZlVqUH19UmpNafIjRFOi5icxSosn5wBSQVxJvaGpobmFpaG5sbmxmoSTOe96gMkpI
        ID2xJDU7NbUgtQimj4mDU6qBsWmZ7KOdp1855e/LnqGwv+CErm15hOtyy6bNE0TnXvAVckn1
        Lu2qj7GwlFpWusN5897/G0rNcpQWCJu4r8oXYvu70e/w7SkaPqp2rZISJ67npnscnlBRZcSV
        rWqqsIrnzWW+maplexz1ZgbtvzB/fjqnQ8lhVcvzTab3n604vS3kdpGbb8EmJZbijERDLeai
        4kQABmdu2skCAAA=
Message-Id: <20180830132732eucas1p12b941ed065276c0cbed6e7b1e01a30dc~PrH1zJtnY2603926039eucas1p1b@eucas1p1.samsung.com>
X-CMS-MailID: 20180830132732eucas1p12b941ed065276c0cbed6e7b1e01a30dc
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20180830130922epcas1p35b0395da64de59107a805c6b99d770c2
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180830130922epcas1p35b0395da64de59107a805c6b99d770c2
References: <CAJKOXPfVXnazraHq-NCCM+h26FFi1U6Z3OSYOX17XH3bj-UDLQ@mail.gmail.com>
        <3053033.se6UkFii4W@tauon.chronox.de>
        <CGME20180830130922epcas1p35b0395da64de59107a805c6b99d770c2@epcas1p3.samsung.com>
        <CAJKOXPd7JdzM2_PiHkS1ix1yU9hZmMbGDZaL07vbON0XzORH=w@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30.08.2018 15:09, Krzysztof Kozlowski wrote:
> [...]
> Thanks Stephan for hints. Let's assume the each of init, update and
> final are atomic... but how about the relation between update and
> final? I have two concurrent users in user-space but only one HW:
> 
> Process A:             Process B:
> init() and set_key()
>                        init() and different key
> update(some_data)
>                        update(different_data)
> final()
>                        final()
> 
> The final() from process A will now produce the result of hashing/CRC
> of some_data and different_data (and even maybe mixed with init() for
> different key). All because in the meantime process B added its own
> data to the HW.
> 
> Best regards,
> Krzysztof
Can your hardware do export/import ?

If yes, you can use workqueue and guard HW with spinlock,
as in exynos hash in s5p-sss.c (or see other drivers).

-- 
Best regards,
Kamil Konieczny
Samsung R&D Institute Poland

