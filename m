Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 356DAC04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 22:24:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0428206B7
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 22:24:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0428206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anholt.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726069AbeLCWYq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 17:24:46 -0500
Received: from anholt.net ([50.246.234.109]:54168 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726034AbeLCWYo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 17:24:44 -0500
Received: from localhost (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id C151B10A1570;
        Mon,  3 Dec 2018 14:24:43 -0800 (PST)
X-Virus-Scanned: Debian amavisd-new at anholt.net
Received: from anholt.net ([127.0.0.1])
        by localhost (kingsolver.anholt.net [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id tqZC9TkeCJ_Y; Mon,  3 Dec 2018 14:24:41 -0800 (PST)
Received: from eliezer.anholt.net (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id D7F5F10A0F7F;
        Mon,  3 Dec 2018 14:24:39 -0800 (PST)
Received: by eliezer.anholt.net (Postfix, from userid 1000)
        id E44C82FE36F0; Mon,  3 Dec 2018 14:24:38 -0800 (PST)
From:   Eric Anholt <eric@anholt.net>
To:     dri-devel@lists.freedesktop.org
Cc:     linux-kernel@vger.kernel.org,
        Dave Emett <david.emett@broadcom.com>,
        Thomas Spurden <thomas.spurden@broadcom.com>,
        Eric Anholt <eric@anholt.net>
Subject: [PATCH v2 5/6] drm/v3d: Stop trying to flush L2C on V3D 3.3+
Date:   Mon,  3 Dec 2018 14:24:37 -0800
Message-Id: <20181203222438.25417-5-eric@anholt.net>
X-Mailer: git-send-email 2.20.0.rc1
In-Reply-To: <20181203222438.25417-1-eric@anholt.net>
References: <20181203222438.25417-1-eric@anholt.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This cache was replaced with the slice accessing the L2T in the newer
generations.  Noted by Dave during review.

Signed-off-by: Eric Anholt <eric@anholt.net>
---
 drivers/gpu/drm/v3d/v3d_gem.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/v3d/v3d_gem.c b/drivers/gpu/drm/v3d/v3d_gem.c
index c268c7c79566..8a4be9515179 100644
--- a/drivers/gpu/drm/v3d/v3d_gem.c
+++ b/drivers/gpu/drm/v3d/v3d_gem.c
@@ -130,10 +130,15 @@ v3d_flush_l3(struct v3d_dev *v3d)
 	}
 }
 
-/* Invalidates the (read-only) L2 cache. */
+/* Invalidates the (read-only) L2C cache.  This was the L2 cache for
+ * uniforms and instructions on V3D 3.2.
+ */
 static void
-v3d_invalidate_l2(struct v3d_dev *v3d, int core)
+v3d_invalidate_l2c(struct v3d_dev *v3d, int core)
 {
+	if (v3d->ver > 32)
+		return;
+
 	V3D_CORE_WRITE(core, V3D_CTL_L2CACTL,
 		       V3D_L2CACTL_L2CCLR |
 		       V3D_L2CACTL_L2CENA);
@@ -168,7 +173,7 @@ v3d_invalidate_caches(struct v3d_dev *v3d)
 {
 	v3d_flush_l3(v3d);
 
-	v3d_invalidate_l2(v3d, 0);
+	v3d_invalidate_l2c(v3d, 0);
 	v3d_invalidate_slices(v3d, 0);
 	v3d_flush_l2t(v3d, 0);
 }
-- 
2.20.0.rc1

