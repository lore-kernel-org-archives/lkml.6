Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA3D7C43444
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 13:10:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99B9E2147C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 13:10:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546866609;
	bh=Y94gbgVHyQpdhtX56hBZGVin2CXZAKqPGZEL1qPKtCE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qn97MYHSf4UzOQt5zh/8etqOAK0HPColZhJbgD1F6cj3yex0doXJI+qnCaSJntZef
	 Qdnla4IoogMahnZHBKY1d8eCHmxDYbIdZirNgKOfNXNboTCc1pjIohiu7FN07Uc4Eq
	 tKfwoRCspRHtDUYKspsOsHPcNHv3DuwELKkav4KM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731778AbfAGNJI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 08:09:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:56116 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731760AbfAGNJF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 08:09:05 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 694C12089F;
        Mon,  7 Jan 2019 13:09:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546866543;
        bh=Y94gbgVHyQpdhtX56hBZGVin2CXZAKqPGZEL1qPKtCE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Z+E81eUP87DFTjcQyU4RtVBW1kr+qLMa8bWX8yDWnLn6LjW38A5zlnw8HJQaznamX
         CHNvPz5+bpasuXy7Ou9RkA1Wgcqek8D7tAuMC3chSWF/ZpQp+DX+DsNd1fRRNEMj+T
         QUfNE0UTH0q16HAXgiQPcofY/452GdNZsqlkiBqc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Deepa Dinamani <deepa.kernel@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.9 28/71] sock: Make sock->sk_stamp thread-safe
Date:   Mon,  7 Jan 2019 13:32:57 +0100
Message-Id: <20190107105334.372515682@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190107105330.280153213@linuxfoundation.org>
References: <20190107105330.280153213@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Deepa Dinamani <deepa.kernel@gmail.com>

[ Upstream commit 3a0ed3e9619738067214871e9cb826fa23b2ddb9 ]

Al Viro mentioned (Message-ID
<20170626041334.GZ10672@ZenIV.linux.org.uk>)
that there is probably a race condition
lurking in accesses of sk_stamp on 32-bit machines.

sock->sk_stamp is of type ktime_t which is always an s64.
On a 32 bit architecture, we might run into situations of
unsafe access as the access to the field becomes non atomic.

Use seqlocks for synchronization.
This allows us to avoid using spinlocks for readers as
readers do not need mutual exclusion.

Another approach to solve this is to require sk_lock for all
modifications of the timestamps. The current approach allows
for timestamps to have their own lock: sk_stamp_lock.
This allows for the patch to not compete with already
existing critical sections, and side effects are limited
to the paths in the patch.

The addition of the new field maintains the data locality
optimizations from
commit 9115e8cd2a0c ("net: reorganize struct sock for better data
locality")

Note that all the instances of the sk_stamp accesses
are either through the ioctl or the syscall recvmsg.

Signed-off-by: Deepa Dinamani <deepa.kernel@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/net/sock.h   |   36 ++++++++++++++++++++++++++++++++++--
 net/compat.c         |   15 +++++++++------
 net/core/sock.c      |    3 +++
 net/sunrpc/svcsock.c |    2 +-
 4 files changed, 47 insertions(+), 9 deletions(-)

--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -284,6 +284,7 @@ struct sock_common {
   *	@sk_filter: socket filtering instructions
   *	@sk_timer: sock cleanup timer
   *	@sk_stamp: time stamp of last packet received
+  *	@sk_stamp_seq: lock for accessing sk_stamp on 32 bit architectures only
   *	@sk_tsflags: SO_TIMESTAMPING socket options
   *	@sk_tskey: counter to disambiguate concurrent tstamp requests
   *	@sk_socket: Identd and reporting IO signals
@@ -425,6 +426,9 @@ struct sock {
 	long			sk_sndtimeo;
 	struct timer_list	sk_timer;
 	ktime_t			sk_stamp;
+#if BITS_PER_LONG==32
+	seqlock_t		sk_stamp_seq;
+#endif
 	u16			sk_tsflags;
 	u8			sk_shutdown;
 	u32			sk_tskey;
@@ -2114,6 +2118,34 @@ static inline void sk_drops_add(struct s
 	atomic_add(segs, &sk->sk_drops);
 }
 
+static inline ktime_t sock_read_timestamp(struct sock *sk)
+{
+#if BITS_PER_LONG==32
+	unsigned int seq;
+	ktime_t kt;
+
+	do {
+		seq = read_seqbegin(&sk->sk_stamp_seq);
+		kt = sk->sk_stamp;
+	} while (read_seqretry(&sk->sk_stamp_seq, seq));
+
+	return kt;
+#else
+	return sk->sk_stamp;
+#endif
+}
+
+static inline void sock_write_timestamp(struct sock *sk, ktime_t kt)
+{
+#if BITS_PER_LONG==32
+	write_seqlock(&sk->sk_stamp_seq);
+	sk->sk_stamp = kt;
+	write_sequnlock(&sk->sk_stamp_seq);
+#else
+	sk->sk_stamp = kt;
+#endif
+}
+
 void __sock_recv_timestamp(struct msghdr *msg, struct sock *sk,
 			   struct sk_buff *skb);
 void __sock_recv_wifi_status(struct msghdr *msg, struct sock *sk,
@@ -2138,7 +2170,7 @@ sock_recv_timestamp(struct msghdr *msg,
 	     (sk->sk_tsflags & SOF_TIMESTAMPING_RAW_HARDWARE)))
 		__sock_recv_timestamp(msg, sk, skb);
 	else
-		sk->sk_stamp = kt;
+		sock_write_timestamp(sk, kt);
 
 	if (sock_flag(sk, SOCK_WIFI_STATUS) && skb->wifi_acked_valid)
 		__sock_recv_wifi_status(msg, sk, skb);
@@ -2158,7 +2190,7 @@ static inline void sock_recv_ts_and_drop
 	if (sk->sk_flags & FLAGS_TS_OR_DROPS || sk->sk_tsflags & TSFLAGS_ANY)
 		__sock_recv_ts_and_drops(msg, sk, skb);
 	else
-		sk->sk_stamp = skb->tstamp;
+		sock_write_timestamp(sk, skb->tstamp);
 }
 
 void __sock_tx_timestamp(__u16 tsflags, __u8 *tx_flags);
--- a/net/compat.c
+++ b/net/compat.c
@@ -457,12 +457,14 @@ int compat_sock_get_timestamp(struct soc
 	err = -ENOENT;
 	if (!sock_flag(sk, SOCK_TIMESTAMP))
 		sock_enable_timestamp(sk, SOCK_TIMESTAMP);
-	tv = ktime_to_timeval(sk->sk_stamp);
+	tv = ktime_to_timeval(sock_read_timestamp(sk));
+
 	if (tv.tv_sec == -1)
 		return err;
 	if (tv.tv_sec == 0) {
-		sk->sk_stamp = ktime_get_real();
-		tv = ktime_to_timeval(sk->sk_stamp);
+		ktime_t kt = ktime_get_real();
+		sock_write_timestamp(sk, kt);
+		tv = ktime_to_timeval(kt);
 	}
 	err = 0;
 	if (put_user(tv.tv_sec, &ctv->tv_sec) ||
@@ -485,12 +487,13 @@ int compat_sock_get_timestampns(struct s
 	err = -ENOENT;
 	if (!sock_flag(sk, SOCK_TIMESTAMP))
 		sock_enable_timestamp(sk, SOCK_TIMESTAMP);
-	ts = ktime_to_timespec(sk->sk_stamp);
+	ts = ktime_to_timespec(sock_read_timestamp(sk));
 	if (ts.tv_sec == -1)
 		return err;
 	if (ts.tv_sec == 0) {
-		sk->sk_stamp = ktime_get_real();
-		ts = ktime_to_timespec(sk->sk_stamp);
+		ktime_t kt = ktime_get_real();
+		sock_write_timestamp(sk, kt);
+		ts = ktime_to_timespec(kt);
 	}
 	err = 0;
 	if (put_user(ts.tv_sec, &ctv->tv_sec) ||
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -2467,6 +2467,9 @@ void sock_init_data(struct socket *sock,
 	sk->sk_sndtimeo		=	MAX_SCHEDULE_TIMEOUT;
 
 	sk->sk_stamp = ktime_set(-1L, 0);
+#if BITS_PER_LONG==32
+	seqlock_init(&sk->sk_stamp_seq);
+#endif
 
 #ifdef CONFIG_NET_RX_BUSY_POLL
 	sk->sk_napi_id		=	0;
--- a/net/sunrpc/svcsock.c
+++ b/net/sunrpc/svcsock.c
@@ -572,7 +572,7 @@ static int svc_udp_recvfrom(struct svc_r
 		/* Don't enable netstamp, sunrpc doesn't
 		   need that much accuracy */
 	}
-	svsk->sk_sk->sk_stamp = skb->tstamp;
+	sock_write_timestamp(svsk->sk_sk, skb->tstamp);
 	set_bit(XPT_DATA, &svsk->sk_xprt.xpt_flags); /* there may be more data... */
 
 	len  = skb->len;


