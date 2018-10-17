Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65C4FECDE30
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 13:42:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1964F2150F
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 13:42:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="fHtPBGED"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1964F2150F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727547AbeJQViH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 17:38:07 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:57647 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727028AbeJQVhz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 17:37:55 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20181017134209euoutp013e5a2be70c9f5d1e9e538612385ffeea~eaSS4ew801247812478euoutp01D;
        Wed, 17 Oct 2018 13:42:09 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20181017134209euoutp013e5a2be70c9f5d1e9e538612385ffeea~eaSS4ew801247812478euoutp01D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1539783729;
        bh=Flm64HIKyGpGJJ++WR5bD05/fn6GV6v+Pg40dM+Jxdg=;
        h=From:To:Cc:Subject:Date:In-reply-to:References:From;
        b=fHtPBGEDFw5GShqNDsRI6p98gY7hm8KLFfWhu0tiGVoEEnAKkKjUG6f4gd+oL1MFm
         I2CvygZlA76ContNBAKwYkFPgScHtR6eMIIUFe892spqOaBSXRqpITs3Cn+eVEsQiw
         gVRm51aFEZzreWLry3SPgh39xWkReusgo2xfZI5E=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20181017134208eucas1p1f288af127a89de86b55131b56cdac87a~eaSSdKt8_1610216102eucas1p1S;
        Wed, 17 Oct 2018 13:42:08 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 9A.EC.04294.03C37CB5; Wed, 17
        Oct 2018 14:42:08 +0100 (BST)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20181017134207eucas1p18188ff6debdbabbbf8b01cc4dc1d4b13~eaSRqbtpo1610216102eucas1p1R;
        Wed, 17 Oct 2018 13:42:07 +0000 (GMT)
X-AuditID: cbfec7f4-84fff700000010c6-c5-5bc73c30ebdd
Received: from eusync4.samsung.com ( [203.254.199.214]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 8A.22.04284.F2C37CB5; Wed, 17
        Oct 2018 14:42:07 +0100 (BST)
Received: from AMDC2765.digital.local ([106.116.147.25]) by
        eusync4.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0 64bit
        (built May  5 2014)) with ESMTPA id <0PGQ001A0WQ1IZ80@eusync4.samsung.com>;
        Wed, 17 Oct 2018 14:42:07 +0100 (BST)
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
Subject: [PATCH v3 5/6] arm64: dts: exynos: Move arch-timer node to right
 place
Date:   Wed, 17 Oct 2018 15:41:58 +0200
Message-id: <20181017134159.9656-6-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
In-reply-to: <20181017134159.9656-1-m.szyprowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrPIsWRmVeSWpSXmKPExsWy7djPc7oGNsejDY78ErDYOGM9q8X7ZT2M
        Fte/PGe1mPdZ1mLS/QksFufPb2C32PT4GqvF5V1z2CxmnN/HZLH2yF12i793/rFZbN40ldni
        5ccTLA68HmvmrWH02LSqk83jzrU9bB7vzp1j99i8pN6jb8sqRo/Pm+QC2KO4bFJSczLLUov0
        7RK4Mk5ebmMsWMFb8XNqegPje64uRk4OCQETiZmvDjJ1MXJxCAmsYJSYOeMblPOZUeJkUwsT
        TNWdkztYIRLLGCVajrxgh3AamCQe/HrIBlLFJmAo0fW2C8wWEciW6Hz8gBHEZhZYxCxx4Jgw
        iC0sECix59YvFhCbRUBV4tuUBWA2r4CNxJQZc9kgtslLrN5wgLmLkYODU8BWYm1/FcguCYEd
        bBIbf/dD1bhIrO65yQ5hC0u8Or4FypaR6OyA+EdCoJlRon3GLHYIp4dRYuucHVDd1hKHj19k
        hbiOT2LStulg2yQEeCU62oQgSjwkftxZCfXyBEaJCf0XGScwSi5gZFjFKJ5aWpybnlpslJda
        rlecmFtcmpeul5yfu4kRGM2n/x3/soNx15+kQ4wCHIxKPLw7xI5FC7EmlhVX5h5ilOBgVhLh
        rVI8Hi3Em5JYWZValB9fVJqTWnyIUZqDRUmcd9m8jdFCAumJJanZqakFqUUwWSYOTqkGRmab
        teEcTcpS4j/8D7CvejHZe591XfO7H4+zVrTejk5s+epxtnKh7KtjKTyrT+8VXy31UzLXNdsv
        7sO7/aWqs9vFluim8yk/1H7G3fF3le/R+02fd96wCzpnaKO6ZPcv2yuTGntSJsxc4ca3YslW
        SZbUqeVnL77/X5C8WLro/ddPt++s54srSFJiKc5INNRiLipOBAD79ymO4gIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrFLMWRmVeSWpSXmKPExsVy+t/xa7r6NsejDea/U7PYOGM9q8X7ZT2M
        Fte/PGe1mPdZ1mLS/QksFufPb2C32PT4GqvF5V1z2CxmnN/HZLH2yF12i793/rFZbN40ldni
        5ccTLA68HmvmrWH02LSqk83jzrU9bB7vzp1j99i8pN6jb8sqRo/Pm+QC2KO4bFJSczLLUov0
        7RK4Mk5ebmMsWMFb8XNqegPje64uRk4OCQETiTsnd7CC2EICSxglzjTkdjFyAdlNTBIPNk5g
        A0mwCRhKdL3tArNFBLIl5u/tZgexmQWWMEvcvO8AYgsL+Ev8fXoGbBCLgKrEtykLWEBsXgEb
        iSkz5rJBLJOXWL3hAHMXIwcHp4CtxNr+Koi9NhIvP89lmsDIs4CRYRWjSGppcW56brGhXnFi
        bnFpXrpecn7uJkZgCG479nPzDsZLG4MPMQpwMCrx8O4QOxYtxJpYVlyZe4hRgoNZSYS3SvF4
        tBBvSmJlVWpRfnxRaU5q8SFGaQ4WJXHe8waVUUIC6YklqdmpqQWpRTBZJg5OqQZGbb2CLX8e
        5tba6zgYmj10rNOQ+2Pn1yhtIM2UGDDL4pr7wvnlLCFX4jWPTBH1yZ7kbaVafuXbDttnUXWG
        Z/+FlxQEWN+TU7TryL3sFKy780Qnc5bf/40KYR72P1uDk7/f2rG95m5pQvDbCK+rr4PFuNeH
        JPnw7wvap8+47KbOh7svlIsUhJVYijMSDbWYi4oTAXhZc3g9AgAA
X-CMS-MailID: 20181017134207eucas1p18188ff6debdbabbbf8b01cc4dc1d4b13
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181017134207eucas1p18188ff6debdbabbbf8b01cc4dc1d4b13
References: <20181017134159.9656-1-m.szyprowski@samsung.com>
        <CGME20181017134207eucas1p18188ff6debdbabbbf8b01cc4dc1d4b13@eucas1p1.samsung.com>
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

