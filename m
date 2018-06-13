Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 01370C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 21:25:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4E34208C4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 21:25:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4E34208C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935974AbeFMVZC (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 17:25:02 -0400
Received: from lilium.sigma-star.at ([109.75.188.150]:45450 "EHLO
        lilium.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935928AbeFMVYK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 17:24:10 -0400
Received: from localhost (localhost [127.0.0.1])
        by lilium.sigma-star.at (Postfix) with ESMTP id 99B1518198DC0;
        Wed, 13 Jun 2018 23:24:08 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     linux-mtd@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, Richard Weinberger <richard@nod.at>
Subject: [PATCH 13/14] ubi: Wire up attach mode selector
Date:   Wed, 13 Jun 2018 23:23:43 +0200
Message-Id: <20180613212344.11608-14-richard@nod.at>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180613212344.11608-1-richard@nod.at>
References: <20180613212344.11608-1-richard@nod.at>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now userspace can specify how UBI shall attach.
By default UBI decides how to attach, but userspace can
also force a full scan.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 drivers/mtd/ubi/build.c | 15 ++++++++++++---
 drivers/mtd/ubi/cdev.c  |  7 ++++++-
 drivers/mtd/ubi/ubi.h   |  3 ++-
 3 files changed, 20 insertions(+), 5 deletions(-)

diff --git a/drivers/mtd/ubi/build.c b/drivers/mtd/ubi/build.c
index 1e3f75ede985..7d08b6498b2a 100644
--- a/drivers/mtd/ubi/build.c
+++ b/drivers/mtd/ubi/build.c
@@ -805,6 +805,7 @@ static int autoresize(struct ubi_device *ubi, int vol_id)
  * @ubi_num: number to assign to the new UBI device
  * @vid_hdr_offset: VID header offset
  * @max_beb_per1024: maximum expected number of bad PEB per 1024 PEBs
+ * @attach_mode: selects how to attach
  *
  * This function attaches MTD device @mtd_dev to UBI and assign @ubi_num number
  * to the newly created UBI device, unless @ubi_num is %UBI_DEV_NUM_AUTO, in
@@ -816,10 +817,12 @@ static int autoresize(struct ubi_device *ubi, int vol_id)
  * @ubi_devices_mutex.
  */
 int ubi_attach_mtd_dev(struct mtd_info *mtd, int ubi_num,
-		       int vid_hdr_offset, int max_beb_per1024)
+		       int vid_hdr_offset, int max_beb_per1024,
+		       int attach_mode)
 {
 	struct ubi_device *ubi;
 	int i, err;
+	int do_full_scan = false;
 
 	if (max_beb_per1024 < 0 || max_beb_per1024 > MAX_MTD_UBI_BEB_LIMIT)
 		return -EINVAL;
@@ -957,7 +960,12 @@ int ubi_attach_mtd_dev(struct mtd_info *mtd, int ubi_num,
 	if (!ubi->fm_buf)
 		goto out_free;
 #endif
-	err = ubi_attach(ubi, force_scan);
+	if (force_scan)
+		do_full_scan = 1;
+	else
+		do_full_scan = !!attach_mode;
+
+	err = ubi_attach(ubi, do_full_scan);
 	if (err) {
 		ubi_err(ubi, "failed to attach mtd%d, error %d",
 			mtd->index, err);
@@ -1240,7 +1248,8 @@ static int __init ubi_init(void)
 
 		mutex_lock(&ubi_devices_mutex);
 		err = ubi_attach_mtd_dev(mtd, p->ubi_num,
-					 p->vid_hdr_offs, p->max_beb_per1024);
+					 p->vid_hdr_offs, p->max_beb_per1024,
+					 UBI_ATTACH_MODE_AUTO);
 		mutex_unlock(&ubi_devices_mutex);
 		if (err < 0) {
 			pr_err("UBI error: cannot attach mtd%d\n",
diff --git a/drivers/mtd/ubi/cdev.c b/drivers/mtd/ubi/cdev.c
index 45c329694a5e..cf9b2b00e8c5 100644
--- a/drivers/mtd/ubi/cdev.c
+++ b/drivers/mtd/ubi/cdev.c
@@ -1001,6 +1001,11 @@ static long ctrl_cdev_ioctl(struct file *file, unsigned int cmd,
 			break;
 		}
 
+		if (req.attach_mode < 0 || req.attach_mode > UBI_ATTACH_MODE_MAX) {
+			err = -EINVAL;
+			break;
+		}
+
 		mtd = get_mtd_device(NULL, req.mtd_num);
 		if (IS_ERR(mtd)) {
 			err = PTR_ERR(mtd);
@@ -1013,7 +1018,7 @@ static long ctrl_cdev_ioctl(struct file *file, unsigned int cmd,
 		 */
 		mutex_lock(&ubi_devices_mutex);
 		err = ubi_attach_mtd_dev(mtd, req.ubi_num, req.vid_hdr_offset,
-					 req.max_beb_per1024);
+					 req.max_beb_per1024, req.attach_mode);
 		mutex_unlock(&ubi_devices_mutex);
 		if (err < 0)
 			put_mtd_device(mtd);
diff --git a/drivers/mtd/ubi/ubi.h b/drivers/mtd/ubi/ubi.h
index 28af5115d180..0b2f79f68986 100644
--- a/drivers/mtd/ubi/ubi.h
+++ b/drivers/mtd/ubi/ubi.h
@@ -949,7 +949,8 @@ int ubi_io_write_vid_hdr(struct ubi_device *ubi, int pnum,
 
 /* build.c */
 int ubi_attach_mtd_dev(struct mtd_info *mtd, int ubi_num,
-		       int vid_hdr_offset, int max_beb_per1024);
+		       int vid_hdr_offset, int max_beb_per1024,
+		       int attach_mode);
 int ubi_detach_mtd_dev(int ubi_num, int anyway);
 struct ubi_device *ubi_get_device(int ubi_num);
 void ubi_put_device(struct ubi_device *ubi);
-- 
2.13.6

