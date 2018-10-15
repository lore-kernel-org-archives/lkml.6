Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E955C71133
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 18:41:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0A0A208B3
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 18:41:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ACYsj79Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0A0A208B3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727049AbeJPC1f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 22:27:35 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:41482 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727028AbeJPC1f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 22:27:35 -0400
Received: by mail-pg1-f196.google.com with SMTP id 23-v6so9569743pgc.8
        for <linux-kernel@vger.kernel.org>; Mon, 15 Oct 2018 11:41:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=bFmpkKZBQAbbZS/QFSkahIqwskTA5OAWzb+7WJWC4Ak=;
        b=ACYsj79ZN7/1tmPHStu1S/GzpFncJaRgzF2auSIcWuMe4YTEXTXXu3+oUpkuAFcOOC
         GFvh5L1x8ywdDGWGBOOKe4tcnLTg7JIlZP9M7EDyqlzI3n89+u8XUnmRC3iTzJae2fJx
         94Zu4PSWORdx7VeQCfRmWZXRro4J3jqD5APS0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=bFmpkKZBQAbbZS/QFSkahIqwskTA5OAWzb+7WJWC4Ak=;
        b=bMauz+lmG0reIx15S+uCurQslvhWvOGz7R6S5fNdar45i2EC7fwXF38gswRsBJTi/2
         Hxt/MgJ/4OjWIKHTKG1/ADPr2NIgLHJftF22De1FgUWLVDUS2agy9NDoQs+vimIszVAE
         DsYyymQ6xGq6hOplNSbwq2ixnc9mCDGi4dZtal1go6XRkwKhMyLth2YbsG2sUT6eUEQa
         VvlyGSYndWPyTGu8OIAKBuNz3C5DS/Kwr75SEzagmSLzkFzbmfG5GKa/zn5fNRkKfL9m
         ZVxKa2ge3XB51S3KQbUVPnMnRGOGelDdGdqYRiZ4j1585HpwxUwUm+h6yLjxz42MBp+o
         +Ujg==
X-Gm-Message-State: ABuFfoiKACxJH7M2lszVCvIJWMwBgkN4/6Ch7GPcImMd3350Onx5x8Da
        ws37e0MVkd0TOqw5a+d4evtLe6ghnhs=
X-Google-Smtp-Source: ACcGV61doTAgPAcfpYsvw+p47Nzl4Xw+FAqg8lEzswxY6VQz9s9eo83n8r1IJ4gnPXl2B+2QqG1ujA==
X-Received: by 2002:a62:8a91:: with SMTP id o17-v6mr18843627pfk.184.1539628867423;
        Mon, 15 Oct 2018 11:41:07 -0700 (PDT)
Received: from localhost ([49.248.168.189])
        by smtp.gmail.com with ESMTPSA id m11-v6sm13170474pgn.39.2018.10.15.11.41.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 15 Oct 2018 11:41:06 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arm-msm@vger.kernel.org, bjorn.andersson@linaro.org,
        edubezval@gmail.com, andy.gross@linaro.org, vkoul@kernel.org,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v1 4/4] arm64: dts: qcom: qcs404: Add thermal zones for each sensor
Date:   Tue, 16 Oct 2018 00:10:43 +0530
Message-Id: <7a0c3d8b7a751d6549b063efee718cdb1741f473.1539627762.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1539627762.git.amit.kucheria@linaro.org>
References: <cover.1539627762.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1539627762.git.amit.kucheria@linaro.org>
References: <cover.1539627762.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

qcs404 has 10 sensors connected to the single TSENS IP. Define a thermal
zone for each of those sensors to expose the temperature of each zone.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 arch/arm64/boot/dts/qcom/qcs404.dtsi | 206 +++++++++++++++++++++++++++
 1 file changed, 206 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qcs404.dtsi b/arch/arm64/boot/dts/qcom/qcs404.dtsi
index dfd65c53cf5f..ea882a9ce6e3 100644
--- a/arch/arm64/boot/dts/qcom/qcs404.dtsi
+++ b/arch/arm64/boot/dts/qcom/qcs404.dtsi
@@ -69,6 +69,7 @@
 			reg = <0x100>;
 			enable-method = "psci";
 			next-level-cache = <&L2_0>;
+			#cooling-cells= <2>;
 		};
 
 		CPU1: cpu@1 {
@@ -77,6 +78,7 @@
 			reg = <0x101>;
 			enable-method = "psci";
 			next-level-cache = <&L2_0>;
+			#cooling-cells= <2>;
 		};
 
 		CPU2: cpu@2 {
@@ -85,6 +87,7 @@
 			reg = <0x102>;
 			enable-method = "psci";
 			next-level-cache = <&L2_0>;
+			#cooling-cells= <2>;
 		};
 
 		CPU3: cpu@3 {
@@ -93,6 +96,7 @@
 			reg = <0x100>;
 			enable-method = "psci";
 			next-level-cache = <&L2_0>;
+			#cooling-cells= <2>;
 		};
 
 		L2_0: l2-cache {
@@ -484,4 +488,206 @@
 			label = "wcss";
 		};
 	};
+
+	thermal-zones {
+		aoss-thermal {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+
+			thermal-sensors = <&tsens 0>;
+
+			trips {
+				aoss_alert: trip0 {
+					temperature = <75000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+				aoss_crit: trip1 {
+					temperature = <95000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
+		};
+
+		dsp-thermal {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+
+			thermal-sensors = <&tsens 1>;
+
+			trips {
+				dsp_alert: trip0 {
+					temperature = <75000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+				dsp_crit: trip1 {
+					temperature = <95000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
+		};
+
+		lpass-thermal {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+
+			thermal-sensors = <&tsens 2>;
+
+			trips {
+				lpass_alert: trip0 {
+					temperature = <75000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+				lpass_crit: trip1 {
+					temperature = <95000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
+		};
+
+		wlan-thermal {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+
+			thermal-sensors = <&tsens 3>;
+
+			trips {
+				wlan_alert: trip0 {
+					temperature = <75000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+				wlan_crit: trip1 {
+					temperature = <95000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
+		};
+
+		cluster-thermal {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+
+			thermal-sensors = <&tsens 4>;
+
+			trips {
+				cluster_alert: cluster_alert {
+					temperature = <75000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+				cluster_crit: cluster_crit {
+					temperature = <110000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
+		};
+
+		cpu-thermal0 {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+
+			thermal-sensors = <&tsens 5>;
+
+			trips {
+				cpu_alert0: cpu_alert0 {
+					temperature = <75000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+				cpu_crit0: cpu_crit0 {
+					temperature = <110000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
+		};
+
+		cpu-thermal1 {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+
+			thermal-sensors = <&tsens 6>;
+
+			trips {
+				cpu_alert1: trip0 {
+					temperature = <75000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+				cpu_crit1: trip1 {
+					temperature = <110000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
+		};
+
+		cpu-thermal2 {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+
+			thermal-sensors = <&tsens 7>;
+
+			trips {
+				cpu_alert2: trip0 {
+					temperature = <75000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+				cpu_crit2: trip1 {
+					temperature = <110000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
+		};
+
+		cpu-thermal3 {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+
+			thermal-sensors = <&tsens 8>;
+
+			trips {
+				cpu_alert3: trip0 {
+					temperature = <75000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+				cpu_crit3: trip1 {
+					temperature = <110000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
+		};
+
+		gpu-thermal {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+
+			thermal-sensors = <&tsens 9>;
+
+			trips {
+				gpu_alert: trip0 {
+					temperature = <75000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+				gpu_crit: trip1 {
+					temperature = <95000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
+		};
+	};
 };
-- 
2.17.1

