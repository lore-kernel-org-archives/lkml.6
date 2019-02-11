Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55306C282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:22:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23DC420838
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:22:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549894922;
	bh=hOxVbyB1yL4dKLoBc8aPW+P6jABPYjOm9xcVfFLdDiY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BFTC4vMz+b5ISKJf/wAar6OP2fM7zBhJ7Rma3foCBSSTpRJ1AXsQ+/BZ+eDsmZL9a
	 oCcc9cmLaKLyemVm+6kVBiLx8ogBZ3m8tIRMgtzQURQbkOQ7bfuOCKAojCNRISDvD0
	 WtIRPUSh0gkJiOoLH7kU2fYiQZZpnD0mqL/K1eqk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728643AbfBKOWA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:22:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:54838 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727807AbfBKOV5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:21:57 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6EA10222AA;
        Mon, 11 Feb 2019 14:21:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549894916;
        bh=hOxVbyB1yL4dKLoBc8aPW+P6jABPYjOm9xcVfFLdDiY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZzSNAiDb7leL3FPpzF67DZ8TEF7ox63UwpdLqJjdoof0Hohzp1jJRimmDMtvfR0SX
         2VwcDV+6+GBOF4uUHOt8JMp9bY17KyAlYdPGZNrXezbvJCfkiFYL6gBhfV3xaZhaXC
         /x5BnYoAoJNQ/QlzeEgpBhcWCpI3EcK1MikiJS+I=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Eric Anholt <eric@anholt.net>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 030/352] drm/vc4: ->x_scaling[1] should never be set to VC4_SCALING_NONE
Date:   Mon, 11 Feb 2019 15:14:17 +0100
Message-Id: <20190211141848.262272405@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141846.543045703@linuxfoundation.org>
References: <20190211141846.543045703@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

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
index ae6254b0b1ae..ed8b0fc170ee 100644
--- a/drivers/gpu/drm/vc4/vc4_plane.c
+++ b/drivers/gpu/drm/vc4/vc4_plane.c
@@ -314,12 +314,14 @@ static int vc4_plane_setup_clipping_and_scaling(struct drm_plane_state *state)
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



