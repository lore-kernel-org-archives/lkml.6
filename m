Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53DF5C64EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 15:37:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05E3C20644
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 15:37:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="qtlHtyCu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05E3C20644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=partner.samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726946AbeJIWzM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 18:55:12 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:52524 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726415AbeJIWzM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 18:55:12 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20181009153740euoutp0118d4b2f72c7fc27584f3c74914270b2a~b_s4ZVRVA2736027360euoutp01U
        for <linux-kernel@vger.kernel.org>; Tue,  9 Oct 2018 15:37:40 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20181009153740euoutp0118d4b2f72c7fc27584f3c74914270b2a~b_s4ZVRVA2736027360euoutp01U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1539099460;
        bh=Z3+x3l9W4xm+lZ8DZw1OmeAPieFICVBuCckxpdPh7J0=;
        h=From:To:Cc:Subject:Date:References:From;
        b=qtlHtyCuOCSwQoJEJuENkelHRKw00dSeD/LGIAN6FRELRPE2hK0aw/BXui6xf7F9X
         7VsTHbIsEW+NrRujfbgK3mBNZTjFYmAFiR4mCDhCaKAzF3xW6S0OnNVvWYc5y7xCOS
         +uS1HWxao6h4L8f7CvWWI0pmBrrWrB9x283NcCHA=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20181009153740eucas1p1c8fc08565698dee2e0ed8df1835a1f7b~b_s39Qm773066630666eucas1p1r;
        Tue,  9 Oct 2018 15:37:40 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 87.DA.04294.34BCCBB5; Tue,  9
        Oct 2018 16:37:39 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20181009153739eucas1p2002c9e68cd25088e13135c69c611f386~b_s3LCHJk2226522265eucas1p27;
        Tue,  9 Oct 2018 15:37:39 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20181009153739eusmtrp16c7ed95e2200b1c81adc81381a3c08c1~b_s26JgIu0519405194eusmtrp1d;
        Tue,  9 Oct 2018 15:37:39 +0000 (GMT)
X-AuditID: cbfec7f4-835ff700000010c6-b7-5bbccb43ee9b
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id E6.74.04284.34BCCBB5; Tue,  9
        Oct 2018 16:37:39 +0100 (BST)
Received: from AMDC3778.DIGITAL.local (unknown [106.120.51.20]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20181009153738eusmtip2092eaa592d062a0f43ec9ce332bfc400~b_s2h9uJ00990009900eusmtip2d;
        Tue,  9 Oct 2018 15:37:38 +0000 (GMT)
From:   Lukasz Luba <l.luba@partner.samsung.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     l.luba@partner.samsung.com, b.zolnierkie@samsung.com,
        shawnguo@kernel.org, fabio.estevam@nxp.com
Subject: [PATCH] config: arm: mxs: remove PROVE_LOCKING from defconfig
Date:   Tue,  9 Oct 2018 17:37:31 +0200
X-Mailer: git-send-email 2.7.4
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrJIsWRmVeSWpSXmKPExsWy7djPc7rOp/dEG9z9a2OxccZ6VouNm2+z
        WNxqkLHY9Pgaq8XlXXPYLF5sEXdg89i0qpPNY/OSeo+N73YweRx8t4fJo2/LKkaPz5vkAtii
        uGxSUnMyy1KL9O0SuDIOTLnIVrCQs+LT3qnMDYwv2bsYOTkkBEwkHl+4ytbFyMUhJLCCUWLa
        7wfsEM4XRon3t9ayQjifGSXmH9nK3MXIAdbyYUolRHw5o8TKpb8QOmY37WEBKWIT0JPYsaoQ
        ZIWIgJvEjcYOJhCbWSBN4vuWHjYQWxgovv3CJhYQm0VAVaL30hdWiJPkJG6e62QGmSkhcJ1N
        ouvtTUaQBK9AmcT6B+eZIYpcJFa86WeCsIUlXh3fAvWPjMTpyT0sEHaxxNmOVWwQdo1E+8kd
        UDXWEoePX2QFuZNZQFNi/S59iLCjxKxp/1ghfuSTuPFWEOJkPolJ26ZDvc4r0dEmBFGtIbGl
        5wLUAWISy9dMgxruIdHz7T7YkUICsRJ/3t9jm8AoNwth1wJGxlWM4qmlxbnpqcVGeanlesWJ
        ucWleel6yfm5mxiBCeD0v+NfdjDu+pN0iFGAg1GJh3dG3u5oIdbEsuLK3EOMEhzMSiK8ott3
        RQvxpiRWVqUW5ccXleakFh9ilOZgURLnXTZvY7SQQHpiSWp2ampBahFMlomDU6qBscrwWpad
        eGewN2/01Uesv7LFJOc+Ubn//NWdX/MV51zJ6LE5wrV4luiqAu2vczgmxfyf8SI/Wd3z824n
        20WC8m9Ulp1ZaNhxa9nfN541okdjtze22ogzKJ7UOHdxglLywSXOwrtfFBj6+Yq7vRa2vFZU
        pjJB7+KCYuaXbhOnPcgWUFM0jF5TrsRSnJFoqMVcVJwIABStF1v8AgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrALMWRmVeSWpSXmKPExsVy+t/xe7rOp/dEG0y+y2axccZ6VouNm2+z
        WNxqkLHY9Pgaq8XlXXPYLF5sEXdg89i0qpPNY/OSeo+N73YweRx8t4fJo2/LKkaPz5vkAtii
        9GyK8ktLUhUy8otLbJWiDS2M9AwtLfSMTCz1DI3NY62MTJX07WxSUnMyy1KL9O0S9DIOTLnI
        VrCQs+LT3qnMDYwv2bsYOTgkBEwkPkyp7GLk4hASWMoosXbVaZYuRk6guJjEpH3b2SFsYYk/
        17rYIIo+MUrMezybCaSZTUBPYseqQpAaEQEPibZ/95hBbGaBLImXPVNYQWxhATeJ7Rc2gc1k
        EVCV6L30BSzOK+ApsaT3DjPEfDmJm+c6mScw8ixgZFjFKJJaWpybnltsqFecmFtcmpeul5yf
        u4kRGHrbjv3cvIPx0sbgQ4wCHIxKPLwz8nZHC7EmlhVX5h5ilOBgVhLhFd2+K1qINyWxsiq1
        KD++qDQntfgQoynQ8onMUqLJ+cC4yCuJNzQ1NLewNDQ3Njc2s1AS5z1vUBklJJCeWJKanZpa
        kFoE08fEwSnVwCi9UGfLpcBFyyuCJq6Z9kCoyv3969JrlcvLX8x7bLNghnhHo5Gqkd+LaWqf
        XHb9YrxvcvfkqlebP2fx8f1ZKps+efL7NVycK6pCptg9bWksiLNX3iOTdCVknuXhGK5tEnzu
        bPs+8Mu4OjuW96x+sE9QZE4235eVVT89Y6c+LL66Y4NTr/r+B7uVWIozEg21mIuKEwG3cq3w
        UwIAAA==
Message-Id: <20181009153739eucas1p2002c9e68cd25088e13135c69c611f386~b_s3LCHJk2226522265eucas1p27@eucas1p2.samsung.com>
X-CMS-MailID: 20181009153739eucas1p2002c9e68cd25088e13135c69c611f386
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20181009153739eucas1p2002c9e68cd25088e13135c69c611f386
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181009153739eucas1p2002c9e68cd25088e13135c69c611f386
References: <CGME20181009153739eucas1p2002c9e68cd25088e13135c69c611f386@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PROVE_LOCKING enables LOCKDEP, which causes big overhead on cache and
bus transactions.

On some ARM big.LITTLE architecutres (Exynos 5433) the overhead is really big.
The overhead can be measures using hackbench which will speed up
by x3 times (11sec -> 3.4sec).
When you check transaction on cache or buses, the results are way higher
than normal for the same hackbench test:
L1d cache invalidations: 26mln vs 4mln
L2u cache invalidations: 42mln vs 12mln
bus cyc/access: 30cyc/access vs. 20cyc/access
context switch is x3 times cheaper

Enable this option only when you have some locking issue to investigate.

Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
---
 arch/arm/configs/mxs_defconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/configs/mxs_defconfig b/arch/arm/configs/mxs_defconfig
index 7b82128..22c9a8d 100644
--- a/arch/arm/configs/mxs_defconfig
+++ b/arch/arm/configs/mxs_defconfig
@@ -170,7 +170,6 @@ CONFIG_UNUSED_SYMBOLS=y
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_DEBUG_KERNEL=y
 CONFIG_SOFTLOCKUP_DETECTOR=y
-CONFIG_PROVE_LOCKING=y
 CONFIG_BLK_DEV_IO_TRACE=y
 CONFIG_STRICT_DEVMEM=y
 CONFIG_DEBUG_USER=y
-- 
2.7.4

