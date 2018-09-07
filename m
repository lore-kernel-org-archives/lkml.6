Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6112BC43143
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 04:28:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2238920869
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 04:28:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2238920869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726665AbeIGJHo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 05:07:44 -0400
Received: from mirror2.csie.ntu.edu.tw ([140.112.30.76]:39966 "EHLO
        wens.csie.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725963AbeIGJHn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 05:07:43 -0400
Received: by wens.csie.org (Postfix, from userid 1000)
        id CEA3F5FD46; Fri,  7 Sep 2018 12:19:50 +0800 (CST)
From:   Chen-Yu Tsai <wens@csie.org>
To:     Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Chen-Yu Tsai <wens@csie.org>, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com, Jonathan Liu <net147@gmail.com>
Subject: [PATCH v2 4/6] drm/panel: simple: Add support for Banana Pi 7" S070WV20-CT16 panel
Date:   Fri,  7 Sep 2018 12:19:46 +0800
Message-Id: <20180907041948.19913-5-wens@csie.org>
X-Mailer: git-send-email 2.19.0.rc1
In-Reply-To: <20180907041948.19913-1-wens@csie.org>
References: <20180907041948.19913-1-wens@csie.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This panel is marketed as Banana Pi 7" LCD display. On the back is
a sticker denoting the model name S070WV20-CT16.

This is a 7" 800x480 panel connected through a 24-bit RGB interface.
However the panel only does 262k colors.

Depending on the variant, the PCB attached to the panel module either
supports DSI, or DSI + 24-bit RGB. DSI is converted to 24-bit RGB via
an onboard ICN6211 MIPI DSI - RGB bridge chip, then fed to the panel
itself.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 .../display/panel/bananapi,s070wv20-ct16.txt  | 12 +++++++++
 drivers/gpu/drm/panel/panel-simple.c          | 25 +++++++++++++++++++
 2 files changed, 37 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/bananapi,s070wv20-ct16.txt

diff --git a/Documentation/devicetree/bindings/display/panel/bananapi,s070wv20-ct16.txt b/Documentation/devicetree/bindings/display/panel/bananapi,s070wv20-ct16.txt
new file mode 100644
index 000000000000..35bc0c839f49
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/bananapi,s070wv20-ct16.txt
@@ -0,0 +1,12 @@
+Banana Pi 7" (S070WV20-CT16) TFT LCD Panel
+
+Required properties:
+- compatible: should be "bananapi,s070wv20-ct16"
+- power-supply: see ./panel-common.txt
+
+Optional properties:
+- enable-gpios: see ./simple-panel.txt
+- backlight: see ./simple-panel.txt
+
+This binding is compatible with the simple-panel binding, which is specified
+in ./simple-panel.txt.
diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index 97964f7f2ace..52d6ac572825 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -772,6 +772,28 @@ static const struct panel_desc avic_tm070ddh03 = {
 	},
 };
 
+static const struct drm_display_mode bananapi_s070wv20_ct16_mode = {
+	.clock = 30000,
+	.hdisplay = 800,
+	.hsync_start = 800 + 40,
+	.hsync_end = 800 + 40 + 48,
+	.htotal = 800 + 40 + 48 + 40,
+	.vdisplay = 480,
+	.vsync_start = 480 + 13,
+	.vsync_end = 480 + 13 + 3,
+	.vtotal = 480 + 13 + 3 + 29,
+};
+
+static const struct panel_desc bananapi_s070wv20_ct16 = {
+	.modes = &bananapi_s070wv20_ct16_mode,
+	.num_modes = 1,
+	.bpc = 6,
+	.size = {
+		.width = 154,
+		.height = 86,
+	},
+};
+
 static const struct drm_display_mode boe_hv070wsa_mode = {
 	.clock = 40800,
 	.hdisplay = 1024,
@@ -2369,6 +2391,9 @@ static const struct of_device_id platform_of_match[] = {
 	}, {
 		.compatible = "avic,tm070ddh03",
 		.data = &avic_tm070ddh03,
+	}, {
+		.compatible = "bananapi,s070wv20-ct16",
+		.data = &bananapi_s070wv20_ct16,
 	}, {
 		.compatible = "boe,hv070wsa-100",
 		.data = &boe_hv070wsa
-- 
2.19.0.rc1

