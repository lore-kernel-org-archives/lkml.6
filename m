Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93DEEC7112A
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 16:04:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 655A620645
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 16:04:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 655A620645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728731AbeJNXqF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 19:46:05 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:35657 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726944AbeJNXLm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 19:11:42 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLV-0004cp-Fr; Sun, 14 Oct 2018 16:30:21 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLS-0000L8-J5; Sun, 14 Oct 2018 16:30:18 +0100
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
Message-ID: <lsq.1539530741.497919690@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 146/366] l2tp: hold reference on tunnels printed in
 pppol2tp proc file
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

commit 0e0c3fee3a59a387aeecc4fca6f3a2e9615a5443 upstream.

Use l2tp_tunnel_get_nth() instead of l2tp_tunnel_find_nth(), to be safe
against concurrent tunnel deletion.

Unlike sessions, we can't drop the reference held on tunnels in
pppol2tp_seq_show(). Tunnels are reused across several calls to
pppol2tp_seq_start() when iterating over sessions. These iterations
need the tunnel for accessing the next session. Therefore the only safe
moment for dropping the reference is just before searching for the next
tunnel.

Normally, the last invocation of pppol2tp_next_tunnel() doesn't find
any new tunnel, so it drops the last tunnel without taking any new
reference. However, in case of error, pppol2tp_seq_stop() is called
directly, so we have to drop the reference there.

Fixes: fd558d186df2 ("l2tp: Split pppol2tp patch into separate l2tp and ppp parts")
Signed-off-by: Guillaume Nault <g.nault@alphalink.fr>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 net/l2tp/l2tp_ppp.c | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

--- a/net/l2tp/l2tp_ppp.c
+++ b/net/l2tp/l2tp_ppp.c
@@ -1583,16 +1583,19 @@ struct pppol2tp_seq_data {
 
 static void pppol2tp_next_tunnel(struct net *net, struct pppol2tp_seq_data *pd)
 {
+	/* Drop reference taken during previous invocation */
+	if (pd->tunnel)
+		l2tp_tunnel_dec_refcount(pd->tunnel);
+
 	for (;;) {
-		pd->tunnel = l2tp_tunnel_find_nth(net, pd->tunnel_idx);
+		pd->tunnel = l2tp_tunnel_get_nth(net, pd->tunnel_idx);
 		pd->tunnel_idx++;
 
-		if (pd->tunnel == NULL)
-			break;
+		/* Only accept L2TPv2 tunnels */
+		if (!pd->tunnel || pd->tunnel->version == 2)
+			return;
 
-		/* Ignore L2TPv3 tunnels */
-		if (pd->tunnel->version < 3)
-			break;
+		l2tp_tunnel_dec_refcount(pd->tunnel);
 	}
 }
 
@@ -1641,7 +1644,14 @@ static void *pppol2tp_seq_next(struct se
 
 static void pppol2tp_seq_stop(struct seq_file *p, void *v)
 {
-	/* nothing to do */
+	struct pppol2tp_seq_data *pd = v;
+
+	if (!pd || pd == SEQ_START_TOKEN)
+		return;
+
+	/* Drop reference taken by last invocation of pppol2tp_next_tunnel() */
+	if (pd->tunnel)
+		l2tp_tunnel_dec_refcount(pd->tunnel);
 }
 
 static void pppol2tp_seq_tunnel_show(struct seq_file *m, void *v)

