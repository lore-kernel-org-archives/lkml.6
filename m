Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CAB3C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 10:28:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2635725C83
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 10:28:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2635725C83
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sntech.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965580AbeGBK2O (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 06:28:14 -0400
Received: from gloria.sntech.de ([185.11.138.130]:36174 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965481AbeGBK1h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 06:27:37 -0400
Received: from wd0142.dip.tu-dresden.de ([141.76.108.142] helo=phil.dip.tu-dresden.de)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1fZw3R-0004Ek-6o; Mon, 02 Jul 2018 12:27:33 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     thierry.reding@gmail.com
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, seanpaul@chromium.org,
        briannorris@chromium.org, hl@rock-chips.com,
        emil.l.velikov@gmail.com, Heiko Stuebner <heiko@sntech.de>
Subject: [PATCH v5 4/4] drm/panel: p079zca: support Innolux P097PFG panel
Date:   Mon,  2 Jul 2018 12:27:21 +0200
Message-Id: <20180702102721.3546-5-heiko@sntech.de>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180702102721.3546-1-heiko@sntech.de>
References: <20180702102721.3546-1-heiko@sntech.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lin Huang <hl@rock-chips.com>

Support Innolux P097PFG 9.7" 1536x2048 TFT LCD panel, it reuse
the Innolux P079ZCA panel driver.

Changes in v2:
- None
Changes in v3:
- None
Changes in v4:
- None
Changes in v5:
- Document source of init-commands
- 4 lanes per DSI interface

Signed-off-by: Lin Huang <hl@rock-chips.com>
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 drivers/gpu/drm/panel/panel-innolux-p079zca.c | 200 +++++++++++++++++-
 1 file changed, 196 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-innolux-p079zca.c b/drivers/gpu/drm/panel/panel-innolux-p079zca.c
index 630b0c2549ef..8d25b87bfbd6 100644
--- a/drivers/gpu/drm/panel/panel-innolux-p079zca.c
+++ b/drivers/gpu/drm/panel/panel-innolux-p079zca.c
@@ -20,6 +20,15 @@
 
 #include <video/mipi_display.h>
 
+struct panel_init_cmd {
+	int len;
+	const char *data;
+};
+
+#define _INIT_CMD(...) { \
+	.len = sizeof((char[]){__VA_ARGS__}), \
+	.data = (char[]){__VA_ARGS__} }
+
 struct panel_desc {
 	const struct drm_display_mode *modes;
 	unsigned int bpc;
@@ -30,6 +39,7 @@ struct panel_desc {
 
 	unsigned long flags;
 	enum mipi_dsi_pixel_format format;
+	const struct panel_init_cmd *init_cmds;
 	unsigned int lanes;
 	const char * const *supply_names;
 	unsigned int num_supplies;
@@ -121,13 +131,43 @@ static int innolux_panel_prepare(struct drm_panel *panel)
 	if (err < 0)
 		return err;
 
-	/* T2: 15ms - 1000ms */
-	usleep_range(15000, 16000);
+	/* p079zca: t2 (20ms), p097pfg: t4 (15ms) */
+	usleep_range(20000, 21000);
 
 	gpiod_set_value_cansleep(innolux->enable_gpio, 1);
 
-	/* T4: 15ms - 1000ms */
-	usleep_range(15000, 16000);
+	/* p079zca: t4, p097pfg: t5 */
+	usleep_range(20000, 21000);
+
+	if (innolux->desc->init_cmds) {
+		const struct panel_init_cmd *cmds =
+					innolux->desc->init_cmds;
+		int i;
+
+		for (i = 0; cmds[i].len != 0; i++) {
+			const struct panel_init_cmd *cmd = &cmds[i];
+
+			err = mipi_dsi_generic_write(innolux->link, cmd->data,
+						     cmd->len);
+			if (err < 0) {
+				dev_err(panel->dev,
+					"failed to write command %d\n", i);
+				goto poweroff;
+			}
+
+			/*
+			 * Included by random guessing, because without this
+			 * (or at least, some delay), the panel sometimes
+			 * didn't appear to pick up the command sequence.
+			 */
+			err = mipi_dsi_dcs_nop(innolux->link);
+			if (err < 0) {
+				dev_err(panel->dev,
+					"failed to send DCS nop: %d\n", err);
+				goto poweroff;
+			}
+		}
+	}
 
 	err = mipi_dsi_dcs_exit_sleep_mode(innolux->link);
 	if (err < 0) {
@@ -213,6 +253,155 @@ static const struct panel_desc innolux_p079zca_panel_desc = {
 	.power_down_delay = 80, /* T8: 80ms - 1000ms */
 };
 
+static const char * const innolux_p097pfg_supply_names[] = {
+	"avdd",
+	"avee",
+};
+
+static const struct drm_display_mode innolux_p097pfg_mode = {
+	.clock = 229000,
+	.hdisplay = 1536,
+	.hsync_start = 1536 + 100,
+	.hsync_end = 1536 + 100 + 24,
+	.htotal = 1536 + 100 + 24 + 100,
+	.vdisplay = 2048,
+	.vsync_start = 2048 + 100,
+	.vsync_end = 2048 + 100 + 2,
+	.vtotal = 2048 + 100 + 2 + 18,
+	.vrefresh = 60,
+};
+
+/*
+ * Display manufacturer failed to provide init sequencing according to
+ * https://chromium-review.googlesource.com/c/chromiumos/third_party/coreboot/+/892065/
+ * so the init sequence stems from a register dump of a working panel.
+ */
+static const struct panel_init_cmd innolux_p097pfg_init_cmds[] = {
+	/* page 0 */
+	_INIT_CMD(0xF0, 0x55, 0xAA, 0x52, 0x08, 0x00),
+	_INIT_CMD(0xB1, 0xE8, 0x11),
+	_INIT_CMD(0xB2, 0x25, 0x02),
+	_INIT_CMD(0xB5, 0x08, 0x00),
+	_INIT_CMD(0xBC, 0x0F, 0x00),
+	_INIT_CMD(0xB8, 0x03, 0x06, 0x00, 0x00),
+	_INIT_CMD(0xBD, 0x01, 0x90, 0x14, 0x14),
+	_INIT_CMD(0x6F, 0x01),
+	_INIT_CMD(0xC0, 0x03),
+	_INIT_CMD(0x6F, 0x02),
+	_INIT_CMD(0xC1, 0x0D),
+	_INIT_CMD(0xD9, 0x01, 0x09, 0x70),
+	_INIT_CMD(0xC5, 0x12, 0x21, 0x00),
+	_INIT_CMD(0xBB, 0x93, 0x93),
+
+	/* page 1 */
+	_INIT_CMD(0xF0, 0x55, 0xAA, 0x52, 0x08, 0x01),
+	_INIT_CMD(0xB3, 0x3C, 0x3C),
+	_INIT_CMD(0xB4, 0x0F, 0x0F),
+	_INIT_CMD(0xB9, 0x45, 0x45),
+	_INIT_CMD(0xBA, 0x14, 0x14),
+	_INIT_CMD(0xCA, 0x02),
+	_INIT_CMD(0xCE, 0x04),
+	_INIT_CMD(0xC3, 0x9B, 0x9B),
+	_INIT_CMD(0xD8, 0xC0, 0x03),
+	_INIT_CMD(0xBC, 0x82, 0x01),
+	_INIT_CMD(0xBD, 0x9E, 0x01),
+
+	/* page 2 */
+	_INIT_CMD(0xF0, 0x55, 0xAA, 0x52, 0x08, 0x02),
+	_INIT_CMD(0xB0, 0x82),
+	_INIT_CMD(0xD1, 0x00, 0x00, 0x00, 0x3E, 0x00, 0x82, 0x00, 0xA5,
+		  0x00, 0xC1, 0x00, 0xEA, 0x01, 0x0D, 0x01, 0x40),
+	_INIT_CMD(0xD2, 0x01, 0x6A, 0x01, 0xA8, 0x01, 0xDC, 0x02, 0x29,
+		  0x02, 0x67, 0x02, 0x68, 0x02, 0xA8, 0x02, 0xF0),
+	_INIT_CMD(0xD3, 0x03, 0x19, 0x03, 0x49, 0x03, 0x67, 0x03, 0x8C,
+		  0x03, 0xA6, 0x03, 0xC7, 0x03, 0xDE, 0x03, 0xEC),
+	_INIT_CMD(0xD4, 0x03, 0xFF, 0x03, 0xFF),
+	_INIT_CMD(0xE0, 0x00, 0x00, 0x00, 0x86, 0x00, 0xC5, 0x00, 0xE5,
+		  0x00, 0xFF, 0x01, 0x26, 0x01, 0x45, 0x01, 0x75),
+	_INIT_CMD(0xE1, 0x01, 0x9C, 0x01, 0xD5, 0x02, 0x05, 0x02, 0x4D,
+		  0x02, 0x86, 0x02, 0x87, 0x02, 0xC3, 0x03, 0x03),
+	_INIT_CMD(0xE2, 0x03, 0x2A, 0x03, 0x56, 0x03, 0x72, 0x03, 0x94,
+		  0x03, 0xAC, 0x03, 0xCB, 0x03, 0xE0, 0x03, 0xED),
+	_INIT_CMD(0xE3, 0x03, 0xFF, 0x03, 0xFF),
+
+	/* page 3 */
+	_INIT_CMD(0xF0, 0x55, 0xAA, 0x52, 0x08, 0x03),
+	_INIT_CMD(0xB0, 0x00, 0x00, 0x00, 0x00),
+	_INIT_CMD(0xB1, 0x00, 0x00, 0x00, 0x00),
+	_INIT_CMD(0xB2, 0x00, 0x00, 0x06, 0x04, 0x01, 0x40, 0x85),
+	_INIT_CMD(0xB3, 0x10, 0x07, 0xFC, 0x04, 0x01, 0x40, 0x80),
+	_INIT_CMD(0xB6, 0xF0, 0x08, 0x00, 0x04, 0x00, 0x00, 0x00, 0x01,
+		  0x40, 0x80),
+	_INIT_CMD(0xBA, 0xC5, 0x07, 0x00, 0x04, 0x11, 0x25, 0x8C),
+	_INIT_CMD(0xBB, 0xC5, 0x07, 0x00, 0x03, 0x11, 0x25, 0x8C),
+	_INIT_CMD(0xC0, 0x00, 0x3C, 0x00, 0x00, 0x00, 0x80, 0x80),
+	_INIT_CMD(0xC1, 0x00, 0x3C, 0x00, 0x00, 0x00, 0x80, 0x80),
+	_INIT_CMD(0xC4, 0x00, 0x00),
+	_INIT_CMD(0xEF, 0x41),
+
+	/* page 4 */
+	_INIT_CMD(0xF0, 0x55, 0xAA, 0x52, 0x08, 0x04),
+	_INIT_CMD(0xEC, 0x4C),
+
+	/* page 5 */
+	_INIT_CMD(0xF0, 0x55, 0xAA, 0x52, 0x08, 0x05),
+	_INIT_CMD(0xB0, 0x13, 0x03, 0x03, 0x01),
+	_INIT_CMD(0xB1, 0x30, 0x00),
+	_INIT_CMD(0xB2, 0x02, 0x02, 0x00),
+	_INIT_CMD(0xB3, 0x82, 0x23, 0x82, 0x9D),
+	_INIT_CMD(0xB4, 0xC5, 0x75, 0x24, 0x57),
+	_INIT_CMD(0xB5, 0x00, 0xD4, 0x72, 0x11, 0x11, 0xAB, 0x0A),
+	_INIT_CMD(0xB6, 0x00, 0x00, 0xD5, 0x72, 0x24, 0x56),
+	_INIT_CMD(0xB7, 0x5C, 0xDC, 0x5C, 0x5C),
+	_INIT_CMD(0xB9, 0x0C, 0x00, 0x00, 0x01, 0x00),
+	_INIT_CMD(0xC0, 0x75, 0x11, 0x11, 0x54, 0x05),
+	_INIT_CMD(0xC6, 0x00, 0x00, 0x00, 0x00),
+	_INIT_CMD(0xD0, 0x00, 0x48, 0x08, 0x00, 0x00),
+	_INIT_CMD(0xD1, 0x00, 0x48, 0x09, 0x00, 0x00),
+
+	/* page 6 */
+	_INIT_CMD(0xF0, 0x55, 0xAA, 0x52, 0x08, 0x06),
+	_INIT_CMD(0xB0, 0x02, 0x32, 0x32, 0x08, 0x2F),
+	_INIT_CMD(0xB1, 0x2E, 0x15, 0x14, 0x13, 0x12),
+	_INIT_CMD(0xB2, 0x11, 0x10, 0x00, 0x3D, 0x3D),
+	_INIT_CMD(0xB3, 0x3D, 0x3D, 0x3D, 0x3D, 0x3D),
+	_INIT_CMD(0xB4, 0x3D, 0x32),
+	_INIT_CMD(0xB5, 0x03, 0x32, 0x32, 0x09, 0x2F),
+	_INIT_CMD(0xB6, 0x2E, 0x1B, 0x1A, 0x19, 0x18),
+	_INIT_CMD(0xB7, 0x17, 0x16, 0x01, 0x3D, 0x3D),
+	_INIT_CMD(0xB8, 0x3D, 0x3D, 0x3D, 0x3D, 0x3D),
+	_INIT_CMD(0xB9, 0x3D, 0x32),
+	_INIT_CMD(0xC0, 0x01, 0x32, 0x32, 0x09, 0x2F),
+	_INIT_CMD(0xC1, 0x2E, 0x1A, 0x1B, 0x16, 0x17),
+	_INIT_CMD(0xC2, 0x18, 0x19, 0x03, 0x3D, 0x3D),
+	_INIT_CMD(0xC3, 0x3D, 0x3D, 0x3D, 0x3D, 0x3D),
+	_INIT_CMD(0xC4, 0x3D, 0x32),
+	_INIT_CMD(0xC5, 0x00, 0x32, 0x32, 0x08, 0x2F),
+	_INIT_CMD(0xC6, 0x2E, 0x14, 0x15, 0x10, 0x11),
+	_INIT_CMD(0xC7, 0x12, 0x13, 0x02, 0x3D, 0x3D),
+	_INIT_CMD(0xC8, 0x3D, 0x3D, 0x3D, 0x3D, 0x3D),
+	_INIT_CMD(0xC9, 0x3D, 0x32),
+
+	{},
+};
+
+static const struct panel_desc innolux_p097pfg_panel_desc = {
+	.modes = &innolux_p097pfg_mode,
+	.bpc = 8,
+	.size = {
+		.width = 147,
+		.height = 196,
+	},
+	.flags = MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_VIDEO_SYNC_PULSE |
+		 MIPI_DSI_MODE_LPM,
+	.format = MIPI_DSI_FMT_RGB888,
+	.init_cmds = innolux_p097pfg_init_cmds,
+	.lanes = 4,
+	.supply_names = innolux_p097pfg_supply_names,
+	.num_supplies = ARRAY_SIZE(innolux_p097pfg_supply_names),
+	.sleep_mode_delay = 100, /* T15 */
+};
+
 static int innolux_panel_get_modes(struct drm_panel *panel)
 {
 	struct drm_display_mode *mode;
@@ -251,6 +440,9 @@ static const struct of_device_id innolux_of_match[] = {
 	{ .compatible = "innolux,p079zca",
 	  .data = &innolux_p079zca_panel_desc
 	},
+	{ .compatible = "innolux,p097pfg",
+	  .data = &innolux_p097pfg_panel_desc
+	},
 	{ }
 };
 MODULE_DEVICE_TABLE(of, innolux_of_match);
-- 
2.17.0

