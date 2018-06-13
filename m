Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.1 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 62F73C004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 21:25:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24A31208C4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 21:25:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24A31208C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936033AbeFMVZG (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 17:25:06 -0400
Received: from lilium.sigma-star.at ([109.75.188.150]:45412 "EHLO
        lilium.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935846AbeFMVYI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 17:24:08 -0400
Received: from localhost (localhost [127.0.0.1])
        by lilium.sigma-star.at (Postfix) with ESMTP id 286E918198DC2;
        Wed, 13 Jun 2018 23:24:07 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     linux-mtd@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, Richard Weinberger <richard@nod.at>
Subject: [PATCH 11/14] ubi: Add module parameter to force a full scan
Date:   Wed, 13 Jun 2018 23:23:41 +0200
Message-Id: <20180613212344.11608-12-richard@nod.at>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180613212344.11608-1-richard@nod.at>
References: <20180613212344.11608-1-richard@nod.at>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using this parameter one can force UBI do to a full scan
instead of using a fastmap.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 drivers/mtd/ubi/attach.c | 13 +++++++++----
 drivers/mtd/ubi/build.c  |  5 ++++-
 2 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/mtd/ubi/attach.c b/drivers/mtd/ubi/attach.c
index 9a8072cf458c..134b15f093c3 100644
--- a/drivers/mtd/ubi/attach.c
+++ b/drivers/mtd/ubi/attach.c
@@ -925,7 +925,7 @@ static int check_corruption(struct ubi_device *ubi, struct ubi_vid_hdr *vid_hdr,
 	return err;
 }
 
-static bool vol_ignored(int vol_id)
+static bool vol_ignored(struct ubi_attach_info *ai, int vol_id)
 {
 	switch (vol_id) {
 		case UBI_LAYOUT_VOLUME_ID:
@@ -933,6 +933,9 @@ static bool vol_ignored(int vol_id)
 	}
 
 #ifdef CONFIG_MTD_UBI_FASTMAP
+	if (ai->force_full_scan)
+		return false;
+
 	return ubi_is_fm_vol(vol_id);
 #else
 	return false;
@@ -1143,7 +1146,7 @@ static int scan_peb(struct ubi_device *ubi, struct ubi_attach_info *ai,
 	}
 
 	vol_id = be32_to_cpu(vidh->vol_id);
-	if (vol_id > UBI_MAX_VOLUMES && !vol_ignored(vol_id)) {
+	if (vol_id > UBI_MAX_VOLUMES && !vol_ignored(ai, vol_id)) {
 		int lnum = be32_to_cpu(vidh->lnum);
 
 		/* Unsupported internal volume */
@@ -1581,9 +1584,11 @@ int ubi_attach(struct ubi_device *ubi, int force_scan)
 		force_scan = 1;
 	}
 
-	if (force_scan)
+	if (force_scan) {
+		ubi_msg(ubi, "full scan forced");
+		ai->force_full_scan = 1;
 		err = scan_all(ubi, ai, 0);
-	else {
+	} else {
 		err = scan_fast(ubi, &ai);
 		if (err > 0 || mtd_is_eccerr(err)) {
 			if (err != UBI_NO_FASTMAP) {
diff --git a/drivers/mtd/ubi/build.c b/drivers/mtd/ubi/build.c
index d2a726654ff1..1e3f75ede985 100644
--- a/drivers/mtd/ubi/build.c
+++ b/drivers/mtd/ubi/build.c
@@ -83,6 +83,7 @@ static struct mtd_dev_param mtd_dev_param[UBI_MAX_DEVICES];
 static bool fm_autoconvert;
 static bool fm_debug;
 #endif
+static bool force_scan;
 
 /* Slab cache for wear-leveling entries */
 struct kmem_cache *ubi_wl_entry_slab;
@@ -956,7 +957,7 @@ int ubi_attach_mtd_dev(struct mtd_info *mtd, int ubi_num,
 	if (!ubi->fm_buf)
 		goto out_free;
 #endif
-	err = ubi_attach(ubi, 0);
+	err = ubi_attach(ubi, force_scan);
 	if (err) {
 		ubi_err(ubi, "failed to attach mtd%d, error %d",
 			mtd->index, err);
@@ -1458,6 +1459,8 @@ module_param(fm_autoconvert, bool, 0644);
 MODULE_PARM_DESC(fm_autoconvert, "Set this parameter to enable fastmap automatically on images without a fastmap.");
 module_param(fm_debug, bool, 0);
 MODULE_PARM_DESC(fm_debug, "Set this parameter to enable fastmap debugging by default. Warning, this will make fastmap slow!");
+module_param(force_scan, bool, 0644);
+MODULE_PARM_DESC(force_scan, "Always do a full scan of the MTD and drop possible fastmap structures from the MTD.");
 #endif
 MODULE_VERSION(__stringify(UBI_VERSION));
 MODULE_DESCRIPTION("UBI - Unsorted Block Images");
-- 
2.13.6

