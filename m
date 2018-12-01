Return-Path: <SRS0=0E8K=OK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3D6BC64EB4
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 00:58:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82E1E20673
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 00:58:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82E1E20673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anholt.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbeLAMJZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 07:09:25 -0500
Received: from anholt.net ([50.246.234.109]:42772 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726744AbeLAMJS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 07:09:18 -0500
Received: from localhost (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id 51CD410A156C;
        Fri, 30 Nov 2018 16:58:06 -0800 (PST)
X-Virus-Scanned: Debian amavisd-new at anholt.net
Received: from anholt.net ([127.0.0.1])
        by localhost (kingsolver.anholt.net [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id 30Y7l-K5haQs; Fri, 30 Nov 2018 16:58:05 -0800 (PST)
Received: from eliezer.anholt.net (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id 3F01010A1572;
        Fri, 30 Nov 2018 16:58:01 -0800 (PST)
Received: by eliezer.anholt.net (Postfix, from userid 1000)
        id 77E2D2FE36F1; Fri, 30 Nov 2018 16:57:59 -0800 (PST)
From:   Eric Anholt <eric@anholt.net>
To:     dri-devel@lists.freedesktop.org
Cc:     linux-kernel@vger.kernel.org,
        Dave Emett <david.emett@broadcom.com>,
        Thomas Spurden <thomas.spurden@broadcom.com>,
        Eric Anholt <eric@anholt.net>
Subject: [PATCH 6/6] drm/v3d: Add missing fence timeline name for TFU.
Date:   Fri, 30 Nov 2018 16:57:59 -0800
Message-Id: <20181201005759.28093-6-eric@anholt.net>
X-Mailer: git-send-email 2.20.0.rc1
In-Reply-To: <20181201005759.28093-1-eric@anholt.net>
References: <20181201005759.28093-1-eric@anholt.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We shouldn't be returning v3d-render in for our new queue.

Signed-off-by: Eric Anholt <eric@anholt.net>
Fixes: 83d5139982db ("drm/v3d: Add support for submitting jobs to the TFU.")
---
 drivers/gpu/drm/v3d/v3d_fence.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/v3d/v3d_fence.c b/drivers/gpu/drm/v3d/v3d_fence.c
index 50bfcf9a8a1a..b0a2a1ae2eb1 100644
--- a/drivers/gpu/drm/v3d/v3d_fence.c
+++ b/drivers/gpu/drm/v3d/v3d_fence.c
@@ -29,10 +29,16 @@ static const char *v3d_fence_get_timeline_name(struct dma_fence *fence)
 {
 	struct v3d_fence *f = to_v3d_fence(fence);
 
-	if (f->queue == V3D_BIN)
+	switch (f->queue) {
+	case V3D_BIN:
 		return "v3d-bin";
-	else
+	case V3D_RENDER:
 		return "v3d-render";
+	case V3D_TFU:
+		return "v3d-tfu";
+	default:
+		return NULL;
+	}
 }
 
 const struct dma_fence_ops v3d_fence_ops = {
-- 
2.20.0.rc1

