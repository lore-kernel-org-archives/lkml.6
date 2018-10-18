Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18631ECDE43
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 17:56:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D543D21473
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 17:55:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="TAO8nghi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D543D21473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728400AbeJSB6C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 21:58:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:45892 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726507AbeJSB6C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 21:58:02 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0AD13204FD;
        Thu, 18 Oct 2018 17:55:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539885357;
        bh=Lh6b0fhrS2x1+Sw4roZgcvzkVVVcDa82/QjQtHAbFL0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TAO8nghis4Ik6G4L31C91utAGz7X8cqVffmGfb0KsmgmdKDCs0WQqblSM9itO+VBa
         JNtxp/brGrcpQHWHvlT/vzKvgS6AVtCL7dyuSz7wKhZ7l4KcgUoB4QSKamTsQrn9FO
         FViRs2DiPEOhEt3wRCIhp80rc1ROv1G61mZXZMV0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sven Eckelmann <sven@narfation.org>,
        Marek Lindner <mareklindner@neomailbox.ch>,
        Simon Wunderlich <sw@simonwunderlich.de>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 10/53] batman-adv: Prevent duplicated nc_node entry
Date:   Thu, 18 Oct 2018 19:54:03 +0200
Message-Id: <20181018175418.614080841@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181018175416.561567978@linuxfoundation.org>
References: <20181018175416.561567978@linuxfoundation.org>
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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/batman-adv/network-coding.c |   27 +++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)

--- a/net/batman-adv/network-coding.c
+++ b/net/batman-adv/network-coding.c
@@ -854,16 +854,27 @@ batadv_nc_get_nc_node(struct batadv_priv
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
@@ -872,22 +883,14 @@ batadv_nc_get_nc_node(struct batadv_priv
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


