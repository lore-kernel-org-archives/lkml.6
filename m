Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FROM,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A210C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 20:28:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E40192190A
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 20:28:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DpSEw3Wl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390339AbeLUU2C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 15:28:02 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:46703 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388606AbeLUU2B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 15:28:01 -0500
Received: by mail-pf1-f195.google.com with SMTP id c73so3070507pfe.13;
        Fri, 21 Dec 2018 12:27:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=xIRdOhGKRSWRyxL3s5x83RnEVTZuPGUkWvFDmjWCx+I=;
        b=DpSEw3WlTBFxkovyU7WfqVuf3p3qF4kRre2Vsthq2C1jIfVaWCyENkznIvQ7KMybI0
         HdPgafdX9sjzH+lW8j5+j03ggDR6hobxhSXo9s2fQL7tuN7x1rObfv049Q9n9sATkhEE
         c4Bwum1ypf0GtFTSTKOHJaic7Wuw47MleUR9olWKi5IRZ/CMinbH4rtIzDy+NGuvou9q
         Qhq3szgg91cI+Yzx1CwJMuOCtIHr7H73G4pzF+/RJqenW4z7bP45wpiW+Aw3R1bgQdXw
         lKZxIoSkAtAx09LUDLzZg325UBrctvjXiRW3WQAkgoEi4lue2xWROBSnCKAmiin7aiRn
         s1uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=xIRdOhGKRSWRyxL3s5x83RnEVTZuPGUkWvFDmjWCx+I=;
        b=QH/zGIf4F+fGsWBTW9aOBNCbw7iV97GsMQjk5CXiTyaa8ocxNS+XeKp4EbBYtohKtt
         udAXl9gJrUVLi78bZYr6wecXhv9l2Tdtvfw5V0FCDbeIniBZCHO1nWH4zmUapvEOzGp1
         5AxyHioo3lej3QlwN+RcDdqxSNUtM/VAvUxAG2KbWxX/aFzqSa+rYeGmrcgUjbJb3+zu
         YpdRtGtaLyeV69DAXh6q/VBi/CL1npPmtRRmzd9H9e+PCH/TK0FTF+emVAqWeWZZsYsh
         NB4peEriSQs4ndz+pwUw7XRN1WawR3zNZlQsWMR8KNnaKkNEklKI6qLgU+/sl8EEJVlz
         0sbQ==
X-Gm-Message-State: AJcUukehl2VtAdQEqufs6ZTXw8X84xEYSXYwPEHu3/feQWVGtivRSQLo
        1AL2d1cuizk8JwydJxpKujY41QiG
X-Google-Smtp-Source: ALg8bN5BKmh0iWhQNpOXwYCs14fdeVrROdGxSyx3VJWdF5DdSgencF3D8ORM05LOIVkigykVRP1dZw==
X-Received: by 2002:a63:ff16:: with SMTP id k22mr3837689pgi.244.1545424079137;
        Fri, 21 Dec 2018 12:27:59 -0800 (PST)
Received: from deepa-ubuntu.lan (c-98-234-52-230.hsd1.ca.comcast.net. [98.234.52.230])
        by smtp.gmail.com with ESMTPSA id r12sm29108794pgv.83.2018.12.21.12.27.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Dec 2018 12:27:58 -0800 (PST)
From:   Deepa Dinamani <deepa.kernel@gmail.com>
To:     davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     viro@zeniv.linux.org.uk, arnd@arndb.de, y2038@lists.linaro.org
Subject: [PATCH] sock: Make sock->sk_tstamp thread-safe
Date:   Fri, 21 Dec 2018 12:27:33 -0800
Message-Id: <20181221202733.19627-1-deepa.kernel@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Al Viro mentioned that there is probably a race condition
lurking in accesses of sk_tstamp on 32-bit machines.

sock->sk_tstamp is of type ktime_t which is always an s64.
On a 32 bit architecture, we might run into situations of
unsafe access as the access to the field becomes non atomic.

Use seqlocks for synchronization.
This allows us to avoid using spinlocks for readers as
readers do not need mutual exclusion.

Another approach to solve this is to require sk_lock for all
modifications of the timestamps. The current approach allows
for timestamps to have their own lock: sk_tstamp_lock.
This allows for the patch to not compete with already
existing critical sections, and side effects are limited
to the paths in the patch.

The addition of the new field maintains the data locality
optimizations from
commit 9115e8cd2a0c ("net: reorganize struct sock for better data
locality")

Note that all the instances of the sk_tstamp accesses
are either through the ioctl or the syscall recvmsg.

Signed-off-by: Deepa Dinamani <deepa.kernel@gmail.com>
---
 include/net/sock.h | 16 +++++++++++++---
 net/compat.c       | 30 +++++++++++++++++++++++++-----
 net/core/sock.c    | 34 +++++++++++++++++++++++++++++-----
 3 files changed, 67 insertions(+), 13 deletions(-)

diff --git a/include/net/sock.h b/include/net/sock.h
index fe58aec00d09..2cb641606533 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -298,6 +298,7 @@ struct sock_common {
   *	@sk_filter: socket filtering instructions
   *	@sk_timer: sock cleanup timer
   *	@sk_stamp: time stamp of last packet received
+  *	@sk_stamp_seq: lock for accessing sk_stamp
   *	@sk_tsflags: SO_TIMESTAMPING socket options
   *	@sk_tskey: counter to disambiguate concurrent tstamp requests
   *	@sk_zckey: counter to order MSG_ZEROCOPY notifications
@@ -474,6 +475,7 @@ struct sock {
 	const struct cred	*sk_peer_cred;
 	long			sk_rcvtimeo;
 	ktime_t			sk_stamp;
+	seqlock_t		sk_stamp_seq;
 	u16			sk_tsflags;
 	u8			sk_shutdown;
 	u32			sk_tskey;
@@ -2311,8 +2313,11 @@ sock_recv_timestamp(struct msghdr *msg, struct sock *sk, struct sk_buff *skb)
 	    (hwtstamps->hwtstamp &&
 	     (sk->sk_tsflags & SOF_TIMESTAMPING_RAW_HARDWARE)))
 		__sock_recv_timestamp(msg, sk, skb);
-	else
+	else {
+		write_seqlock(&sk->sk_stamp_seq);
 		sk->sk_stamp = kt;
+		write_sequnlock(&sk->sk_stamp_seq);
+	}
 
 	if (sock_flag(sk, SOCK_WIFI_STATUS) && skb->wifi_acked_valid)
 		__sock_recv_wifi_status(msg, sk, skb);
@@ -2332,10 +2337,15 @@ static inline void sock_recv_ts_and_drops(struct msghdr *msg, struct sock *sk,
 
 	if (sk->sk_flags & FLAGS_TS_OR_DROPS || sk->sk_tsflags & TSFLAGS_ANY)
 		__sock_recv_ts_and_drops(msg, sk, skb);
-	else if (unlikely(sock_flag(sk, SOCK_TIMESTAMP)))
+	else if (unlikely(sock_flag(sk, SOCK_TIMESTAMP))) {
+		write_seqlock(&sk->sk_stamp_seq);
 		sk->sk_stamp = skb->tstamp;
-	else if (unlikely(sk->sk_stamp == SK_DEFAULT_STAMP))
+		write_sequnlock(&sk->sk_stamp_seq);
+	} else if (unlikely(sk->sk_stamp == SK_DEFAULT_STAMP)) {
+		write_seqlock(&sk->sk_stamp_seq);
 		sk->sk_stamp = 0;
+		write_sequnlock(&sk->sk_stamp_seq);
+	}
 }
 
 void __sock_tx_timestamp(__u16 tsflags, __u8 *tx_flags);
diff --git a/net/compat.c b/net/compat.c
index 6c9fceeefac0..3022f4941687 100644
--- a/net/compat.c
+++ b/net/compat.c
@@ -459,6 +459,7 @@ int compat_sock_get_timestamp(struct sock *sk, struct timeval __user *userstamp)
 {
 	struct compat_timeval __user *ctv;
 	int err;
+	unsigned int seq;
 	struct timeval tv;
 
 	if (COMPAT_USE_64BIT_TIME)
@@ -467,11 +468,20 @@ int compat_sock_get_timestamp(struct sock *sk, struct timeval __user *userstamp)
 	ctv = (struct compat_timeval __user *) userstamp;
 	err = -ENOENT;
 	sock_enable_timestamp(sk, SOCK_TIMESTAMP);
-	tv = ktime_to_timeval(sk->sk_stamp);
+
+	do {
+		seq = read_seqbegin(&sk->sk_stamp_seq);
+		tv = ktime_to_timeval(sk->sk_stamp);
+	} while (read_seqretry(&sk->sk_stamp_seq, seq));
+
 	if (tv.tv_sec == -1)
 		return err;
 	if (tv.tv_sec == 0) {
-		sk->sk_stamp = ktime_get_real();
+		ktime_t kt = ktime_get_real();
+
+		write_seqlock(&sk->sk_stamp_seq);
+		sk->sk_stamp = kt;
+		write_sequnlock(&sk->sk_stamp_seq);
 		tv = ktime_to_timeval(sk->sk_stamp);
 	}
 	err = 0;
@@ -486,6 +496,7 @@ int compat_sock_get_timestampns(struct sock *sk, struct timespec __user *usersta
 {
 	struct compat_timespec __user *ctv;
 	int err;
+	unsigned int seq;
 	struct timespec ts;
 
 	if (COMPAT_USE_64BIT_TIME)
@@ -494,12 +505,21 @@ int compat_sock_get_timestampns(struct sock *sk, struct timespec __user *usersta
 	ctv = (struct compat_timespec __user *) userstamp;
 	err = -ENOENT;
 	sock_enable_timestamp(sk, SOCK_TIMESTAMP);
-	ts = ktime_to_timespec(sk->sk_stamp);
+
+	do {
+		seq = read_seqbegin(&sk->sk_stamp_seq);
+		ts = ktime_to_timespec(sk->sk_stamp);
+	} while (read_seqretry(&sk->sk_stamp_seq, seq));
+
 	if (ts.tv_sec == -1)
 		return err;
 	if (ts.tv_sec == 0) {
-		sk->sk_stamp = ktime_get_real();
-		ts = ktime_to_timespec(sk->sk_stamp);
+		ktime_t kt = ktime_get_real();
+
+		write_seqlock(&sk->sk_stamp_seq);
+		sk->sk_stamp = kt;
+		write_sequnlock(&sk->sk_stamp_seq);
+		ts = ktime_to_timespec(kt);
 	}
 	err = 0;
 	if (put_user(ts.tv_sec, &ctv->tv_sec) ||
diff --git a/net/core/sock.c b/net/core/sock.c
index f0e0e12b2e0d..a9a99af24a95 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -2783,6 +2783,7 @@ void sock_init_data(struct socket *sock, struct sock *sk)
 	sk->sk_sndtimeo		=	MAX_SCHEDULE_TIMEOUT;
 
 	sk->sk_stamp = SK_DEFAULT_STAMP;
+	seqlock_init(&sk->sk_stamp_seq);
 	atomic_set(&sk->sk_zckey, 0);
 
 #ifdef CONFIG_NET_RX_BUSY_POLL
@@ -2880,15 +2881,27 @@ EXPORT_SYMBOL(lock_sock_fast);
 int sock_get_timestamp(struct sock *sk, struct timeval __user *userstamp)
 {
 	struct timeval tv;
+	unsigned int seq;
 
 	sock_enable_timestamp(sk, SOCK_TIMESTAMP);
-	tv = ktime_to_timeval(sk->sk_stamp);
+
+	do {
+		seq = read_seqbegin(&sk->sk_stamp_seq);
+		tv = ktime_to_timeval(sk->sk_stamp);
+	} while (read_seqretry(&sk->sk_stamp_seq, seq));
+
 	if (tv.tv_sec == -1)
 		return -ENOENT;
 	if (tv.tv_sec == 0) {
-		sk->sk_stamp = ktime_get_real();
-		tv = ktime_to_timeval(sk->sk_stamp);
+		ktime_t kt = ktime_get_real();
+
+		write_seqlock(&sk->sk_stamp_seq);
+		sk->sk_stamp = kt;
+		write_sequnlock(&sk->sk_stamp_seq);
+
+		tv = ktime_to_timeval(kt);
 	}
+
 	return copy_to_user(userstamp, &tv, sizeof(tv)) ? -EFAULT : 0;
 }
 EXPORT_SYMBOL(sock_get_timestamp);
@@ -2896,13 +2909,24 @@ EXPORT_SYMBOL(sock_get_timestamp);
 int sock_get_timestampns(struct sock *sk, struct timespec __user *userstamp)
 {
 	struct timespec ts;
+	unsigned int seq;
 
 	sock_enable_timestamp(sk, SOCK_TIMESTAMP);
-	ts = ktime_to_timespec(sk->sk_stamp);
+
+	do {
+		seq = read_seqbegin(&sk->sk_stamp_seq);
+		ts = ktime_to_timespec(sk->sk_stamp);
+	} while (read_seqretry(&sk->sk_stamp_seq, seq));
+
 	if (ts.tv_sec == -1)
 		return -ENOENT;
 	if (ts.tv_sec == 0) {
-		sk->sk_stamp = ktime_get_real();
+		ktime_t kt = ktime_get_real();
+
+		write_seqlock(&sk->sk_stamp_seq);
+		sk->sk_stamp = kt;
+		write_sequnlock(&sk->sk_stamp_seq);
+
 		ts = ktime_to_timespec(sk->sk_stamp);
 	}
 	return copy_to_user(userstamp, &ts, sizeof(ts)) ? -EFAULT : 0;
-- 
2.17.1

