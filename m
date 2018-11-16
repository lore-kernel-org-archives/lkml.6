Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 948F4C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 10:05:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50ABB20892
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 10:05:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="auctwtug"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50ABB20892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389633AbeKPURI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 15:17:08 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:37164 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389504AbeKPURH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 15:17:07 -0500
Received: by mail-pg1-f194.google.com with SMTP id 80so10406363pge.4
        for <linux-kernel@vger.kernel.org>; Fri, 16 Nov 2018 02:05:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=om0H71tufNAx0r7YflYDpC1gYfbPSxJIkzk36iVdtAw=;
        b=auctwtugckjHOD5UYwG5YZKu9lugfvTLsmETpIWATYFmmRKSoMz8hKoNZJg1vRIqcc
         /SVMWzBdcg7V3+I8AUw8f2GHCNQ+v7i9aAXAF4QWrcOQyLan24bCiBP7wKBz7+Ufx6h2
         wgVPCk/H/6x9eUb2oDprX/qc/SAKcd8l7q3i0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=om0H71tufNAx0r7YflYDpC1gYfbPSxJIkzk36iVdtAw=;
        b=WwNYKexsG6fCEbvFhD6NL6W+ejGUySBBbgICHvme9JasmBAGkPx8ZtLJJknDLwdzDP
         di01jlS/m/0ZZJS0uHgR1OEm+5Plr4akEHhgGHcWb7kuSnshlFrTqVzKV5KLP4A8h7cI
         lGMzJDQB5bCp8xqIbll92TT6vtwIREAOxnSx7Ck7DcHMwkb+nlIywDs2BD/bvqFu8VD4
         1ot1d4kauWrXXSTLyastOozyq5SQPSf/u4Byee8IgW00vhX+B2MIaeUNdzPXbdvARRtd
         iRZYNbHw1F0bb1pIkpQtR+dZKLkZP3FBaN6+8ttUBGNVI90p8lgCTgk1i8w3nFW3/wXZ
         rMyg==
X-Gm-Message-State: AGRZ1gLMNlTlrTe9GPQLHgAvfrdeq2WN3tuSyhvmsQBhiiKc6zMAuxNi
        fMzTKsrwGaQZnNUUIGKIPtKHoA==
X-Google-Smtp-Source: AJdET5cb467S8Az2pHGP9fdJoTx6K+t306shHiBHqvOLREarsw3+f0vbG0GrtEiBuTosP1V5I0zlhw==
X-Received: by 2002:a62:178c:: with SMTP id 134-v6mr10578182pfx.29.1542362728307;
        Fri, 16 Nov 2018 02:05:28 -0800 (PST)
Received: from localhost ([122.172.88.116])
        by smtp.gmail.com with ESMTPSA id c7-v6sm37915148pfh.25.2018.11.16.02.05.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Nov 2018 02:05:27 -0800 (PST)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>, arm@kernel.org,
        Heiko Stuebner <heiko@sntech.de>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, devicetree@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 09/10] ARM64: dts: rockchip: Add all CPUs in cooling maps
Date:   Fri, 16 Nov 2018 15:34:32 +0530
Message-Id: <ee0bd5fb56652141e5ce23927b258b1779844af6.1542362530.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.19.1.568.g152ad8e3369a
In-Reply-To: <cover.1542362530.git.viresh.kumar@linaro.org>
References: <cover.1542362530.git.viresh.kumar@linaro.org>
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
 arch/arm64/boot/dts/rockchip/rk3328.dtsi          |  5 ++++-
 arch/arm64/boot/dts/rockchip/rk3368.dtsi          | 15 ++++++++++++---
 arch/arm64/boot/dts/rockchip/rk3399-gru-kevin.dts |  8 ++++++--
 arch/arm64/boot/dts/rockchip/rk3399.dtsi          | 12 +++++++++---
 4 files changed, 31 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3328.dtsi b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
index e1a33dd981e0..ecd7f19c3542 100644
--- a/arch/arm64/boot/dts/rockchip/rk3328.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
@@ -479,7 +479,10 @@
 			cooling-maps {
 				map0 {
 					trip = <&target>;
-					cooling-device = <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+					cooling-device = <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
 					contribution = <4096>;
 				};
 			};
diff --git a/arch/arm64/boot/dts/rockchip/rk3368.dtsi b/arch/arm64/boot/dts/rockchip/rk3368.dtsi
index 9c24de1ba43c..7014d10b954c 100644
--- a/arch/arm64/boot/dts/rockchip/rk3368.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3368.dtsi
@@ -426,12 +426,18 @@
 				map0 {
 					trip = <&cpu_alert0>;
 					cooling-device =
-					<&cpu_b0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+					<&cpu_b0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+					<&cpu_b1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+					<&cpu_b2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+					<&cpu_b3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
 				};
 				map1 {
 					trip = <&cpu_alert1>;
 					cooling-device =
-					<&cpu_l0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+					<&cpu_l0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+					<&cpu_l1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+					<&cpu_l2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+					<&cpu_l3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
 				};
 			};
 		};
@@ -459,7 +465,10 @@
 				map0 {
 					trip = <&gpu_alert0>;
 					cooling-device =
-					<&cpu_b0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+					<&cpu_b0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+					<&cpu_b1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+					<&cpu_b2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+					<&cpu_b3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
 				};
 			};
 		};
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-gru-kevin.dts b/arch/arm64/boot/dts/rockchip/rk3399-gru-kevin.dts
index 2cc7c47d6a85..81e73103fa78 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-gru-kevin.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-gru-kevin.dts
@@ -118,13 +118,17 @@
 			map0 {
 				trip = <&ppvar_bigcpu_alert>;
 				cooling-device =
-					<&cpu_l0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+					<&cpu_l0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+					<&cpu_l1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+					<&cpu_l2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+					<&cpu_l3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
 				contribution = <4096>;
 			};
 			map1 {
 				trip = <&ppvar_bigcpu_alert>;
 				cooling-device =
-					<&cpu_b0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+					<&cpu_b0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+					<&cpu_b1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
 				contribution = <1024>;
 			};
 		};
diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
index 99e7f65c1779..d4ebffc28953 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
@@ -770,13 +770,18 @@
 				map0 {
 					trip = <&cpu_alert0>;
 					cooling-device =
-						<&cpu_b0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+						<&cpu_b0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+						<&cpu_b1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
 				};
 				map1 {
 					trip = <&cpu_alert1>;
 					cooling-device =
 						<&cpu_l0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-						<&cpu_b0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+						<&cpu_l1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+						<&cpu_l2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+						<&cpu_l3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+						<&cpu_b0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+						<&cpu_b1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
 				};
 			};
 		};
@@ -804,7 +809,8 @@
 				map0 {
 					trip = <&gpu_alert0>;
 					cooling-device =
-						<&cpu_b0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+						<&cpu_b0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+						<&cpu_b1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
 				};
 			};
 		};
-- 
2.19.1.568.g152ad8e3369a

