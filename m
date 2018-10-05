Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D089C00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 21:59:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFAEF21473
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 21:59:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=micronovasrl.com header.i=@micronovasrl.com header.b="W13CNmK1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFAEF21473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=micronovasrl.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728341AbeJFFAh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Oct 2018 01:00:37 -0400
Received: from mail.micronovasrl.com ([212.103.203.10]:45174 "EHLO
        mail.micronovasrl.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725772AbeJFFAg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Oct 2018 01:00:36 -0400
Received: from mail.micronovasrl.com (mail.micronovasrl.com [127.0.0.1])
        by mail.micronovasrl.com (Postfix) with ESMTP id C8D0BB0081B
        for <linux-kernel@vger.kernel.org>; Fri,  5 Oct 2018 23:59:55 +0200 (CEST)
Authentication-Results: mail.micronovasrl.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=micronovasrl.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=micronovasrl.com;
         h=references:in-reply-to:x-mailer:message-id:date:date:subject
        :subject:to:from:from; s=dkim; t=1538776795; x=1539640796; bh=6I
        LxoHv50N8w16qw34Fi8S7zwu/gJ947bOekxAMNcUc=; b=W13CNmK13Lrc0OU+4M
        Rr4snk15NJ7/P/QnRRYTTWLh6GaqD7y7LncrvX5ScA2XOQXjn5IGWIf+egs4qoFZ
        UV3ExKyK6tMju8osUyKWcIoka3ZDOSuwN/2ikv18rN6Oj+65mdWBXmzqpbcSwgF/
        BTKWxYojp9TuwKPOQlO6oL1OE=
X-Virus-Scanned: Debian amavisd-new at mail.micronovasrl.com
Received: from mail.micronovasrl.com ([127.0.0.1])
        by mail.micronovasrl.com (mail.micronovasrl.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id alGUDreIOXoC for <linux-kernel@vger.kernel.org>;
        Fri,  5 Oct 2018 23:59:55 +0200 (CEST)
Received: from ubuntu.localdomain (unknown [192.168.123.60])
        by mail.micronovasrl.com (Postfix) with ESMTPSA id BB698B000F6;
        Fri,  5 Oct 2018 23:59:53 +0200 (CEST)
From:   Giulio Benetti <giulio.benetti@micronovasrl.com>
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     David Airlie <airlied@linux.ie>, Chen-Yu Tsai <wens@csie.org>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Giulio Benetti <giulio.benetti@micronovasrl.com>
Subject: [PATCH v3 1/2] drm/sun4i: tcon: fix check of tcon->panel null pointer
Date:   Fri,  5 Oct 2018 23:59:50 +0200
Message-Id: <20181005215951.99003-1-giulio.benetti@micronovasrl.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181004195605.txvbkshvxklyzxyb@flea>
References: <20181004195605.txvbkshvxklyzxyb@flea>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since tcon->panel is a pointer returned by of_drm_find_panel() need to
check if it is not NULL, hence a valid pointer.
IS_ERR() instead checks return error values, not NULL pointers.

Substitute "if (!IS_ERR(tcon->panel))" with "if (tcon->panel)".

Signed-off-by: Giulio Benetti <giulio.benetti@micronovasrl.com>
---
Changes V1->V2:
* correct same bug for all same occurences in drm/sun4i folder

Changes V2->V3:
* Improve commit log

 drivers/gpu/drm/sun4i/sun4i_lvds.c | 4 ++--
 drivers/gpu/drm/sun4i/sun4i_rgb.c  | 4 ++--
 drivers/gpu/drm/sun4i/sun4i_tcon.c | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_lvds.c b/drivers/gpu/drm/sun4i/sun4i_lvds.c
index af7dcb6da351..e7eb0d1e17be 100644
--- a/drivers/gpu/drm/sun4i/sun4i_lvds.c
+++ b/drivers/gpu/drm/sun4i/sun4i_lvds.c
@@ -75,7 +75,7 @@ static void sun4i_lvds_encoder_enable(struct drm_encoder *encoder)
 
 	DRM_DEBUG_DRIVER("Enabling LVDS output\n");
 
-	if (!IS_ERR(tcon->panel)) {
+	if (tcon->panel) {
 		drm_panel_prepare(tcon->panel);
 		drm_panel_enable(tcon->panel);
 	}
@@ -88,7 +88,7 @@ static void sun4i_lvds_encoder_disable(struct drm_encoder *encoder)
 
 	DRM_DEBUG_DRIVER("Disabling LVDS output\n");
 
-	if (!IS_ERR(tcon->panel)) {
+	if (tcon->panel) {
 		drm_panel_disable(tcon->panel);
 		drm_panel_unprepare(tcon->panel);
 	}
diff --git a/drivers/gpu/drm/sun4i/sun4i_rgb.c b/drivers/gpu/drm/sun4i/sun4i_rgb.c
index bf068da6b12e..f4a22689eb54 100644
--- a/drivers/gpu/drm/sun4i/sun4i_rgb.c
+++ b/drivers/gpu/drm/sun4i/sun4i_rgb.c
@@ -135,7 +135,7 @@ static void sun4i_rgb_encoder_enable(struct drm_encoder *encoder)
 
 	DRM_DEBUG_DRIVER("Enabling RGB output\n");
 
-	if (!IS_ERR(tcon->panel)) {
+	if (tcon->panel) {
 		drm_panel_prepare(tcon->panel);
 		drm_panel_enable(tcon->panel);
 	}
@@ -148,7 +148,7 @@ static void sun4i_rgb_encoder_disable(struct drm_encoder *encoder)
 
 	DRM_DEBUG_DRIVER("Disabling RGB output\n");
 
-	if (!IS_ERR(tcon->panel)) {
+	if (tcon->panel) {
 		drm_panel_disable(tcon->panel);
 		drm_panel_unprepare(tcon->panel);
 	}
diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.c b/drivers/gpu/drm/sun4i/sun4i_tcon.c
index c78cd35a1294..e4b3bd0307ef 100644
--- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
+++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
@@ -555,7 +555,7 @@ static void sun4i_tcon0_mode_set_rgb(struct sun4i_tcon *tcon,
 	 * Following code is a way to avoid quirks all around TCON
 	 * and DOTCLOCK drivers.
 	 */
-	if (!IS_ERR(tcon->panel)) {
+	if (tcon->panel) {
 		struct drm_panel *panel = tcon->panel;
 		struct drm_connector *connector = panel->connector;
 		struct drm_display_info display_info = connector->display_info;
-- 
2.17.1

