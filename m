Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30085C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 13:08:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA9322147C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 13:08:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546866507;
	bh=CHPgtDH7ZXbZKuVB01t6vsIbdZN0AA5am8SXR3QL20M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WFbvCqaY+XGxarMP76CSvcWKNTgPC68knpGqJJKzgUoZDS2mzcbUmKm072LAskCA+
	 6902H/qt8jCuGV9XV8wqND15TjQkbgheu8AUoKU7vRFhYJKFFyvNGP2FdS6yCjdTN3
	 JYctPhqllklNwt7H4wzsE7tgbFe2HGmGmKoVepw4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731657AbfAGNI0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 08:08:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:55458 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731629AbfAGNIV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 08:08:21 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 884822089F;
        Mon,  7 Jan 2019 13:08:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546866501;
        bh=CHPgtDH7ZXbZKuVB01t6vsIbdZN0AA5am8SXR3QL20M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LEHewmhSl0arIa5edJTP6l3WzSESrDCkZbORJ54Arl52F+2c2wiZzn7F2I5YtDYnd
         8/YNq+iEPPNIJVsfPIFJOHhi5CtHeGb4L7UNLrZD+7rB2bjx+1C/PVijP7btYBgFaw
         C9Pao36k9/TpiePd8+w+//CWgO8jhYQcPxYSTi2M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Theodore Tso <tytso@mit.edu>,
        stable@kernel.org
Subject: [PATCH 4.9 51/71] ext4: check for shutdown and r/o file system in ext4_write_inode()
Date:   Mon,  7 Jan 2019 13:33:20 +0100
Message-Id: <20190107105335.657090383@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190107105330.280153213@linuxfoundation.org>
References: <20190107105330.280153213@linuxfoundation.org>
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

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -5014,9 +5014,13 @@ int ext4_write_inode(struct inode *inode
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
@@ -5032,7 +5036,8 @@ int ext4_write_inode(struct inode *inode
 		if (wbc->sync_mode != WB_SYNC_ALL || wbc->for_sync)
 			return 0;
 
-		err = ext4_force_commit(inode->i_sb);
+		err = jbd2_complete_transaction(EXT4_SB(inode->i_sb)->s_journal,
+						EXT4_I(inode)->i_sync_tid);
 	} else {
 		struct ext4_iloc iloc;
 


