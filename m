Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,FORGED_MUA_MOZILLA,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 643C1ECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 15:47:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1116020883
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 15:47:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="atYj9hrH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1116020883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=partner.samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729374AbeIQVPZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 17:15:25 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:40953 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728409AbeIQVPZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 17:15:25 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20180917154729euoutp02faa43c4e6c9627fe8b701e2691a90719~VOpKUfDLF0064500645euoutp02o
        for <linux-kernel@vger.kernel.org>; Mon, 17 Sep 2018 15:47:29 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20180917154729euoutp02faa43c4e6c9627fe8b701e2691a90719~VOpKUfDLF0064500645euoutp02o
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1537199249;
        bh=bOcEP/oLH1YgqNSsOvMtCk5AFKqswcuMjqT14BzrzLM=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=atYj9hrHKuaLysVOgF0v+iIg+tpOzpkjFtCw1G2NxGJ/jmXOngGUPmb591PVwpDUF
         Y12+a9u9NzMPVWejoyWWjoZnqBiBY6jCIrnX5/ka2VMhgyP4RZQSTuKHJBGzuvoA08
         1RG3UIFUb/prErBnhAzEB6dQUGEzh+4b1B3AAIJY=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20180917154727eucas1p26eaac8d054cb774cb48dbc18d0a581c5~VOpJTSXx22008020080eucas1p2n;
        Mon, 17 Sep 2018 15:47:27 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 12.80.04441.F8CCF9B5; Mon, 17
        Sep 2018 16:47:27 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20180917154726eucas1p18eb2e915a45177d5cd7a192278eacc48~VOpH40eWM2730527305eucas1p1o;
        Mon, 17 Sep 2018 15:47:26 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20180917154726eusmtrp26ee5ac4df470f68e8f797fba358cd61b~VOpHnxRPO0381703817eusmtrp2F;
        Mon, 17 Sep 2018 15:47:26 +0000 (GMT)
X-AuditID: cbfec7f2-5c9ff70000001159-33-5b9fcc8fe3bf
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 3E.5C.04284.E8CCF9B5; Mon, 17
        Sep 2018 16:47:26 +0100 (BST)
Received: from [106.120.51.18] (unknown [106.120.51.18]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20180917154725eusmtip27058124a012294de1b64edce071ca0ad~VOpHOR7iq3230832308eusmtip2_;
        Mon, 17 Sep 2018 15:47:25 +0000 (GMT)
Subject: Re: [PATCH v2 1/4] crypto: s5p-sss: Fix race in error handling
To:     Christoph Manszewski <c.manszewski@samsung.com>,
        linux-crypto@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
From:   Kamil Konieczny <k.konieczny@partner.samsung.com>
Date:   Mon, 17 Sep 2018 17:47:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
        Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180917151006eucas1p2226806b94605b061bc1bc3e9b5a6c495~VOIhXssSK0729007290eucas1p25@eucas1p2.samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTYRjHec9lO5Mmx2n4oFIx05jkDYROJFIguI+BIOKwWnq8oFPZ8R6B
        oLVSu9jNNc15wUrBS94vWOJtLZfDS5BSKmmF1j7kMlDT5fEo+e33Pv/n+T//B14Kl3WSHlRy
        WiarTVOnykVORNfYxoT/PYtRFVRVcJJ5pW8hGVN/PWIqrUUEU7LqxVitrWJmYX4DY6b7KkWM
        3voaYxybhfh5ibKjYRZTdg36KNsab4uUOzWPCOXdjkaktLcduyiKcQqNZ1OTs1ltYNgVpyTj
        6hCZ4SBzP+kmxAVomyhGEgroEFhuH95jGf0SQW/hdYF/I/huPlGMnHbZjmCtvlF0MNAw8wYT
        hBcIlprM+w8bAsdcLc53udIRUGdYFPPsRkfCDfu4mG/C6SoMSkdn96xE9Bn40m3BeCZoH9DN
        D+zxUToaRhZrEM9S2gXMT5d381GUhM6BTWsqX8Zpd5hbNmICH4duWyXO+wP9Tgz1K3ZcmM2G
        Mp0eE2KHwx97p1hgV1g1deyzFzh6jfs9OdDf+U0sGBUhePawdl84B8OmSZIPgdMKaOkL5BHo
        CzBTmCugM3y0uQhxnOFBVzkulKVw66ZM8PCHKoeFFNgTih3N5H0kNxy60XDoMMOhwwz/11Yj
        ohG5s1mcJpHlgtPYnABOreGy0hID4tI1bWj3M43vmNZ60PrU1SFEU0h+RFpdbVTJSHU2l6cZ
        QkDhcjcp7rxbksar8/JZbfplbVYqyw0hT4qQu0ud/RJUMjpRncmmsGwGqz1QMUriUYC8vC0l
        tiVDc3lfaFQktiTaIiYTXj4uG8AzB5+MhBFrX09l7kD7tlJRGRz7S5pyJ1+bsUD2xvmsnxX5
        9r0N+flBPBWkcdl8fi3mh6Iip8lcYV7hSBeVXlFa0HraHqVTQfJY9cTfSN8JRXhsRPD61meJ
        scfmETRa9z7am52+JCe4JHWwH67l1P8AoGtQUEgDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrFIsWRmVeSWpSXmKPExsVy+t/xe7p9Z+ZHG7xZxGaxccZ6Vovju5cy
        Wsw538Ji0f1KxuL8+Q3sFvfv/WSyuLxrDpvFjPP7mCz+/2pmduD02LLyJpPHtgOqHptWdbJ5
        /Fs4hcWjb8sqRo/Pm+QC2KL0bIryS0tSFTLyi0tslaINLYz0DC0t9IxMLPUMjc1jrYxMlfTt
        bFJSczLLUov07RL0Mua/OsRa8J+14k77OfYGxr8sXYycHBICJhIrr+xn6mLk4hASWMoocWXx
        GyaIhLRE4+nVULawxJ9rXWwQRa8ZJeZu+gaWEBZwl1g86wE7iC0iECzx4MEMFpAiZoF5TBIH
        j7yBGtvBJHFp6gVmkCo2AXOJR9vPACU4OHgF3CS6zgaChFkEVCXa7+0FGyoqECGxevkLVhCb
        V0BQ4uTMJywg5ZwC5RK/zueAhJkF1CX+zLvEDGGLS9x6Mp8JwpaX2P52DvMERqFZSLpnIWmZ
        haRlFpKWBYwsqxhFUkuLc9Nziw31ihNzi0vz0vWS83M3MQLjcduxn5t3MF7aGHyIUYCDUYmH
        d8GC+dFCrIllxZW5hxglOJiVRHiZ+YBCvCmJlVWpRfnxRaU5qcWHGE2BfpvILCWanA9MFXkl
        8YamhuYWlobmxubGZhZK4rznDSqjhATSE0tSs1NTC1KLYPqYODilGhjzFoctYxF7WPhbjVnT
        YvPjprZpvRZas5ycz+25elu2jv3eb9+qN3IKEgHiT6pDbhdoNK186nf8bqeB3smZcRvYrgUx
        svmF3nnyT9+jyPXX5b2bJatTZR30LiwIS6+cvOY5d7nkHIfDPXYvnG+5MgqXbb/gWfq46cyq
        ibXMJ99GWs3rmm+z84kSS3FGoqEWc1FxIgAILd4S3QIAAA==
Message-Id: <20180917154726eucas1p18eb2e915a45177d5cd7a192278eacc48~VOpH40eWM2730527305eucas1p1o@eucas1p1.samsung.com>
X-CMS-MailID: 20180917154726eucas1p18eb2e915a45177d5cd7a192278eacc48
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20180917151006eucas1p2226806b94605b061bc1bc3e9b5a6c495
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180917151006eucas1p2226806b94605b061bc1bc3e9b5a6c495
References: <1537196970-5987-1-git-send-email-c.manszewski@samsung.com>
        <CGME20180917151006eucas1p2226806b94605b061bc1bc3e9b5a6c495@eucas1p2.samsung.com>
        <20180917151006eucas1p2226806b94605b061bc1bc3e9b5a6c495~VOIhXssSK0729007290eucas1p25@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 17.09.2018 17:09, Christoph Manszewski wrote:
> Remove a race condition introduced by error path in functions:
> s5p_aes_interrupt and s5p_aes_crypt_start. Setting the busy field of
> struct s5p_aes_dev to false made it possible for s5p_tasklet_cb to
> change the req field, before s5p_aes_complete was called.
> 
> Change the first parameter of s5p_aes_complete to struct
> ablkcipher_request. Before spin_unlock, make a copy of the currently
> handled request, to ensure s5p_aes_complete function call with the
> correct request.
> 
> Signed-off-by: Christoph Manszewski <c.manszewski@samsung.com>

Acked-by: Kamil Konieczny <k.konieczny@partner.samsung.com>

Thanks!
Kamil

-- 
Best regards,
Kamil Konieczny
Samsung R&D Institute Poland

