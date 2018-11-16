Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFD39C04EBC
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 12:56:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7A282250F
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 12:56:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="YAWY/21c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7A282250F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389934AbeKPXIU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 18:08:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:34082 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727965AbeKPXIU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 18:08:20 -0500
Received: from ziggy.de (unknown [93.176.133.217])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2ACCA22507;
        Fri, 16 Nov 2018 12:55:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542372962;
        bh=WW16hmSAu3cDtCEXwV03kGOnejJmROkh16btrAr+l3k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YAWY/21co5Dyko1/K6UuFZ7erUSseMyADNqy9aUyRSe+lOnQm+H8hTvCbKrvwHJu6
         3+CSvI9aRJufHYehXxc9/v5KxACxOVCm++0Z0fAlSkqAPuklh3fhUiFHGnkRonm01r
         cNPJuvKrERzSnYtd6ofCHSDnDFv5TStSpRn5+Jg8=
From:   matthias.bgg@kernel.org
To:     robh+dt@kernel.org, mark.rutland@arm.com, ck.hu@mediatek.com,
        p.zabel@pengutronix.de, airlied@linux.ie, mturquette@baylibre.com,
        sboyd@codeaurora.org, ulrich.hecht+renesas@gmail.com,
        laurent.pinchart@ideasonboard.com, matthias.bgg@gmail.com
Cc:     sean.wang@mediatek.com, sean.wang@kernel.org,
        rdunlap@infradead.org, wens@csie.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, Matthias Brugger <mbrugger@suse.com>
Subject: [PATCH v5 08/12] dt-bindings: mediatek: Change the binding for mmsys clocks
Date:   Fri, 16 Nov 2018 13:54:45 +0100
Message-Id: <20181116125449.23581-9-matthias.bgg@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181116125449.23581-1-matthias.bgg@kernel.org>
References: <20181116125449.23581-1-matthias.bgg@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matthias Brugger <mbrugger@suse.com>

On SoCs with no publical available HW or no working graphic stack
we change the devicetree binding for the mmsys clock part. This
way we don't need to register a platform device explicitly in the
drm driver. Instead we can create a mmsys child which invokes the
clock driver.

Signed-off-by: Matthias Brugger <mbrugger@suse.com>
---
 .../bindings/arm/mediatek/mediatek,mmsys.txt  | 21 ++++++++++++-------
 .../display/mediatek/mediatek,disp.txt        |  4 ++++
 2 files changed, 18 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.txt b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.txt
index 4468345f8b1a..d4e205981363 100644
--- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.txt
+++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.txt
@@ -1,4 +1,4 @@
-Mediatek mmsys controller
+Mediatek mmsys clock controller
 ============================
 
 The Mediatek mmsys controller provides various clocks to the system.
@@ -6,18 +6,25 @@ The Mediatek mmsys controller provides various clocks to the system.
 Required Properties:
 
 - compatible: Should be one of:
-	- "mediatek,mt2712-mmsys", "syscon"
-	- "mediatek,mt6797-mmsys", "syscon"
+	- "mediatek,mt2712-mmsys-clk", "syscon"
+	- "mediatek,mt6797-mmsys-clk", "syscon"
 - #clock-cells: Must be 1
 
-The mmsys controller uses the common clk binding from
+The mmsys clock controller uses the common clk binding from
 Documentation/devicetree/bindings/clock/clock-bindings.txt
 The available clocks are defined in dt-bindings/clock/mt*-clk.h.
+It is a child of the mmsys block, see binding at:
+Documentation/devicetree/bindings/display/mediatek/mediatek,disp.txt
 
 Example:
 
-mmsys: clock-controller@14000000 {
-	compatible = "mediatek,mt8173-mmsys", "syscon";
+mmsys: syscon@14000000 {
+	compatible = "mediatek,mt2712-mmsys", "syscon", "simple-mfd";
 	reg = <0 0x14000000 0 0x1000>;
-	#clock-cells = <1>;
+
+	mmsys_clk: clock-controller@14000000 {
+		compatible = "mediatek,mt2712-mmsys-clk";
+		#clock-cells = <1>;
+	};
+
 };
diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,disp.txt b/Documentation/devicetree/bindings/display/mediatek/mediatek,disp.txt
index 4b008d992398..38c708cb7e55 100644
--- a/Documentation/devicetree/bindings/display/mediatek/mediatek,disp.txt
+++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,disp.txt
@@ -54,6 +54,10 @@ Required properties (all function blocks):
   DPI controller nodes have multiple clock inputs. These are documented in
   mediatek,dsi.txt and mediatek,dpi.txt, respectively.
 
+Some chips have a separate binding for the clock controller, which is a child node
+of the mmsys device, for more information see:
+Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.txt
+
 Required properties (DMA function blocks):
 - compatible: Should be one of
 	"mediatek,<chip>-disp-ovl"
-- 
2.19.1

