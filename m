Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA57FC3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 13:41:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B35B23CD9
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 13:41:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B35B23CD9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933435AbeGFNlv (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 09:41:51 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:37040 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932345AbeGFNlu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 09:41:50 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 33DEEED1;
        Fri,  6 Jul 2018 06:41:50 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 21C7A3F5AD;
        Fri,  6 Jul 2018 06:41:48 -0700 (PDT)
From:   Mark Rutland <mark.rutland@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <mawilcox@microsoft.com>,
        valdis.kletnieks@vt.edu
Subject: [PATCH] radix-tree: avoid NULL dereference
Date:   Fri,  6 Jul 2018 14:41:44 +0100
Message-Id: <20180706134144.48446-1-mark.rutland@arm.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When idr_alloc() is called for the first time on an IDR (which has no
nodes in its radix tree), we end up with calculate_count() calling
get_slot_offset() with a NULL node, leading to a NULL pointer
dereference caught by UBSAN:

================================================================================
UBSAN: Undefined behaviour in lib/radix-tree.c:123:14
member access within null pointer of type 'const struct radix_tree_node'
CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.18.0-rc3+ #14
Hardware name: linux,dummy-virt (DT)
Call trace:
 dump_backtrace+0x0/0x458
 show_stack+0x20/0x30
 dump_stack+0x18c/0x248
 ubsan_epilogue+0x18/0x94
 handle_null_ptr_deref+0x1d4/0x228
 __ubsan_handle_type_mismatch_v1+0x188/0x1e0
 __radix_tree_replace+0x29c/0x2a0
 radix_tree_iter_replace+0x58/0x88
 idr_alloc_u32+0x240/0x340
 idr_alloc+0xe8/0x188
 worker_pool_assign_id+0x74/0x128
 workqueue_init_early+0x588/0xae4
 start_kernel+0x54c/0xb9c
================================================================================

The result of the load is passed into node_tag_get(), which ignores the
value when node is NULL. Typically, the compiler inlines both
get_slot_offset() and node_tag_get() into calculate_count(), optimizing
away the NULL-pointer dereference, and hence this doesn't typically
result in a boot failure.

We can't rely on the compiler always doing this, and must avoid
dereferencing fields from node when it is potentially NULL.

To do so, this patch folds the generation of offset into tag_get(), such
that this only happens when node is not NULL. Callers are updated to
pass the relevant slot, rather than the offset derived from it.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Matthew Wilcox <mawilcox@microsoft.com>
Cc: valdis.kletnieks@vt.edu
---
 lib/radix-tree.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

I beleive this is what Valdis hit [1] back in March. I spotted this while
booting an arm64 machine.

Mark.

[1] https://lkml.kernel.org/r/22378.1520883323@turing-police.cc.vt.edu

diff --git a/lib/radix-tree.c b/lib/radix-tree.c
index a9e41aed6de4..4c6f409582cb 100644
--- a/lib/radix-tree.c
+++ b/lib/radix-tree.c
@@ -1137,10 +1137,10 @@ static void replace_slot(void __rcu **slot, void *item,
 
 static bool node_tag_get(const struct radix_tree_root *root,
 				const struct radix_tree_node *node,
-				unsigned int tag, unsigned int offset)
+				unsigned int tag, void __rcu **slot)
 {
 	if (node)
-		return tag_get(node, tag, offset);
+		return tag_get(node, tag, get_slot_offset(node, slot));
 	return root_tag_get(root, tag);
 }
 
@@ -1156,8 +1156,7 @@ static int calculate_count(struct radix_tree_root *root,
 				void *item, void *old)
 {
 	if (is_idr(root)) {
-		unsigned offset = get_slot_offset(node, slot);
-		bool free = node_tag_get(root, node, IDR_FREE, offset);
+		bool free = node_tag_get(root, node, IDR_FREE, slot);
 		if (!free)
 			return 0;
 		if (!old)
@@ -2041,7 +2040,7 @@ void *radix_tree_delete_item(struct radix_tree_root *root,
 	if (!slot)
 		return NULL;
 	if (!entry && (!is_idr(root) || node_tag_get(root, node, IDR_FREE,
-						get_slot_offset(node, slot))))
+						     slot)))
 		return NULL;
 
 	if (item && entry != item)
-- 
2.11.0

