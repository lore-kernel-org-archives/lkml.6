Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71D6FC282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 20:10:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49E7720857
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 20:10:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727475AbfBGUKR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 15:10:17 -0500
Received: from anholt.net ([50.246.234.109]:57738 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727398AbfBGUKG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 15:10:06 -0500
Received: from localhost (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id 0F05310A0353;
        Thu,  7 Feb 2019 12:10:06 -0800 (PST)
X-Virus-Scanned: Debian amavisd-new at anholt.net
Received: from anholt.net ([127.0.0.1])
        by localhost (kingsolver.anholt.net [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id vHaayKI4mv8l; Thu,  7 Feb 2019 12:10:04 -0800 (PST)
Received: from eliezer.anholt.net (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id A10D810A2C20;
        Thu,  7 Feb 2019 12:10:02 -0800 (PST)
Received: by eliezer.anholt.net (Postfix, from userid 1000)
        id A267C2FE464E; Thu,  7 Feb 2019 12:10:01 -0800 (PST)
From:   Eric Anholt <eric@anholt.net>
To:     dri-devel@lists.freedesktop.org
Cc:     linux-kernel@vger.kernel.org, david.emett@broadcom.com,
        thomas.spurden@broadcom.com, Eric Anholt <eric@anholt.net>
Subject: [PATCH 3/4] drm/v3d: Don't change other values in V3D_CTL_MISCCFG.
Date:   Thu,  7 Feb 2019 12:10:00 -0800
Message-Id: <20190207201001.5730-3-eric@anholt.net>
X-Mailer: git-send-email 2.20.0.rc1
In-Reply-To: <20190207201001.5730-1-eric@anholt.net>
References: <20190207201001.5730-1-eric@anholt.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The register now has another field, QRMAXCNT for how many TMU requests
get serviced before thread switch.  We were accidentally reducing it
from its default of 0x3 (4 requests) to 0x0 (1).

Signed-off-by: Eric Anholt <eric@anholt.net>
---
 drivers/gpu/drm/v3d/v3d_gem.c  | 4 +++-
 drivers/gpu/drm/v3d/v3d_regs.h | 2 ++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/v3d/v3d_gem.c b/drivers/gpu/drm/v3d/v3d_gem.c
index 3ee3ae4d3cac..887b4cf7020d 100644
--- a/drivers/gpu/drm/v3d/v3d_gem.c
+++ b/drivers/gpu/drm/v3d/v3d_gem.c
@@ -25,7 +25,9 @@ v3d_init_core(struct v3d_dev *v3d, int core)
 	 * type.  If you want the default behavior, you can still put
 	 * "2" in the indirect texture state's output_type field.
 	 */
-	V3D_CORE_WRITE(core, V3D_CTL_MISCCFG, V3D_MISCCFG_OVRTMUOUT);
+	V3D_CORE_WRITE(core, V3D_CTL_MISCCFG,
+		       V3D_CORE_READ(core, V3D_CTL_MISCCFG) |
+		       V3D_MISCCFG_OVRTMUOUT);
 
 	/* Whenever we flush the L2T cache, we always want to flush
 	 * the whole thing.
diff --git a/drivers/gpu/drm/v3d/v3d_regs.h b/drivers/gpu/drm/v3d/v3d_regs.h
index 6ccdee9d47bd..8e88af237610 100644
--- a/drivers/gpu/drm/v3d/v3d_regs.h
+++ b/drivers/gpu/drm/v3d/v3d_regs.h
@@ -216,6 +216,8 @@
 # define V3D_IDENT2_BCG_INT                            BIT(28)
 
 #define V3D_CTL_MISCCFG                                0x00018
+# define V3D_CTL_MISCCFG_QRMAXCNT_MASK                 V3D_MASK(3, 1)
+# define V3D_CTL_MISCCFG_QRMAXCNT_SHIFT                1
 # define V3D_MISCCFG_OVRTMUOUT                         BIT(0)
 
 #define V3D_CTL_L2CACTL                                0x00020
-- 
2.20.0.rc1

