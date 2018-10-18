Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98833ECDE43
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 09:57:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D72821550
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 09:57:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="NN7YGIRJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D72821550
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728047AbeJRR5f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 13:57:35 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:53153 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727946AbeJRR5f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 13:57:35 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20181018095719euoutp01d2838277dbccbd78b006fbc20c19f301~eq3SUf2Um0160201602euoutp01f;
        Thu, 18 Oct 2018 09:57:19 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20181018095719euoutp01d2838277dbccbd78b006fbc20c19f301~eq3SUf2Um0160201602euoutp01f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1539856639;
        bh=Flm64HIKyGpGJJ++WR5bD05/fn6GV6v+Pg40dM+Jxdg=;
        h=From:To:Cc:Subject:Date:In-reply-to:References:From;
        b=NN7YGIRJweT4UFtrUkfKqB5tJlwsnweWLCiT3wX8uX25NLZEp+vq4Mwab1+oTfadf
         UG+y6ozmaSBSNsz2eV2aJb+ftj2w6y/5bEPrilkRFVC0snUVpavFKHCXC/7LzMo3Yu
         JbIDFn6fNfXjUCJJ5EOPk/mB8+w3OAIXix4LvYvc=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20181018095719eucas1p2b2edc39c08bc260229864241c6467a29~eq3R4Et2y0201302013eucas1p2u;
        Thu, 18 Oct 2018 09:57:19 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 30.E1.04294.EF858CB5; Thu, 18
        Oct 2018 10:57:19 +0100 (BST)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20181018095718eucas1p17799dfba088b0ea412687dd5f1dad78f~eq3RFN3X91872818728eucas1p15;
        Thu, 18 Oct 2018 09:57:18 +0000 (GMT)
X-AuditID: cbfec7f4-84fff700000010c6-02-5bc858fe7559
Received: from eusync3.samsung.com ( [203.254.199.213]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 20.E2.04284.EF858CB5; Thu, 18
        Oct 2018 10:57:18 +0100 (BST)
Received: from AMDC2765.digital.local ([106.116.147.25]) by
        eusync3.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0 64bit
        (built May  5 2014)) with ESMTPA id <0PGS00GLZGZA2H50@eusync3.samsung.com>;
        Thu, 18 Oct 2018 10:57:18 +0100 (BST)
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
Subject: [PATCH v4 5/6] arm64: dts: exynos: Move arch-timer node to right
 place
Date:   Thu, 18 Oct 2018 11:57:07 +0200
Message-id: <20181018095708.1527-6-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
In-reply-to: <20181018095708.1527-1-m.szyprowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzVRa0hTYRju2zk757haHTbDz1uXQReCLEXiQy0N+nFAyKR+ZAty5Wma7kx2
        3MoiXFama5YZMgnTChWdhrqZqZjUGk1LHWIqoqZh0MUbNvsxqVXz6L/neZ/neS+8FCb7iIdQ
        GVwOq+NUWQpCgre987r3/z3dozzY3y5CLeVNYrRYawZodPmrGFV6wlHpVAmO3O5mEtlmRsRo
        qLOCQOXubhF67pwk0Z8JH4FqRgdFyG4rw9D3pR48YTPTWNkIGJu1iGAmRroIZmFggGTs1XnM
        vVYrYDy2bSfIM5K4NDYrw8DqDhxJlaT3DhWA7DrpFW+Z2ggWJSYQQEE6Gr5/bCRNQELJ6DoA
        68dr1ogHwA7HJ7DuMltWcEGoBdB7/5lYIEYRHB6ZXHURdCQ0zZsIPw6kM2HRzDTwmzC6F4O+
        MRvpF+R0Mnx42yEyAYrC6V3wi1HuL0vpOPhqrp8Qpm2HDc2vMT8OoA/DvqqF1cmQdhLQme8T
        C6Zj0PrTsxaQwx+uVlLAYbCo8I1ICNwE8E75I1IgZgBfVLSvJWLhW9fgaieM3gxL2yyYfyNI
        S2FhgUyADJztChOuLAFwqqCYKAHBT8AGKwhi9bxGzfJRHHs5gldpeD2njrig1djA/19/8LmW
        20Hn7/MOQFNAsUk6zbqUMrHKwOdqHABSmCJQeu1Qj1ImTVPlXmV12nM6fRbLO0AohSuCpLWV
        LUoZrVblsJksm83q1lURFRBiBKSzoympWz9O9CfstcejYoPrgXXYoXXVzFMxW8aOLkgwX/Xx
        WfMOd/xL+9jQHDfReDFWHhlab7mef3dgyWAfTkyc+/XZ6zKdtCY3cM68yWitWsZ11TmJJOtu
        pyc4ZefZvqiVvBSLZGvl1MZvETdu6bg9T8NjqtypS4WnLq0ocD5dFbkP0/Gqf5X6O4znAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrILMWRmVeSWpSXmKPExsVy+t/xq7r/Ik5EG0x7LW2xccZ6Vov3y3oY
        La5/ec5qMe+zrMWk+xNYLM6f38BusenxNVaLy7vmsFnMOL+PyWLtkbvsFn/v/GOzWHr9IpPF
        5k1TmS1efjzB4sDnsWbeGkaPTas62TzuXNvD5vHu3Dl2j81L6j36tqxi9Pi8SS6APYrLJiU1
        J7MstUjfLoEr4+TlNsaCFbwVP6emNzC+5+pi5OSQEDCR6Jn+i6WLkYtDSGAJo8T6PctZIZwm
        Jon2Bb8YQarYBAwlut52sYHYIgLZEvP3drODFDELnGSWuPT4HQtIQljAX2Lj8n9ACQ4OFgFV
        iScNwiBhXgEbib1vzrJBbJOXWL3hADOIzSlgK3FmPkSrEFBN95/17BMYeRYwMqxiFEktLc5N
        zy021CtOzC0uzUvXS87P3cQIDMhtx35u3sF4aWPwIUYBDkYlHt4HqcejhVgTy4orcw8xSnAw
        K4nwVpudiBbiTUmsrEotyo8vKs1JLT7EKM3BoiTOe96gMkpIID2xJDU7NbUgtQgmy8TBKdXA
        2P7OQZxhDqPeDYGHk4Nn+yo52Ho1H3R4sFzTrUd8WcoFRh3/6U5+3ooM//eyqwuvzovg6O2e
        +i1z/vq0ePMPavJeGzyKNObazSiYn/qF858w97w7Oduzd92+u2K9eb/pgpgZli9a98blTytY
        8uSJwoHHuU+CZd5ePrdQ6722leMrwWeVM/6+VWIpzkg01GIuKk4EANyZ4zZEAgAA
X-CMS-MailID: 20181018095718eucas1p17799dfba088b0ea412687dd5f1dad78f
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181018095718eucas1p17799dfba088b0ea412687dd5f1dad78f
References: <20181018095708.1527-1-m.szyprowski@samsung.com>
        <CGME20181018095718eucas1p17799dfba088b0ea412687dd5f1dad78f@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move ARM architected timer device-tree node to the beginning of 'soc'
node, to group it together with other ARM CPU core devices (like PMU).

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
Tested-by: Chanwoo Choi <cw00.choi@samsung.com>
---
 arch/arm64/boot/dts/exynos/exynos5433.dtsi | 23 +++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/arch/arm64/boot/dts/exynos/exynos5433.dtsi b/arch/arm64/boot/dts/exynos/exynos5433.dtsi
index 2131f12364cb..fa20eb3495b3 100644
--- a/arch/arm64/boot/dts/exynos/exynos5433.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynos5433.dtsi
@@ -255,6 +255,18 @@
 			interrupt-affinity = <&cpu4>, <&cpu5>, <&cpu6>, <&cpu7>;
 		};
 
+		timer: timer {
+			compatible = "arm,armv8-timer";
+			interrupts = <GIC_PPI 13
+					(GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_HIGH)>,
+				<GIC_PPI 14
+					(GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_HIGH)>,
+				<GIC_PPI 11
+					(GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_HIGH)>,
+				<GIC_PPI 10
+					(GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_HIGH)>;
+		};
+
 		chipid@10000000 {
 			compatible = "samsung,exynos4210-chipid";
 			reg = <0x10000000 0x100>;
@@ -1750,17 +1762,6 @@
 		};
 	};
 
-	timer: timer {
-		compatible = "arm,armv8-timer";
-		interrupts = <GIC_PPI 13
-				(GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_HIGH)>,
-			<GIC_PPI 14
-				(GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_HIGH)>,
-			<GIC_PPI 11
-				(GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_HIGH)>,
-			<GIC_PPI 10
-				(GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_HIGH)>;
-	};
 };
 
 #include "exynos5433-bus.dtsi"
-- 
2.17.1

