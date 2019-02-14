Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9904BC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 13:09:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68336222B6
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 13:09:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vrxqex71"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438754AbfBNNJk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 08:09:40 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:43134 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436747AbfBNNJf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 08:09:35 -0500
Received: by mail-pl1-f193.google.com with SMTP id f90so3143199plb.10;
        Thu, 14 Feb 2019 05:09:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ofA8+5OQRWMQvRz/8D4Xr5InC1D52UQFLM4xDydHYFs=;
        b=Vrxqex71isZH7GRRW9BY6yHvd50IjDOjwgwxImUDtgkxn++JflpMl0l0dEC/hAKngc
         vMC064RwxVzhgdExZCCBopR80w/3pPKQqhGt9gd2oVwFLY8cDU98FvA6AAJTRtNR1KJH
         aVZeKe+wpl+U6eiPuhojdUqhUSXkzpqS3uP6HWN3HYkDR4T3y1xV+E0Nz/K24BEnTPXm
         cRG1KnTMCJQEUWyldNwiXrEWGdbOf1gxzH3t5sTUeem3sQxpIfAp9YNyJAPX71SDPwUK
         fY/wac7iVWBYc2pkUFGKn/3HOAYOjvNNlDVP9RH9GyuJZArpwSEw4vVdfUL2fKjYIqik
         0S2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ofA8+5OQRWMQvRz/8D4Xr5InC1D52UQFLM4xDydHYFs=;
        b=ceXw6dGlB9KQpLo/5nv46ZZbnYBmJhjH7PS26XzAKiy00tklygfOKYDb12J+JhVNQm
         Hjk4iuwI8bbv1uftOeP7GKV3z+/i4Qv5gOYC28B515pmBJCTbHh+xqXRa85uo84LV/mg
         IAGVfKZJFLT50QiSFg/WhCRw+r1b+7bhrZxO5PIqq4siO2bhe9qr6X9l+Yjwt6RPwzqq
         fbAhcnmg2vNNpGvG8WWtpjeqNaY6J5rSi1AkON7rZlixoyjn1NPBmSEDE5hEaVIPXEGp
         mE2/vIDCR1Pj1Rnfir+E3ERdcADGPaS1CXmDgSL44AEj3Ut2H17brd5OLAFd4NDAAtCy
         QEWA==
X-Gm-Message-State: AHQUAuYS2KNsiY41Ix+cjd5cybdG8bvxFyy4CaSlX/H7csEKhkAvXuDn
        bYMVDg+VORPbFO2jq9rsYWw=
X-Google-Smtp-Source: AHgI3IbX91T+syXYN7LWYJkdosLGW6PfkvSFvASEsnDCCb8pcgVeBNx9t2ByfEwgSO1gcfezi+bSng==
X-Received: by 2002:a17:902:129:: with SMTP id 38mr4110852plb.140.1550149775352;
        Thu, 14 Feb 2019 05:09:35 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id b15sm8159128pfj.44.2019.02.14.05.09.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 14 Feb 2019 05:09:34 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     maxime.ripard@bootlin.com, wens@csie.org, robh+dt@kernel.org
Cc:     mark.rutland@arm.com, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH 4/4] arm64: dts: allwinner: h6: Add CPU Operating Performance Points table
Date:   Thu, 14 Feb 2019 08:09:10 -0500
Message-Id: <20190214130910.9201-5-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190214130910.9201-1-tiny.windzz@gmail.com>
References: <20190214130910.9201-1-tiny.windzz@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add an OPP (Operating Performance Points) table for the CPU cores to
enable DVFS (Dynamic Voltage & Frequency Scaling) on the H6. This
information comes from github.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi | 61 ++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
index 57a1390ecdc2..46a4a69eb38f 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
@@ -28,6 +28,8 @@
 			enable-method = "psci";
 			clocks = <&ccu CLK_CPUX>; 
 			clock-latency-ns = <244144>; /* 8 32k periods */
+			operating-points-v2 = <&cpu_opp_table>;
+			#cooling-cells = <2>;
 		};
 
 		cpu1: cpu@1 {
@@ -37,6 +39,8 @@
 			enable-method = "psci";
 			clocks = <&ccu CLK_CPUX>; 
 			clock-latency-ns = <244144>; /* 8 32k periods */
+			operating-points-v2 = <&cpu_opp_table>;
+			#cooling-cells = <2>;
 		};
 
 		cpu2: cpu@2 {
@@ -46,6 +50,8 @@
 			enable-method = "psci";
 			clocks = <&ccu CLK_CPUX>; 
 			clock-latency-ns = <244144>; /* 8 32k periods */
+			operating-points-v2 = <&cpu_opp_table>;
+			#cooling-cells = <2>;
 		};
 
 		cpu3: cpu@3 {
@@ -55,6 +61,61 @@
 			enable-method = "psci";
 			clocks = <&ccu CLK_CPUX>; 
 			clock-latency-ns = <244144>; /* 8 32k periods */
+			operating-points-v2 = <&cpu_opp_table>;
+			#cooling-cells = <2>;
+		};
+	};
+
+	cpu_opp_table: opp_table {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		opp@480000000 {
+			opp-hz = /bits/ 64 <480000000>;
+			opp-microvolt = <800000 800000 880000>;
+			clock-latency-ns = <244144>; /* 8 32k periods */
+		};
+
+		opp@720000000 {
+			opp-hz = /bits/ 64 <720000000>;
+			opp-microvolt = <800000 800000 880000>;
+			clock-latency-ns = <244144>; /* 8 32k periods */
+		};
+
+		opp@816000000 {
+			opp-hz = /bits/ 64 <816000000>;
+			opp-microvolt = <800000 800000 880000>;
+			clock-latency-ns = <244144>; /* 8 32k periods */
+		};
+
+		opp@888000000 {
+			opp-hz = /bits/ 64 <888000000>;
+			opp-microvolt = <800000 800000 940000>;
+			clock-latency-ns = <244144>; /* 8 32k periods */
+		};
+
+		opp@1080000000 {
+			opp-hz = /bits/ 64 <1080000000>;
+			opp-microvolt = <840000 840000 1060000>;
+			clock-latency-ns = <244144>; /* 8 32k periods */
+		};
+
+		opp@1320000000 {
+			opp-hz = /bits/ 64 <1320000000>;
+			opp-microvolt = <900000 900000 1160000>;
+			clock-latency-ns = <244144>; /* 8 32k periods */
+		};
+
+		opp@1488000000 {
+			opp-hz = /bits/ 64 <1488000000>;
+			opp-microvolt = <960000 960000 1160000>;
+			clock-latency-ns = <244144>; /* 8 32k periods */
+		};
+
+		opp@1800000000 {
+			opp-hz = /bits/ 64 <1800000000>;
+			opp-microvolt = <1060000 1060000 1160000>;
+			clock-latency-ns = <244144>; /* 8 32k periods */
 		};
 	};
 
-- 
2.17.0

