Return-Path: <SRS0=1U6d=QQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10700C282C4
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 18:53:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFEDB20821
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 18:53:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549738389;
	bh=iIXzYjkzx8FW4knIQH0cq7xv08zI5qckJhdYfOn+pBk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2KOskKQUREXMxCLNGcbfSGbUbHP1mUwLeB2RYUCFPSJgCJPkV67vV1n6IIvz+22SW
	 /YYrNa2CHXLx/8mPfjmMb11sEvX3BKOFMzeo9qavfA9+zcmoyZ+Z30c81C+iL9N5YU
	 LvHtNDP2HbOLeXc3oBWEpVkq/+SsRmLoY8Rpgoqw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728125AbfBISt2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Feb 2019 13:49:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:34944 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728110AbfBIStZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Feb 2019 13:49:25 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DCD3C20821;
        Sat,  9 Feb 2019 18:49:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549738164;
        bh=iIXzYjkzx8FW4knIQH0cq7xv08zI5qckJhdYfOn+pBk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mj/a+dqi40jmNrIofeap+0EmbGeMcPsEjx+RpwnTUAb0x5LBSFg5BucNdXpW0MGny
         ES4BmV2yoxMAd1IOR6Ixi7BhHzjPiOy0UI0+KpcV8nCiwW97xswIwf/qLJ85l1LRoa
         JI4GLEvLjXv8eIQNSo3JQzPK1kwrPIY/WEPOUblY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Ilia Mirkin <imirkin@alum.mit.edu>,
        Ben Skeggs <bskeggs@redhat.com>,
        Sasha Levin <sashal@kernel.org>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org
Subject: [PATCH AUTOSEL 4.19 26/28] drm/nouveau/falcon: avoid touching registers if engine is off
Date:   Sat,  9 Feb 2019 13:48:34 -0500
Message-Id: <20190209184840.126418-26-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190209184840.126418-1-sashal@kernel.org>
References: <20190209184840.126418-1-sashal@kernel.org>
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
index 816ccaedfc73..8675613e142b 100644
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

