Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 53817C5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 20:02:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 136A02089C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 20:02:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 136A02089C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=siol.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934628AbeFLUCz (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 16:02:55 -0400
Received: from mailoutvs53.siol.net ([185.57.226.244]:38861 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932927AbeFLUCw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 16:02:52 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Zimbra) with ESMTP id E271C521F5C;
        Tue, 12 Jun 2018 22:02:49 +0200 (CEST)
X-Virus-Scanned: amavisd-new at psrvmta12.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta12.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id ETCzqjYLZwqD; Tue, 12 Jun 2018 22:02:49 +0200 (CEST)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Zimbra) with ESMTPS id 513F1521279;
        Tue, 12 Jun 2018 22:02:49 +0200 (CEST)
Received: from localhost.localdomain (unknown [194.152.15.144])
        (Authenticated sender: 031275009)
        by mail.siol.net (Zimbra) with ESMTPSA id C79D6521F5C;
        Tue, 12 Jun 2018 22:02:46 +0200 (CEST)
From:   Jernej Skrabec <jernej.skrabec@siol.net>
To:     maxime.ripard@bootlin.com, wens@csie.org, robh+dt@kernel.org
Cc:     airlied@linux.ie, gustavo@padovan.org,
        maarten.lankhorst@linux.intel.com, seanpaul@chromium.org,
        mark.rutland@arm.com, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: [PATCH v2 24/27] drm: of: Export drm_crtc_port_mask()
Date:   Tue, 12 Jun 2018 22:00:33 +0200
Message-Id: <20180612200036.21483-25-jernej.skrabec@siol.net>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180612200036.21483-1-jernej.skrabec@siol.net>
References: <20180612200036.21483-1-jernej.skrabec@siol.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function is useful when drm_of_find_possible_crtcs() can't be used and
custom parsing is needed. This can happen for example when there is a
node with multiple muxes between crtc and encoder.

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 drivers/gpu/drm/drm_of.c | 4 ++--
 include/drm/drm_of.h     | 8 ++++++++
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_of.c b/drivers/gpu/drm/drm_of.c
index 1fe122461298..2e9cea3287b2 100644
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
2.17.1

