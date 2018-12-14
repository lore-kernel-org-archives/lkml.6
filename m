Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72453C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 14:13:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33187206C2
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 14:13:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730099AbeLNONz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 09:13:55 -0500
Received: from mail.bootlin.com ([62.4.15.54]:57252 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729804AbeLNONz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 09:13:55 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 199D6208E3; Fri, 14 Dec 2018 15:13:53 +0100 (CET)
Received: from localhost.localdomain (aaubervilliers-681-1-89-7.w90-88.abo.wanadoo.fr [90.88.30.7])
        by mail.bootlin.com (Postfix) with ESMTPSA id C8A002074F;
        Fri, 14 Dec 2018 15:13:52 +0100 (CET)
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     Eric Anholt <eric@anholt.net>, David Airlie <airlied@linux.ie>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Eben Upton <eben@raspberrypi.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Subject: [PATCH] drm/vc4: Limit SAND tiling support to semiplanar YUV420 formats
Date:   Fri, 14 Dec 2018 15:12:18 +0100
Message-Id: <20181214141218.12671-1-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Despite what the HVS documentation indicates, the VC4 does not actually
support SAND tiling modes for any RGB format and only semiplanar YUV420
formats (NV12/NV21) can be used in these tiling modes.

The driver currently claims to support RGB formats for the associated
modifiers, so remove them from the supported list in the
format_mod_supported helper for RGB formats.

Remove further checks that are no longer necessary along the way, since
semi-planar YUV420 formats support every SAND tiling mode.

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
---
 drivers/gpu/drm/vc4/vc4_plane.c | 17 +----------------
 1 file changed, 1 insertion(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_plane.c b/drivers/gpu/drm/vc4/vc4_plane.c
index 75db62cbe468..a176e7d8af27 100644
--- a/drivers/gpu/drm/vc4/vc4_plane.c
+++ b/drivers/gpu/drm/vc4/vc4_plane.c
@@ -596,20 +596,7 @@ static int vc4_plane_mode_set(struct drm_plane *plane,
 	case DRM_FORMAT_MOD_BROADCOM_SAND256: {
 		uint32_t param = fourcc_mod_broadcom_param(fb->modifier);
 
-		/* Column-based NV12 or RGBA.
-		 */
-		if (fb->format->num_planes > 1) {
-			if (hvs_format != HVS_PIXEL_FORMAT_YCBCR_YUV420_2PLANE) {
-				DRM_DEBUG_KMS("SAND format only valid for NV12/21");
-				return -EINVAL;
-			}
-			hvs_format = HVS_PIXEL_FORMAT_H264;
-		} else {
-			if (base_format_mod == DRM_FORMAT_MOD_BROADCOM_SAND256) {
-				DRM_DEBUG_KMS("SAND256 format only valid for H.264");
-				return -EINVAL;
-			}
-		}
+		hvs_format = HVS_PIXEL_FORMAT_H264;
 
 		switch (base_format_mod) {
 		case DRM_FORMAT_MOD_BROADCOM_SAND64:
@@ -1050,8 +1037,6 @@ static bool vc4_format_mod_supported(struct drm_plane *plane,
 		switch (fourcc_mod_broadcom_mod(modifier)) {
 		case DRM_FORMAT_MOD_LINEAR:
 		case DRM_FORMAT_MOD_BROADCOM_VC4_T_TILED:
-		case DRM_FORMAT_MOD_BROADCOM_SAND64:
-		case DRM_FORMAT_MOD_BROADCOM_SAND128:
 			return true;
 		default:
 			return false;
-- 
2.19.2

