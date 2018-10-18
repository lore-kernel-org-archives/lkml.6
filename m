Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D78CFC5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 18:04:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BB682148E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 18:04:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xhxz5Cvz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BB682148E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730056AbeJSCGR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 22:06:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:54586 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728416AbeJSCGQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 22:06:16 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 65834214AB;
        Thu, 18 Oct 2018 18:04:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539885849;
        bh=DqP2wE70HFsIGnPUzSE3MOS6o+iP8EUTH+xEztnwlBo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Xhxz5CvzYsQgDPoTTU7wKSnuglF1+VWufhLGb8TAUKxtSZhTk+gF6MMlQmhWxYLo7
         nJsKdCOzh4/JrkdmVZ2iXdFWcKbBWuBKNP6UOeklEEmTh6nt+NXIcyoRrmsyoMctTY
         YC/OE7fqnfbTzHwcpl7VfS6Z46n9o6Upn2pFCBQQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Theodore Tso <tytso@mit.edu>,
        stable@kernel.org, Chenbo Feng <fengc@google.com>
Subject: [PATCH 4.9 34/35] ext4: avoid running out of journal credits when appending to an inline file
Date:   Thu, 18 Oct 2018 19:55:03 +0200
Message-Id: <20181018175427.528209473@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181018175422.506152522@linuxfoundation.org>
References: <20181018175422.506152522@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Theodore Ts'o <tytso@mit.edu>

commit 8bc1379b82b8e809eef77a9fedbb75c6c297be19 upstream.

Use a separate journal transaction if it turns out that we need to
convert an inline file to use an data block.  Otherwise we could end
up failing due to not having journal credits.

This addresses CVE-2018-10883.

https://bugzilla.kernel.org/show_bug.cgi?id=200071

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Cc: stable@kernel.org
[fengc@google.com: 4.4 and 4.9 backport: adjust context]
Signed-off-by: Chenbo Feng <fengc@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/ext4/ext4.h   |    3 ---
 fs/ext4/inline.c |   38 +-------------------------------------
 fs/ext4/xattr.c  |   18 ++----------------
 3 files changed, 3 insertions(+), 56 deletions(-)

--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -3038,9 +3038,6 @@ extern struct buffer_head *ext4_get_firs
 extern int ext4_inline_data_fiemap(struct inode *inode,
 				   struct fiemap_extent_info *fieinfo,
 				   int *has_inline, __u64 start, __u64 len);
-extern int ext4_try_to_evict_inline_data(handle_t *handle,
-					 struct inode *inode,
-					 int needed);
 extern void ext4_inline_data_truncate(struct inode *inode, int *has_inline);
 
 extern int ext4_convert_inline_data(struct inode *inode);
--- a/fs/ext4/inline.c
+++ b/fs/ext4/inline.c
@@ -889,11 +889,11 @@ retry_journal:
 	flags |= AOP_FLAG_NOFS;
 
 	if (ret == -ENOSPC) {
+		ext4_journal_stop(handle);
 		ret = ext4_da_convert_inline_data_to_extent(mapping,
 							    inode,
 							    flags,
 							    fsdata);
-		ext4_journal_stop(handle);
 		if (ret == -ENOSPC &&
 		    ext4_should_retry_alloc(inode->i_sb, &retries))
 			goto retry_journal;
@@ -1865,42 +1865,6 @@ out:
 	return (error < 0 ? error : 0);
 }
 
-/*
- * Called during xattr set, and if we can sparse space 'needed',
- * just create the extent tree evict the data to the outer block.
- *
- * We use jbd2 instead of page cache to move data to the 1st block
- * so that the whole transaction can be committed as a whole and
- * the data isn't lost because of the delayed page cache write.
- */
-int ext4_try_to_evict_inline_data(handle_t *handle,
-				  struct inode *inode,
-				  int needed)
-{
-	int error;
-	struct ext4_xattr_entry *entry;
-	struct ext4_inode *raw_inode;
-	struct ext4_iloc iloc;
-
-	error = ext4_get_inode_loc(inode, &iloc);
-	if (error)
-		return error;
-
-	raw_inode = ext4_raw_inode(&iloc);
-	entry = (struct ext4_xattr_entry *)((void *)raw_inode +
-					    EXT4_I(inode)->i_inline_off);
-	if (EXT4_XATTR_LEN(entry->e_name_len) +
-	    EXT4_XATTR_SIZE(le32_to_cpu(entry->e_value_size)) < needed) {
-		error = -ENOSPC;
-		goto out;
-	}
-
-	error = ext4_convert_inline_data_nolock(handle, inode, &iloc);
-out:
-	brelse(iloc.bh);
-	return error;
-}
-
 void ext4_inline_data_truncate(struct inode *inode, int *has_inline)
 {
 	handle_t *handle;
--- a/fs/ext4/xattr.c
+++ b/fs/ext4/xattr.c
@@ -1086,22 +1086,8 @@ int ext4_xattr_ibody_inline_set(handle_t
 	if (EXT4_I(inode)->i_extra_isize == 0)
 		return -ENOSPC;
 	error = ext4_xattr_set_entry(i, s, inode);
-	if (error) {
-		if (error == -ENOSPC &&
-		    ext4_has_inline_data(inode)) {
-			error = ext4_try_to_evict_inline_data(handle, inode,
-					EXT4_XATTR_LEN(strlen(i->name) +
-					EXT4_XATTR_SIZE(i->value_len)));
-			if (error)
-				return error;
-			error = ext4_xattr_ibody_find(inode, i, is);
-			if (error)
-				return error;
-			error = ext4_xattr_set_entry(i, s, inode);
-		}
-		if (error)
-			return error;
-	}
+	if (error)
+		return error;
 	header = IHDR(inode, ext4_raw_inode(&is->iloc));
 	if (!IS_LAST_ENTRY(s->first)) {
 		header->h_magic = cpu_to_le32(EXT4_XATTR_MAGIC);


