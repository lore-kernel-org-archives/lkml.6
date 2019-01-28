Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81AA6C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:20:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F6D621738
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548692422;
	bh=8CxUx3jL7rEIMpSPDgPBEHU0VjlumxYRwXrmlORX9EM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=o/lFhVbYZgRRG87R+kczMNk1o7AHItksKvUInCm7j5PeawZ6aPar/1vRp6KmPlS5h
	 0/jG1pdQ53LY9Be3+DO++Q3t42XscsQvxukMGfj6W4ODp5f2YIRyf50Is7NqsEKnw6
	 mDQbyPaXxbC01z72OJuWI+XIGoTr3tLmsJwitgxs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388779AbfA1QUV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 11:20:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:55634 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388771AbfA1QUS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 11:20:18 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 913032171F;
        Mon, 28 Jan 2019 16:20:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548692418;
        bh=8CxUx3jL7rEIMpSPDgPBEHU0VjlumxYRwXrmlORX9EM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=I8teyX3HMaMhTYFLQXcGvUEmWl/0hUhZ3ZkPuQE5jnyxyCuKKkdN7pQEYpvYJltLz
         AqXerxU71ttpk8rsX/X6gF8RV3uRbj1ttVud6tSQGOqNNzr/VunoWccqgkcyHCMaWN
         9OqHGv500fjxBkM8iA+nPBMPMdUPP4XttlasbNoQ=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Boris Brezillon <boris.brezillon@bootlin.com>,
        Sasha Levin <sashal@kernel.org>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 4.9 012/107] drm/vc4: ->x_scaling[1] should never be set to VC4_SCALING_NONE
Date:   Mon, 28 Jan 2019 11:18:12 -0500
Message-Id: <20190128161947.57405-12-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128161947.57405-1-sashal@kernel.org>
References: <20190128161947.57405-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Boris Brezillon <boris.brezillon@bootlin.com>

[ Upstream commit 0560054da5673b25d56bea6c57c8d069673af73b ]

For the YUV conversion to work properly, ->x_scaling[1] should never
be set to VC4_SCALING_NONE, but vc4_get_scaling_mode() might return
VC4_SCALING_NONE if the horizontal scaling ratio exactly matches the
horizontal subsampling factor. Add a test to turn VC4_SCALING_NONE
into VC4_SCALING_PPF when that happens.

The old ->x_scaling[0] adjustment is dropped as I couldn't find any
mention to this constraint in the spec and it's proven to be
unnecessary (I tested various multi-planar YUV formats with scaling
disabled, and all of them worked fine without this adjustment).

Fixes: fc04023fafec ("drm/vc4: Add support for YUV planes.")
Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
Reviewed-by: Eric Anholt <eric@anholt.net>
Link: https://patchwork.freedesktop.org/patch/msgid/20181109102633.32603-1-boris.brezillon@bootlin.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/vc4/vc4_plane.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_plane.c b/drivers/gpu/drm/vc4/vc4_plane.c
index 70051bf0ee5c..0376c0c2fc66 100644
--- a/drivers/gpu/drm/vc4/vc4_plane.c
+++ b/drivers/gpu/drm/vc4/vc4_plane.c
@@ -345,12 +345,14 @@ static int vc4_plane_setup_clipping_and_scaling(struct drm_plane_state *state)
 			vc4_get_scaling_mode(vc4_state->src_h[1],
 					     vc4_state->crtc_h);
 
-		/* YUV conversion requires that horizontal scaling be enabled,
-		 * even on a plane that's otherwise 1:1. Looks like only PPF
-		 * works in that case, so let's pick that one.
+		/* YUV conversion requires that horizontal scaling be enabled
+		 * on the UV plane even if vc4_get_scaling_mode() returned
+		 * VC4_SCALING_NONE (which can happen when the down-scaling
+		 * ratio is 0.5). Let's force it to VC4_SCALING_PPF in this
+		 * case.
 		 */
-		if (vc4_state->is_unity)
-			vc4_state->x_scaling[0] = VC4_SCALING_PPF;
+		if (vc4_state->x_scaling[1] == VC4_SCALING_NONE)
+			vc4_state->x_scaling[1] = VC4_SCALING_PPF;
 	} else {
 		vc4_state->is_yuv = false;
 		vc4_state->x_scaling[1] = VC4_SCALING_NONE;
-- 
2.19.1

