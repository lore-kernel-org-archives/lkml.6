Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DCFDC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 19:47:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDA1620835
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 19:47:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PAqnRkna"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDA1620835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727665AbeH3Xut (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 19:50:49 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:34648 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726959AbeH3Xuo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 19:50:44 -0400
Received: by mail-lj1-f195.google.com with SMTP id f8-v6so8251688ljk.1;
        Thu, 30 Aug 2018 12:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Lag49zHaI7W74KHWcSc1GzDVdrmpI5PrH+/bPU7poCc=;
        b=PAqnRknaQwgnyChMjVs8bnX/oCeIvGEyTnrtpq+cDQe0L/1E/OvoVp+nV5Ar9Hebmn
         PMrGbqTvzstfM5uqEP7W3jbLRxMDwoI1xUup4CKMQmpNniJOi0waMSqw2Tngfo0LXCI6
         0ICsR34newHI8VsdXDw258oFe32qqqxiz5o14f+3uHkR6eoyc7jHA4C3tgI1UXxRwWT9
         nM6fBpvb/0RfqrahsC8uNzdWp/cxEsVRXaJQ7ejev9Yow7axmmXw10njJ+Qr/k7xjE7T
         QTo/cHSEjFZ5O9FHX5adJaU1pw2ZF2Tq5Hf1dxjRigqwgFwfIQhBplf7/MOX11j+y9kk
         pfrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Lag49zHaI7W74KHWcSc1GzDVdrmpI5PrH+/bPU7poCc=;
        b=kWbMSXtgkwWC+6B/Z7D9ZKlHU7FGtEg9r5ZeA1Iqor/QKtwdeTm2Qz+fT3ttOfwX9t
         5lcS4sJ+ROsxEwTXVEc5eoMExvrkon+ZSPKbjPJSqN2UYm5foktofJkFNsNrCdD1tmJx
         Dohno3JkGWqnsMVxqXq0BxJWVd1va5m+wQNlPpD8LhwDMoTzBmwhWFOwRom4tIgvv4Uw
         gKTSD/9kOAxNCzuQkjPyLc265jK8j4jBOdt/8MEetulNd/WwXC34oKpW3tJa9k8AyBK4
         rtemZuyP2QUvjZ1AvCV1ClSPWP1EGvYWGvJqD9Gjyiea4FRCQeZ2xvK90GLBmQSFPzdK
         NWXQ==
X-Gm-Message-State: APzg51BYctd7VgVVCls3zV0c7wY3WQj/tiwZadevX87ucu4la4d8PHhL
        xY7J01DNAFj8XFeKs1j8MR4=
X-Google-Smtp-Source: ANB0VdZHtqjnqZvaHmj8/RcSttsKyrS5cjytlPOuD4qHPQQpXqBmQqLK4Kx+NT/40qDtKGqFtCsxHg==
X-Received: by 2002:a2e:4619:: with SMTP id t25-v6mr8739856lja.96.1535658416275;
        Thu, 30 Aug 2018 12:46:56 -0700 (PDT)
Received: from localhost.localdomain (109-252-90-13.nat.spd-mgts.ru. [109.252.90.13])
        by smtp.gmail.com with ESMTPSA id x3-v6sm1381191ljb.25.2018.08.30.12.46.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Aug 2018 12:46:55 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 5/5] ARM: dts: tegra30: Add CPU Operating Performance Points
Date:   Thu, 30 Aug 2018 22:43:56 +0300
Message-Id: <20180830194356.14059-6-digetx@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180830194356.14059-1-digetx@gmail.com>
References: <20180830194356.14059-1-digetx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add CPU's Operating Performance Points to the device tree, they are used
by the CPUFreq driver and allow to setup thermal throttling for the boards
by linking the cooling device (CPU) with thermal sensors via thermal-zones
description.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/arm/boot/dts/tegra30.dtsi | 65 ++++++++++++++++++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/arch/arm/boot/dts/tegra30.dtsi b/arch/arm/boot/dts/tegra30.dtsi
index 37c4757516d2..5c8098bdfb2a 100644
--- a/arch/arm/boot/dts/tegra30.dtsi
+++ b/arch/arm/boot/dts/tegra30.dtsi
@@ -980,6 +980,47 @@
 		status = "disabled";
 	};
 
+	cpu0_opp_table: opp_table0 {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		opp@408000000 {
+			clock-latency-ns = <2000>;
+			opp-hz = /bits/ 64 <408000000>;
+			opp-suspend;
+		};
+
+		opp@456000000 {
+			clock-latency-ns = <50000>;
+			opp-hz = /bits/ 64 <456000000>;
+		};
+
+		opp@608000000 {
+			clock-latency-ns = <50000>;
+			opp-hz = /bits/ 64 <608000000>;
+		};
+
+		opp@760000000 {
+			clock-latency-ns = <50000>;
+			opp-hz = /bits/ 64 <760000000>;
+		};
+
+		opp@816000000 {
+			clock-latency-ns = <50000>;
+			opp-hz = /bits/ 64 <816000000>;
+		};
+
+		opp@912000000 {
+			clock-latency-ns = <50000>;
+			opp-hz = /bits/ 64 <912000000>;
+		};
+
+		opp@1000000000 {
+			clock-latency-ns = <50000>;
+			opp-hz = /bits/ 64 <1000000000>;
+		};
+	};
+
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -988,24 +1029,48 @@
 			device_type = "cpu";
 			compatible = "arm,cortex-a9";
 			reg = <0>;
+			clocks = <&tegra_car TEGRA30_CLK_PLL_X>,
+				 <&tegra_car TEGRA30_CLK_PLL_P>,
+				 <&tegra_car TEGRA30_CLK_CCLK_G>;
+			clock-names = "pll_x", "backup", "cpu";
+			operating-points-v2 = <&cpu0_opp_table>;
+			#cooling-cells = <2>;
 		};
 
 		cpu@1 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a9";
 			reg = <1>;
+			clocks = <&tegra_car TEGRA30_CLK_PLL_X>,
+				 <&tegra_car TEGRA30_CLK_PLL_P>,
+				 <&tegra_car TEGRA30_CLK_CCLK_G>;
+			clock-names = "pll_x", "backup", "cpu";
+			operating-points-v2 = <&cpu0_opp_table>;
+			#cooling-cells = <2>;
 		};
 
 		cpu@2 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a9";
 			reg = <2>;
+			clocks = <&tegra_car TEGRA30_CLK_PLL_X>,
+				 <&tegra_car TEGRA30_CLK_PLL_P>,
+				 <&tegra_car TEGRA30_CLK_CCLK_G>;
+			clock-names = "pll_x", "backup", "cpu";
+			operating-points-v2 = <&cpu0_opp_table>;
+			#cooling-cells = <2>;
 		};
 
 		cpu@3 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a9";
 			reg = <3>;
+			clocks = <&tegra_car TEGRA30_CLK_PLL_X>,
+				 <&tegra_car TEGRA30_CLK_PLL_P>,
+				 <&tegra_car TEGRA30_CLK_CCLK_G>;
+			clock-names = "pll_x", "backup", "cpu";
+			operating-points-v2 = <&cpu0_opp_table>;
+			#cooling-cells = <2>;
 		};
 	};
 
-- 
2.18.0

