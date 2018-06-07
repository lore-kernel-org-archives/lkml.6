Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 5gpoGDc/GVvVWAAAmS7hNA
	; Thu, 07 Jun 2018 14:20:43 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 4D569608BA; Thu,  7 Jun 2018 14:20:43 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id B64B46063F;
	Thu,  7 Jun 2018 14:20:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B64B46063F
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933467AbeFGOTZ (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 10:19:25 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:39512 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933089AbeFGOJN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 10:09:13 -0400
Received: from [148.252.241.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvbD-0005Zo-Ar; Thu, 07 Jun 2018 15:09:11 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvb9-00038d-TZ; Thu, 07 Jun 2018 15:09:07 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "David S. Miller" <davem@davemloft.net>,
        "Guillaume Nault" <g.nault@alphalink.fr>
Date: Thu, 07 Jun 2018 15:05:21 +0100
Message-ID: <lsq.1528380321.258705553@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 287/410] l2tp: remove l2tp_tunnel_count and
 l2tp_session_count
In-Reply-To: <lsq.1528380320.647747352@decadent.org.uk>
X-SA-Exim-Connect-IP: 148.252.241.226
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.57-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Guillaume Nault <g.nault@alphalink.fr>

commit c7fa745d988812c4dea7dbc645f025c5bfa4917e upstream.

These variables have never been used.

Signed-off-by: Guillaume Nault <g.nault@alphalink.fr>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 net/l2tp/l2tp_core.c | 10 ----------
 1 file changed, 10 deletions(-)

--- a/net/l2tp/l2tp_core.c
+++ b/net/l2tp/l2tp_core.c
@@ -99,8 +99,6 @@ struct l2tp_skb_cb {
 
 #define L2TP_SKB_CB(skb)	((struct l2tp_skb_cb *) &skb->cb[sizeof(struct inet_skb_parm)])
 
-static atomic_t l2tp_tunnel_count;
-static atomic_t l2tp_session_count;
 static struct workqueue_struct *l2tp_wq;
 
 /* per-net private data for this module */
@@ -419,10 +417,6 @@ int l2tp_session_register(struct l2tp_se
 	hlist_add_head(&session->hlist, head);
 	write_unlock_bh(&tunnel->hlist_lock);
 
-	/* Ignore management session in session count value */
-	if (session->session_id != 0)
-		atomic_inc(&l2tp_session_count);
-
 	return 0;
 
 err_tlock_pnlock:
@@ -1327,7 +1321,6 @@ static void l2tp_tunnel_destruct(struct
 	spin_lock_bh(&pn->l2tp_tunnel_list_lock);
 	list_del_rcu(&tunnel->list);
 	spin_unlock_bh(&pn->l2tp_tunnel_list_lock);
-	atomic_dec(&l2tp_tunnel_count);
 
 	l2tp_tunnel_closeall(tunnel);
 
@@ -1749,7 +1742,6 @@ int l2tp_tunnel_create(struct net *net,
 
 	/* Add tunnel to our list */
 	INIT_LIST_HEAD(&tunnel->list);
-	atomic_inc(&l2tp_tunnel_count);
 
 	/* Bump the reference count. The tunnel context is deleted
 	 * only when this drops to zero. Must be done before list insertion
@@ -1795,8 +1787,6 @@ void l2tp_session_free(struct l2tp_sessi
 
 	if (tunnel) {
 		BUG_ON(tunnel->magic != L2TP_TUNNEL_MAGIC);
-		if (session->session_id != 0)
-			atomic_dec(&l2tp_session_count);
 		sock_put(tunnel->sock);
 		session->tunnel = NULL;
 		l2tp_tunnel_dec_refcount(tunnel);
