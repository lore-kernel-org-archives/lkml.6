Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3BD3C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 15:46:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A98420658
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 15:46:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qb8wKlxN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A98420658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727972AbeH3Tse (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 15:48:34 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40627 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727813AbeH3Tse (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 15:48:34 -0400
Received: by mail-wr1-f67.google.com with SMTP id n2-v6so8511125wrw.7;
        Thu, 30 Aug 2018 08:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=CrbjzCGKhuy1hrMWFjimT5Qh6ZU+NM8doLLYCKA9NAU=;
        b=qb8wKlxN8ikE8T9BDdtgn/W5hhtut7faqPOVpHaPelKnSWMqpgdxRy/1KVJexwbnE1
         QPPwPWsXnMFU6fr4x/X01yC6CQ1uCPHP2l8oDZYuE4CeUzFGoEve711z5j54qN6+tLet
         GUpUOfDgWTDE73HpW6HllXyHBZ7nOXvQTCXqpiU34Fki4IGdpFhpx2NbVGVCaIXlMgMk
         s87CECAcyq+qfzPZMEa/JVajSaG6AfQn34QJUKEp5vhtruikchZOTlamYgnLHpRNh5H7
         TqOxYpNsC004LJyoJwCDlaedW9/f9w0OI0zAPhJ5cvUYiVFJTiW4gVud4sYnLlR8OMoF
         oUwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=CrbjzCGKhuy1hrMWFjimT5Qh6ZU+NM8doLLYCKA9NAU=;
        b=BaOk47475ZlvsOSP6zs/GW/CgldwGqwKIXJBL+Lylb7l1fUKtYiebPn0tRqTElnu/j
         fUv7yyrYdYSIh1WpQqqYpx/OTYkHx+kgSIHT4qxleoexw23iSdQDxq3OEO0E7yPHgOwo
         ngXAnhhE98wI9NIsEivt1RJcTHn+h8mV+lL37iJT4m8pl5egDgX9TNb9etpFAf46UHBy
         i+OCjqG6f+5s7nCJvaIhw80VHQ9MyH4PsHBp8fRVqV4VherUgo9G4C6r5nW3PPrPLUxK
         OI1zYHI7GQhwB+A4JhhoMyfZB0LEfr+jEqqf7D5Lh8gYeaDi3FW13p0KW5JtnHtmDDIF
         Q99g==
X-Gm-Message-State: APzg51BmQ7VRJcwz400hZnvrr0p7MRRtr1SUNrQXDZ4eV7jHh3zBVcpy
        26d9Ei3jhZ2YLz1We0RI7RE=
X-Google-Smtp-Source: ANB0VdZP4PYxxNOjOMzNiV+xt7u6wr8jjl4VjFuXGazBQIsNzc0NEBrxi9riWD9Hd9ZUOnghnMxBxg==
X-Received: by 2002:adf:ea4f:: with SMTP id j15-v6mr8358259wrn.224.1535643946851;
        Thu, 30 Aug 2018 08:45:46 -0700 (PDT)
Received: from debian-hp.wlan.uni-ulm.de (eduroam170-020.wlan.uni-ulm.de. [134.60.170.20])
        by smtp.gmail.com with ESMTPSA id j20-v6sm1362759wmh.9.2018.08.30.08.45.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Aug 2018 08:45:46 -0700 (PDT)
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
Subject: [PATCH v3 25/30] ARM: dts: sun8i: h3: add thermal zone to H3
Date:   Thu, 30 Aug 2018 17:45:13 +0200
Message-Id: <20180830154518.29507-26-embed3d@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180830154518.29507-1-embed3d@gmail.com>
References: <20180830154518.29507-1-embed3d@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the thermal zones to the H3. We have only one sensor and
that is placed in the cpu.

Signed-off-by: Philipp Rossak <embed3d@gmail.com>
---
 arch/arm/boot/dts/sun8i-h3.dtsi    | 31 +++++++++++++++++++++++++++++++
 arch/arm/boot/dts/sunxi-h3-h5.dtsi |  1 +
 2 files changed, 32 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-h3.dtsi b/arch/arm/boot/dts/sun8i-h3.dtsi
index 5b7994cb1471..954848d5df50 100644
--- a/arch/arm/boot/dts/sun8i-h3.dtsi
+++ b/arch/arm/boot/dts/sun8i-h3.dtsi
@@ -78,6 +78,8 @@
 			clock-names = "cpu";
 			operating-points-v2 = <&cpu0_opp_table>;
 			#cooling-cells = <2>;
+			cooling-min-level = <0>;
+			cooling-max-level = <15>;
 		};
 
 		cpu@1 {
@@ -102,6 +104,35 @@
 		};
 	};
 
+	thermal-zones {
+		cpu-thermal {
+			/* milliseconds */
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+			thermal-sensors = <&ths>;
+
+			trips {
+				cpu_hot_trip: cpu-warm {
+					temperature = <65000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+				cpu_very_hot_trip: cpu-very-hot {
+					temperature = <90000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
+
+			cooling-maps {
+				cpu-warm-limit {
+					trip = <&cpu_hot_trip>;
+					cooling-device = <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
+		};
+	};
+
 	timer {
 		compatible = "arm,armv7-timer";
 		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
diff --git a/arch/arm/boot/dts/sunxi-h3-h5.dtsi b/arch/arm/boot/dts/sunxi-h3-h5.dtsi
index 3520e4ad6042..2c83f4893757 100644
--- a/arch/arm/boot/dts/sunxi-h3-h5.dtsi
+++ b/arch/arm/boot/dts/sunxi-h3-h5.dtsi
@@ -47,6 +47,7 @@
 #include <dt-bindings/reset/sun8i-de2.h>
 #include <dt-bindings/reset/sun8i-h3-ccu.h>
 #include <dt-bindings/reset/sun8i-r-ccu.h>
+#include <dt-bindings/thermal/thermal.h>
 
 / {
 	interrupt-parent = <&gic>;
-- 
2.11.0

