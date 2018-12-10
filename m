Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5354AC04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 19:28:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1330A2084C
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 19:28:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SbcvbUBs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1330A2084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729284AbeLJT2u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 14:28:50 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:37901 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729240AbeLJT2s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 14:28:48 -0500
Received: by mail-pf1-f193.google.com with SMTP id q1so5872477pfi.5
        for <linux-kernel@vger.kernel.org>; Mon, 10 Dec 2018 11:28:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GtvLm796l9zcE9X2QBqdH2TSAhlWDzcyKdXJhnax1GQ=;
        b=SbcvbUBs3XLl+G10G8MFMNI4d7f8wmpLTOmABXYclImDe4+FXR1kfab/zOpfUk/ZHw
         oJOrqBNVIztI7T0Eyel8TgKwkX4R+Oqb5CHi67A9ZuoaYPg2Mx1pOJEMbSCknWFKUFCs
         VBnH8S8TamVtt8kEF7+1BYy+JcdXtexa8d6qA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GtvLm796l9zcE9X2QBqdH2TSAhlWDzcyKdXJhnax1GQ=;
        b=F4o/S01rmzn5BXtwRySSpuK3CnpUqNHnmPbOH8QZcdV6yKTmOoWiMy0gDxZ/DmTgGc
         kwtFlKh3Fdf6h7O4H95lARfheSlQKlnRtCi6hdo5SKSgNjz2CvBShF+487ABe1HB3AHA
         uWJPDioB3RbezIstcqEfJGv0H+bkFVVa+Jlqt6Mnk+7Drh8EQ0ymdT9QQPAFJGgwnfGf
         mW2Gr4DidPqYSButubCGyalURmA2X42TEc3x3V++QNWgvnoV+pDw3KSeOrEd3sqQg4eb
         bfH/LYfvLCSpTvFTBUuqOgKY1z/EXpJoZJChdDhJw5YXkRf70t2e04BltkDKwgfs6iQt
         dvkA==
X-Gm-Message-State: AA+aEWbKcUK8DxNF7Tut5FF+rDbkUYJ45hFXzZfLGQsPZpzwpm+f4LvT
        yUI3XRfQrQxOMH56HkWTfxfGZwFztMU=
X-Google-Smtp-Source: AFSGD/WCNtjXmH01+xpfLN5kQJ5yFcbacaCGl2O9P/sd3tuT6FUeXsmum6BLD5g41Qksl+sWze4l/g==
X-Received: by 2002:a65:4ccb:: with SMTP id n11mr12181072pgt.257.1544470126680;
        Mon, 10 Dec 2018 11:28:46 -0800 (PST)
Received: from evgreen2.mtv.corp.google.com ([2620:15c:202:201:ffda:7716:9afc:1301])
        by smtp.gmail.com with ESMTPSA id v12sm18318674pgg.41.2018.12.10.11.28.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 10 Dec 2018 11:28:46 -0800 (PST)
From:   Evan Green <evgreen@chromium.org>
To:     Andy Gross <andy.gross@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Douglas Anderson <dianders@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Evan Green <evgreen@chromium.org>, devicetree@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v7 1/5] dt-bindings: phy-qcom-qmp: Fix register underspecification
Date:   Mon, 10 Dec 2018 11:28:22 -0800
Message-Id: <20181210192826.241350-2-evgreen@chromium.org>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20181210192826.241350-1-evgreen@chromium.org>
References: <20181210192826.241350-1-evgreen@chromium.org>
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

Changes in v7: None
Changes in v6: None
Changes in v5:
- Fix incorrect register value in example, copied from real life!

Changes in v4:
- Remove "status" from DT binding example (Rob)

Changes in v3: None
Changes in v2:
- Added dt bindings change, corresponding driver fixup, and USB PHY fixup

 .../devicetree/bindings/phy/qcom-qmp-phy.txt  | 69 +++++++++++++++++--
 1 file changed, 62 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt b/Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt
index adf20b2bdf715..c7a71e67ebdf5 100644
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
@@ -70,22 +70,26 @@ Required nodes:
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
 
+Required properties for child node of PCIe and USB3 qmp phys:
  - clocks: a list of phandles and clock-specifier pairs,
 	   one for each entry in clock-names.
  - clock-names: Must contain following for pcie and usb qmp phys:
 		 "pipe<lane-number>" for pipe clock specific to each lane.
  - clock-output-names: Name of the PHY clock that will be the parent for
 		       the above pipe clock.
-
 	For "qcom,ipq8074-qmp-pcie-phy":
 		- "pcie20_phy0_pipe_clk"	Pipe Clock parent
 			(or)
@@ -135,3 +139,54 @@ Example:
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
2.18.1

