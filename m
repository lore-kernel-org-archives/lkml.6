Return-Path: <SRS0=1U6d=QQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89DE8C282C4
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 18:52:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EB7C21916
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 18:52:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549738328;
	bh=e2rUuGeVBb0hcmo3kJyKe0yIWs4a61HTgpDqUcLrqCQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CJc2twkpHuk5ITJsRRKeucASxzt/mf4cgueshvTBctGbr7jp2K8hbaE2WdOTpw8iG
	 GjsAUX42E+zbHIf0zLZud3tgVXMllY5m6WTX0vQHTQs+5x1upNt4/diMblt0/4V0m0
	 qq3Z3WRgvjgkfWeOtGGz0ZmQAaeDwf2CdYoqdjeg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728305AbfBISwG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Feb 2019 13:52:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:35822 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728243AbfBIStu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Feb 2019 13:49:50 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8A6532192C;
        Sat,  9 Feb 2019 18:49:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549738190;
        bh=e2rUuGeVBb0hcmo3kJyKe0yIWs4a61HTgpDqUcLrqCQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WhZTvZKSOCXCY8jLFFa7vaVCs7AihQgLCEIJ3A6PewS6mloyk7KQYBTV1nPGEYUZX
         wyymX3eMgNHdrXO7VLSNkQZkv9o3134VWtDM4pCQbyoJx2wCl7b486tzcrjRXxaCde
         Nv3NKXUIhEmosob3kAMgi+ZHvxyt2xER7hxxwf9k=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Ilia Mirkin <imirkin@alum.mit.edu>,
        Ben Skeggs <bskeggs@redhat.com>,
        Sasha Levin <sashal@kernel.org>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org
Subject: [PATCH AUTOSEL 4.14 15/16] drm/nouveau/falcon: avoid touching registers if engine is off
Date:   Sat,  9 Feb 2019 13:49:26 -0500
Message-Id: <20190209184927.126791-15-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190209184927.126791-1-sashal@kernel.org>
References: <20190209184927.126791-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ilia Mirkin <imirkin@alum.mit.edu>

[ Upstream commit a5176a4cb85bb6213daadf691097cf411da35df2 ]

Bugzilla: https://bugs.freedesktop.org/show_bug.cgi?id=108980
Signed-off-by: Ilia Mirkin <imirkin@alum.mit.edu>
Signed-off-by: Ben Skeggs <bskeggs@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/nouveau/nvkm/engine/falcon.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/falcon.c b/drivers/gpu/drm/nouveau/nvkm/engine/falcon.c
index 2e7b4e2105ef..62cb376e2c01 100644
--- a/drivers/gpu/drm/nouveau/nvkm/engine/falcon.c
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/falcon.c
@@ -22,6 +22,7 @@
 #include <engine/falcon.h>
 
 #include <core/gpuobj.h>
+#include <subdev/mc.h>
 #include <subdev/timer.h>
 #include <engine/fifo.h>
 
@@ -107,8 +108,10 @@ nvkm_falcon_fini(struct nvkm_engine *engine, bool suspend)
 		}
 	}
 
-	nvkm_mask(device, base + 0x048, 0x00000003, 0x00000000);
-	nvkm_wr32(device, base + 0x014, 0xffffffff);
+	if (nvkm_mc_enabled(device, engine->subdev.index)) {
+		nvkm_mask(device, base + 0x048, 0x00000003, 0x00000000);
+		nvkm_wr32(device, base + 0x014, 0xffffffff);
+	}
 	return 0;
 }
 
-- 
2.19.1

