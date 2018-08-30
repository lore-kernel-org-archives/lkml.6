Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ABCCC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 15:45:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE5DA20658
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 15:45:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Aw9v103k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE5DA20658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728056AbeH3Tsi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 15:48:38 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42692 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727996AbeH3Tsi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 15:48:38 -0400
Received: by mail-wr1-f66.google.com with SMTP id v17-v6so8516011wrr.9;
        Thu, 30 Aug 2018 08:45:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=sICcaZN9SuHUxjIoI4iQcsXgJZYewubrScoChP39YpI=;
        b=Aw9v103kYcLLYZnLacNAi2w5W6W18WUc1/2IS7u1/9HUeYKyu4eVfDzJpD1PybEatM
         MrznRHu0Dyec+WLTggEvXmp5Kv0AyCMgzolRBcFSo0gyBteDJBPi4A3FbFhuf+bVVJSr
         c1plByogpJ61B/oG/PH35mpesTFkcO7qUY76jxP8pTCn7XnBOtLXxgNT2WGs4rSCcFrx
         1CpIT5w6d56m/eCqh2mYJ9XgYLwEf0A5sLm4P28K/L8XHYSP8UyvztV8hXy6EtYlXBAA
         dPIIgci9jS3fMMvNK2OTj7tLhbedaZocdsbA8R+/5Bkh1jiKxN4AiDz31Uttg+7SNhPU
         Ry6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=sICcaZN9SuHUxjIoI4iQcsXgJZYewubrScoChP39YpI=;
        b=KESzq0anMIYAhm1SWuBQlmpY0smijBLFOPfS51XRuESEhWUMC2YCr++0b2n5FAu8ga
         0d5282ZvoAKSU1Y+l2Kt1iRQrv8XxqRdQo54EpHi+z+b+2lQ8CUh76VYycZzn6UQt8CB
         7+oba2rnvxvPHTTfmYzk020Dgb7poQWqCP2x8IeFBGRCPLT45kqovoH1GSPBJZgBfyBC
         B4i7EG8++6ae9yu0j8vM1njj5YU/REKSDPW60wBvXjfOhyF9ycBkOo35GCkrE7IW1W+t
         ll4jVWOXqPVNgNKrtrfvWf/CIfBw4tUqmU0ALXb/Hn13ADZy5l0DkwEmqEsxbY9qV4uD
         i3fg==
X-Gm-Message-State: APzg51CijB2MKa2uSnaUbE0PeVeQqdT4zWf7G5i0knSwsBERS2oQEbYR
        Yk18l08IKysU+LKloWU0Aeg=
X-Google-Smtp-Source: ANB0VdZ0MikSKsrAa87d0u3AUJ+5RqMu1iRmXtZH7fLGRlp1wDHMuNiCDvEZEfF05cd4AM5E4NiNTA==
X-Received: by 2002:adf:8504:: with SMTP id 4-v6mr7769616wrh.72.1535643951102;
        Thu, 30 Aug 2018 08:45:51 -0700 (PDT)
Received: from debian-hp.wlan.uni-ulm.de (eduroam170-020.wlan.uni-ulm.de. [134.60.170.20])
        by smtp.gmail.com with ESMTPSA id j20-v6sm1362759wmh.9.2018.08.30.08.45.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Aug 2018 08:45:50 -0700 (PDT)
From:   Philipp Rossak <embed3d@gmail.com>
To:     lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        maxime.ripard@bootlin.com, wens@csie.org, linux@armlinux.org.uk,
        jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, eugen.hristev@microchip.com,
        rdunlap@infradead.org, vilhelm.gray@gmail.com,
        clabbe.montjoie@gmail.com, quentin.schulz@bootlin.com,
        geert+renesas@glider.be, lukas@wunner.de, icenowy@aosc.io,
        arnd@arndb.de, broonie@kernel.org, arnaud.pouliquen@st.com
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: [PATCH v3 29/30] ARM: dts: sun8i: a83t: add thermal zone to A83T
Date:   Thu, 30 Aug 2018 17:45:17 +0200
Message-Id: <20180830154518.29507-30-embed3d@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180830154518.29507-1-embed3d@gmail.com>
References: <20180830154518.29507-1-embed3d@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the thermal zones to the A83T. Sensor 0 is located
besides the cpu cluster 0. Sensor 1 is located besides cluster 1 and
sensor 2 is located besides in the gpu.

Signed-off-by: Philipp Rossak <embed3d@gmail.com>
---
 arch/arm/boot/dts/sun8i-a83t.dtsi | 103 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 103 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-a83t.dtsi b/arch/arm/boot/dts/sun8i-a83t.dtsi
index f2f745930b08..78aa448e869f 100644
--- a/arch/arm/boot/dts/sun8i-a83t.dtsi
+++ b/arch/arm/boot/dts/sun8i-a83t.dtsi
@@ -50,6 +50,7 @@
 #include <dt-bindings/reset/sun8i-a83t-ccu.h>
 #include <dt-bindings/reset/sun8i-de2.h>
 #include <dt-bindings/reset/sun8i-r-ccu.h>
+#include <dt-bindings/thermal/thermal.h>
 
 / {
 	interrupt-parent = <&gic>;
@@ -69,6 +70,9 @@
 			cci-control-port = <&cci_control0>;
 			enable-method = "allwinner,sun8i-a83t-smp";
 			reg = <0>;
+			#cooling-cells = <2>;
+			cooling-min-level = <0>;
+			cooling-max-level = <7>;
 		};
 
 		cpu@1 {
@@ -107,6 +111,9 @@
 			cci-control-port = <&cci_control1>;
 			enable-method = "allwinner,sun8i-a83t-smp";
 			reg = <0x100>;
+			#cooling-cells = <2>;
+			cooling-min-level = <0>;
+			cooling-max-level = <7>;
 		};
 
 		cpu@101 {
@@ -1035,4 +1042,100 @@
 			#size-cells = <0>;
 		};
 	};
+
+	thermal-zones {
+		cpu0_thermal: cpu0-thermal {
+			polling-delay-passive = <1000>;
+			polling-delay = <5000>;
+			thermal-sensors = <&ths 0>;
+
+			trips {
+				cpu0_warm: cpu_warm {
+					temperature = <70000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+				cpu0_hot: cpu_hot {
+					temperature = <80000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+				cpu0_very_hot: cpu_very_hot {
+					temperature = <90000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+				cpu0_crit: cpu_crit {
+					temperature = <105000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
+
+			cooling-maps {
+				cpu_warm_limit_cpu {
+					trip = <&cpu0_warm>;
+					cooling-device = <&cpu0 THERMAL_NO_LIMIT 4>;
+				};
+				cpu_hot_limit_cpu {
+					trip = <&cpu0_hot>;
+					cooling-device = <&cpu0 5 5>;
+				};
+				cpu_very_hot_limit_cpu {
+					trip = <&cpu0_very_hot>;
+					cooling-device = <&cpu0 7 THERMAL_NO_LIMIT>;
+				};
+			};
+		};
+
+		cpu1_thermal: cpu1-thermal {
+			polling-delay-passive = <1000>;
+			polling-delay = <5000>;
+			thermal-sensors = <&ths 1>;
+
+			trips {
+				cpu1_warm: cpu_warm {
+					temperature = <70000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+				cpu1_hot: cpu_hot {
+					temperature = <80000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+				cpu1_very_hot: cpu_very_hot {
+					temperature = <90000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+				cpu1_crit: cpu_crit {
+					temperature = <105000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
+
+			cooling-maps {
+				cpu_warm_limit_cpu {
+					trip = <&cpu1_warm>;
+					cooling-device = <&cpu100 THERMAL_NO_LIMIT 4>;
+				};
+				cpu_hot_limit_cpu {
+					trip = <&cpu1_hot>;
+					cooling-device = <&cpu100 5 5>;
+				};
+				cpu_very_hot_limit_cpu {
+					trip = <&cpu1_very_hot>;
+					cooling-device = <&cpu100 7 THERMAL_NO_LIMIT>;
+				};
+			};
+		};
+
+		gpu_thermal: gpu-thermal {
+			polling-delay-passive = <1000>;
+			polling-delay = <5000>;
+			thermal-sensors = <&ths 2>;
+		};
+	};
 };
-- 
2.11.0

