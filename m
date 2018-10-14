Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA2D2C71122
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:47:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B7B820645
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:47:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B7B820645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729632AbeJNX21 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 19:28:27 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:37253 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728125AbeJNX20 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 19:28:26 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiM3-0004co-66; Sun, 14 Oct 2018 16:30:55 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLS-0000KU-Ar; Sun, 14 Oct 2018 16:30:18 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "David S. Miller" <davem@davemloft.net>,
        "Guillaume Nault" <g.nault@alphalink.fr>
Date:   Sun, 14 Oct 2018 16:25:41 +0100
Message-ID: <lsq.1539530741.136803335@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 139/366] l2tp: fix race in duplicate tunnel detection
In-Reply-To: <lsq.1539530740.755408431@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:cbab:f00:c93f:614
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.60-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Guillaume Nault <g.nault@alphalink.fr>

commit f6cd651b056ffd3b4e8496afd44d4ed44bf69136 upstream.

We can't use l2tp_tunnel_find() to prevent l2tp_nl_cmd_tunnel_create()
from creating a duplicate tunnel. A tunnel can be concurrently
registered after l2tp_tunnel_find() returns. Therefore, searching for
duplicates must be done at registration time.

Finally, remove l2tp_tunnel_find() entirely as it isn't use anywhere
anymore.

Fixes: 309795f4bec2 ("l2tp: Add netlink control API for L2TP")
Signed-off-by: Guillaume Nault <g.nault@alphalink.fr>
Signed-off-by: David S. Miller <davem@davemloft.net>
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 net/l2tp/l2tp_core.c    | 35 ++++++++++++++---------------------
 net/l2tp/l2tp_core.h    |  1 -
 net/l2tp/l2tp_netlink.c |  6 ------
 3 files changed, 14 insertions(+), 28 deletions(-)

--- a/net/l2tp/l2tp_core.c
+++ b/net/l2tp/l2tp_core.c
@@ -395,26 +395,6 @@ err_tlock:
 }
 EXPORT_SYMBOL_GPL(l2tp_session_register);
 
-/* Lookup a tunnel by id
- */
-struct l2tp_tunnel *l2tp_tunnel_find(struct net *net, u32 tunnel_id)
-{
-	struct l2tp_tunnel *tunnel;
-	struct l2tp_net *pn = l2tp_pernet(net);
-
-	rcu_read_lock_bh();
-	list_for_each_entry_rcu(tunnel, &pn->l2tp_tunnel_list, list) {
-		if (tunnel->tunnel_id == tunnel_id) {
-			rcu_read_unlock_bh();
-			return tunnel;
-		}
-	}
-	rcu_read_unlock_bh();
-
-	return NULL;
-}
-EXPORT_SYMBOL_GPL(l2tp_tunnel_find);
-
 struct l2tp_tunnel *l2tp_tunnel_find_nth(struct net *net, int nth)
 {
 	struct l2tp_net *pn = l2tp_pernet(net);
@@ -1625,6 +1605,7 @@ static int l2tp_validate_socket(const st
 int l2tp_tunnel_register(struct l2tp_tunnel *tunnel, struct net *net,
 			 struct l2tp_tunnel_cfg *cfg)
 {
+	struct l2tp_tunnel *tunnel_walk;
 	struct l2tp_net *pn;
 	struct socket *sock;
 	struct sock *sk;
@@ -1653,7 +1634,16 @@ int l2tp_tunnel_register(struct l2tp_tun
 	tunnel->l2tp_net = net;
 
 	pn = l2tp_pernet(net);
+
 	spin_lock_bh(&pn->l2tp_tunnel_list_lock);
+	list_for_each_entry(tunnel_walk, &pn->l2tp_tunnel_list, list) {
+		if (tunnel_walk->tunnel_id == tunnel->tunnel_id) {
+			spin_unlock_bh(&pn->l2tp_tunnel_list_lock);
+
+			ret = -EEXIST;
+			goto err_sock;
+		}
+	}
 	list_add_rcu(&tunnel->list, &pn->l2tp_tunnel_list);
 	spin_unlock_bh(&pn->l2tp_tunnel_list_lock);
 
@@ -1683,7 +1673,10 @@ int l2tp_tunnel_register(struct l2tp_tun
 	return 0;
 
 err_sock:
-	sockfd_put(sock);
+	if (tunnel->fd < 0)
+		sock_release(sock);
+	else
+		sockfd_put(sock);
 err:
 	return ret;
 }
--- a/net/l2tp/l2tp_core.h
+++ b/net/l2tp/l2tp_core.h
@@ -240,7 +240,6 @@ struct l2tp_session *l2tp_session_get_nt
 struct l2tp_session *l2tp_session_get_by_ifname(const struct net *net,
 						const char *ifname,
 						bool do_ref);
-struct l2tp_tunnel *l2tp_tunnel_find(struct net *net, u32 tunnel_id);
 struct l2tp_tunnel *l2tp_tunnel_find_nth(struct net *net, int nth);
 
 int l2tp_tunnel_create(struct net *net, int fd, int version, u32 tunnel_id,
--- a/net/l2tp/l2tp_netlink.c
+++ b/net/l2tp/l2tp_netlink.c
@@ -177,12 +177,6 @@ static int l2tp_nl_cmd_tunnel_create(str
 	if (info->attrs[L2TP_ATTR_DEBUG])
 		cfg.debug = nla_get_u32(info->attrs[L2TP_ATTR_DEBUG]);
 
-	tunnel = l2tp_tunnel_find(net, tunnel_id);
-	if (tunnel != NULL) {
-		ret = -EEXIST;
-		goto out;
-	}
-
 	ret = -EINVAL;
 	switch (cfg.encap) {
 	case L2TP_ENCAPTYPE_UDP:

