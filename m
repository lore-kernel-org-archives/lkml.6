Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 366F7C43610
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:27:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02B2020818
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:27:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02B2020818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731717AbeKLGQ6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 01:16:58 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:50790 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730594AbeKLFs0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 00:48:26 -0500
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsk-0000oF-Jw; Sun, 11 Nov 2018 19:58:54 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsY-0001nQ-Nl; Sun, 11 Nov 2018 19:58:42 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org,
        "Phillip Lougher" <phillip@squashfs.org.uk>,
        "Anatoly Trosinenko" <anatoly.trosinenko@gmail.com>,
        "Al Viro" <viro@zeniv.linux.org.uk>,
        "Linus Torvalds" <torvalds@linux-foundation.org>
Date:   Sun, 11 Nov 2018 19:49:05 +0000
Message-ID: <lsq.1541965745.356922265@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 301/366] squashfs: be more careful about metadata
 corruption
In-Reply-To: <lsq.1541965744.387173642@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.61-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Linus Torvalds <torvalds@linux-foundation.org>

commit 01cfb7937a9af2abb1136c7e89fbf3fd92952956 upstream.

Anatoly Trosinenko reports that a corrupted squashfs image can cause a
kernel oops.  It turns out that squashfs can end up being confused about
negative fragment lengths.

The regular squashfs_read_data() does check for negative lengths, but
squashfs_read_metadata() did not, and the fragment size code just
blindly trusted the on-disk value.  Fix both the fragment parsing and
the metadata reading code.

Reported-by: Anatoly Trosinenko <anatoly.trosinenko@gmail.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Phillip Lougher <phillip@squashfs.org.uk>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 fs/squashfs/cache.c       | 3 +++
 fs/squashfs/file.c        | 8 ++++++--
 fs/squashfs/fragment.c    | 4 +---
 fs/squashfs/squashfs_fs.h | 6 ++++++
 4 files changed, 16 insertions(+), 5 deletions(-)

--- a/fs/squashfs/cache.c
+++ b/fs/squashfs/cache.c
@@ -350,6 +350,9 @@ int squashfs_read_metadata(struct super_
 
 	TRACE("Entered squashfs_read_metadata [%llx:%x]\n", *block, *offset);
 
+	if (unlikely(length < 0))
+		return -EIO;
+
 	while (length) {
 		entry = squashfs_cache_get(sb, msblk->block_cache, *block, 0);
 		if (entry->error) {
--- a/fs/squashfs/file.c
+++ b/fs/squashfs/file.c
@@ -194,7 +194,11 @@ static long long read_indexes(struct sup
 		}
 
 		for (i = 0; i < blocks; i++) {
-			int size = le32_to_cpu(blist[i]);
+			int size = squashfs_block_size(blist[i]);
+			if (size < 0) {
+				err = size;
+				goto failure;
+			}
 			block += SQUASHFS_COMPRESSED_SIZE_BLOCK(size);
 		}
 		n -= blocks;
@@ -367,7 +371,7 @@ static int read_blocklist(struct inode *
 			sizeof(size));
 	if (res < 0)
 		return res;
-	return le32_to_cpu(size);
+	return squashfs_block_size(size);
 }
 
 /* Copy data into page cache  */
--- a/fs/squashfs/fragment.c
+++ b/fs/squashfs/fragment.c
@@ -61,9 +61,7 @@ int squashfs_frag_lookup(struct super_bl
 		return size;
 
 	*fragment_block = le64_to_cpu(fragment_entry.start_block);
-	size = le32_to_cpu(fragment_entry.size);
-
-	return size;
+	return squashfs_block_size(fragment_entry.size);
 }
 
 
--- a/fs/squashfs/squashfs_fs.h
+++ b/fs/squashfs/squashfs_fs.h
@@ -129,6 +129,12 @@
 
 #define SQUASHFS_COMPRESSED_BLOCK(B)	(!((B) & SQUASHFS_COMPRESSED_BIT_BLOCK))
 
+static inline int squashfs_block_size(__le32 raw)
+{
+	u32 size = le32_to_cpu(raw);
+	return (size >> 25) ? -EIO : size;
+}
+
 /*
  * Inode number ops.  Inodes consist of a compressed block number, and an
  * uncompressed offset within that block

