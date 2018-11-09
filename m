Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85024C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 14:06:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E53820825
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 14:06:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="w2vePZqw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E53820825
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728398AbeKIXqn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 18:46:43 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:32980 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728094AbeKIXpn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 18:45:43 -0500
Received: by mail-wr1-f68.google.com with SMTP id u9-v6so2042607wrr.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Nov 2018 06:04:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5sBBc5EvtxV7NFthSUI3pE8N+JW8dWzJOFUjmWOYU4c=;
        b=w2vePZqwP/S8ctG411E/KBaYLGU/zQhtamb+ciUS7vGB1KCo87xuSEYeCys+BJki1P
         14+za2fF3+MPFgM+U9A6n23UZCPVmaG1/OkbpGgdcd6NI69ZvaXEVYNQfZFo2Gc3ct5H
         IfU/rFHo1y4QgsLlD6fSIsuA83YdF/ef82zY//ThUZWW4T49hcRSbx7gLVONwrYfXHEP
         0qH9NaiK/CdUlO65rDv6vpsVGcAGJQ0fBpS+nCiOrIMqi618sh9Pol8EoVqBbeSrpXx5
         VhsvZ0kO7Umhiet2PfdaIYh5/KeAuRhroYQIyJcexAV+XafvpvEk91ipsVjQVz7fTbvz
         px8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5sBBc5EvtxV7NFthSUI3pE8N+JW8dWzJOFUjmWOYU4c=;
        b=GqUwkZSEmBkKfCY1YAkYaBF8tHjuhQ2+ehXAFVProgsUx7EwvUDAK28KbI7W/9NHzt
         Djw2cTL+5jNf3DQPVUTr0WM1HW5E5i4uIWpDs9sWJg5uQyV3mF4s48eONH+GX5nemb1E
         jQu8TmvNp61LVQriKZ/GtMOxO325pm/Q54yt2Bw2akBiPTaPlqkPdZm1ysHG/qsA/+mZ
         aQcc/VDBvOF8uT8h8t00Udia2tI1B63ExfeEWPF5rnI/f7nle30XdFUq2SJk9+ljL1ad
         V0kZU/AZBcmTsqdLZmxKH2BocjgsgzbYllWbUoxgo8cCruH6Esu80FIb2XSocgscNV+3
         OPVQ==
X-Gm-Message-State: AGRZ1gITdTdIWnR+WcUwmQmsm+M9sayj2r4ewEAgYpWWwu2/nqoyuXv6
        nVJoux8lJNFVw4qN51ZvonRzJA==
X-Google-Smtp-Source: AJdET5fe4mT8gGats0aGUOP7q7Ys+fmZngA4GT1+7qJk6rcqBolA1qcjEIqN8skxy3gv25NWknFPMg==
X-Received: by 2002:adf:ba52:: with SMTP id t18-v6mr7612292wrg.325.1541772297448;
        Fri, 09 Nov 2018 06:04:57 -0800 (PST)
Received: from boomer.baylibre.com ([2a01:e34:eeb6:4690:106b:bae3:31ed:7561])
        by smtp.googlemail.com with ESMTPSA id w18-v6sm15964987wrn.66.2018.11.09.06.04.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 09 Nov 2018 06:04:56 -0800 (PST)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, devicetree@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/4] arm64: dts: meson: remove extra subnode in mmc clk_gate pinmux
Date:   Fri,  9 Nov 2018 15:04:42 +0100
Message-Id: <20181109140445.17795-2-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181109140445.17795-1-jbrunet@baylibre.com>
References: <20181109140445.17795-1-jbrunet@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the pinmux of the mmc clk_gate nodes, we define 2 subnodes. One for
the function definition, the other for the bias. This is not necessary
since we can define the function and the bias in the same subnode.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-axg.dtsi  | 6 ------
 arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi | 9 ---------
 arch/arm64/boot/dts/amlogic/meson-gxl.dtsi  | 9 ---------
 3 files changed, 24 deletions(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
index eb46db001ce0..e86f5f721f8f 100644
--- a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
@@ -280,9 +280,6 @@
 					mux {
 						groups = "BOOT_8";
 						function = "gpio_periphs";
-					};
-					cfg-pull-down {
-						pins = "BOOT_8";
 						bias-pull-down;
 					};
 				};
@@ -513,9 +510,6 @@
 					mux {
 						groups = "GPIOX_4";
 						function = "gpio_periphs";
-					};
-					cfg-pull-down {
-						pins = "GPIOX_4";
 						bias-pull-down;
 					};
 				};
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
index 524f533e41d4..1cb8e7e0d0da 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
@@ -377,9 +377,6 @@
 			mux {
 				groups = "BOOT_8";
 				function = "gpio_periphs";
-			};
-			cfg-pull-down {
-				pins = "BOOT_8";
 				bias-pull-down;
 			};
 		};
@@ -426,9 +423,6 @@
 			mux {
 				groups = "CARD_2";
 				function = "gpio_periphs";
-			};
-			cfg-pull-down {
-				pins = "CARD_2";
 				bias-pull-down;
 			};
 		};
@@ -449,9 +443,6 @@
 			mux {
 				groups = "GPIOX_4";
 				function = "gpio_periphs";
-			};
-			cfg-pull-down {
-				pins = "GPIOX_4";
 				bias-pull-down;
 			};
 		};
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
index 8ccab9a1ebcc..7cfee40d89e9 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
@@ -324,9 +324,6 @@
 			mux {
 				groups = "BOOT_8";
 				function = "gpio_periphs";
-			};
-			cfg-pull-down {
-				pins = "BOOT_8";
 				bias-pull-down;
 			};
 		};
@@ -373,9 +370,6 @@
 			mux {
 				groups = "CARD_2";
 				function = "gpio_periphs";
-			};
-			cfg-pull-down {
-				pins = "CARD_2";
 				bias-pull-down;
 			};
 		};
@@ -396,9 +390,6 @@
 			mux {
 				groups = "GPIOX_4";
 				function = "gpio_periphs";
-			};
-			cfg-pull-down {
-				pins = "GPIOX_4";
 				bias-pull-down;
 			};
 		};
-- 
2.19.1

