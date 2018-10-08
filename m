Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A2AEC677D4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 15:34:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FB6C21557
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 15:34:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="B9O4ZLwS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FB6C21557
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727969AbeJHWi0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 18:38:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:56912 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727866AbeJHWiZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 18:38:25 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2AFD9214DA;
        Mon,  8 Oct 2018 15:26:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539012369;
        bh=Fw9aVCDrHqdojjWMg45pUPn5YhDjYy1ym5aN4lUf9vg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=B9O4ZLwSBf8FZv2xI+5EkMqsr5hh/H6qHVbyNdTMANHJhorIQAhwKW/GhgOUmDaLO
         XW+2xpQf17IcFFzNTZQW23MzeUINt9lnPrkqsxy60sTX/7jwS5MHpSxp/1uaoAAAtF
         cs3xzyE6aB69AnSsPhCquG26RufNVuOOoB6AB4yY=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     John Fastabend <john.fastabend@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 45/58] bpf: sockmap, fix transition through disconnect without close
Date:   Mon,  8 Oct 2018 11:25:10 -0400
Message-Id: <20181008152523.70705-45-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181008152523.70705-1-sashal@kernel.org>
References: <20181008152523.70705-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: John Fastabend <john.fastabend@gmail.com>

[ Upstream commit b05545e15e1ff1d6a6a8593971275f9cc3e6b92b ]

It is possible (via shutdown()) for TCP socks to go trough TCP_CLOSE
state via tcp_disconnect() without actually calling tcp_close which
would then call our bpf_tcp_close() callback. Because of this a user
could disconnect a socket then put it in a LISTEN state which would
break our assumptions about sockets always being ESTABLISHED state.

To resolve this rely on the unhash hook, which is called in the
disconnect case, to remove the sock from the sockmap.

Reported-by: Eric Dumazet <edumazet@google.com>
Fixes: 1aa12bdf1bfb ("bpf: sockmap, add sock close() hook to remove socks")
Signed-off-by: John Fastabend <john.fastabend@gmail.com>
Acked-by: Yonghong Song <yhs@fb.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 kernel/bpf/sockmap.c | 60 ++++++++++++++++++++++++++++++--------------
 1 file changed, 41 insertions(+), 19 deletions(-)

diff --git a/kernel/bpf/sockmap.c b/kernel/bpf/sockmap.c
index 0d829e71024b..6cdef7f3bd69 100644
--- a/kernel/bpf/sockmap.c
+++ b/kernel/bpf/sockmap.c
@@ -132,6 +132,7 @@ struct smap_psock {
 	struct work_struct gc_work;
 
 	struct proto *sk_proto;
+	void (*save_unhash)(struct sock *sk);
 	void (*save_close)(struct sock *sk, long timeout);
 	void (*save_data_ready)(struct sock *sk);
 	void (*save_write_space)(struct sock *sk);
@@ -143,6 +144,7 @@ static int bpf_tcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 static int bpf_tcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t size);
 static int bpf_tcp_sendpage(struct sock *sk, struct page *page,
 			    int offset, size_t size, int flags);
+static void bpf_tcp_unhash(struct sock *sk);
 static void bpf_tcp_close(struct sock *sk, long timeout);
 
 static inline struct smap_psock *smap_psock_sk(const struct sock *sk)
@@ -184,6 +186,7 @@ static void build_protos(struct proto prot[SOCKMAP_NUM_CONFIGS],
 			 struct proto *base)
 {
 	prot[SOCKMAP_BASE]			= *base;
+	prot[SOCKMAP_BASE].unhash		= bpf_tcp_unhash;
 	prot[SOCKMAP_BASE].close		= bpf_tcp_close;
 	prot[SOCKMAP_BASE].recvmsg		= bpf_tcp_recvmsg;
 	prot[SOCKMAP_BASE].stream_memory_read	= bpf_tcp_stream_read;
@@ -217,6 +220,7 @@ static int bpf_tcp_init(struct sock *sk)
 		return -EBUSY;
 	}
 
+	psock->save_unhash = sk->sk_prot->unhash;
 	psock->save_close = sk->sk_prot->close;
 	psock->sk_proto = sk->sk_prot;
 
@@ -305,30 +309,12 @@ static struct smap_psock_map_entry *psock_map_pop(struct sock *sk,
 	return e;
 }
 
-static void bpf_tcp_close(struct sock *sk, long timeout)
+static void bpf_tcp_remove(struct sock *sk, struct smap_psock *psock)
 {
-	void (*close_fun)(struct sock *sk, long timeout);
 	struct smap_psock_map_entry *e;
 	struct sk_msg_buff *md, *mtmp;
-	struct smap_psock *psock;
 	struct sock *osk;
 
-	lock_sock(sk);
-	rcu_read_lock();
-	psock = smap_psock_sk(sk);
-	if (unlikely(!psock)) {
-		rcu_read_unlock();
-		release_sock(sk);
-		return sk->sk_prot->close(sk, timeout);
-	}
-
-	/* The psock may be destroyed anytime after exiting the RCU critial
-	 * section so by the time we use close_fun the psock may no longer
-	 * be valid. However, bpf_tcp_close is called with the sock lock
-	 * held so the close hook and sk are still valid.
-	 */
-	close_fun = psock->save_close;
-
 	if (psock->cork) {
 		free_start_sg(psock->sock, psock->cork);
 		kfree(psock->cork);
@@ -379,6 +365,42 @@ static void bpf_tcp_close(struct sock *sk, long timeout)
 		kfree(e);
 		e = psock_map_pop(sk, psock);
 	}
+}
+
+static void bpf_tcp_unhash(struct sock *sk)
+{
+	void (*unhash_fun)(struct sock *sk);
+	struct smap_psock *psock;
+
+	rcu_read_lock();
+	psock = smap_psock_sk(sk);
+	if (unlikely(!psock)) {
+		rcu_read_unlock();
+		if (sk->sk_prot->unhash)
+			sk->sk_prot->unhash(sk);
+		return;
+	}
+	unhash_fun = psock->save_unhash;
+	bpf_tcp_remove(sk, psock);
+	rcu_read_unlock();
+	unhash_fun(sk);
+}
+
+static void bpf_tcp_close(struct sock *sk, long timeout)
+{
+	void (*close_fun)(struct sock *sk, long timeout);
+	struct smap_psock *psock;
+
+	lock_sock(sk);
+	rcu_read_lock();
+	psock = smap_psock_sk(sk);
+	if (unlikely(!psock)) {
+		rcu_read_unlock();
+		release_sock(sk);
+		return sk->sk_prot->close(sk, timeout);
+	}
+	close_fun = psock->save_close;
+	bpf_tcp_remove(sk, psock);
 	rcu_read_unlock();
 	release_sock(sk);
 	close_fun(sk, timeout);
-- 
2.17.1

