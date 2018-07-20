Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 984AAECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 12:48:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59CA3206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 12:48:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59CA3206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390541AbeGTNgo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 09:36:44 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:58498 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390387AbeGTNgo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 09:36:44 -0400
Received: from localhost (LFbn-1-12238-233.w90-92.abo.wanadoo.fr [90.92.53.233])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 72BD4D67;
        Fri, 20 Jul 2018 12:39:07 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+5c063698bdbfac19f363@syzkaller.appspotmail.com,
        Martin KaFai Lau <kafai@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Wei Wang <weiwan@google.com>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH 4.17 079/101] bpf: sockmap, fix crash when ipv6 sock is added
Date:   Fri, 20 Jul 2018 14:14:25 +0200
Message-Id: <20180720121426.625236595@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180720121422.837870592@linuxfoundation.org>
References: <20180720121422.837870592@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: John Fastabend <john.fastabend@gmail.com>

commit 9901c5d77e969d8215a8e8d087ef02e6feddc84c upstream.

This fixes a crash where we assign tcp_prot to IPv6 sockets instead
of tcpv6_prot.

Previously we overwrote the sk->prot field with tcp_prot even in the
AF_INET6 case. This patch ensures the correct tcp_prot and tcpv6_prot
are used.

Tested with 'netserver -6' and 'netperf -H [IPv6]' as well as
'netperf -H [IPv4]'. The ESTABLISHED check resolves the previously
crashing case here.

Fixes: 174a79ff9515 ("bpf: sockmap with sk redirect support")
Reported-by: syzbot+5c063698bdbfac19f363@syzkaller.appspotmail.com
Acked-by: Martin KaFai Lau <kafai@fb.com>
Signed-off-by: John Fastabend <john.fastabend@gmail.com>
Signed-off-by: Wei Wang <weiwan@google.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/bpf/sockmap.c |   58 ++++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 48 insertions(+), 10 deletions(-)

--- a/kernel/bpf/sockmap.c
+++ b/kernel/bpf/sockmap.c
@@ -112,6 +112,7 @@ static int bpf_tcp_recvmsg(struct sock *
 static int bpf_tcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t size);
 static int bpf_tcp_sendpage(struct sock *sk, struct page *page,
 			    int offset, size_t size, int flags);
+static void bpf_tcp_close(struct sock *sk, long timeout);
 
 static inline struct smap_psock *smap_psock_sk(const struct sock *sk)
 {
@@ -133,7 +134,42 @@ out:
 	return !empty;
 }
 
-static struct proto tcp_bpf_proto;
+enum {
+	SOCKMAP_IPV4,
+	SOCKMAP_IPV6,
+	SOCKMAP_NUM_PROTS,
+};
+
+enum {
+	SOCKMAP_BASE,
+	SOCKMAP_TX,
+	SOCKMAP_NUM_CONFIGS,
+};
+
+static struct proto *saved_tcpv6_prot __read_mostly;
+static DEFINE_SPINLOCK(tcpv6_prot_lock);
+static struct proto bpf_tcp_prots[SOCKMAP_NUM_PROTS][SOCKMAP_NUM_CONFIGS];
+static void build_protos(struct proto prot[SOCKMAP_NUM_CONFIGS],
+			 struct proto *base)
+{
+	prot[SOCKMAP_BASE]			= *base;
+	prot[SOCKMAP_BASE].close		= bpf_tcp_close;
+	prot[SOCKMAP_BASE].recvmsg		= bpf_tcp_recvmsg;
+	prot[SOCKMAP_BASE].stream_memory_read	= bpf_tcp_stream_read;
+
+	prot[SOCKMAP_TX]			= prot[SOCKMAP_BASE];
+	prot[SOCKMAP_TX].sendmsg		= bpf_tcp_sendmsg;
+	prot[SOCKMAP_TX].sendpage		= bpf_tcp_sendpage;
+}
+
+static void update_sk_prot(struct sock *sk, struct smap_psock *psock)
+{
+	int family = sk->sk_family == AF_INET6 ? SOCKMAP_IPV6 : SOCKMAP_IPV4;
+	int conf = psock->bpf_tx_msg ? SOCKMAP_TX : SOCKMAP_BASE;
+
+	sk->sk_prot = &bpf_tcp_prots[family][conf];
+}
+
 static int bpf_tcp_init(struct sock *sk)
 {
 	struct smap_psock *psock;
@@ -153,14 +189,17 @@ static int bpf_tcp_init(struct sock *sk)
 	psock->save_close = sk->sk_prot->close;
 	psock->sk_proto = sk->sk_prot;
 
-	if (psock->bpf_tx_msg) {
-		tcp_bpf_proto.sendmsg = bpf_tcp_sendmsg;
-		tcp_bpf_proto.sendpage = bpf_tcp_sendpage;
-		tcp_bpf_proto.recvmsg = bpf_tcp_recvmsg;
-		tcp_bpf_proto.stream_memory_read = bpf_tcp_stream_read;
+	/* Build IPv6 sockmap whenever the address of tcpv6_prot changes */
+	if (sk->sk_family == AF_INET6 &&
+	    unlikely(sk->sk_prot != smp_load_acquire(&saved_tcpv6_prot))) {
+		spin_lock_bh(&tcpv6_prot_lock);
+		if (likely(sk->sk_prot != saved_tcpv6_prot)) {
+			build_protos(bpf_tcp_prots[SOCKMAP_IPV6], sk->sk_prot);
+			smp_store_release(&saved_tcpv6_prot, sk->sk_prot);
+		}
+		spin_unlock_bh(&tcpv6_prot_lock);
 	}
-
-	sk->sk_prot = &tcp_bpf_proto;
+	update_sk_prot(sk, psock);
 	rcu_read_unlock();
 	return 0;
 }
@@ -1070,8 +1109,7 @@ static void bpf_tcp_msg_add(struct smap_
 
 static int bpf_tcp_ulp_register(void)
 {
-	tcp_bpf_proto = tcp_prot;
-	tcp_bpf_proto.close = bpf_tcp_close;
+	build_protos(bpf_tcp_prots[SOCKMAP_IPV4], &tcp_prot);
 	/* Once BPF TX ULP is registered it is never unregistered. It
 	 * will be in the ULP list for the lifetime of the system. Doing
 	 * duplicate registers is not a problem.


