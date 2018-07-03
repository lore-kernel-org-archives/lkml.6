Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00842C6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 17:06:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF0A321C66
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 17:05:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF0A321C66
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anholt.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934264AbeGCRFz (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 13:05:55 -0400
Received: from anholt.net ([50.246.234.109]:41078 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934157AbeGCRFV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 13:05:21 -0400
Received: from localhost (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id 8B50F10A0EEB;
        Tue,  3 Jul 2018 10:05:20 -0700 (PDT)
X-Virus-Scanned: Debian amavisd-new at anholt.net
Received: from anholt.net ([127.0.0.1])
        by localhost (kingsolver.anholt.net [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id 9G4Ctg4dqOzo; Tue,  3 Jul 2018 10:05:18 -0700 (PDT)
Received: from eliezer.anholt.net (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id D7D9310A18A9;
        Tue,  3 Jul 2018 10:05:16 -0700 (PDT)
Received: by eliezer.anholt.net (Postfix, from userid 1000)
        id 6DBFE2FE2604; Tue,  3 Jul 2018 10:05:15 -0700 (PDT)
From:   Eric Anholt <eric@anholt.net>
To:     dri-devel@lists.freedesktop.org
Cc:     linux-kernel@vger.kernel.org, Eric Anholt <eric@anholt.net>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Subject: [PATCH 2/4] drm/v3d: Remove unnecessary dma_fence_ops.
Date:   Tue,  3 Jul 2018 10:05:13 -0700
Message-Id: <20180703170515.6298-2-eric@anholt.net>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180703170515.6298-1-eric@anholt.net>
References: <20180703170515.6298-1-eric@anholt.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The dma-fence core as of commit 418cc6ca0607 ("dma-fence: Make ->wait
callback optional") provides appropriate defaults for these methods.

Signed-off-by: Eric Anholt <eric@anholt.net>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
---
 drivers/gpu/drm/v3d/v3d_fence.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/drivers/gpu/drm/v3d/v3d_fence.c b/drivers/gpu/drm/v3d/v3d_fence.c
index bfe31a89668b..50bfcf9a8a1a 100644
--- a/drivers/gpu/drm/v3d/v3d_fence.c
+++ b/drivers/gpu/drm/v3d/v3d_fence.c
@@ -35,19 +35,7 @@ static const char *v3d_fence_get_timeline_name(struct dma_fence *fence)
 		return "v3d-render";
 }
 
-static bool v3d_fence_enable_signaling(struct dma_fence *fence)
-{
-	return true;
-}
-
 const struct dma_fence_ops v3d_fence_ops = {
 	.get_driver_name = v3d_fence_get_driver_name,
 	.get_timeline_name = v3d_fence_get_timeline_name,
-	.enable_signaling = v3d_fence_enable_signaling,
-	/* Each of our fences gets signaled as complete by the IRQ
-	 * handler, so we rely on the core's tracking of signaling.
-	 */
-	.signaled = NULL,
-	.wait = dma_fence_default_wait,
-	.release = dma_fence_free,
 };
-- 
2.18.0

