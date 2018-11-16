Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BA9DC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 10:01:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D516920892
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 10:01:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="JVPGj49/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D516920892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389535AbeKPUNV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 15:13:21 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:36371 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389485AbeKPUNU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 15:13:20 -0500
Received: by mail-pl1-f194.google.com with SMTP id y6-v6so3369737plt.3
        for <linux-kernel@vger.kernel.org>; Fri, 16 Nov 2018 02:01:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=U5rf2itzTOB9dax2BRq+hIYugAJTWtXSu7y5bvsLcSw=;
        b=JVPGj49/bBk59RqV2L5ue3O6HvsEhZV/XPoi+xJdLJozZQR7EveaokK7roEQ+WyYQl
         N70Y/WTEklM1ZU3P0aOiY+gBXU74y0ZqWKljsm+4Mc38kOw33KAAvWBoageihkKN+vb/
         R6iH2+bmM9Zbxrntzr7Ng4Drc2fOyQlRhTxVY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=U5rf2itzTOB9dax2BRq+hIYugAJTWtXSu7y5bvsLcSw=;
        b=qAZdSnX3kkRy+MGuJdK9tCC677FM/HTo5L70iIaIpibPw32gVkNthysAspXmBssXiL
         ijGs3S9HNvyVi8+Y7agOyfe4gQB1p22huJ4Lux3fUPLz7Fh7PLcLbWKMZWdaCl4AO6Cz
         57KqgPoAaPhcUtuMK27HYDC6DQiYNUL93P+qxs7EPcpVt5SVMC+5siNdpa5oBPLum0wt
         AbSuwxpN9/af3oWKrbZ+sdF2NvSaq7/mf6lxTJeKwd24tdmRfUOaC/p/Q3KBNZGJXI1A
         i++b3rQHrMLGtRoczhHg3fOtwTAwY5W1AlXj4eeW1/ifuObS/aRMI5txYVr6ZN7B9Htu
         W65w==
X-Gm-Message-State: AGRZ1gKbI5hRlqbkOy1aAEqz67QufH96vCdhU7ovxsn4HKn5yXA9ofE+
        pPAeqsRxzZoIE3kQ/6wrCPFaLA==
X-Google-Smtp-Source: AJdET5c/LUs0/aVaFxYqnM0QAF7mSKRH0Wn6K3sXFTFaRMsf0qW2PB/bVjEtpzVrqgGVv0H1i97vug==
X-Received: by 2002:a17:902:5ac7:: with SMTP id g7mr10273850plm.212.1542362503876;
        Fri, 16 Nov 2018 02:01:43 -0800 (PST)
Received: from localhost ([122.172.88.116])
        by smtp.gmail.com with ESMTPSA id a15sm3111223pgb.1.2018.11.16.02.01.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Nov 2018 02:01:43 -0800 (PST)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, devicetree@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/6] ARM: dts: rockchip: Add all CPUs in cooling maps
Date:   Fri, 16 Nov 2018 15:31:13 +0530
Message-Id: <8e59f97ae89a116b835ee14c63f550b159b000cc.1542362000.git.viresh.kumar@linaro.org>
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
 arch/arm/boot/dts/rk322x.dtsi              | 10 +++++++--
 arch/arm/boot/dts/rk3288-veyron-mickey.dts | 24 +++++++++++++---------
 arch/arm/boot/dts/rk3288.dtsi              | 15 +++++++++++---
 3 files changed, 34 insertions(+), 15 deletions(-)

diff --git a/arch/arm/boot/dts/rk322x.dtsi b/arch/arm/boot/dts/rk322x.dtsi
index cd8f2a3b0e91..29f19076dceb 100644
--- a/arch/arm/boot/dts/rk322x.dtsi
+++ b/arch/arm/boot/dts/rk322x.dtsi
@@ -493,12 +493,18 @@
 				map0 {
 					trip = <&cpu_alert0>;
 					cooling-device =
-						<&cpu0 THERMAL_NO_LIMIT 6>;
+						<&cpu0 THERMAL_NO_LIMIT 6>,
+						<&cpu1 THERMAL_NO_LIMIT 6>,
+						<&cpu2 THERMAL_NO_LIMIT 6>,
+						<&cpu3 THERMAL_NO_LIMIT 6>;
 				};
 				map1 {
 					trip = <&cpu_alert1>;
 					cooling-device =
-						<&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+						<&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+						<&cpu1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+						<&cpu2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+						<&cpu3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
 				};
 			};
 		};
diff --git a/arch/arm/boot/dts/rk3288-veyron-mickey.dts b/arch/arm/boot/dts/rk3288-veyron-mickey.dts
index 1e0158acf895..d889ab3c8235 100644
--- a/arch/arm/boot/dts/rk3288-veyron-mickey.dts
+++ b/arch/arm/boot/dts/rk3288-veyron-mickey.dts
@@ -81,8 +81,10 @@
 		 */
 		cpu_warm_limit_cpu {
 			trip = <&cpu_alert_warm>;
-			cooling-device =
-				<&cpu0 THERMAL_NO_LIMIT 4>;
+			cooling-device = <&cpu0 THERMAL_NO_LIMIT 4>,
+					 <&cpu1 THERMAL_NO_LIMIT 4>,
+					 <&cpu2 THERMAL_NO_LIMIT 4>,
+					 <&cpu3 THERMAL_NO_LIMIT 4>;
 		};
 
 		/*
@@ -103,23 +105,25 @@
 		 */
 		cpu_almost_hot_limit_cpu {
 			trip = <&cpu_alert_almost_hot>;
-			cooling-device =
-				<&cpu0 5 6>;
+			cooling-device = <&cpu0 5 6>, <&cpu1 5 6>, <&cpu2 5 6>,
+					 <&cpu3 5 6>;
 		};
 		cpu_hot_limit_cpu {
 			trip = <&cpu_alert_hot>;
-			cooling-device =
-				<&cpu0 7 7>;
+			cooling-device = <&cpu0 7 7>, <&cpu1 7 7>, <&cpu2 7 7>,
+					 <&cpu3 7 7>;
 		};
 		cpu_hotter_limit_cpu {
 			trip = <&cpu_alert_hotter>;
-			cooling-device =
-				<&cpu0 7 8>;
+			cooling-device = <&cpu0 7 8>, <&cpu1 7 8>, <&cpu2 7 8>,
+					 <&cpu3 7 8>;
 		};
 		cpu_very_hot_limit_cpu {
 			trip = <&cpu_alert_very_hot>;
-			cooling-device =
-				<&cpu0 8 THERMAL_NO_LIMIT>;
+			cooling-device = <&cpu0 8 THERMAL_NO_LIMIT>,
+					 <&cpu1 8 THERMAL_NO_LIMIT>,
+					 <&cpu2 8 THERMAL_NO_LIMIT>,
+					 <&cpu3 8 THERMAL_NO_LIMIT>;
 		};
 	};
 };
diff --git a/arch/arm/boot/dts/rk3288.dtsi b/arch/arm/boot/dts/rk3288.dtsi
index 0840ffb3205c..1da86e82bb57 100644
--- a/arch/arm/boot/dts/rk3288.dtsi
+++ b/arch/arm/boot/dts/rk3288.dtsi
@@ -508,12 +508,18 @@
 				map0 {
 					trip = <&cpu_alert0>;
 					cooling-device =
-						<&cpu0 THERMAL_NO_LIMIT 6>;
+						<&cpu0 THERMAL_NO_LIMIT 6>,
+						<&cpu1 THERMAL_NO_LIMIT 6>,
+						<&cpu2 THERMAL_NO_LIMIT 6>,
+						<&cpu3 THERMAL_NO_LIMIT 6>;
 				};
 				map1 {
 					trip = <&cpu_alert1>;
 					cooling-device =
-						<&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+						<&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+						<&cpu1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+						<&cpu2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+						<&cpu3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
 				};
 			};
 		};
@@ -541,7 +547,10 @@
 				map0 {
 					trip = <&gpu_alert0>;
 					cooling-device =
-						<&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+						<&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+						<&cpu1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+						<&cpu2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+						<&cpu3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
 				};
 			};
 		};
-- 
2.19.1.568.g152ad8e3369a

