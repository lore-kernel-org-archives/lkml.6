Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C57DC65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 15:27:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2338F21565
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 15:27:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="feC9Eko4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2338F21565
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728807AbeJHWj0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 18:39:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:58578 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728738AbeJHWjY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 18:39:24 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CA8CE2150B;
        Mon,  8 Oct 2018 15:27:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539012429;
        bh=NwMBx61baqYkjWB4UFE2LysvHYdeFbptIuL0ERK0Bnc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=feC9Eko4xHlEiy4cmztCVVbfxFsmfaJ90KhCFmwX2a+P+XI/EibuI148/xnL8Klro
         qJGgwwIUlozquGdbTy8nOMzNzTqxsxO7+34WTPYnS3pDIBhYWUgf0ZMZg2MmiFO/nf
         En9mUAm2YLh/8CBk/QOVtDnA4m4p+uOdkzbuahIo=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Sven Eckelmann <sven@narfation.org>,
        Simon Wunderlich <sw@simonwunderlich.de>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.9 04/23] batman-adv: Prevent duplicated nc_node entry
Date:   Mon,  8 Oct 2018 11:26:44 -0400
Message-Id: <20181008152703.70891-4-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181008152703.70891-1-sashal@kernel.org>
References: <20181008152703.70891-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sven Eckelmann <sven@narfation.org>

[ Upstream commit fa122fec8640eb7186ce5a41b83a4c1744ceef8f ]

The function batadv_nc_get_nc_node is responsible for adding new nc_nodes
to the in_coding_list and out_coding_list. It first checks whether the
entry already is in the list or not. If it is, then the creation of a new
entry is aborted.

But the lock for the list is only held when the list is really modified.
This could lead to duplicated entries because another context could create
an entry with the same key between the check and the list manipulation.

The check and the manipulation of the list must therefore be in the same
locked code section.

Fixes: d56b1705e28c ("batman-adv: network coding - detect coding nodes and remove these after timeout")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Acked-by: Marek Lindner <mareklindner@neomailbox.ch>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 net/batman-adv/network-coding.c | 27 +++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/net/batman-adv/network-coding.c b/net/batman-adv/network-coding.c
index e3baf697a35c..a7b5cf08d363 100644
--- a/net/batman-adv/network-coding.c
+++ b/net/batman-adv/network-coding.c
@@ -845,16 +845,27 @@ batadv_nc_get_nc_node(struct batadv_priv *bat_priv,
 	spinlock_t *lock; /* Used to lock list selected by "int in_coding" */
 	struct list_head *list;
 
+	/* Select ingoing or outgoing coding node */
+	if (in_coding) {
+		lock = &orig_neigh_node->in_coding_list_lock;
+		list = &orig_neigh_node->in_coding_list;
+	} else {
+		lock = &orig_neigh_node->out_coding_list_lock;
+		list = &orig_neigh_node->out_coding_list;
+	}
+
+	spin_lock_bh(lock);
+
 	/* Check if nc_node is already added */
 	nc_node = batadv_nc_find_nc_node(orig_node, orig_neigh_node, in_coding);
 
 	/* Node found */
 	if (nc_node)
-		return nc_node;
+		goto unlock;
 
 	nc_node = kzalloc(sizeof(*nc_node), GFP_ATOMIC);
 	if (!nc_node)
-		return NULL;
+		goto unlock;
 
 	/* Initialize nc_node */
 	INIT_LIST_HEAD(&nc_node->list);
@@ -863,22 +874,14 @@ batadv_nc_get_nc_node(struct batadv_priv *bat_priv,
 	kref_get(&orig_neigh_node->refcount);
 	nc_node->orig_node = orig_neigh_node;
 
-	/* Select ingoing or outgoing coding node */
-	if (in_coding) {
-		lock = &orig_neigh_node->in_coding_list_lock;
-		list = &orig_neigh_node->in_coding_list;
-	} else {
-		lock = &orig_neigh_node->out_coding_list_lock;
-		list = &orig_neigh_node->out_coding_list;
-	}
-
 	batadv_dbg(BATADV_DBG_NC, bat_priv, "Adding nc_node %pM -> %pM\n",
 		   nc_node->addr, nc_node->orig_node->orig);
 
 	/* Add nc_node to orig_node */
-	spin_lock_bh(lock);
 	kref_get(&nc_node->refcount);
 	list_add_tail_rcu(&nc_node->list, list);
+
+unlock:
 	spin_unlock_bh(lock);
 
 	return nc_node;
-- 
2.17.1

