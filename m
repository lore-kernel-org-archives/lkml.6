Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B3CAC0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 21:26:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C40162054F
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 21:26:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C40162054F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725963AbeKAG0X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 02:26:23 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:44320 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725736AbeKAG0X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 02:26:23 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 398D4B09;
        Wed, 31 Oct 2018 21:26:33 +0000 (UTC)
Date:   Wed, 31 Oct 2018 14:26:32 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Larry Chen <lchen@suse.com>
Cc:     mark@fasheh.com, jlbec@evilplan.org, linux-kernel@vger.kernel.org,
        ocfs2-devel@oss.oracle.com, Joseph Qi <jiangqi903@gmail.com>,
        Changwei Ge <gechangwei@live.cn>
Subject: Re: [PATCH V2] ocfs2: fix dead lock caused by ocfs2_defrag_extent
Message-Id: <20181031142632.c523108bc137caa8cb1c6282@linux-foundation.org>
In-Reply-To: <20180902091455.23862-1-lchen@suse.com>
References: <20180902091455.23862-1-lchen@suse.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Folks, could we please review this patch for upstream inclusion?

Thanks.


From: Larry Chen <lchen@suse.com>
Subject: ocfs2: fix deadlock caused by ocfs2_defrag_extent

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
__ocfs2_flush_truncate_log() will definitely fall into deadlock because it
needs to inode_lock global bitmap, which has already been locked.

To fix this bug, we could remove from ocfs2_lock_allocators_move_extents()
the code which intends to lock global allocator, and put the removed code
after __ocfs2_flush_truncate_log().

ocfs2_lock_allocators_move_extents() is refered by 2 places, one is here,
the other does not need the data allocator context, which means this patch
does not affect the caller so far.

[lchen@suse.com: rename ocfs2_lock_allocators_move_extents() to ocfs2_lock_meta_allocator_move_extents(), add some comments]
  Link: http://lkml.kernel.org/r/20180902091455.23862-1-lchen@suse.com
Link: http://lkml.kernel.org/r/20180827080121.31145-1-lchen@suse.com
Signed-off-by: Larry Chen <lchen@suse.com>
Cc: Mark Fasheh <mark@fasheh.com>
Cc: Joel Becker <jlbec@evilplan.org>
Cc: Junxiao Bi <junxiao.bi@oracle.com>
Cc: Joseph Qi <jiangqi903@gmail.com>
Cc: Changwei Ge <ge.changwei@h3c.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 fs/ocfs2/move_extents.c |   40 +++++++++++++++++++++++---------------
 1 file changed, 25 insertions(+), 15 deletions(-)

--- a/fs/ocfs2/move_extents.c~fix-dead-lock-caused-by-ocfs2_defrag_extent
+++ a/fs/ocfs2/move_extents.c
@@ -162,7 +162,7 @@ out:
  * in some cases, we don't need to reserve clusters, just let data_ac
  * be NULL.
  */
-static int ocfs2_lock_allocators_move_extents(struct inode *inode,
+static int ocfs2_lock_meta_allocator_move_extents(struct inode *inode,
 					struct ocfs2_extent_tree *et,
 					u32 clusters_to_move,
 					u32 extents_to_split,
@@ -192,13 +192,6 @@ static int ocfs2_lock_allocators_move_ex
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
 
@@ -257,10 +250,11 @@ static int ocfs2_defrag_extent(struct oc
 		}
 	}
 
-	ret = ocfs2_lock_allocators_move_extents(inode, &context->et, *len, 1,
-						 &context->meta_ac,
-						 &context->data_ac,
-						 extra_blocks, &credits);
+	ret = ocfs2_lock_meta_allocator_move_extents(inode, &context->et,
+						*len, 1,
+						&context->meta_ac,
+						&context->data_ac,
+						extra_blocks, &credits);
 	if (ret) {
 		mlog_errno(ret);
 		goto out;
@@ -283,6 +277,21 @@ static int ocfs2_defrag_extent(struct oc
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
@@ -600,9 +609,10 @@ static int ocfs2_move_extent(struct ocfs
 		}
 	}
 
-	ret = ocfs2_lock_allocators_move_extents(inode, &context->et, len, 1,
-						 &context->meta_ac,
-						 NULL, extra_blocks, &credits);
+	ret = ocfs2_lock_meta_allocator_move_extents(inode, &context->et,
+						len, 1,
+						&context->meta_ac,
+						NULL, extra_blocks, &credits);
 	if (ret) {
 		mlog_errno(ret);
 		goto out;
_

