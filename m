Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D3DDC43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 04:16:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FCA620843
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 04:16:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FCA620843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727075AbeIDIkJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 04:40:09 -0400
Received: from smtp2.provo.novell.com ([137.65.250.81]:37044 "EHLO
        smtp2.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725845AbeIDIkJ (ORCPT
        <rfc822;groupwise-linux-kernel@vger.kernel.org:0:0>);
        Tue, 4 Sep 2018 04:40:09 -0400
Received: from Beta.suse.asia (prv-ext-foundry1int.gns.novell.com [137.65.251.240])
        by smtp2.provo.novell.com with ESMTP (NOT encrypted); Mon, 03 Sep 2018 22:16:44 -0600
From:   Larry Chen <lchen@suse.com>
To:     mark@fasheh.com, jlbec@evilplan.org
Cc:     linux-kernel@vger.kernel.org, ocfs2-devel@oss.oracle.com,
        akpm@linux-foundation.org
Subject: [PATCH 2/2] fix clusters leak in ocfs2_defrag_extent
Date:   Tue,  4 Sep 2018 12:16:21 +0800
Message-Id: <20180904041621.16874-3-lchen@suse.com>
X-Mailer: git-send-email 2.13.7
In-Reply-To: <20180904041621.16874-1-lchen@suse.com>
References: <20180904041621.16874-1-lchen@suse.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Larry Chen <lchen@suse.com>
---
 fs/ocfs2/move_extents.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/fs/ocfs2/move_extents.c b/fs/ocfs2/move_extents.c
index d85dc8a02bd6..4f2ad054b419 100644
--- a/fs/ocfs2/move_extents.c
+++ b/fs/ocfs2/move_extents.c
@@ -226,6 +226,8 @@ static int ocfs2_defrag_extent(struct ocfs2_move_extents_context *context,
 	struct ocfs2_refcount_tree *ref_tree = NULL;
 	u32 new_phys_cpos, new_len;
 	u64 phys_blkno = ocfs2_clusters_to_blocks(inode->i_sb, phys_cpos);
+	int need_free = 0;
+	struct ocfs2_alloc_context *data_ac;
 
 	if ((ext_flags & OCFS2_EXT_REFCOUNTED) && *len) {
 		BUG_ON(!ocfs2_is_refcount_inode(inode));
@@ -317,6 +319,7 @@ static int ocfs2_defrag_extent(struct ocfs2_move_extents_context *context,
 		if (!partial) {
 			context->range->me_flags &= ~OCFS2_MOVE_EXT_FL_COMPLETE;
 			ret = -ENOSPC;
+			need_free = 1;
 			goto out_commit;
 		}
 	}
@@ -341,6 +344,19 @@ static int ocfs2_defrag_extent(struct ocfs2_move_extents_context *context,
 		mlog_errno(ret);
 
 out_commit:
+	if (need_free && context->data_ac) {
+		data_ac = context->data_ac;
+		if (context->data_ac->ac_which == OCFS2_AC_USE_LOCAL)
+			ocfs2_free_local_alloc_bits(osb, handle, data_ac,
+					new_phys_cpos, new_len);
+		else
+			ocfs2_free_clusters(handle,
+					data_ac->ac_inode,
+					data_ac->ac_bh,
+					ocfs2_clusters_to_blocks(osb->sb, new_phys_cpos),
+					new_len);
+	}
+
 	ocfs2_commit_trans(osb, handle);
 
 out_unlock_mutex:
-- 
2.13.7

