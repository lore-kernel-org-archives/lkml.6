Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFA72C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 12:26:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C22120831
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 12:26:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="WKSXXSG+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C22120831
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728897AbeKSWtp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 17:49:45 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39458 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728872AbeKSWto (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 17:49:44 -0500
Received: by mail-wm1-f65.google.com with SMTP id u13-v6so5045788wmc.4
        for <linux-kernel@vger.kernel.org>; Mon, 19 Nov 2018 04:26:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=RWlU1LSwFAx6oov/bJmjYlsstO2SymtzOQNbuVyVIRA=;
        b=WKSXXSG+em8s0+pLK1Y9+pBR6bqDlIlElS09l0Y8J67kJa55X0C6kUKW/3mLQJeIy9
         52tbFT5/+fzxq/xerKyo3KLt2EvBMmFc3wKfuCz9VjL1KBIRT5lrtsvRznITCWchcHTE
         u81HPdUeNo6LKBfm6FvzAEc1amCjIQr9jU8G0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=RWlU1LSwFAx6oov/bJmjYlsstO2SymtzOQNbuVyVIRA=;
        b=Yo4o10FZU0Na9TFG0Fd7JRwAaIDZ/wZathUH8C+jOPg/A6wwak0H5OGU1/fVF0u6wM
         VqVPIvgCpRDdd0rc1DfOGupvRXVFp3b65vDNXIZjjAp7rhcHdbE2In+CbVTI+LLO3okv
         KLbMbcT1SMRNRoJFXJJjDs8XtM9sKFVtfEDswwQZB+osLhlWmk2yF/y3Lbjuf8oXoOtM
         2ZolcvruulrQY7H5iXFjCVC7jesI8gIF8mwHZ1sE+gSIVp84iwpIeiRmEY+sV81hqNvF
         FsbaUgrORihBEw0ara0HAbtkJMWxdAh7QbgfydrrXhWQ8ASCzpngXUXnSgfjAhgEomOs
         4/xA==
X-Gm-Message-State: AGRZ1gJ/C7beyd2NxFaa6LYB872gwLiHjx6Xg4IGTnIL2yZoo59WIaJ4
        yMDYgWpzCGI30ru4g9ifB627jMXUhao=
X-Google-Smtp-Source: AJdET5dpNWr4lI7l3wBqj9nxebZk/jrd9txpTznsDQyD1L3qL3OSD3GM+TRSTQivpO19HLuLZL1hVA==
X-Received: by 2002:a1c:7d54:: with SMTP id y81mr6913645wmc.106.1542630373963;
        Mon, 19 Nov 2018 04:26:13 -0800 (PST)
Received: from localhost ([49.248.195.80])
        by smtp.gmail.com with ESMTPSA id a18-v6sm35058384wrt.79.2018.11.19.04.26.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 19 Nov 2018 04:26:13 -0800 (PST)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arm-msm@vger.kernel.org, bjorn.andersson@linaro.org,
        edubezval@gmail.com, andy.gross@linaro.org, vkoul@kernel.org,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v2 4/4] arm64: dts: qcom: qcs404: Add thermal zones for each sensor
Date:   Mon, 19 Nov 2018 17:55:22 +0530
Message-Id: <4c95177d5454421fb789cb67da94181af2a0370d.1542629810.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1542629810.git.amit.kucheria@linaro.org>
References: <cover.1542629810.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1542629810.git.amit.kucheria@linaro.org>
References: <cover.1542629810.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

qcs404 has 10 sensors connected to the single TSENS IP. Define a thermal
zone for each of those sensors to expose the temperature of each zone.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
Reviewed-by: Vinod Koul <vkoul@kernel.org>
Tested-by: Vinod Koul <vkoul@kernel.org>
---
 arch/arm64/boot/dts/qcom/qcs404.dtsi | 206 +++++++++++++++++++++++++++
 1 file changed, 206 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qcs404.dtsi b/arch/arm64/boot/dts/qcom/qcs404.dtsi
index 57d14d8f0c901..cbc3fd3788938 100644
--- a/arch/arm64/boot/dts/qcom/qcs404.dtsi
+++ b/arch/arm64/boot/dts/qcom/qcs404.dtsi
@@ -30,6 +30,7 @@
 			reg = <0x100>;
 			enable-method = "psci";
 			next-level-cache = <&L2_0>;
+			#cooling-cells= <2>;
 		};
 
 		CPU1: cpu@101 {
@@ -38,6 +39,7 @@
 			reg = <0x101>;
 			enable-method = "psci";
 			next-level-cache = <&L2_0>;
+			#cooling-cells= <2>;
 		};
 
 		CPU2: cpu@102 {
@@ -46,6 +48,7 @@
 			reg = <0x102>;
 			enable-method = "psci";
 			next-level-cache = <&L2_0>;
+			#cooling-cells= <2>;
 		};
 
 		CPU3: cpu@103 {
@@ -54,6 +57,7 @@
 			reg = <0x103>;
 			enable-method = "psci";
 			next-level-cache = <&L2_0>;
+			#cooling-cells= <2>;
 		};
 
 		L2_0: l2-cache {
@@ -507,4 +511,206 @@
 			#interrupt-cells = <2>;
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

