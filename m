Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43601C67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 11:54:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7ED6208A3
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 11:54:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7ED6208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ispras.ru
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730613AbeG0NQ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 09:16:29 -0400
Received: from bran.ispras.ru ([83.149.199.196]:21735 "EHLO smtp.ispras.ru"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730088AbeG0NQ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 09:16:29 -0400
Received: from myklebust.intra.ispras.ru (unknown [10.10.2.207])
        by smtp.ispras.ru (Postfix) with ESMTP id 6B183203B2;
        Fri, 27 Jul 2018 14:54:52 +0300 (MSK)
From:   Anton Vasilyev <vasilyev@ispras.ru>
To:     Dave Airlie <airlied@redhat.com>
Cc:     Anton Vasilyev <vasilyev@ispras.ru>,
        Gerd Hoffmann <kraxel@redhat.com>,
        David Airlie <airlied@linux.ie>,
        virtualization@lists.linux-foundation.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        ldv-project@linuxtesting.org
Subject: [PATCH] drm: qxl: Fix error handling at qxl_device_init
Date:   Fri, 27 Jul 2018 14:54:40 +0300
Message-Id: <20180727115440.11112-1-vasilyev@ispras.ru>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If qxl_device_init fails on creating resources and does not report it,
then qxl module will catch null pointer exception on remove, or on
probe's error path.

The patch adds error path with resources release into qxl_device_init.

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Anton Vasilyev <vasilyev@ispras.ru>
---
 drivers/gpu/drm/qxl/qxl_kms.c | 80 ++++++++++++++++++++++++++++++++---
 1 file changed, 73 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/qxl/qxl_kms.c b/drivers/gpu/drm/qxl/qxl_kms.c
index 771250aed78d..e25c589d5f50 100644
--- a/drivers/gpu/drm/qxl/qxl_kms.c
+++ b/drivers/gpu/drm/qxl/qxl_kms.c
@@ -102,8 +102,10 @@ int qxl_device_init(struct qxl_device *qdev,
 	int r, sb;
 
 	r = drm_dev_init(&qdev->ddev, drv, &pdev->dev);
-	if (r)
-		return r;
+	if (r) {
+		pr_err("Unable to init drm dev");
+		goto error;
+	}
 
 	qdev->ddev.pdev = pdev;
 	pci_set_drvdata(pdev, &qdev->ddev);
@@ -121,6 +123,11 @@ int qxl_device_init(struct qxl_device *qdev,
 	qdev->io_base = pci_resource_start(pdev, 3);
 
 	qdev->vram_mapping = io_mapping_create_wc(qdev->vram_base, pci_resource_len(pdev, 0));
+	if (!qdev->vram_mapping) {
+		pr_err("Unable to create vram_mapping");
+		r = -ENOMEM;
+		goto error;
+	}
 
 	if (pci_resource_len(pdev, 4) > 0) {
 		/* 64bit surface bar present */
@@ -139,6 +146,11 @@ int qxl_device_init(struct qxl_device *qdev,
 		qdev->surface_mapping =
 			io_mapping_create_wc(qdev->surfaceram_base,
 					     qdev->surfaceram_size);
+		if (!qdev->surface_mapping) {
+			pr_err("Unable to create surface_mapping");
+			r = -ENOMEM;
+			goto vram_mapping_free;
+		}
 	}
 
 	DRM_DEBUG_KMS("qxl: vram %llx-%llx(%dM %dk), surface %llx-%llx(%dM %dk, %s)\n",
@@ -155,20 +167,29 @@ int qxl_device_init(struct qxl_device *qdev,
 	qdev->rom = ioremap(qdev->rom_base, qdev->rom_size);
 	if (!qdev->rom) {
 		pr_err("Unable to ioremap ROM\n");
-		return -ENOMEM;
+		r = -ENOMEM;
+		goto surface_mapping_free;
 	}
 
-	qxl_check_device(qdev);
+	if (!qxl_check_device(qdev)) {
+		r = -ENODEV;
+		goto surface_mapping_free;
+	}
 
 	r = qxl_bo_init(qdev);
 	if (r) {
 		DRM_ERROR("bo init failed %d\n", r);
-		return r;
+		goto rom_unmap;
 	}
 
 	qdev->ram_header = ioremap(qdev->vram_base +
 				   qdev->rom->ram_header_offset,
 				   sizeof(*qdev->ram_header));
+	if (!qdev->ram_header) {
+		DRM_ERROR("Unable to ioremap RAM header\n");
+		r = -ENOMEM;
+		goto bo_fini;
+	}
 
 	qdev->command_ring = qxl_ring_create(&(qdev->ram_header->cmd_ring_hdr),
 					     sizeof(struct qxl_command),
@@ -176,6 +197,11 @@ int qxl_device_init(struct qxl_device *qdev,
 					     qdev->io_base + QXL_IO_NOTIFY_CMD,
 					     false,
 					     &qdev->display_event);
+	if (!qdev->command_ring) {
+		DRM_ERROR("Unable to create command ring\n");
+		r = -ENOMEM;
+		goto ram_header_unmap;
+	}
 
 	qdev->cursor_ring = qxl_ring_create(
 				&(qdev->ram_header->cursor_ring_hdr),
@@ -185,12 +211,23 @@ int qxl_device_init(struct qxl_device *qdev,
 				false,
 				&qdev->cursor_event);
 
+	if (!qdev->cursor_ring) {
+		DRM_ERROR("Unable to create cursor ring\n");
+		r = -ENOMEM;
+		goto command_ring_free;
+	}
+
 	qdev->release_ring = qxl_ring_create(
 				&(qdev->ram_header->release_ring_hdr),
 				sizeof(uint64_t),
 				QXL_RELEASE_RING_SIZE, 0, true,
 				NULL);
 
+	if (!qdev->release_ring) {
+		DRM_ERROR("Unable to create release ring\n");
+		r = -ENOMEM;
+		goto cursor_ring_free;
+	}
 	/* TODO - slot initialization should happen on reset. where is our
 	 * reset handler? */
 	qdev->n_mem_slots = qdev->rom->slots_end;
@@ -203,6 +240,12 @@ int qxl_device_init(struct qxl_device *qdev,
 		kmalloc_array(qdev->n_mem_slots, sizeof(struct qxl_memslot),
 			      GFP_KERNEL);
 
+	if (!qdev->mem_slots) {
+		DRM_ERROR("Unable to alloc mem slots\n");
+		r = -ENOMEM;
+		goto release_ring_free;
+	}
+
 	idr_init(&qdev->release_idr);
 	spin_lock_init(&qdev->release_idr_lock);
 	spin_lock_init(&qdev->release_lock);
@@ -218,8 +261,10 @@ int qxl_device_init(struct qxl_device *qdev,
 
 	/* must initialize irq before first async io - slot creation */
 	r = qxl_irq_init(qdev);
-	if (r)
-		return r;
+	if (r) {
+		DRM_ERROR("Unable to init qxl irq\n");
+		goto mem_slots_free;
+	}
 
 	/*
 	 * Note that virtual is surface0. We rely on the single ioremap done
@@ -243,6 +288,27 @@ int qxl_device_init(struct qxl_device *qdev,
 	INIT_WORK(&qdev->gc_work, qxl_gc_work);
 
 	return 0;
+
+mem_slots_free:
+	kfree(qdev->mem_slots);
+release_ring_free:
+	qxl_ring_free(qdev->release_ring);
+cursor_ring_free:
+	qxl_ring_free(qdev->cursor_ring);
+command_ring_free:
+	qxl_ring_free(qdev->command_ring);
+ram_header_unmap:
+	iounmap(qdev->ram_header);
+bo_fini:
+	qxl_bo_fini(qdev);
+rom_unmap:
+	iounmap(qdev->rom);
+surface_mapping_free:
+	io_mapping_free(qdev->surface_mapping);
+vram_mapping_free:
+	io_mapping_free(qdev->vram_mapping);
+error:
+	return r;
 }
 
 void qxl_device_fini(struct qxl_device *qdev)
-- 
2.18.0

