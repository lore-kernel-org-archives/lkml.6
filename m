Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E478EC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:56:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADAD721B18
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:56:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549900579;
	bh=dnfFIqlnYPQT1kF+Rriwt1X8/EUVWCz2vJZ8CjI9n+k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BmoRWk3pf81CuGTBZSbqZBMsunLJqepmFZgr6V1A1c9T09YzHstjehB9pCE8jiQUj
	 rGeoLJeexNZftKOmz8/Llot0+gUpzuCkph3igjpYjBdSAO4SFSZtpBC9XUganYv212
	 +n2iqdS6+1IGNHgOINFB/HPFpesqkHU3RsB8/mSE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731422AbfBKP4S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 10:56:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:42744 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728939AbfBKOe3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:34:29 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 32E2D20844;
        Mon, 11 Feb 2019 14:34:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549895668;
        bh=dnfFIqlnYPQT1kF+Rriwt1X8/EUVWCz2vJZ8CjI9n+k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=o7tazr4o9cd7zFVJKFATu65fIxwhHJEVEuEbascr9JjD5k6cNhDgpDd1dVDzbzM4e
         w9yEkyxreG5lEJSeVJtRUlRFQ2+f2tgjLfbPGVVezhpC9uZiWS8HoFvZggF7+8h70m
         L9J0uaFefKon2HChp4U6l2iITWX1fmxIyb2RO9qI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, John Fastabend <john.fastabend@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 242/352] bpf: sk_msg, fix socket data_ready events
Date:   Mon, 11 Feb 2019 15:17:49 +0100
Message-Id: <20190211141902.547806581@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141846.543045703@linuxfoundation.org>
References: <20190211141846.543045703@linuxfoundation.org>
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

[ Upstream commit 552de91068828daef50a227a665068cf8dde835e ]

When a skb verdict program is in-use and either another BPF program
redirects to that socket or the new SK_PASS support is used the
data_ready callback does not wake up application. Instead because
the stream parser/verdict is using the sk data_ready callback we wake
up the stream parser/verdict block.

Fix this by adding a helper to check if the stream parser block is
enabled on the sk and if so call the saved pointer which is the
upper layers wake up function.

This fixes application stalls observed when an application is waiting
for data in a blocking read().

Fixes: d829e9c4112b ("tls: convert to generic sk_msg interface")
Signed-off-by: John Fastabend <john.fastabend@gmail.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/skmsg.h | 8 ++++++++
 net/core/skmsg.c      | 6 +++---
 net/ipv4/tcp_bpf.c    | 2 +-
 3 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/include/linux/skmsg.h b/include/linux/skmsg.h
index 2a11e9d91dfa..36bd85863081 100644
--- a/include/linux/skmsg.h
+++ b/include/linux/skmsg.h
@@ -416,6 +416,14 @@ static inline void sk_psock_put(struct sock *sk, struct sk_psock *psock)
 		sk_psock_drop(sk, psock);
 }
 
+static inline void sk_psock_data_ready(struct sock *sk, struct sk_psock *psock)
+{
+	if (psock->parser.enabled)
+		psock->parser.saved_data_ready(sk);
+	else
+		sk->sk_data_ready(sk);
+}
+
 static inline void psock_set_prog(struct bpf_prog **pprog,
 				  struct bpf_prog *prog)
 {
diff --git a/net/core/skmsg.c b/net/core/skmsg.c
index fc7d59f1c57c..54d854807630 100644
--- a/net/core/skmsg.c
+++ b/net/core/skmsg.c
@@ -406,7 +406,7 @@ static int sk_psock_skb_ingress(struct sk_psock *psock, struct sk_buff *skb)
 	msg->skb = skb;
 
 	sk_psock_queue_msg(psock, msg);
-	sk->sk_data_ready(sk);
+	sk_psock_data_ready(sk, psock);
 	return copied;
 }
 
@@ -739,7 +739,7 @@ static int sk_psock_strp_parse(struct strparser *strp, struct sk_buff *skb)
 }
 
 /* Called with socket lock held. */
-static void sk_psock_data_ready(struct sock *sk)
+static void sk_psock_strp_data_ready(struct sock *sk)
 {
 	struct sk_psock *psock;
 
@@ -787,7 +787,7 @@ void sk_psock_start_strp(struct sock *sk, struct sk_psock *psock)
 		return;
 
 	parser->saved_data_ready = sk->sk_data_ready;
-	sk->sk_data_ready = sk_psock_data_ready;
+	sk->sk_data_ready = sk_psock_strp_data_ready;
 	sk->sk_write_space = sk_psock_write_space;
 	parser->enabled = true;
 }
diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
index 3b45fe530f91..2d6bd7a59b2c 100644
--- a/net/ipv4/tcp_bpf.c
+++ b/net/ipv4/tcp_bpf.c
@@ -198,7 +198,7 @@ static int bpf_tcp_ingress(struct sock *sk, struct sk_psock *psock,
 		msg->sg.start = i;
 		msg->sg.size -= apply_bytes;
 		sk_psock_queue_msg(psock, tmp);
-		sk->sk_data_ready(sk);
+		sk_psock_data_ready(sk, psock);
 	} else {
 		sk_msg_free(sk, tmp);
 		kfree(tmp);
-- 
2.19.1



