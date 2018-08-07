Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04BE5C46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 18:59:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE9C920895
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 18:59:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE9C920895
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404563AbeHGVPB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 17:15:01 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:34992 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403958AbeHGVPB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 17:15:01 -0400
Received: from localhost (unknown [194.244.16.108])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 8BCE73EE;
        Tue,  7 Aug 2018 18:59:16 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Anatoly Trosinenko <anatoly.trosinenko@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Phillip Lougher <phillip@squashfs.org.uk>, stable@kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 3.18 65/85] squashfs: be more careful about metadata corruption
Date:   Tue,  7 Aug 2018 20:52:07 +0200
Message-Id: <20180807172359.766468481@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180807172357.357252052@linuxfoundation.org>
References: <20180807172357.357252052@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

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
Cc: stable@kernel.org
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/squashfs/cache.c       |    3 +++
 fs/squashfs/file.c        |    8 ++++++--
 fs/squashfs/fragment.c    |    4 +---
 fs/squashfs/squashfs_fs.h |    6 ++++++
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


