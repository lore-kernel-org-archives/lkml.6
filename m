Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8B03C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 13:05:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 896FF2147C
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 13:05:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728008AbfBTNFW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 08:05:22 -0500
Received: from xavier.telenet-ops.be ([195.130.132.52]:35972 "EHLO
        xavier.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726455AbfBTNFW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 08:05:22 -0500
Received: from ramsan ([84.194.111.163])
        by xavier.telenet-ops.be with bizsmtp
        id f15K1z0073XaVaC0115Koi; Wed, 20 Feb 2019 14:05:19 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1gwRYt-0001UR-6k; Wed, 20 Feb 2019 14:05:19 +0100
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1gwRYt-0000K6-4f; Wed, 20 Feb 2019 14:05:19 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Gary R Hook <gary.hook@amd.com>, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] iommu: Fix IOMMU debugfs fallout
Date:   Wed, 20 Feb 2019 14:05:05 +0100
Message-Id: <20190220130505.1188-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A change made in the final version of IOMMU debugfs support replaced the
public function iommu_debugfs_new_driver_dir() by the public dentry
iommu_debugfs_dir in <linux/iommu.h>, but forgot to update both the
implementation in iommu-debugfs.c, and the patch description.

Fix this by exporting iommu_debugfs_dir, and removing the reference to
and implementation of iommu_debugfs_new_driver_dir().

Fixes: bad614b24293ae46 ("iommu: Enable debugfs exposure of IOMMU driver internals")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/iommu/iommu-debugfs.c | 23 ++++-------------------
 1 file changed, 4 insertions(+), 19 deletions(-)

diff --git a/drivers/iommu/iommu-debugfs.c b/drivers/iommu/iommu-debugfs.c
index 3b1bf88fd1b0494a..f0354894209648fd 100644
--- a/drivers/iommu/iommu-debugfs.c
+++ b/drivers/iommu/iommu-debugfs.c
@@ -12,6 +12,7 @@
 #include <linux/debugfs.h>
 
 struct dentry *iommu_debugfs_dir;
+EXPORT_SYMBOL_GPL(iommu_debugfs_dir);
 
 /**
  * iommu_debugfs_setup - create the top-level iommu directory in debugfs
@@ -23,9 +24,9 @@ struct dentry *iommu_debugfs_dir;
  * Emit a strong warning at boot time to indicate that this feature is
  * enabled.
  *
- * This function is called from iommu_init; drivers may then call
- * iommu_debugfs_new_driver_dir() to instantiate a vendor-specific
- * directory to be used to expose internal data.
+ * This function is called from iommu_init; drivers may then use
+ * iommu_debugfs_dir to instantiate a vendor-specific directory to be used
+ * to expose internal data.
  */
 void iommu_debugfs_setup(void)
 {
@@ -48,19 +49,3 @@ void iommu_debugfs_setup(void)
 		pr_warn("*************************************************************\n");
 	}
 }
-
-/**
- * iommu_debugfs_new_driver_dir - create a vendor directory under debugfs/iommu
- * @vendor: name of the vendor-specific subdirectory to create
- *
- * This function is called by an IOMMU driver to create the top-level debugfs
- * directory for that driver.
- *
- * Return: upon success, a pointer to the dentry for the new directory.
- *         NULL in case of failure.
- */
-struct dentry *iommu_debugfs_new_driver_dir(const char *vendor)
-{
-	return debugfs_create_dir(vendor, iommu_debugfs_dir);
-}
-EXPORT_SYMBOL_GPL(iommu_debugfs_new_driver_dir);
-- 
2.17.1

