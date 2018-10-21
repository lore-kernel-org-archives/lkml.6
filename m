Return-Path: <SRS0=f4JY=NB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55F2BECDE46
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 20:58:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 183552083E
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 20:58:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cA8sG5GR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 183552083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728505AbeJVFNy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 01:13:54 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:41486 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727256AbeJVFNx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 01:13:53 -0400
Received: by mail-lf1-f65.google.com with SMTP id q39-v6so28782390lfi.8;
        Sun, 21 Oct 2018 13:58:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lD5gQWDai5qk2fHLTBuMFPsuyYW/QrRx1ZMqTJ219kA=;
        b=cA8sG5GRUrZLF4q5mqmNpb4lNS6GSSWcwEzUikW3pY5rVnowbn8xJ5r3VH4aVvcGc4
         eo+YQEJ9fOF01UZd0XVJmc0Ur6TT5GSHeXesHnN2voyhDSY1jcg0FkPXkWOphsY9BUF5
         DKzFFofkBApc9SW2B0tikDBITiZOuovK1r4SxJne93fnkIbSRb1sdMM6bV8wqFpQIxbD
         U2vzVRwGhnt4NIOycjdWbcykJEfMqmmgWmlGuIpaWeWaXcPgyaQpRHLcu99/+N9a7/4o
         vwTcO+si4PJAGd49la491S1PER4zqlSYA3B0Do2hGolQ5nSHuXjLxiOsVb1Z3RwpY3kf
         dMgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lD5gQWDai5qk2fHLTBuMFPsuyYW/QrRx1ZMqTJ219kA=;
        b=cSSCq8D+knP+l0kzI4r2P/eZEOxdiS4BuEXv76tp4cf6NYQhmsf7fVxx83ZyTu/oBN
         t8/lcBmnovSQI4ZO7an+lL5v6oSG/QCzHyz57iKEg/LGRYRPvN0nSZgl8CsD4tYo301D
         FA7qgJcOkuCZtdo5s60xvM/IfkevNWUrVcihnKFPs1VKRhaiRKXo7mAeXnv/vXoQWCkj
         uSDjE98w6cymzELIs5ThDy61wmezr01zth3FWWD6wxyIRzywi1GlzmadDGi4dl3+2asR
         3eWcdukJcnNHxw53ATVpP6NJWfNYtP3JejNU0TQYGh1PXogcPMMS2AHU0L0Y3n8B14gY
         P/FQ==
X-Gm-Message-State: ABuFfoiJHD+ojrCskjaOsQ/g7M5hcZocsmekMwBV/61DE4EN5gfGWOUt
        JF30Us/7AWrjXzXqR47A/gI=
X-Google-Smtp-Source: ACcGV60sUQzYL79YaCR1qHIltNtJAWU7+yPYcI8cL/GqLatXhsjUxJ+cAUTJ8Taesl1ciA9G84a/cQ==
X-Received: by 2002:a19:6719:: with SMTP id b25mr5618971lfc.38.1540155493600;
        Sun, 21 Oct 2018 13:58:13 -0700 (PDT)
Received: from localhost.localdomain (109-252-91-118.nat.spd-mgts.ru. [109.252.91.118])
        by smtp.gmail.com with ESMTPSA id p63-v6sm6515919lfg.46.2018.10.21.13.58.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 21 Oct 2018 13:58:13 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>
Cc:     linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2 09/17] ARM: dts: tegra20: harmony: Setup voltage regulators for DVFS
Date:   Sun, 21 Oct 2018 23:54:53 +0300
Message-Id: <20181021205501.23943-10-digetx@gmail.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181021205501.23943-1-digetx@gmail.com>
References: <20181021205501.23943-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Set min/max regulators voltage and add CPU node that hooks up CPU with
voltage regulators.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/arm/boot/dts/tegra20-harmony.dts | 31 +++++++++++++++++++--------
 1 file changed, 22 insertions(+), 9 deletions(-)

diff --git a/arch/arm/boot/dts/tegra20-harmony.dts b/arch/arm/boot/dts/tegra20-harmony.dts
index 1d96d92b72a7..9d720743fd4e 100644
--- a/arch/arm/boot/dts/tegra20-harmony.dts
+++ b/arch/arm/boot/dts/tegra20-harmony.dts
@@ -339,17 +339,19 @@
 					regulator-always-on;
 				};
 
-				sm0 {
+				core_vdd_reg: sm0 {
 					regulator-name = "vdd_sm0,vdd_core";
-					regulator-min-microvolt = <1200000>;
-					regulator-max-microvolt = <1200000>;
+					regulator-min-microvolt = <1000000>;
+					regulator-max-microvolt = <1300000>;
+					regulator-coupled-with = <&rtc_vdd_reg>;
+					regulator-coupled-max-spread = <150000>;
 					regulator-always-on;
 				};
 
-				sm1 {
+				cpu_vdd_reg: sm1 {
 					regulator-name = "vdd_sm1,vdd_cpu";
-					regulator-min-microvolt = <1000000>;
-					regulator-max-microvolt = <1000000>;
+					regulator-min-microvolt = <750000>;
+					regulator-max-microvolt = <1125000>;
 					regulator-always-on;
 				};
 
@@ -373,10 +375,13 @@
 					regulator-always-on;
 				};
 
-				ldo2 {
+				rtc_vdd_reg: ldo2 {
 					regulator-name = "vdd_ldo2,vdd_rtc";
-					regulator-min-microvolt = <1200000>;
-					regulator-max-microvolt = <1200000>;
+					regulator-min-microvolt = <950000>;
+					regulator-max-microvolt = <1300000>;
+					regulator-coupled-with = <&core_vdd_reg>;
+					regulator-coupled-max-spread = <150000>;
+					regulator-always-on;
 				};
 
 				ldo3 {
@@ -779,4 +784,12 @@
 			 <&tegra_car TEGRA20_CLK_CDEV1>;
 		clock-names = "pll_a", "pll_a_out0", "mclk";
 	};
+
+	cpus {
+		cpu0: cpu@0 {
+			cpu-supply = <&cpu_vdd_reg>;
+			core-supply = <&core_vdd_reg>;
+			rtc-supply = <&rtc_vdd_reg>;
+		};
+	};
 };
-- 
2.19.0

