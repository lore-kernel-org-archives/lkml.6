Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FA69C10F02
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:37:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 645142229E
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:37:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550500671;
	bh=EUy1HFNattFaUXrd6BSkGWYyUkNJQEheNnsdUYqfAb4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wXR2nCv4yJwo5ADebG/JyP7IeDhNpR5JYKTtMVo80SCrUmSEODmzTD1WstNtvHmbe
	 7kp4f31jPZaHL0fvZEAHJe/bbqAghPs+DckQewU1lcYfB26zCzlRhvXJHUA5/g3fDg
	 +Dos9jRS9gH1Dhoa4DEO6P8y8GBBJndfQmYTZ/XI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387791AbfBROgv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 09:36:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:35862 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733028AbfBRNzr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 08:55:47 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 266C321901;
        Mon, 18 Feb 2019 13:55:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550498145;
        bh=EUy1HFNattFaUXrd6BSkGWYyUkNJQEheNnsdUYqfAb4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VQebmxnf7VwiWsIxPA4XV2hmreSi3yQYG6u2QT2JVu/i9wHqgcV1mgpuToGRxIFJH
         i0pm2chxkpAJhcU+lO5oTTZ5+KSkgQ31mP4TJC6alJeLbMP3Hmc6HdK7C9U4vf4Fwi
         uctLQJ6eQRExSB+XrqzM0nfIUj2P+qNBQ1jXU/jo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ilia Mirkin <imirkin@alum.mit.edu>,
        Ben Skeggs <bskeggs@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 38/62] drm/nouveau/falcon: avoid touching registers if engine is off
Date:   Mon, 18 Feb 2019 14:43:44 +0100
Message-Id: <20190218133509.173666949@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190218133505.801423074@linuxfoundation.org>
References: <20190218133505.801423074@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

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



