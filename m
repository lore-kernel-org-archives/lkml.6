Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38186C7112A
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:51:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0827B20645
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:51:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0827B20645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728043AbeJNXMA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 19:12:00 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:36159 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727993AbeJNXL7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 19:11:59 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLm-0004cC-5s; Sun, 14 Oct 2018 16:30:38 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLY-0000dV-L0; Sun, 14 Oct 2018 16:30:24 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Al Viro" <viro@zeniv.linux.org.uk>
Date:   Sun, 14 Oct 2018 16:25:41 +0100
Message-ID: <lsq.1539530741.925553633@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 290/366] ufs: deal with nfsd/iget races
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

From: Al Viro <viro@zeniv.linux.org.uk>

commit e4502c63f56aeca887ced37f24e0def1ef11cec8 upstream.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 fs/ufs/ialloc.c | 6 +++++-
 fs/ufs/namei.c  | 4 ++++
 2 files changed, 9 insertions(+), 1 deletion(-)

--- a/fs/ufs/ialloc.c
+++ b/fs/ufs/ialloc.c
@@ -298,7 +298,10 @@ cg_found:
 	ufsi->i_oeftflag = 0;
 	ufsi->i_dir_start_lookup = 0;
 	memset(&ufsi->i_u1, 0, sizeof(ufsi->i_u1));
-	insert_inode_hash(inode);
+	if (insert_inode_locked(inode) < 0) {
+		err = -EIO;
+		goto failed;
+	}
 	mark_inode_dirty(inode);
 
 	if (uspi->fs_magic == UFS2_MAGIC) {
@@ -337,6 +340,7 @@ cg_found:
 fail_remove_inode:
 	mutex_unlock(&sbi->s_lock);
 	clear_nlink(inode);
+	unlock_new_inode(inode);
 	iput(inode);
 	UFSD("EXIT (FAILED): err %d\n", err);
 	return ERR_PTR(err);
--- a/fs/ufs/namei.c
+++ b/fs/ufs/namei.c
@@ -38,10 +38,12 @@ static inline int ufs_add_nondir(struct
 {
 	int err = ufs_add_link(dentry, inode);
 	if (!err) {
+		unlock_new_inode(inode);
 		d_instantiate(dentry, inode);
 		return 0;
 	}
 	inode_dec_link_count(inode);
+	unlock_new_inode(inode);
 	iput(inode);
 	return err;
 }
@@ -155,6 +157,7 @@ out_notlocked:
 
 out_fail:
 	inode_dec_link_count(inode);
+	unlock_new_inode(inode);
 	iput(inode);
 	goto out;
 }
@@ -211,6 +214,7 @@ out:
 out_fail:
 	inode_dec_link_count(inode);
 	inode_dec_link_count(inode);
+	unlock_new_inode(inode);
 	iput (inode);
 out_dir:
 	inode_dec_link_count(dir);

