Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7DF7C43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 21:55:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86AB42082B
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 21:55:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86AB42082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727390AbeIECWP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 22:22:15 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:48218 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726864AbeIECWO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 22:22:14 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 4E122CBF;
        Tue,  4 Sep 2018 21:55:11 +0000 (UTC)
Date:   Tue, 4 Sep 2018 14:55:10 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Larry Chen <lchen@suse.com>
Cc:     mark@fasheh.com, jlbec@evilplan.org, linux-kernel@vger.kernel.org,
        ocfs2-devel@oss.oracle.com
Subject: Re: [PATCH 1/2] add declaration of ocfs2_free_local_alloc_bits
Message-Id: <20180904145510.9dd257f40514c8c839745bf4@linux-foundation.org>
In-Reply-To: <20180904041621.16874-2-lchen@suse.com>
References: <20180904041621.16874-1-lchen@suse.com>
        <20180904041621.16874-2-lchen@suse.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue,  4 Sep 2018 12:16:20 +0800 Larry Chen <lchen@suse.com> wrote:

> Signed-off-by: Larry Chen <lchen@suse.com>
> ---
>  fs/ocfs2/alloc.h | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/fs/ocfs2/alloc.h b/fs/ocfs2/alloc.h
> index 250bcacdf9e9..5770503b0e36 100644
> --- a/fs/ocfs2/alloc.h
> +++ b/fs/ocfs2/alloc.h
> @@ -323,4 +323,10 @@ int ocfs2_find_cpos_for_left_leaf(struct super_block *sb,
>  int ocfs2_find_subtree_root(struct ocfs2_extent_tree *et,
>  			    struct ocfs2_path *left,
>  			    struct ocfs2_path *right);
> +
> +int ocfs2_free_local_alloc_bits(struct ocfs2_super *osb,
> +				handle_t *handle,
> +				struct ocfs2_alloc_context *ac,
> +				u32 bit_off,
> +				u32 num_bits);
>  #endif /* OCFS2_ALLOC_H */

It's already declared in fs/ocfs2/localalloc.h - why not include that?

I did this with the other patch and all seems well:


From: Andrew Morton <akpm@linux-foundation.org>
Subject: fix-clusters-leak-in-ocfs2_defrag_extent-fix

include localalloc.h, reduce scope of data_ac

Cc: Larry Chen <lchen@suse.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 fs/ocfs2/move_extents.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/fs/ocfs2/move_extents.c~fix-clusters-leak-in-ocfs2_defrag_extent-fix
+++ a/fs/ocfs2/move_extents.c
@@ -25,6 +25,7 @@
 #include "ocfs2_ioctl.h"
 
 #include "alloc.h"
+#include "localalloc.h"
 #include "aops.h"
 #include "dlmglue.h"
 #include "extent_map.h"
@@ -227,7 +228,6 @@ static int ocfs2_defrag_extent(struct oc
 	u32 new_phys_cpos, new_len;
 	u64 phys_blkno = ocfs2_clusters_to_blocks(inode->i_sb, phys_cpos);
 	int need_free = 0;
-	struct ocfs2_alloc_context *data_ac;
 
 	if ((ext_flags & OCFS2_EXT_REFCOUNTED) && *len) {
 		BUG_ON(!ocfs2_is_refcount_inode(inode));
@@ -345,7 +345,8 @@ static int ocfs2_defrag_extent(struct oc
 
 out_commit:
 	if (need_free && context->data_ac) {
-		data_ac = context->data_ac;
+		struct ocfs2_alloc_context *data_ac = context->data_ac;
+
 		if (context->data_ac->ac_which == OCFS2_AC_USE_LOCAL)
 			ocfs2_free_local_alloc_bits(osb, handle, data_ac,
 					new_phys_cpos, new_len);
_

