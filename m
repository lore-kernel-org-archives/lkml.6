Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 891ABC433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 07:48:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B4AF2086D
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 07:48:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B4AF2086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727795AbeH2Lnh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 07:43:37 -0400
Received: from smtp2.provo.novell.com ([137.65.250.81]:42751 "EHLO
        smtp2.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727099AbeH2Lnh (ORCPT
        <rfc822;groupwise-linux-kernel@vger.kernel.org:0:0>);
        Wed, 29 Aug 2018 07:43:37 -0400
Received: from Beta.suse.asia (prv-ext-foundry1int.gns.novell.com [137.65.251.240])
        by smtp2.provo.novell.com with ESMTP (NOT encrypted); Wed, 29 Aug 2018 01:47:52 -0600
From:   Larry Chen <lchen@suse.com>
To:     mfasheh@suse.com, jlbec@evilplan.org
Cc:     linux-kernel@vger.kernel.org, ocfs2-devel@oss.oracle.com,
        akpm@linux-foundation.org
Subject: [PATCH] fix crash on ocfs2_duplicate_clusters_by_page
Date:   Wed, 29 Aug 2018 15:47:40 +0800
Message-Id: <20180829074740.9438-1-lchen@suse.com>
X-Mailer: git-send-email 2.13.7
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ocfs2_duplicate_clusters_by_page may crash if one of extent's pages is dirty.
When a page has not been written back, it is still in dirty state. If 
ocfs2_duplicate_clusters_by_page is called against the
dirty page, the crash happens.

To fix this bug, we can just unlock the page and wait the page until
it's not dirty.

The following is the buck trace dump:

kernel BUG at /root/code/ocfs2/refcounttree.c:2961!
[exception RIP: ocfs2_duplicate_clusters_by_page+822]
__ocfs2_move_extent+0x80/0x450 [ocfs2]
? __ocfs2_claim_clusters+0x130/0x250 [ocfs2]
ocfs2_defrag_extent+0x5b8/0x5e0 [ocfs2]
__ocfs2_move_extents_range+0x2a4/0x470 [ocfs2]
ocfs2_move_extents+0x180/0x3b0 [ocfs2]
? ocfs2_wait_for_recovery+0x13/0x70 [ocfs2]
ocfs2_ioctl_move_extents+0x133/0x2d0 [ocfs2]
ocfs2_ioctl+0x253/0x640 [ocfs2]
do_vfs_ioctl+0x90/0x5f0
SyS_ioctl+0x74/0x80
do_syscall_64+0x74/0x140
entry_SYSCALL_64_after_hwframe+0x3d/0xa2

Change-log:
1. Once we founce the page is dirty, we do not wait until it's clean,
   but rather we use write_one_page to write it back

2. write_one_page arguments list changed, adjust and retest this patch. 
Signed-off-by: Larry Chen <lchen@suse.com>
---
 fs/ocfs2/refcounttree.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/fs/ocfs2/refcounttree.c b/fs/ocfs2/refcounttree.c
index 7869622af22a..d6022e04c35a 100644
--- a/fs/ocfs2/refcounttree.c
+++ b/fs/ocfs2/refcounttree.c
@@ -2946,6 +2946,7 @@ int ocfs2_duplicate_clusters_by_page(handle_t *handle,
 		if (map_end & (PAGE_SIZE - 1))
 			to = map_end & (PAGE_SIZE - 1);
 
+retry:
 		page = find_or_create_page(mapping, page_index, GFP_NOFS);
 		if (!page) {
 			ret = -ENOMEM;
@@ -2957,8 +2958,15 @@ int ocfs2_duplicate_clusters_by_page(handle_t *handle,
 		 * In case PAGE_SIZE <= CLUSTER_SIZE, This page
 		 * can't be dirtied before we CoW it out.
 		 */
-		if (PAGE_SIZE <= OCFS2_SB(sb)->s_clustersize)
-			BUG_ON(PageDirty(page));
+		if (PAGE_SIZE <= OCFS2_SB(sb)->s_clustersize) {
+			if (PageDirty(page)) {
+				/*
+				 * write_on_page will unlock the page on return
+				 */
+				ret = write_one_page(page);
+				goto retry;
+			}
+		}
 
 		if (!PageUptodate(page)) {
 			ret = block_read_full_page(page, ocfs2_get_block);
-- 
2.13.7

