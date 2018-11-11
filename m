Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CFF7C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:10:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49B442080D
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:10:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49B442080D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731592AbeKLGAW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 01:00:22 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:52410 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726471AbeKLGAW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 01:00:22 -0500
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvt8-0000l6-4u; Sun, 11 Nov 2018 19:59:18 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsP-0001SE-VP; Sun, 11 Nov 2018 19:58:33 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Theodore Ts'o" <tytso@mit.edu>
Date:   Sun, 11 Nov 2018 19:49:05 +0000
Message-ID: <lsq.1541965745.788906469@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 077/366] ext4: check if in-inode xattr is corrupted
 in ext4_expand_extra_isize_ea()
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

From: Theodore Ts'o <tytso@mit.edu>

commit 9e92f48c34eb2b9af9d12f892e2fe1fce5e8ce35 upstream.

We aren't checking to see if the in-inode extended attribute is
corrupted before we try to expand the inode's extra isize fields.

This can lead to potential crashes caused by the BUG_ON() check in
ext4_xattr_shift_entries().

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
[bwh: Backported to 3.16: s/EFSCORRUPTED/EIO/]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 fs/ext4/xattr.c | 32 ++++++++++++++++++++++++++++----
 1 file changed, 28 insertions(+), 4 deletions(-)

--- a/fs/ext4/xattr.c
+++ b/fs/ext4/xattr.c
@@ -243,6 +243,27 @@ ext4_xattr_check_block(struct inode *ino
 	return error;
 }
 
+static int
+__xattr_check_inode(struct inode *inode, struct ext4_xattr_ibody_header *header,
+			 void *end, const char *function, unsigned int line)
+{
+	struct ext4_xattr_entry *entry = IFIRST(header);
+	int error = -EIO;
+
+	if (((void *) header >= end) ||
+	    (header->h_magic != le32_to_cpu(EXT4_XATTR_MAGIC)))
+		goto errout;
+	error = ext4_xattr_check_names(entry, end, entry);
+errout:
+	if (error)
+		__ext4_error_inode(inode, function, line, 0,
+				   "corrupted in-inode xattr");
+	return error;
+}
+
+#define xattr_check_inode(inode, header, end) \
+	__xattr_check_inode((inode), (header), (end), __func__, __LINE__)
+
 static inline int
 ext4_xattr_check_entry(struct ext4_xattr_entry *entry, size_t size)
 {
@@ -368,7 +389,7 @@ ext4_xattr_ibody_get(struct inode *inode
 	header = IHDR(inode, raw_inode);
 	entry = IFIRST(header);
 	end = (void *)raw_inode + EXT4_SB(inode->i_sb)->s_inode_size;
-	error = ext4_xattr_check_names(entry, end, entry);
+	error = xattr_check_inode(inode, header, end);
 	if (error)
 		goto cleanup;
 	error = xattr_find_entry(inode, &entry, end, name_index, name,
@@ -506,7 +527,7 @@ ext4_xattr_ibody_list(struct dentry *den
 	raw_inode = ext4_raw_inode(&iloc);
 	header = IHDR(inode, raw_inode);
 	end = (void *)raw_inode + EXT4_SB(inode->i_sb)->s_inode_size;
-	error = ext4_xattr_check_names(IFIRST(header), end, IFIRST(header));
+	error = xattr_check_inode(inode, header, end);
 	if (error)
 		goto cleanup;
 	error = ext4_xattr_list_entries(dentry, IFIRST(header),
@@ -1038,8 +1059,7 @@ int ext4_xattr_ibody_find(struct inode *
 	is->s.here = is->s.first;
 	is->s.end = (void *)raw_inode + EXT4_SB(inode->i_sb)->s_inode_size;
 	if (ext4_test_inode_state(inode, EXT4_STATE_XATTR)) {
-		error = ext4_xattr_check_names(IFIRST(header), is->s.end,
-					       IFIRST(header));
+		error = xattr_check_inode(inode, header, is->s.end);
 		if (error)
 			return error;
 		/* Find the named attribute. */
@@ -1319,6 +1339,10 @@ retry:
 	last = entry;
 	total_ino = sizeof(struct ext4_xattr_ibody_header);
 
+	error = xattr_check_inode(inode, header, end);
+	if (error)
+		goto cleanup;
+
 	free = ext4_xattr_free_space(last, &min_offs, base, &total_ino);
 	if (free >= new_extra_isize) {
 		entry = IFIRST(header);

