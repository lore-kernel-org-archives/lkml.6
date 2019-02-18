Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44832C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 12:36:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FC77217D7
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 12:36:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="O787LItj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730696AbfBRMgD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 07:36:03 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37689 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730621AbfBRMgC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 07:36:02 -0500
Received: by mail-wm1-f66.google.com with SMTP id x10so16808079wmg.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Feb 2019 04:36:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=ssMp2Pe32HI1MMC/wAOh7tQF9HUmue5BH2ZmF71FZeU=;
        b=O787LItjmkEXtGdpkelQdSlXmvzwr1PvV+JJj7+Zz3z2hhI2QqqYDIOJ1QvLtyv2fy
         9vbqhAvhsJtmKZcTyCafuNQp8kXCGyhlp+2QLx8BX179kUXNU/TgneG3HZDYhgVDaGLg
         Q22F7ukU6y2DpVruvOicJQS3vYMuSiKRnNOjTyfvPkqOSC0eWGAuqUVvL7p1SPGh+q67
         csCJQjhFYUl72gXfjUVA/OmnGjw210T/aRmXWE31bcAM/iMh3x3hxx3HkdCxijPnaKsW
         wx+nNR2v5CfztBbOmxLBKheEMH27RQgQw4hLdjMem/oX1vndOLmwhaBL2nC1yT26ln1p
         aQJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=ssMp2Pe32HI1MMC/wAOh7tQF9HUmue5BH2ZmF71FZeU=;
        b=n7AG+YmGaGHgIpos3fxj1xxP2MIRfU0RkCKBdG58Z561NT9OaDTJFvG73WpPVsk9lp
         3cnrQsLvu/W+IAco8A3yIDStUbr4oyHWjJjsOA4xiBHHdtWHOibAC6gNhePfW/Nr7YpP
         twM4XpdYX8t0aesFmg+hD1c9Q0mSUjH0TzlHgydAlpZiAnO2DwV4PuUBxJYevm9c+ciz
         a/4IbIbE+TYv7UFwU7UwXTwxtHuAdQkvxG0opgxz8WzgxeEKdsQqQYNqHNNFlKz8kk3P
         SJZ80INdMn75oufTi4yiD8Wxu7v5qLhveGlisxfJ5xMk91x0K4ULDM7ETVoWQEmmvj32
         idNg==
X-Gm-Message-State: AHQUAuZ0J/aR8Png0rnpwTQISpREOENBivcxIROgxLFdnmBNmgzFG8Jx
        7uFCoC5Wb5FLPH5uilJQClmyc8GYf9s=
X-Google-Smtp-Source: AHgI3IZYz4hK5voq6Do/+pixeyUbyt7GnzoWL9OBtoGDDRjcrI4xt/4DOr2RTJCohbUx0yiuc3gldg==
X-Received: by 2002:a1c:6306:: with SMTP id x6mr389506wmb.144.1550493360831;
        Mon, 18 Feb 2019 04:36:00 -0800 (PST)
Received: from localhost ([49.248.190.152])
        by smtp.gmail.com with ESMTPSA id h1sm15703213wmb.0.2019.02.18.04.35.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 Feb 2019 04:36:00 -0800 (PST)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com,
        andy.gross@linaro.org, David Brown <david.brown@linaro.org>
Cc:     devicetree@vger.kernel.org
Subject: [PATCH v1 04/12] arm64: dts: msm8996: thermal: Add temperature sensors near major peripherals
Date:   Mon, 18 Feb 2019 18:05:18 +0530
Message-Id: <51feb49578f6e412eb5e80012dc63eab5532342b.1550493113.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1550493113.git.amit.kucheria@linaro.org>
References: <cover.1550493113.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1550493113.git.amit.kucheria@linaro.org>
References: <cover.1550493113.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

msm8996 has a total of 21 temperature sensors. Populate DT with
information about them.

There are 2 sensors on each of the cpus - one on the top, the other
below (we only expose one on the top in DT for now). For the GPU, we
expose both, the one on the top and the one below.

Depending on the version of the silicon, sensor 2 is either placed near
the L3 cache or the venus video decoder. It would've been nice to be
able to be version-specific but we don't have DTs that differentiate the
two versions of silicon yet.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8996.dtsi | 98 +++++++++++++++++++++++++++
 1 file changed, 98 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
index ae6e9f0778f0..8e36a39e1386 100644
--- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
@@ -237,6 +237,104 @@
 				};
 			};
 		};
+
+		gpu-thermal-top {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+
+			thermal-sensors = <&tsens1 6>;
+
+			trips {
+				gpu1_alert0: trip-point@0 {
+					temperature = <75000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
+				gpu1_crit: gpu_crit {
+					temperature = <95000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
+		};
+
+		gpu-thermal-bottom {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+
+			thermal-sensors = <&tsens1 7>;
+
+			trips {
+				gpu2_alert0: trip-point@0 {
+					temperature = <75000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
+				gpu2_crit: gpu_crit {
+					temperature = <95000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
+		};
+
+		m4m-thermal {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+
+			thermal-sensors = <&tsens0 1>;
+		};
+
+		l3_or_venus-thermal {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+
+			thermal-sensors = <&tsens0 2>;
+		};
+
+		cluster0-l2-thermal {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+
+			thermal-sensors = <&tsens0 7>;
+		};
+
+		cluster1-l2-thermal {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+
+			thermal-sensors = <&tsens0 12>;
+		};
+
+		camera-thermal {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+
+			thermal-sensors = <&tsens1 1>;
+		};
+
+		q6-dsp-thermal {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+
+			thermal-sensors = <&tsens1 2>;
+		};
+
+		mem-thermal {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+
+			thermal-sensors = <&tsens1 3>;
+		};
+
+		modemtx-thermal {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+
+			thermal-sensors = <&tsens1 4>;
+		};
 	};
 
 	timer {
-- 
2.17.1

