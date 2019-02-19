Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECEDCC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 21:54:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A935421736
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 21:54:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729821AbfBSVyS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 16:54:18 -0500
Received: from mout.kundenserver.de ([212.227.126.134]:37177 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725994AbfBSVyS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 16:54:18 -0500
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MG9To-1goSWS3fqO-00GV3x; Tue, 19 Feb 2019 22:54:08 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Remi Denis-Courmont <courmisch@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        =?UTF-8?q?R=C3=A9mi=20Denis-Courmont?= <remi@remlab.net>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] phonet: fix building with clang
Date:   Tue, 19 Feb 2019 22:53:50 +0100
Message-Id: <20190219215359.391543-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:9fVfvuRX1S/S6uNzPGpDKAPYIX9mn5gALV8mwlUL86mtNX0kOZ7
 YezzvIFn5tEFc6pjUbExZaUTVBQYz2WMeQXCyVtZODqeMh1TOw4qH/U3wVG+qtsPhX0d15s
 f5giY0w6gUzZKqMOkwqIPH6+UtimaQRaVTUpUiKZOFdKFJJqz7tw3P5uBVdlNjZJhJg8CY0
 hcbB0wqo9+FAnrYV+X+ng==
X-UI-Out-Filterresults: notjunk:1;V03:K0:BvHyZ7ZQG2E=:vE9pN89b/qf9vb933BVxgV
 VH18Uni92bujIMBkFLyldt/XbxHFvWyTkb0M97niKvcU+Vb/2if3z2anRssT6Pcqp1tVcRdVv
 Mt4xEN/ZblQ7NG+p+EqNF/6N6Je3Ju3ieZDnBjr9KMj5a1Ww1QwGnc6PQkUgUgqA1hTMAVIF9
 SrxVd5OGuSkXfW8Tyw3TUARzTHWFqtav2UWv5EbQISLsOQXigvFXDn+5qnW5A4+8bNexeLSgN
 8SP/LrtQehg+Q8HVE4zZX4GzFXsrIVaAMJ+zny9DtEnoGpWi0r5XOREyLeAnfTHpT3eTQzr+A
 5GsIVTQm/OOyqqrvg99UGdreZ0oBuwFqtE/g9K6JFoYlrrKHTcrYsq+dsTiCNphGc8KMVlZtp
 pXF+iApeu6X5gEOKjpVFg8V7yZPRcZMjw/NqWOJKDZK3n6/Vr6RwPt4h435kihR19KAUz1j+T
 6YfPFtwTspRJMqAVtCccgmyh4Fgt1uVHlNR3IDOAXpWy34xkSiSXpq8fgYOwHWc1KoDOQOx2J
 wDkSGfftA3+JPkSSlp07rO0RnM2eZmkwI31HKF1dWpKrydYgg4Hq0Sk0K2oBd8C+DX9fZehbr
 yUQhEPwZ38GUstJG3Ftw78nUUqAPlTQ2S528R5y6PjH0q8nBN91YsZeK8EkeElB88brn6ld/4
 e2O5b+n7bAIT8giK5eOpsg63WazkE358n99Xx8V3mr7OL0oN5KVK9N2z8xjkOlK+Z5DyQuP3L
 SCYeSoxKaiA0zoWK1OZfKtfFie5gbI4/Q89cjw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

clang warns about overflowing the data[] member in the struct pnpipehdr:

net/phonet/pep.c:295:8: warning: array index 4 is past the end of the array (which contains 1 element) [-Warray-bounds]
                        if (hdr->data[4] == PEP_IND_READY)
                            ^         ~
include/net/phonet/pep.h:66:3: note: array 'data' declared here
                u8              data[1];

Using a flexible array member at the end of the struct avoids the
warning, but since we cannot have a flexible array member inside
of the union, each index now has to be moved back by one, which
makes it a little uglier.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 include/net/phonet/pep.h |  5 +++--
 net/phonet/pep.c         | 32 ++++++++++++++++----------------
 2 files changed, 19 insertions(+), 18 deletions(-)

diff --git a/include/net/phonet/pep.h b/include/net/phonet/pep.h
index b669fe6dbc3b..98f31c7ea23d 100644
--- a/include/net/phonet/pep.h
+++ b/include/net/phonet/pep.h
@@ -63,10 +63,11 @@ struct pnpipehdr {
 		u8		state_after_reset;	/* reset request */
 		u8		error_code;		/* any response */
 		u8		pep_type;		/* status indication */
-		u8		data[1];
+		u8		data0;			/* anything else */
 	};
+	u8			data[];
 };
-#define other_pep_type		data[1]
+#define other_pep_type		data[0]
 
 static inline struct pnpipehdr *pnp_hdr(struct sk_buff *skb)
 {
diff --git a/net/phonet/pep.c b/net/phonet/pep.c
index 9fc76b19cd3c..db3473540303 100644
--- a/net/phonet/pep.c
+++ b/net/phonet/pep.c
@@ -132,7 +132,7 @@ static int pep_indicate(struct sock *sk, u8 id, u8 code,
 	ph->utid = 0;
 	ph->message_id = id;
 	ph->pipe_handle = pn->pipe_handle;
-	ph->data[0] = code;
+	ph->error_code = code;
 	return pn_skb_send(sk, skb, NULL);
 }
 
@@ -153,7 +153,7 @@ static int pipe_handler_request(struct sock *sk, u8 id, u8 code,
 	ph->utid = id; /* whatever */
 	ph->message_id = id;
 	ph->pipe_handle = pn->pipe_handle;
-	ph->data[0] = code;
+	ph->error_code = code;
 	return pn_skb_send(sk, skb, NULL);
 }
 
@@ -208,7 +208,7 @@ static int pep_ctrlreq_error(struct sock *sk, struct sk_buff *oskb, u8 code,
 	struct pnpipehdr *ph;
 	struct sockaddr_pn dst;
 	u8 data[4] = {
-		oph->data[0], /* PEP type */
+		oph->pep_type, /* PEP type */
 		code, /* error code, at an unusual offset */
 		PAD, PAD,
 	};
@@ -221,7 +221,7 @@ static int pep_ctrlreq_error(struct sock *sk, struct sk_buff *oskb, u8 code,
 	ph->utid = oph->utid;
 	ph->message_id = PNS_PEP_CTRL_RESP;
 	ph->pipe_handle = oph->pipe_handle;
-	ph->data[0] = oph->data[1]; /* CTRL id */
+	ph->data0 = oph->data[0]; /* CTRL id */
 
 	pn_skb_get_src_sockaddr(oskb, &dst);
 	return pn_skb_send(sk, skb, &dst);
@@ -272,17 +272,17 @@ static int pipe_rcv_status(struct sock *sk, struct sk_buff *skb)
 		return -EINVAL;
 
 	hdr = pnp_hdr(skb);
-	if (hdr->data[0] != PN_PEP_TYPE_COMMON) {
+	if (hdr->pep_type != PN_PEP_TYPE_COMMON) {
 		net_dbg_ratelimited("Phonet unknown PEP type: %u\n",
-				    (unsigned int)hdr->data[0]);
+				    (unsigned int)hdr->pep_type);
 		return -EOPNOTSUPP;
 	}
 
-	switch (hdr->data[1]) {
+	switch (hdr->data[0]) {
 	case PN_PEP_IND_FLOW_CONTROL:
 		switch (pn->tx_fc) {
 		case PN_LEGACY_FLOW_CONTROL:
-			switch (hdr->data[4]) {
+			switch (hdr->data[3]) {
 			case PEP_IND_BUSY:
 				atomic_set(&pn->tx_credits, 0);
 				break;
@@ -292,7 +292,7 @@ static int pipe_rcv_status(struct sock *sk, struct sk_buff *skb)
 			}
 			break;
 		case PN_ONE_CREDIT_FLOW_CONTROL:
-			if (hdr->data[4] == PEP_IND_READY)
+			if (hdr->data[3] == PEP_IND_READY)
 				atomic_set(&pn->tx_credits, wake = 1);
 			break;
 		}
@@ -301,12 +301,12 @@ static int pipe_rcv_status(struct sock *sk, struct sk_buff *skb)
 	case PN_PEP_IND_ID_MCFC_GRANT_CREDITS:
 		if (pn->tx_fc != PN_MULTI_CREDIT_FLOW_CONTROL)
 			break;
-		atomic_add(wake = hdr->data[4], &pn->tx_credits);
+		atomic_add(wake = hdr->data[3], &pn->tx_credits);
 		break;
 
 	default:
 		net_dbg_ratelimited("Phonet unknown PEP indication: %u\n",
-				    (unsigned int)hdr->data[1]);
+				    (unsigned int)hdr->data[0]);
 		return -EOPNOTSUPP;
 	}
 	if (wake)
@@ -318,7 +318,7 @@ static int pipe_rcv_created(struct sock *sk, struct sk_buff *skb)
 {
 	struct pep_sock *pn = pep_sk(sk);
 	struct pnpipehdr *hdr = pnp_hdr(skb);
-	u8 n_sb = hdr->data[0];
+	u8 n_sb = hdr->data0;
 
 	pn->rx_fc = pn->tx_fc = PN_LEGACY_FLOW_CONTROL;
 	__skb_pull(skb, sizeof(*hdr));
@@ -506,7 +506,7 @@ static int pep_connresp_rcv(struct sock *sk, struct sk_buff *skb)
 		return -ECONNREFUSED;
 
 	/* Parse sub-blocks */
-	n_sb = hdr->data[4];
+	n_sb = hdr->data[3];
 	while (n_sb > 0) {
 		u8 type, buf[6], len = sizeof(buf);
 		const u8 *data = pep_get_sb(skb, &type, &len, buf);
@@ -739,7 +739,7 @@ static int pipe_do_remove(struct sock *sk)
 	ph->utid = 0;
 	ph->message_id = PNS_PIPE_REMOVE_REQ;
 	ph->pipe_handle = pn->pipe_handle;
-	ph->data[0] = PAD;
+	ph->data0 = PAD;
 	return pn_skb_send(sk, skb, NULL);
 }
 
@@ -817,7 +817,7 @@ static struct sock *pep_sock_accept(struct sock *sk, int flags, int *errp,
 	peer_type = hdr->other_pep_type << 8;
 
 	/* Parse sub-blocks (options) */
-	n_sb = hdr->data[4];
+	n_sb = hdr->data[3];
 	while (n_sb > 0) {
 		u8 type, buf[1], len = sizeof(buf);
 		const u8 *data = pep_get_sb(skb, &type, &len, buf);
@@ -1109,7 +1109,7 @@ static int pipe_skb_send(struct sock *sk, struct sk_buff *skb)
 	ph->utid = 0;
 	if (pn->aligned) {
 		ph->message_id = PNS_PIPE_ALIGNED_DATA;
-		ph->data[0] = 0; /* padding */
+		ph->data0 = 0; /* padding */
 	} else
 		ph->message_id = PNS_PIPE_DATA;
 	ph->pipe_handle = pn->pipe_handle;
-- 
2.20.0

