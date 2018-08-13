Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5022BC46464
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 21:43:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D85E21756
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 21:43:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D85E21756
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730806AbeHNA15 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 20:27:57 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:45439 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730027AbeHNA15 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 20:27:57 -0400
Received: from wuerfel.lan ([109.193.40.16]) by mrelayeu.kundenserver.de
 (mreue003 [212.227.15.129]) with ESMTPA (Nemesis) id
 0MEJGG-1feGwi0UFU-00FQmY; Mon, 13 Aug 2018 23:43:44 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     "David S. Miller" <davem@davemloft.net>,
        James Chapman <jchapman@katalix.com>,
        Guillaume Nault <g.nault@alphalink.fr>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] l2tp: fix unused function warning
Date:   Mon, 13 Aug 2018 23:43:05 +0200
Message-Id: <20180813214341.3333789-1-arnd@arndb.de>
X-Mailer: git-send-email 2.18.0
X-Provags-ID: V03:K1:QUX99iiomjXNkWr3rDLS1PrwtsQ/ME2ixd+StRJ9a/yILXEi2MN
 IB6QK5Vop6DkAqdKc398hlBNmPAsWvSg4Kq/XkgMbInnhy/n8O3wcxFZ22ICz6p3tpLDhhW
 WHB3bp6OUcurcXKBOaLxFBXfITlG4scsozh1D0YaHpKRxGsPdGTExpXYiZCEkXegP5DtxNP
 cygZi8MCSqeXX+fdV3NDA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:n1VdRkNX6nA=:lkAO9MUC4kgcNq49NEp0zR
 czb7uYaHlMi/dKs0WyxQ+LjS62i7CB+7Mcmkr0y6gzxds8GDK38Vr+QajeI/L39OfvSyN7GXi
 yFTQt65Qe+ZGqaHz/ralIUeKOMGCgDJ0h5ymZLx1wpk4xIbSubf0CqDDB1UH8eswVhkyQJ1Qj
 ok/hq4+CzbuFXiouq+Mc4K9vEOD+DWA2eVroQIRqnGHRQjzv+vjfob9YkBegS8q/iGEDjSmSF
 MMXdSfYchI1nSk7+axNnBBak8buAhw61jh95R2vzUmdNEH1628aa8iy3OEB1l7nlOmkZ4hvg9
 nY5O15yJgMTYBKzJhQbdG+bHi9Hf5437xEF7vYc+rRXumw/t9JRlBJWNA152se9EVDUrr2dEY
 ojvU1xI9B+MeaeNj3e7S9y9CcK8Jq1qy3Zylg0UHSAZaB8lSFe8V8OKzw8km+Y2HS68OzO5RC
 sV4f2tEp9MDZdDeOAFA9EaQkU1r23p0xfgqKpz1TMR7U9gTu2LSo4Wdg5hPsMEDACvjzpFP9N
 8ltpzZAfGIMwZD2grOtDSWH4uhSCFSnWpXS7RVu/nPsNK2PVx3VlfEEeFDaVcNVsCFnAZUS4o
 5zwCNQMNjzx60X18/wGZBVmw7gzGE1ekapiV6y0fPBauaKQs+comhjhjsvfR9b/FvG/NdO7i5
 +7gP5wDSlcF3zIrzkKwNcXpTfBGEN29vsGrDaxOMiVujWJJE4K7ikNXreUhCkMZnrVEg=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Removing one of the callers of pppol2tp_session_get_sock caused a harmless
warning in some configurations:

net/l2tp/l2tp_ppp.c:142:21: 'pppol2tp_session_get_sock' defined but not used [-Wunused-function]

Rather than adding another #ifdef here, using a proper IS_ENABLED()
check makes the code more readable and avoids those warnings while
letting the compiler figure out for itself which code is needed.

This adds one pointer for the unused show() callback in struct
l2tp_session, but that seems harmless.

Fixes: b0e29063dcb3 ("l2tp: remove pppol2tp_session_ioctl()")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 net/l2tp/l2tp_core.h | 2 --
 net/l2tp/l2tp_eth.c  | 7 ++-----
 net/l2tp/l2tp_ppp.c  | 7 ++-----
 3 files changed, 4 insertions(+), 12 deletions(-)

diff --git a/net/l2tp/l2tp_core.h b/net/l2tp/l2tp_core.h
index 8480a0af973e..9c9afe94d389 100644
--- a/net/l2tp/l2tp_core.h
+++ b/net/l2tp/l2tp_core.h
@@ -118,9 +118,7 @@ struct l2tp_session {
 	int (*build_header)(struct l2tp_session *session, void *buf);
 	void (*recv_skb)(struct l2tp_session *session, struct sk_buff *skb, int data_len);
 	void (*session_close)(struct l2tp_session *session);
-#if IS_ENABLED(CONFIG_L2TP_DEBUGFS)
 	void (*show)(struct seq_file *m, void *priv);
-#endif
 	uint8_t			priv[0];	/* private data */
 };
 
diff --git a/net/l2tp/l2tp_eth.c b/net/l2tp/l2tp_eth.c
index 3728986ec885..8aadc4f3bb9e 100644
--- a/net/l2tp/l2tp_eth.c
+++ b/net/l2tp/l2tp_eth.c
@@ -199,7 +199,6 @@ static void l2tp_eth_delete(struct l2tp_session *session)
 	}
 }
 
-#if IS_ENABLED(CONFIG_L2TP_DEBUGFS)
 static void l2tp_eth_show(struct seq_file *m, void *arg)
 {
 	struct l2tp_session *session = arg;
@@ -219,7 +218,6 @@ static void l2tp_eth_show(struct seq_file *m, void *arg)
 
 	dev_put(dev);
 }
-#endif
 
 static void l2tp_eth_adjust_mtu(struct l2tp_tunnel *tunnel,
 				struct l2tp_session *session,
@@ -305,9 +303,8 @@ static int l2tp_eth_create(struct net *net, struct l2tp_tunnel *tunnel,
 
 	session->recv_skb = l2tp_eth_dev_recv;
 	session->session_close = l2tp_eth_delete;
-#if IS_ENABLED(CONFIG_L2TP_DEBUGFS)
-	session->show = l2tp_eth_show;
-#endif
+	if (IS_ENABLED(CONFIG_L2TP_DEBUGFS))
+		session->show = l2tp_eth_show;
 
 	spriv = l2tp_session_priv(session);
 
diff --git a/net/l2tp/l2tp_ppp.c b/net/l2tp/l2tp_ppp.c
index 62f2d3f1e431..04d9946dcdba 100644
--- a/net/l2tp/l2tp_ppp.c
+++ b/net/l2tp/l2tp_ppp.c
@@ -533,7 +533,6 @@ static int pppol2tp_create(struct net *net, struct socket *sock, int kern)
 	return error;
 }
 
-#if IS_ENABLED(CONFIG_L2TP_DEBUGFS)
 static void pppol2tp_show(struct seq_file *m, void *arg)
 {
 	struct l2tp_session *session = arg;
@@ -547,16 +546,14 @@ static void pppol2tp_show(struct seq_file *m, void *arg)
 		sock_put(sk);
 	}
 }
-#endif
 
 static void pppol2tp_session_init(struct l2tp_session *session)
 {
 	struct pppol2tp_session *ps;
 
 	session->recv_skb = pppol2tp_recv;
-#if IS_ENABLED(CONFIG_L2TP_DEBUGFS)
-	session->show = pppol2tp_show;
-#endif
+	if (IS_ENABLED(CONFIG_L2TP_DEBUGFS))
+		session->show = pppol2tp_show;
 
 	ps = l2tp_session_priv(session);
 	mutex_init(&ps->sk_lock);
-- 
2.18.0

