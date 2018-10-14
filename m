Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C572AC7112A
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:42:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BE0E20645
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:42:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BE0E20645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729133AbeJNXXv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 19:23:51 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:36948 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728020AbeJNXXu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 19:23:50 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiMA-0004cU-Mn; Sun, 14 Oct 2018 16:31:02 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLQ-0000Fo-6Q; Sun, 14 Oct 2018 16:30:16 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Theodore Ts'o" <tytso@mit.edu>
Date:   Sun, 14 Oct 2018 16:25:41 +0100
Message-ID: <lsq.1539530741.314837075@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 086/366] ext4: add extra checks to ext4_xattr_block_get()
In-Reply-To: <lsq.1539530740.755408431@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:cbab:f00:c93f:614
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.60-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Theodore Ts'o <tytso@mit.edu>

commit 54dd0e0a1b255f115f8647fc6fb93273251b01b9 upstream.

Add explicit checks in ext4_xattr_block_get() just in case the
e_value_offs and e_value_size fields in the the xattr block are
corrupted in memory after the buffer_verified bit is set on the xattr
block.

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
[bwh: Backported to 3.16:
 - Drop change to ext4_xattr_check_entries() which is only needed for the
   xattr-in-inode case
 - Adjust context, indentation]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/fs/ext4/xattr.c
+++ b/fs/ext4/xattr.c
@@ -327,12 +327,18 @@ bad_block:
 	if (error)
 		goto cleanup;
 	size = le32_to_cpu(entry->e_value_size);
+	error = -ERANGE;
+	if (unlikely(size > EXT4_XATTR_SIZE_MAX))
+		goto cleanup;
 	if (buffer) {
-		error = -ERANGE;
+		u16 offset = le16_to_cpu(entry->e_value_offs);
+		void *p = bh->b_data + offset;
+
 		if (size > buffer_size)
 			goto cleanup;
-		memcpy(buffer, bh->b_data + le16_to_cpu(entry->e_value_offs),
-		       size);
+		if (unlikely(p + size > end))
+			goto cleanup;
+		memcpy(buffer, p, size);
 	}
 	error = size;
 
@@ -370,12 +376,18 @@ ext4_xattr_ibody_get(struct inode *inode
 	if (error)
 		goto cleanup;
 	size = le32_to_cpu(entry->e_value_size);
+	error = -ERANGE;
+	if (unlikely(size > EXT4_XATTR_SIZE_MAX))
+		goto cleanup;
 	if (buffer) {
-		error = -ERANGE;
+		u16 offset = le16_to_cpu(entry->e_value_offs);
+		void *p = (void *)IFIRST(header) + offset;
+
 		if (size > buffer_size)
 			goto cleanup;
-		memcpy(buffer, (void *)IFIRST(header) +
-		       le16_to_cpu(entry->e_value_offs), size);
+		if (unlikely(p + size > end))
+			goto cleanup;
+		memcpy(buffer, p, size);
 	}
 	error = size;
 
--- a/fs/ext4/xattr.h
+++ b/fs/ext4/xattr.h
@@ -67,6 +67,17 @@ struct ext4_xattr_entry {
 		EXT4_I(inode)->i_extra_isize))
 #define IFIRST(hdr) ((struct ext4_xattr_entry *)((hdr)+1))
 
+/*
+ * XATTR_SIZE_MAX is currently 64k, but for the purposes of checking
+ * for file system consistency errors, we use a somewhat bigger value.
+ * This allows XATTR_SIZE_MAX to grow in the future, but by using this
+ * instead of INT_MAX for certain consistency checks, we don't need to
+ * worry about arithmetic overflows.  (Actually XATTR_SIZE_MAX is
+ * defined in include/uapi/linux/limits.h, so changing it is going
+ * not going to be trivial....)
+ */
+#define EXT4_XATTR_SIZE_MAX (1 << 24)
+
 #define BHDR(bh) ((struct ext4_xattr_header *)((bh)->b_data))
 #define ENTRY(ptr) ((struct ext4_xattr_entry *)(ptr))
 #define BFIRST(bh) ENTRY(BHDR(bh)+1)

