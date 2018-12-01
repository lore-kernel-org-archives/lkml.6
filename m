Return-Path: <SRS0=0E8K=OK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27929C64EB4
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 00:58:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E137620673
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 00:58:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E137620673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anholt.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726663AbeLAMJQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 07:09:16 -0500
Received: from anholt.net ([50.246.234.109]:42742 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726014AbeLAMJP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 07:09:15 -0500
Received: from localhost (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id 111A610A1570;
        Fri, 30 Nov 2018 16:58:03 -0800 (PST)
X-Virus-Scanned: Debian amavisd-new at anholt.net
Received: from anholt.net ([127.0.0.1])
        by localhost (kingsolver.anholt.net [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id 9Q1TQ2L54tyi; Fri, 30 Nov 2018 16:58:00 -0800 (PST)
Received: from eliezer.anholt.net (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id 5A7BB10A11BF;
        Fri, 30 Nov 2018 16:58:00 -0800 (PST)
Received: by eliezer.anholt.net (Postfix, from userid 1000)
        id 6AFA32FE36EE; Fri, 30 Nov 2018 16:57:59 -0800 (PST)
From:   Eric Anholt <eric@anholt.net>
To:     dri-devel@lists.freedesktop.org
Cc:     linux-kernel@vger.kernel.org,
        Dave Emett <david.emett@broadcom.com>,
        Thomas Spurden <thomas.spurden@broadcom.com>,
        Eric Anholt <eric@anholt.net>
Subject: [PATCH 3/6] drm/v3d: Don't bother flushing L1TD at job start.
Date:   Fri, 30 Nov 2018 16:57:56 -0800
Message-Id: <20181201005759.28093-3-eric@anholt.net>
X-Mailer: git-send-email 2.20.0.rc1
In-Reply-To: <20181201005759.28093-1-eric@anholt.net>
References: <20181201005759.28093-1-eric@anholt.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the write combiner for TMU writes.  You're supposed to flush
that at job end if you had dirtied any cachelines.  Flushing it at job
start then doesn't make any sense.

Signed-off-by: Eric Anholt <eric@anholt.net>
Fixes: 57692c94dcbe ("drm/v3d: Introduce a new DRM driver for Broadcom V3D V3.x+")
---
 drivers/gpu/drm/v3d/v3d_gem.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/drivers/gpu/drm/v3d/v3d_gem.c b/drivers/gpu/drm/v3d/v3d_gem.c
index 34103205b7cb..cc4d025b01e0 100644
--- a/drivers/gpu/drm/v3d/v3d_gem.c
+++ b/drivers/gpu/drm/v3d/v3d_gem.c
@@ -139,22 +139,10 @@ v3d_invalidate_l2(struct v3d_dev *v3d, int core)
 		       V3D_L2CACTL_L2CENA);
 }
 
-static void
-v3d_invalidate_l1td(struct v3d_dev *v3d, int core)
-{
-	V3D_CORE_WRITE(core, V3D_CTL_L2TCACTL, V3D_L2TCACTL_TMUWCF);
-	if (wait_for(!(V3D_CORE_READ(core, V3D_CTL_L2TCACTL) &
-		       V3D_L2TCACTL_L2TFLS), 100)) {
-		DRM_ERROR("Timeout waiting for L1T write combiner flush\n");
-	}
-}
-
 /* Invalidates texture L2 cachelines */
 static void
 v3d_flush_l2t(struct v3d_dev *v3d, int core)
 {
-	v3d_invalidate_l1td(v3d, core);
-
 	V3D_CORE_WRITE(core, V3D_CTL_L2TCACTL,
 		       V3D_L2TCACTL_L2TFLS |
 		       V3D_SET_FIELD(V3D_L2TCACTL_FLM_FLUSH, V3D_L2TCACTL_FLM));
-- 
2.20.0.rc1

