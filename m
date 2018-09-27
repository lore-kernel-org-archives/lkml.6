Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E60ABC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 09:22:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3E562152F
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 09:22:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3E562152F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727480AbeI0PjY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 11:39:24 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:56346 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727347AbeI0PjY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 11:39:24 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 711941120;
        Thu, 27 Sep 2018 09:22:04 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Eric Anholt <eric@anholt.net>,
        Sean Paul <seanpaul@chromium.org>
Subject: [PATCH 4.14 46/64] drm/vc4: Fix the "no scaling" case on multi-planar YUV formats
Date:   Thu, 27 Sep 2018 11:04:03 +0200
Message-Id: <20180927090256.461155281@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180927090249.801943776@linuxfoundation.org>
References: <20180927090249.801943776@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Boris Brezillon <boris.brezillon@bootlin.com>

commit 658d8cbd07dae22ccecf49399e18c609c4e85c53 upstream.

When there's no scaling requested ->is_unity should be true no matter
the format.

Also, when no scaling is requested and we have a multi-planar YUV
format, we should leave ->y_scaling[0] to VC4_SCALING_NONE and only
set ->x_scaling[0] to VC4_SCALING_PPF.

Doing this fixes an hardly visible artifact (seen when using modetest
and a rather big overlay plane in YUV420).

Fixes: fc04023fafec ("drm/vc4: Add support for YUV planes.")
Cc: <stable@vger.kernel.org>
Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
Reviewed-by: Eric Anholt <eric@anholt.net>
Link: https://patchwork.freedesktop.org/patch/msgid/20180725122907.13702-1-boris.brezillon@bootlin.com
Signed-off-by: Sean Paul <seanpaul@chromium.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/vc4/vc4_plane.c |   25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

--- a/drivers/gpu/drm/vc4/vc4_plane.c
+++ b/drivers/gpu/drm/vc4/vc4_plane.c
@@ -329,6 +329,9 @@ static int vc4_plane_setup_clipping_and_
 	vc4_state->y_scaling[0] = vc4_get_scaling_mode(vc4_state->src_h[0],
 						       vc4_state->crtc_h);
 
+	vc4_state->is_unity = (vc4_state->x_scaling[0] == VC4_SCALING_NONE &&
+			       vc4_state->y_scaling[0] == VC4_SCALING_NONE);
+
 	if (num_planes > 1) {
 		vc4_state->is_yuv = true;
 
@@ -344,24 +347,17 @@ static int vc4_plane_setup_clipping_and_
 			vc4_get_scaling_mode(vc4_state->src_h[1],
 					     vc4_state->crtc_h);
 
-		/* YUV conversion requires that scaling be enabled,
-		 * even on a plane that's otherwise 1:1.  Choose TPZ
-		 * for simplicity.
+		/* YUV conversion requires that horizontal scaling be enabled,
+		 * even on a plane that's otherwise 1:1. Looks like only PPF
+		 * works in that case, so let's pick that one.
 		 */
-		if (vc4_state->x_scaling[0] == VC4_SCALING_NONE)
-			vc4_state->x_scaling[0] = VC4_SCALING_TPZ;
-		if (vc4_state->y_scaling[0] == VC4_SCALING_NONE)
-			vc4_state->y_scaling[0] = VC4_SCALING_TPZ;
+		if (vc4_state->is_unity)
+			vc4_state->x_scaling[0] = VC4_SCALING_PPF;
 	} else {
 		vc4_state->x_scaling[1] = VC4_SCALING_NONE;
 		vc4_state->y_scaling[1] = VC4_SCALING_NONE;
 	}
 
-	vc4_state->is_unity = (vc4_state->x_scaling[0] == VC4_SCALING_NONE &&
-			       vc4_state->y_scaling[0] == VC4_SCALING_NONE &&
-			       vc4_state->x_scaling[1] == VC4_SCALING_NONE &&
-			       vc4_state->y_scaling[1] == VC4_SCALING_NONE);
-
 	/* No configuring scaling on the cursor plane, since it gets
 	   non-vblank-synced updates, and scaling requires requires
 	   LBM changes which have to be vblank-synced.
@@ -639,7 +635,10 @@ static int vc4_plane_mode_set(struct drm
 		vc4_dlist_write(vc4_state, SCALER_CSC2_ITR_R_601_5);
 	}
 
-	if (!vc4_state->is_unity) {
+	if (vc4_state->x_scaling[0] != VC4_SCALING_NONE ||
+	    vc4_state->x_scaling[1] != VC4_SCALING_NONE ||
+	    vc4_state->y_scaling[0] != VC4_SCALING_NONE ||
+	    vc4_state->y_scaling[1] != VC4_SCALING_NONE) {
 		/* LBM Base Address. */
 		if (vc4_state->y_scaling[0] != VC4_SCALING_NONE ||
 		    vc4_state->y_scaling[1] != VC4_SCALING_NONE) {


