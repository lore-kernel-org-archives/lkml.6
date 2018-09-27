Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20AACC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 09:23:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D95862152F
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 09:23:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D95862152F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728741AbeI0Pks (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 11:40:48 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:56590 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727241AbeI0Pkr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 11:40:47 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 4FC9B1120;
        Thu, 27 Sep 2018 09:23:26 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Theodore Tso <tytso@mit.edu>,
        Wen Xu <wen.xu@gatech.edu>
Subject: [PATCH 4.14 52/64] ext4: avoid divide by zero fault when deleting corrupted inline directories
Date:   Thu, 27 Sep 2018 11:04:09 +0200
Message-Id: <20180927090257.197758325@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180927090249.801943776@linuxfoundation.org>
References: <20180927090249.801943776@linuxfoundation.org>
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
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/ext4/dir.c    |   20 +++++++++-----------
 fs/ext4/inline.c |    4 +++-
 2 files changed, 12 insertions(+), 12 deletions(-)

--- a/fs/ext4/dir.c
+++ b/fs/ext4/dir.c
@@ -75,7 +75,7 @@ int __ext4_check_dir_entry(const char *f
 	else if (unlikely(rlen < EXT4_DIR_REC_LEN(de->name_len)))
 		error_msg = "rec_len is too small for name_len";
 	else if (unlikely(((char *) de - buf) + rlen > size))
-		error_msg = "directory entry across range";
+		error_msg = "directory entry overrun";
 	else if (unlikely(le32_to_cpu(de->inode) >
 			le32_to_cpu(EXT4_SB(dir->i_sb)->s_es->s_inodes_count)))
 		error_msg = "inode out of bounds";
@@ -84,18 +84,16 @@ int __ext4_check_dir_entry(const char *f
 
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
@@ -1759,6 +1759,7 @@ bool empty_inline_dir(struct inode *dir,
 {
 	int err, inline_size;
 	struct ext4_iloc iloc;
+	size_t inline_len;
 	void *inline_pos;
 	unsigned int offset;
 	struct ext4_dir_entry_2 *de;
@@ -1786,8 +1787,9 @@ bool empty_inline_dir(struct inode *dir,
 		goto out;
 	}
 
+	inline_len = ext4_get_inline_size(dir);
 	offset = EXT4_INLINE_DOTDOT_SIZE;
-	while (offset < dir->i_size) {
+	while (offset < inline_len) {
 		de = ext4_get_inline_entry(dir, &iloc, offset,
 					   &inline_pos, &inline_size);
 		if (ext4_check_dir_entry(dir, NULL, de,


