Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9096EC64EAD
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 21:57:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5278320880
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 21:57:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5278320880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729286AbeI3E0q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Sep 2018 00:26:46 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:51721 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728356AbeI3ES0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Sep 2018 00:18:26 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1g6N65-0000Gz-TB; Sat, 29 Sep 2018 22:48:22 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1g6N5y-0006x8-SQ; Sat, 29 Sep 2018 22:48:14 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org,
        "Christian =?UTF-8?Q?K=C3=B6nig?=" <christian.koenig@amd.com>,
        "Dave Airlie" <airlied@redhat.com>
Date:   Sat, 29 Sep 2018 22:43:07 +0100
Message-ID: <lsq.1538257387.681758792@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 103/131] drm/drivers: add support for using the arch
 wc mapping API.
In-Reply-To: <lsq.1538257386.330095874@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:cbab:f00:c93f:614
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.59-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Dave Airlie <airlied@redhat.com>

commit 7cf321d118a825c1541b43ca45294126fd474efa upstream.

This fixes a regression in all these drivers since the cache
mode tracking was fixed for mixed mappings. It uses the new
arch API to add the VRAM range to the PAT mapping tracking
tables.

Fixes: 87744ab3832 (mm: fix cache mode tracking in vm_insert_mixed())
Reviewed-by: Christian König <christian.koenig@amd.com>.
Signed-off-by: Dave Airlie <airlied@redhat.com>
[bwh: Backported to 3.16:
 - Drop changes in amdgpu
 - In nouveau, use struct nouveau_device * and nv_device_resource_{start,len}()
 - Adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/drivers/gpu/drm/ast/ast_ttm.c
+++ b/drivers/gpu/drm/ast/ast_ttm.c
@@ -275,6 +275,8 @@ int ast_mm_init(struct ast_private *ast)
 		return ret;
 	}
 
+	arch_io_reserve_memtype_wc(pci_resource_start(dev->pdev, 0),
+				   pci_resource_len(dev->pdev, 0));
 	ast->fb_mtrr = arch_phys_wc_add(pci_resource_start(dev->pdev, 0),
 					pci_resource_len(dev->pdev, 0));
 
@@ -283,11 +285,15 @@ int ast_mm_init(struct ast_private *ast)
 
 void ast_mm_fini(struct ast_private *ast)
 {
+	struct drm_device *dev = ast->dev;
+
 	ttm_bo_device_release(&ast->ttm.bdev);
 
 	ast_ttm_global_release(ast);
 
 	arch_phys_wc_del(ast->fb_mtrr);
+	arch_io_free_memtype_wc(pci_resource_start(dev->pdev, 0),
+				pci_resource_len(dev->pdev, 0));
 }
 
 void ast_ttm_placement(struct ast_bo *bo, int domain)
--- a/drivers/gpu/drm/cirrus/cirrus_ttm.c
+++ b/drivers/gpu/drm/cirrus/cirrus_ttm.c
@@ -275,6 +275,9 @@ int cirrus_mm_init(struct cirrus_device
 		return ret;
 	}
 
+	arch_io_reserve_memtype_wc(pci_resource_start(dev->pdev, 0),
+				   pci_resource_len(dev->pdev, 0));
+
 	cirrus->fb_mtrr = arch_phys_wc_add(pci_resource_start(dev->pdev, 0),
 					   pci_resource_len(dev->pdev, 0));
 
@@ -284,6 +287,8 @@ int cirrus_mm_init(struct cirrus_device
 
 void cirrus_mm_fini(struct cirrus_device *cirrus)
 {
+	struct drm_device *dev = cirrus->dev;
+
 	if (!cirrus->mm_inited)
 		return;
 
@@ -293,6 +298,8 @@ void cirrus_mm_fini(struct cirrus_device
 
 	arch_phys_wc_del(cirrus->fb_mtrr);
 	cirrus->fb_mtrr = 0;
+	arch_io_free_memtype_wc(pci_resource_start(dev->pdev, 0),
+				pci_resource_len(dev->pdev, 0));
 }
 
 void cirrus_ttm_placement(struct cirrus_bo *bo, int domain)
--- a/drivers/gpu/drm/mgag200/mgag200_ttm.c
+++ b/drivers/gpu/drm/mgag200/mgag200_ttm.c
@@ -274,6 +274,9 @@ int mgag200_mm_init(struct mga_device *m
 		return ret;
 	}
 
+	arch_io_reserve_memtype_wc(pci_resource_start(dev->pdev, 0),
+				   pci_resource_len(dev->pdev, 0));
+
 	mdev->fb_mtrr = arch_phys_wc_add(pci_resource_start(dev->pdev, 0),
 					 pci_resource_len(dev->pdev, 0));
 
@@ -282,10 +285,14 @@ int mgag200_mm_init(struct mga_device *m
 
 void mgag200_mm_fini(struct mga_device *mdev)
 {
+	struct drm_device *dev = mdev->dev;
+
 	ttm_bo_device_release(&mdev->ttm.bdev);
 
 	mgag200_ttm_global_release(mdev);
 
+	arch_io_free_memtype_wc(pci_resource_start(dev->pdev, 0),
+				pci_resource_len(dev->pdev, 0));
 	arch_phys_wc_del(mdev->fb_mtrr);
 	mdev->fb_mtrr = 0;
 }
--- a/drivers/gpu/drm/nouveau/nouveau_ttm.c
+++ b/drivers/gpu/drm/nouveau/nouveau_ttm.c
@@ -397,6 +397,9 @@ nouveau_ttm_init(struct nouveau_drm *drm
 	drm->gem.vram_available  = nouveau_fb(drm->device)->ram->size;
 	drm->gem.vram_available -= nouveau_instmem(drm->device)->reserved;
 
+	arch_io_reserve_memtype_wc(nv_device_resource_start(device, 1),
+				   nv_device_resource_len(device, 1));
+
 	ret = ttm_bo_init_mm(&drm->ttm.bdev, TTM_PL_VRAM,
 			      drm->gem.vram_available >> PAGE_SHIFT);
 	if (ret) {
@@ -429,6 +432,8 @@ nouveau_ttm_init(struct nouveau_drm *drm
 void
 nouveau_ttm_fini(struct nouveau_drm *drm)
 {
+	struct nouveau_device *device = nv_device(drm->device);
+
 	mutex_lock(&drm->dev->struct_mutex);
 	ttm_bo_clean_mm(&drm->ttm.bdev, TTM_PL_VRAM);
 	ttm_bo_clean_mm(&drm->ttm.bdev, TTM_PL_TT);
@@ -440,4 +445,7 @@ nouveau_ttm_fini(struct nouveau_drm *drm
 
 	arch_phys_wc_del(drm->ttm.mtrr);
 	drm->ttm.mtrr = 0;
+	arch_io_free_memtype_wc(nv_device_resource_start(device, 1),
+				nv_device_resource_len(device, 1));
+
 }
--- a/drivers/gpu/drm/radeon/radeon_object.c
+++ b/drivers/gpu/drm/radeon/radeon_object.c
@@ -359,6 +359,10 @@ void radeon_bo_force_delete(struct radeo
 
 int radeon_bo_init(struct radeon_device *rdev)
 {
+	/* reserve PAT memory space to WC for VRAM */
+	arch_io_reserve_memtype_wc(rdev->mc.aper_base,
+				   rdev->mc.aper_size);
+
 	/* Add an MTRR for the VRAM */
 	if (!rdev->fastfb_working) {
 		rdev->mc.vram_mtrr = arch_phys_wc_add(rdev->mc.aper_base,
@@ -376,6 +380,7 @@ void radeon_bo_fini(struct radeon_device
 {
 	radeon_ttm_fini(rdev);
 	arch_phys_wc_del(rdev->mc.vram_mtrr);
+	arch_io_free_memtype_wc(rdev->mc.aper_base, rdev->mc.aper_size);
 }
 
 /* Returns how many bytes TTM can move per IB.

