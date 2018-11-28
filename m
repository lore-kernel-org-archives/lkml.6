Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 893DBC43610
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 23:09:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CBC5208E7
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 23:09:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CBC5208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anholt.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726980AbeK2KMs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 05:12:48 -0500
Received: from anholt.net ([50.246.234.109]:53880 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726586AbeK2KMq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 05:12:46 -0500
Received: from localhost (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id 6B06B10A1521;
        Wed, 28 Nov 2018 15:09:31 -0800 (PST)
X-Virus-Scanned: Debian amavisd-new at anholt.net
Received: from anholt.net ([127.0.0.1])
        by localhost (kingsolver.anholt.net [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id YR3kf40-004p; Wed, 28 Nov 2018 15:09:28 -0800 (PST)
Received: from eliezer.anholt.net (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id E283D10A02AD;
        Wed, 28 Nov 2018 15:09:27 -0800 (PST)
Received: by eliezer.anholt.net (Postfix, from userid 1000)
        id 569062FE2D64; Wed, 28 Nov 2018 15:09:27 -0800 (PST)
From:   Eric Anholt <eric@anholt.net>
To:     dri-devel@lists.freedesktop.org
Cc:     linux-kernel@vger.kernel.org, Eric Anholt <eric@anholt.net>,
        Dave Emett <david.emett@broadcom.com>
Subject: [PATCH 3/3] drm/v3d: Fix prime imports of buffers from other drivers.
Date:   Wed, 28 Nov 2018 15:09:27 -0800
Message-Id: <20181128230927.10951-3-eric@anholt.net>
X-Mailer: git-send-email 2.20.0.rc1
In-Reply-To: <20181128230927.10951-1-eric@anholt.net>
References: <20181128230927.10951-1-eric@anholt.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v3d_bo_get_pages() checks this to decide to map the imported buffer
instead of the backing shmem file.  The caller was about to set this
value anyway, and there's no error path in between.  Ideally we
wouldn't even allocate the shmem file for our imports, but that's a
more invasive fix.

Signed-off-by: Eric Anholt <eric@anholt.net>
Fixes: 57692c94dcbe ("drm/v3d: Introduce a new DRM driver for Broadcom V3D V3.x+")
Cc: Dave Emett <david.emett@broadcom.com>
---

I've been sitting on this one because I don't like it and was hoping
the shmem library would pan out.  This is a useful patch for now,
though.

 drivers/gpu/drm/v3d/v3d_bo.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/v3d/v3d_bo.c b/drivers/gpu/drm/v3d/v3d_bo.c
index 54d96518a131..a08766d39eab 100644
--- a/drivers/gpu/drm/v3d/v3d_bo.c
+++ b/drivers/gpu/drm/v3d/v3d_bo.c
@@ -293,6 +293,7 @@ v3d_prime_import_sg_table(struct drm_device *dev,
 	bo->resv = attach->dmabuf->resv;
 
 	bo->sgt = sgt;
+	obj->import_attach = attach;
 	v3d_bo_get_pages(bo);
 
 	v3d_mmu_insert_ptes(bo);
-- 
2.20.0.rc1

