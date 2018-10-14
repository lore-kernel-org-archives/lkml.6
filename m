Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3F65C7112A
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:30:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 920052087D
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:30:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 920052087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728371AbeJNXML (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 19:12:11 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:36473 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728257AbeJNXML (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 19:12:11 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLy-0004io-FP; Sun, 14 Oct 2018 16:30:51 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLU-0000OZ-Bn; Sun, 14 Oct 2018 16:30:20 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "David S. Miller" <davem@davemloft.net>,
        "Guillaume Nault" <g.nault@alphalink.fr>
Date:   Sun, 14 Oct 2018 16:25:41 +0100
Message-ID: <lsq.1539530741.645437329@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 188/366] l2tp: fix {pppol2tp, l2tp_dfs}_seq_stop() in
 case of seq_file overflow
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

commit 5411b6187adf62909e3b998ac782e722904c7487 upstream.

Commit 0e0c3fee3a59 ("l2tp: hold reference on tunnels printed in pppol2tp proc file")
assumed that if pppol2tp_seq_stop() was called with non-NULL private
data (the 'v' pointer), then pppol2tp_seq_start() would not be called
again. It turns out that this isn't guaranteed, and overflowing the
seq_file's buffer in pppol2tp_seq_show() is a way to get into this
situation.

Therefore, pppol2tp_seq_stop() needs to reset pd->tunnel, so that
pppol2tp_seq_start() won't drop a reference again if it gets called.
We also have to clear pd->session, because the rest of the code expects
a non-NULL tunnel when pd->session is set.

The l2tp_debugfs module has the same issue. Fix it in the same way.

Fixes: 0e0c3fee3a59 ("l2tp: hold reference on tunnels printed in pppol2tp proc file")
Fixes: f726214d9b23 ("l2tp: hold reference on tunnels printed in l2tp/tunnels debugfs file")
Signed-off-by: Guillaume Nault <g.nault@alphalink.fr>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 net/l2tp/l2tp_debugfs.c | 5 ++++-
 net/l2tp/l2tp_ppp.c     | 5 ++++-
 2 files changed, 8 insertions(+), 2 deletions(-)

--- a/net/l2tp/l2tp_debugfs.c
+++ b/net/l2tp/l2tp_debugfs.c
@@ -106,8 +106,11 @@ static void l2tp_dfs_seq_stop(struct seq
 		return;
 
 	/* Drop reference taken by last invocation of l2tp_dfs_next_tunnel() */
-	if (pd->tunnel)
+	if (pd->tunnel) {
 		l2tp_tunnel_dec_refcount(pd->tunnel);
+		pd->tunnel = NULL;
+		pd->session = NULL;
+	}
 }
 
 static void l2tp_dfs_seq_tunnel_show(struct seq_file *m, void *v)
--- a/net/l2tp/l2tp_ppp.c
+++ b/net/l2tp/l2tp_ppp.c
@@ -1650,8 +1650,11 @@ static void pppol2tp_seq_stop(struct seq
 		return;
 
 	/* Drop reference taken by last invocation of pppol2tp_next_tunnel() */
-	if (pd->tunnel)
+	if (pd->tunnel) {
 		l2tp_tunnel_dec_refcount(pd->tunnel);
+		pd->tunnel = NULL;
+		pd->session = NULL;
+	}
 }
 
 static void pppol2tp_seq_tunnel_show(struct seq_file *m, void *v)

