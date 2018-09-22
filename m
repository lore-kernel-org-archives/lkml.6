Return-Path: <SRS0=j7Hi=ME=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE96DECE560
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 00:24:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F62220870
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 00:24:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F62220870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392261AbeIVGPZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Sep 2018 02:15:25 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:44170 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2391938AbeIVGKq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Sep 2018 02:10:46 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1g3Vdv-0008BX-Bc; Sat, 22 Sep 2018 01:19:27 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1g3Vdo-0000td-R6; Sat, 22 Sep 2018 01:19:20 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Qu Wenruo" <wqu@suse.com>,
        "David Sterba" <dsterba@suse.com>,
        "Gu Jinxiang" <gujx@cn.fujitsu.com>, "Xu Wen" <wen.xu@gatech.edu>
Date:   Sat, 22 Sep 2018 01:15:42 +0100
Message-ID: <lsq.1537575342.743277752@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 49/63] btrfs: relocation: Only remove reloc rb_trees
 if reloc control has been initialized
In-Reply-To: <lsq.1537575341.194909669@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:cbab:f00:c93f:614
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.58-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Qu Wenruo <wqu@suse.com>

commit 389305b2aa68723c754f88d9dbd268a400e10664 upstream.

Invalid reloc tree can cause kernel NULL pointer dereference when btrfs
does some cleanup of the reloc roots.

It turns out that fs_info::reloc_ctl can be NULL in
btrfs_recover_relocation() as we allocate relocation control after all
reloc roots have been verified.
So when we hit: note, we haven't called set_reloc_control() thus
fs_info::reloc_ctl is still NULL.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=199833
Reported-by: Xu Wen <wen.xu@gatech.edu>
Signed-off-by: Qu Wenruo <wqu@suse.com>
Tested-by: Gu Jinxiang <gujx@cn.fujitsu.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 fs/btrfs/relocation.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -1311,18 +1311,19 @@ static void __del_reloc_root(struct btrf
 	struct mapping_node *node = NULL;
 	struct reloc_control *rc = root->fs_info->reloc_ctl;
 
-	spin_lock(&rc->reloc_root_tree.lock);
-	rb_node = tree_search(&rc->reloc_root_tree.rb_root,
-			      root->node->start);
-	if (rb_node) {
-		node = rb_entry(rb_node, struct mapping_node, rb_node);
-		rb_erase(&node->rb_node, &rc->reloc_root_tree.rb_root);
+	if (rc) {
+		spin_lock(&rc->reloc_root_tree.lock);
+		rb_node = tree_search(&rc->reloc_root_tree.rb_root,
+				      root->node->start);
+		if (rb_node) {
+			node = rb_entry(rb_node, struct mapping_node, rb_node);
+			rb_erase(&node->rb_node, &rc->reloc_root_tree.rb_root);
+		}
+		spin_unlock(&rc->reloc_root_tree.lock);
+		if (!node)
+			return;
+		BUG_ON((struct btrfs_root *)node->data != root);
 	}
-	spin_unlock(&rc->reloc_root_tree.lock);
-
-	if (!node)
-		return;
-	BUG_ON((struct btrfs_root *)node->data != root);
 
 	spin_lock(&root->fs_info->trans_lock);
 	list_del_init(&root->root_list);

