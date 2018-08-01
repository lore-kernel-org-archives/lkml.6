Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9805C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 17:28:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69BBD2083D
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 17:28:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69BBD2083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407484AbeHATP3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 15:15:29 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:52222 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404699AbeHATP3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 15:15:29 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id A3040D2F;
        Wed,  1 Aug 2018 17:28:44 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 084/144] drm/radeon: fix mode_valids return type
Date:   Wed,  1 Aug 2018 18:51:51 +0200
Message-Id: <20180801164955.755757242@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180801164949.023217860@linuxfoundation.org>
References: <20180801164949.023217860@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

[ Upstream commit 7a47f20eb1fb8fa8d7a8fe3a4fd8c721f04c2174 ]

The method struct drm_connector_helper_funcs::mode_valid is defined
as returning an 'enum drm_mode_status' but the driver implementation
for this method uses an 'int' for it.

Fix this by using 'enum drm_mode_status' in the driver too.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/radeon/radeon_connectors.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

--- a/drivers/gpu/drm/radeon/radeon_connectors.c
+++ b/drivers/gpu/drm/radeon/radeon_connectors.c
@@ -850,7 +850,7 @@ static int radeon_lvds_get_modes(struct
 	return ret;
 }
 
-static int radeon_lvds_mode_valid(struct drm_connector *connector,
+static enum drm_mode_status radeon_lvds_mode_valid(struct drm_connector *connector,
 				  struct drm_display_mode *mode)
 {
 	struct drm_encoder *encoder = radeon_best_single_encoder(connector);
@@ -1010,7 +1010,7 @@ static int radeon_vga_get_modes(struct d
 	return ret;
 }
 
-static int radeon_vga_mode_valid(struct drm_connector *connector,
+static enum drm_mode_status radeon_vga_mode_valid(struct drm_connector *connector,
 				  struct drm_display_mode *mode)
 {
 	struct drm_device *dev = connector->dev;
@@ -1154,7 +1154,7 @@ static int radeon_tv_get_modes(struct dr
 	return 1;
 }
 
-static int radeon_tv_mode_valid(struct drm_connector *connector,
+static enum drm_mode_status radeon_tv_mode_valid(struct drm_connector *connector,
 				struct drm_display_mode *mode)
 {
 	if ((mode->hdisplay > 1024) || (mode->vdisplay > 768))
@@ -1496,7 +1496,7 @@ static void radeon_dvi_force(struct drm_
 		radeon_connector->use_digital = true;
 }
 
-static int radeon_dvi_mode_valid(struct drm_connector *connector,
+static enum drm_mode_status radeon_dvi_mode_valid(struct drm_connector *connector,
 				  struct drm_display_mode *mode)
 {
 	struct drm_device *dev = connector->dev;
@@ -1798,7 +1798,7 @@ out:
 	return ret;
 }
 
-static int radeon_dp_mode_valid(struct drm_connector *connector,
+static enum drm_mode_status radeon_dp_mode_valid(struct drm_connector *connector,
 				  struct drm_display_mode *mode)
 {
 	struct drm_device *dev = connector->dev;


