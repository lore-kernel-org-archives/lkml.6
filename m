Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74636C677D4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 12:50:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 325902085B
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 12:50:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="bU3OPpJS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 325902085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726573AbeJHUC0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 16:02:26 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:51671 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726415AbeJHUCZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 16:02:25 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20181008125050euoutp020968f58ab8f346ab0284cf40429cb403~box7gzKNu2691626916euoutp02i;
        Mon,  8 Oct 2018 12:50:50 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20181008125050euoutp020968f58ab8f346ab0284cf40429cb403~box7gzKNu2691626916euoutp02i
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1539003050;
        bh=oISHmxNdfGkbDwfrWiEytBWOAxw9HaS1HFlv7Fq2LTc=;
        h=From:To:Cc:Subject:Date:In-reply-to:References:From;
        b=bU3OPpJSEbYwPuMDlATGQp+Ppk8SzLj14JB9ytagizmNrUihVaQdvVPk8cRsS+AA9
         xBDo1ZOHnipx8eLId+MLWOj+4LYnhR5ZKm3zfY6uMGnToIZfh4iBcxHkbsrq3rfZkI
         lGjI7SJ9ykLJKVvHpmCYyjy79kcXSDm2Pz2D3QPk=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20181008125049eucas1p1a8a02aef5ffee52919b11e3dbd27a0b3~box62mgYx1753817538eucas1p1s;
        Mon,  8 Oct 2018 12:50:49 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 79.1C.04294.9A25BBB5; Mon,  8
        Oct 2018 13:50:49 +0100 (BST)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20181008125049eucas1p21a186cd652f968a3609987d4dee2427f~box6CUtUg0782707827eucas1p2k;
        Mon,  8 Oct 2018 12:50:49 +0000 (GMT)
X-AuditID: cbfec7f4-c77a99c0000010c6-46-5bbb52a9674f
Received: from eusync1.samsung.com ( [203.254.199.211]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 36.39.04128.8A25BBB5; Mon,  8
        Oct 2018 13:50:49 +0100 (BST)
Received: from AMDC2765.digital.local ([106.116.147.25]) by
        eusync1.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0 64bit
        (built May  5 2014)) with ESMTPA id <0PGA006EA6BYW230@eusync1.samsung.com>;
        Mon, 08 Oct 2018 13:50:48 +0100 (BST)
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
Subject: [PATCH 5/7] arm64: dts: exynos: Move arch-timer node to right place
Date:   Mon, 08 Oct 2018 14:50:07 +0200
Message-id: <20181008125009.3721-6-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
In-reply-to: <20181008125009.3721-1-m.szyprowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrIIsWRmVeSWpSXmKPExsWy7djP87org3ZHG+w6rGGxccZ6Vov3y3oY
        La5/ec5qMe+zrMWk+xNYLM6f38BusenxNVaLy7vmsFnMOL+PyWLtkbvsFn/v/GOz2LxpKrPF
        y48nWBx4PdbMW8PosWlVJ5vHnWt72DzenTvH7rF5Sb1H35ZVjB6fN8kFsEdx2aSk5mSWpRbp
        2yVwZcya94mtYCtPxeaZi1kaGNu4uhg5OSQETCTOTHvA3MXIxSEksIJR4vvi++wQzmdGiYt7
        5rLBVB2e2ccIkVjGKDG17TuU08Ak8atpGxNIFZuAoUTX2y6wDhGBbInOxw8YQWxmgUXMEgeO
        CYPYwgI+Ertb/oDVswioSjzvvwhWzytgI7H72mmobfISqzccYAaxOQVsJZ50rWIBWSYhsIdN
        4k1vBztEkYvEv80zWCFsYYlXx7dAxWUkLk/uhmpoZpRonzGLHcLpYZTYOmcH1ApricPHL7JC
        nMcnMWnbdKB1HEBxXomONiGIEg+J7l9HmCDenMAo8XL9ZtYJjJILGBlWMYqnlhbnpqcWG+Wl
        lusVJ+YWl+al6yXn525iBEb06X/Hv+xg3PUn6RCjAAejEg/vioBd0UKsiWXFlbmHGCU4mJVE
        eEW3A4V4UxIrq1KL8uOLSnNSiw8xSnOwKInzLpu3MVpIID2xJDU7NbUgtQgmy8TBKdXA2KdW
        0HGvYv0Og4NdT54GJVjN+2K/dFbAJgdDrRlL3wktMni28vHlwFOdHR/ZC9Nqll1W3DH7Zf62
        b48ntj6JaOMN7nop2rDtcXSja6KI/JdHO5QEZz+13+i+gLFpUt4tn6sm+TMXJK7f/Wya0s/J
        hz4va4w/57yV/bhN0/fbu8obV71foad+b6kSS3FGoqEWc1FxIgCp4lpP5AIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrDLMWRmVeSWpSXmKPExsVy+t/xy7org3ZHG5z3sNg4Yz2rxftlPYwW
        1788Z7WY91nWYtL9CSwW589vYLfY9Pgaq8XlXXPYLGac38dksfbIXXaLv3f+sVls3jSV2eLl
        xxMsDrwea+atYfTYtKqTzePOtT1sHu/OnWP32Lyk3qNvyypGj8+b5ALYo7hsUlJzMstSi/Tt
        ErgyZs37xFawladi88zFLA2MbVxdjJwcEgImEodn9jF2MXJxCAksYZSYenMVG4TTxCSxdPlL
        dpAqNgFDia63XWwgtohAtsT8vd1gcWaBJcwSN+87gNjCAj4Su1v+MIHYLAKqEs/7L4LV8wrY
        SOy+dpoNYpu8xOoNB5hBbE4BW4knXatYQGwhoJre6RdZJzDyLGBkWMUoklpanJueW2ykV5yY
        W1yal66XnJ+7iREYhtuO/dyyg7HrXfAhRgEORiUe3hUBu6KFWBPLiitzDzFKcDArifCKbgcK
        8aYkVlalFuXHF5XmpBYfYpTmYFES5z1vUBklJJCeWJKanZpakFoEk2Xi4JRqYAz9duPYUjX/
        dL+gtbKbJE7svq8z2W+O/o7bJjdvn+rcE8WjmGdt5bZ8k2Dg5f/VG1hu3Whoz/nJ4Jpw9kB6
        4+SiuTwJbnHW36+rec54I3v0reny5G31uc53mGNf/jkwY4aps/1u3jqGy2cqa58m9cp3+eyc
        peok81l1xRMjg+MOLo1WHv5LFiuxFGckGmoxFxUnAgDTtbWmPwIAAA==
X-CMS-MailID: 20181008125049eucas1p21a186cd652f968a3609987d4dee2427f
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181008125049eucas1p21a186cd652f968a3609987d4dee2427f
References: <20181008125009.3721-1-m.szyprowski@samsung.com>
        <CGME20181008125049eucas1p21a186cd652f968a3609987d4dee2427f@eucas1p2.samsung.com>
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
index 77297d66642c..eee3d1d1b52f 100644
--- a/arch/arm64/boot/dts/exynos/exynos5433.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynos5433.dtsi
@@ -290,6 +290,18 @@
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
 		sysram@2020000 {
 			compatible = "mmio-sram";
 			reg = <0x02020000 0x5c000>;
@@ -1811,17 +1823,6 @@
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

