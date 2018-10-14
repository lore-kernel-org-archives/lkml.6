Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 545D5C7112A
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 16:05:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 236C120645
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 16:05:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 236C120645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727691AbeJNXrF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 19:47:05 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:35635 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726933AbeJNXLl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 19:11:41 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLU-0004cI-T0; Sun, 14 Oct 2018 16:30:21 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLS-0000LC-KC; Sun, 14 Oct 2018 16:30:18 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org,
        "Guillaume Nault" <g.nault@alphalink.fr>,
        "David S. Miller" <davem@davemloft.net>
Date:   Sun, 14 Oct 2018 16:25:41 +0100
Message-ID: <lsq.1539530741.816498408@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 147/366] l2tp: hold reference on tunnels printed in
 l2tp/tunnels debugfs file
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

commit f726214d9b23e5fce8c11937577a289a3202498f upstream.

Use l2tp_tunnel_get_nth() instead of l2tp_tunnel_find_nth(), to be safe
against concurrent tunnel deletion.

Use the same mechanism as in l2tp_ppp.c for dropping the reference
taken by l2tp_tunnel_get_nth(). That is, drop the reference just
before looking up the next tunnel. In case of error, drop the last
accessed tunnel in l2tp_dfs_seq_stop().

That was the last use of l2tp_tunnel_find_nth().

Fixes: 0ad6614048cf ("l2tp: Add debugfs files for dumping l2tp debug info")
Signed-off-by: Guillaume Nault <g.nault@alphalink.fr>
Signed-off-by: David S. Miller <davem@davemloft.net>
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 net/l2tp/l2tp_core.c    | 20 --------------------
 net/l2tp/l2tp_core.h    |  1 -
 net/l2tp/l2tp_debugfs.c | 15 +++++++++++++--
 3 files changed, 13 insertions(+), 23 deletions(-)

--- a/net/l2tp/l2tp_core.c
+++ b/net/l2tp/l2tp_core.c
@@ -415,26 +415,6 @@ err_tlock:
 }
 EXPORT_SYMBOL_GPL(l2tp_session_register);
 
-struct l2tp_tunnel *l2tp_tunnel_find_nth(struct net *net, int nth)
-{
-	struct l2tp_net *pn = l2tp_pernet(net);
-	struct l2tp_tunnel *tunnel;
-	int count = 0;
-
-	rcu_read_lock_bh();
-	list_for_each_entry_rcu(tunnel, &pn->l2tp_tunnel_list, list) {
-		if (++count > nth) {
-			rcu_read_unlock_bh();
-			return tunnel;
-		}
-	}
-
-	rcu_read_unlock_bh();
-
-	return NULL;
-}
-EXPORT_SYMBOL_GPL(l2tp_tunnel_find_nth);
-
 /*****************************************************************************
  * Receive data handling
  *****************************************************************************/
--- a/net/l2tp/l2tp_core.h
+++ b/net/l2tp/l2tp_core.h
@@ -242,7 +242,6 @@ struct l2tp_session *l2tp_session_get_nt
 struct l2tp_session *l2tp_session_get_by_ifname(const struct net *net,
 						const char *ifname,
 						bool do_ref);
-struct l2tp_tunnel *l2tp_tunnel_find_nth(struct net *net, int nth);
 
 int l2tp_tunnel_create(struct net *net, int fd, int version, u32 tunnel_id,
 		       u32 peer_tunnel_id, struct l2tp_tunnel_cfg *cfg,
--- a/net/l2tp/l2tp_debugfs.c
+++ b/net/l2tp/l2tp_debugfs.c
@@ -47,7 +47,11 @@ struct l2tp_dfs_seq_data {
 
 static void l2tp_dfs_next_tunnel(struct l2tp_dfs_seq_data *pd)
 {
-	pd->tunnel = l2tp_tunnel_find_nth(pd->net, pd->tunnel_idx);
+	/* Drop reference taken during previous invocation */
+	if (pd->tunnel)
+		l2tp_tunnel_dec_refcount(pd->tunnel);
+
+	pd->tunnel = l2tp_tunnel_get_nth(pd->net, pd->tunnel_idx);
 	pd->tunnel_idx++;
 }
 
@@ -96,7 +100,14 @@ static void *l2tp_dfs_seq_next(struct se
 
 static void l2tp_dfs_seq_stop(struct seq_file *p, void *v)
 {
-	/* nothing to do */
+	struct l2tp_dfs_seq_data *pd = v;
+
+	if (!pd || pd == SEQ_START_TOKEN)
+		return;
+
+	/* Drop reference taken by last invocation of l2tp_dfs_next_tunnel() */
+	if (pd->tunnel)
+		l2tp_tunnel_dec_refcount(pd->tunnel);
 }
 
 static void l2tp_dfs_seq_tunnel_show(struct seq_file *m, void *v)

