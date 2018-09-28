Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EC89C004D2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 23:21:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1836206B6
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 23:21:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1836206B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anholt.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727781AbeI2Frn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 01:47:43 -0400
Received: from anholt.net ([50.246.234.109]:45464 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727401AbeI2Frd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 01:47:33 -0400
Received: from localhost (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id 105A710A1AED;
        Fri, 28 Sep 2018 16:21:32 -0700 (PDT)
X-Virus-Scanned: Debian amavisd-new at anholt.net
Received: from anholt.net ([127.0.0.1])
        by localhost (kingsolver.anholt.net [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id z0gbsOGzIDem; Fri, 28 Sep 2018 16:21:31 -0700 (PDT)
Received: from eliezer.anholt.net (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id 18DE310A1AE7;
        Fri, 28 Sep 2018 16:21:28 -0700 (PDT)
Received: by eliezer.anholt.net (Postfix, from userid 1000)
        id EE0DC2FE1B43; Fri, 28 Sep 2018 16:21:26 -0700 (PDT)
From:   Eric Anholt <eric@anholt.net>
To:     dri-devel@lists.freedesktop.org
Cc:     linux-kernel@vger.kernel.org, boris.brezillon@bootlin.com,
        Eric Anholt <eric@anholt.net>
Subject: [PATCH 4/4] drm/v3d: Skip debugfs dumping GCA on platforms without GCA.
Date:   Fri, 28 Sep 2018 16:21:26 -0700
Message-Id: <20180928232126.4332-4-eric@anholt.net>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180928232126.4332-1-eric@anholt.net>
References: <20180928232126.4332-1-eric@anholt.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes an oops reading this debugfs entry on BCM7278.

Signed-off-by: Eric Anholt <eric@anholt.net>
---
 drivers/gpu/drm/v3d/v3d_debugfs.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/v3d/v3d_debugfs.c b/drivers/gpu/drm/v3d/v3d_debugfs.c
index d48008adb085..eb2b2d2f8553 100644
--- a/drivers/gpu/drm/v3d/v3d_debugfs.c
+++ b/drivers/gpu/drm/v3d/v3d_debugfs.c
@@ -71,10 +71,13 @@ static int v3d_v3d_debugfs_regs(struct seq_file *m, void *unused)
 			   V3D_READ(v3d_hub_reg_defs[i].reg));
 	}
 
-	for (i = 0; i < ARRAY_SIZE(v3d_gca_reg_defs); i++) {
-		seq_printf(m, "%s (0x%04x): 0x%08x\n",
-			   v3d_gca_reg_defs[i].name, v3d_gca_reg_defs[i].reg,
-			   V3D_GCA_READ(v3d_gca_reg_defs[i].reg));
+	if (v3d->ver < 41) {
+		for (i = 0; i < ARRAY_SIZE(v3d_gca_reg_defs); i++) {
+			seq_printf(m, "%s (0x%04x): 0x%08x\n",
+				   v3d_gca_reg_defs[i].name,
+				   v3d_gca_reg_defs[i].reg,
+				   V3D_GCA_READ(v3d_gca_reg_defs[i].reg));
+		}
 	}
 
 	for (core = 0; core < v3d->cores; core++) {
-- 
2.18.0

