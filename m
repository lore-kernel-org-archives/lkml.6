Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65689C6778C
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 12:47:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EDAE208A1
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 12:47:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EDAE208A1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752816AbeGDMrE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 08:47:04 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:45967 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934563AbeGDMmX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 08:42:23 -0400
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <sha@pengutronix.de>)
        id 1fah6m-0001dR-Nj; Wed, 04 Jul 2018 14:42:08 +0200
Received: from sha by dude.hi.pengutronix.de with local (Exim 4.91)
        (envelope-from <sha@pengutronix.de>)
        id 1fah6l-0005ZA-HD; Wed, 04 Jul 2018 14:42:07 +0200
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     linux-mtd@lists.infradead.org
Cc:     David Gstir <david@sigma-star.at>,
        Richard Weinberger <richard@nod.at>, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org, Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH 09/25] ubifs: add separate functions to init/crc a node
Date:   Wed,  4 Jul 2018 14:41:21 +0200
Message-Id: <20180704124137.13396-10-s.hauer@pengutronix.de>
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

When adding authentication support we will embed a HMAC into some
nodes. To prepare these nodes we have to first initialize the nodes,
then add a HMAC and finally add a CRC. To accomplish this add separate
ubifs_init_node/ubifs_crc_node functions.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 fs/ubifs/io.c    | 42 +++++++++++++++++++++++++++---------------
 fs/ubifs/ubifs.h |  2 ++
 2 files changed, 29 insertions(+), 15 deletions(-)

diff --git a/fs/ubifs/io.c b/fs/ubifs/io.c
index fe77e9625e84..eeb8fb073d33 100644
--- a/fs/ubifs/io.c
+++ b/fs/ubifs/io.c
@@ -365,20 +365,8 @@ static unsigned long long next_sqnum(struct ubifs_info *c)
 	return sqnum;
 }
 
-/**
- * ubifs_prepare_node - prepare node to be written to flash.
- * @c: UBIFS file-system description object
- * @node: the node to pad
- * @len: node length
- * @pad: if the buffer has to be padded
- *
- * This function prepares node at @node to be written to the media - it
- * calculates node CRC, fills the common header, and adds proper padding up to
- * the next minimum I/O unit if @pad is not zero.
- */
-void ubifs_prepare_node(struct ubifs_info *c, void *node, int len, int pad)
+void ubifs_init_node(struct ubifs_info *c, void *node, int len, int pad)
 {
-	uint32_t crc;
 	struct ubifs_ch *ch = node;
 	unsigned long long sqnum = next_sqnum(c);
 
@@ -389,8 +377,6 @@ void ubifs_prepare_node(struct ubifs_info *c, void *node, int len, int pad)
 	ch->group_type = UBIFS_NO_NODE_GROUP;
 	ch->sqnum = cpu_to_le64(sqnum);
 	ch->padding[0] = ch->padding[1] = 0;
-	crc = crc32(UBIFS_CRC32_INIT, node + 8, len - 8);
-	ch->crc = cpu_to_le32(crc);
 
 	if (pad) {
 		len = ALIGN(len, 8);
@@ -399,6 +385,32 @@ void ubifs_prepare_node(struct ubifs_info *c, void *node, int len, int pad)
 	}
 }
 
+void ubifs_crc_node(struct ubifs_info *c, void *node, int len)
+{
+	struct ubifs_ch *ch = node;
+	uint32_t crc;
+
+	crc = crc32(UBIFS_CRC32_INIT, node + 8, len - 8);
+	ch->crc = cpu_to_le32(crc);
+}
+
+/**
+ * ubifs_prepare_node - prepare node to be written to flash.
+ * @c: UBIFS file-system description object
+ * @node: the node to pad
+ * @len: node length
+ * @pad: if the buffer has to be padded
+ *
+ * This function prepares node at @node to be written to the media - it
+ * calculates node CRC, fills the common header, and adds proper padding up to
+ * the next minimum I/O unit if @pad is not zero.
+ */
+void ubifs_prepare_node(struct ubifs_info *c, void *node, int len, int pad)
+{
+	ubifs_init_node(c, node, len, pad);
+	ubifs_crc_node(c, node, len);
+}
+
 /**
  * ubifs_prep_grp_node - prepare node of a group to be written to flash.
  * @c: UBIFS file-system description object
diff --git a/fs/ubifs/ubifs.h b/fs/ubifs/ubifs.h
index 92574045e030..485de4e27f96 100644
--- a/fs/ubifs/ubifs.h
+++ b/fs/ubifs/ubifs.h
@@ -1480,6 +1480,8 @@ int ubifs_write_node(struct ubifs_info *c, void *node, int len, int lnum,
 		     int offs);
 int ubifs_check_node(const struct ubifs_info *c, const void *buf, int lnum,
 		     int offs, int quiet, int must_chk_crc);
+void ubifs_init_node(struct ubifs_info *c, void *buf, int len, int pad);
+void ubifs_crc_node(struct ubifs_info *c, void *buf, int len);
 void ubifs_prepare_node(struct ubifs_info *c, void *buf, int len, int pad);
 void ubifs_prep_grp_node(struct ubifs_info *c, void *node, int len, int last);
 int ubifs_io_init(struct ubifs_info *c);
-- 
2.18.0

