Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30B56C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 16:09:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E75E820700
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 16:09:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549901372;
	bh=79m+Nk+lf61QRKOswr2Y7pdtJDF06KLqmRAFsEhz8vc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JwJPjA2kfh6OObVkB0vQeCF5XdoKhh2mWvN2EVRuP2WumPsJkO5ti5BV4Q1xyIrxr
	 U4tjnXrFXHEg8e/mQecmV9mdO08VDXFZn50fc1YN5JbUi4BnP7Yaxbg7e2L6BTjL5R
	 Do3vtkxPzJaFcuHsldTbqP1sRapBvlyMK4u2Ry0M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729685AbfBKQJa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 11:09:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:58782 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729368AbfBKOZX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:25:23 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F1AA2214DA;
        Mon, 11 Feb 2019 14:25:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549895122;
        bh=79m+Nk+lf61QRKOswr2Y7pdtJDF06KLqmRAFsEhz8vc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oJ1e9/OvMRSqCOaEwVMV3Os/Ldd8anYXgcGr5+1lbyaDEoxrtOA2cMO5RDACpzMoG
         QFFYxzWAfdNSE81LssYmPK5u0juvEF8nSzLxdTSZFSLV3B6jdYo9B5aY3T/UKRTzdY
         lbo7mLqkCayPOVazo2XDk0KqaOuVQk8Z3A8++tSY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Anholt <eric@anholt.net>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Dave Emett <david.emett@broadcom.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 099/352] drm/v3d: Fix prime imports of buffers from other drivers.
Date:   Mon, 11 Feb 2019 15:15:26 +0100
Message-Id: <20190211141852.112153451@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141846.543045703@linuxfoundation.org>
References: <20190211141846.543045703@linuxfoundation.org>
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



