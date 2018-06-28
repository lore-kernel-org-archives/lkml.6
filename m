Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2019C43142
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 07:42:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A11FC2705B
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 07:42:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A11FC2705B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965222AbeF1HmA (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 03:42:00 -0400
Received: from mail.bootlin.com ([62.4.15.54]:37101 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S964984AbeF1Hl5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 03:41:57 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id A35C120DE2; Thu, 28 Jun 2018 09:41:55 +0200 (CEST)
Received: from localhost.localdomain (AAubervilliers-681-1-87-188.w90-88.abo.wanadoo.fr [90.88.29.188])
        by mail.bootlin.com (Postfix) with ESMTPSA id 9823120DDB;
        Thu, 28 Jun 2018 09:41:32 +0200 (CEST)
From:   Quentin Schulz <quentin.schulz@bootlin.com>
To:     dedekind1@gmail.com, richard@nod.at, dwmw2@infradead.org,
        computersforpeace@gmail.com, boris.brezillon@bootlin.com,
        marek.vasut@gmail.com
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        thomas.petazzoni@bootlin.com,
        Quentin Schulz <quentin.schulz@bootlin.com>
Subject: [PATCH v3 2/2] ubi: expose the volume CRC check skip flag
Date:   Thu, 28 Jun 2018 09:40:53 +0200
Message-Id: <0ace6202bddb495ae0e632ae2fd0346f99fcdab4.1530169759.git-series.quentin.schulz@bootlin.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.6d66955e7c1848c8255870deb42eddb69bd276f3.1530169759.git-series.quentin.schulz@bootlin.com>
References: <cover.6d66955e7c1848c8255870deb42eddb69bd276f3.1530169759.git-series.quentin.schulz@bootlin.com>
In-Reply-To: <cover.6d66955e7c1848c8255870deb42eddb69bd276f3.1530169759.git-series.quentin.schulz@bootlin.com>
References: <cover.6d66955e7c1848c8255870deb42eddb69bd276f3.1530169759.git-series.quentin.schulz@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that we have the logic for skipping CRC check for static UBI volumes
in the core, let's expose it to users.

This makes use of a padding byte in the volume description data
structure as a flag. This flag only tell for now whether we should skip
the CRC check of a volume.

This checks the UBI volume for which we are trying to skip the CRC check
is static.

Suggested-by: Boris Brezillon <boris.brezillon@bootlin.com>
Signed-off-by: Quentin Schulz <quentin.schulz@bootlin.com>
Reviewed-by: Boris Brezillon <boris.brezillon@bootlin.com>
---
 drivers/mtd/ubi/cdev.c      |  4 ++++
 drivers/mtd/ubi/vmt.c       |  3 +++
 include/uapi/mtd/ubi-user.h | 16 ++++++++++++++--
 3 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/ubi/cdev.c b/drivers/mtd/ubi/cdev.c
index 45c3296..3eea1df 100644
--- a/drivers/mtd/ubi/cdev.c
+++ b/drivers/mtd/ubi/cdev.c
@@ -622,6 +622,10 @@ static int verify_mkvol_req(const struct ubi_device *ubi,
 	    req->vol_type != UBI_STATIC_VOLUME)
 		goto bad;
 
+	if (req->flags & UBI_VOL_SKIP_CRC_CHECK_FLG &&
+	    req->vol_type != UBI_STATIC_VOLUME)
+		goto bad;
+
 	if (req->alignment > ubi->leb_size)
 		goto bad;
 
diff --git a/drivers/mtd/ubi/vmt.c b/drivers/mtd/ubi/vmt.c
index e2606a4..729588b 100644
--- a/drivers/mtd/ubi/vmt.c
+++ b/drivers/mtd/ubi/vmt.c
@@ -174,6 +174,9 @@ int ubi_create_volume(struct ubi_device *ubi, struct ubi_mkvol_req *req)
 	vol->dev.class = &ubi_class;
 	vol->dev.groups = volume_dev_groups;
 
+	if (req->flags & UBI_VOL_SKIP_CRC_CHECK_FLG)
+		vol->skip_check = 1;
+
 	spin_lock(&ubi->volumes_lock);
 	if (vol_id == UBI_VOL_NUM_AUTO) {
 		/* Find unused volume ID */
diff --git a/include/uapi/mtd/ubi-user.h b/include/uapi/mtd/ubi-user.h
index 5b04a49..6e5ded5 100644
--- a/include/uapi/mtd/ubi-user.h
+++ b/include/uapi/mtd/ubi-user.h
@@ -285,6 +285,18 @@ struct ubi_attach_req {
 	__s8 padding[10];
 };
 
+/*
+ * UBI volume flags.
+ *
+ * @UBI_VOL_SKIP_CRC_CHECK_FLG: skip the CRC check done on a static volume at
+ *				open time. Only valid for static volumes and
+ *				should only be used if the volume user has a
+ *				way to verify data integrity
+ */
+enum {
+	UBI_VOL_SKIP_CRC_CHECK_FLG = 0x1,
+};
+
 /**
  * struct ubi_mkvol_req - volume description data structure used in
  *                        volume creation requests.
@@ -292,7 +304,7 @@ struct ubi_attach_req {
  * @alignment: volume alignment
  * @bytes: volume size in bytes
  * @vol_type: volume type (%UBI_DYNAMIC_VOLUME or %UBI_STATIC_VOLUME)
- * @padding1: reserved for future, not used, has to be zeroed
+ * @flags: volume flags (%UBI_VOL_SKIP_CRC_CHECK_FLG)
  * @name_len: volume name length
  * @padding2: reserved for future, not used, has to be zeroed
  * @name: volume name
@@ -321,7 +333,7 @@ struct ubi_mkvol_req {
 	__s32 alignment;
 	__s64 bytes;
 	__s8 vol_type;
-	__s8 padding1;
+	__u8 flags;
 	__s16 name_len;
 	__s8 padding2[4];
 	char name[UBI_MAX_VOLUME_NAME + 1];
-- 
git-series 0.9.1
