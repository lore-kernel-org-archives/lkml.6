Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1E7EC67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:20:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 981F9208E7
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:20:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544790018;
	bh=3hJsp/PAsu7eUdEN8jre9xYthANGn9AgpO+A52Gwa40=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=byk9kdfj4az8ShMeDcfiCw1saGw3hbAyy06JKd2F4l7ImksoRbDZdQOKuYP/pXxYm
	 qBLSHmohd3YtlcLp3xtH03rwxKgQQ8TLPTOTzgD1/xJEI9sWUn3wPcyB1DR4LqBJu8
	 q1D72xiw3jFBVwIO9ITbiCtfxyNIgnZ96PabezMA=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 981F9208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732562AbeLNMP0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 07:15:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:35352 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732237AbeLNMPX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 07:15:23 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CAD7E214DE;
        Fri, 14 Dec 2018 12:15:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544789722;
        bh=3hJsp/PAsu7eUdEN8jre9xYthANGn9AgpO+A52Gwa40=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ed014AjhMAmLsbpwb73XZx5Ax6CtlJ2U9Xiu3VCDhYJgetGrREpa+SNkjrFFNj6Tb
         MBgoy8L8DAaPaRAN+sB47skagVEuW124Ll3VfRPLE9Au/2xyy/cRguQo2FdUr+E2Po
         csHLLQLaBNzaz2YwK901UXxT3JvI5ONnri1/aJmc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Larry Chen <lchen@suse.com>,
        Changwei Ge <ge.changwei@h3c.com>,
        Mark Fasheh <mark@fasheh.com>,
        Joel Becker <jlbec@evilplan.org>,
        Junxiao Bi <junxiao.bi@oracle.com>,
        Joseph Qi <jiangqi903@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 34/88] ocfs2: fix deadlock caused by ocfs2_defrag_extent()
Date:   Fri, 14 Dec 2018 13:00:08 +0100
Message-Id: <20181214115704.971233058@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181214115702.151309521@linuxfoundation.org>
References: <20181214115702.151309521@linuxfoundation.org>
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

[ Upstream commit e21e57445a64598b29a6f629688f9b9a39e7242a ]

ocfs2_defrag_extent may fall into deadlock.

ocfs2_ioctl_move_extents
    ocfs2_ioctl_move_extents
      ocfs2_move_extents
        ocfs2_defrag_extent
          ocfs2_lock_allocators_move_extents

            ocfs2_reserve_clusters
              inode_lock GLOBAL_BITMAP_SYSTEM_INODE

	  __ocfs2_flush_truncate_log
              inode_lock GLOBAL_BITMAP_SYSTEM_INODE

As backtrace shows above, ocfs2_reserve_clusters() will call inode_lock
against the global bitmap if local allocator has not sufficient cluters.
Once global bitmap could meet the demand, ocfs2_reserve_cluster will
return success with global bitmap locked.

After ocfs2_reserve_cluster(), if truncate log is full,
__ocfs2_flush_truncate_log() will definitely fall into deadlock because
it needs to inode_lock global bitmap, which has already been locked.

To fix this bug, we could remove from
ocfs2_lock_allocators_move_extents() the code which intends to lock
global allocator, and put the removed code after
__ocfs2_flush_truncate_log().

ocfs2_lock_allocators_move_extents() is referred by 2 places, one is
here, the other does not need the data allocator context, which means
this patch does not affect the caller so far.

Link: http://lkml.kernel.org/r/20181101071422.14470-1-lchen@suse.com
Signed-off-by: Larry Chen <lchen@suse.com>
Reviewed-by: Changwei Ge <ge.changwei@h3c.com>
Cc: Mark Fasheh <mark@fasheh.com>
Cc: Joel Becker <jlbec@evilplan.org>
Cc: Junxiao Bi <junxiao.bi@oracle.com>
Cc: Joseph Qi <jiangqi903@gmail.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ocfs2/move_extents.c | 47 +++++++++++++++++++++++------------------
 1 file changed, 26 insertions(+), 21 deletions(-)

diff --git a/fs/ocfs2/move_extents.c b/fs/ocfs2/move_extents.c
index 124471d26a73..c1a83c58456e 100644
--- a/fs/ocfs2/move_extents.c
+++ b/fs/ocfs2/move_extents.c
@@ -156,18 +156,14 @@ static int __ocfs2_move_extent(handle_t *handle,
 }
 
 /*
- * lock allocators, and reserving appropriate number of bits for
- * meta blocks and data clusters.
- *
- * in some cases, we don't need to reserve clusters, just let data_ac
- * be NULL.
+ * lock allocator, and reserve appropriate number of bits for
+ * meta blocks.
  */
-static int ocfs2_lock_allocators_move_extents(struct inode *inode,
+static int ocfs2_lock_meta_allocator_move_extents(struct inode *inode,
 					struct ocfs2_extent_tree *et,
 					u32 clusters_to_move,
 					u32 extents_to_split,
 					struct ocfs2_alloc_context **meta_ac,
-					struct ocfs2_alloc_context **data_ac,
 					int extra_blocks,
 					int *credits)
 {
@@ -192,13 +188,6 @@ static int ocfs2_lock_allocators_move_extents(struct inode *inode,
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
 
@@ -260,10 +249,10 @@ static int ocfs2_defrag_extent(struct ocfs2_move_extents_context *context,
 		}
 	}
 
-	ret = ocfs2_lock_allocators_move_extents(inode, &context->et, *len, 1,
-						 &context->meta_ac,
-						 &context->data_ac,
-						 extra_blocks, &credits);
+	ret = ocfs2_lock_meta_allocator_move_extents(inode, &context->et,
+						*len, 1,
+						&context->meta_ac,
+						extra_blocks, &credits);
 	if (ret) {
 		mlog_errno(ret);
 		goto out;
@@ -286,6 +275,21 @@ static int ocfs2_defrag_extent(struct ocfs2_move_extents_context *context,
 		}
 	}
 
+	/*
+	 * Make sure ocfs2_reserve_cluster is called after
+	 * __ocfs2_flush_truncate_log, otherwise, dead lock may happen.
+	 *
+	 * If ocfs2_reserve_cluster is called
+	 * before __ocfs2_flush_truncate_log, dead lock on global bitmap
+	 * may happen.
+	 *
+	 */
+	ret = ocfs2_reserve_clusters(osb, *len, &context->data_ac);
+	if (ret) {
+		mlog_errno(ret);
+		goto out_unlock_mutex;
+	}
+
 	handle = ocfs2_start_trans(osb, credits);
 	if (IS_ERR(handle)) {
 		ret = PTR_ERR(handle);
@@ -606,9 +610,10 @@ static int ocfs2_move_extent(struct ocfs2_move_extents_context *context,
 		}
 	}
 
-	ret = ocfs2_lock_allocators_move_extents(inode, &context->et, len, 1,
-						 &context->meta_ac,
-						 NULL, extra_blocks, &credits);
+	ret = ocfs2_lock_meta_allocator_move_extents(inode, &context->et,
+						len, 1,
+						&context->meta_ac,
+						extra_blocks, &credits);
 	if (ret) {
 		mlog_errno(ret);
 		goto out;
-- 
2.19.1



