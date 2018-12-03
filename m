Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0766C04EBF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 22:25:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FA51206B7
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 22:25:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FA51206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anholt.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726119AbeLCWZG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 17:25:06 -0500
Received: from anholt.net ([50.246.234.109]:54176 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726036AbeLCWYp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 17:24:45 -0500
Received: from localhost (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id C786F10A1570;
        Mon,  3 Dec 2018 14:24:44 -0800 (PST)
X-Virus-Scanned: Debian amavisd-new at anholt.net
Received: from anholt.net ([127.0.0.1])
        by localhost (kingsolver.anholt.net [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id zEZqKWZN3Puv; Mon,  3 Dec 2018 14:24:42 -0800 (PST)
Received: from eliezer.anholt.net (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id E0FD410A0FA0;
        Mon,  3 Dec 2018 14:24:39 -0800 (PST)
Received: by eliezer.anholt.net (Postfix, from userid 1000)
        id DDE982FE36EE; Mon,  3 Dec 2018 14:24:38 -0800 (PST)
From:   Eric Anholt <eric@anholt.net>
To:     dri-devel@lists.freedesktop.org
Cc:     linux-kernel@vger.kernel.org,
        Dave Emett <david.emett@broadcom.com>,
        Thomas Spurden <thomas.spurden@broadcom.com>,
        Eric Anholt <eric@anholt.net>
Subject: [PATCH v2 4/6] drm/v3d: Drop the wait for L2T flush to complete.
Date:   Mon,  3 Dec 2018 14:24:36 -0800
Message-Id: <20181203222438.25417-4-eric@anholt.net>
X-Mailer: git-send-email 2.20.0.rc1
In-Reply-To: <20181203222438.25417-1-eric@anholt.net>
References: <20181203222438.25417-1-eric@anholt.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to Dave, once you've started an L2T flush, all L2T accesses
will be blocked until the flush completes.  This fixes a consistent
3-4ms stall between the ioctl and running the job, and 3DMMES Taiji
goes from 27fps to 110fps.

v2: Leave a note about why we don't need to wait for completion.

Signed-off-by: Eric Anholt <eric@anholt.net>
Fixes: 57692c94dcbe ("drm/v3d: Introduce a new DRM driver for Broadcom V3D V3.x+")
Reviewed-by: Dave Emett <david.emett@broadcom.com> (v1, comment requested)
---
 drivers/gpu/drm/v3d/v3d_gem.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/v3d/v3d_gem.c b/drivers/gpu/drm/v3d/v3d_gem.c
index 01e879c71cad..c268c7c79566 100644
--- a/drivers/gpu/drm/v3d/v3d_gem.c
+++ b/drivers/gpu/drm/v3d/v3d_gem.c
@@ -143,13 +143,13 @@ v3d_invalidate_l2(struct v3d_dev *v3d, int core)
 static void
 v3d_flush_l2t(struct v3d_dev *v3d, int core)
 {
+	/* While there is a busy bit (V3D_L2TCACTL_L2TFLS), we don't
+	 * need to wait for completion before dispatching the job --
+	 * L2T accesses will be stalled until the flush has completed.
+	 */
 	V3D_CORE_WRITE(core, V3D_CTL_L2TCACTL,
 		       V3D_L2TCACTL_L2TFLS |
 		       V3D_SET_FIELD(V3D_L2TCACTL_FLM_FLUSH, V3D_L2TCACTL_FLM));
-	if (wait_for(!(V3D_CORE_READ(core, V3D_CTL_L2TCACTL) &
-		       V3D_L2TCACTL_L2TFLS), 100)) {
-		DRM_ERROR("Timeout waiting for L2T flush\n");
-	}
 }
 
 /* Invalidates the slice caches.  These are read-only caches. */
-- 
2.20.0.rc1

