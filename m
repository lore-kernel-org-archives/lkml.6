Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AF18C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 08:01:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 291E4208B8
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 08:01:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 291E4208B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727040AbeH0LrK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 07:47:10 -0400
Received: from smtp2.provo.novell.com ([137.65.250.81]:58171 "EHLO
        smtp2.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726802AbeH0LrK (ORCPT
        <rfc822;groupwise-linux-kernel@vger.kernel.org:0:0>);
        Mon, 27 Aug 2018 07:47:10 -0400
Received: from Beta.suse.asia (prv-ext-foundry1int.gns.novell.com [137.65.251.240])
        by smtp2.provo.novell.com with ESMTP (NOT encrypted); Mon, 27 Aug 2018 02:01:30 -0600
From:   Larry Chen <lchen@suse.com>
To:     mfasheh@suse.com, jlbec@evilplan.org
Cc:     linux-kernel@vger.kernel.org, ocfs2-devel@oss.oracle.com,
        akpm@linux-foundation.org
Subject: [PATCH] fix dead lock caused by ocfs2_defrag_extent
Date:   Mon, 27 Aug 2018 16:01:21 +0800
Message-Id: <20180827080121.31145-1-lchen@suse.com>
X-Mailer: git-send-email 2.13.7
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ocfs2_defrag_extent may fall into dead lock.

ocfs2_ioctl_move_extents
  ocfs2_ioctl_move_extents	
    ocfs2_move_extents
      ocfs2_defrag_extent
        ocfs2_lock_allocators_move_extents  

          ocfs2_reserve_clusters
            inode_lock GLOBAL_BITMAP_SYSTEM_INODE

	  __ocfs2_flush_truncate_log
            inode_lock GLOBAL_BITMAP_SYSTEM_INODE

As back trace shows above, ocfs2_reserve_clusters will call inode_lock
against the global bitmap if local allocator has not sufficient cluters. 
Once global bitmap could meet the demand, ocfs2_reserve_cluster will 
return success with global bitmap locked.

After ocfs2_reserve_cluster, if truncate log is full, 
__ocfs2_flush_truncate_log will definitely fall into dead lock
because it needs to inode_lock global bitmap, which has
already been locked.

To fix this bug, we could remove from ocfs2_lock_allocators_move_extents 
the code which intends to lock global allocator, and put the removed
code after __ocfs2_flush_truncate_log

The ocfs2_lock_allocators_move_extents has been refered by 2 places, one
is here, the other does not need the data allocator context, which means
this patch does not affect the caller so far.



Signed-off-by: Larry Chen <lchen@suse.com>
---
 fs/ocfs2/move_extents.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/fs/ocfs2/move_extents.c b/fs/ocfs2/move_extents.c
index 7eb3b0a6347e..064dedf40d74 100644
--- a/fs/ocfs2/move_extents.c
+++ b/fs/ocfs2/move_extents.c
@@ -192,13 +192,6 @@ static int ocfs2_lock_allocators_move_extents(struct inode *inode,
 		goto out;
 	}
 
-	if (data_ac) {
-		ret = ocfs2_reserve_clusters(osb, clusters_to_move, data_ac);
-		if (ret) {
-			mlog_errno(ret);
-			goto out;
-		}
-	}
 
 	*credits += ocfs2_calc_extend_credits(osb->sb, et->et_root_el);
 
@@ -283,6 +276,12 @@ static int ocfs2_defrag_extent(struct ocfs2_move_extents_context *context,
 		}
 	}
 
+	ret = ocfs2_reserve_clusters(osb, *len, &context->data_ac);
+	if (ret) {
+		mlog_errno(ret);
+		goto out_unlock_mutex;
+	}
+
 	handle = ocfs2_start_trans(osb, credits);
 	if (IS_ERR(handle)) {
 		ret = PTR_ERR(handle);
-- 
2.13.7

