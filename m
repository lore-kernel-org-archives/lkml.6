Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73E84C43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 09:00:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DAF521871
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 09:00:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727135AbfADJAm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 04:00:42 -0500
Received: from mail.bootlin.com ([62.4.15.54]:45999 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726800AbfADJAm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 04:00:42 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id E476D2075E; Fri,  4 Jan 2019 10:00:39 +0100 (CET)
Received: from localhost.localdomain (aaubervilliers-681-1-29-148.w90-88.abo.wanadoo.fr [90.88.149.148])
        by mail.bootlin.com (Postfix) with ESMTPSA id A71A720717;
        Fri,  4 Jan 2019 10:00:39 +0100 (CET)
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Eric Anholt <eric@anholt.net>, Sean Paul <sean@poorly.run>,
        David Airlie <airlied@linux.ie>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Subject: [PATCH] drm: Auto-set allow_fb_modifiers when given modifiers at plane init
Date:   Fri,  4 Jan 2019 09:56:10 +0100
Message-Id: <20190104085610.5829-1-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When drivers pass non-empty lists of modifiers for initializing their
planes, we can infer that they allow framebuffer modifiers and set the
driver's allow_fb_modifiers mode config element.

In case the allow_fb_modifiers element was not set (some drivers tend
to set them after registering planes), the modifiers will still be
registered but won't be available to userspace unless the flag is set
later. However in that case, the IN_FORMATS blob won't be created.

In order to avoid this case and generally reduce the trouble associated
with the flag, always set allow_fb_modifiers when a non-empty list of
format modifiers is passed at plane init.

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
---
 drivers/gpu/drm/drm_plane.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/drm_plane.c b/drivers/gpu/drm/drm_plane.c
index 5f650d8fc66b..4cfb56893b7f 100644
--- a/drivers/gpu/drm/drm_plane.c
+++ b/drivers/gpu/drm/drm_plane.c
@@ -220,6 +220,9 @@ int drm_universal_plane_init(struct drm_device *dev, struct drm_plane *plane,
 			format_modifier_count++;
 	}
 
+	if (format_modifier_count)
+		config->allow_fb_modifiers = true;
+
 	plane->modifier_count = format_modifier_count;
 	plane->modifiers = kmalloc_array(format_modifier_count,
 					 sizeof(format_modifiers[0]),
-- 
2.20.1

