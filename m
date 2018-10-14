Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15558C7112A
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:41:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D980E20645
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:41:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D980E20645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728087AbeJNXMB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 19:12:01 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:36153 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727989AbeJNXL7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 19:11:59 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLm-0004cI-5u; Sun, 14 Oct 2018 16:30:38 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLY-0000dB-Ie; Sun, 14 Oct 2018 16:30:24 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Al Viro" <viro@zeniv.linux.org.uk>,
        "Jan Kara" <jack@suse.cz>
Date:   Sun, 14 Oct 2018 16:25:41 +0100
Message-ID: <lsq.1539530741.903928293@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 289/366] udf: fix the udf_iget() vs. udf_new_inode()
 races
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

commit b231509616feb911c2a7a8814d58c0014ef5b17f upstream.

Currently udf_iget() (triggered by NFS) can race with udf_new_inode()
leading to two inode structures with the same inode number:

nfsd: iget_locked() creates inode
nfsd: try to read from disk, block on that.
udf_new_inode(): allocate inode with that inumber
udf_new_inode(): insert it into icache, set it up and dirty
udf_write_inode(): write inode into buffer cache
nfsd: get CPU again, look into buffer cache, see nice and sane on-disk
  inode, set the in-core inode from it

Fix the problem by putting inode into icache in locked state (I_NEW set)
and unlocking it only after it's fully set up.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Jan Kara <jack@suse.cz>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 fs/udf/ialloc.c | 7 ++++++-
 fs/udf/namei.c  | 7 +++++++
 2 files changed, 13 insertions(+), 1 deletion(-)

--- a/fs/udf/ialloc.c
+++ b/fs/udf/ialloc.c
@@ -123,7 +123,12 @@ struct inode *udf_new_inode(struct inode
 		iinfo->i_alloc_type = ICBTAG_FLAG_AD_LONG;
 	inode->i_mtime = inode->i_atime = inode->i_ctime =
 		iinfo->i_crtime = current_fs_time(inode->i_sb);
-	insert_inode_hash(inode);
+	if (unlikely(insert_inode_locked(inode) < 0)) {
+		make_bad_inode(inode);
+		iput(inode);
+		*err = -EIO;
+		return NULL;
+	}
 	mark_inode_dirty(inode);
 
 	*err = 0;
--- a/fs/udf/namei.c
+++ b/fs/udf/namei.c
@@ -562,6 +562,7 @@ static int udf_add_nondir(struct dentry
 	fi = udf_add_entry(dir, dentry, &fibh, &cfi, &err);
 	if (unlikely(!fi)) {
 		inode_dec_link_count(inode);
+		unlock_new_inode(inode);
 		iput(inode);
 		return err;
 	}
@@ -575,6 +576,7 @@ static int udf_add_nondir(struct dentry
 	if (fibh.sbh != fibh.ebh)
 		brelse(fibh.ebh);
 	brelse(fibh.sbh);
+	unlock_new_inode(inode);
 	d_instantiate(dentry, inode);
 
 	return 0;
@@ -622,6 +624,7 @@ static int udf_tmpfile(struct inode *dir
 	mark_inode_dirty(inode);
 
 	d_tmpfile(dentry, inode);
+	unlock_new_inode(inode);
 	return 0;
 }
 
@@ -663,6 +666,7 @@ static int udf_mkdir(struct inode *dir,
 	fi = udf_add_entry(inode, NULL, &fibh, &cfi, &err);
 	if (!fi) {
 		inode_dec_link_count(inode);
+		unlock_new_inode(inode);
 		iput(inode);
 		goto out;
 	}
@@ -681,6 +685,7 @@ static int udf_mkdir(struct inode *dir,
 	if (!fi) {
 		clear_nlink(inode);
 		mark_inode_dirty(inode);
+		unlock_new_inode(inode);
 		iput(inode);
 		goto out;
 	}
@@ -692,6 +697,7 @@ static int udf_mkdir(struct inode *dir,
 	udf_write_fi(dir, &cfi, fi, &fibh, NULL, NULL);
 	inc_nlink(dir);
 	mark_inode_dirty(dir);
+	unlock_new_inode(inode);
 	d_instantiate(dentry, inode);
 	if (fibh.sbh != fibh.ebh)
 		brelse(fibh.ebh);
@@ -999,6 +1005,7 @@ out:
 out_no_entry:
 	up_write(&iinfo->i_data_sem);
 	inode_dec_link_count(inode);
+	unlock_new_inode(inode);
 	iput(inode);
 	goto out;
 }

