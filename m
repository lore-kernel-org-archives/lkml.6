Return-Path: <SRS0=c/ts=OD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B62F2C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 02:22:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72ED320868
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 02:22:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s+Xvl68z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72ED320868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729684AbeKXNIq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Nov 2018 08:08:46 -0500
Received: from mail-yw1-f68.google.com ([209.85.161.68]:37441 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729268AbeKXNIo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Nov 2018 08:08:44 -0500
Received: by mail-yw1-f68.google.com with SMTP id h193so4202609ywc.4;
        Fri, 23 Nov 2018 18:22:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zh7i5tbIrsN4edtqazmXJdbtG+2I6ZFzPoC1MVR2aA4=;
        b=s+Xvl68z+J1iiWOgVafuwucE6JW8qbKGyZxIKOAAaAHyhP8FjhvQ/7Q5yDnN/sHdWL
         eTIvHYBYWgpDLyVVAb9pe5IWekiKO9152KJDd7sUmufBqZobVj6OIYGR66RKlu63yB5o
         neglvsC+/2i1kc8kNvQUM8rDpGK3zB4RpMq3bpiIgqjA4++WHeromHP+3B0F/a+boq7X
         5wXRB+gYc1Ld0/OwILadN8OsmVDSk0FIQR8bnUfpdtYI65jLBYN8tvgvDFqI2ya010xF
         /igZKtzEggF7rewPK1f5c+QOnfUwL3HxsSw1ndGKOniJOuSSTKX6vZLCgK1czMvdgwyR
         nqfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zh7i5tbIrsN4edtqazmXJdbtG+2I6ZFzPoC1MVR2aA4=;
        b=f6CsFLuHNC7dGwSimGy9ZR0MhLQG4TXjWLToAojR8vQ+HzmydPg13jwfqt9CkEOU7+
         0tnURmLOAkj3bfa4SyDMbHQJeu5uPG2aczpbfLGaps2MP7Wl4xkelrO610crmsd2HeGT
         Jgu4oniLgMlBD93nZZx7kpST+J3CyBORSzWFku84vyeTnRlI8YWJ0/3PFonhFEl8cNeo
         3cJ0vDwXS2XYYiTYSo+RMUDpDTT+LY9j+NmjqpqCZwEhYIhpibQCg5GXKbWk5ioKsmmn
         MDwSfcevXspWfv5hJMDJJWWVsMIefQ8/FlIFo+gqTjMv9CBmAK7x9cIdpeNuh5bYMZhO
         IJdw==
X-Gm-Message-State: AGRZ1gJ9VoVGoezQCi61aZ+tK5mc2xtCAbmqYM3p9Ynjl3LiHKipCKeK
        +qUH5tXFBaDEXiRo0o7YcuE=
X-Google-Smtp-Source: AJdET5eE1jZWre3SNifvVBaF9m1OuDJ+87dyuivyrXWFMYTZPTCrGhQ85/e75LUp/n+r95k3ILcFpQ==
X-Received: by 2002:a81:2b89:: with SMTP id r131-v6mr19284361ywr.286.1543026126471;
        Fri, 23 Nov 2018 18:22:06 -0800 (PST)
Received: from deepa-ubuntu.lan (c-98-234-52-213.hsd1.ca.comcast.net. [98.234.52.213])
        by smtp.gmail.com with ESMTPSA id w1sm6947292ywd.49.2018.11.23.18.22.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Nov 2018 18:22:05 -0800 (PST)
From:   Deepa Dinamani <deepa.kernel@gmail.com>
To:     davem@davemloft.net, linux-kernel@vger.kernel.org
Cc:     netdev@vger.kernel.org, viro@zeniv.linux.org.uk, arnd@arndb.de,
        y2038@lists.linaro.org
Subject: [PATCH 3/8] socket: Disentangle SOCK_RCVTSTAMPNS from SOCK_RCVTSTAMP
Date:   Fri, 23 Nov 2018 18:20:30 -0800
Message-Id: <20181124022035.17519-4-deepa.kernel@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181124022035.17519-1-deepa.kernel@gmail.com>
References: <20181124022035.17519-1-deepa.kernel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SOCK_RCVTSTAMPNS is never set alone. SOCK_RCVTSTAMP
is always set along with SOCK_RCVTSTAMPNS. This leads to
checking for two flag states whenever we need to check for
SOCK_RCVTSTAMPS.

Also SOCK_RCVTSTAMPS was the only flag that needed to be
checked in order to verify if either of the two flags are
set. But, the two features are not actually dependent on
each other. This artificial dependency creates more
confusion.
The change does away with this logic as well.

Note that RDS seems to be supporting only SO_TIMESTAMP at
SOL_RDS level. And, it uses the same SOCK_RCVTSTAMP to track
this. Hence, the updates to rds_incoming->i_rx_tstamp only
track SOCK_RCVTSTAMP and not SOCK_RCVTSTAMPNS.

Signed-off-by: Deepa Dinamani <deepa.kernel@gmail.com>
---
 include/net/sock.h |  4 +++-
 net/core/sock.c    | 37 ++++++++++++++++++++++++-------------
 net/ipv4/tcp.c     | 20 +++++++++-----------
 net/socket.c       |  3 ++-
 net/unix/af_unix.c |  4 ++--
 5 files changed, 40 insertions(+), 28 deletions(-)

diff --git a/include/net/sock.h b/include/net/sock.h
index f665d74ae509..8143c4c1a49d 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -2305,6 +2305,7 @@ sock_recv_timestamp(struct msghdr *msg, struct sock *sk, struct sk_buff *skb)
 	 * - hardware time stamps available and wanted
 	 */
 	if (sock_flag(sk, SOCK_RCVTSTAMP) ||
+		sock_flag(sk, SOCK_RCVTSTAMPNS) ||
 	    (sk->sk_tsflags & SOF_TIMESTAMPING_RX_SOFTWARE) ||
 	    (kt && sk->sk_tsflags & SOF_TIMESTAMPING_SOFTWARE) ||
 	    (hwtstamps->hwtstamp &&
@@ -2325,7 +2326,8 @@ static inline void sock_recv_ts_and_drops(struct msghdr *msg, struct sock *sk,
 					  struct sk_buff *skb)
 {
 #define FLAGS_TS_OR_DROPS ((1UL << SOCK_RXQ_OVFL)			| \
-			   (1UL << SOCK_RCVTSTAMP))
+			   (1UL << SOCK_RCVTSTAMP)			| \
+			   (1UL << SOCK_RCVTSTAMPNS))
 #define TSFLAGS_ANY	  (SOF_TIMESTAMPING_SOFTWARE			| \
 			   SOF_TIMESTAMPING_RAW_HARDWARE)
 
diff --git a/net/core/sock.c b/net/core/sock.c
index cf990db9b2a0..e60036618205 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -647,6 +647,28 @@ bool sk_mc_loop(struct sock *sk)
 }
 EXPORT_SYMBOL(sk_mc_loop);
 
+static void setsockopt_timestamp(struct sock *sk, int type, int val)
+{
+	if (!val) {
+		sock_reset_flag(sk, SOCK_RCVTSTAMP);
+		sock_reset_flag(sk, SOCK_RCVTSTAMPNS);
+		return;
+	}
+
+	switch (type) {
+	case SO_TIMESTAMP_OLD:
+		sock_reset_flag(sk, SOCK_RCVTSTAMPNS);
+		sock_set_flag(sk, SOCK_RCVTSTAMP);
+		break;
+	case SO_TIMESTAMPNS_OLD:
+		sock_reset_flag(sk, SOCK_RCVTSTAMP);
+		sock_set_flag(sk, SOCK_RCVTSTAMPNS);
+		break;
+	}
+
+	sock_enable_timestamp(sk, SOCK_TIMESTAMP);
+}
+
 /*
  *	This is meant for all protocols to use and covers goings on
  *	at the socket level. Everything here is generic.
@@ -816,17 +838,7 @@ int sock_setsockopt(struct socket *sock, int level, int optname,
 
 	case SO_TIMESTAMP_OLD:
 	case SO_TIMESTAMPNS_OLD:
-		if (valbool)  {
-			if (optname == SO_TIMESTAMP_OLD)
-				sock_reset_flag(sk, SOCK_RCVTSTAMPNS);
-			else
-				sock_set_flag(sk, SOCK_RCVTSTAMPNS);
-			sock_set_flag(sk, SOCK_RCVTSTAMP);
-			sock_enable_timestamp(sk, SOCK_TIMESTAMP);
-		} else {
-			sock_reset_flag(sk, SOCK_RCVTSTAMP);
-			sock_reset_flag(sk, SOCK_RCVTSTAMPNS);
-		}
+		setsockopt_timestamp(sk, optname, valbool);
 		break;
 
 	case SO_TIMESTAMPING_OLD:
@@ -1183,8 +1195,7 @@ int sock_getsockopt(struct socket *sock, int level, int optname,
 		break;
 
 	case SO_TIMESTAMP_OLD:
-		v.val = sock_flag(sk, SOCK_RCVTSTAMP) &&
-				!sock_flag(sk, SOCK_RCVTSTAMPNS);
+		v.val = sock_flag(sk, SOCK_RCVTSTAMP);
 		break;
 
 	case SO_TIMESTAMPNS_OLD:
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 496848ab0269..d6eb5f542fcf 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -1868,17 +1868,15 @@ static void tcp_recv_timestamp(struct msghdr *msg, const struct sock *sk,
 	bool has_timestamping = false;
 
 	if (tss->ts[0].tv_sec || tss->ts[0].tv_nsec) {
-		if (sock_flag(sk, SOCK_RCVTSTAMP)) {
-			if (sock_flag(sk, SOCK_RCVTSTAMPNS)) {
-				put_cmsg(msg, SOL_SOCKET, SO_TIMESTAMPNS_OLD,
-					 sizeof(tss->ts[0]), &tss->ts[0]);
-			} else {
-				tv.tv_sec = tss->ts[0].tv_sec;
-				tv.tv_usec = tss->ts[0].tv_nsec / 1000;
-
-				put_cmsg(msg, SOL_SOCKET, SO_TIMESTAMP_OLD,
-					 sizeof(tv), &tv);
-			}
+		if (sock_flag(sk, SOCK_RCVTSTAMPNS)) {
+			put_cmsg(msg, SOL_SOCKET, SO_TIMESTAMPNS_OLD,
+				 sizeof(tss->ts[0]), &tss->ts[0]);
+		} else if (sock_flag(sk, SOCK_RCVTSTAMP)) {
+			tv.tv_sec = tss->ts[0].tv_sec;
+			tv.tv_usec = tss->ts[0].tv_nsec / 1000;
+
+			put_cmsg(msg, SOL_SOCKET, SO_TIMESTAMP_OLD,
+				 sizeof(tv), &tv);
 		}
 
 		if (sk->sk_tsflags & SOF_TIMESTAMPING_SOFTWARE)
diff --git a/net/socket.c b/net/socket.c
index dfc5742ccfbb..c7455349a3c1 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -701,11 +701,12 @@ static void put_ts_pktinfo(struct msghdr *msg, struct sk_buff *skb)
 
 /*
  * called from sock_recv_timestamp() if sock_flag(sk, SOCK_RCVTSTAMP)
+ * or sock_flag(sk, SOCK_RCVTSTAMPNS)
  */
 void __sock_recv_timestamp(struct msghdr *msg, struct sock *sk,
 	struct sk_buff *skb)
 {
-	int need_software_tstamp = sock_flag(sk, SOCK_RCVTSTAMP);
+	int need_software_tstamp = sock_flag(sk, SOCK_RCVTSTAMP) || sock_flag(sk, SOCK_RCVTSTAMPNS);
 	struct scm_timestamping tss;
 	int empty = 1, false_tstamp = 0;
 	struct skb_shared_hwtstamps *shhwtstamps =
diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 74d1eed7cbd4..531efd0ddeb1 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -1798,7 +1798,7 @@ static int unix_dgram_sendmsg(struct socket *sock, struct msghdr *msg,
 	if (unlikely(sk_locked))
 		unix_state_unlock(sk);
 
-	if (sock_flag(other, SOCK_RCVTSTAMP))
+	if (sock_flag(other, SOCK_RCVTSTAMP) || sock_flag(other, SOCK_RCVTSTAMPNS))
 		__net_timestamp(skb);
 	maybe_add_creds(skb, sock, other);
 	skb_queue_tail(&other->sk_receive_queue, skb);
@@ -2141,7 +2141,7 @@ static int unix_dgram_recvmsg(struct socket *sock, struct msghdr *msg,
 	if (err)
 		goto out_free;
 
-	if (sock_flag(sk, SOCK_RCVTSTAMP))
+	if (sock_flag(sk, SOCK_RCVTSTAMP) || sock_flag(sk, SOCK_RCVTSTAMPNS))
 		__sock_recv_timestamp(msg, sk, skb);
 
 	memset(&scm, 0, sizeof(scm));
-- 
2.17.1

