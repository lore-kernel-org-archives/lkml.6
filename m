Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96C91ECDE43
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 18:01:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FF8321480
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 18:01:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="BWoxS6Wn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FF8321480
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729642AbeJSCDy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 22:03:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:51966 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726599AbeJSCDx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 22:03:53 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D388E21486;
        Thu, 18 Oct 2018 18:01:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539885707;
        bh=dQYIxbRKvq61FFi656hoCDkLF+f/M+w+Bd3ibE/ooX8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BWoxS6Wn3BORep/KyAqPO/aFPgZp0v96Di3rnvvEKLsVRRycARr4v2I3SQznfADM/
         X+0BMrvcHqVizcnlIeos39rZCxn4xHX1QWE0pXkZ1icEyJVzR+mB/NZ2FcSkeS1bpF
         Nrwad9PByHa0ksPGEhnaHbVKIyb3Ymgy5ZhR4hEk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sven Eckelmann <sven@narfation.org>,
        Marek Lindner <mareklindner@neomailbox.ch>,
        Simon Wunderlich <sw@simonwunderlich.de>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 05/41] batman-adv: Prevent duplicated gateway_node entry
Date:   Thu, 18 Oct 2018 19:54:20 +0200
Message-Id: <20181018175417.512510138@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181018175416.718399607@linuxfoundation.org>
References: <20181018175416.718399607@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sven Eckelmann <sven@narfation.org>

[ Upstream commit dff9bc42ab0b2d38c5e90ddd79b238fed5b4c7ad ]

The function batadv_gw_node_add is responsible for adding new gw_node to
the gateway_list. It is expecting that the caller already checked that
there is not already an entry with the same key or not.

But the lock for the list is only held when the list is really modified.
This could lead to duplicated entries because another context could create
an entry with the same key between the check and the list manipulation.

The check and the manipulation of the list must therefore be in the same
locked code section.

Fixes: c6c8fea29769 ("net: Add batman-adv meshing protocol")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Acked-by: Marek Lindner <mareklindner@neomailbox.ch>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/batman-adv/gateway_client.c |   11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

--- a/net/batman-adv/gateway_client.c
+++ b/net/batman-adv/gateway_client.c
@@ -31,6 +31,7 @@
 #include <linux/kernel.h>
 #include <linux/kref.h>
 #include <linux/list.h>
+#include <linux/lockdep.h>
 #include <linux/netdevice.h>
 #include <linux/netlink.h>
 #include <linux/rculist.h>
@@ -325,6 +326,9 @@ out:
  * @bat_priv: the bat priv with all the soft interface information
  * @orig_node: originator announcing gateway capabilities
  * @gateway: announced bandwidth information
+ *
+ * Has to be called with the appropriate locks being acquired
+ * (gw.list_lock).
  */
 static void batadv_gw_node_add(struct batadv_priv *bat_priv,
 			       struct batadv_orig_node *orig_node,
@@ -332,6 +336,8 @@ static void batadv_gw_node_add(struct ba
 {
 	struct batadv_gw_node *gw_node;
 
+	lockdep_assert_held(&bat_priv->gw.list_lock);
+
 	if (gateway->bandwidth_down == 0)
 		return;
 
@@ -346,10 +352,8 @@ static void batadv_gw_node_add(struct ba
 	gw_node->bandwidth_down = ntohl(gateway->bandwidth_down);
 	gw_node->bandwidth_up = ntohl(gateway->bandwidth_up);
 
-	spin_lock_bh(&bat_priv->gw.list_lock);
 	kref_get(&gw_node->refcount);
 	hlist_add_head_rcu(&gw_node->list, &bat_priv->gw.gateway_list);
-	spin_unlock_bh(&bat_priv->gw.list_lock);
 
 	batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
 		   "Found new gateway %pM -> gw bandwidth: %u.%u/%u.%u MBit\n",
@@ -405,11 +409,14 @@ void batadv_gw_node_update(struct batadv
 {
 	struct batadv_gw_node *gw_node, *curr_gw = NULL;
 
+	spin_lock_bh(&bat_priv->gw.list_lock);
 	gw_node = batadv_gw_node_get(bat_priv, orig_node);
 	if (!gw_node) {
 		batadv_gw_node_add(bat_priv, orig_node, gateway);
+		spin_unlock_bh(&bat_priv->gw.list_lock);
 		goto out;
 	}
+	spin_unlock_bh(&bat_priv->gw.list_lock);
 
 	if ((gw_node->bandwidth_down == ntohl(gateway->bandwidth_down)) &&
 	    (gw_node->bandwidth_up == ntohl(gateway->bandwidth_up)))


