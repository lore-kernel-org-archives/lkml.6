Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC0FBC04AA5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 12:31:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6F7920652
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 12:31:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="NHnIYJRp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6F7920652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726777AbeJOUQp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 16:16:45 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:37129 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726654AbeJOUQo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 16:16:44 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20181015123138euoutp027b60de0c35b26362ca986b518105c8f1~dyCKL0atM0591705917euoutp02h;
        Mon, 15 Oct 2018 12:31:38 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20181015123138euoutp027b60de0c35b26362ca986b518105c8f1~dyCKL0atM0591705917euoutp02h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1539606698;
        bh=kIXYHgbCw/TEbmTBRAWIfTvqOP+VrE5bWDenOgTQcoY=;
        h=From:To:Cc:Subject:Date:In-reply-to:References:From;
        b=NHnIYJRp7lXh+QNLuOWzKZ2Dw1jMRkE/9X0BYllongdjCzXfP/Pu4RNEuwKixL/8D
         M54lHE7E1rPdEqghrp7rBmp5t8/ifPiteoU1TKVMj/KScmElvP3SXv6t2NXnp1ndch
         vi+E5BVfICKsK7RPAfxpi5+950qBNWdAbGdCO2yw=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20181015123137eucas1p2951938764f36f3e8d85c9143452304a0~dyCJtUXcY2088020880eucas1p2p;
        Mon, 15 Oct 2018 12:31:37 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id DE.22.04441.9A884CB5; Mon, 15
        Oct 2018 13:31:37 +0100 (BST)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20181015123136eucas1p292c0d6662da5e6694e9f6773282ea017~dyCI2A4ek2088020880eucas1p2m;
        Mon, 15 Oct 2018 12:31:36 +0000 (GMT)
X-AuditID: cbfec7f2-a1ae89c000001159-f9-5bc488a94e56
Received: from eusync1.samsung.com ( [203.254.199.211]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 19.EE.04284.8A884CB5; Mon, 15
        Oct 2018 13:31:36 +0100 (BST)
Received: from AMDC2765.digital.local ([106.116.147.25]) by
        eusync1.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0 64bit
        (built May  5 2014)) with ESMTPA id <0PGN00GZC4490K70@eusync1.samsung.com>;
        Mon, 15 Oct 2018 13:31:36 +0100 (BST)
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
Subject: [PATCH v2 5/6] arm64: dts: exynos: Move arch-timer node to right
 place
Date:   Mon, 15 Oct 2018 14:31:11 +0200
Message-id: <20181015123112.9379-6-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
In-reply-to: <20181015123112.9379-1-m.szyprowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrHIsWRmVeSWpSXmKPExsWy7djP87orO45EG1xZJGqxccZ6Vov3y3oY
        La5/ec5qMe+zrMWk+xNYLM6f38BusenxNVaLy7vmsFnMOL+PyWLtkbvsFn/v/GOz2LxpKrPF
        y48nWBx4PdbMW8PosWlVJ5vHnWt72DzenTvH7rF5Sb1H35ZVjB6fN8kFsEdx2aSk5mSWpRbp
        2yVwZdz4PpO14AhPRfuTQ2wNjFO5uhg5OSQETCSWdB5g62Lk4hASWMEo0XlqHyuE85lRYmv3
        VXaYqtUbXrNAJJYxSiy91gXlNDBJLL89nxWkik3AUKLrbRcbiC0ikC3R+fgBI4jNLLCIWeLA
        MeEuRg4OYYFAifuLREDCLAKqEtOaFzGDhHkFbCQm71CA2CUPtOsAM4jNKWArcfj/KrBVEgIH
        2CR+LZ/HBFHkIjFv4SSo44QlXh3fAmXLSHR2HGSCaGhmlGifMYsdwukBemfODjaIKmuJw8cv
        skIcxycxadt0sCskBHglOtqEIEwPiT87EiB+nMAosazrHNMERskFjAyrGMVTS4tz01OLDfNS
        y/WKE3OLS/PS9ZLzczcxAmP59L/jn3Ywfr2UdIhRgINRiYdXgOdItBBrYllxZe4hRgkOZiUR
        XomQQ9FCvCmJlVWpRfnxRaU5qcWHGKU5WJTEeZfN2xgtJJCeWJKanZpakFoEk2Xi4JQCxlnA
        QokuryW/4m94SNtaacwQvZVx926M9ewHy642OX/NEVB/pCbc+lLA68SDV1HMbA6b59i37np+
        wH37w7kXZM3cvH+kNyrI7Y+I3c0YeUqn2bniSHfv7cRIeRd+LUc5x6+Mb4MqBI3SPNepyH1Y
        WKzl8k7ycMSKPb5dixc9Fbi6L/3znTsnlFiKMxINtZiLihMBgnhvwuECAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrDLMWRmVeSWpSXmKPExsVy+t/xy7orOo5EG3RNNbXYOGM9q8X7ZT2M
        Fte/PGe1mPdZ1mLS/QksFufPb2C32PT4GqvF5V1z2CxmnN/HZLH2yF12i793/rFZbN40ldni
        5ccTLA68HmvmrWH02LSqk83jzrU9bB7vzp1j99i8pN6jb8sqRo/Pm+QC2KO4bFJSczLLUov0
        7RK4Mm58n8lacISnov3JIbYGxqlcXYycHBICJhKrN7xm6WLk4hASWMIo8fLuByYIp4lJYtvV
        EywgVWwChhJdb7vYQGwRgWyJ+Xu72UFsZoElzBI37zuA2MIC/hKXp3xkBbFZBFQlpjUvYu5i
        5ODgFbCRmLxDAWKZPNCyA8wgNqeArcTh/6vAxgsBlVw49pdxAiPPAkaGVYwiqaXFuem5xYZ6
        xYm5xaV56XrJ+bmbGIFhuO3Yz807GC9tDD7EKMDBqMTDK8BzJFqINbGsuDL3EKMEB7OSCK9E
        yKFoId6UxMqq1KL8+KLSnNTiQ4zSHCxK4rznDSqjhATSE0tSs1NTC1KLYLJMHJxSDYwp0lp6
        yurbGQ6YzVc6zmdjdkP2EaOQ+xefSJfgWxN3KhYtWVHyL+uzf+qtTZyqv/T2nJv5J33ukQud
        qhfbH3xprV2Sv9KXcf6NxmWZ17aG2ulvEq7bbu0U+jDcS+Dk0slS8nbSiulukl89Ppss/Drz
        ffjMj6xPjyxb6Hetq/Lhz2Wbja7NlepVYinOSDTUYi4qTgQA8nznFj8CAAA=
X-CMS-MailID: 20181015123136eucas1p292c0d6662da5e6694e9f6773282ea017
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181015123136eucas1p292c0d6662da5e6694e9f6773282ea017
References: <20181015123112.9379-1-m.szyprowski@samsung.com>
        <CGME20181015123136eucas1p292c0d6662da5e6694e9f6773282ea017@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move ARM architected timer device-tree node to the beginning of 'soc'
node, to group it together with other ARM CPU core devices (like PMU).

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
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

