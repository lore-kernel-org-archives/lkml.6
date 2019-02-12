Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C806EC282CE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 20:27:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99FCE222C1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 20:27:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731330AbfBLU1U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 15:27:20 -0500
Received: from anholt.net ([50.246.234.109]:59654 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727059AbfBLU1S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 15:27:18 -0500
Received: from localhost (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id 8297F10A29D8;
        Tue, 12 Feb 2019 12:27:17 -0800 (PST)
X-Virus-Scanned: Debian amavisd-new at anholt.net
Received: from anholt.net ([127.0.0.1])
        by localhost (kingsolver.anholt.net [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id 3LQGtXZWU1zI; Tue, 12 Feb 2019 12:27:14 -0800 (PST)
Received: from eliezer.anholt.net (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id A34B910A2C5A;
        Tue, 12 Feb 2019 12:27:14 -0800 (PST)
Received: by eliezer.anholt.net (Postfix, from userid 1000)
        id C051B2FE1FE6; Tue, 12 Feb 2019 12:27:13 -0800 (PST)
From:   Eric Anholt <eric@anholt.net>
To:     dri-devel@lists.freedesktop.org
Cc:     linux-kernel@vger.kernel.org, david.emett@broadcom.com,
        thomas.spurden@broadcom.com, Eric Anholt <eric@anholt.net>
Subject: [PATCH v2 2/3] drm/v3d: Don't try to set OVRTMUOUT on V3D 4.x.
Date:   Tue, 12 Feb 2019 12:27:12 -0800
Message-Id: <20190212202713.29205-2-eric@anholt.net>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190212202713.29205-1-eric@anholt.net>
References: <20190212202713.29205-1-eric@anholt.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The old field is gone and the register now has a different field,
QRMAXCNT for how many TMU requests get serviced before thread switch.
We were accidentally reducing it from its default of 0x3 (4 requests)
to 0x0 (1).

v2: Skip setting the reg at all on 4.x, instead of trying to update
    only the old field.

Signed-off-by: Eric Anholt <eric@anholt.net>
---
 drivers/gpu/drm/v3d/v3d_gem.c  | 3 ++-
 drivers/gpu/drm/v3d/v3d_regs.h | 2 ++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/v3d/v3d_gem.c b/drivers/gpu/drm/v3d/v3d_gem.c
index 3ee3ae4d3cac..06538ffa3014 100644
--- a/drivers/gpu/drm/v3d/v3d_gem.c
+++ b/drivers/gpu/drm/v3d/v3d_gem.c
@@ -25,7 +25,8 @@ v3d_init_core(struct v3d_dev *v3d, int core)
 	 * type.  If you want the default behavior, you can still put
 	 * "2" in the indirect texture state's output_type field.
 	 */
-	V3D_CORE_WRITE(core, V3D_CTL_MISCCFG, V3D_MISCCFG_OVRTMUOUT);
+	if (v3d->ver < 40)
+		V3D_CORE_WRITE(core, V3D_CTL_MISCCFG, V3D_MISCCFG_OVRTMUOUT);
 
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
2.20.1

