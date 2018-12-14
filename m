Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CACB7C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 21:12:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1FB02080F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 21:12:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="IZ7K5eYh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731109AbeLNVMp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 16:12:45 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:44962 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730757AbeLNVMp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 16:12:45 -0500
Received: by mail-lf1-f68.google.com with SMTP id z13so5265448lfe.11
        for <linux-kernel@vger.kernel.org>; Fri, 14 Dec 2018 13:12:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ayXodJU59wzJNPigsWiwer1kLPrNiQ7AuIEJaBjTXl0=;
        b=IZ7K5eYhQXgvgeAg4dskOoBR9E57dK95gTN9G1kY6rpSUv14fBp/LO+Ok7aA2XKdEv
         8Pge5CEgun+aExl/4ol1Cmlzjm+C3Kk1pOwgedPky7InM/FM6bL5BZ3Pdu3QDYbIu1Wj
         6RojxIqvXQur4MvHmep7ovuUHfc4OTrq08tYI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ayXodJU59wzJNPigsWiwer1kLPrNiQ7AuIEJaBjTXl0=;
        b=owSkd9yNYivMCPlVsZREHuwNwKE3ayFf9XfjL+aqYou5hD0XbVhL+3OgBpv6xT2GEf
         ZD9CzXcYvQmsYLSTIXnT0Uv/PVMRWVpHGb0XNj7Pq3cj9jcN22bDiXq9PfHz2ieVz21z
         YoHZz+DvvS09hWUak439XHyzuWZ1/sjukIBhzPobakbPv4YUd3wFzLRQsdEbV3FK2wuZ
         gdup5kkF/l7d4TuP4fazyO/WJgPbDHOf7lZAh2Kc5zC8MVIXZVtF83SECKopkJODigIH
         RxZ2Eox2FtHS8LT9MoWnBE6LrIuKDC8mhzagWJlGp5XSDjZKkbwNyNMcBZLoAZhQ2PTV
         GZow==
X-Gm-Message-State: AA+aEWa0W43wAZCrkM1LbhyjcMjN/DlGuoV09Q4zMfvX16TLuk2ElA+i
        UIN2JLlKp9YxtSIo4AsXKHvZKA==
X-Google-Smtp-Source: AFSGD/VPLx+SYteFumr8F09pzsmGQrgXBFuPDW0elK399HdvJTFC9UlUaXnwGPBGfz/ZEGdYrFqj1A==
X-Received: by 2002:a19:5f1e:: with SMTP id t30mr2576767lfb.76.1544821963322;
        Fri, 14 Dec 2018 13:12:43 -0800 (PST)
Received: from localhost ([195.238.92.132])
        by smtp.gmail.com with ESMTPSA id k68-v6sm1046377ljb.35.2018.12.14.13.12.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 14 Dec 2018 13:12:42 -0800 (PST)
From:   Sam Protsenko <semen.protsenko@linaro.org>
To:     James Chapman <jchapman@katalix.com>,
        "David S. Miller" <davem@davemloft.net>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Guillaume Nault <g.nault@alphalink.fr>
Subject: [PATCH 1/2] l2tp: Bring back ->flags to struct pppol2tp_session
Date:   Fri, 14 Dec 2018 23:12:41 +0200
Message-Id: <20181214211242.9721-1-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Flags field will be used in further commits (e.g. for keeping
SC_COMP_PROT), so let's bring those back. This commit effectively
reverts commit 1998b5ed9c9b ("l2tp: drop ->flags from struct
pppol2tp_session"), with some cosmetic changes.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
 net/l2tp/l2tp_ppp.c | 52 +++++++++++++++++++++++++++++----------------
 1 file changed, 34 insertions(+), 18 deletions(-)

diff --git a/net/l2tp/l2tp_ppp.c b/net/l2tp/l2tp_ppp.c
index c03c6461f236..145435977b21 100644
--- a/net/l2tp/l2tp_ppp.c
+++ b/net/l2tp/l2tp_ppp.c
@@ -125,6 +125,7 @@ struct pppol2tp_session {
 						 * PPPoX socket */
 	struct sock		*__sk;		/* Copy of .sk, for cleanup */
 	struct rcu_head		rcu;		/* For asynchronous release */
+	int			flags;		/* accessed by PPPIOCGFLAGS */
 };
 
 static int pppol2tp_xmit(struct ppp_channel *chan, struct sk_buff *skb);
@@ -1074,44 +1075,60 @@ static int pppol2tp_ioctl(struct socket *sock, unsigned int cmd,
 {
 	struct pppol2tp_ioc_stats stats;
 	struct l2tp_session *session;
+	struct pppol2tp_session *ps;
 	int val;
+	bool is_tunnel;
+
+	session = sock->sk->sk_user_data;
+	if (!session)
+		return -ENOTCONN;
+
+	ps = l2tp_session_priv(session);
+	is_tunnel = !session->session_id && !session->peer_session_id;
 
 	switch (cmd) {
 	case PPPIOCGMRU:
-	case PPPIOCGFLAGS:
-		session = sock->sk->sk_user_data;
-		if (!session)
-			return -ENOTCONN;
-
 		/* Not defined for tunnels */
-		if (!session->session_id && !session->peer_session_id)
+		if (is_tunnel)
 			return -ENOSYS;
 
 		if (put_user(0, (int __user *)arg))
 			return -EFAULT;
 		break;
+	case PPPIOCGFLAGS:
+		/* Not defined for tunnels */
+		if (is_tunnel)
+			return -ENOSYS;
 
-	case PPPIOCSMRU:
-	case PPPIOCSFLAGS:
-		session = sock->sk->sk_user_data;
-		if (!session)
-			return -ENOTCONN;
+		if (put_user(ps->flags, (int __user *)arg))
+			return -EFAULT;
 
+		l2tp_info(session, L2TP_MSG_CONTROL, "%s: get flags=%d\n",
+			  session->name, ps->flags);
+		break;
+	case PPPIOCSMRU:
 		/* Not defined for tunnels */
-		if (!session->session_id && !session->peer_session_id)
+		if (is_tunnel)
 			return -ENOSYS;
 
 		if (get_user(val, (int __user *)arg))
 			return -EFAULT;
 		break;
+	case PPPIOCSFLAGS:
+		/* Not defined for tunnels */
+		if (is_tunnel)
+			return -ENOSYS;
 
-	case PPPIOCGL2TPSTATS:
-		session = sock->sk->sk_user_data;
-		if (!session)
-			return -ENOTCONN;
+		if (get_user(val, (int __user *)arg))
+			return -EFAULT;
 
+		ps->flags = val;
+		l2tp_info(session, L2TP_MSG_CONTROL, "%s: set flags=%d\n",
+			  session->name, ps->flags);
+		break;
+	case PPPIOCGL2TPSTATS:
 		/* Session 0 represents the parent tunnel */
-		if (!session->session_id && !session->peer_session_id) {
+		if (is_tunnel) {
 			u32 session_id;
 			int err;
 
@@ -1136,7 +1153,6 @@ static int pppol2tp_ioctl(struct socket *sock, unsigned int cmd,
 		if (copy_to_user((void __user *)arg, &stats, sizeof(stats)))
 			return -EFAULT;
 		break;
-
 	default:
 		return -ENOIOCTLCMD;
 	}
-- 
2.19.1

