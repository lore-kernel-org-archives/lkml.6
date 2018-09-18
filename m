Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1F7BECE562
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 02:18:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BE1F214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 02:18:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="NzjS4+wc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BE1F214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728815AbeIRHsV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 03:48:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:48730 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725787AbeIRHsV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 03:48:21 -0400
Received: from localhost (unknown [104.132.1.88])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4E480214C2;
        Tue, 18 Sep 2018 02:18:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1537237088;
        bh=D14RfgxyFY8ZuNnZBmyheGXI8tohKTKj6xrfTnK6/Rw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NzjS4+wc6KLtgU+eahCDzO8HJ703fu9gXSX4igGYHujg+W7jkYbwbhbS9dwtRA1x+
         K3iI1q/SqaEKEJY+i/sU/g50jh/hugIRW2dsxPFFHr96mgf8Z7gUowR9l4Fj57Jqtj
         vHv8KjuhUofwNbOejEm5bUGFECbeSHgxv32PsHZk=
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 2/2] f2fs: avoid f2fs_bug_on if f2fs_get_meta_page_nofail got EIO
Date:   Mon, 17 Sep 2018 19:18:05 -0700
Message-Id: <20180918021805.85032-2-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d-goog
In-Reply-To: <20180918021805.85032-1-jaegeuk@kernel.org>
References: <20180918021805.85032-1-jaegeuk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch avoids BUG_ON when f2fs_get_meta_page_nofail got EIO during
xfstests/generic/475.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/checkpoint.c |  2 +-
 fs/f2fs/gc.c         |  2 ++
 fs/f2fs/node.c       | 12 ++++++++++--
 fs/f2fs/recovery.c   |  2 ++
 fs/f2fs/segment.c    |  3 +++
 5 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 01e0d8f5bbbe..6ce3cb6502dd 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -121,7 +121,7 @@ struct page *f2fs_get_meta_page_nofail(struct f2fs_sb_info *sbi, pgoff_t index)
 			goto retry;
 
 		f2fs_stop_checkpoint(sbi, false);
-		f2fs_bug_on(sbi, 1);
+		return NULL;
 	}
 
 	return page;
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 4bcc8a59fdef..d049865887cf 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -1070,6 +1070,8 @@ static int do_garbage_collect(struct f2fs_sb_info *sbi,
 	/* reference all summary page */
 	while (segno < end_segno) {
 		sum_page = f2fs_get_sum_page(sbi, segno++);
+		if (!sum_page)
+			return -EIO;
 		unlock_page(sum_page);
 	}
 
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index fa2381c0bc47..b3595522c35b 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -126,6 +126,8 @@ static struct page *get_next_nat_page(struct f2fs_sb_info *sbi, nid_t nid)
 
 	/* get current nat block page with lock */
 	src_page = get_current_nat_page(sbi, nid);
+	if (!src_page)
+		return NULL;
 	dst_page = f2fs_grab_meta_page(sbi, dst_off);
 	f2fs_bug_on(sbi, PageDirty(src_page));
 
@@ -2265,8 +2267,12 @@ static int __f2fs_build_free_nids(struct f2fs_sb_info *sbi,
 						nm_i->nat_block_bitmap)) {
 			struct page *page = get_current_nat_page(sbi, nid);
 
-			ret = scan_nat_page(sbi, page, nid);
-			f2fs_put_page(page, 1);
+			if (page) {
+				ret = scan_nat_page(sbi, page, nid);
+				f2fs_put_page(page, 1);
+			} else {
+				ret = -EIO;
+			}
 
 			if (ret) {
 				up_read(&nm_i->nat_tree_lock);
@@ -2724,6 +2730,8 @@ static void __flush_nat_entry_set(struct f2fs_sb_info *sbi,
 		down_write(&curseg->journal_rwsem);
 	} else {
 		page = get_next_nat_page(sbi, start_nid);
+		if (!page)
+			return;
 		nat_blk = page_address(page);
 		f2fs_bug_on(sbi, !nat_blk);
 	}
diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
index 56d34193a74b..a3dce16bfd6c 100644
--- a/fs/f2fs/recovery.c
+++ b/fs/f2fs/recovery.c
@@ -355,6 +355,8 @@ static int check_index_in_prev_nodes(struct f2fs_sb_info *sbi,
 	}
 
 	sum_page = f2fs_get_sum_page(sbi, segno);
+	if (!sum_page)
+		return -EIO;
 	sum_node = (struct f2fs_summary_block *)page_address(sum_page);
 	sum = sum_node->entries[blkoff];
 	f2fs_put_page(sum_page, 1);
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index aa96a371aaf8..cfc9eb492da1 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -2487,6 +2487,7 @@ static void change_curseg(struct f2fs_sb_info *sbi, int type)
 	__next_free_blkoff(sbi, curseg, 0);
 
 	sum_page = f2fs_get_sum_page(sbi, new_segno);
+	f2fs_bug_on(sbi, !sum_page);
 	sum_node = (struct f2fs_summary_block *)page_address(sum_page);
 	memcpy(curseg->sum_blk, sum_node, SUM_ENTRY_SIZE);
 	f2fs_put_page(sum_page, 1);
@@ -3971,6 +3972,8 @@ static int build_sit_entries(struct f2fs_sb_info *sbi)
 
 			se = &sit_i->sentries[start];
 			page = get_current_sit_page(sbi, start);
+			if (!page)
+				return err;
 			sit_blk = (struct f2fs_sit_block *)page_address(page);
 			sit = sit_blk->entries[SIT_ENTRY_OFFSET(sit_i, start)];
 			f2fs_put_page(page, 1);
-- 
2.17.0.441.gb46fe60e1d-goog

