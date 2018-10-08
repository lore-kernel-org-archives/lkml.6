Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FB82C65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 12:50:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1919E2085B
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 12:50:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="rCn8Pokz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1919E2085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726642AbeJHUC1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 16:02:27 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:51685 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726523AbeJHUC0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 16:02:26 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20181008125051euoutp025c035a297db0e9ba1eba9c840fc57dad~box8LGLYQ2691626916euoutp02k;
        Mon,  8 Oct 2018 12:50:51 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20181008125051euoutp025c035a297db0e9ba1eba9c840fc57dad~box8LGLYQ2691626916euoutp02k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1539003051;
        bh=vVM6CC5JF82bvFsbKaZtHMXQsiBL3UIIS0wEGFQbXQo=;
        h=From:To:Cc:Subject:Date:In-reply-to:References:From;
        b=rCn8PokzVH9Tx/L/t2pRwqrJy3f2dMSyzmwlSKDXnxBeT+eKembNf+6mbdeKuOEBo
         XUhgueVAmAIbHD2JY4v0E8foA2SzJdrBznS0ipzoCAd+6AIKKNyh6gltE/kytTMbBE
         SF9sKUSmecXYSAr6W+0x2sFdRRjdRJRVdOkbk75M=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20181008125050eucas1p2aab3851201d1efb7be4b9b7bd9504ab0~box7mWxAD1878618786eucas1p2G;
        Mon,  8 Oct 2018 12:50:50 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 61.E2.04441.AA25BBB5; Mon,  8
        Oct 2018 13:50:50 +0100 (BST)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20181008125050eucas1p1caae30a4e791190e6c731816e36832ab~box64h10a1752717527eucas1p1d;
        Mon,  8 Oct 2018 12:50:50 +0000 (GMT)
X-AuditID: cbfec7f2-5c9ff70000001159-c3-5bbb52aa3507
Received: from eusync1.samsung.com ( [203.254.199.211]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id A0.A9.04284.9A25BBB5; Mon,  8
        Oct 2018 13:50:49 +0100 (BST)
Received: from AMDC2765.digital.local ([106.116.147.25]) by
        eusync1.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0 64bit
        (built May  5 2014)) with ESMTPA id <0PGA006EA6BYW230@eusync1.samsung.com>;
        Mon, 08 Oct 2018 13:50:49 +0100 (BST)
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
Subject: [PATCH 6/7] arm64: dts: exynos: Mark arch_timer device as
 not-fw-configured on TM2(e)
Date:   Mon, 08 Oct 2018 14:50:08 +0200
Message-id: <20181008125009.3721-7-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
In-reply-to: <20181008125009.3721-1-m.szyprowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrHIsWRmVeSWpSXmKPExsWy7djPc7qrgnZHG7y/JWuxccZ6Vov3y3oY
        La5/ec5qMe+zrMWk+xNYLM6f38BusenxNVaLy7vmsFnMOL+PyWLtkbvsFn/v/GOz2LxpKrPF
        y48nWBx4PdbMW8PosWlVJ5vHnWt72DzenTvH7rF5Sb1H35ZVjB6fN8kFsEdx2aSk5mSWpRbp
        2yVwZbz+t4qlYCFbxdVPU5kaGLewdjFyckgImEgsezOXuYuRi0NIYAWjROecp1DOZ0aJIwfn
        sMFU7ZhzkAkisYxR4ty+B2AJIYEGJonXXxJBbDYBQ4mut11gcRGBbInOxw8YQWxmgUXMEgeO
        CXcxcnAICyRINPw1AAmzCKhKzN1+EqycV8BGYvGGl+wQu+QlVm84wAxicwrYSjzpWsUCsldC
        YA+bxKd171ggilwkbn34AGULS7w6vgWqWUaiswPiUAmBZkaJ9hmz2CGcHkaJrXN2QL1jLXH4
        +EVWiOv4JCZtm84Mcp2EAK9ER5sQhOkh8XaBP8TDExgl+mfvY5nAKLmAkWEVo3hqaXFuemqx
        YV5quV5xYm5xaV66XnJ+7iZGYCyf/nf80w7Gr5eSDjEKcDAq8fCuDNgVLcSaWFZcmXuIUYKD
        WUmEV3Q7UIg3JbGyKrUoP76oNCe1+BCjNAeLkjjvsnkbo4UE0hNLUrNTUwtSi2CyTBycUg2M
        BsLL3KWuTn7cndEh/emF4Qyp5ZbTz7MURVqsq65K1GD9L1QlyK92K+tvwYGQ4yuf6S4xirj/
        69K2POstaZznuS2bUpX8TWLY9Y80qb2YMPG7j8kjnz9ij7/LLnyRfnqd8NktJ29kXguqW5vx
        xbFv84qNhw/F35+9IHrVkraSWj4fxQiHVY76SizFGYmGWsxFxYkA5iQDNOECAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrNLMWRmVeSWpSXmKPExsVy+t/xy7org3ZHG6xfY2OxccZ6Vov3y3oY
        La5/ec5qMe+zrMWk+xNYLM6f38BusenxNVaLy7vmsFnMOL+PyWLtkbvsFn/v/GOz2LxpKrPF
        y48nWBx4PdbMW8PosWlVJ5vHnWt72DzenTvH7rF5Sb1H35ZVjB6fN8kFsEdx2aSk5mSWpRbp
        2yVwZbz+t4qlYCFbxdVPU5kaGLewdjFyckgImEjsmHOQCcQWEljCKHFhc3UXIxeQ3cQkceP8
        RXaQBJuAoUTX2y42EFtEIFti/t5usDizwBJmiZv3HboYOTiEBRIkGv4agIRZBFQl5m4/CVbO
        K2AjsXjDS3aIXfISqzccYAaxOQVsJZ50rWKB2Gsj0Tv9IusERp4FjAyrGEVSS4tz03OLDfWK
        E3OLS/PS9ZLzczcxAoNw27Gfm3cwXtoYfIhRgINRiYc3wG9XtBBrYllxZe4hRgkOZiURXtHt
        QCHelMTKqtSi/Pii0pzU4kOM0hwsSuK85w0qo4QE0hNLUrNTUwtSi2CyTBycUg2MjJdOfOxd
        XdRl8X/TLfaT16ctXWfWfnP2pN9Brpoe2k3qt9OdmbPYY8NUrGYuPm3g+SY6+kXRnxtre/V5
        /Q5Y2iyd1O14T2WP5JMbdar3DTlmxx05+JlfsKzp1Fr/fW8abp6O3/+q59KrHO34Xtf9Z06J
        nZgdfT/TZ/HRidt3dHEKF7YeP9amosRSnJFoqMVcVJwIAAvbji0+AgAA
X-CMS-MailID: 20181008125050eucas1p1caae30a4e791190e6c731816e36832ab
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181008125050eucas1p1caae30a4e791190e6c731816e36832ab
References: <20181008125009.3721-1-m.szyprowski@samsung.com>
        <CGME20181008125050eucas1p1caae30a4e791190e6c731816e36832ab@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TM2(e) boards use old firmware, which some PCSI requirements and doesn't
properly configure arch virtual timers, so add property indicating this
state. This enables respective workarounds in the timer driver.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi b/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi
index 2606c2ab6456..ded0fb6c5936 100644
--- a/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi
@@ -1265,6 +1265,7 @@
 };
 
 &timer {
+	arm,cpu-registers-not-fw-configured;
 	clock-frequency = <24000000>;
 };
 
-- 
2.17.1

