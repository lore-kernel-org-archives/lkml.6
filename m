Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C298C46465
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 17:11:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE2612089F
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 17:11:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="iaR/6Prh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE2612089F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=partner.samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731620AbeKHCmC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 21:42:02 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:54863 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731527AbeKHCmA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 21:42:00 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20181107171042euoutp01c9096536dd7450ab2f522053c76d9706~k5rZF2mxl2287822878euoutp01Q
        for <linux-kernel@vger.kernel.org>; Wed,  7 Nov 2018 17:10:42 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20181107171042euoutp01c9096536dd7450ab2f522053c76d9706~k5rZF2mxl2287822878euoutp01Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1541610643;
        bh=Z1YsDuDqKlskrg/CVSgaixZZ2C4GhBivvX7W7GWawhI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iaR/6Prhby05Xtjm0Xzpy5416HFMMmWrYrSMdKIik1ybQGX1gIu3cd4pGkokM0PqZ
         mcSUUCNqnxVEoXbyYbaYtRl0TIMsXnOjVy6nJasuKp8L1Og9uQ1lHJ4+vYs4pk6GnZ
         tkgL05Luuu0AKevvOialvZly68mYjzuO0oL2Vvbk=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20181107171041eucas1p14cba150376baadc063cb4ee342ef9b53~k5rX8Zqdr2713827138eucas1p1q;
        Wed,  7 Nov 2018 17:10:41 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id CF.C9.04806.19C13EB5; Wed,  7
        Nov 2018 17:10:41 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20181107171041eucas1p1a3cf91435b9071fd6e6f84101ebbcd9f~k5rXWV08_2713827138eucas1p1p;
        Wed,  7 Nov 2018 17:10:41 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20181107171040eusmtrp18347a2a9b53b3ccd524d5130b02f1b4f~k5rXKbIYu2472624726eusmtrp1o;
        Wed,  7 Nov 2018 17:10:40 +0000 (GMT)
X-AuditID: cbfec7f5-34dff700000012c6-10-5be31c91258b
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 8D.23.04128.09C13EB5; Wed,  7
        Nov 2018 17:10:40 +0000 (GMT)
Received: from AMDC3778.DIGITAL.local (unknown [106.120.51.20]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20181107171040eusmtip25bb9ca8d55565755f260653b2aba3b50~k5rWfCR-V0340803408eusmtip2T;
        Wed,  7 Nov 2018 17:10:40 +0000 (GMT)
From:   Lukasz Luba <l.luba@partner.samsung.com>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Cc:     rui.zhang@intel.com, edubezval@gmail.com,
        daniel.lezcano@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, corbet@lwn.net, b.zolnierkie@samsung.com,
        krzk@kernel.org, Lukasz Luba <l.luba@partner.samsung.com>,
        Kukjin Kim <kgene@kernel.org>,
        linux-samsung-soc@vger.kernel.org
Subject: [PATCH v2 06/11] arm64: dts: exynos5433: add support for thermal
 trip irq-mode
Date:   Wed,  7 Nov 2018 18:09:48 +0100
Message-Id: <1541610593-28542-7-git-send-email-l.luba@partner.samsung.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1541610593-28542-1-git-send-email-l.luba@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WSa0hTYRjHe8/ZubicHOftzdRoUFiQFgqeMNIi4lB90MAgR+XMg0re2nGW
        lXfylpdSTNGaioq2FHNeUJlDbTREU5fhDUXN+SFvJbPQSmnzGH37Pf/n//yfh5eXRMXdmDMZ
        GRPPymNkURJcKOj4sD186oXLovT01s+jdEtZM0Ybe7MArTS50pW6YYyu/DyO0YWLKyg9MvKO
        oKdTXWj1olmqzqwV0GPdr3DalK8DdNmIFqHrJgwI/bRHR9DGhQLcn2IalY2A6SqfJZgazVeE
        UatycGZmXIMzrbUpTE1BMcb0rWsQpqBNBRiT2i1AGCw8F8ZGRSawcs/zIcKIUWM7Ebfp9/BZ
        2SySCjI8coEVCSlvWJA6gFhYTDUA2GPw53kTwLwN61wgNLMJwN2mISIXkHsDORnBvF4PYMZA
        Os4X5oGZNwuYxYRTHrBTdd+i21MVAJq0NYSlQKkqBG78bhJYVthRN2GmYQu1sIA6BtPyjZiF
        RdQV2DpbjfLnucGp4Zw9tqKuQuXY2l4QpMYJqP/2HeNPugS3+67xfju4rG8jeHaBg8V5Ap45
        +DFbhfP8BGYNdO57fOF7vWEvBqVOwOZuT16+AHdGtnE+3QZOrtlaZNSMRR2lKC+LYHammHe7
        w7a8UYRnR1jf+HI/nIH5K3X7b6sEsGU89Dk4Uv5/VxUAKuDEKrjocJbzimEfeHCyaE4RE+5x
        NzZaDcw/anBX/6MTaP+E9gOKBBJr0Wj7glSMyRK4xOh+AElUYi/Kf/tFKhaFyRIfsfLYO3JF
        FMv1g8OkQOIkenxgXiqmwmXx7D2WjWPl/7oIaeWcCkqMi64rgvT5qCJSMqXY0QVobvjby1OG
        5tykxznEpznFy/Nymm1aq1uF9aHi7usN3jl6h/UKZwe10WfC51bS5IA22TWkBChkRa8J7KKV
        i3uQrzok6eBSoG5nLSjjtmNpUbWffrVhdWtp2qACv2wCu5I/pfRGLGeScWf98grnJAIuQnbm
        JCrnZH8BLcEL3E0DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprPIsWRmVeSWpSXmKPExsVy+t/xe7oTZB5HG9x4ZWSxccZ6VosnB9oZ
        LeZ9lrWYf+Qcq8X8K9dYLfofv2a2OH9+A7vFrQYZi02PgUIL25awWFzeNYfN4nPvEUaLGef3
        MVksvX6RyaJ17xF2iycP+9gcBDzWzFvD6LFz1l12j8V7XjJ5bFrVyeZx59oeNo/NS+o9FvdN
        ZvU4+G4Pk0ffllWMHp83yQVwRenZFOWXlqQqZOQXl9gqRRtaGOkZWlroGZlY6hkam8daGZkq
        6dvZpKTmZJalFunbJehlXHiylb3gi31F94y7TA2MzXpdjBwcEgImEp3NUV2MXBxCAksZJf6t
        PM7UxcgJFBeTmLRvOzuELSzx51oXG0TRJ0aJk22H2UGa2QT0JHasKgSJiwjMZ5Q4uukyWBGz
        wBomia2HzjOCFAkLhEscf1QNMohFQFWisfcJK4jNK+AlsfnuQmaIBXISN891gtmcAt4S8y6/
        BVssBFTzfdZ6tgmMfAsYGVYxiqSWFuem5xYb6RUn5haX5qXrJefnbmIERs62Yz+37GDsehd8
        iFGAg1GJh1djx8NoIdbEsuLK3EOMEhzMSiK8vasfRQvxpiRWVqUW5ccXleakFh9iNAU6aiKz
        lGhyPjCq80riDU0NzS0sDc2NzY3NLJTEec8bVEYJCaQnlqRmp6YWpBbB9DFxcEo1MCrXT4/X
        jct7wfXz7bmZU2/nvGOL87DPCmAqPfBrWlXGek7WC/uNNr9QilV741PJLyP5+cv7qm+1nC1l
        j5muTJ0XkjBztqrc2e9axuZMzM8qVjhP3jf5yH03f9vjs7Zk+bRMPH5Fpm31d+5dUROElyh9
        uqMv5Sjd0SRu2vvSbq6+xr/5Hi9u/1FiKc5INNRiLipOBABCgnoHsgIAAA==
X-CMS-MailID: 20181107171041eucas1p1a3cf91435b9071fd6e6f84101ebbcd9f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20181107171041eucas1p1a3cf91435b9071fd6e6f84101ebbcd9f
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181107171041eucas1p1a3cf91435b9071fd6e6f84101ebbcd9f
References: <1541610593-28542-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20181107171041eucas1p1a3cf91435b9071fd6e6f84101ebbcd9f@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds support for new flag which indicates
that trip point triggers IRQ when temperature is met.
Exynos5433 supports 8 trip point which will trigger IRQ.
Above that number other trip points should be registered
without 'irq-mode' flag.

Cc: Kukjin Kim <kgene@kernel.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Cc: devicetree@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-samsung-soc@vger.kernel.org
Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
---
 arch/arm64/boot/dts/exynos/exynos5433-tmu.dtsi | 105 ++++++++++++++++---------
 1 file changed, 70 insertions(+), 35 deletions(-)

diff --git a/arch/arm64/boot/dts/exynos/exynos5433-tmu.dtsi b/arch/arm64/boot/dts/exynos/exynos5433-tmu.dtsi
index fe3a0b1..c4330f6 100644
--- a/arch/arm64/boot/dts/exynos/exynos5433-tmu.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynos5433-tmu.dtsi
@@ -17,37 +17,44 @@ thermal-zones {
 			atlas0_alert_0: atlas0-alert-0 {
 				temperature = <65000>;	/* millicelsius */
 				hysteresis = <1000>;	/* millicelsius */
-				type = "active";
+				type = "passive";
+				irq-mode;
 			};
 			atlas0_alert_1: atlas0-alert-1 {
 				temperature = <70000>;	/* millicelsius */
 				hysteresis = <1000>;	/* millicelsius */
-				type = "active";
+				type = "passive";
+				irq-mode;
 			};
 			atlas0_alert_2: atlas0-alert-2 {
 				temperature = <75000>;	/* millicelsius */
 				hysteresis = <1000>;	/* millicelsius */
-				type = "active";
+				type = "passive";
+				irq-mode;
 			};
 			atlas0_alert_3: atlas0-alert-3 {
 				temperature = <80000>;	/* millicelsius */
 				hysteresis = <1000>;	/* millicelsius */
-				type = "active";
+				type = "passive";
+				irq-mode;
 			};
 			atlas0_alert_4: atlas0-alert-4 {
 				temperature = <85000>;	/* millicelsius */
 				hysteresis = <1000>;	/* millicelsius */
-				type = "active";
+				type = "passive";
+				irq-mode;
 			};
 			atlas0_alert_5: atlas0-alert-5 {
 				temperature = <90000>;	/* millicelsius */
 				hysteresis = <1000>;	/* millicelsius */
-				type = "active";
+				type = "passive";
+				irq-mode;
 			};
 			atlas0_alert_6: atlas0-alert-6 {
 				temperature = <95000>;	/* millicelsius */
 				hysteresis = <1000>;	/* millicelsius */
-				type = "active";
+				type = "passive";
+				irq-mode;
 			};
 		};
 
@@ -98,37 +105,44 @@ thermal-zones {
 			atlas1_alert_0: atlas1-alert-0 {
 				temperature = <65000>;	/* millicelsius */
 				hysteresis = <1000>;	/* millicelsius */
-				type = "active";
+				type = "passive";
+				irq-mode;
 			};
 			atlas1_alert_1: atlas1-alert-1 {
 				temperature = <70000>;	/* millicelsius */
 				hysteresis = <1000>;	/* millicelsius */
-				type = "active";
+				type = "passive";
+				irq-mode;
 			};
 			atlas1_alert_2: atlas1-alert-2 {
 				temperature = <75000>;	/* millicelsius */
 				hysteresis = <1000>;	/* millicelsius */
-				type = "active";
+				type = "passive";
+				irq-mode;
 			};
 			atlas1_alert_3: atlas1-alert-3 {
 				temperature = <80000>;	/* millicelsius */
 				hysteresis = <1000>;	/* millicelsius */
-				type = "active";
+				type = "passive";
+				irq-mode;
 			};
 			atlas1_alert_4: atlas1-alert-4 {
 				temperature = <85000>;	/* millicelsius */
 				hysteresis = <1000>;	/* millicelsius */
-				type = "active";
+				type = "passive";
+				irq-mode;
 			};
 			atlas1_alert_5: atlas1-alert-5 {
 				temperature = <90000>;	/* millicelsius */
 				hysteresis = <1000>;	/* millicelsius */
-				type = "active";
+				type = "passive";
+				irq-mode;
 			};
 			atlas1_alert_6: atlas1-alert-6 {
 				temperature = <95000>;	/* millicelsius */
 				hysteresis = <1000>;	/* millicelsius */
-				type = "active";
+				type = "passive";
+				irq-mode;
 			};
 		};
 	};
@@ -141,37 +155,44 @@ thermal-zones {
 			g3d_alert_0: g3d-alert-0 {
 				temperature = <70000>;	/* millicelsius */
 				hysteresis = <1000>;	/* millicelsius */
-				type = "active";
+				type = "passive";
+				irq-mode;
 			};
 			g3d_alert_1: g3d-alert-1 {
 				temperature = <75000>;	/* millicelsius */
 				hysteresis = <1000>;	/* millicelsius */
-				type = "active";
+				type = "passive";
+				irq-mode;
 			};
 			g3d_alert_2: g3d-alert-2 {
 				temperature = <80000>;	/* millicelsius */
 				hysteresis = <1000>;	/* millicelsius */
-				type = "active";
+				type = "passive";
+				irq-mode;
 			};
 			g3d_alert_3: g3d-alert-3 {
 				temperature = <85000>;	/* millicelsius */
 				hysteresis = <1000>;	/* millicelsius */
-				type = "active";
+				type = "passive";
+				irq-mode;
 			};
 			g3d_alert_4: g3d-alert-4 {
 				temperature = <90000>;	/* millicelsius */
 				hysteresis = <1000>;	/* millicelsius */
-				type = "active";
+				type = "passive";
+				irq-mode;
 			};
 			g3d_alert_5: g3d-alert-5 {
 				temperature = <95000>;	/* millicelsius */
 				hysteresis = <1000>;	/* millicelsius */
-				type = "active";
+				type = "passive";
+				irq-mode;
 			};
 			g3d_alert_6: g3d-alert-6 {
 				temperature = <100000>;	/* millicelsius */
 				hysteresis = <1000>;	/* millicelsius */
-				type = "active";
+				type = "passive";
+				irq-mode;
 			};
 		};
 	};
@@ -184,37 +205,44 @@ thermal-zones {
 			apollo_alert_0: apollo-alert-0 {
 				temperature = <65000>;	/* millicelsius */
 				hysteresis = <1000>;	/* millicelsius */
-				type = "active";
+				type = "passive";
+				irq-mode;
 			};
 			apollo_alert_1: apollo-alert-1 {
 				temperature = <70000>;	/* millicelsius */
 				hysteresis = <1000>;	/* millicelsius */
-				type = "active";
+				type = "passive";
+				irq-mode;
 			};
 			apollo_alert_2: apollo-alert-2 {
 				temperature = <75000>;	/* millicelsius */
 				hysteresis = <1000>;	/* millicelsius */
-				type = "active";
+				type = "passive";
+				irq-mode;
 			};
 			apollo_alert_3: apollo-alert-3 {
 				temperature = <80000>;	/* millicelsius */
 				hysteresis = <1000>;	/* millicelsius */
-				type = "active";
+				type = "passive";
+				irq-mode;
 			};
 			apollo_alert_4: apollo-alert-4 {
 				temperature = <85000>;	/* millicelsius */
 				hysteresis = <1000>;	/* millicelsius */
-				type = "active";
+				type = "passive";
+				irq-mode;
 			};
 			apollo_alert_5: apollo-alert-5 {
 				temperature = <90000>;	/* millicelsius */
 				hysteresis = <1000>;	/* millicelsius */
-				type = "active";
+				type = "passive";
+				irq-mode;
 			};
 			apollo_alert_6: apollo-alert-6 {
 				temperature = <95000>;	/* millicelsius */
 				hysteresis = <1000>;	/* millicelsius */
-				type = "active";
+				type = "passive";
+				irq-mode;
 			};
 		};
 
@@ -255,37 +283,44 @@ thermal-zones {
 			isp_alert_0: isp-alert-0 {
 				temperature = <80000>;	/* millicelsius */
 				hysteresis = <1000>;	/* millicelsius */
-				type = "active";
+				type = "passive";
+				irq-mode;
 			};
 			isp_alert_1: isp-alert-1 {
 				temperature = <85000>;	/* millicelsius */
 				hysteresis = <1000>;	/* millicelsius */
-				type = "active";
+				type = "passive";
+				irq-mode;
 			};
 			isp_alert_2: isp-alert-2 {
 				temperature = <90000>;	/* millicelsius */
 				hysteresis = <1000>;	/* millicelsius */
-				type = "active";
+				type = "passive";
+				irq-mode;
 			};
 			isp_alert_3: isp-alert-3 {
 				temperature = <95000>;	/* millicelsius */
 				hysteresis = <1000>;	/* millicelsius */
-				type = "active";
+				type = "passive";
+				irq-mode;
 			};
 			isp_alert_4: isp-alert-4 {
 				temperature = <100000>;	/* millicelsius */
 				hysteresis = <1000>;	/* millicelsius */
-				type = "active";
+				type = "passive";
+				irq-mode;
 			};
 			isp_alert_5: isp-alert-5 {
 				temperature = <105000>;	/* millicelsius */
 				hysteresis = <1000>;	/* millicelsius */
-				type = "active";
+				type = "passive";
+				irq-mode;
 			};
 			isp_alert_6: isp-alert-6 {
 				temperature = <110000>;	/* millicelsius */
 				hysteresis = <1000>;	/* millicelsius */
-				type = "active";
+				type = "passive";
+				irq-mode;
 			};
 		};
 	};
-- 
2.7.4

