Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F526C04EBF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 22:24:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EC7A20864
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 22:24:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EC7A20864
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anholt.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726085AbeLCWYu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 17:24:50 -0500
Received: from anholt.net ([50.246.234.109]:54188 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726054AbeLCWYq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 17:24:46 -0500
Received: from localhost (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id 3AE8610A1176;
        Mon,  3 Dec 2018 14:24:46 -0800 (PST)
X-Virus-Scanned: Debian amavisd-new at anholt.net
Received: from anholt.net ([127.0.0.1])
        by localhost (kingsolver.anholt.net [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id lui2YruITQ4r; Mon,  3 Dec 2018 14:24:45 -0800 (PST)
Received: from eliezer.anholt.net (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id 87C5F10A1583;
        Mon,  3 Dec 2018 14:24:40 -0800 (PST)
Received: by eliezer.anholt.net (Postfix, from userid 1000)
        id E83422FE36F1; Mon,  3 Dec 2018 14:24:38 -0800 (PST)
From:   Eric Anholt <eric@anholt.net>
To:     dri-devel@lists.freedesktop.org
Cc:     linux-kernel@vger.kernel.org,
        Dave Emett <david.emett@broadcom.com>,
        Thomas Spurden <thomas.spurden@broadcom.com>,
        Eric Anholt <eric@anholt.net>
Subject: [PATCH v2 6/6] drm/v3d: Invalidate the caches from the outside in.
Date:   Mon,  3 Dec 2018 14:24:38 -0800
Message-Id: <20181203222438.25417-6-eric@anholt.net>
X-Mailer: git-send-email 2.20.0.rc1
In-Reply-To: <20181203222438.25417-1-eric@anholt.net>
References: <20181203222438.25417-1-eric@anholt.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This would be a fairly obscure race, but let's make sure we don't ever
lose it.

Signed-off-by: Eric Anholt <eric@anholt.net>
---
 drivers/gpu/drm/v3d/v3d_gem.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/v3d/v3d_gem.c b/drivers/gpu/drm/v3d/v3d_gem.c
index 8a4be9515179..443b1c53117a 100644
--- a/drivers/gpu/drm/v3d/v3d_gem.c
+++ b/drivers/gpu/drm/v3d/v3d_gem.c
@@ -171,11 +171,15 @@ v3d_invalidate_slices(struct v3d_dev *v3d, int core)
 void
 v3d_invalidate_caches(struct v3d_dev *v3d)
 {
+	/* Invalidate the caches from the outside in.  That way if
+	 * another CL's concurrent use of nearby memory were to pull
+	 * an invalidated cacheline back in, we wouldn't leave stale
+	 * data in the inner cache.
+	 */
 	v3d_flush_l3(v3d);
-
 	v3d_invalidate_l2c(v3d, 0);
-	v3d_invalidate_slices(v3d, 0);
 	v3d_flush_l2t(v3d, 0);
+	v3d_invalidate_slices(v3d, 0);
 }
 
 static void
-- 
2.20.0.rc1

