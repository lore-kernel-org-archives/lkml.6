Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA0FEC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:27:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F9FF214FE
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:27:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F9FF214FE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733252AbeIXS3F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 14:29:05 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:57226 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731006AbeIXS3F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 14:29:05 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 6F096108B;
        Mon, 24 Sep 2018 12:27:10 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Roi Dayan <roid@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>
Subject: [PATCH 4.18 014/235] net/mlx5: Fix possible deadlock from lockdep when adding fte to fg
Date:   Mon, 24 Sep 2018 13:50:00 +0200
Message-Id: <20180924113105.881671877@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180924113103.999624566@linuxfoundation.org>
References: <20180924113103.999624566@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Roi Dayan <roid@mellanox.com>

[ Upstream commit ad9421e36a77056a4f095d49b9605e80b4d216ed ]

This is a false positive report due to incorrect nested lock
annotations as we lock multiple fgs with the same subclass.
Instead of locking all fgs only lock the one being used as was
done before.

Fixes: bd71b08ec2ee ("net/mlx5: Support multiple updates of steering rules in parallel")
Signed-off-by: Roi Dayan <roid@mellanox.com>
Signed-off-by: Saeed Mahameed <saeedm@mellanox.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/fs_core.c |   74 +++++++++++-----------
 1 file changed, 37 insertions(+), 37 deletions(-)

--- a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
@@ -1649,6 +1649,33 @@ static u64 matched_fgs_get_version(struc
 	return version;
 }
 
+static struct fs_fte *
+lookup_fte_locked(struct mlx5_flow_group *g,
+		  u32 *match_value,
+		  bool take_write)
+{
+	struct fs_fte *fte_tmp;
+
+	if (take_write)
+		nested_down_write_ref_node(&g->node, FS_LOCK_PARENT);
+	else
+		nested_down_read_ref_node(&g->node, FS_LOCK_PARENT);
+	fte_tmp = rhashtable_lookup_fast(&g->ftes_hash, match_value,
+					 rhash_fte);
+	if (!fte_tmp || !tree_get_node(&fte_tmp->node)) {
+		fte_tmp = NULL;
+		goto out;
+	}
+
+	nested_down_write_ref_node(&fte_tmp->node, FS_LOCK_CHILD);
+out:
+	if (take_write)
+		up_write_ref_node(&g->node);
+	else
+		up_read_ref_node(&g->node);
+	return fte_tmp;
+}
+
 static struct mlx5_flow_handle *
 try_add_to_existing_fg(struct mlx5_flow_table *ft,
 		       struct list_head *match_head,
@@ -1671,10 +1698,6 @@ try_add_to_existing_fg(struct mlx5_flow_
 	if (IS_ERR(fte))
 		return  ERR_PTR(-ENOMEM);
 
-	list_for_each_entry(iter, match_head, list) {
-		nested_down_read_ref_node(&iter->g->node, FS_LOCK_PARENT);
-	}
-
 search_again_locked:
 	version = matched_fgs_get_version(match_head);
 	/* Try to find a fg that already contains a matching fte */
@@ -1682,20 +1705,9 @@ search_again_locked:
 		struct fs_fte *fte_tmp;
 
 		g = iter->g;
-		fte_tmp = rhashtable_lookup_fast(&g->ftes_hash, spec->match_value,
-						 rhash_fte);
-		if (!fte_tmp || !tree_get_node(&fte_tmp->node))
+		fte_tmp = lookup_fte_locked(g, spec->match_value, take_write);
+		if (!fte_tmp)
 			continue;
-
-		nested_down_write_ref_node(&fte_tmp->node, FS_LOCK_CHILD);
-		if (!take_write) {
-			list_for_each_entry(iter, match_head, list)
-				up_read_ref_node(&iter->g->node);
-		} else {
-			list_for_each_entry(iter, match_head, list)
-				up_write_ref_node(&iter->g->node);
-		}
-
 		rule = add_rule_fg(g, spec->match_value,
 				   flow_act, dest, dest_num, fte_tmp);
 		up_write_ref_node(&fte_tmp->node);
@@ -1704,19 +1716,6 @@ search_again_locked:
 		return rule;
 	}
 
-	/* No group with matching fte found. Try to add a new fte to any
-	 * matching fg.
-	 */
-
-	if (!take_write) {
-		list_for_each_entry(iter, match_head, list)
-			up_read_ref_node(&iter->g->node);
-		list_for_each_entry(iter, match_head, list)
-			nested_down_write_ref_node(&iter->g->node,
-						   FS_LOCK_PARENT);
-		take_write = true;
-	}
-
 	/* Check the ft version, for case that new flow group
 	 * was added while the fgs weren't locked
 	 */
@@ -1728,27 +1727,30 @@ search_again_locked:
 	/* Check the fgs version, for case the new FTE with the
 	 * same values was added while the fgs weren't locked
 	 */
-	if (version != matched_fgs_get_version(match_head))
+	if (version != matched_fgs_get_version(match_head)) {
+		take_write = true;
 		goto search_again_locked;
+	}
 
 	list_for_each_entry(iter, match_head, list) {
 		g = iter->g;
 
 		if (!g->node.active)
 			continue;
+
+		nested_down_write_ref_node(&g->node, FS_LOCK_PARENT);
+
 		err = insert_fte(g, fte);
 		if (err) {
+			up_write_ref_node(&g->node);
 			if (err == -ENOSPC)
 				continue;
-			list_for_each_entry(iter, match_head, list)
-				up_write_ref_node(&iter->g->node);
 			kmem_cache_free(steering->ftes_cache, fte);
 			return ERR_PTR(err);
 		}
 
 		nested_down_write_ref_node(&fte->node, FS_LOCK_CHILD);
-		list_for_each_entry(iter, match_head, list)
-			up_write_ref_node(&iter->g->node);
+		up_write_ref_node(&g->node);
 		rule = add_rule_fg(g, spec->match_value,
 				   flow_act, dest, dest_num, fte);
 		up_write_ref_node(&fte->node);
@@ -1757,8 +1759,6 @@ search_again_locked:
 	}
 	rule = ERR_PTR(-ENOENT);
 out:
-	list_for_each_entry(iter, match_head, list)
-		up_write_ref_node(&iter->g->node);
 	kmem_cache_free(steering->ftes_cache, fte);
 	return rule;
 }


