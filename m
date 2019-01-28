Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2052C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:04:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1F2F20989
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:04:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548691442;
	bh=beHVS2Iu1Tzax3T2S2GlQfVdgWYSSvUUhhfJczYpivQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=IRghzji45mfAxP3j6ZpoUvirxwQhDQlSHrxCX1Y5G6WjivGYl7Qm++nXEqOctOMfh
	 PqshXjl5tO7giYaNSQgl0JJtcT3WcmRHmA6Z1I1fSyfqmngxQ+rFSBdx3b7ggrrxgm
	 4tQKAdY0IIEJg42awUQUcHXIZNe+RMXG7fj+JnLc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731500AbfA1QEB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 11:04:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:49178 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731467AbfA1QDu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 11:03:50 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6159421852;
        Mon, 28 Jan 2019 16:03:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548691429;
        bh=beHVS2Iu1Tzax3T2S2GlQfVdgWYSSvUUhhfJczYpivQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MCSlqaYBqbov/M+ozi7idtf+K/o5zisO6lZt/aeyDMYmiTwPD3KdPQ3lS6sTC5vOf
         wlnCrEmoDVlIs+/s+994BJj7mGGCDp4pBtalGjuqYrSetJvzk2K5XsXlWCjesO8Cju
         djhgPVJXaKz4cURnoEDrZCPpdUh2s70rEq536X1A=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Eric Anholt <eric@anholt.net>, Sasha Levin <sashal@kernel.org>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 4.19 092/258] drm/v3d: Fix prime imports of buffers from other drivers.
Date:   Mon, 28 Jan 2019 10:56:38 -0500
Message-Id: <20190128155924.51521-92-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128155924.51521-1-sashal@kernel.org>
References: <20190128155924.51521-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Anholt <eric@anholt.net>

[ Upstream commit 62d1a752874962f072de8a779e960fcd2ab4847b ]

v3d_bo_get_pages() checks this to decide to map the imported buffer
instead of the backing shmem file.  The caller was about to set this
value anyway, and there's no error path in between.  Ideally we
wouldn't even allocate the shmem file for our imports, but that's a
more invasive fix.

Signed-off-by: Eric Anholt <eric@anholt.net>
Fixes: 57692c94dcbe ("drm/v3d: Introduce a new DRM driver for Broadcom V3D V3.x+")
Link: https://patchwork.freedesktop.org/patch/msgid/20181128230927.10951-3-eric@anholt.net
Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Reviewed-by: Dave Emett <david.emett@broadcom.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
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
2.19.1

