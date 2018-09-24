Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27B37C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 11:37:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF629208E3
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 11:37:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF629208E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728950AbeIXRiv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 13:38:51 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:50168 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728421AbeIXRiu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 13:38:50 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 6729D1065;
        Mon, 24 Sep 2018 11:37:11 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Xu Wen <wen.xu@gatech.edu>,
        Qu Wenruo <wqu@suse.com>, Gu Jinxiang <gujx@cn.fujitsu.com>,
        David Sterba <dsterba@suse.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 024/105] btrfs: relocation: Only remove reloc rb_trees if reloc control has been initialized
Date:   Mon, 24 Sep 2018 13:33:10 +0200
Message-Id: <20180924113116.062619889@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180924113113.268650190@linuxfoundation.org>
References: <20180924113113.268650190@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Qu Wenruo <wqu@suse.com>

[ Upstream commit 389305b2aa68723c754f88d9dbd268a400e10664 ]

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
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/btrfs/relocation.c |   23 ++++++++++++-----------
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


