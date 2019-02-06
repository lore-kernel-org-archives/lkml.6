Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81347C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 23:25:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38A58218B0
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 23:25:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbfBFXZx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 18:25:53 -0500
Received: from anholt.net ([50.246.234.109]:52322 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726188AbfBFXZx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 18:25:53 -0500
Received: from localhost (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id 7B57010A2BF3;
        Wed,  6 Feb 2019 15:25:52 -0800 (PST)
X-Virus-Scanned: Debian amavisd-new at anholt.net
Received: from anholt.net ([127.0.0.1])
        by localhost (kingsolver.anholt.net [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id T8Tc3bRO-B-S; Wed,  6 Feb 2019 15:25:51 -0800 (PST)
Received: from eliezer.anholt.net (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id 4921310A282F;
        Wed,  6 Feb 2019 15:25:51 -0800 (PST)
Received: by eliezer.anholt.net (Postfix, from userid 1000)
        id D6F482FE4648; Wed,  6 Feb 2019 15:25:50 -0800 (PST)
From:   Eric Anholt <eric@anholt.net>
To:     dri-devel@lists.freedesktop.org
Cc:     linux-kernel@vger.kernel.org, Eric Anholt <eric@anholt.net>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>
Subject: [PATCH RESEND] drm/vc4: Make sure to emit a tile coordinates between two MSAA loads.
Date:   Wed,  6 Feb 2019 15:25:50 -0800
Message-Id: <20190206232550.12012-1-eric@anholt.net>
X-Mailer: git-send-email 2.20.0.rc1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The HW only executes a load once the tile coordinates packet happens,
and only tracks one at a time, so by emitting our two MSAA loads back
to back we would end up with an undefined color or Z buffer.

Fixes dEQP-EGL.functional.render.multi_context.gles2.rgb888_window

Signed-off-by: Eric Anholt <eric@anholt.net>
Cc: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc: Maxime Ripard <maxime.ripard@bootlin.com>
---
 drivers/gpu/drm/vc4/vc4_render_cl.c | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_render_cl.c b/drivers/gpu/drm/vc4/vc4_render_cl.c
index 273984f71ae2..3c918eeaf56e 100644
--- a/drivers/gpu/drm/vc4/vc4_render_cl.c
+++ b/drivers/gpu/drm/vc4/vc4_render_cl.c
@@ -148,6 +148,12 @@ static void emit_tile(struct vc4_exec_info *exec,
 	}
 
 	if (setup->zs_read) {
+		if (setup->color_read) {
+			/* Exec previous load. */
+			vc4_tile_coordinates(setup, x, y);
+			vc4_store_before_load(setup);
+		}
+
 		if (args->zs_read.flags &
 		    VC4_SUBMIT_RCL_SURFACE_READ_IS_FULL_RES) {
 			rcl_u8(setup, VC4_PACKET_LOAD_FULL_RES_TILE_BUFFER);
@@ -156,12 +162,6 @@ static void emit_tile(struct vc4_exec_info *exec,
 						    &args->zs_read, x, y) |
 				VC4_LOADSTORE_FULL_RES_DISABLE_COLOR);
 		} else {
-			if (setup->color_read) {
-				/* Exec previous load. */
-				vc4_tile_coordinates(setup, x, y);
-				vc4_store_before_load(setup);
-			}
-
 			rcl_u8(setup, VC4_PACKET_LOAD_TILE_BUFFER_GENERAL);
 			rcl_u16(setup, args->zs_read.bits);
 			rcl_u32(setup, setup->zs_read->paddr +
@@ -291,16 +291,15 @@ static int vc4_create_rcl_bo(struct drm_device *dev, struct vc4_exec_info *exec,
 		}
 	}
 	if (setup->zs_read) {
+		if (setup->color_read) {
+			loop_body_size += VC4_PACKET_TILE_COORDINATES_SIZE;
+			loop_body_size += VC4_PACKET_STORE_TILE_BUFFER_GENERAL_SIZE;
+		}
+
 		if (args->zs_read.flags &
 		    VC4_SUBMIT_RCL_SURFACE_READ_IS_FULL_RES) {
 			loop_body_size += VC4_PACKET_LOAD_FULL_RES_TILE_BUFFER_SIZE;
 		} else {
-			if (setup->color_read &&
-			    !(args->color_read.flags &
-			      VC4_SUBMIT_RCL_SURFACE_READ_IS_FULL_RES)) {
-				loop_body_size += VC4_PACKET_TILE_COORDINATES_SIZE;
-				loop_body_size += VC4_PACKET_STORE_TILE_BUFFER_GENERAL_SIZE;
-			}
 			loop_body_size += VC4_PACKET_LOAD_TILE_BUFFER_GENERAL_SIZE;
 		}
 	}
-- 
2.20.0.rc1

