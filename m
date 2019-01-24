Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC244C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 20:12:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C3EE217D7
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 20:12:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548360777;
	bh=wCYAG8nbo3hExxu3TKc8A5srMnqnOmowXCyMTBo2Oo4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=SDwTgnBp3Rd1khDXxb9lJb68c4CVBGuYwp4ULL+/Ee8IZR3Qxg9zB1pSeApG4Zxig
	 DkdW8tTo89fey1cOgp30xDvfdV2d665h/p+sJEjltOfaPA7OM67qs0x5uj2v410tg1
	 vk9lfpgLDc663HyADWZFcusFOUZ9ue1BdIYNSn6M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730568AbfAXUM4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 15:12:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:51356 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729597AbfAXTZk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 14:25:40 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 35A20218FD;
        Thu, 24 Jan 2019 19:25:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548357939;
        bh=wCYAG8nbo3hExxu3TKc8A5srMnqnOmowXCyMTBo2Oo4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pH1XIZBBHzMvp9H3+A8zJKxm7ahJuV44bnVZCOQLjQpKKxaNDeZRLwcXqNHE1VSbD
         eYEhMpSNZ1egIwK+YRpWHlA5gknTgVWcLvs3lJgUEyXB7UxsFatUzuTBMGVy5vGwbX
         gakROpEzEnG6kHR9Lf7+ZZ6D/7IQd+MBEzkKZK90=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>
Subject: [PATCH 4.4 007/104] f2fs: give -EINVAL for norecovery and rw mount
Date:   Thu, 24 Jan 2019 20:18:56 +0100
Message-Id: <20190124190155.686881629@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190124190154.968308875@linuxfoundation.org>
References: <20190124190154.968308875@linuxfoundation.org>
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

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jaegeuk Kim <jaegeuk@kernel.org>

commit 6781eabba1bdb133eb9125c4acf6704ccbe4df02 upstream.

Once detecting something to recover, f2fs should stop mounting, given norecovery
and rw mount options.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/f2fs/f2fs.h     |    2 +-
 fs/f2fs/recovery.c |   11 +++++++----
 fs/f2fs/super.c    |   14 ++++++++++++--
 3 files changed, 20 insertions(+), 7 deletions(-)

--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1867,7 +1867,7 @@ void build_gc_manager(struct f2fs_sb_inf
 /*
  * recovery.c
  */
-int recover_fsync_data(struct f2fs_sb_info *);
+int recover_fsync_data(struct f2fs_sb_info *, bool);
 bool space_for_roll_forward(struct f2fs_sb_info *);
 
 /*
--- a/fs/f2fs/recovery.c
+++ b/fs/f2fs/recovery.c
@@ -524,12 +524,13 @@ next:
 	return err;
 }
 
-int recover_fsync_data(struct f2fs_sb_info *sbi)
+int recover_fsync_data(struct f2fs_sb_info *sbi, bool check_only)
 {
 	struct curseg_info *curseg = CURSEG_I(sbi, CURSEG_WARM_NODE);
 	struct list_head inode_list;
 	block_t blkaddr;
 	int err;
+	int ret = 0;
 	bool need_writecp = false;
 
 	fsync_entry_slab = f2fs_kmem_cache_create("f2fs_fsync_inode_entry",
@@ -546,11 +547,13 @@ int recover_fsync_data(struct f2fs_sb_in
 
 	/* step #1: find fsynced inode numbers */
 	err = find_fsync_dnodes(sbi, &inode_list);
-	if (err)
+	if (err || list_empty(&inode_list))
 		goto out;
 
-	if (list_empty(&inode_list))
+	if (check_only) {
+		ret = 1;
 		goto out;
+	}
 
 	need_writecp = true;
 
@@ -598,5 +601,5 @@ out:
 	} else {
 		mutex_unlock(&sbi->cp_mutex);
 	}
-	return err;
+	return ret ? ret: err;
 }
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1457,14 +1457,24 @@ try_onemore:
 		if (need_fsck)
 			set_sbi_flag(sbi, SBI_NEED_FSCK);
 
-		err = recover_fsync_data(sbi);
-		if (err) {
+		err = recover_fsync_data(sbi, false);
+		if (err < 0) {
 			need_fsck = true;
 			f2fs_msg(sb, KERN_ERR,
 				"Cannot recover all fsync data errno=%ld", err);
 			goto free_kobj;
 		}
+	} else {
+		err = recover_fsync_data(sbi, true);
+
+		if (!f2fs_readonly(sb) && err > 0) {
+			err = -EINVAL;
+			f2fs_msg(sb, KERN_ERR,
+				"Need to recover fsync data");
+			goto free_kobj;
+		}
 	}
+
 	/* recover_fsync_data() cleared this already */
 	clear_sbi_flag(sbi, SBI_POR_DOING);
 


