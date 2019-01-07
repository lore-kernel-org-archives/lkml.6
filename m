Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77582C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:54:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F73320651
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:54:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546865699;
	bh=ilpU2SFC+YuobzqR68Wu1a8YG5vvE0NW5LgluEe2u4Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=iBvNOX9PbWxgdg8cJAPYP5bzoouNUrls89CalxwWxAg0CngRULu/pve+IfAkAwejo
	 pVJvVOO0IYhjRoYeTbbe9VKJ+d5YHYh5vb7hr0v9zgEfHJRCz0weCKiBt2iT9QLj5H
	 rqkB/C2Z8eh3YQCrQUknSSE24xtOHoUC/+9dTSKQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729307AbfAGMy6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 07:54:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:43550 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728296AbfAGMy4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 07:54:56 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8E37C20651;
        Mon,  7 Jan 2019 12:54:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546865695;
        bh=ilpU2SFC+YuobzqR68Wu1a8YG5vvE0NW5LgluEe2u4Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VWCMl4ab/2cpugjiaNUkfvS06rqyZ+B1xlvyOOlPdFc/TRdtc2VUEbSUM0NMMGnbu
         psK/Dx6SCvo2USQfR8rffqJq3SKTs64Uv1J/CW6rQnj3/9ZfDHqRYRguPwv+UEJfKb
         TvxTbs86YZYSrnPPtQkU4N1ta1uEsha9p6qRvJ2w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Theodore Tso <tytso@mit.edu>,
        stable@kernel.org
Subject: [PATCH 4.19 114/170] ext4: check for shutdown and r/o file system in ext4_write_inode()
Date:   Mon,  7 Jan 2019 13:32:21 +0100
Message-Id: <20190107104506.405947594@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190107104452.953560660@linuxfoundation.org>
References: <20190107104452.953560660@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Theodore Ts'o <tytso@mit.edu>

commit 18f2c4fcebf2582f96cbd5f2238f4f354a0e4847 upstream.

If the file system has been shut down or is read-only, then
ext4_write_inode() needs to bail out early.

Also use jbd2_complete_transaction() instead of ext4_force_commit() so
we only force a commit if it is needed.

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Cc: stable@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/ext4/inode.c |    9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -5369,9 +5369,13 @@ int ext4_write_inode(struct inode *inode
 {
 	int err;
 
-	if (WARN_ON_ONCE(current->flags & PF_MEMALLOC))
+	if (WARN_ON_ONCE(current->flags & PF_MEMALLOC) ||
+	    sb_rdonly(inode->i_sb))
 		return 0;
 
+	if (unlikely(ext4_forced_shutdown(EXT4_SB(inode->i_sb))))
+		return -EIO;
+
 	if (EXT4_SB(inode->i_sb)->s_journal) {
 		if (ext4_journal_current_handle()) {
 			jbd_debug(1, "called recursively, non-PF_MEMALLOC!\n");
@@ -5387,7 +5391,8 @@ int ext4_write_inode(struct inode *inode
 		if (wbc->sync_mode != WB_SYNC_ALL || wbc->for_sync)
 			return 0;
 
-		err = ext4_force_commit(inode->i_sb);
+		err = jbd2_complete_transaction(EXT4_SB(inode->i_sb)->s_journal,
+						EXT4_I(inode)->i_sync_tid);
 	} else {
 		struct ext4_iloc iloc;
 


