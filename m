Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49B85C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 16:26:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1452320834
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 16:26:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1452320834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anholt.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727750AbeJZBAH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 21:00:07 -0400
Received: from anholt.net ([50.246.234.109]:33146 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727411AbeJZBAH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 21:00:07 -0400
Received: from localhost (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id 8D60510A12E8;
        Thu, 25 Oct 2018 09:26:37 -0700 (PDT)
X-Virus-Scanned: Debian amavisd-new at anholt.net
Received: from anholt.net ([127.0.0.1])
        by localhost (kingsolver.anholt.net [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id GCgBB5lDSKhn; Thu, 25 Oct 2018 09:26:36 -0700 (PDT)
Received: from eliezer.anholt.net (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id 5BD3310A0F99;
        Thu, 25 Oct 2018 09:26:36 -0700 (PDT)
Received: by eliezer.anholt.net (Postfix, from userid 1000)
        id E3EA82FE1BF0; Thu, 25 Oct 2018 09:26:35 -0700 (PDT)
From:   Eric Anholt <eric@anholt.net>
To:     dri-devel@lists.freedesktop.org,
        =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>
Cc:     linux-kernel@vger.kernel.org, Eric Anholt <eric@anholt.net>
Subject: [PATCH] drm/tinydrm: Advertise that we can do only DRM_FORMAT_MOD_LINEAR.
Date:   Thu, 25 Oct 2018 09:26:35 -0700
Message-Id: <20181025162635.6689-1-eric@anholt.net>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Without this, the xserver relies on what the 3D driver exposes and
assumes that the display can handle it, and then the DRM driver
happily tries to scan out a tiled format.

Signed-off-by: Eric Anholt <eric@anholt.net>
---
 drivers/gpu/drm/drm_simple_kms_helper.c     | 8 ++++++++
 drivers/gpu/drm/tinydrm/core/tinydrm-core.c | 1 +
 drivers/gpu/drm/tinydrm/core/tinydrm-pipe.c | 6 +++++-
 3 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_simple_kms_helper.c b/drivers/gpu/drm/drm_simple_kms_helper.c
index 51fa978f0d23..917812448d1b 100644
--- a/drivers/gpu/drm/drm_simple_kms_helper.c
+++ b/drivers/gpu/drm/drm_simple_kms_helper.c
@@ -190,6 +190,13 @@ static void drm_simple_kms_plane_cleanup_fb(struct drm_plane *plane,
 	pipe->funcs->cleanup_fb(pipe, state);
 }
 
+static bool drm_simple_kms_format_mod_supported(struct drm_plane *plane,
+						uint32_t format,
+						uint64_t modifier)
+{
+	return modifier == DRM_FORMAT_MOD_LINEAR;
+}
+
 static const struct drm_plane_helper_funcs drm_simple_kms_plane_helper_funcs = {
 	.prepare_fb = drm_simple_kms_plane_prepare_fb,
 	.cleanup_fb = drm_simple_kms_plane_cleanup_fb,
@@ -204,6 +211,7 @@ static const struct drm_plane_funcs drm_simple_kms_plane_funcs = {
 	.reset			= drm_atomic_helper_plane_reset,
 	.atomic_duplicate_state	= drm_atomic_helper_plane_duplicate_state,
 	.atomic_destroy_state	= drm_atomic_helper_plane_destroy_state,
+	.format_mod_supported   = drm_simple_kms_format_mod_supported,
 };
 
 /**
diff --git a/drivers/gpu/drm/tinydrm/core/tinydrm-core.c b/drivers/gpu/drm/tinydrm/core/tinydrm-core.c
index 255341ee4eb9..9af51d982a33 100644
--- a/drivers/gpu/drm/tinydrm/core/tinydrm-core.c
+++ b/drivers/gpu/drm/tinydrm/core/tinydrm-core.c
@@ -146,6 +146,7 @@ static int tinydrm_init(struct device *parent, struct tinydrm_device *tdev,
 	drm->dev_private = tdev;
 	drm_mode_config_init(drm);
 	drm->mode_config.funcs = &tinydrm_mode_config_funcs;
+	drm->mode_config.allow_fb_modifiers = true;
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/tinydrm/core/tinydrm-pipe.c b/drivers/gpu/drm/tinydrm/core/tinydrm-pipe.c
index 7e8e24d0b7a7..eacfc0ec8ff1 100644
--- a/drivers/gpu/drm/tinydrm/core/tinydrm-pipe.c
+++ b/drivers/gpu/drm/tinydrm/core/tinydrm-pipe.c
@@ -184,6 +184,10 @@ tinydrm_display_pipe_init(struct tinydrm_device *tdev,
 	struct drm_display_mode mode_copy;
 	struct drm_connector *connector;
 	int ret;
+	static const uint64_t modifiers[] = {
+		DRM_FORMAT_MOD_LINEAR,
+		DRM_FORMAT_MOD_INVALID
+	};
 
 	drm_mode_copy(&mode_copy, mode);
 	ret = tinydrm_rotate_mode(&mode_copy, rotation);
@@ -202,6 +206,6 @@ tinydrm_display_pipe_init(struct tinydrm_device *tdev,
 		return PTR_ERR(connector);
 
 	return drm_simple_display_pipe_init(drm, &tdev->pipe, funcs, formats,
-					    format_count, NULL, connector);
+					    format_count, modifiers, connector);
 }
 EXPORT_SYMBOL(tinydrm_display_pipe_init);
-- 
2.19.1

