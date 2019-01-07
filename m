Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 053A2C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:37:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFC56206BB
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:37:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546864628;
	bh=iowOMYpdIlvNvVsaui5l3g1Tfv/1734hEYJYhqbiGXY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wklCl64o/lFFVaalDeouoZmx7Q27E4Ge4Lp56KYUemAsxbTFKFP6Gxn0QXdDOSn2L
	 qf/zd4JCPJUD/dnyPpA7PwqpSIufOjwAKhkVlGIe1nqTCNLa4mo2edGrhNWFmKnwUS
	 dWnFwLvd5ICurdDsZKY1GmSIN1cDYqvIOclnz9xo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727765AbfAGMhH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 07:37:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:51942 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726718AbfAGMhG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 07:37:06 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B32412173C;
        Mon,  7 Jan 2019 12:37:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546864625;
        bh=iowOMYpdIlvNvVsaui5l3g1Tfv/1734hEYJYhqbiGXY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ph5T8UUjO3gUS7i41JmxwSA1hMtqZ7gqgWK8kA2WrU+EkhO6Sveri6gj7mNy7Q1kI
         4QxaK8KZanaiuOOTMRJx0ET7rqKAqYSCHa3mlFzBxyuHmQ/RdV4y/mP89ugEMH6/Lw
         JM4txJ2veMQI5EYjeGHs/+e6jIRRIH4EYajkaL88=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Deepa Dinamani <deepa.kernel@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.20 018/145] sock: Make sock->sk_stamp thread-safe
Date:   Mon,  7 Jan 2019 13:30:55 +0100
Message-Id: <20190107104439.656547039@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190107104437.308206189@linuxfoundation.org>
References: <20190107104437.308206189@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

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
 include/net/sock.h   |   38 +++++++++++++++++++++++++++++++++++---
 net/compat.c         |   15 +++++++++------
 net/core/sock.c      |   15 ++++++++++-----
 net/sunrpc/svcsock.c |    2 +-
 4 files changed, 55 insertions(+), 15 deletions(-)

--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -298,6 +298,7 @@ struct sock_common {
   *	@sk_filter: socket filtering instructions
   *	@sk_timer: sock cleanup timer
   *	@sk_stamp: time stamp of last packet received
+  *	@sk_stamp_seq: lock for accessing sk_stamp on 32 bit architectures only
   *	@sk_tsflags: SO_TIMESTAMPING socket options
   *	@sk_tskey: counter to disambiguate concurrent tstamp requests
   *	@sk_zckey: counter to order MSG_ZEROCOPY notifications
@@ -474,6 +475,9 @@ struct sock {
 	const struct cred	*sk_peer_cred;
 	long			sk_rcvtimeo;
 	ktime_t			sk_stamp;
+#if BITS_PER_LONG==32
+	seqlock_t		sk_stamp_seq;
+#endif
 	u16			sk_tsflags;
 	u8			sk_shutdown;
 	u32			sk_tskey;
@@ -2287,6 +2291,34 @@ static inline void sk_drops_add(struct s
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
@@ -2311,7 +2343,7 @@ sock_recv_timestamp(struct msghdr *msg,
 	     (sk->sk_tsflags & SOF_TIMESTAMPING_RAW_HARDWARE)))
 		__sock_recv_timestamp(msg, sk, skb);
 	else
-		sk->sk_stamp = kt;
+		sock_write_timestamp(sk, kt);
 
 	if (sock_flag(sk, SOCK_WIFI_STATUS) && skb->wifi_acked_valid)
 		__sock_recv_wifi_status(msg, sk, skb);
@@ -2332,9 +2364,9 @@ static inline void sock_recv_ts_and_drop
 	if (sk->sk_flags & FLAGS_TS_OR_DROPS || sk->sk_tsflags & TSFLAGS_ANY)
 		__sock_recv_ts_and_drops(msg, sk, skb);
 	else if (unlikely(sock_flag(sk, SOCK_TIMESTAMP)))
-		sk->sk_stamp = skb->tstamp;
+		sock_write_timestamp(sk, skb->tstamp);
 	else if (unlikely(sk->sk_stamp == SK_DEFAULT_STAMP))
-		sk->sk_stamp = 0;
+		sock_write_timestamp(sk, 0);
 }
 
 void __sock_tx_timestamp(__u16 tsflags, __u8 *tx_flags);
--- a/net/compat.c
+++ b/net/compat.c
@@ -467,12 +467,14 @@ int compat_sock_get_timestamp(struct soc
 	ctv = (struct compat_timeval __user *) userstamp;
 	err = -ENOENT;
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
@@ -494,12 +496,13 @@ int compat_sock_get_timestampns(struct s
 	ctv = (struct compat_timespec __user *) userstamp;
 	err = -ENOENT;
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
@@ -2743,6 +2743,9 @@ void sock_init_data(struct socket *sock,
 	sk->sk_sndtimeo		=	MAX_SCHEDULE_TIMEOUT;
 
 	sk->sk_stamp = SK_DEFAULT_STAMP;
+#if BITS_PER_LONG==32
+	seqlock_init(&sk->sk_stamp_seq);
+#endif
 	atomic_set(&sk->sk_zckey, 0);
 
 #ifdef CONFIG_NET_RX_BUSY_POLL
@@ -2842,12 +2845,13 @@ int sock_get_timestamp(struct sock *sk,
 	struct timeval tv;
 
 	sock_enable_timestamp(sk, SOCK_TIMESTAMP);
-	tv = ktime_to_timeval(sk->sk_stamp);
+	tv = ktime_to_timeval(sock_read_timestamp(sk));
 	if (tv.tv_sec == -1)
 		return -ENOENT;
 	if (tv.tv_sec == 0) {
-		sk->sk_stamp = ktime_get_real();
-		tv = ktime_to_timeval(sk->sk_stamp);
+		ktime_t kt = ktime_get_real();
+		sock_write_timestamp(sk, kt);
+		tv = ktime_to_timeval(kt);
 	}
 	return copy_to_user(userstamp, &tv, sizeof(tv)) ? -EFAULT : 0;
 }
@@ -2858,11 +2862,12 @@ int sock_get_timestampns(struct sock *sk
 	struct timespec ts;
 
 	sock_enable_timestamp(sk, SOCK_TIMESTAMP);
-	ts = ktime_to_timespec(sk->sk_stamp);
+	ts = ktime_to_timespec(sock_read_timestamp(sk));
 	if (ts.tv_sec == -1)
 		return -ENOENT;
 	if (ts.tv_sec == 0) {
-		sk->sk_stamp = ktime_get_real();
+		ktime_t kt = ktime_get_real();
+		sock_write_timestamp(sk, kt);
 		ts = ktime_to_timespec(sk->sk_stamp);
 	}
 	return copy_to_user(userstamp, &ts, sizeof(ts)) ? -EFAULT : 0;
--- a/net/sunrpc/svcsock.c
+++ b/net/sunrpc/svcsock.c
@@ -549,7 +549,7 @@ static int svc_udp_recvfrom(struct svc_r
 		/* Don't enable netstamp, sunrpc doesn't
 		   need that much accuracy */
 	}
-	svsk->sk_sk->sk_stamp = skb->tstamp;
+	sock_write_timestamp(svsk->sk_sk, skb->tstamp);
 	set_bit(XPT_DATA, &svsk->sk_xprt.xpt_flags); /* there may be more data... */
 
 	len  = skb->len;


