Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA131C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 22:25:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 711D1206B7
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 22:25:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 711D1206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anholt.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726102AbeLCWY7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 17:24:59 -0500
Received: from anholt.net ([50.246.234.109]:54182 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726044AbeLCWYq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 17:24:46 -0500
Received: from localhost (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id 4269B10A0FA0;
        Mon,  3 Dec 2018 14:24:45 -0800 (PST)
X-Virus-Scanned: Debian amavisd-new at anholt.net
Received: from anholt.net ([127.0.0.1])
        by localhost (kingsolver.anholt.net [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id R4kBV1tBz2uL; Mon,  3 Dec 2018 14:24:43 -0800 (PST)
Received: from eliezer.anholt.net (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id EA67910A1176;
        Mon,  3 Dec 2018 14:24:39 -0800 (PST)
Received: by eliezer.anholt.net (Postfix, from userid 1000)
        id D2CF52FE2D14; Mon,  3 Dec 2018 14:24:38 -0800 (PST)
From:   Eric Anholt <eric@anholt.net>
To:     dri-devel@lists.freedesktop.org
Cc:     linux-kernel@vger.kernel.org,
        Dave Emett <david.emett@broadcom.com>,
        Thomas Spurden <thomas.spurden@broadcom.com>,
        Eric Anholt <eric@anholt.net>
Subject: [PATCH v2 2/6] drm/v3d: Drop unused v3d_flush_caches().
Date:   Mon,  3 Dec 2018 14:24:34 -0800
Message-Id: <20181203222438.25417-2-eric@anholt.net>
X-Mailer: git-send-email 2.20.0.rc1
In-Reply-To: <20181203222438.25417-1-eric@anholt.net>
References: <20181203222438.25417-1-eric@anholt.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that I've specified how the end-of-pipeline flushing should work,
we're never going to use this function.

Signed-off-by: Eric Anholt <eric@anholt.net>
Reviewed-by: Dave Emett <david.emett@broadcom.com>
---
 drivers/gpu/drm/v3d/v3d_drv.h |  1 -
 drivers/gpu/drm/v3d/v3d_gem.c | 21 ---------------------
 2 files changed, 22 deletions(-)

diff --git a/drivers/gpu/drm/v3d/v3d_drv.h b/drivers/gpu/drm/v3d/v3d_drv.h
index bcd3d567bec2..239b56d76f3e 100644
--- a/drivers/gpu/drm/v3d/v3d_drv.h
+++ b/drivers/gpu/drm/v3d/v3d_drv.h
@@ -314,7 +314,6 @@ void v3d_exec_put(struct v3d_exec_info *exec);
 void v3d_tfu_job_put(struct v3d_tfu_job *exec);
 void v3d_reset(struct v3d_dev *v3d);
 void v3d_invalidate_caches(struct v3d_dev *v3d);
-void v3d_flush_caches(struct v3d_dev *v3d);
 
 /* v3d_irq.c */
 void v3d_irq_init(struct v3d_dev *v3d);
diff --git a/drivers/gpu/drm/v3d/v3d_gem.c b/drivers/gpu/drm/v3d/v3d_gem.c
index f565b197cba9..92413cbcf92c 100644
--- a/drivers/gpu/drm/v3d/v3d_gem.c
+++ b/drivers/gpu/drm/v3d/v3d_gem.c
@@ -175,20 +175,6 @@ v3d_invalidate_slices(struct v3d_dev *v3d, int core)
 		       V3D_SET_FIELD(0xf, V3D_SLCACTL_ICC));
 }
 
-/* Invalidates texture L2 cachelines */
-static void
-v3d_invalidate_l2t(struct v3d_dev *v3d, int core)
-{
-	V3D_CORE_WRITE(core,
-		       V3D_CTL_L2TCACTL,
-		       V3D_L2TCACTL_L2TFLS |
-		       V3D_SET_FIELD(V3D_L2TCACTL_FLM_CLEAR, V3D_L2TCACTL_FLM));
-	if (wait_for(!(V3D_CORE_READ(core, V3D_CTL_L2TCACTL) &
-		       V3D_L2TCACTL_L2TFLS), 100)) {
-		DRM_ERROR("Timeout waiting for L2T invalidate\n");
-	}
-}
-
 void
 v3d_invalidate_caches(struct v3d_dev *v3d)
 {
@@ -199,13 +185,6 @@ v3d_invalidate_caches(struct v3d_dev *v3d)
 	v3d_flush_l2t(v3d, 0);
 }
 
-void
-v3d_flush_caches(struct v3d_dev *v3d)
-{
-	v3d_invalidate_l1td(v3d, 0);
-	v3d_invalidate_l2t(v3d, 0);
-}
-
 static void
 v3d_attach_object_fences(struct v3d_bo **bos, int bo_count,
 			 struct dma_fence *fence)
-- 
2.20.0.rc1

