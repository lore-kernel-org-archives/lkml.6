Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79FB1C04AA5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 12:32:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33EC62145D
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 12:32:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="phOC8a6d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33EC62145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726653AbeJOUQn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 16:16:43 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:51529 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726515AbeJOUQm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 16:16:42 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20181015123136euoutp01cdb676658468bcf30f9e1cf1b6ced1b4~dyCID2asL0673906739euoutp01u;
        Mon, 15 Oct 2018 12:31:36 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20181015123136euoutp01cdb676658468bcf30f9e1cf1b6ced1b4~dyCID2asL0673906739euoutp01u
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1539606696;
        bh=hE4KIJfsgG80RlWzLC4i+vSpLTiGkNSGTs/k+EYthPI=;
        h=From:To:Cc:Subject:Date:In-reply-to:References:From;
        b=phOC8a6dSNWzc1Z2vqv+YrX8XXsKP2fi5rVT9pJnh+DUdkKAd36xiNy5QCaha3b12
         v28+gioR+drxNV02sKQoqkN9tl4HweYIZ+HTlgFN87+eQo28I7B5srw5xA4d/mVYG9
         g7zbkValw7R9pL7yTyQOpqMyJBkGOaLuYLZ+cgYY=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20181015123135eucas1p12a3f2190d4541140d8affa3a1ec722cc~dyCHjB8Eb1989019890eucas1p1l;
        Mon, 15 Oct 2018 12:31:35 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 1C.22.04441.7A884CB5; Mon, 15
        Oct 2018 13:31:35 +0100 (BST)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20181015123134eucas1p2bca15d1e0f54c0a580c04d9af7411f68~dyCG4vPtX3197531975eucas1p2d;
        Mon, 15 Oct 2018 12:31:34 +0000 (GMT)
X-AuditID: cbfec7f2-5c9ff70000001159-eb-5bc488a72289
Received: from eusync1.samsung.com ( [203.254.199.211]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 26.EE.04284.6A884CB5; Mon, 15
        Oct 2018 13:31:34 +0100 (BST)
Received: from AMDC2765.digital.local ([106.116.147.25]) by
        eusync1.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0 64bit
        (built May  5 2014)) with ESMTPA id <0PGN00GZC4490K70@eusync1.samsung.com>;
        Mon, 15 Oct 2018 13:31:34 +0100 (BST)
From:   Marek Szyprowski <m.szyprowski@samsung.com>
To:     linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Inki Dae <inki.dae@samsung.com>
Subject: [PATCH v2 1/6] clocksource: exynos_mct: Remove dead code
Date:   Mon, 15 Oct 2018 14:31:07 +0200
Message-id: <20181015123112.9379-2-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
In-reply-to: <20181015123112.9379-1-m.szyprowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrPIsWRmVeSWpSXmKPExsWy7djP87rLO45EG+z6yGexccZ6Vov3y3oY
        La5/ec5qMe+zrMWk+xNYLM6f38BusenxNVaLy7vmsFnMOL+PyWLtkbvsFn/v/GOz2LxpKrPF
        y48nWBx4PdbMW8PosWlVJ5vHnWt72DzenTvH7rF5Sb1H35ZVjB6fN8kFsEdx2aSk5mSWpRbp
        2yVwZVw9upet4CZ7xfndOxgbGDeydTFycEgImEgsuMrbxcjFISSwglFix9UNLBDOZ0aJA4fv
        scMU3frkBxFfxigxZc0FNgingUniXuMb1i5GTg42AUOJrrddbCC2iEC2ROfjB4wgNrPAImaJ
        A8eEQWxhAUeJH6vXMYHYLAKqEvu3HGIGsXkFbCRuLGljAbElBOQlVm84ABbnFLCVOPx/FdhF
        EgIH2CT+nN7FClHkInHi2xqoBmGJV8e3sEPYMhKdHQeZIBqaGSXaZ8xih3B6GCW2ztnBBlFl
        LXH4+EVWiPP4JCZtm84M8SevREebEESJh0RDy1RmiDcnMErMvjGZbQKj5AJGhlWM4qmlxbnp
        qcWGeanlesWJucWleel6yfm5mxiB0Xz63/FPOxi/Xko6xCjAwajEwyvAcyRaiDWxrLgy9xCj
        BAezkgivRMihaCHelMTKqtSi/Pii0pzU4kOM0hwsSuK8y+ZtjBYSSE8sSc1OTS1ILYLJMnFw
        SjUwrngiyFQdZXpjJl9BzLGj1fbdkps31bTv1y3xOT25n6upRGfezaMm3R5z9p4QE8lZsPtW
        St2XBu0HEYLi1/tLZ13z5D079woTW8fxj9MD76pMnbSvwUA94Lyqw41e77BAjtfnN77QX+Sv
        K8l3j2P7vaSsJqPC2A0LvXe2hv/uWRK2T55bI/W7EktxRqKhFnNRcSIAjdF2qOICAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrNLMWRmVeSWpSXmKPExsVy+t/xy7rLOo5EGxx8pWWxccZ6Vov3y3oY
        La5/ec5qMe+zrMWk+xNYLM6f38BusenxNVaLy7vmsFnMOL+PyWLtkbvsFn/v/GOz2LxpKrPF
        y48nWBx4PdbMW8PosWlVJ5vHnWt72DzenTvH7rF5Sb1H35ZVjB6fN8kFsEdx2aSk5mSWpRbp
        2yVwZVw9upet4CZ7xfndOxgbGDeydTFycEgImEjc+uTXxcjFISSwhFHi6K79TF2MnEBOE5NE
        xz4DEJtNwFCi620XG4gtIpAtMX9vNzuIzSywhFni5n0HEFtYwFHix+p1YL0sAqoS+7ccYgax
        eQVsJG4saWMBsSUE5CVWbzgAFucUsJU4/H8VC8QuG4kLx/4yTmDkWcDIsIpRJLW0ODc9t9hQ
        rzgxt7g0L10vOT93EyMwCLcd+7l5B+OljcGHGAU4GJV4eAV4jkQLsSaWFVfmHmKU4GBWEuGV
        CDkULcSbklhZlVqUH19UmpNafIhRmoNFSZz3vEFllJBAemJJanZqakFqEUyWiYNTqoExfFH7
        DbEvARoRRi8E7hkLtWW6WJV4MITf+HLBZJnMVtMf5+5rr52b9WXKaoNCycbULlH9+90Mmed3
        7FxfVherqJ2zflNCwJm9zPKtriGFZzW2bzi/NPVR1D6xSa9yNBInNv80bV67+fO8WZfEHWcb
        HJS5L/FaYa44k87Xr9eEVhR5fCu7sjZbiaU4I9FQi7moOBEAFHYTOT4CAAA=
X-CMS-MailID: 20181015123134eucas1p2bca15d1e0f54c0a580c04d9af7411f68
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181015123134eucas1p2bca15d1e0f54c0a580c04d9af7411f68
References: <20181015123112.9379-1-m.szyprowski@samsung.com>
        <CGME20181015123134eucas1p2bca15d1e0f54c0a580c04d9af7411f68@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Exynos Multi-Core Timer driver is used only on device-tree based
systems, so remove non-dt related code. In case of !CONFIG_OF
the code is anyway equal because of_irq_count() has a stub
returning 0.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/clocksource/exynos_mct.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/clocksource/exynos_mct.c b/drivers/clocksource/exynos_mct.c
index 7a244b681876..43b335ff4a96 100644
--- a/drivers/clocksource/exynos_mct.c
+++ b/drivers/clocksource/exynos_mct.c
@@ -581,11 +581,7 @@ static int __init mct_init_dt(struct device_node *np, unsigned int int_type)
 	 * timer irqs are specified after the four global timer
 	 * irqs are specified.
 	 */
-#ifdef CONFIG_OF
 	nr_irqs = of_irq_count(np);
-#else
-	nr_irqs = 0;
-#endif
 	for (i = MCT_L0_IRQ; i < nr_irqs; i++)
 		mct_irqs[i] = irq_of_parse_and_map(np, i);
 
-- 
2.17.1

