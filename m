Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CB37C282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:42:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B24920838
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:42:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549896151;
	bh=FBmtrXisTjyn/dN3T1lleB0l2mjPcdFFAFSewHyu81M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=eRFyDKSN++WsZDaaH2GMMdQSxPTU5obOrIGs3JU8BmvIVrgoDZNftLlrod3DkJ1F4
	 q/4gg1kSmavM/jr2cXhz7qttemeTifAT52Y4ZbYUspT+LlUHB2dvW/1N5p6QN5T7Fh
	 qQC46cuuEaRUqdLIsaGH9fhKycH+pFCTAKXBW1q8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732440AbfBKOm3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:42:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:54250 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732046AbfBKOm0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:42:26 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E659B20700;
        Mon, 11 Feb 2019 14:42:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549896145;
        bh=FBmtrXisTjyn/dN3T1lleB0l2mjPcdFFAFSewHyu81M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gv2q/R44TsFWCZvTeH1SZQE/Be4IKg6pOIicbGfXRvyWvb7ZwwLrA9AtZb0n3dtQx
         nlDmcvqT+uqN3dHqtdn/06RNw4M6BxtjA0IiW2Nh/cPoBu31UxZfRsx4swF6U/3BL5
         ViF79Am/DNJD/SkVvwJAA5GM+BT0eRjV6arpDjxA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Anholt <eric@anholt.net>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Dave Emett <david.emett@broadcom.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 086/313] drm/v3d: Fix prime imports of buffers from other drivers.
Date:   Mon, 11 Feb 2019 15:16:06 +0100
Message-Id: <20190211141859.598714302@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141852.749630980@linuxfoundation.org>
References: <20190211141852.749630980@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

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



