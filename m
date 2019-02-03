Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E169DC282DA
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 14:31:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB16D2073D
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 14:31:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730109AbfBCObB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 09:31:01 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:55286 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729388AbfBCOUG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 09:20:06 -0500
Received: from cable-78.29.236.164.coditel.net ([78.29.236.164] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqIcu-00069G-AZ; Sun, 03 Feb 2019 14:20:04 +0000
Received: from ben by deadeye with local (Exim 4.92-RC4)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqI9h-0007D9-Pp; Sun, 03 Feb 2019 14:49:53 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Guillaume Nault" <g.nault@alphalink.fr>,
        "David S. Miller" <davem@davemloft.net>,
        "Xin Long" <lucien.xin@gmail.com>, "Jianlin Shi" <jishi@redhat.com>
Date:   Sun, 03 Feb 2019 14:45:08 +0100
Message-ID: <lsq.1549201508.526365184@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 203/305] l2tp: fix a sock refcnt leak in
 l2tp_tunnel_register
In-Reply-To: <lsq.1549201507.384106140@decadent.org.uk>
X-SA-Exim-Connect-IP: 78.29.236.164
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.63-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Xin Long <lucien.xin@gmail.com>

commit f8504f4ca0a0e9f84546ef86e00b24d2ea9a0bd2 upstream.

This issue happens when trying to add an existent tunnel. It
doesn't call sock_put() before returning -EEXIST to release
the sock refcnt that was held by calling sock_hold() before
the existence check.

This patch is to fix it by holding the sock after doing the
existence check.

Fixes: f6cd651b056f ("l2tp: fix race in duplicate tunnel detection")
Reported-by: Jianlin Shi <jishi@redhat.com>
Signed-off-by: Xin Long <lucien.xin@gmail.com>
Reviewed-by: Guillaume Nault <g.nault@alphalink.fr>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 net/l2tp/l2tp_core.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

--- a/net/l2tp/l2tp_core.c
+++ b/net/l2tp/l2tp_core.c
@@ -1627,12 +1627,7 @@ int l2tp_tunnel_register(struct l2tp_tun
 			goto err_sock;
 	}
 
-	sk = sock->sk;
-
-	sock_hold(sk);
-	tunnel->sock = sk;
 	tunnel->l2tp_net = net;
-
 	pn = l2tp_pernet(net);
 
 	spin_lock_bh(&pn->l2tp_tunnel_list_lock);
@@ -1647,6 +1642,10 @@ int l2tp_tunnel_register(struct l2tp_tun
 	list_add_rcu(&tunnel->list, &pn->l2tp_tunnel_list);
 	spin_unlock_bh(&pn->l2tp_tunnel_list_lock);
 
+	sk = sock->sk;
+	sock_hold(sk);
+	tunnel->sock = sk;
+
 	if (tunnel->encap == L2TP_ENCAPTYPE_UDP) {
 		udp_sk(sk)->encap_type = UDP_ENCAP_L2TPINUDP;
 		udp_sk(sk)->encap_rcv = l2tp_udp_encap_recv;

