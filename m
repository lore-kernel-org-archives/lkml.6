Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37776C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 13:11:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FE402133F
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 13:11:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728915AbeLSNLp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 08:11:45 -0500
Received: from mail.lysator.liu.se ([130.236.254.3]:60435 "EHLO
        mail.lysator.liu.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728809AbeLSNLh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 08:11:37 -0500
Received: from mail.lysator.liu.se (localhost [127.0.0.1])
        by mail.lysator.liu.se (Postfix) with ESMTP id 693FA4002E;
        Wed, 19 Dec 2018 14:05:01 +0100 (CET)
Received: from orc.pedanet (c-17f4e255.26241707-0-68616c6d7374616473746164736e6174.bbcust.telenor.se [85.226.244.23])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.lysator.liu.se (Postfix) with ESMTPSA id 17ADE40005;
        Wed, 19 Dec 2018 14:05:01 +0100 (CET)
From:   Peter Rosin <peda@lysator.liu.se>
To:     linux-kernel@vger.kernel.org
Cc:     Peter Rosin <peda@axentia.se>, David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org
Subject: [PATCH v2 1/3] dt-bindings: display: bridge: fork out ti,ds90c185 from lvds-transmitter
Date:   Wed, 19 Dec 2018 14:04:47 +0100
Message-Id: <20181219130449.31641-2-peda@lysator.liu.se>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20181219130449.31641-1-peda@lysator.liu.se>
References: <20181219130449.31641-1-peda@lysator.liu.se>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Rosin <peda@axentia.se>

DS90C185 has a shutdown pin which does not fit in the lvds-transmitter
binding, which is meant to be generic.

The sister chip DS90C187 is similar to DS90C185, describe it here as well.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 .../bindings/display/bridge/lvds-transmitter.txt   |  8 +---
 .../bindings/display/bridge/ti,ds90c185.txt        | 55 ++++++++++++++++++++++
 2 files changed, 56 insertions(+), 7 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/display/bridge/ti,ds90c185.txt

diff --git a/Documentation/devicetree/bindings/display/bridge/lvds-transmitter.txt b/Documentation/devicetree/bindings/display/bridge/lvds-transmitter.txt
index 50220190c203..fd39ad34c383 100644
--- a/Documentation/devicetree/bindings/display/bridge/lvds-transmitter.txt
+++ b/Documentation/devicetree/bindings/display/bridge/lvds-transmitter.txt
@@ -22,13 +22,7 @@ among others.
 
 Required properties:
 
-- compatible: Must be one or more of the following
-  - "ti,ds90c185" for the TI DS90C185 FPD-Link Serializer
-  - "lvds-encoder" for a generic LVDS encoder device
-
-  When compatible with the generic version, nodes must list the
-  device-specific version corresponding to the device first
-  followed by the generic version.
+- compatible: Must be "lvds-encoder"
 
 Required nodes:
 
diff --git a/Documentation/devicetree/bindings/display/bridge/ti,ds90c185.txt b/Documentation/devicetree/bindings/display/bridge/ti,ds90c185.txt
new file mode 100644
index 000000000000..a13e778503e6
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/bridge/ti,ds90c185.txt
@@ -0,0 +1,55 @@
+Texas Instruments FPD-Link (LVDS) Serializer
+--------------------------------------------
+
+The DS90C185 and DS90C187 are low-power serializers for portable
+battery-powered applications that reduces the size of the RGB
+interface between the host GPU and the display.
+
+Required properties:
+
+- compatible: Should be
+  "ti,ds90c185", "lvds-encoder"  for the TI DS90C185 FPD-Link Serializer
+  "ti,ds90c187", "lvds-encoder"  for the TI DS90C187 FPD-Link Serializer
+
+Optional properties:
+
+- pwdn-gpios: Power down control GPIO (the PDB pin, active-low)
+
+Required nodes:
+
+The devices have two video ports. Their connections are modeled using the OF
+graph bindings specified in Documentation/devicetree/bindings/graph.txt.
+
+- Video port 0 for parallel input
+- Video port 1 for LVDS output
+
+
+Example
+-------
+
+lvds-encoder {
+	compatible = "ti,ds90c185", "lvds-encoder";
+
+	pwdn-gpios = <&gpio 17 GPIO_ACTIVE_LOW>;
+
+	ports {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		port@0 {
+			reg = <0>;
+
+			lvds_enc_in: endpoint {
+				remote-endpoint = <&lcdc_out_rgb>;
+			};
+		};
+
+		port@1 {
+			reg = <1>;
+
+			lvds_enc_out: endpoint {
+				remote-endpoint = <&lvds_panel_in>;
+			};
+		};
+	};
+};
-- 
2.11.0

