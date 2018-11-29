Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2085DC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:27:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D14242145D
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:27:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="x2qy1z9Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D14242145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387585AbeK3Bck (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 20:32:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:60956 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731824AbeK3Bci (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 20:32:38 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 336B32133F;
        Thu, 29 Nov 2018 14:27:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543501625;
        bh=SUYh6AICqaxru1Oy86ZESA6CAQPGv0/QCmdtfnGsgSk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=x2qy1z9Q0rd5PAUHNEJIYG6mGDI1YK4h69RPP4RTFaSZS6K4cwSmfwIHuyltaevlc
         kJzHNMRG6Jzepu089R/wl1IUgsFkFcHub+0qCCrB7MqY1PeGizLK3koQojnRvXgKAh
         UcKvkeNiuWcxILGGuG/lfZ1yX1YXUlxbcaeuyBY0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Richard Weinberger <richard@nod.at>,
        Martin Kepplinger <martin.kepplinger@ginzinger.com>
Subject: [PATCH 4.14 074/100] ubi: fastmap: Check each mapping only once
Date:   Thu, 29 Nov 2018 15:12:44 +0100
Message-Id: <20181129140105.188935124@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181129140058.768942700@linuxfoundation.org>
References: <20181129140058.768942700@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Richard Weinberger <richard@nod.at>

commit 34653fd8c46e771585fce5975e4243f8fd401914 upstream.

Maintain a bitmap to keep track of which LEB->PEB mapping
was checked already.
That way we have to read back VID headers only once.

Fixes: a23cf10d9abb ("ubi: fastmap: Correctly handle interrupted erasures in EBA")
Signed-off-by: Richard Weinberger <richard@nod.at>
Signed-off-by: Martin Kepplinger <martin.kepplinger@ginzinger.com>

---
 drivers/mtd/ubi/build.c   |    1 +
 drivers/mtd/ubi/eba.c     |    4 ++++
 drivers/mtd/ubi/fastmap.c |   20 ++++++++++++++++++++
 drivers/mtd/ubi/ubi.h     |   11 +++++++++++
 drivers/mtd/ubi/vmt.c     |    1 +
 drivers/mtd/ubi/vtbl.c    |   16 +++++++++++++++-
 6 files changed, 52 insertions(+), 1 deletion(-)

--- a/drivers/mtd/ubi/build.c
+++ b/drivers/mtd/ubi/build.c
@@ -526,6 +526,7 @@ void ubi_free_internal_volumes(struct ub
 	for (i = ubi->vtbl_slots;
 	     i < ubi->vtbl_slots + UBI_INT_VOL_COUNT; i++) {
 		ubi_eba_replace_table(ubi->volumes[i], NULL);
+		ubi_fastmap_destroy_checkmap(ubi->volumes[i]);
 		kfree(ubi->volumes[i]);
 	}
 }
--- a/drivers/mtd/ubi/eba.c
+++ b/drivers/mtd/ubi/eba.c
@@ -517,6 +517,9 @@ static int check_mapping(struct ubi_devi
 	if (!ubi->fast_attach)
 		return 0;
 
+	if (!vol->checkmap || test_bit(lnum, vol->checkmap))
+		return 0;
+
 	vidb = ubi_alloc_vid_buf(ubi, GFP_NOFS);
 	if (!vidb)
 		return -ENOMEM;
@@ -551,6 +554,7 @@ static int check_mapping(struct ubi_devi
 		goto out_free;
 	}
 
+	set_bit(lnum, vol->checkmap);
 	err = 0;
 
 out_free:
--- a/drivers/mtd/ubi/fastmap.c
+++ b/drivers/mtd/ubi/fastmap.c
@@ -1101,6 +1101,26 @@ free_fm_sb:
 	goto out;
 }
 
+int ubi_fastmap_init_checkmap(struct ubi_volume *vol, int leb_count)
+{
+	struct ubi_device *ubi = vol->ubi;
+
+	if (!ubi->fast_attach)
+		return 0;
+
+	vol->checkmap = kcalloc(BITS_TO_LONGS(leb_count), sizeof(unsigned long),
+				GFP_KERNEL);
+	if (!vol->checkmap)
+		return -ENOMEM;
+
+	return 0;
+}
+
+void ubi_fastmap_destroy_checkmap(struct ubi_volume *vol)
+{
+	kfree(vol->checkmap);
+}
+
 /**
  * ubi_write_fastmap - writes a fastmap.
  * @ubi: UBI device object
--- a/drivers/mtd/ubi/ubi.h
+++ b/drivers/mtd/ubi/ubi.h
@@ -334,6 +334,9 @@ struct ubi_eba_leb_desc {
  * @changing_leb: %1 if the atomic LEB change ioctl command is in progress
  * @direct_writes: %1 if direct writes are enabled for this volume
  *
+ * @checkmap: bitmap to remember which PEB->LEB mappings got checked,
+ *            protected by UBI LEB lock tree.
+ *
  * The @corrupted field indicates that the volume's contents is corrupted.
  * Since UBI protects only static volumes, this field is not relevant to
  * dynamic volumes - it is user's responsibility to assure their data
@@ -377,6 +380,10 @@ struct ubi_volume {
 	unsigned int updating:1;
 	unsigned int changing_leb:1;
 	unsigned int direct_writes:1;
+
+#ifdef CONFIG_MTD_UBI_FASTMAP
+	unsigned long *checkmap;
+#endif
 };
 
 /**
@@ -965,8 +972,12 @@ size_t ubi_calc_fm_size(struct ubi_devic
 int ubi_update_fastmap(struct ubi_device *ubi);
 int ubi_scan_fastmap(struct ubi_device *ubi, struct ubi_attach_info *ai,
 		     struct ubi_attach_info *scan_ai);
+int ubi_fastmap_init_checkmap(struct ubi_volume *vol, int leb_count);
+void ubi_fastmap_destroy_checkmap(struct ubi_volume *vol);
 #else
 static inline int ubi_update_fastmap(struct ubi_device *ubi) { return 0; }
+int static inline ubi_fastmap_init_checkmap(struct ubi_volume *vol, int leb_count) { return 0; }
+static inline void ubi_fastmap_destroy_checkmap(struct ubi_volume *vol) {}
 #endif
 
 /* block.c */
--- a/drivers/mtd/ubi/vmt.c
+++ b/drivers/mtd/ubi/vmt.c
@@ -139,6 +139,7 @@ static void vol_release(struct device *d
 	struct ubi_volume *vol = container_of(dev, struct ubi_volume, dev);
 
 	ubi_eba_replace_table(vol, NULL);
+	ubi_fastmap_destroy_checkmap(vol);
 	kfree(vol);
 }
 
--- a/drivers/mtd/ubi/vtbl.c
+++ b/drivers/mtd/ubi/vtbl.c
@@ -534,7 +534,7 @@ static int init_volumes(struct ubi_devic
 			const struct ubi_attach_info *ai,
 			const struct ubi_vtbl_record *vtbl)
 {
-	int i, reserved_pebs = 0;
+	int i, err, reserved_pebs = 0;
 	struct ubi_ainf_volume *av;
 	struct ubi_volume *vol;
 
@@ -620,6 +620,16 @@ static int init_volumes(struct ubi_devic
 			(long long)(vol->used_ebs - 1) * vol->usable_leb_size;
 		vol->used_bytes += av->last_data_size;
 		vol->last_eb_bytes = av->last_data_size;
+
+		/*
+		 * We use ubi->peb_count and not vol->reserved_pebs because
+		 * we want to keep the code simple. Otherwise we'd have to
+		 * resize/check the bitmap upon volume resize too.
+		 * Allocating a few bytes more does not hurt.
+		 */
+		err = ubi_fastmap_init_checkmap(vol, ubi->peb_count);
+		if (err)
+			return err;
 	}
 
 	/* And add the layout volume */
@@ -645,6 +655,9 @@ static int init_volumes(struct ubi_devic
 	reserved_pebs += vol->reserved_pebs;
 	ubi->vol_count += 1;
 	vol->ubi = ubi;
+	err = ubi_fastmap_init_checkmap(vol, UBI_LAYOUT_VOLUME_EBS);
+	if (err)
+		return err;
 
 	if (reserved_pebs > ubi->avail_pebs) {
 		ubi_err(ubi, "not enough PEBs, required %d, available %d",
@@ -849,6 +862,7 @@ int ubi_read_volume_table(struct ubi_dev
 out_free:
 	vfree(ubi->vtbl);
 	for (i = 0; i < ubi->vtbl_slots + UBI_INT_VOL_COUNT; i++) {
+		ubi_fastmap_destroy_checkmap(ubi->volumes[i]);
 		kfree(ubi->volumes[i]);
 		ubi->volumes[i] = NULL;
 	}


