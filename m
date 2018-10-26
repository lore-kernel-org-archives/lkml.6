Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0B64ECDE46
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 17:36:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABCD82084D
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 17:36:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="I2+lbxXK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABCD82084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727679AbeJ0CNz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 22:13:55 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:36724 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727623AbeJ0CNz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 22:13:55 -0400
Received: by mail-pf1-f194.google.com with SMTP id l81-v6so893974pfg.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Oct 2018 10:36:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xuYKlm6mh0oPqnrGGq1xfr15WJea0AO3HvLc6Hnl/C0=;
        b=I2+lbxXKANGIQ3QjKx+MmLq1lxCOH9pQJTaAWBcKr8RgwmvdqzwJIQuXNpo25WJofH
         +9V/BlP6QDRsl1owXDLppxvefLMum1FVeC+AS5sQ6tcXYojpDOnv6T0sCBn+f/bntIZ5
         3SKOVkTerNk2Ep+VuC5pyE9F07U37zWGPvmZA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xuYKlm6mh0oPqnrGGq1xfr15WJea0AO3HvLc6Hnl/C0=;
        b=StX7YSkZSjPYut8lp8Pb3aSkwcxIVqQAUPjZM8hhpcK8WRqQw5gdB+SwY74WxDLOQQ
         44hkl/y42iQOAzctFLIhsrUDX3fYppw8A4jON1PhUGFncf4mXZi422ytDLOWjJIvkHgH
         uJdQi4Zb3TS4ZotzlX1fR43ckC8FzN2rWH4pSzsKJVosqQAc3tQaLJ8Aa6jtwasCmBm8
         qrQJrubEQrmc3vnFnB8/n/80KTZsFnoN2q+GInnk9I8hUSr4uqkMmNnlf6+XOFEXGRZO
         KbFSCerpokqUnJyetRt7O0oyirt1yaE2cjSBTBMljp3yRmovMM46Wp9AE7c1AyHl7GCU
         gEzA==
X-Gm-Message-State: AGRZ1gKztcHkWZ6wbATEXZaH413jm7OYWfx1Q73zyRYTPTJsIwnFuUI3
        +rMFVY5eKVu1W/W16yG8b80oJw==
X-Google-Smtp-Source: AJdET5cTSLKNWa5YK0n4Zov7ogvIL4q3Dpq9n1IZKezlYrxSzURiUHdG83JtcqZRrchVbinh7ZWPxw==
X-Received: by 2002:a62:7d81:: with SMTP id y123-v6mr4602647pfc.245.1540575361130;
        Fri, 26 Oct 2018 10:36:01 -0700 (PDT)
Received: from evgreen2.mtv.corp.google.com ([2620:15c:202:201:e418:c825:76cf:5f64])
        by smtp.gmail.com with ESMTPSA id b29-v6sm20164448pfj.183.2018.10.26.10.35.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 26 Oct 2018 10:36:00 -0700 (PDT)
From:   Evan Green <evgreen@chromium.org>
To:     Rob Herring <robh@kernel.org>, Andy Gross <andy.gross@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Douglas Anderson <dianders@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Evan Green <evgreen@chromium.org>, devicetree@vger.kernel.org,
        Can Guo <cang@codeaurora.org>, linux-kernel@vger.kernel.org,
        Manu Gautam <mgautam@codeaurora.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: [PATCH v5 1/5] dt-bindings: phy-qcom-qmp: Fix register underspecification
Date:   Fri, 26 Oct 2018 10:35:40 -0700
Message-Id: <20181026173544.136037-2-evgreen@chromium.org>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20181026173544.136037-1-evgreen@chromium.org>
References: <20181026173544.136037-1-evgreen@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add register regions for the second lane of dual-lane nodes.
This additional specification is needed so that the driver can stop
reaching beyond the tx and rx register allocations to get at the
second lane registers in a dual-lane PHY.

While in there, document #clock-cells as optional for PHYs that don't
provide a pipe clock. Also, document the pcs_misc register region, which
was being quietly supplied and used.

Signed-off-by: Evan Green <evgreen@chromium.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Rob Herring <robh@kernel.org>

---

Changes in v5:
- Fix incorrect register value in example, copied from real life!

Changes in v4:
- Remove "status" from DT binding example (Rob)

Changes in v3: None
Changes in v2:
- Added dt bindings change, corresponding driver fixup, and USB PHY fixup

 .../devicetree/bindings/phy/qcom-qmp-phy.txt       | 70 +++++++++++++++++++---
 1 file changed, 62 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt b/Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt
index fbc198d5dd39..f7b532125a4d 100644
--- a/Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt
+++ b/Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt
@@ -25,7 +25,7 @@ Required properties:
   - For all others:
     - The reg-names property shouldn't be defined.
 
- - #clock-cells: must be 1
+ - #clock-cells: must be 1 (PCIe and USB3 PHYs only)
     - Phy pll outputs a bunch of clocks for Tx, Rx and Pipe
       interface (for pipe based PHYs). These clock are then gate-controlled
       by gcc.
@@ -82,23 +82,26 @@ Required nodes:
  - Each device node of QMP phy is required to have as many child nodes as
    the number of lanes the PHY has.
 
-Required properties for child node:
+Required properties for child nodes of PCIe PHYs (one child per lane):
  - reg: list of offset and length pairs of register sets for PHY blocks -
-	- index 0: tx
-	- index 1: rx
-	- index 2: pcs
-	- index 3: pcs_misc (optional)
+	tx, rx, pcs, and pcs_misc (optional).
+ - #phy-cells: must be 0
 
+Required properties for a single "lanes" child node of non-PCIe PHYs:
+ - reg: list of offset and length pairs of register sets for PHY blocks
+	For 1-lane devices:
+		tx, rx, pcs, and (optionally) pcs_misc
+	For 2-lane devices:
+		tx0, rx0, pcs, tx1, rx1, and (optionally) pcs_misc
  - #phy-cells: must be 0
 
-Required properties child node of pcie and usb3 qmp phys:
+Required properties for child node of PCIe and USB3 qmp phys:
  - clocks: a list of phandles and clock-specifier pairs,
 	   one for each entry in clock-names.
  - clock-names: Must contain following:
 		 "pipe<lane-number>" for pipe clock specific to each lane.
  - clock-output-names: Name of the PHY clock that will be the parent for
 		       the above pipe clock.
-
 	For "qcom,ipq8074-qmp-pcie-phy":
 		- "pcie20_phy0_pipe_clk"	Pipe Clock parent
 			(or)
@@ -150,3 +153,54 @@ Example:
 		...
 		...
 	};
+
+	phy@88eb000 {
+		compatible = "qcom,sdm845-qmp-usb3-uni-phy";
+		reg = <0x88eb000 0x18c>;
+		#clock-cells = <1>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		clocks = <&gcc GCC_USB3_SEC_PHY_AUX_CLK>,
+			 <&gcc GCC_USB_PHY_CFG_AHB2PHY_CLK>,
+			 <&gcc GCC_USB3_SEC_CLKREF_CLK>,
+			 <&gcc GCC_USB3_SEC_PHY_COM_AUX_CLK>;
+		clock-names = "aux", "cfg_ahb", "ref", "com_aux";
+
+		resets = <&gcc GCC_USB3PHY_PHY_SEC_BCR>,
+			 <&gcc GCC_USB3_PHY_SEC_BCR>;
+		reset-names = "phy", "common";
+
+		lane@88eb200 {
+			reg = <0x88eb200 0x128>,
+			      <0x88eb400 0x1fc>,
+			      <0x88eb800 0x218>,
+			      <0x88eb600 0x70>;
+			#phy-cells = <0>;
+			clocks = <&gcc GCC_USB3_SEC_PHY_PIPE_CLK>;
+			clock-names = "pipe0";
+			clock-output-names = "usb3_uni_phy_pipe_clk_src";
+		};
+	};
+
+	phy@1d87000 {
+		compatible = "qcom,sdm845-qmp-ufs-phy";
+		reg = <0x1d87000 0x18c>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+		clock-names = "ref",
+			      "ref_aux";
+		clocks = <&gcc GCC_UFS_MEM_CLKREF_CLK>,
+			 <&gcc GCC_UFS_PHY_PHY_AUX_CLK>;
+
+		lanes@1d87400 {
+			reg = <0x1d87400 0x108>,
+			      <0x1d87600 0x1e0>,
+			      <0x1d87c00 0x1dc>,
+			      <0x1d87800 0x108>,
+			      <0x1d87a00 0x1e0>;
+			#phy-cells = <0>;
+		};
+	};
-- 
2.16.4

