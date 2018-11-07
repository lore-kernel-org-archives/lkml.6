Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80314C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 18:20:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FC3920862
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 18:20:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FC3920862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=paulk.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728351AbeKHDvn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 22:51:43 -0500
Received: from leonov.paulk.fr ([185.233.101.22]:48984 "EHLO leonov.paulk.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726726AbeKHDvm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 22:51:42 -0500
Received: from gagarine.paulk.fr (gagarine [192.168.1.127])
        by leonov.paulk.fr (Postfix) with ESMTPS id CE8BFBFE24;
        Wed,  7 Nov 2018 19:20:07 +0100 (CET)
Received: by gagarine.paulk.fr (Postfix, from userid 114)
        id 52DA8C108E; Wed,  7 Nov 2018 19:20:06 +0100 (CET)
Received: from localhost.localdomain (collins [192.168.1.129])
        by gagarine.paulk.fr (Postfix) with ESMTP id 55BF2C106E;
        Wed,  7 Nov 2018 19:17:58 +0100 (CET)
From:   Paul Kocialkowski <contact@paulk.fr>
To:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, linux-sunxi@googlegroups.com,
        Mark Van den Borre <mark@fosdem.org>,
        Gerry Demaret <gerry@fosdem.org>,
        Luc Verhaegen <libv@skynet.be>,
        Paul Kocialkowski <contact@paulk.fr>
Subject: [PATCH v3 6/8] drm/panel: simple: Add support for the LeMaker BL035-RGB-002 3.5" LCD
Date:   Wed,  7 Nov 2018 19:18:41 +0100
Message-Id: <20181107181843.27628-7-contact@paulk.fr>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181107181843.27628-1-contact@paulk.fr>
References: <20181107181843.27628-1-contact@paulk.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds support for the 3.5" LCD panel from LeMaker, sold for use with
BananaPi boards. It comes with a 24-bit RGB888 parallel interface and
requires an active-low DE signal

Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
---
 drivers/gpu/drm/panel/panel-simple.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index 07d576d99475..a259874f6039 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -1562,6 +1562,30 @@ static const struct panel_desc kyo_tcg121xglp = {
 	.bus_format = MEDIA_BUS_FMT_RGB888_1X7X4_SPWG,
 };
 
+static const struct drm_display_mode lemaker_bl035_rgb_002_mode = {
+	.clock = 7000,
+	.hdisplay = 320,
+	.hsync_start = 320 + 20,
+	.hsync_end = 320 + 20 + 30,
+	.htotal = 320 + 20 + 30 + 38,
+	.vdisplay = 240,
+	.vsync_start = 240 + 4,
+	.vsync_end = 240 + 4 + 3,
+	.vtotal = 240 + 4 + 3 + 15,
+	.vrefresh = 60,
+};
+
+static const struct panel_desc lemaker_bl035_rgb_002 = {
+	.modes = &lemaker_bl035_rgb_002_mode,
+	.num_modes = 1,
+	.size = {
+		.width = 70,
+		.height = 52,
+	},
+	.bus_format = MEDIA_BUS_FMT_RGB888_1X24,
+	.bus_flags = DRM_BUS_FLAG_DE_LOW,
+};
+
 static const struct drm_display_mode lg_lb070wv8_mode = {
 	.clock = 33246,
 	.hdisplay = 800,
@@ -2599,6 +2623,9 @@ static const struct of_device_id platform_of_match[] = {
 	}, {
 		.compatible = "kyo,tcg121xglp",
 		.data = &kyo_tcg121xglp,
+	}, {
+		.compatible = "lemaker,bl035-rgb-002",
+		.data = &lemaker_bl035_rgb_002,
 	}, {
 		.compatible = "lg,lb070wv8",
 		.data = &lg_lb070wv8,
-- 
2.19.1

