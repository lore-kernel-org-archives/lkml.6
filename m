Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23BABC43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 12:05:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D71322589C
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 12:05:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D71322589C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=siol.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933860AbeFYMFv (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 08:05:51 -0400
Received: from mailoutvs55.siol.net ([185.57.226.246]:48269 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S933756AbeFYMFp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 08:05:45 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTP id D8B4D5208D5;
        Mon, 25 Jun 2018 14:05:42 +0200 (CEST)
X-Virus-Scanned: amavisd-new at psrvmta10.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta10.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id XKN4o_X0A4Jo; Mon, 25 Jun 2018 14:05:42 +0200 (CEST)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTPS id 63BEF5206EB;
        Mon, 25 Jun 2018 14:05:42 +0200 (CEST)
Received: from localhost.localdomain (unknown [194.152.15.144])
        (Authenticated sender: 031275009)
        by mail.siol.net (Postfix) with ESMTPSA id A0BC15208D5;
        Mon, 25 Jun 2018 14:05:39 +0200 (CEST)
From:   Jernej Skrabec <jernej.skrabec@siol.net>
To:     maxime.ripard@bootlin.com, wens@csie.org, robh+dt@kernel.org
Cc:     airlied@linux.ie, gustavo@padovan.org,
        maarten.lankhorst@linux.intel.com, seanpaul@chromium.org,
        mark.rutland@arm.com, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: [PATCH v3 21/24] drm: of: Export drm_crtc_port_mask()
Date:   Mon, 25 Jun 2018 14:03:01 +0200
Message-Id: <20180625120304.7543-22-jernej.skrabec@siol.net>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180625120304.7543-1-jernej.skrabec@siol.net>
References: <20180625120304.7543-1-jernej.skrabec@siol.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function is useful when drm_of_find_possible_crtcs() can't be used and
custom parsing is needed. This can happen for example when there is a
node with multiple muxes between crtc and encoder.

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 drivers/gpu/drm/drm_of.c | 5 +++--
 include/drm/drm_of.h     | 8 ++++++++
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_of.c b/drivers/gpu/drm/drm_of.c
index 1fe122461298..50e738857258 100644
--- a/drivers/gpu/drm/drm_of.c
+++ b/drivers/gpu/drm/drm_of.c
@@ -22,8 +22,8 @@ static void drm_release_of(struct device *dev, void *data)
  * Given a port OF node, return the possible mask of the corresponding
  * CRTC within a device's list of CRTCs.  Returns zero if not found.
  */
-static uint32_t drm_crtc_port_mask(struct drm_device *dev,
-				   struct device_node *port)
+uint32_t drm_crtc_port_mask(struct drm_device *dev,
+			    struct device_node *port)
 {
 	unsigned int index = 0;
 	struct drm_crtc *tmp;
@@ -37,6 +37,7 @@ static uint32_t drm_crtc_port_mask(struct drm_device *dev,
 
 	return 0;
 }
+EXPORT_SYMBOL(drm_crtc_port_mask);
 
 /**
  * drm_of_find_possible_crtcs - find the possible CRTCs for an encoder port
diff --git a/include/drm/drm_of.h b/include/drm/drm_of.h
index b93c239afb60..a61fd77e46ba 100644
--- a/include/drm/drm_of.h
+++ b/include/drm/drm_of.h
@@ -17,6 +17,8 @@ struct drm_bridge;
 struct device_node;
 
 #ifdef CONFIG_OF
+uint32_t drm_crtc_port_mask(struct drm_device *dev,
+			    struct device_node *port);
 uint32_t drm_of_find_possible_crtcs(struct drm_device *dev,
 				    struct device_node *port);
 void drm_of_component_match_add(struct device *master,
@@ -34,6 +36,12 @@ int drm_of_find_panel_or_bridge(const struct device_node *np,
 				struct drm_panel **panel,
 				struct drm_bridge **bridge);
 #else
+static inline uint32_t drm_crtc_port_mask(struct drm_device *dev,
+					  struct device_node *port)
+{
+	return 0;
+}
+
 static inline uint32_t drm_of_find_possible_crtcs(struct drm_device *dev,
 						  struct device_node *port)
 {
-- 
2.18.0

