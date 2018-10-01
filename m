Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,FORGED_MUA_MOZILLA,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32132C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 13:13:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C51E52089A
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 13:12:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="gHRBmxdU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C51E52089A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=partner.samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729286AbeJATun (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 15:50:43 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:50204 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729182AbeJATun (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 15:50:43 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20181001131256euoutp0249dee6ea92bc89b1b55af3ec48b65b54~ZfkOCdJzS2498124981euoutp02E
        for <linux-kernel@vger.kernel.org>; Mon,  1 Oct 2018 13:12:56 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20181001131256euoutp0249dee6ea92bc89b1b55af3ec48b65b54~ZfkOCdJzS2498124981euoutp02E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1538399576;
        bh=+1z/PGuQIfcSuRYv8m9CeKWRNnoGWTPrE/7SkV1isfA=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=gHRBmxdUwDnQjCo3yDmddkvR9arvfcu+4V+ANRBTvIeQFL+BmMzCVjZT8agGr+ej4
         sCDrsz6ejNB8LE9V3viebD+Jm+2IdXZaSjmyWBzkaW5Zx5w+RyMWlPwd9TIgdtwqVq
         3ftNC8fbdZKJvGmB0wokVI9GNHkjWNCGzQTmV2Y0=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20181001131255eucas1p24c9943697e09b0fc17a27c2f82aced2e~ZfkNNdYTS1170611706eucas1p2l;
        Mon,  1 Oct 2018 13:12:55 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 73.21.04294.65D12BB5; Mon,  1
        Oct 2018 14:12:54 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20181001131254eucas1p2ae0390483d52f18e37b9550a59da52aa~ZfkMUwYnn1170611706eucas1p2k;
        Mon,  1 Oct 2018 13:12:54 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20181001131253eusmtrp2b72889e13a484e45ed1bdff9ba87948d~ZfkMC1TXu1382713827eusmtrp2N;
        Mon,  1 Oct 2018 13:12:53 +0000 (GMT)
X-AuditID: cbfec7f4-835ff700000010c6-2a-5bb21d5669cf
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 9A.C5.04128.55D12BB5; Mon,  1
        Oct 2018 14:12:53 +0100 (BST)
Received: from [106.120.51.30] (unknown [106.120.51.30]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20181001131253eusmtip22ae64940a9fa22ef8a5d219afe5d73f4~ZfkLbqnNu0741107411eusmtip2K;
        Mon,  1 Oct 2018 13:12:53 +0000 (GMT)
Subject: Re: [PATCH v2 1/7] arm64: move arm uprobes code to be reused by
 arm64
To:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     linux@armlinux.org.uk, oleg@redhat.com, catalin.marinas@arm.com,
        will.deacon@arm.com, peterz@infradead.org, mingo@redhat.com,
        acme@kernel.org, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org, b.zolnierkie@samsung.com,
        m.szyprowski@samsung.com, k.lewandowsk@samsung.com
From:   Maciej Slodczyk <m.slodczyk2@partner.samsung.com>
Date:   Mon, 1 Oct 2018 15:12:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
        Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <0d10bc6d-5fb1-fac3-3d68-352b0cfd4af2@arm.com>
Content-Language: pl
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sa0hTYRju2zk7O1tOjtPwxS7KqB9J2k3yhCIFQafox/KHZCtq1clKp7Lj
        vBSRCw0dKSnpUkytZNYwlvOa1bThLc0uWjpRK1QwrSnefhhquR0r/z3v87yX5/n4SEw2IfQh
        L8cmsJpYVYyckOC1rQvvAyI2W5S7rOb9tP5LPUFnWAqEdOU9s5CeMt5GdEvXkoDWzdzHaMtI
        r5DuaSgiaFveK0Q/bR4S0d1NpQL6prEGp2sa0xHdltUkoAsGBhA9Pt2OH6CYiuIKxPT0fsSY
        qsf+jMWUSTDFb44zVWU3mCnrZ4LJrjYhZtayRSE+KQm9wMZcTmQ1O8POSi4N2w2i+EosufzX
        LJGKOgR6JCaBCoIOR7FQjySkjHqMIHduRMQXcwhqH3YhvphFMFneIPo30teJ80I5glJdJcEX
        DgT9FS3I2eVJKeCReRRzYi+Kg17HW8zZhFEWAeRNNONOgaCCoa4lzYVxaiv037a48AbqBDR/
        e+BaJKU84E3BqIsXUyHw84nB5RyjvMA+nIZ47At1jiLXAaCySBju+irihxPhrjUH530fggXT
        tJDHnjDRVr2aZxP8fl6y+hxJ8KK9X8QvSkOQp2taFUJg0ZSzkpNcubYdzA07efog6PWDyEkD
        5Q52hwfvxx1yaw0YT0sh45aM7w6AV79SV91shM+6fMEdJC9ck7JwTbLCNckK/98tRbgJebNa
        Th3Fcnti2aRATqXmtLFRgefj1Ba08gM7l9vm6lHD4jkbokgkd5MqbGalTKhK5FLUNgQkJveS
        hn96ppRJL6hSrrKauDMabQzL2dBGEpd7S43FlUoZFaVKYKNZNp7V/FUFpNgnFeWSEWGLzw7v
        yIhONARnZ303Sq8sqsPTfazjXe+0yVjJB9/2IDeP80dnJIYNfZ0hfdfG9s5fz5qwn2rFTweL
        f1sjBss8M23njkTW1DOhk8LO/CHtfKTGw+d1t2MoTtG6fIvwW0cqlBePvSTGRpK2ddh/JKVj
        ++SNqTG69TVLtX5ynLuk2u2PaTjVH136++N9AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrNIsWRmVeSWpSXmKPExsVy+t/xe7qhspuiDXovWVt03dvBZtGxaSar
        xcYZ61kt3i/rYbQ4evYvk0Xjp7nMFpseX2O1uLxrDpvFoal7GS3WHrnLbnHpwAImi6ZlW1ks
        tu5vZbQ43nuAyWLm7duMFi8/nmBxEPBYM28No8flaxeZPTav0PLYtKqTzWPeyUCPzUvqPd7v
        u8rm0bdlFaPH501yAZxRejZF+aUlqQoZ+cUltkrRhhZGeoaWFnpGJpZ6hsbmsVZGpkr6djYp
        qTmZZalF+nYJehmPbkxnL9jIXLH812e2BsZTTF2MnBwSAiYSp66fZgGxhQSWMkp82C0DEZeW
        OPl2ExuELSzx51oXkM0FVPOaUaL3bDsrSEJYwE9i6bRnYM0iAsUSR+/uYAcpYhbYxCRxZfk6
        doips5gk/s2KB7HZBMwlth9tAWvgFXCTeH7/JdggFgEViZs9m8DiogIREquXv2CFqBGUODnz
        CVicU8Ba4s3K6WBXMwuYSczb/JAZwhaRuPGohRHClpfY/nYO8wRGoVlI2mchaZmFpGUWkpYF
        jCyrGEVSS4tz03OLjfSKE3OLS/PS9ZLzczcxAiN+27GfW3Ywdr0LPsQowMGoxMMbcGh9tBBr
        YllxZe4hRgkOZiUR3qArG6KFeFMSK6tSi/Lji0pzUosPMZoCPTeRWUo0OR+YjPJK4g1NDc0t
        LA3Njc2NzSyUxHnPG1RGCQmkJ5akZqemFqQWwfQxcXBKNTBK/Pw9/8Lc8+0f2xjPvX4Ucu/g
        ++eCXqWC68qymeNCmo9VHlTV4vtiE66w64jZmaKlJSln1f57HL5RYdqg+uRyU4v9cYvH0+5s
        uJc/11HY57GB2JRf+XpbLwYIPnsTvOqp7XK+Gf+fXVx9K8ndfsMcmSv3VHzf2ZfLntg6ffPd
        K9rn2uXnPErxVGIpzkg01GIuKk4EABA0SKUOAwAA
Message-Id: <20181001131254eucas1p2ae0390483d52f18e37b9550a59da52aa~ZfkMUwYnn1170611706eucas1p2k@eucas1p2.samsung.com>
X-CMS-MailID: 20181001131254eucas1p2ae0390483d52f18e37b9550a59da52aa
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20180926121214eucas1p2b262936ddd96980b7b4369f16b52c6ce
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180926121214eucas1p2b262936ddd96980b7b4369f16b52c6ce
References: <1537963925-25313-1-git-send-email-m.slodczyk2@partner.samsung.com>
        <CGME20180926121214eucas1p2b262936ddd96980b7b4369f16b52c6ce@eucas1p2.samsung.com>
        <1537963925-25313-2-git-send-email-m.slodczyk2@partner.samsung.com>
        <0d10bc6d-5fb1-fac3-3d68-352b0cfd4af2@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 29.09.2018 11:37, Suzuki K Poulose wrote:
> following nit:
> 
> The subject tag looks incorrect. Since this patch moves the ARM
> code around and has nothing to do with arm64 (yet). So, the subject
> could be :
> 
> ARM: move uprobes code to be reused by arm64
> 
> which could allow the concerned arm people to check this patch.

Hi,

Thank you for the review. I'll adjust subject tags in v3.

Thank you,
Maciej
