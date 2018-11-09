Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E376AC43610
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 14:05:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 890EA20825
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 14:05:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="fanEEaKu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 890EA20825
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728234AbeKIXpu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 18:45:50 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37803 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727988AbeKIXpt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 18:45:49 -0500
Received: by mail-wm1-f67.google.com with SMTP id p2-v6so2039443wmc.2
        for <linux-kernel@vger.kernel.org>; Fri, 09 Nov 2018 06:05:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=92pszNN5RdjoBtGHWr3+HOv6XkVAsZVgMAIyJbe9F7o=;
        b=fanEEaKungZfQmz14elXCjp5D8yp31Z8yUWn7gg8PtLuKJXRQIJxLIBExAW+bKLB3j
         2YY/p3u3r2q3Gi1hPDLdaoAZL6LPfH4fz0fO/E3hQzgiPogiAqLbtc9qNFhz4Y+3L1Ob
         5+0Jvqln34sAFqeAR8TnTbjiNvgKIohVL0JRIoLBKmZNIYADW2SiFn2CdDpyLKDk9IVP
         dezbkIj/UNwiwNz73Va6x7Dv1n1USkJbeJy3F+lm8qAy+Hb3QOIuA2lkRgV2H6m+moKk
         Al7DiXhSocIu0s2+tyC3np8tRPzNm0VKyGvkbxWGC9vrCRENi4TG4KAe2VaLBWUdh+L/
         mC8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=92pszNN5RdjoBtGHWr3+HOv6XkVAsZVgMAIyJbe9F7o=;
        b=JCXfrD95ZtNlJTBvQ9UsUh2O3HS1rAYJy6QXtSsLp9SHrW1pQbx2K6fUbu0K7yoIhm
         LxmyUwqIRE5mYlrjrdu8FGTVH4GTlI0IIOs/6EAj4dEiRZLOHqNql3tHS8XJgEPrBT2j
         H5lL5ptWgwGZAGZ3uW438qAJIGgIYJzd9do+2HqXq3WtnHFB2V9ls+V63p0BKyKXtlS+
         uNmi5hyVvoXyRXwgVELiALTFxdmIAi9WP3nIXlAYHNFMXBLckta+kTVXkA4iAle2JCwW
         EPr0nPMChEgLkRnQAUoZDunnOQpSVMiL384DOJG8O1ycxCquFJFGvDge8rFHRZ+z3kOj
         GBUA==
X-Gm-Message-State: AGRZ1gJWCcSrbnRTneowJOt0L3OftZ5U629grOVnd7zT4Ph6i/gL5d1P
        DB2tMVxgirDZhLAcEx0OHTKn9A==
X-Google-Smtp-Source: AJdET5eq9OxE83LnwuYa+xpvTRj2kdOM7geYvCJkIsGtnwe7pJE5uPViruo6+Mnt442lK5YfBBGT9A==
X-Received: by 2002:a1c:f008:: with SMTP id a8-v6mr4605215wmb.5.1541772301737;
        Fri, 09 Nov 2018 06:05:01 -0800 (PST)
Received: from boomer.baylibre.com ([2a01:e34:eeb6:4690:106b:bae3:31ed:7561])
        by smtp.googlemail.com with ESMTPSA id w18-v6sm15964987wrn.66.2018.11.09.06.04.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 09 Nov 2018 06:05:01 -0800 (PST)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, devicetree@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/4] arm64: dts: meson: consistently disable pin bias
Date:   Fri,  9 Nov 2018 15:04:44 +0100
Message-Id: <20181109140445.17795-4-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181109140445.17795-1-jbrunet@baylibre.com>
References: <20181109140445.17795-1-jbrunet@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Amlogic chipsets, the bias set through pinconf applies to the pad
itself, not only the GPIO function. This means that even when we change
the function of the pad from GPIO to anything else, the bias previously
set still applies.

As we have seen with the eMMC, depending on the bias type and the function,
it may trigger problems.

The underlying issue is that we inherit whatever was left by previous user
of the pad (pinconf, u-boot or the ROM code). As a consequence, the actual
setup we will get is undefined.

There is nothing mentioned in the documentation about pad bias and pinmux
function, however leaving it undefined is not an option.

This change consistently disable the pad bias for every pinmux functions.
It seems to work well, we can only assume that the necessary bias (if any)
is already provided by the pin function itself.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-axg.dtsi  | 103 ++++++++++++++++++++
 arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi |  47 +++++++++
 arch/arm64/boot/dts/amlogic/meson-gxl.dtsi  |  49 ++++++++++
 3 files changed, 199 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
index bc427b9d3e13..e0139f174726 100644
--- a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
@@ -200,6 +200,7 @@
 						groups = "i2c0_sck",
 							 "i2c0_sda";
 						function = "i2c0";
+						bias-disable;
 					};
 				};
 
@@ -208,6 +209,7 @@
 						groups = "i2c1_sck_x",
 							 "i2c1_sda_x";
 						function = "i2c1";
+						bias-disable;
 					};
 				};
 
@@ -216,6 +218,7 @@
 						groups = "i2c1_sck_z",
 							 "i2c1_sda_z";
 						function = "i2c1";
+						bias-disable;
 					};
 				};
 
@@ -224,6 +227,7 @@
 						groups = "i2c2_sck_a",
 							 "i2c2_sda_a";
 						function = "i2c2";
+						bias-disable;
 					};
 				};
 
@@ -232,6 +236,7 @@
 						groups = "i2c2_sck_x",
 							 "i2c2_sda_x";
 						function = "i2c2";
+						bias-disable;
 					};
 				};
 
@@ -240,6 +245,7 @@
 						groups = "i2c3_sda_a6",
 							 "i2c3_sck_a7";
 						function = "i2c3";
+						bias-disable;
 					};
 				};
 
@@ -248,6 +254,7 @@
 						groups = "i2c3_sda_a12",
 							 "i2c3_sck_a13";
 						function = "i2c3";
+						bias-disable;
 					};
 				};
 
@@ -256,6 +263,7 @@
 						groups = "i2c3_sda_a19",
 							 "i2c3_sck_a20";
 						function = "i2c3";
+						bias-disable;
 					};
 				};
 
@@ -302,6 +310,7 @@
 							 "eth_txd2_rgmii",
 							 "eth_txd3_rgmii";
 						function = "eth";
+						bias-disable;
 					};
 				};
 
@@ -322,6 +331,7 @@
 							 "eth_txd2_rgmii",
 							 "eth_txd3_rgmii";
 						function = "eth";
+						bias-disable;
 					};
 				};
 
@@ -337,6 +347,7 @@
 							 "eth_txd0_x",
 							 "eth_txd1_x";
 						function = "eth";
+						bias-disable;
 					};
 				};
 
@@ -352,6 +363,7 @@
 							 "eth_txd0_y",
 							 "eth_txd1_y";
 						function = "eth";
+						bias-disable;
 					};
 				};
 
@@ -359,6 +371,7 @@
 					mux {
 						groups = "mclk_b";
 						function = "mclk_b";
+						bias-disable;
 					};
 				};
 
@@ -366,6 +379,7 @@
 					mux {
 						groups = "mclk_c";
 						function = "mclk_c";
+						bias-disable;
 					};
 				};
 
@@ -373,6 +387,7 @@
 					mux {
 						groups = "pdm_dclk_a14";
 						function = "pdm";
+						bias-disable;
 					};
 				};
 
@@ -380,6 +395,7 @@
 					mux {
 						groups = "pdm_dclk_a19";
 						function = "pdm";
+						bias-disable;
 					};
 				};
 
@@ -387,6 +403,7 @@
 					mux {
 						groups = "pdm_din0";
 						function = "pdm";
+						bias-disable;
 					};
 				};
 
@@ -394,6 +411,7 @@
 					mux {
 						groups = "pdm_din1";
 						function = "pdm";
+						bias-disable;
 					};
 				};
 
@@ -401,6 +419,7 @@
 					mux {
 						groups = "pdm_din2";
 						function = "pdm";
+						bias-disable;
 					};
 				};
 
@@ -408,6 +427,7 @@
 					mux {
 						groups = "pdm_din3";
 						function = "pdm";
+						bias-disable;
 					};
 				};
 
@@ -415,6 +435,7 @@
 					mux {
 						groups = "pwm_a_a";
 						function = "pwm_a";
+						bias-disable;
 					};
 				};
 
@@ -422,6 +443,7 @@
 					mux {
 						groups = "pwm_a_x18";
 						function = "pwm_a";
+						bias-disable;
 					};
 				};
 
@@ -429,6 +451,7 @@
 					mux {
 						groups = "pwm_a_x20";
 						function = "pwm_a";
+						bias-disable;
 					};
 				};
 
@@ -436,6 +459,7 @@
 					mux {
 						groups = "pwm_a_z";
 						function = "pwm_a";
+						bias-disable;
 					};
 				};
 
@@ -443,6 +467,7 @@
 					mux {
 						groups = "pwm_b_a";
 						function = "pwm_b";
+						bias-disable;
 					};
 				};
 
@@ -450,6 +475,7 @@
 					mux {
 						groups = "pwm_b_x";
 						function = "pwm_b";
+						bias-disable;
 					};
 				};
 
@@ -457,6 +483,7 @@
 					mux {
 						groups = "pwm_b_z";
 						function = "pwm_b";
+						bias-disable;
 					};
 				};
 
@@ -464,6 +491,7 @@
 					mux {
 						groups = "pwm_c_a";
 						function = "pwm_c";
+						bias-disable;
 					};
 				};
 
@@ -471,6 +499,7 @@
 					mux {
 						groups = "pwm_c_x10";
 						function = "pwm_c";
+						bias-disable;
 					};
 				};
 
@@ -478,6 +507,7 @@
 					mux {
 						groups = "pwm_c_x17";
 						function = "pwm_c";
+						bias-disable;
 					};
 				};
 
@@ -485,6 +515,7 @@
 					mux {
 						groups = "pwm_d_x11";
 						function = "pwm_d";
+						bias-disable;
 					};
 				};
 
@@ -492,6 +523,7 @@
 					mux {
 						groups = "pwm_d_x16";
 						function = "pwm_d";
+						bias-disable;
 					};
 				};
 
@@ -520,6 +552,7 @@
 					mux {
 						groups = "spdif_in_z";
 						function = "spdif_in";
+						bias-disable;
 					};
 				};
 
@@ -527,6 +560,7 @@
 					mux {
 						groups = "spdif_in_a1";
 						function = "spdif_in";
+						bias-disable;
 					};
 				};
 
@@ -534,6 +568,7 @@
 					mux {
 						groups = "spdif_in_a7";
 						function = "spdif_in";
+						bias-disable;
 					};
 				};
 
@@ -541,6 +576,7 @@
 					mux {
 						groups = "spdif_in_a19";
 						function = "spdif_in";
+						bias-disable;
 					};
 				};
 
@@ -548,6 +584,7 @@
 					mux {
 						groups = "spdif_in_a20";
 						function = "spdif_in";
+						bias-disable;
 					};
 				};
 
@@ -555,6 +592,7 @@
 					mux {
 						groups = "spdif_out_a1";
 						function = "spdif_out";
+						bias-disable;
 					};
 				};
 
@@ -562,6 +600,7 @@
 					mux {
 						groups = "spdif_out_a11";
 						function = "spdif_out";
+						bias-disable;
 					};
 				};
 
@@ -569,6 +608,7 @@
 					mux {
 						groups = "spdif_out_a19";
 						function = "spdif_out";
+						bias-disable;
 					};
 				};
 
@@ -576,6 +616,7 @@
 					mux {
 						groups = "spdif_out_a20";
 						function = "spdif_out";
+						bias-disable;
 					};
 				};
 
@@ -583,6 +624,7 @@
 					mux {
 						groups = "spdif_out_z";
 						function = "spdif_out";
+						bias-disable;
 					};
 				};
 
@@ -592,6 +634,7 @@
 							 "spi0_mosi",
 							 "spi0_clk";
 						function = "spi0";
+						bias-disable;
 					};
 				};
 
@@ -599,6 +642,7 @@
 					mux {
 						groups = "spi0_ss0";
 						function = "spi0";
+						bias-disable;
 					};
 				};
 
@@ -606,6 +650,7 @@
 					mux {
 						groups = "spi0_ss1";
 						function = "spi0";
+						bias-disable;
 					};
 				};
 
@@ -613,6 +658,7 @@
 					mux {
 						groups = "spi0_ss2";
 						function = "spi0";
+						bias-disable;
 					};
 				};
 
@@ -622,6 +668,7 @@
 							 "spi1_mosi_a",
 							 "spi1_clk_a";
 						function = "spi1";
+						bias-disable;
 					};
 				};
 
@@ -629,6 +676,7 @@
 					mux {
 						groups = "spi1_ss0_a";
 						function = "spi1";
+						bias-disable;
 					};
 				};
 
@@ -636,6 +684,7 @@
 					mux {
 						groups = "spi1_ss1";
 						function = "spi1";
+						bias-disable;
 					};
 				};
 
@@ -645,6 +694,7 @@
 							 "spi1_mosi_x",
 							 "spi1_clk_x";
 						function = "spi1";
+						bias-disable;
 					};
 				};
 
@@ -652,6 +702,7 @@
 					mux {
 						groups = "spi1_ss0_x";
 						function = "spi1";
+						bias-disable;
 					};
 				};
 
@@ -659,6 +710,7 @@
 					mux {
 						groups = "tdma_din0";
 						function = "tdma";
+						bias-disable;
 					};
 				};
 
@@ -666,6 +718,7 @@
 					mux {
 						groups = "tdma_dout0_x14";
 						function = "tdma";
+						bias-disable;
 					};
 				};
 
@@ -673,6 +726,7 @@
 					mux {
 						groups = "tdma_dout0_x15";
 						function = "tdma";
+						bias-disable;
 					};
 				};
 
@@ -680,6 +734,7 @@
 					mux {
 						groups = "tdma_dout1";
 						function = "tdma";
+						bias-disable;
 					};
 				};
 
@@ -687,6 +742,7 @@
 					mux {
 						groups = "tdma_din1";
 						function = "tdma";
+						bias-disable;
 					};
 				};
 
@@ -694,6 +750,7 @@
 					mux {
 						groups = "tdma_fs";
 						function = "tdma";
+						bias-disable;
 					};
 				};
 
@@ -701,6 +758,7 @@
 					mux {
 						groups = "tdma_fs_slv";
 						function = "tdma";
+						bias-disable;
 					};
 				};
 
@@ -708,6 +766,7 @@
 					mux {
 						groups = "tdma_sclk";
 						function = "tdma";
+						bias-disable;
 					};
 				};
 
@@ -715,6 +774,7 @@
 					mux {
 						groups = "tdma_sclk_slv";
 						function = "tdma";
+						bias-disable;
 					};
 				};
 
@@ -722,6 +782,7 @@
 					mux {
 						groups = "tdmb_din0";
 						function = "tdmb";
+						bias-disable;
 					};
 				};
 
@@ -729,6 +790,7 @@
 					mux {
 						groups = "tdmb_din1";
 						function = "tdmb";
+						bias-disable;
 					};
 				};
 
@@ -736,6 +798,7 @@
 					mux {
 						groups = "tdmb_din2";
 						function = "tdmb";
+						bias-disable;
 					};
 				};
 
@@ -743,6 +806,7 @@
 					mux {
 						groups = "tdmb_din3";
 						function = "tdmb";
+						bias-disable;
 					};
 				};
 
@@ -750,6 +814,7 @@
 					mux {
 						groups = "tdmb_dout0";
 						function = "tdmb";
+						bias-disable;
 					};
 				};
 
@@ -757,6 +822,7 @@
 					mux {
 						groups = "tdmb_dout1";
 						function = "tdmb";
+						bias-disable;
 					};
 				};
 
@@ -764,6 +830,7 @@
 					mux {
 						groups = "tdmb_dout2";
 						function = "tdmb";
+						bias-disable;
 					};
 				};
 
@@ -771,6 +838,7 @@
 					mux {
 						groups = "tdmb_dout3";
 						function = "tdmb";
+						bias-disable;
 					};
 				};
 
@@ -778,6 +846,7 @@
 					mux {
 						groups = "tdmb_fs";
 						function = "tdmb";
+						bias-disable;
 					};
 				};
 
@@ -785,6 +854,7 @@
 					mux {
 						groups = "tdmb_fs_slv";
 						function = "tdmb";
+						bias-disable;
 					};
 				};
 
@@ -792,6 +862,7 @@
 					mux {
 						groups = "tdmb_sclk";
 						function = "tdmb";
+						bias-disable;
 					};
 				};
 
@@ -799,6 +870,7 @@
 					mux {
 						groups = "tdmb_sclk_slv";
 						function = "tdmb";
+						bias-disable;
 					};
 				};
 
@@ -806,6 +878,7 @@
 					mux {
 						groups = "tdmc_fs";
 						function = "tdmc";
+						bias-disable;
 					};
 				};
 
@@ -813,6 +886,7 @@
 					mux {
 						groups = "tdmc_fs_slv";
 						function = "tdmc";
+						bias-disable;
 					};
 				};
 
@@ -820,6 +894,7 @@
 					mux {
 						groups = "tdmc_sclk";
 						function = "tdmc";
+						bias-disable;
 					};
 				};
 
@@ -827,6 +902,7 @@
 					mux {
 						groups = "tdmc_sclk_slv";
 						function = "tdmc";
+						bias-disable;
 					};
 				};
 
@@ -834,6 +910,7 @@
 					mux {
 						groups = "tdmc_din0";
 						function = "tdmc";
+						bias-disable;
 					};
 				};
 
@@ -841,6 +918,7 @@
 					mux {
 						groups = "tdmc_din1";
 						function = "tdmc";
+						bias-disable;
 					};
 				};
 
@@ -848,6 +926,7 @@
 					mux {
 						groups = "tdmc_din2";
 						function = "tdmc";
+						bias-disable;
 					};
 				};
 
@@ -855,6 +934,7 @@
 					mux {
 						groups = "tdmc_din3";
 						function = "tdmc";
+						bias-disable;
 					};
 				};
 
@@ -862,6 +942,7 @@
 					mux {
 						groups = "tdmc_dout0";
 						function = "tdmc";
+						bias-disable;
 					};
 				};
 
@@ -869,6 +950,7 @@
 					mux {
 						groups = "tdmc_dout1";
 						function = "tdmc";
+						bias-disable;
 					};
 				};
 
@@ -876,6 +958,7 @@
 					mux {
 						groups = "tdmc_dout2";
 						function = "tdmc";
+						bias-disable;
 					};
 				};
 
@@ -883,6 +966,7 @@
 					mux {
 						groups = "tdmc_dout3";
 						function = "tdmc";
+						bias-disable;
 					};
 				};
 
@@ -891,6 +975,7 @@
 						groups = "uart_tx_a",
 							 "uart_rx_a";
 						function = "uart_a";
+						bias-disable;
 					};
 				};
 
@@ -899,6 +984,7 @@
 						groups = "uart_cts_a",
 							 "uart_rts_a";
 						function = "uart_a";
+						bias-disable;
 					};
 				};
 
@@ -907,6 +993,7 @@
 						groups = "uart_tx_b_x",
 							 "uart_rx_b_x";
 						function = "uart_b";
+						bias-disable;
 					};
 				};
 
@@ -915,6 +1002,7 @@
 						groups = "uart_cts_b_x",
 							 "uart_rts_b_x";
 						function = "uart_b";
+						bias-disable;
 					};
 				};
 
@@ -923,6 +1011,7 @@
 						groups = "uart_tx_b_z",
 							 "uart_rx_b_z";
 						function = "uart_b";
+						bias-disable;
 					};
 				};
 
@@ -931,6 +1020,7 @@
 						groups = "uart_cts_b_z",
 							 "uart_rts_b_z";
 						function = "uart_b";
+						bias-disable;
 					};
 				};
 
@@ -939,6 +1029,7 @@
 						groups = "uart_ao_tx_b_z",
 							 "uart_ao_rx_b_z";
 						function = "uart_ao_b_z";
+						bias-disable;
 					};
 				};
 
@@ -947,6 +1038,7 @@
 						groups = "uart_ao_cts_b_z",
 							 "uart_ao_rts_b_z";
 						function = "uart_ao_b_z";
+						bias-disable;
 					};
 				};
 			};
@@ -1235,6 +1327,7 @@
 					mux {
 						groups = "i2c_ao_sck_4";
 						function = "i2c_ao";
+						bias-disable;
 					};
 				};
 
@@ -1242,6 +1335,7 @@
 					mux {
 						groups = "i2c_ao_sck_8";
 						function = "i2c_ao";
+						bias-disable;
 					};
 				};
 
@@ -1249,6 +1343,7 @@
 					mux {
 						groups = "i2c_ao_sck_10";
 						function = "i2c_ao";
+						bias-disable;
 					};
 				};
 
@@ -1256,6 +1351,7 @@
 					mux {
 						groups = "i2c_ao_sda_5";
 						function = "i2c_ao";
+						bias-disable;
 					};
 				};
 
@@ -1263,6 +1359,7 @@
 					mux {
 						groups = "i2c_ao_sda_9";
 						function = "i2c_ao";
+						bias-disable;
 					};
 				};
 
@@ -1270,6 +1367,7 @@
 					mux {
 						groups = "i2c_ao_sda_11";
 						function = "i2c_ao";
+						bias-disable;
 					};
 				};
 
@@ -1277,6 +1375,7 @@
 					mux {
 						groups = "remote_input_ao";
 						function = "remote_input_ao";
+						bias-disable;
 					};
 				};
 
@@ -1285,6 +1384,7 @@
 						groups = "uart_ao_tx_a",
 							 "uart_ao_rx_a";
 						function = "uart_ao_a";
+						bias-disable;
 					};
 				};
 
@@ -1293,6 +1393,7 @@
 						groups = "uart_ao_cts_a",
 							 "uart_ao_rts_a";
 						function = "uart_ao_a";
+						bias-disable;
 					};
 				};
 
@@ -1301,6 +1402,7 @@
 						groups = "uart_ao_tx_b",
 							 "uart_ao_rx_b";
 						function = "uart_ao_b";
+						bias-disable;
 					};
 				};
 
@@ -1309,6 +1411,7 @@
 						groups = "uart_ao_cts_b",
 							 "uart_ao_rts_b";
 						function = "uart_ao_b";
+						bias-disable;
 					};
 				};
 			};
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
index 32ef82321340..6796d250985a 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
@@ -81,6 +81,7 @@
 			mux {
 				groups = "uart_tx_ao_a", "uart_rx_ao_a";
 				function = "uart_ao";
+				bias-disable;
 			};
 		};
 
@@ -89,6 +90,7 @@
 				groups = "uart_cts_ao_a",
 				       "uart_rts_ao_a";
 				function = "uart_ao";
+				bias-disable;
 			};
 		};
 
@@ -96,6 +98,7 @@
 			mux {
 				groups = "uart_tx_ao_b", "uart_rx_ao_b";
 				function = "uart_ao_b";
+				bias-disable;
 			};
 		};
 
@@ -104,6 +107,7 @@
 				groups = "uart_cts_ao_b",
 				       "uart_rts_ao_b";
 				function = "uart_ao_b";
+				bias-disable;
 			};
 		};
 
@@ -111,6 +115,7 @@
 			mux {
 				groups = "remote_input_ao";
 				function = "remote_input_ao";
+				bias-disable;
 			};
 		};
 
@@ -119,6 +124,7 @@
 				groups = "i2c_sck_ao",
 				       "i2c_sda_ao";
 				function = "i2c_ao";
+				bias-disable;
 			};
 		};
 
@@ -126,6 +132,7 @@
 			mux {
 				groups = "pwm_ao_a_3";
 				function = "pwm_ao_a_3";
+				bias-disable;
 			};
 		};
 
@@ -133,6 +140,7 @@
 			mux {
 				groups = "pwm_ao_a_6";
 				function = "pwm_ao_a_6";
+				bias-disable;
 			};
 		};
 
@@ -140,6 +148,7 @@
 			mux {
 				groups = "pwm_ao_a_12";
 				function = "pwm_ao_a_12";
+				bias-disable;
 			};
 		};
 
@@ -147,6 +156,7 @@
 			mux {
 				groups = "pwm_ao_b";
 				function = "pwm_ao_b";
+				bias-disable;
 			};
 		};
 
@@ -154,6 +164,7 @@
 			mux {
 				groups = "i2s_am_clk";
 				function = "i2s_out_ao";
+				bias-disable;
 			};
 		};
 
@@ -161,6 +172,7 @@
 			mux {
 				groups = "i2s_out_ao_clk";
 				function = "i2s_out_ao";
+				bias-disable;
 			};
 		};
 
@@ -168,6 +180,7 @@
 			mux {
 				groups = "i2s_out_lr_clk";
 				function = "i2s_out_ao";
+				bias-disable;
 			};
 		};
 
@@ -175,6 +188,7 @@
 			mux {
 				groups = "i2s_out_ch01_ao";
 				function = "i2s_out_ao";
+				bias-disable;
 			};
 		};
 
@@ -182,6 +196,7 @@
 			mux {
 				groups = "i2s_out_ch23_ao";
 				function = "i2s_out_ao";
+				bias-disable;
 			};
 		};
 
@@ -189,6 +204,7 @@
 			mux {
 				groups = "i2s_out_ch45_ao";
 				function = "i2s_out_ao";
+				bias-disable;
 			};
 		};
 
@@ -203,6 +219,7 @@
 			mux {
 				groups = "spdif_out_ao_13";
 				function = "spdif_out_ao";
+				bias-disable;
 			};
 		};
 
@@ -210,6 +227,7 @@
 			mux {
 				groups = "ao_cec";
 				function = "cec_ao";
+				bias-disable;
 			};
 		};
 
@@ -217,6 +235,7 @@
 			mux {
 				groups = "ee_cec";
 				function = "cec_ao";
+				bias-disable;
 			};
 		};
 	};
@@ -390,6 +409,7 @@
 				       "nor_c",
 				       "nor_cs";
 				function = "nor";
+				bias-disable;
 			};
 		};
 
@@ -399,6 +419,7 @@
 					"spi_mosi",
 					"spi_sclk";
 				function = "spi";
+				bias-disable;
 			};
 		};
 
@@ -406,6 +427,7 @@
 			mux {
 				groups = "spi_ss0";
 				function = "spi";
+				bias-disable;
 			};
 		};
 
@@ -455,6 +477,7 @@
 			mux {
 				groups = "sdio_irq";
 				function = "sdio";
+				bias-disable;
 			};
 		};
 
@@ -463,6 +486,7 @@
 				groups = "uart_tx_a",
 				       "uart_rx_a";
 				function = "uart_a";
+				bias-disable;
 			};
 		};
 
@@ -471,6 +495,7 @@
 				groups = "uart_cts_a",
 				       "uart_rts_a";
 				function = "uart_a";
+				bias-disable;
 			};
 		};
 
@@ -479,6 +504,7 @@
 				groups = "uart_tx_b",
 				       "uart_rx_b";
 				function = "uart_b";
+				bias-disable;
 			};
 		};
 
@@ -487,6 +513,7 @@
 				groups = "uart_cts_b",
 				       "uart_rts_b";
 				function = "uart_b";
+				bias-disable;
 			};
 		};
 
@@ -495,6 +522,7 @@
 				groups = "uart_tx_c",
 				       "uart_rx_c";
 				function = "uart_c";
+				bias-disable;
 			};
 		};
 
@@ -503,6 +531,7 @@
 				groups = "uart_cts_c",
 				       "uart_rts_c";
 				function = "uart_c";
+				bias-disable;
 			};
 		};
 
@@ -511,6 +540,7 @@
 				groups = "i2c_sck_a",
 				       "i2c_sda_a";
 				function = "i2c_a";
+				bias-disable;
 			};
 		};
 
@@ -519,6 +549,7 @@
 				groups = "i2c_sck_b",
 				       "i2c_sda_b";
 				function = "i2c_b";
+				bias-disable;
 			};
 		};
 
@@ -527,6 +558,7 @@
 				groups = "i2c_sck_c",
 				       "i2c_sda_c";
 				function = "i2c_c";
+				bias-disable;
 			};
 		};
 
@@ -547,6 +579,7 @@
 				       "eth_txd2",
 				       "eth_txd3";
 				function = "eth";
+				bias-disable;
 			};
 		};
 
@@ -562,6 +595,7 @@
 				       "eth_txd0",
 				       "eth_txd1";
 				function = "eth";
+				bias-disable;
 			};
 		};
 
@@ -569,6 +603,7 @@
 			mux {
 				groups = "pwm_a_x";
 				function = "pwm_a_x";
+				bias-disable;
 			};
 		};
 
@@ -576,6 +611,7 @@
 			mux {
 				groups = "pwm_a_y";
 				function = "pwm_a_y";
+				bias-disable;
 			};
 		};
 
@@ -583,6 +619,7 @@
 			mux {
 				groups = "pwm_b";
 				function = "pwm_b";
+				bias-disable;
 			};
 		};
 
@@ -590,6 +627,7 @@
 			mux {
 				groups = "pwm_d";
 				function = "pwm_d";
+				bias-disable;
 			};
 		};
 
@@ -597,6 +635,7 @@
 			mux {
 				groups = "pwm_e";
 				function = "pwm_e";
+				bias-disable;
 			};
 		};
 
@@ -604,6 +643,7 @@
 			mux {
 				groups = "pwm_f_x";
 				function = "pwm_f_x";
+				bias-disable;
 			};
 		};
 
@@ -611,6 +651,7 @@
 			mux {
 				groups = "pwm_f_y";
 				function = "pwm_f_y";
+				bias-disable;
 			};
 		};
 
@@ -618,6 +659,7 @@
 			mux {
 				groups = "hdmi_hpd";
 				function = "hdmi_hpd";
+				bias-disable;
 			};
 		};
 
@@ -625,6 +667,7 @@
 			mux {
 				groups = "hdmi_sda", "hdmi_scl";
 				function = "hdmi_i2c";
+				bias-disable;
 			};
 		};
 
@@ -632,6 +675,7 @@
 			mux {
 				groups = "i2sout_ch23_y";
 				function = "i2s_out";
+				bias-disable;
 			};
 		};
 
@@ -639,6 +683,7 @@
 			mux {
 				groups = "i2sout_ch45_y";
 				function = "i2s_out";
+				bias-disable;
 			};
 		};
 
@@ -646,6 +691,7 @@
 			mux {
 				groups = "i2sout_ch67_y";
 				function = "i2s_out";
+				bias-disable;
 			};
 		};
 
@@ -653,6 +699,7 @@
 			mux {
 				groups = "spdif_out_y";
 				function = "spdif_out";
+				bias-disable;
 			};
 		};
 	};
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
index cfeec5579726..ed278097825b 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
@@ -116,6 +116,7 @@
 			mux {
 				groups = "uart_tx_ao_a", "uart_rx_ao_a";
 				function = "uart_ao";
+				bias-disable;
 			};
 		};
 
@@ -124,6 +125,7 @@
 				groups = "uart_cts_ao_a",
 				       "uart_rts_ao_a";
 				function = "uart_ao";
+				bias-disable;
 			};
 		};
 
@@ -131,6 +133,7 @@
 			mux {
 				groups = "uart_tx_ao_b", "uart_rx_ao_b";
 				function = "uart_ao_b";
+				bias-disable;
 			};
 		};
 
@@ -138,6 +141,7 @@
 			mux {
 				groups = "uart_tx_ao_b_0", "uart_rx_ao_b_1";
 				function = "uart_ao_b";
+				bias-disable;
 			};
 		};
 
@@ -146,6 +150,7 @@
 				groups = "uart_cts_ao_b",
 				       "uart_rts_ao_b";
 				function = "uart_ao_b";
+				bias-disable;
 			};
 		};
 
@@ -153,6 +158,7 @@
 			mux {
 				groups = "remote_input_ao";
 				function = "remote_input_ao";
+				bias-disable;
 			};
 		};
 
@@ -161,6 +167,7 @@
 				groups = "i2c_sck_ao",
 				       "i2c_sda_ao";
 				function = "i2c_ao";
+				bias-disable;
 			};
 		};
 
@@ -168,6 +175,7 @@
 			mux {
 				groups = "pwm_ao_a_3";
 				function = "pwm_ao_a";
+				bias-disable;
 			};
 		};
 
@@ -175,6 +183,7 @@
 			mux {
 				groups = "pwm_ao_a_8";
 				function = "pwm_ao_a";
+				bias-disable;
 			};
 		};
 
@@ -182,6 +191,7 @@
 			mux {
 				groups = "pwm_ao_b";
 				function = "pwm_ao_b";
+				bias-disable;
 			};
 		};
 
@@ -189,6 +199,7 @@
 			mux {
 				groups = "pwm_ao_b_6";
 				function = "pwm_ao_b";
+				bias-disable;
 			};
 		};
 
@@ -196,6 +207,7 @@
 			mux {
 				groups = "i2s_out_ch23_ao";
 				function = "i2s_out_ao";
+				bias-disable;
 			};
 		};
 
@@ -203,6 +215,7 @@
 			mux {
 				groups = "i2s_out_ch45_ao";
 				function = "i2s_out_ao";
+				bias-disable;
 			};
 		};
 
@@ -210,6 +223,7 @@
 			mux {
 				groups = "spdif_out_ao_6";
 				function = "spdif_out_ao";
+				bias-disable;
 			};
 		};
 
@@ -217,6 +231,7 @@
 			mux {
 				groups = "spdif_out_ao_9";
 				function = "spdif_out_ao";
+				bias-disable;
 			};
 		};
 
@@ -224,6 +239,7 @@
 			mux {
 				groups = "ao_cec";
 				function = "cec_ao";
+				bias-disable;
 			};
 		};
 
@@ -231,6 +247,7 @@
 			mux {
 				groups = "ee_cec";
 				function = "cec_ao";
+				bias-disable;
 			};
 		};
 	};
@@ -337,6 +354,7 @@
 				       "nor_c",
 				       "nor_cs";
 				function = "nor";
+				bias-disable;
 			};
 		};
 
@@ -346,6 +364,7 @@
 					"spi_mosi",
 					"spi_sclk";
 				function = "spi";
+				bias-disable;
 			};
 		};
 
@@ -353,6 +372,7 @@
 			mux {
 				groups = "spi_ss0";
 				function = "spi";
+				bias-disable;
 			};
 		};
 
@@ -402,6 +422,7 @@
 			mux {
 				groups = "sdio_irq";
 				function = "sdio";
+				bias-disable;
 			};
 		};
 
@@ -410,6 +431,7 @@
 				groups = "uart_tx_a",
 				       "uart_rx_a";
 				function = "uart_a";
+				bias-disable;
 			};
 		};
 
@@ -418,6 +440,7 @@
 				groups = "uart_cts_a",
 				       "uart_rts_a";
 				function = "uart_a";
+				bias-disable;
 			};
 		};
 
@@ -426,6 +449,7 @@
 				groups = "uart_tx_b",
 				       "uart_rx_b";
 				function = "uart_b";
+				bias-disable;
 			};
 		};
 
@@ -434,6 +458,7 @@
 				groups = "uart_cts_b",
 				       "uart_rts_b";
 				function = "uart_b";
+				bias-disable;
 			};
 		};
 
@@ -442,6 +467,7 @@
 				groups = "uart_tx_c",
 				       "uart_rx_c";
 				function = "uart_c";
+				bias-disable;
 			};
 		};
 
@@ -450,6 +476,7 @@
 				groups = "uart_cts_c",
 				       "uart_rts_c";
 				function = "uart_c";
+				bias-disable;
 			};
 		};
 
@@ -458,6 +485,7 @@
 				groups = "i2c_sck_a",
 				     "i2c_sda_a";
 				function = "i2c_a";
+				bias-disable;
 			};
 		};
 
@@ -466,6 +494,7 @@
 				groups = "i2c_sck_b",
 				      "i2c_sda_b";
 				function = "i2c_b";
+				bias-disable;
 			};
 		};
 
@@ -474,6 +503,7 @@
 				groups = "i2c_sck_c",
 				      "i2c_sda_c";
 				function = "i2c_c";
+				bias-disable;
 			};
 		};
 
@@ -494,6 +524,7 @@
 				       "eth_txd2",
 				       "eth_txd3";
 				function = "eth";
+				bias-disable;
 			};
 		};
 
@@ -501,6 +532,7 @@
 			mux {
 				groups = "eth_link_led";
 				function = "eth_led";
+				bias-disable;
 			};
 		};
 
@@ -515,6 +547,7 @@
 			mux {
 				groups = "pwm_a";
 				function = "pwm_a";
+				bias-disable;
 			};
 		};
 
@@ -522,6 +555,7 @@
 			mux {
 				groups = "pwm_b";
 				function = "pwm_b";
+				bias-disable;
 			};
 		};
 
@@ -529,6 +563,7 @@
 			mux {
 				groups = "pwm_c";
 				function = "pwm_c";
+				bias-disable;
 			};
 		};
 
@@ -536,6 +571,7 @@
 			mux {
 				groups = "pwm_d";
 				function = "pwm_d";
+				bias-disable;
 			};
 		};
 
@@ -543,6 +579,7 @@
 			mux {
 				groups = "pwm_e";
 				function = "pwm_e";
+				bias-disable;
 			};
 		};
 
@@ -550,6 +587,7 @@
 			mux {
 				groups = "pwm_f_clk";
 				function = "pwm_f";
+				bias-disable;
 			};
 		};
 
@@ -557,6 +595,7 @@
 			mux {
 				groups = "pwm_f_x";
 				function = "pwm_f";
+				bias-disable;
 			};
 		};
 
@@ -564,6 +603,7 @@
 			mux {
 				groups = "hdmi_hpd";
 				function = "hdmi_hpd";
+				bias-disable;
 			};
 		};
 
@@ -571,6 +611,7 @@
 			mux {
 				groups = "hdmi_sda", "hdmi_scl";
 				function = "hdmi_i2c";
+				bias-disable;
 			};
 		};
 
@@ -578,6 +619,7 @@
 			mux {
 				groups = "i2s_am_clk";
 				function = "i2s_out";
+				bias-disable;
 			};
 		};
 
@@ -585,6 +627,7 @@
 			mux {
 				groups = "i2s_out_ao_clk";
 				function = "i2s_out";
+				bias-disable;
 			};
 		};
 
@@ -592,6 +635,7 @@
 			mux {
 				groups = "i2s_out_lr_clk";
 				function = "i2s_out";
+				bias-disable;
 			};
 		};
 
@@ -599,12 +643,14 @@
 			mux {
 				groups = "i2s_out_ch01";
 				function = "i2s_out";
+				bias-disable;
 			};
 		};
 		i2sout_ch23_z_pins: i2sout_ch23_z {
 			mux {
 				groups = "i2sout_ch23_z";
 				function = "i2s_out";
+				bias-disable;
 			};
 		};
 
@@ -612,6 +658,7 @@
 			mux {
 				groups = "i2sout_ch45_z";
 				function = "i2s_out";
+				bias-disable;
 			};
 		};
 
@@ -619,6 +666,7 @@
 			mux {
 				groups = "i2sout_ch67_z";
 				function = "i2s_out";
+				bias-disable;
 			};
 		};
 
@@ -626,6 +674,7 @@
 			mux {
 				groups = "spdif_out_h";
 				function = "spdif_out";
+				bias-disable;
 			};
 		};
 	};
-- 
2.19.1

