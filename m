Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 257C3C520D3
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 17:48:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4C0821104
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 17:48:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="A6wx/B1l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4C0821104
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731222AbeK3EyM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 23:54:12 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:32970 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731191AbeK3EyK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 23:54:10 -0500
Received: by mail-lf1-f68.google.com with SMTP id i26so2124040lfc.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 09:47:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=edUuds9oK7rq3a7y1o1twsgnSy+L5oYmA4xb9WHJ9+k=;
        b=A6wx/B1lx1+bygG6vNTP5U1cnmX9jGEyu1b3aHBxjvlAIzHP/jh/FWsauGN28VCUzQ
         ljorwL5unf+YDLuCY0t6Ivi4w5Lj71gYb0YXCgZ4jRGr+Jt6dYLG2khG3OERWdIZ5xkY
         Ac65FBUbc5jI8f4Eyk6HdNONOTEhIVUNeWVhQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=edUuds9oK7rq3a7y1o1twsgnSy+L5oYmA4xb9WHJ9+k=;
        b=QuENIF6lvewFh/XAx8E+J0sFi1UmglcFW7r2AMO+2gyhg11s8Nk6ROXwJPNniy/Uvv
         Mqs0GdJaPAi/Z0azEIxfbID2wyVsaGgJBmecZX5W6rtELCJCMp6V/iLZMci+9UDGHwTJ
         H8ny3h2Zp0BC+bxA/4YsLxsBjG7JbZxTLVQOoX+zfGDG8teqVAFvys1pztE4M5cl6geZ
         ApISjJUYMipokKIfS2BpJpXpiV5OA0PYi9XYH11KNCZQwKg7i4uOpQ4ItCRYVFdL3kFb
         bZlS9ODb5f33BBy0iyiGB/YYfNau8/omo40ffJTHRFi0y4voYOQRHGf+kEnuj+2umUD9
         +sbg==
X-Gm-Message-State: AA+aEWZ9hjtDSGDfyObrCT2aaYepjX4N+U5AFfgIt+EVCkWre19/NZja
        aOu3biCxL8II5/fygwqhhYuwEA==
X-Google-Smtp-Source: AFSGD/XVzFGUZimGhzy88XMVy4uhorvpa7/8oAxi7Md22GA4kR2vIjSPoAiN4QAPlVeK/uqUb9G+/Q==
X-Received: by 2002:a19:59c2:: with SMTP id n185mr1558629lfb.118.1543513677002;
        Thu, 29 Nov 2018 09:47:57 -0800 (PST)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id j76-v6sm393983ljb.12.2018.11.29.09.47.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Nov 2018 09:47:56 -0800 (PST)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-pm@vger.kernel.org
Cc:     "Raju P . L . S . S . S . N" <rplsssn@codeaurora.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Kevin Hilman <khilman@kernel.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v10 27/27] arm64: dts: hikey: Convert to the hierarchical CPU topology layout
Date:   Thu, 29 Nov 2018 18:47:00 +0100
Message-Id: <20181129174700.16585-28-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181129174700.16585-1-ulf.hansson@linaro.org>
References: <20181129174700.16585-1-ulf.hansson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To enable the OS to manage last-man standing activities for a CPU, while an
idle state for a group of CPUs is selected, let's convert the Hikey
platform into using the hierarchical CPU topology layout.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes in v10:
	- New patch.

---
 arch/arm64/boot/dts/hisilicon/hi6220.dtsi | 87 ++++++++++++++++++++---
 1 file changed, 76 insertions(+), 11 deletions(-)

diff --git a/arch/arm64/boot/dts/hisilicon/hi6220.dtsi b/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
index 97d5bf2c6ec5..fa5b385cfbc4 100644
--- a/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
@@ -20,6 +20,64 @@
 	psci {
 		compatible = "arm,psci-0.2";
 		method = "smc";
+
+		CPU_PD0: cpu-pd0 {
+			#power-domain-cells = <0>;
+			power-domains = <&CLUSTER_PD0>;
+			domain-idle-states = <&CPU_SLEEP>;
+		};
+
+		CPU_PD1: cpu-pd1 {
+			#power-domain-cells = <0>;
+			power-domains = <&CLUSTER_PD0>;
+			domain-idle-states = <&CPU_SLEEP>;
+		};
+
+		CPU_PD2: cpu-pd2 {
+			#power-domain-cells = <0>;
+			power-domains = <&CLUSTER_PD0>;
+			domain-idle-states = <&CPU_SLEEP>;
+		};
+
+		CPU_PD3: cpu-pd3 {
+			#power-domain-cells = <0>;
+			power-domains = <&CLUSTER_PD0>;
+			domain-idle-states = <&CPU_SLEEP>;
+		};
+
+		CPU_PD4: cpu-pd4 {
+			#power-domain-cells = <0>;
+			power-domains = <&CLUSTER_PD1>;
+			domain-idle-states = <&CPU_SLEEP>;
+		};
+
+		CPU_PD5: cpu-pd5 {
+			#power-domain-cells = <0>;
+			power-domains = <&CLUSTER_PD1>;
+			domain-idle-states = <&CPU_SLEEP>;
+		};
+
+		CPU_PD6: cpu-pd6 {
+			#power-domain-cells = <0>;
+			power-domains = <&CLUSTER_PD1>;
+			domain-idle-states = <&CPU_SLEEP>;
+		};
+
+		CPU_PD7: cpu-pd7 {
+			#power-domain-cells = <0>;
+			power-domains = <&CLUSTER_PD1>;
+			domain-idle-states = <&CPU_SLEEP>;
+		};
+
+		CLUSTER_PD0: cluster-pd0 {
+			#power-domain-cells = <0>;
+			domain-idle-states = <&CLUSTER_SLEEP>;
+		};
+
+		CLUSTER_PD1: cluster-pd1 {
+			#power-domain-cells = <0>;
+			domain-idle-states = <&CLUSTER_SLEEP>;
+		};
 	};
 
 	cpus {
@@ -70,9 +128,8 @@
 			};
 
 			CLUSTER_SLEEP: cluster-sleep {
-				compatible = "arm,idle-state";
-				local-timer-stop;
-				arm,psci-suspend-param = <0x1010000>;
+				compatible = "domain-idle-state";
+				arm,psci-suspend-param = <0x1000000>;
 				entry-latency-us = <1000>;
 				exit-latency-us = <700>;
 				min-residency-us = <2700>;
@@ -88,9 +145,10 @@
 			next-level-cache = <&CLUSTER0_L2>;
 			clocks = <&stub_clock 0>;
 			operating-points-v2 = <&cpu_opp_table>;
-			cpu-idle-states = <&CPU_SLEEP &CLUSTER_SLEEP>;
 			#cooling-cells = <2>; /* min followed by max */
 			dynamic-power-coefficient = <311>;
+			power-domains = <&CPU_PD0>;
+			power-domain-names = "psci";
 		};
 
 		cpu1: cpu@1 {
@@ -101,9 +159,10 @@
 			next-level-cache = <&CLUSTER0_L2>;
 			clocks = <&stub_clock 0>;
 			operating-points-v2 = <&cpu_opp_table>;
-			cpu-idle-states = <&CPU_SLEEP &CLUSTER_SLEEP>;
 			#cooling-cells = <2>; /* min followed by max */
 			dynamic-power-coefficient = <311>;
+			power-domains = <&CPU_PD1>;
+			power-domain-names = "psci";
 		};
 
 		cpu2: cpu@2 {
@@ -114,9 +173,10 @@
 			next-level-cache = <&CLUSTER0_L2>;
 			clocks = <&stub_clock 0>;
 			operating-points-v2 = <&cpu_opp_table>;
-			cpu-idle-states = <&CPU_SLEEP &CLUSTER_SLEEP>;
 			#cooling-cells = <2>; /* min followed by max */
 			dynamic-power-coefficient = <311>;
+			power-domains = <&CPU_PD2>;
+			power-domain-names = "psci";
 		};
 
 		cpu3: cpu@3 {
@@ -127,9 +187,10 @@
 			next-level-cache = <&CLUSTER0_L2>;
 			clocks = <&stub_clock 0>;
 			operating-points-v2 = <&cpu_opp_table>;
-			cpu-idle-states = <&CPU_SLEEP &CLUSTER_SLEEP>;
 			#cooling-cells = <2>; /* min followed by max */
 			dynamic-power-coefficient = <311>;
+			power-domains = <&CPU_PD3>;
+			power-domain-names = "psci";
 		};
 
 		cpu4: cpu@100 {
@@ -140,9 +201,10 @@
 			next-level-cache = <&CLUSTER1_L2>;
 			clocks = <&stub_clock 0>;
 			operating-points-v2 = <&cpu_opp_table>;
-			cpu-idle-states = <&CPU_SLEEP &CLUSTER_SLEEP>;
 			#cooling-cells = <2>; /* min followed by max */
 			dynamic-power-coefficient = <311>;
+			power-domains = <&CPU_PD4>;
+			power-domain-names = "psci";
 		};
 
 		cpu5: cpu@101 {
@@ -153,9 +215,10 @@
 			next-level-cache = <&CLUSTER1_L2>;
 			clocks = <&stub_clock 0>;
 			operating-points-v2 = <&cpu_opp_table>;
-			cpu-idle-states = <&CPU_SLEEP &CLUSTER_SLEEP>;
 			#cooling-cells = <2>; /* min followed by max */
 			dynamic-power-coefficient = <311>;
+			power-domains = <&CPU_PD5>;
+			power-domain-names = "psci";
 		};
 
 		cpu6: cpu@102 {
@@ -166,9 +229,10 @@
 			next-level-cache = <&CLUSTER1_L2>;
 			clocks = <&stub_clock 0>;
 			operating-points-v2 = <&cpu_opp_table>;
-			cpu-idle-states = <&CPU_SLEEP &CLUSTER_SLEEP>;
 			#cooling-cells = <2>; /* min followed by max */
 			dynamic-power-coefficient = <311>;
+			power-domains = <&CPU_PD6>;
+			power-domain-names = "psci";
 		};
 
 		cpu7: cpu@103 {
@@ -179,9 +243,10 @@
 			next-level-cache = <&CLUSTER1_L2>;
 			clocks = <&stub_clock 0>;
 			operating-points-v2 = <&cpu_opp_table>;
-			cpu-idle-states = <&CPU_SLEEP &CLUSTER_SLEEP>;
 			#cooling-cells = <2>; /* min followed by max */
 			dynamic-power-coefficient = <311>;
+			power-domains = <&CPU_PD7>;
+			power-domain-names = "psci";
 		};
 
 		CLUSTER0_L2: l2-cache0 {
-- 
2.17.1

