Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1472C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 05:23:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AAFD2087E
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 05:23:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bTm5iHsc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727757AbfAHFXg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 00:23:36 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:39277 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725800AbfAHFXg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 00:23:36 -0500
Received: by mail-pl1-f194.google.com with SMTP id 101so1293129pld.6;
        Mon, 07 Jan 2019 21:23:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qlZNbPAO/J9Uvse4XP1zTWd0WA+l2Rw7kNOKGh7RDBI=;
        b=bTm5iHscvl68zC9mxYTeUxZ54NnEuW7J7294APLsNviavHRpbwCp4tYFz5ezV/lT4R
         md/wQ4SjpbCOHWaLVqX61PmBmDtotUMQRa1CYMqrlzLxq0TKJsBHYCaGAb2Zv5BcDi+4
         kDz2VrwbsK0W1pz8maJIFEwoEQs1bn2NlkmKop591Tvs0SsjdrkjiRUevL3bwUznChpA
         d2JDX2nfikTDeEUkaqkkSCUar7QMRaDgOm/IbSpYy2qZPmhYXTY8BOESpyixH2umdhkt
         pOfxyh6wwc6vqX95e5YfZsoJNwuuXkt83T7aUOr8LP2T2YgzEI9yMDkIayplbfyJueFA
         Oc8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qlZNbPAO/J9Uvse4XP1zTWd0WA+l2Rw7kNOKGh7RDBI=;
        b=tBLJpB9Cx2k6YVPK1CvhdRQt/e6ghPiY7yzZsi1HL0ZJTg94qvrrz96115YcUbJTDT
         twmKDPZkdhRRmmU19AzZJ3Oii4CoyXPFnrF7KZphQ2H/8A5Dh1VpcqKQWBTw0eTKT/CK
         Rk4HV1lndExaLbTbrvMaWK3OZfe5iwcOyAgLvPeAN99dJL0gFYET7nWRjOmC4iSjgGij
         B7f+14bxCEM4crmlpZ0VETectucGugy2qgIILOByblMq9N1fSg/2An/8qu49IYeLU0eL
         /zrNOki4sP44tgb6cgP5KD29OUDVUiiZ4ToBONJuHS2/ulPdzyRSm5qSPgV2g+P34Qbu
         +vPA==
X-Gm-Message-State: AJcUukfiExbaonxz1qq0gh53+Y8xBzHcmwVIDPiBPjKWGp2CkxFA2OkC
        4Ja+LyQmMiUuvbCU6Pdw96w=
X-Google-Smtp-Source: ALg8bN5qJWgM2NqN9rf4TsDadT2YZr9Y4MDsUjP3cOoGCjBhAdsYIMOm8pvJaalJHiRBnFkhyWZ3Vw==
X-Received: by 2002:a17:902:6a4:: with SMTP id 33mr365443plh.99.1546925015480;
        Mon, 07 Jan 2019 21:23:35 -0800 (PST)
Received: from deepa-ubuntu.lan (c-98-234-52-230.hsd1.ca.comcast.net. [98.234.52.230])
        by smtp.gmail.com with ESMTPSA id x127sm102710626pfd.156.2019.01.07.21.23.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Jan 2019 21:23:35 -0800 (PST)
From:   Deepa Dinamani <deepa.kernel@gmail.com>
To:     davem@davemloft.net, linux-kernel@vger.kernel.org
Cc:     netdev@vger.kernel.org, arnd@arndb.de, y2038@lists.linaro.org
Subject: [PATCH 1/3] socket: Use old_timeval types for socket timeouts
Date:   Mon,  7 Jan 2019 21:22:53 -0800
Message-Id: <20190108052255.10699-2-deepa.kernel@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190108052255.10699-1-deepa.kernel@gmail.com>
References: <20190108052255.10699-1-deepa.kernel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As part of y2038 solution, all internal uses of
struct timeval are replaced by struct __kernel_old_timeval
and struct compat_timeval by struct old_timeval32.
Make socket timeouts use these new types.

This is mainly to be able to verify that the kernel build
is y2038 safe when such non y2038 safe types are not
supported anymore.

Signed-off-by: Deepa Dinamani <deepa.kernel@gmail.com>
---
 net/compat.c             | 10 +++++-----
 net/core/sock.c          |  8 ++++----
 net/vmw_vsock/af_vsock.c |  4 ++--
 3 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/net/compat.c b/net/compat.c
index b6ff0899e424..cbc15f65033c 100644
--- a/net/compat.c
+++ b/net/compat.c
@@ -351,8 +351,8 @@ static int do_set_attach_filter(struct socket *sock, int level, int optname,
 static int do_set_sock_timeout(struct socket *sock, int level,
 		int optname, char __user *optval, unsigned int optlen)
 {
-	struct compat_timeval __user *up = (struct compat_timeval __user *)optval;
-	struct timeval ktime;
+	struct old_timeval32 __user *up = (struct old_timeval32 __user *)optval;
+	struct __kernel_old_timeval ktime;
 	mm_segment_t old_fs;
 	int err;
 
@@ -420,12 +420,12 @@ COMPAT_SYSCALL_DEFINE5(setsockopt, int, fd, int, level, int, optname,
 static int do_get_sock_timeout(struct socket *sock, int level, int optname,
 		char __user *optval, int __user *optlen)
 {
-	struct compat_timeval __user *up;
-	struct timeval ktime;
+	struct old_timeval32 __user *up;
+	struct __kernel_old_timeval ktime;
 	mm_segment_t old_fs;
 	int len, err;
 
-	up = (struct compat_timeval __user *)optval;
+	up = (struct old_timeval32 __user *)optval;
 	if (get_user(len, optlen))
 		return -EFAULT;
 	if (len < sizeof(*up))
diff --git a/net/core/sock.c b/net/core/sock.c
index 78df5228ffbd..af0fb33624e2 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -337,7 +337,7 @@ EXPORT_SYMBOL(__sk_backlog_rcv);
 
 static int sock_set_timeout(long *timeo_p, char __user *optval, int optlen)
 {
-	struct timeval tv;
+	struct __kernel_old_timeval tv;
 
 	if (optlen < sizeof(tv))
 		return -EINVAL;
@@ -1113,7 +1113,7 @@ int sock_getsockopt(struct socket *sock, int level, int optname,
 		int val;
 		u64 val64;
 		struct linger ling;
-		struct timeval tm;
+		struct __kernel_old_timeval tm;
 		struct sock_txtime txtime;
 	} v;
 
@@ -1223,7 +1223,7 @@ int sock_getsockopt(struct socket *sock, int level, int optname,
 		break;
 
 	case SO_RCVTIMEO:
-		lv = sizeof(struct timeval);
+		lv = sizeof(struct __kernel_old_timeval);
 		if (sk->sk_rcvtimeo == MAX_SCHEDULE_TIMEOUT) {
 			v.tm.tv_sec = 0;
 			v.tm.tv_usec = 0;
@@ -1234,7 +1234,7 @@ int sock_getsockopt(struct socket *sock, int level, int optname,
 		break;
 
 	case SO_SNDTIMEO:
-		lv = sizeof(struct timeval);
+		lv = sizeof(struct __kernel_old_timeval);
 		if (sk->sk_sndtimeo == MAX_SCHEDULE_TIMEOUT) {
 			v.tm.tv_sec = 0;
 			v.tm.tv_usec = 0;
diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index 43a1dec08825..e1149bf1b57b 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -1439,7 +1439,7 @@ static int vsock_stream_setsockopt(struct socket *sock,
 		break;
 
 	case SO_VM_SOCKETS_CONNECT_TIMEOUT: {
-		struct timeval tv;
+		struct __kernel_old_timeval tv;
 		COPY_IN(tv);
 		if (tv.tv_sec >= 0 && tv.tv_usec < USEC_PER_SEC &&
 		    tv.tv_sec < (MAX_SCHEDULE_TIMEOUT / HZ - 1)) {
@@ -1517,7 +1517,7 @@ static int vsock_stream_getsockopt(struct socket *sock,
 		break;
 
 	case SO_VM_SOCKETS_CONNECT_TIMEOUT: {
-		struct timeval tv;
+		struct __kernel_old_timeval tv;
 		tv.tv_sec = vsk->connect_timeout / HZ;
 		tv.tv_usec =
 		    (vsk->connect_timeout -
-- 
2.17.1

