Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5684BC6786F
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 20:02:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2618C20657
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 20:02:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2618C20657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=paulk.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727885AbeKBFG5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 01:06:57 -0400
Received: from leonov.paulk.fr ([185.233.101.22]:46024 "EHLO leonov.paulk.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726594AbeKBFG4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 01:06:56 -0400
Received: from gagarine.paulk.fr (gagarine [192.168.1.127])
        by leonov.paulk.fr (Postfix) with ESMTPS id 65308BFA47;
        Thu,  1 Nov 2018 21:02:30 +0100 (CET)
Received: by gagarine.paulk.fr (Postfix, from userid 114)
        id DBFCCC107E; Thu,  1 Nov 2018 21:02:29 +0100 (CET)
Received: from localhost.localdomain (collins [192.168.1.129])
        by gagarine.paulk.fr (Postfix) with ESMTP id E7FDAC1043;
        Thu,  1 Nov 2018 21:00:34 +0100 (CET)
From:   Paul Kocialkowski <contact@paulk.fr>
To:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, linux-sunxi@googlegroups.com,
        Paul Kocialkowski <contact@paulk.fr>
Subject: [PATCH v2 5/7] drm/panel: simple: Add support for the LeMaker BL035-RGB-002 3.5" LCD
Date:   Thu,  1 Nov 2018 21:00:43 +0100
Message-Id: <20181101200045.6078-6-contact@paulk.fr>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181101200045.6078-1-contact@paulk.fr>
References: <20181101200045.6078-1-contact@paulk.fr>
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
index 90296090340e..8e147cfa7b88 100644
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
@@ -2569,6 +2593,9 @@ static const struct of_device_id platform_of_match[] = {
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

