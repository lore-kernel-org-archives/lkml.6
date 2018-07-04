Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D260C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 12:42:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B050B208A1
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 12:42:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B050B208A1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934766AbeGDMm3 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 08:42:29 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:41995 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934473AbeGDMmW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 08:42:22 -0400
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <sha@pengutronix.de>)
        id 1fah6m-0001dT-J5; Wed, 04 Jul 2018 14:42:08 +0200
Received: from sha by dude.hi.pengutronix.de with local (Exim 4.91)
        (envelope-from <sha@pengutronix.de>)
        id 1fah6l-0005ZP-IH; Wed, 04 Jul 2018 14:42:07 +0200
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     linux-mtd@lists.infradead.org
Cc:     David Gstir <david@sigma-star.at>,
        Richard Weinberger <richard@nod.at>, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org, Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH 11/25] ubifs: Create functions to embed a HMAC in a node
Date:   Wed,  4 Jul 2018 14:41:23 +0200
Message-Id: <20180704124137.13396-12-s.hauer@pengutronix.de>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180704124137.13396-1-s.hauer@pengutronix.de>
References: <20180704124137.13396-1-s.hauer@pengutronix.de>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::7
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With authentication support some nodes (master node, super block node)
get a HMAC embedded into them. This patch adds functions to prepare and
write such a node.
The difficulty is that besides the HMAC the nodes also have a CRC which
must stay valid. This means we first have to initialize all fields in
the node, then calculate the HMAC (not covering the CRC) and finally
calculate the CRC.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 fs/ubifs/io.c    | 58 +++++++++++++++++++++++++++++++++++++++++++-----
 fs/ubifs/ubifs.h |  4 ++++
 2 files changed, 56 insertions(+), 6 deletions(-)

diff --git a/fs/ubifs/io.c b/fs/ubifs/io.c
index eeb8fb073d33..6f83da07edb1 100644
--- a/fs/ubifs/io.c
+++ b/fs/ubifs/io.c
@@ -394,6 +394,31 @@ void ubifs_crc_node(struct ubifs_info *c, void *node, int len)
 	ch->crc = cpu_to_le32(crc);
 }
 
+/**
+ * ubifs_prepare_node_hmac - prepare node to be written to flash.
+ * @c: UBIFS file-system description object
+ * @node: the node to pad
+ * @len: node length
+ * @hmac_offs: offset of the HMAC in the node
+ * @pad: if the buffer has to be padded
+ *
+ * This function prepares node at @node to be written to the media - it
+ * calculates node CRC, fills the common header, and adds proper padding up to
+ * the next minimum I/O unit if @pad is not zero. if @hmac_offs is positive then
+ * a HMAC is inserted into the node at the given offset.
+ */
+void ubifs_prepare_node_hmac(struct ubifs_info *c, void *node, int len, int hmac_offs,
+			     int pad)
+{
+
+	ubifs_init_node(c, node, len, pad);
+
+	if (hmac_offs > 0)
+		ubifs_node_insert_hmac(c, node, len, hmac_offs);
+
+	ubifs_crc_node(c, node, len);
+}
+
 /**
  * ubifs_prepare_node - prepare node to be written to flash.
  * @c: UBIFS file-system description object
@@ -407,8 +432,7 @@ void ubifs_crc_node(struct ubifs_info *c, void *node, int len)
  */
 void ubifs_prepare_node(struct ubifs_info *c, void *node, int len, int pad)
 {
-	ubifs_init_node(c, node, len, pad);
-	ubifs_crc_node(c, node, len);
+	ubifs_prepare_node_hmac(c, node, len, 0, pad);
 }
 
 /**
@@ -860,12 +884,13 @@ int ubifs_wbuf_write_nolock(struct ubifs_wbuf *wbuf, void *buf, int len)
 }
 
 /**
- * ubifs_write_node - write node to the media.
+ * ubifs_write_node_hmac - write node to the media.
  * @c: UBIFS file-system description object
  * @buf: the node to write
  * @len: node length
  * @lnum: logical eraseblock number
  * @offs: offset within the logical eraseblock
+ * @hmac_offs: offset of the HMAC within the node
  *
  * This function automatically fills node magic number, assigns sequence
  * number, and calculates node CRC checksum. The length of the @buf buffer has
@@ -873,8 +898,8 @@ int ubifs_wbuf_write_nolock(struct ubifs_wbuf *wbuf, void *buf, int len)
  * appends padding node and padding bytes if needed. Returns zero in case of
  * success and a negative error code in case of failure.
  */
-int ubifs_write_node(struct ubifs_info *c, void *buf, int len, int lnum,
-		     int offs)
+int ubifs_write_node_hmac(struct ubifs_info *c, void *buf, int len, int lnum,
+			  int offs, int hmac_offs)
 {
 	int err, buf_len = ALIGN(len, c->min_io_size);
 
@@ -889,7 +914,8 @@ int ubifs_write_node(struct ubifs_info *c, void *buf, int len, int lnum,
 	if (c->ro_error)
 		return -EROFS;
 
-	ubifs_prepare_node(c, buf, len, 1);
+	ubifs_prepare_node_hmac(c, buf, len, hmac_offs, 1);
+
 	err = ubifs_leb_write(c, lnum, buf, offs, buf_len);
 	if (err)
 		ubifs_dump_node(c, buf);
@@ -897,6 +923,26 @@ int ubifs_write_node(struct ubifs_info *c, void *buf, int len, int lnum,
 	return err;
 }
 
+/**
+ * ubifs_write_node - write node to the media.
+ * @c: UBIFS file-system description object
+ * @buf: the node to write
+ * @len: node length
+ * @lnum: logical eraseblock number
+ * @offs: offset within the logical eraseblock
+ *
+ * This function automatically fills node magic number, assigns sequence
+ * number, and calculates node CRC checksum. The length of the @buf buffer has
+ * to be aligned to the minimal I/O unit size. This function automatically
+ * appends padding node and padding bytes if needed. Returns zero in case of
+ * success and a negative error code in case of failure.
+ */
+int ubifs_write_node(struct ubifs_info *c, void *buf, int len, int lnum,
+		     int offs)
+{
+	return ubifs_write_node_hmac(c, buf, len, lnum, offs, -1);
+}
+
 /**
  * ubifs_read_node_wbuf - read node from the media or write-buffer.
  * @wbuf: wbuf to check for un-written data
diff --git a/fs/ubifs/ubifs.h b/fs/ubifs/ubifs.h
index 2086cb8f7115..d8a7276e83df 100644
--- a/fs/ubifs/ubifs.h
+++ b/fs/ubifs/ubifs.h
@@ -1665,11 +1665,15 @@ int ubifs_read_node_wbuf(struct ubifs_wbuf *wbuf, void *buf, int type, int len,
 			 int lnum, int offs);
 int ubifs_write_node(struct ubifs_info *c, void *node, int len, int lnum,
 		     int offs);
+int ubifs_write_node_hmac(struct ubifs_info *c, void *buf, int len, int lnum,
+			  int offs, int hmac_offs);
 int ubifs_check_node(const struct ubifs_info *c, const void *buf, int lnum,
 		     int offs, int quiet, int must_chk_crc);
 void ubifs_init_node(struct ubifs_info *c, void *buf, int len, int pad);
 void ubifs_crc_node(struct ubifs_info *c, void *buf, int len);
 void ubifs_prepare_node(struct ubifs_info *c, void *buf, int len, int pad);
+void ubifs_prepare_node_hmac(struct ubifs_info *c, void *node, int len,
+			     int hmac_offs, int pad);
 void ubifs_prep_grp_node(struct ubifs_info *c, void *node, int len, int last);
 int ubifs_io_init(struct ubifs_info *c);
 void ubifs_pad(const struct ubifs_info *c, void *buf, int pad);
-- 
2.18.0

