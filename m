Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B51C0C65BAF
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:24:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81EA120661
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:24:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81EA120661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728617AbeLIWYT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 17:24:19 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:35046 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726480AbeLIVzS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 16:55:18 -0500
Received: from pub.yeoldevic.com ([81.174.156.145] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW72h-0002im-Ho; Sun, 09 Dec 2018 21:55:15 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW72e-0003Rp-KQ; Sun, 09 Dec 2018 21:55:12 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Wen Xu" <wen.xu@gatech.edu>,
        "Theodore Ts'o" <tytso@mit.edu>
Date:   Sun, 09 Dec 2018 21:50:33 +0000
Message-ID: <lsq.1544392233.91659953@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 169/328] ext4: avoid divide by zero fault when
 deleting corrupted inline directories
In-Reply-To: <lsq.1544392232.713909046@decadent.org.uk>
X-SA-Exim-Connect-IP: 81.174.156.145
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.62-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Theodore Ts'o <tytso@mit.edu>

commit 4d982e25d0bdc83d8c64e66fdeca0b89240b3b85 upstream.

A specially crafted file system can trick empty_inline_dir() into
reading past the last valid entry in a inline directory, and then run
into the end of xattr marker. This will trigger a divide by zero
fault.  Fix this by using the size of the inline directory instead of
dir->i_size.

Also clean up error reporting in __ext4_check_dir_entry so that the
message is clearer and more understandable --- and avoids the division
by zero trap if the size passed in is zero.  (I'm not sure why we
coded it that way in the first place; printing offset % size is
actually more confusing and less useful.)

https://bugzilla.kernel.org/show_bug.cgi?id=200933

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Reported-by: Wen Xu <wen.xu@gatech.edu>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 fs/ext4/dir.c    | 20 +++++++++-----------
 fs/ext4/inline.c |  4 +++-
 2 files changed, 12 insertions(+), 12 deletions(-)

--- a/fs/ext4/dir.c
+++ b/fs/ext4/dir.c
@@ -77,7 +77,7 @@ int __ext4_check_dir_entry(const char *f
 	else if (unlikely(rlen < EXT4_DIR_REC_LEN(de->name_len)))
 		error_msg = "rec_len is too small for name_len";
 	else if (unlikely(((char *) de - buf) + rlen > size))
-		error_msg = "directory entry across range";
+		error_msg = "directory entry overrun";
 	else if (unlikely(le32_to_cpu(de->inode) >
 			le32_to_cpu(EXT4_SB(dir->i_sb)->s_es->s_inodes_count)))
 		error_msg = "inode out of bounds";
@@ -86,18 +86,16 @@ int __ext4_check_dir_entry(const char *f
 
 	if (filp)
 		ext4_error_file(filp, function, line, bh->b_blocknr,
-				"bad entry in directory: %s - offset=%u(%u), "
-				"inode=%u, rec_len=%d, name_len=%d",
-				error_msg, (unsigned) (offset % size),
-				offset, le32_to_cpu(de->inode),
-				rlen, de->name_len);
+				"bad entry in directory: %s - offset=%u, "
+				"inode=%u, rec_len=%d, name_len=%d, size=%d",
+				error_msg, offset, le32_to_cpu(de->inode),
+				rlen, de->name_len, size);
 	else
 		ext4_error_inode(dir, function, line, bh->b_blocknr,
-				"bad entry in directory: %s - offset=%u(%u), "
-				"inode=%u, rec_len=%d, name_len=%d",
-				error_msg, (unsigned) (offset % size),
-				offset, le32_to_cpu(de->inode),
-				rlen, de->name_len);
+				"bad entry in directory: %s - offset=%u, "
+				"inode=%u, rec_len=%d, name_len=%d, size=%d",
+				 error_msg, offset, le32_to_cpu(de->inode),
+				 rlen, de->name_len, size);
 
 	return 1;
 }
--- a/fs/ext4/inline.c
+++ b/fs/ext4/inline.c
@@ -1741,6 +1741,7 @@ int empty_inline_dir(struct inode *dir,
 {
 	int err, inline_size;
 	struct ext4_iloc iloc;
+	size_t inline_len;
 	void *inline_pos;
 	unsigned int offset;
 	struct ext4_dir_entry_2 *de;
@@ -1768,8 +1769,9 @@ int empty_inline_dir(struct inode *dir,
 		goto out;
 	}
 
+	inline_len = ext4_get_inline_size(dir);
 	offset = EXT4_INLINE_DOTDOT_SIZE;
-	while (offset < dir->i_size) {
+	while (offset < inline_len) {
 		de = ext4_get_inline_entry(dir, &iloc, offset,
 					   &inline_pos, &inline_size);
 		if (ext4_check_dir_entry(dir, NULL, de,

