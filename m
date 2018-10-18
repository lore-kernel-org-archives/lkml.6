Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 550B9C5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 17:58:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D1AA21479
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 17:58:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="sgCj80yI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D1AA21479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728985AbeJSCAJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 22:00:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:47792 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728335AbeJSCAI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 22:00:08 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F328C21476;
        Thu, 18 Oct 2018 17:58:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539885483;
        bh=TCrK768sXP6V/9CaiKlPe1c+UgEbrszBaHrpD+N4rfY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sgCj80yI2u67RFT+tX3uXxzDbZ2iKkSjLDgvq0gqGZJihTtVR9vlYIYDXhfC1t6t4
         NRcWJhqYX0fjyXjCXf4Pa/Xsuga/nihgva4gFrdWpCYbEJ3aHdd3i9NlAU5F2I0SJy
         P/uRvPJsE9QbxZL53YPyG0HQqPN+4on9pYOvUrzg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Yonghong Song <yhs@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 37/53] bpf: sockmap, fix transition through disconnect without close
Date:   Thu, 18 Oct 2018 19:54:30 +0200
Message-Id: <20181018175423.021198321@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181018175416.561567978@linuxfoundation.org>
References: <20181018175416.561567978@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/bpf/sockmap.c |   60 ++++++++++++++++++++++++++++++++++-----------------
 1 file changed, 41 insertions(+), 19 deletions(-)

--- a/kernel/bpf/sockmap.c
+++ b/kernel/bpf/sockmap.c
@@ -132,6 +132,7 @@ struct smap_psock {
 	struct work_struct gc_work;
 
 	struct proto *sk_proto;
+	void (*save_unhash)(struct sock *sk);
 	void (*save_close)(struct sock *sk, long timeout);
 	void (*save_data_ready)(struct sock *sk);
 	void (*save_write_space)(struct sock *sk);
@@ -143,6 +144,7 @@ static int bpf_tcp_recvmsg(struct sock *
 static int bpf_tcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t size);
 static int bpf_tcp_sendpage(struct sock *sk, struct page *page,
 			    int offset, size_t size, int flags);
+static void bpf_tcp_unhash(struct sock *sk);
 static void bpf_tcp_close(struct sock *sk, long timeout);
 
 static inline struct smap_psock *smap_psock_sk(const struct sock *sk)
@@ -184,6 +186,7 @@ static void build_protos(struct proto pr
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
 
@@ -305,30 +309,12 @@ static struct smap_psock_map_entry *psoc
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
 		free_start_sg(psock->sock, psock->cork, true);
 		kfree(psock->cork);
@@ -379,6 +365,42 @@ static void bpf_tcp_close(struct sock *s
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


