Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A3C3ECDE44
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 09:57:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7D0521550
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 09:57:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Q9uYZdYF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7D0521550
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728067AbeJRR5g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 13:57:36 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:58967 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727997AbeJRR5f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 13:57:35 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20181018095720euoutp022f9f0a605126b1e654091eaf692e6b50~eq3Sz2mcQ3210532105euoutp02z;
        Thu, 18 Oct 2018 09:57:20 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20181018095720euoutp022f9f0a605126b1e654091eaf692e6b50~eq3Sz2mcQ3210532105euoutp02z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1539856640;
        bh=JbawqqnuJmBPjDcr8q+jVFNwx8wHm3+63GETfeiWmM0=;
        h=From:To:Cc:Subject:Date:In-reply-to:References:From;
        b=Q9uYZdYFUvMcis5O22jtqppTl7hl/4CPrsdlGYPX0URfloFk26eZCwnEJw5lmb+78
         8nLVFA3PtHRvCUkYYj4ns3Yy5LKQw4Z30eUoSGUYQnmozeBOH8L7d8MjPVA6N2m8k4
         mQkST35PGi229BZYqUpFFtdGTd3oUNxAF9D1wT44=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20181018095719eucas1p14a5ba239fba9a472368332262f9acb53~eq3SYkGck1223012230eucas1p1s;
        Thu, 18 Oct 2018 09:57:19 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id BF.63.04441.FF858CB5; Thu, 18
        Oct 2018 10:57:19 +0100 (BST)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20181018095719eucas1p27732208abef3397d28640c4e519d5bca~eq3RuB4RF2701327013eucas1p2o;
        Thu, 18 Oct 2018 09:57:19 +0000 (GMT)
X-AuditID: cbfec7f2-a1ae89c000001159-75-5bc858ffa2b4
Received: from eusync3.samsung.com ( [203.254.199.213]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id FE.C2.04128.FF858CB5; Thu, 18
        Oct 2018 10:57:19 +0100 (BST)
Received: from AMDC2765.digital.local ([106.116.147.25]) by
        eusync3.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0 64bit
        (built May  5 2014)) with ESMTPA id <0PGS00GLZGZA2H50@eusync3.samsung.com>;
        Thu, 18 Oct 2018 10:57:19 +0100 (BST)
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
        Inki Dae <inki.dae@samsung.com>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v4 6/6] arm64: platform: Add enable Exynos Multi-Core Timer
 driver
Date:   Thu, 18 Oct 2018 11:57:08 +0200
Message-id: <20181018095708.1527-7-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
In-reply-to: <20181018095708.1527-1-m.szyprowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrMIsWRmVeSWpSXmKPExsWy7djPc7r/I05EG/x+rmyxccZ6Vov3y3oY
        La5/ec5qMe+zrMWk+xNYLM6f38BusenxNVaLy7vmsFnMOL+PyWLtkbvsFn/v/GOzWHr9IpPF
        5k1TmS1efjzB4sDnsWbeGkaPTas62TzuXNvD5vHu3Dl2j81L6j36tqxi9Pi8SS6APYrLJiU1
        J7MstUjfLoEr49CWW2wFc9gr/vz/ytTAOImti5GTQ0LARGLuk3MsXYxcHEICKxglunpvskI4
        nxklrqy/zQJT1fDzHRNEYhmjxOEFrVBVDUwSz38cA6tiEzCU6HrbBTZXRCBbovPxA0aQImaB
        k8wS/25uYu9i5OAQFgiRuPGnBsRkEVCVmH5OG6ScV8BGouXzFqiT5CVWbzjADGJzCthKnJn/
        Duw8CYEjbBJrb2+CushF4sDsh0wQtrDEq+Nb2CFsGYnLk7uhGpoZJdpnzGKHcHoYJbbO2QG1
        wlri8PGLrCA2swCfxKRt05lBLpIQ4JXoaBOCMD0kLn6sA6kQEpjAKLFhds4ERskFjAyrGMVT
        S4tz01OLDfNSy/WKE3OLS/PS9ZLzczcxAqP69L/jn3Ywfr2UdIhRgINRiYf3QerxaCHWxLLi
        ytxDjBIczEoivNVmJ6KFeFMSK6tSi/Lji0pzUosPMUpzsCiJ8y6btzFaSCA9sSQ1OzW1ILUI
        JsvEwSnVwMh+TObeAZNv5ac3qXzUfcH7fvp5y8uClbPdCo5WbBYWld20ZdKOeWfnmpzZmnGx
        5v2Dk6+mbQzZIGhvfyHZUkdtr3pG5P0J0U0uS/yr3t3zthM84byhseSr9HEtA+Vkr4wgNbnC
        0wFqbXt/7Z15rbrPIGCzVEud04/lnvmmH58tylm+67DxnW4lluKMREMt5qLiRADwoTuc5gIA
        AA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrILMWRmVeSWpSXmKPExsVy+t/xq7r/I05EG+yZwmKxccZ6Vov3y3oY
        La5/ec5qMe+zrMWk+xNYLM6f38BusenxNVaLy7vmsFnMOL+PyWLtkbvsFn/v/GOzWHr9IpPF
        5k1TmS1efjzB4sDnsWbeGkaPTas62TzuXNvD5vHu3Dl2j81L6j36tqxi9Pi8SS6APYrLJiU1
        J7MstUjfLoEr49CWW2wFc9gr/vz/ytTAOImti5GTQ0LARKLh5zumLkYuDiGBJYwSM1r+skM4
        TUwSrbeuMoFUsQkYSnS97QLrEBHIlpi/txusiFngJLPEpcfvWLoYOTiEBUIkbvypATFZBFQl
        pp/TBinnFbCRaPm8BWqZvMTqDQeYQWxOAVuJM/NBOjmBdtlIdP9Zzz6BkWcBI8MqRpHU0uLc
        9NxiI73ixNzi0rx0veT83E2MwIDcduznlh2MXe+CDzEKcDAq8fA+SD0eLcSaWFZcmXuIUYKD
        WUmEt9rsRLQQb0piZVVqUX58UWlOavEhRmkOFiVx3vMGlVFCAumJJanZqakFqUUwWSYOTqkG
        RnPuqkuXVWfXr+m2enPt4Ou3U4/fTvzWLJ7qvUqgukS5olRw2u9qk+pl7yy1i2Nm7I6sFHhz
        TvArZ8UGyVutJ288CYzr3bDmxnVftT6P6cYi3NG6O5LPr+heWqZ20C565lq13F31Sye4ZdWU
        s33XkVr8sGiqYZjRmd9vympOdDxSm6KulPHMU4mlOCPRUIu5qDgRAN3coEBEAgAA
X-CMS-MailID: 20181018095719eucas1p27732208abef3397d28640c4e519d5bca
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181018095719eucas1p27732208abef3397d28640c4e519d5bca
References: <20181018095708.1527-1-m.szyprowski@samsung.com>
        <CGME20181018095719eucas1p27732208abef3397d28640c4e519d5bca@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Exynos SoCs enabling MCT driver is required even if ARM Architected
Timer driver is used to for managing timer hardware and clock source
events.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
Tested-by: Chanwoo Choi <cw00.choi@samsung.com>
---
 arch/arm64/Kconfig.platforms | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index 51bc479334a4..7cc687580fad 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -62,6 +62,7 @@ config ARCH_BRCMSTB
 config ARCH_EXYNOS
 	bool "ARMv8 based Samsung Exynos SoC family"
 	select COMMON_CLK_SAMSUNG
+	select CLKSRC_EXYNOS_MCT
 	select EXYNOS_PM_DOMAINS if PM_GENERIC_DOMAINS
 	select EXYNOS_PMU
 	select HAVE_S3C2410_WATCHDOG if WATCHDOG
-- 
2.17.1

