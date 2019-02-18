Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC020C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 13:47:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AABF721901
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 13:47:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550497643;
	bh=undMkpbzLKFDvCdjQoEUNyMB7VcAkAfE3hY42gsTy9E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=DZMaNJqMwYaeVF4SAbsoW1kJ19s8EwjeTaFaaaUemD3RRu2Yvf5YvYVZ7mtEaack8
	 SwzbzqmNzebjmFpPKQimEhCc75xAW4jraL/GmVTt/FN5pdm8BgvTebFy7qgI6PCkFj
	 Y+rIalfQ1Ov9shzl13OE9wL0hoXbt273AToCL+LQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731722AbfBRNrW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 08:47:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:53916 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727417AbfBRNrU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 08:47:20 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 02A37218FC;
        Mon, 18 Feb 2019 13:47:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550497639;
        bh=undMkpbzLKFDvCdjQoEUNyMB7VcAkAfE3hY42gsTy9E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZN51VsvVQZawnjJHqRkqICw8LUKXr8CZHjvPm5y/bJ8vUtk4n/nHiQV8jMsOHrxD4
         cZaDs46s+D76IfeSotBYPSoyInQksZgmv+Iu8k45v+pf103PMGQU0IAIFEc3pSmMoH
         +BHsoIySWECae9wT5frzyYKcGJYCBZzry6dWMhbU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ilia Mirkin <imirkin@alum.mit.edu>,
        Ben Skeggs <bskeggs@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 40/92] drm/nouveau/falcon: avoid touching registers if engine is off
Date:   Mon, 18 Feb 2019 14:42:43 +0100
Message-Id: <20190218133458.458530155@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190218133454.668268457@linuxfoundation.org>
References: <20190218133454.668268457@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

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



