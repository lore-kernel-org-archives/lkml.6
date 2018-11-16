Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E673EC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 10:01:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A647D208E7
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 10:01:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="khGGSh6g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A647D208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389549AbeKPUN0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 15:13:26 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:41435 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389532AbeKPUNZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 15:13:25 -0500
Received: by mail-pf1-f196.google.com with SMTP id e22-v6so11167619pfn.8
        for <linux-kernel@vger.kernel.org>; Fri, 16 Nov 2018 02:01:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mKdk4u9uuV3/V2n+XEiMfTYkJhxf8c+bfGxxkDgZOEY=;
        b=khGGSh6gI7N4doAVpcL7uHa6DTmcuayGAhPPhSeVUzm8qrVeFuR73wyRDo5XnVxV7k
         606J6cOTrAoNwuoRQ32KZAyKgm1z9ROrNviT9yHvnAr9mrAuL9x6tOisotVK/xmk0OHB
         RG+dFDEKQDjLc7z9NBsfn3lYTgPzUxC+YeJGs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mKdk4u9uuV3/V2n+XEiMfTYkJhxf8c+bfGxxkDgZOEY=;
        b=gRXx/pariwSR0CjNrn2YqEpF7H7J5x9ZCWY6tH66oKtIGq3Y2MxpGAMfh+jZcWBf67
         FneJjG9Kw/XFbkxQ6kaxUe1RH45w0DMiKNlmwXJcCGO4RpYAlONpr/2N3LjKFfDTjqvp
         iak4gX5d+3owQt5LJoQ3Gjn8COruV1ik2Gcx83SlNaIK0xq7Yn+V8PvbiEoyDjG5Hr6B
         TEj1lY3HL+ViUFKeQmn/41WXg1qkqCOZBZvtgcr4bHO98jADaO7WAILOGmLVdimdeHFI
         NIpvAO4CRlDR7pjJNFTjv/Vm+7M6kb6LkD4fUILO9wQ01VkbQ6pNYoG2wuVFKbdDzppD
         uodA==
X-Gm-Message-State: AGRZ1gK+Qxc/ZcndZ7cMQXmUjK9PPFiSGiqqNJTnuBMg1+XHVsgowWRU
        VMaU2qKVbMpwtpMf7CaVh9YDEw==
X-Google-Smtp-Source: AJdET5eXq6l7stfr9qN5pRZ5Cb2+y06vwTIGaWCuynlUfu8fYZthALuyZNzGWJK0NGX5SUJXn21vwQ==
X-Received: by 2002:a62:798f:: with SMTP id u137mr7491081pfc.168.1542362508571;
        Fri, 16 Nov 2018 02:01:48 -0800 (PST)
Received: from localhost ([122.172.88.116])
        by smtp.gmail.com with ESMTPSA id y71-v6sm37238045pfk.70.2018.11.16.02.01.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Nov 2018 02:01:48 -0800 (PST)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, devicetree@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 5/6] ARM: dts: sunxi: Add all CPUs in cooling maps
Date:   Fri, 16 Nov 2018 15:31:14 +0530
Message-Id: <b2524a2db87c97c038990af405bd1cca25e579f8.1542362000.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.19.1.568.g152ad8e3369a
In-Reply-To: <cover.1542362000.git.viresh.kumar@linaro.org>
References: <cover.1542362000.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Each CPU can (and does) participate in cooling down the system but the
DT only captures a handful of them, normally CPU0, in the cooling maps.
Things work by chance currently as under normal circumstances its the
first CPU of each cluster which is used by the operating systems to
probe the cooling devices. But as soon as this CPU ordering changes and
any other CPU is used to bring up the cooling device, we will start
seeing failures.

Also the DT is rather incomplete when we list only one CPU in the
cooling maps, as the hardware doesn't have any such limitations.

Update cooling maps to include all devices affected by individual trip
points.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 arch/arm/boot/dts/sun6i-a31.dtsi | 11 +++++++----
 arch/arm/boot/dts/sun7i-a20.dtsi |  5 +++--
 arch/arm/boot/dts/sun8i-a33.dtsi | 16 +++++++++++-----
 3 files changed, 21 insertions(+), 11 deletions(-)

diff --git a/arch/arm/boot/dts/sun6i-a31.dtsi b/arch/arm/boot/dts/sun6i-a31.dtsi
index debc0bf22ea3..1eaa60cd3218 100644
--- a/arch/arm/boot/dts/sun6i-a31.dtsi
+++ b/arch/arm/boot/dts/sun6i-a31.dtsi
@@ -115,7 +115,7 @@
 			#cooling-cells = <2>;
 		};
 
-		cpu@1 {
+		cpu1: cpu@1 {
 			compatible = "arm,cortex-a7";
 			device_type = "cpu";
 			reg = <1>;
@@ -131,7 +131,7 @@
 			#cooling-cells = <2>;
 		};
 
-		cpu@2 {
+		cpu2: cpu@2 {
 			compatible = "arm,cortex-a7";
 			device_type = "cpu";
 			reg = <2>;
@@ -147,7 +147,7 @@
 			#cooling-cells = <2>;
 		};
 
-		cpu@3 {
+		cpu3: cpu@3 {
 			compatible = "arm,cortex-a7";
 			device_type = "cpu";
 			reg = <3>;
@@ -174,7 +174,10 @@
 			cooling-maps {
 				map0 {
 					trip = <&cpu_alert0>;
-					cooling-device = <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+					cooling-device = <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
 				};
 			};
 
diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
index 02e40da9f028..b4fd4f5ca66b 100644
--- a/arch/arm/boot/dts/sun7i-a20.dtsi
+++ b/arch/arm/boot/dts/sun7i-a20.dtsi
@@ -118,7 +118,7 @@
 			#cooling-cells = <2>;
 		};
 
-		cpu@1 {
+		cpu1: cpu@1 {
 			compatible = "arm,cortex-a7";
 			device_type = "cpu";
 			reg = <1>;
@@ -148,7 +148,8 @@
 			cooling-maps {
 				map0 {
 					trip = <&cpu_alert0>;
-					cooling-device = <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+					cooling-device = <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
 				};
 			};
 
diff --git a/arch/arm/boot/dts/sun8i-a33.dtsi b/arch/arm/boot/dts/sun8i-a33.dtsi
index c1cc8f09dd9a..502de6f44a9a 100644
--- a/arch/arm/boot/dts/sun8i-a33.dtsi
+++ b/arch/arm/boot/dts/sun8i-a33.dtsi
@@ -131,14 +131,14 @@
 			#cooling-cells = <2>;
 		};
 
-		cpu@1 {
+		cpu1: cpu@1 {
 			clocks = <&ccu CLK_CPUX>;
 			clock-names = "cpu";
 			operating-points-v2 = <&cpu0_opp_table>;
 			#cooling-cells = <2>;
 		};
 
-		cpu@2 {
+		cpu2: cpu@2 {
 			compatible = "arm,cortex-a7";
 			device_type = "cpu";
 			reg = <2>;
@@ -148,7 +148,7 @@
 			#cooling-cells = <2>;
 		};
 
-		cpu@3 {
+		cpu3: cpu@3 {
 			compatible = "arm,cortex-a7";
 			device_type = "cpu";
 			reg = <3>;
@@ -479,11 +479,17 @@
 			cooling-maps {
 				map0 {
 					trip = <&cpu_alert0>;
-					cooling-device = <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+					cooling-device = <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
 				};
 				map1 {
 					trip = <&cpu_alert1>;
-					cooling-device = <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+					cooling-device = <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
 				};
 
 				map2 {
-- 
2.19.1.568.g152ad8e3369a

