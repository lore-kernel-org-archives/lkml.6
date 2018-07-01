Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E6F9C6778A
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 16:27:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3092E251BF
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 16:27:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3092E251BF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965518AbeGAQ13 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 12:27:29 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:34102 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965028AbeGAQ1Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 12:27:25 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 7523DACD;
        Sun,  1 Jul 2018 16:27:24 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, martin bayern <Martinbayern@outlook.com>,
        Richard Weinberger <richard@nod.at>
Subject: [PATCH 4.9 069/101] ubi: fastmap: Correctly handle interrupted erasures in EBA
Date:   Sun,  1 Jul 2018 18:21:55 +0200
Message-Id: <20180701160759.928145668@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180701160757.138608453@linuxfoundation.org>
References: <20180701160757.138608453@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Richard Weinberger <richard@nod.at>

commit 781932375ffc6411713ee0926ccae8596ed0261c upstream.

Fastmap cannot track the LEB unmap operation, therefore it can
happen that after an interrupted erasure the mapping still looks
good from Fastmap's point of view, while reading from the PEB will
cause an ECC error and confuses the upper layer.

Instead of teaching users of UBI how to deal with that, we read back
the VID header and check for errors. If the PEB is empty or shows ECC
errors we fixup the mapping and schedule the PEB for erasure.

Fixes: dbb7d2a88d2a ("UBI: Add fastmap core")
Cc: <stable@vger.kernel.org>
Reported-by: martin bayern <Martinbayern@outlook.com>
Signed-off-by: Richard Weinberger <richard@nod.at>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/mtd/ubi/eba.c |   90 +++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 89 insertions(+), 1 deletion(-)

--- a/drivers/mtd/ubi/eba.c
+++ b/drivers/mtd/ubi/eba.c
@@ -490,6 +490,82 @@ out_unlock:
 	return err;
 }
 
+#ifdef CONFIG_MTD_UBI_FASTMAP
+/**
+ * check_mapping - check and fixup a mapping
+ * @ubi: UBI device description object
+ * @vol: volume description object
+ * @lnum: logical eraseblock number
+ * @pnum: physical eraseblock number
+ *
+ * Checks whether a given mapping is valid. Fastmap cannot track LEB unmap
+ * operations, if such an operation is interrupted the mapping still looks
+ * good, but upon first read an ECC is reported to the upper layer.
+ * Normaly during the full-scan at attach time this is fixed, for Fastmap
+ * we have to deal with it while reading.
+ * If the PEB behind a LEB shows this symthom we change the mapping to
+ * %UBI_LEB_UNMAPPED and schedule the PEB for erasure.
+ *
+ * Returns 0 on success, negative error code in case of failure.
+ */
+static int check_mapping(struct ubi_device *ubi, struct ubi_volume *vol, int lnum,
+			 int *pnum)
+{
+	int err;
+	struct ubi_vid_io_buf *vidb;
+
+	if (!ubi->fast_attach)
+		return 0;
+
+	vidb = ubi_alloc_vid_buf(ubi, GFP_NOFS);
+	if (!vidb)
+		return -ENOMEM;
+
+	err = ubi_io_read_vid_hdr(ubi, *pnum, vidb, 0);
+	if (err > 0 && err != UBI_IO_BITFLIPS) {
+		int torture = 0;
+
+		switch (err) {
+			case UBI_IO_FF:
+			case UBI_IO_FF_BITFLIPS:
+			case UBI_IO_BAD_HDR:
+			case UBI_IO_BAD_HDR_EBADMSG:
+				break;
+			default:
+				ubi_assert(0);
+		}
+
+		if (err == UBI_IO_BAD_HDR_EBADMSG || err == UBI_IO_FF_BITFLIPS)
+			torture = 1;
+
+		down_read(&ubi->fm_eba_sem);
+		vol->eba_tbl->entries[lnum].pnum = UBI_LEB_UNMAPPED;
+		up_read(&ubi->fm_eba_sem);
+		ubi_wl_put_peb(ubi, vol->vol_id, lnum, *pnum, torture);
+
+		*pnum = UBI_LEB_UNMAPPED;
+	} else if (err < 0) {
+		ubi_err(ubi, "unable to read VID header back from PEB %i: %i",
+			*pnum, err);
+
+		goto out_free;
+	}
+
+	err = 0;
+
+out_free:
+	ubi_free_vid_buf(vidb);
+
+	return err;
+}
+#else
+static int check_mapping(struct ubi_device *ubi, struct ubi_volume *vol, int lnum,
+		  int *pnum)
+{
+	return 0;
+}
+#endif
+
 /**
  * ubi_eba_read_leb - read data.
  * @ubi: UBI device description object
@@ -522,7 +598,13 @@ int ubi_eba_read_leb(struct ubi_device *
 		return err;
 
 	pnum = vol->eba_tbl->entries[lnum].pnum;
-	if (pnum < 0) {
+	if (pnum >= 0) {
+		err = check_mapping(ubi, vol, lnum, &pnum);
+		if (err < 0)
+			goto out_unlock;
+	}
+
+	if (pnum == UBI_LEB_UNMAPPED) {
 		/*
 		 * The logical eraseblock is not mapped, fill the whole buffer
 		 * with 0xFF bytes. The exception is static volumes for which
@@ -931,6 +1013,12 @@ int ubi_eba_write_leb(struct ubi_device
 
 	pnum = vol->eba_tbl->entries[lnum].pnum;
 	if (pnum >= 0) {
+		err = check_mapping(ubi, vol, lnum, &pnum);
+		if (err < 0)
+			goto out;
+	}
+
+	if (pnum >= 0) {
 		dbg_eba("write %d bytes at offset %d of LEB %d:%d, PEB %d",
 			len, offset, vol_id, lnum, pnum);
 


