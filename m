Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30EF8C7112A
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:43:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00C1F20876
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:43:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00C1F20876
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729191AbeJNXYk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 19:24:40 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:36996 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728020AbeJNXYj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 19:24:39 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiMA-0004cI-Lm; Sun, 14 Oct 2018 16:31:02 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLQ-0000Fi-4x; Sun, 14 Oct 2018 16:30:16 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Eric Biggers" <ebiggers@google.com>,
        "Theodore Ts'o" <tytso@mit.edu>
Date:   Sun, 14 Oct 2018 16:25:41 +0100
Message-ID: <lsq.1539530741.925379379@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 085/366] ext4: correctly detect when an xattr value
 has an invalid size
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

From: Eric Biggers <ebiggers@google.com>

commit d7614cc16146e3f0b4c33e71875c19607602aed5 upstream.

It was possible for an xattr value to have a very large size, which
would then pass validation on 32-bit architectures due to a pointer
wraparound.  Fix this by validating the size in a way which avoids
pointer wraparound.

It was also possible that a value's size would fit in the available
space but its padded size would not.  This would cause an out-of-bounds
memory write in ext4_xattr_set_entry when replacing the xattr value.
For example, if an xattr value of unpadded size 253 bytes went until the
very end of the inode or block, then using setxattr(2) to replace this
xattr's value with 256 bytes would cause a write to the 3 bytes past the
end of the inode or buffer, and the new xattr value would be incorrectly
truncated.  Fix this by requiring that the padded size fit in the
available space rather than the unpadded size.

This patch shouldn't have any noticeable effect on
non-corrupted/non-malicious filesystems.

Signed-off-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
[bwh: Backported to 3.16:
 - s/EFSCORRUPTED/EIO/
 - Adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 fs/ext4/xattr.c | 27 +++++++++++++++++++++------
 1 file changed, 21 insertions(+), 6 deletions(-)

--- a/fs/ext4/xattr.c
+++ b/fs/ext4/xattr.c
@@ -188,6 +188,7 @@ ext4_xattr_check_names(struct ext4_xattr
 {
 	struct ext4_xattr_entry *e = entry;
 
+	/* Find the end of the names list */
 	while (!IS_LAST_ENTRY(e)) {
 		struct ext4_xattr_entry *next = EXT4_XATTR_NEXT(e);
 		if ((void *)next >= end)
@@ -195,13 +196,27 @@ ext4_xattr_check_names(struct ext4_xattr
 		e = next;
 	}
 
+	/* Check the values */
 	while (!IS_LAST_ENTRY(entry)) {
-		if (entry->e_value_size != 0 &&
-		    (value_start + le16_to_cpu(entry->e_value_offs) <
-		     (void *)e + sizeof(__u32) ||
-		     value_start + le16_to_cpu(entry->e_value_offs) +
-		    le32_to_cpu(entry->e_value_size) > end))
-			return -EIO;
+		if (entry->e_value_size != 0) {
+			u16 offs = le16_to_cpu(entry->e_value_offs);
+			u32 size = le32_to_cpu(entry->e_value_size);
+			void *value;
+
+			/*
+			 * The value cannot overlap the names, and the value
+			 * with padding cannot extend beyond 'end'.  Check both
+			 * the padded and unpadded sizes, since the size may
+			 * overflow to 0 when adding padding.
+			 */
+			if (offs > end - value_start)
+				return -EIO;
+			value = value_start + offs;
+			if (value < (void *)e + sizeof(u32) ||
+			    size > end - value ||
+			    EXT4_XATTR_SIZE(size) > end - value)
+				return -EIO;
+		}
 		entry = EXT4_XATTR_NEXT(entry);
 	}
 

