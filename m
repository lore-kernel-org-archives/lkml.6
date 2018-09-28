Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44115C43143
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 23:21:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0808E206B6
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 23:21:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0808E206B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anholt.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727742AbeI2Fre (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 01:47:34 -0400
Received: from anholt.net ([50.246.234.109]:45470 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727672AbeI2Frd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 01:47:33 -0400
Received: from localhost (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id 76FE310A0414;
        Fri, 28 Sep 2018 16:21:32 -0700 (PDT)
X-Virus-Scanned: Debian amavisd-new at anholt.net
Received: from anholt.net ([127.0.0.1])
        by localhost (kingsolver.anholt.net [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id GkQskAae_OW9; Fri, 28 Sep 2018 16:21:30 -0700 (PDT)
Received: from eliezer.anholt.net (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id 0EBA610A1706;
        Fri, 28 Sep 2018 16:21:28 -0700 (PDT)
Received: by eliezer.anholt.net (Postfix, from userid 1000)
        id E8BC82FE1B41; Fri, 28 Sep 2018 16:21:26 -0700 (PDT)
From:   Eric Anholt <eric@anholt.net>
To:     dri-devel@lists.freedesktop.org
Cc:     linux-kernel@vger.kernel.org, boris.brezillon@bootlin.com,
        Eric Anholt <eric@anholt.net>
Subject: [PATCH 3/4] drm/v3d: Add some better documentation of the in_sync arguments.
Date:   Fri, 28 Sep 2018 16:21:25 -0700
Message-Id: <20180928232126.4332-3-eric@anholt.net>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180928232126.4332-1-eric@anholt.net>
References: <20180928232126.4332-1-eric@anholt.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since this is UAPI, it's good to document what exactly the guarantees
we're providing are.

Signed-off-by: Eric Anholt <eric@anholt.net>
---
 include/uapi/drm/v3d_drm.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/uapi/drm/v3d_drm.h b/include/uapi/drm/v3d_drm.h
index 7b6627783608..f446656d00b1 100644
--- a/include/uapi/drm/v3d_drm.h
+++ b/include/uapi/drm/v3d_drm.h
@@ -58,6 +58,11 @@ struct drm_v3d_submit_cl {
 	 * coordinate shader to determine where primitives land on the screen,
 	 * then writes out the state updates and draw calls necessary per tile
 	 * to the tile allocation BO.
+	 *
+	 * This BCL will block on any previous BCL submitted on the
+	 * same FD, but not on any RCL or BCLs submitted by other
+	 * clients -- that is left up to the submitter to control
+	 * using in_sync_bcl if necessary.
 	 */
 	__u32 bcl_start;
 
@@ -69,6 +74,11 @@ struct drm_v3d_submit_cl {
 	 * This is the second set of commands executed, which will either
 	 * execute the tiles that have been set up by the BCL, or a fixed set
 	 * of tiles (in the case of RCL-only blits).
+	 *
+	 * This RCL will block on this submit's BCL, and any previous
+	 * RCL submitted on the same FD, but not on any RCL or BCLs
+	 * submitted by other clients -- that is left up to the
+	 * submitter to control using in_sync_rcl if necessary.
 	 */
 	__u32 rcl_start;
 
-- 
2.18.0

