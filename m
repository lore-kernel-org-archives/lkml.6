Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D216DC7112A
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:50:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97A9220645
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:50:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97A9220645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729081AbeJNXXr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 19:23:47 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:36191 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728024AbeJNXMA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 19:12:00 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLo-0004cH-8f; Sun, 14 Oct 2018 16:30:40 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLY-0000al-A4; Sun, 14 Oct 2018 16:30:24 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Chao Yu" <chao2.yu@samsung.com>,
        "Jaegeuk Kim" <jaegeuk@kernel.org>
Date:   Sun, 14 Oct 2018 16:25:41 +0100
Message-ID: <lsq.1539530741.655779125@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 284/366] f2fs: reposition unlock_new_inode to prevent
 accessing invalid inode
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

From: Chao Yu <chao2.yu@samsung.com>

commit b73e52824c8920a5ff754e3c8ff68466a7dd61f9 upstream.

As the race condition on the inode cache, following scenario can appear:
[Thread a]				[Thread b]
					->f2fs_mkdir
					  ->f2fs_add_link
					    ->__f2fs_add_link
					      ->init_inode_metadata failed here
->gc_thread_func
  ->f2fs_gc
    ->do_garbage_collect
      ->gc_data_segment
        ->f2fs_iget
          ->iget_locked
            ->wait_on_inode
					  ->unlock_new_inode
        ->move_data_page
					  ->make_bad_inode
					  ->iput

When we fail in create/symlink/mkdir/mknod/tmpfile, the new allocated inode
should be set as bad to avoid being accessed by other thread. But in above
scenario, it allows f2fs to access the invalid inode before this inode was set
as bad.
This patch fix the potential problem, and this issue was found by code review.

change log from v1:
 o Add condition judgment in gc_data_segment() suggested by Changman Lee.
 o use iget_failed to simplify code.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
[bwh: Backported to 3.16: Drop changes in f2fs_tmpfile()]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -602,7 +602,7 @@ next_step:
 
 		if (phase == 2) {
 			inode = f2fs_iget(sb, dni.ino);
-			if (IS_ERR(inode))
+			if (IS_ERR(inode) || is_bad_inode(inode))
 				continue;
 
 			start_bidx = start_bidx_of_node(nofs, F2FS_I(inode));
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -135,9 +135,7 @@ static int f2fs_create(struct inode *dir
 	return 0;
 out:
 	clear_nlink(inode);
-	unlock_new_inode(inode);
-	make_bad_inode(inode);
-	iput(inode);
+	iget_failed(inode);
 	alloc_nid_failed(sbi, ino);
 	return err;
 }
@@ -271,9 +269,7 @@ static int f2fs_symlink(struct inode *di
 	return err;
 out:
 	clear_nlink(inode);
-	unlock_new_inode(inode);
-	make_bad_inode(inode);
-	iput(inode);
+	iget_failed(inode);
 	alloc_nid_failed(sbi, inode->i_ino);
 	return err;
 }
@@ -312,9 +308,7 @@ static int f2fs_mkdir(struct inode *dir,
 out_fail:
 	clear_inode_flag(F2FS_I(inode), FI_INC_LINK);
 	clear_nlink(inode);
-	unlock_new_inode(inode);
-	make_bad_inode(inode);
-	iput(inode);
+	iget_failed(inode);
 	alloc_nid_failed(sbi, inode->i_ino);
 	return err;
 }
@@ -359,9 +353,7 @@ static int f2fs_mknod(struct inode *dir,
 	return 0;
 out:
 	clear_nlink(inode);
-	unlock_new_inode(inode);
-	make_bad_inode(inode);
-	iput(inode);
+	iget_failed(inode);
 	alloc_nid_failed(sbi, inode->i_ino);
 	return err;
 }

