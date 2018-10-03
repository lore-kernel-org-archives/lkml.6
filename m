Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E393C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 14:25:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FD132098A
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 14:25:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=micronovasrl.com header.i=@micronovasrl.com header.b="EKfdmVAz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FD132098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=micronovasrl.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727120AbeJCVNw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 17:13:52 -0400
Received: from mail.micronovasrl.com ([212.103.203.10]:37084 "EHLO
        mail.micronovasrl.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726543AbeJCVNw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 17:13:52 -0400
Received: from mail.micronovasrl.com (mail.micronovasrl.com [127.0.0.1])
        by mail.micronovasrl.com (Postfix) with ESMTP id 3874DB013EE
        for <linux-kernel@vger.kernel.org>; Wed,  3 Oct 2018 16:25:14 +0200 (CEST)
Authentication-Results: mail.micronovasrl.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=micronovasrl.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=micronovasrl.com;
         h=references:in-reply-to:x-mailer:message-id:date:date:subject
        :subject:to:from:from; s=dkim; t=1538576712; x=1539440713; bh=Lj
        KnGJP4TdCoWqibBRvqHzphJU2fsqMvq+PH3cAGiTE=; b=EKfdmVAzJAiLFzcAnR
        5RNSXkc5jhJHf6exjEcpuQm+K7uIycLWppXu9NNKlZp4nIEv5cMXGRBqNc6Dq0/1
        TzMKUJTpBLcQwJg2daIm3drLHGLv69+JFljSh81l85T4sz0K0pDr7QT5I1sWkf3G
        wxO1S9HOKofeeYISlWo02uwec=
X-Virus-Scanned: Debian amavisd-new at mail.micronovasrl.com
Received: from mail.micronovasrl.com ([127.0.0.1])
        by mail.micronovasrl.com (mail.micronovasrl.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id soziho1xZPgT for <linux-kernel@vger.kernel.org>;
        Wed,  3 Oct 2018 16:25:12 +0200 (CEST)
Received: from localhost.localdomain (host128-8-dynamic.21-79-r.retail.telecomitalia.it [79.21.8.128])
        by mail.micronovasrl.com (Postfix) with ESMTPSA id 680BDB00245;
        Wed,  3 Oct 2018 16:25:11 +0200 (CEST)
From:   Giulio Benetti <giulio.benetti@micronovasrl.com>
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     David Airlie <airlied@linux.ie>, Chen-Yu Tsai <wens@csie.org>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Giulio Benetti <giulio.benetti@micronovasrl.com>
Subject: [PATCH v2 1/2] drm/sun4i: tcon: fix check of tcon->panel null pointer
Date:   Wed,  3 Oct 2018 16:24:57 +0200
Message-Id: <20181003142458.33120-1-giulio.benetti@micronovasrl.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <9a545739-eed5-7af1-3b75-108bdd3427a2@micronovasrl.com>
References: <9a545739-eed5-7af1-3b75-108bdd3427a2@micronovasrl.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

At the moment, the check of tcon->panel to be valid is wrong. IS_ERR()
has been used, but that macro doesn't check if tcon->panel pointer is
null or not, but check if tcon->panel is between -1 and -4095(MAX_ERRNO).

Remove IS_ERR() from tcon->panel checking and let "if (tcon->panel)" as
condition to check if it's a pointer not null.

Signed-off-by: Giulio Benetti <giulio.benetti@micronovasrl.com>
---
Changes V1->V2:
* correct same bug for all same occurences in drm/sun4i folder

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

