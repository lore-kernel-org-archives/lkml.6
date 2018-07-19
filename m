Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C0E6C468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 11:12:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7ED720684
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 11:12:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="B3giSNId"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7ED720684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730763AbeGSLz1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 07:55:27 -0400
Received: from mail-lj1-f175.google.com ([209.85.208.175]:36167 "EHLO
        mail-lj1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727702AbeGSLz0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 07:55:26 -0400
Received: by mail-lj1-f175.google.com with SMTP id u7-v6so6864459lji.3
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jul 2018 04:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=BmLrT7gE7Autb1nWTgYaPcoIuEoqpazC62ER5SdKMMY=;
        b=B3giSNIdkYTUvwbAvsUxAxCeCbhPx1sxyx0NRLeinih5fISUgm1YN/PZFtwmv5YaZg
         Ph0IqC2F05rL3R+WJIhdrCQRhNsBfoi0IU3k8TYiHOH9t86ipE7+X4YM1Oqm9/pIRMh6
         j0ew7u0oW4s7eMLxZjFd2fGJ7oQdpcPe9T7kw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=BmLrT7gE7Autb1nWTgYaPcoIuEoqpazC62ER5SdKMMY=;
        b=G3/XRYN/+u/bKvO9yiwWdOVeIU39IArwep3BtXR0Lc0+fUCI3/V0rApiTIrgRwaFqn
         L+3I4v6W6rP7NDJIY2glfUycLnpW2rIarneB6lX3s/5kdXjuxV5RN0O8/0u0W2a1ALCs
         3sFoOHJOorr/oy1587woKaTM8QFzacHTG3RHTMHJiYQJvMd3koZBJMRfpnyCJsvqyKMN
         qS4aJzp3XHYvtUnCovZr4r9QMdxq5wvG1Jj8IxzLsp8pPU1VEQxnAlk/6bklkU4aKkiW
         uprUDXsfxWfteAw9JCV8EJklrE0AoLh8LK9iCnMZoTaNlSW7FVjzvbTXsXLKBl9AWDZx
         5NFg==
X-Gm-Message-State: AOUpUlGrfzzGCgE0gP9VO4mNSo7ujkjktaljrEVch4RZcaSKM0Zp5k4k
        hyFBjHXybsIcBASqjvxX8YOHlg==
X-Google-Smtp-Source: AAOMgpeInUV0K3udhueBjf7fkH8Ti7So+e7UutEoPBqcRJnqMHO65Xgu3WztmCRATD9Xpl/dz7++xA==
X-Received: by 2002:a2e:9004:: with SMTP id h4-v6mr7827746ljg.44.1531998764741;
        Thu, 19 Jul 2018 04:12:44 -0700 (PDT)
Received: from localhost.localdomain (h-229-118.A785.priv.bahnhof.se. [5.150.229.118])
        by smtp.gmail.com with ESMTPSA id w14-v6sm1061498ljh.71.2018.07.19.04.12.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 19 Jul 2018 04:12:44 -0700 (PDT)
From:   Niklas Cassel <niklas.cassel@linaro.org>
To:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Nicolas Dechesne <nicolas.dechesne@linaro.org>,
        Niklas Cassel <niklas.cassel@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] arm64: dts: msm8916: drop legacy suffix for clocks used by MSM DRM driver
Date:   Thu, 19 Jul 2018 13:12:34 +0200
Message-Id: <20180719111235.22421-1-niklas.cassel@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop legacy suffix for clocks used by MSM DRM driver.

The _clk suffix has been deprecated since commit 20c3bb80235 ("drm/msm:
drop _clk suffix from clk names").

Fixes the following warnings during boot:

msm_dsi_phy 1a98300.dsi-phy: Using legacy clk name binding.  Use "iface" instead of "iface_clk"
msm 1a00000.mdss: Using legacy clk name binding.  Use "iface" instead of "iface_clk"
msm 1a00000.mdss: Using legacy clk name binding.  Use "bus" instead of "bus_clk"
msm 1a00000.mdss: Using legacy clk name binding.  Use "vsync" instead of "vsync_clk"
msm_mdp 1a01000.mdp: Using legacy clk name binding.  Use "bus" instead of "bus_clk"
msm_mdp 1a01000.mdp: Using legacy clk name binding.  Use "iface" instead of "iface_clk"
msm_mdp 1a01000.mdp: Using legacy clk name binding.  Use "core" instead of "core_clk"
msm_mdp 1a01000.mdp: Using legacy clk name binding.  Use "vsync" instead of "vsync_clk"
msm_dsi 1a98000.dsi: Using legacy clk name binding.  Use "mdp_core" instead of "mdp_core_clk"
msm_dsi 1a98000.dsi: Using legacy clk name binding.  Use "iface" instead of "iface_clk"
msm_dsi 1a98000.dsi: Using legacy clk name binding.  Use "bus" instead of "bus_clk"
msm_dsi 1a98000.dsi: Using legacy clk name binding.  Use "byte" instead of "byte_clk"
msm_dsi 1a98000.dsi: Using legacy clk name binding.  Use "pixel" instead of "pixel_clk"
msm_dsi 1a98000.dsi: Using legacy clk name binding.  Use "core" instead of "core_clk"

Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
Reviewed-by: Nicolas Dechesne <nicolas.dechesne@linaro.org>
---
Changes since v1:
-Improved commit message.

 arch/arm64/boot/dts/qcom/msm8916.dtsi | 28 +++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
index c2625d15a8c0..7b32b8990d62 100644
--- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
@@ -858,9 +858,9 @@
 			clocks = <&gcc GCC_MDSS_AHB_CLK>,
 				 <&gcc GCC_MDSS_AXI_CLK>,
 				 <&gcc GCC_MDSS_VSYNC_CLK>;
-			clock-names = "iface_clk",
-				      "bus_clk",
-				      "vsync_clk";
+			clock-names = "iface",
+				      "bus",
+				      "vsync";
 
 			interrupts = <0 72 IRQ_TYPE_LEVEL_HIGH>;
 
@@ -883,10 +883,10 @@
 					 <&gcc GCC_MDSS_AXI_CLK>,
 					 <&gcc GCC_MDSS_MDP_CLK>,
 					 <&gcc GCC_MDSS_VSYNC_CLK>;
-				clock-names = "iface_clk",
-					      "bus_clk",
-					      "core_clk",
-					      "vsync_clk";
+				clock-names = "iface",
+					      "bus",
+					      "core",
+					      "vsync";
 
 				iommus = <&apps_iommu 4>;
 
@@ -922,12 +922,12 @@
 					 <&gcc GCC_MDSS_BYTE0_CLK>,
 					 <&gcc GCC_MDSS_PCLK0_CLK>,
 					 <&gcc GCC_MDSS_ESC0_CLK>;
-				clock-names = "mdp_core_clk",
-					      "iface_clk",
-					      "bus_clk",
-					      "byte_clk",
-					      "pixel_clk",
-					      "core_clk";
+				clock-names = "mdp_core",
+					      "iface",
+					      "bus",
+					      "byte",
+					      "pixel",
+					      "core";
 				phys = <&dsi_phy0>;
 				phy-names = "dsi-phy";
 
@@ -963,7 +963,7 @@
 				#phy-cells = <0>;
 
 				clocks = <&gcc GCC_MDSS_AHB_CLK>;
-				clock-names = "iface_clk";
+				clock-names = "iface";
 			};
 		};
 
-- 
2.17.1

