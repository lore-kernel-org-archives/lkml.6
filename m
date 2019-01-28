Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79F70C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 15:56:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47D5921848
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 15:56:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548690989;
	bh=4G5BH0hhZc5Xjzpu+FnH9S6ZvcRhSUASBRCCpFfqScE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=IQ9mddKz6tOZ4J4UDI6lbkM6c93dBZNiBouH97q7qoenweBA6Od/KZ5gjGCqae14Y
	 HGMIDE9dWXnP6okawB7QjfuiySAhy0xIoH9GEZBWvXdU/+eg3uq7eiYPqtGazNblea
	 lXu6TRbxeTd4kVxKPLXu8LFxmUck1GB/5GquVQmc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730098AbfA1P41 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 10:56:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:42126 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729382AbfA1P4Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 10:56:24 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 768B6217F5;
        Mon, 28 Jan 2019 15:56:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548690983;
        bh=4G5BH0hhZc5Xjzpu+FnH9S6ZvcRhSUASBRCCpFfqScE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lauhz9M4A9TTLpf9xq3jkGTDQpW0PSMapCtjnWypKuUAJZUAdl894NfH3o65AfEho
         rrt0NdWyOX6a34AzkWH1JjXsPJP8YjexZ3lha6H3589okLdqMncsXF5UX8qwZEeM/+
         AuDekO+xQ1L26ynL94tfXY6jpzpUg51ezAifFsZA=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     John Fastabend <john.fastabend@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.20 254/304] bpf: sk_msg, fix socket data_ready events
Date:   Mon, 28 Jan 2019 10:42:51 -0500
Message-Id: <20190128154341.47195-254-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128154341.47195-1-sashal@kernel.org>
References: <20190128154341.47195-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: John Fastabend <john.fastabend@gmail.com>

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

