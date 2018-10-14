Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01854C7112A
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:45:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6EB820645
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:45:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6EB820645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729453AbeJNX1A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 19:27:00 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:37150 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728141AbeJNX1A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 19:27:00 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiM1-0004cF-T5; Sun, 14 Oct 2018 16:30:54 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLS-0000L2-HW; Sun, 14 Oct 2018 16:30:18 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "David S. Miller" <davem@davemloft.net>,
        "Guillaume Nault" <g.nault@alphalink.fr>
Date:   Sun, 14 Oct 2018 16:25:41 +0100
Message-ID: <lsq.1539530741.960330775@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 145/366] l2tp: hold reference on tunnels in netlink dumps
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

commit 5846c131c39b6d0add36ec19dc8650700690f930 upstream.

l2tp_tunnel_find_nth() is unsafe: no reference is held on the returned
tunnel, therefore it can be freed whenever the caller uses it.
This patch defines l2tp_tunnel_get_nth() which works similarly, but
also takes a reference on the returned tunnel. The caller then has to
drop it after it stops using the tunnel.

Convert netlink dumps to make them safe against concurrent tunnel
deletion.

Fixes: 309795f4bec2 ("l2tp: Add netlink control API for L2TP")
Signed-off-by: Guillaume Nault <g.nault@alphalink.fr>
Signed-off-by: David S. Miller <davem@davemloft.net>
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 net/l2tp/l2tp_core.c    | 20 ++++++++++++++++++++
 net/l2tp/l2tp_core.h    |  2 ++
 net/l2tp/l2tp_netlink.c | 11 ++++++++---
 3 files changed, 30 insertions(+), 3 deletions(-)

--- a/net/l2tp/l2tp_core.c
+++ b/net/l2tp/l2tp_core.c
@@ -231,6 +231,26 @@ struct l2tp_tunnel *l2tp_tunnel_get(cons
 }
 EXPORT_SYMBOL_GPL(l2tp_tunnel_get);
 
+struct l2tp_tunnel *l2tp_tunnel_get_nth(const struct net *net, int nth)
+{
+	const struct l2tp_net *pn = l2tp_pernet(net);
+	struct l2tp_tunnel *tunnel;
+	int count = 0;
+
+	rcu_read_lock_bh();
+	list_for_each_entry_rcu(tunnel, &pn->l2tp_tunnel_list, list) {
+		if (++count > nth) {
+			l2tp_tunnel_inc_refcount(tunnel);
+			rcu_read_unlock_bh();
+			return tunnel;
+		}
+	}
+	rcu_read_unlock_bh();
+
+	return NULL;
+}
+EXPORT_SYMBOL_GPL(l2tp_tunnel_get_nth);
+
 /* Like l2tp_session_find() but takes a reference on the returned session.
  * Optionally calls session->ref() too if do_ref is true.
  */
--- a/net/l2tp/l2tp_core.h
+++ b/net/l2tp/l2tp_core.h
@@ -227,6 +227,8 @@ static inline void *l2tp_session_priv(st
 }
 
 struct l2tp_tunnel *l2tp_tunnel_get(const struct net *net, u32 tunnel_id);
+struct l2tp_tunnel *l2tp_tunnel_get_nth(const struct net *net, int nth);
+
 void l2tp_tunnel_free(struct l2tp_tunnel *tunnel);
 
 struct l2tp_session *l2tp_session_get(const struct net *net,
--- a/net/l2tp/l2tp_netlink.c
+++ b/net/l2tp/l2tp_netlink.c
@@ -395,14 +395,17 @@ static int l2tp_nl_cmd_tunnel_dump(struc
 	struct net *net = sock_net(skb->sk);
 
 	for (;;) {
-		tunnel = l2tp_tunnel_find_nth(net, ti);
+		tunnel = l2tp_tunnel_get_nth(net, ti);
 		if (tunnel == NULL)
 			goto out;
 
 		if (l2tp_nl_tunnel_send(skb, NETLINK_CB(cb->skb).portid,
 					cb->nlh->nlmsg_seq, NLM_F_MULTI,
-					tunnel) <= 0)
+					tunnel) <= 0) {
+			l2tp_tunnel_dec_refcount(tunnel);
 			goto out;
+		}
+		l2tp_tunnel_dec_refcount(tunnel);
 
 		ti++;
 	}
@@ -746,7 +749,7 @@ static int l2tp_nl_cmd_session_dump(stru
 
 	for (;;) {
 		if (tunnel == NULL) {
-			tunnel = l2tp_tunnel_find_nth(net, ti);
+			tunnel = l2tp_tunnel_get_nth(net, ti);
 			if (tunnel == NULL)
 				goto out;
 		}
@@ -754,6 +757,7 @@ static int l2tp_nl_cmd_session_dump(stru
 		session = l2tp_session_get_nth(tunnel, si, false);
 		if (session == NULL) {
 			ti++;
+			l2tp_tunnel_dec_refcount(tunnel);
 			tunnel = NULL;
 			si = 0;
 			continue;
@@ -763,6 +767,7 @@ static int l2tp_nl_cmd_session_dump(stru
 					 cb->nlh->nlmsg_seq, NLM_F_MULTI,
 					 session) <= 0) {
 			l2tp_session_dec_refcount(session);
+			l2tp_tunnel_dec_refcount(tunnel);
 			break;
 		}
 		l2tp_session_dec_refcount(session);

