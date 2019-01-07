Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98652C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 13:02:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 659D3206BB
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 13:02:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546866174;
	bh=35l1QpTf3s/uPFkEsv3Y/Kx29+a2CmutUYO9fvJtqvI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=V3MBj63hIUliev4SgYtid7b5jjKH5NZVWquI9e9RZuONylMi9+ipcZcO1990aVSlW
	 YEpPwkIy7qrVogfQ7bocoZ40k9LiCwu7rXtMPfpTYMnVWzhbNFXpkB1lrOnuwx4Eyz
	 MjYNMaKSA4OUgi+uva8r7OsRLe97ONvRCSPxoBk8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730888AbfAGNCx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 08:02:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:50310 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730870AbfAGNCt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 08:02:49 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 71C1C2089F;
        Mon,  7 Jan 2019 13:02:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546866169;
        bh=35l1QpTf3s/uPFkEsv3Y/Kx29+a2CmutUYO9fvJtqvI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Pli72izIextdnQ3AT07+MY8HQdTjRnNcKYmY0uqxYqwiv90X9YkROEsMPeh1F/0PS
         DbpyNievOYdoX1QbaXuDzl+niUcTTpoR5mzpCKBNe6GsGdM6jGaWy+upXpNeyVmPzw
         drVdeJUqZNqNha/AnT8AfVBjuluOom+OYW0XKxLo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Theodore Tso <tytso@mit.edu>,
        stable@kernel.org
Subject: [PATCH 4.14 068/101] ext4: check for shutdown and r/o file system in ext4_write_inode()
Date:   Mon,  7 Jan 2019 13:32:56 +0100
Message-Id: <20190107105336.696469012@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190107105330.372621917@linuxfoundation.org>
References: <20190107105330.372621917@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -5218,9 +5218,13 @@ int ext4_write_inode(struct inode *inode
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
@@ -5236,7 +5240,8 @@ int ext4_write_inode(struct inode *inode
 		if (wbc->sync_mode != WB_SYNC_ALL || wbc->for_sync)
 			return 0;
 
-		err = ext4_force_commit(inode->i_sb);
+		err = jbd2_complete_transaction(EXT4_SB(inode->i_sb)->s_journal,
+						EXT4_I(inode)->i_sync_tid);
 	} else {
 		struct ext4_iloc iloc;
 


