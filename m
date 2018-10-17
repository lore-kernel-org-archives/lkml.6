Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FORGED_MUA_MOZILLA,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B12A8ECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 12:36:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69A6421526
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 12:36:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="E+w+KISO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69A6421526
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727267AbeJQUb4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 16:31:56 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:59674 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727050AbeJQUb4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 16:31:56 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20181017123624euoutp013326937361e972a58661bce9354feeff~eZY5jRohy0955109551euoutp01f
        for <linux-kernel@vger.kernel.org>; Wed, 17 Oct 2018 12:36:24 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20181017123624euoutp013326937361e972a58661bce9354feeff~eZY5jRohy0955109551euoutp01f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1539779784;
        bh=VqHDJ0kWF1i0fAhJNciL2LUVkvutwCzVC0E9Vq/6qhM=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=E+w+KISOyWb5YZnq04UJcU39f4KEKYMbE/ShaJ0fyPZegsnfDtkMJc5T1F4g0gJ9w
         JmP9qifgFmpY63lsiigDTiveXD9JZSaydxYYfq3Bp2B9ZL8+DYZphmEN9dljkLQ784
         FzQHgFuDXdkY0TDg73+45anqFGtI0Zqa9mcsINvs=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20181017123623eucas1p11671bdd6448c424e33cc0955f3a141af~eZY4iMm6p0422004220eucas1p1N;
        Wed, 17 Oct 2018 12:36:23 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 05.82.04294.7CC27CB5; Wed, 17
        Oct 2018 13:36:23 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20181017123622eucas1p14654c89a8590fd094d638b60ab9af8f0~eZY3j27rs0422004220eucas1p1M;
        Wed, 17 Oct 2018 12:36:22 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20181017123622eusmtrp17066a6343957f1a340281cf3725fdb53~eZY3iTCfu3081930819eusmtrp10;
        Wed, 17 Oct 2018 12:36:22 +0000 (GMT)
X-AuditID: cbfec7f4-835ff700000010c6-90-5bc72cc75b39
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 90.38.04284.6CC27CB5; Wed, 17
        Oct 2018 13:36:22 +0100 (BST)
Received: from [106.116.147.30] (unknown [106.116.147.30]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20181017123621eusmtip10086f9783335795aaab08706fb03b248~eZY25afyA0741607416eusmtip1g;
        Wed, 17 Oct 2018 12:36:21 +0000 (GMT)
Subject: Re: [PATCH v2 3/6] clocksource: exynos_mct: Add arch_timer
 cooperation mode for ARM64
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Inki Dae <inki.dae@samsung.com>, nd@arm.com
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Date:   Wed, 17 Oct 2018 14:36:21 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
        Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181015132652.3vanslay7xomtzqh@lakrids.cambridge.arm.com>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA01Se0hTcRTut9+9293Y7Nc0PZgaDSqyshYSlxQpirhEoUQRtaJWXlbo1thN
        SwkUCq01p1iRjmXvtGGWy9RWCCm50tp8lI+S/ENJkuyBUmr2cLs9/O873znf+b4Dh8HqV3Qk
        c8h0hLeY9OkaqYKqbZ7wL/cu8+pWjj+MZKtL7tDsp5s2xHaPDdFs2Wg0W9xfRLF+/10Z6x7o
        otlOj1PKlvgbJOyPvp9S9kZ3u4R9Xm7D7D33ecy+//KUWhvCVZZVIs7tOi3l+roeSbmPPp+M
        u3c9h7PXuBA36o5Jke1SJKby6YcyecuKpH2Kg08awNwz+9ivges4FzUorUjOAImHW64XlBUp
        GDWpQNDb4qPFYgxBXcdFLBajCPpK7eiv5NqwjQpgNSlH8NapFIc+IXg6dZsONELJPhjKa5MG
        cBhZDDbPWNADk2EMhZ1FONCQEi1YR6zBIYoshHct56Z5hplLdsN3T0KAVpE58Kx0MGgmJxy8
        +XwmuB+T+VA34sQijoDXg5ckgf1ARmRQfNcmE8WZ0G8vkIqpN8ADVwUWcSgMe2tkIo6C1rM2
        ShSfQJBf4pCJhQ3BfWf9H3UCNHnb6UA6TJbAHc8KkV4H33ovogANJAR6RuaIgUKguPYCFmkV
        nMpTi9OLwOGt+mf7uK0DFyGNY8aZjhmnOWac5vjvexlRLhTBZwhGAy+sMvFH4wS9UcgwGeIO
        HDa60fSztf70jtUjz9T+RkQYpFGq6sObdWpanylkGRsRMFgTpspe4NWpVan6rGzecnivJSOd
        FxrRPIbSRKhullXr1MSgP8Kn8byZt/ztShh5ZC7SMWxOvuF8yy75jvXaPc8SjIMnV2vTClqj
        zUs3l26hh3xMa0Fh7LbkjKKdydtjhtaMx0xVzx/olEuqznSlpPiuLh5/mfjhzcZuZVXe8dje
        lK+F9glr9Kb4efGnKyaT9nc5lZOzQpjkqKaIPk4If+57fCVXW2devtQlmH8JuGfrRw0lHNRr
        Y7FF0P8GiM0AFmgDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrBIsWRmVeSWpSXmKPExsVy+t/xu7rHdI5HG1xtVrbYOGM9q8X7ZT2M
        Fte/PGe1mPdZ1mLS/QksFufPb2C32PT4GqvF5V1z2CxmnN/HZPH3zj82i6XXLzJZnFnew2yx
        edNUZouXH0+wOPB5rJm3htFj06pONo871/awebw7d47dY/OSeo++LasYPT5vkgtgj9KzKcov
        LUlVyMgvLrFVija0MNIztLTQMzKx1DM0No+1MjJV0rezSUnNySxLLdK3S9DLOLpPouAGf8X/
        x0uYGxj38XQxcnJICJhILH7Vw9LFyMUhJLCUUaL53TVWiISMxMlpDVC2sMSfa11sILaQwFtG
        iYWd3iC2sECCxPO2C2BxEQF1iZ5dX8AGMQu8YZb48XgHO8TURiaJvzengFWxCRhKdL2FmMQr
        YCexomca2AYWAVWJZ6emMIPYogIxEkcnt0DVCEqcnPmEBcTmFPCQuP2hG6yeGWjbn3mXmCFs
        eYntb+dA2eISt57MZ5rAKDQLSfssJC2zkLTMQtKygJFlFaNIamlxbnpusaFecWJucWleul5y
        fu4mRmAsbzv2c/MOxksbgw8xCnAwKvHw7hA7Fi3EmlhWXJl7iFGCg1lJhLdK8Xi0EG9KYmVV
        alF+fFFpTmrxIUZToOcmMkuJJucD00xeSbyhqaG5haWhubG5sZmFkjjveYPKKCGB9MSS1OzU
        1ILUIpg+Jg5OqQbG1A+/gpUe+b/tSC3+f9Yjfd6/k5M/P+A/p3VJTTPl1mErESfriVvP3tlz
        O928b+Xa/LaXp2OVlO4Evl0cUly7/PBdnbdTs5dZL7PZ+lO2VWEN459NiTxfbMUZLxyYfWAJ
        q73MUdekcPep+TPYFnn9NJoe8X3qjlcLEpcoqh6SrBf0e6p+4oWcnBJLcUaioRZzUXEiACAB
        ELv7AgAA
Message-Id: <20181017123622eucas1p14654c89a8590fd094d638b60ab9af8f0~eZY3j27rs0422004220eucas1p1M@eucas1p1.samsung.com>
X-CMS-MailID: 20181017123622eucas1p14654c89a8590fd094d638b60ab9af8f0
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20181015123135eucas1p16a10ed68040141a714ab2977e2ad5e2d
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181015123135eucas1p16a10ed68040141a714ab2977e2ad5e2d
References: <20181015123112.9379-1-m.szyprowski@samsung.com>
        <CGME20181015123135eucas1p16a10ed68040141a714ab2977e2ad5e2d@eucas1p1.samsung.com>
        <20181015123112.9379-4-m.szyprowski@samsung.com>
        <20181015132652.3vanslay7xomtzqh@lakrids.cambridge.arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

On 2018-10-15 15:26, Mark Rutland wrote:
> On Mon, Oct 15, 2018 at 02:31:09PM +0200, Marek Szyprowski wrote:
>> To get ARM Architected Timers working on Samsung Exynos SoCs, one has to
>> first configure and enable Exynos Multi-Core Timer, because they both
>> share some common hardware blocks.
> Could you please elaborate on what exactly is shared with the MCT?
>
> Architecturally, the OS shouldn't have to do anything to put the timers
> into a usable state. All instances should be fed (directly) from the
> system counter, which FW is tasked with configuring and enabling, and
> all other state is private to the instance.
>
> If we have to poke things to make them usable, that means we can't
> assume that it's always safe to use the timers or counters, as the
> architecture lets us, and I'd like to understand what the impact is.
>
> e.g. does this mean that there are windows where the counters don't
> tick?

Good question is always a helpful advice. I don't have such hardware
details and I've did my patches basing on what I've observed while
playing with the hardware.

I've checked again and I found that the only things that need to be
done to get ARM arch timer working are:

1. enable multi core timer clock,
2. set MCT_G_TCON_START (Timer enable) bit in MCT_G_TCON (Global timer
control) register.

Otherwise arch timer doesn't get any tick.

Changing CPUHP priorities nor any other MCT register writes are not
needed. It looks that they were leftovers from my older approaches
and I've kept them without really checking if they are needed in the
final version.

I will send a new simplified version of this patchset then.

> Are all the counters fed the same underlying counter value? ... or are
> those independent?

My summary above suggests that ARM architected timers are fed from the
physical counter, which is controlled by MCT registers.

> ...

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

