Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D200BC04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:19:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99A3A20878
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:19:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="2PNnfzWP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99A3A20878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727911AbeLDLEA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 06:04:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:50572 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726416AbeLDLDy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 06:03:54 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 93C722087F;
        Tue,  4 Dec 2018 11:03:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543921434;
        bh=bCWT0n2b2z9MEkH+UhkaQcghnMN4SLily3ASRL4ZXPs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2PNnfzWPUUqHaK+oamfyPtSwWsyLr1hjweS7VtXLHzeGqoa+MrVovp+kLyQ+JrJpy
         tAU3RaIWVeASk2SROiyd3P1OsWm1n6mJSYWDLfCW/GjC9yisY686LBf7+dyb8pdcm4
         Zya6m4z09DN2iCCmFA5D6sWn29VSdzfmv3udgsQk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Boris Pismenny <borisp@mellanox.com>,
        Ilya Lesokhin <ilyal@mellanox.com>,
        "David S. Miller" <davem@davemloft.net>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 024/146] tls: Use correct sk->sk_prot for IPV6
Date:   Tue,  4 Dec 2018 11:48:30 +0100
Message-Id: <20181204103727.796464549@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181204103726.750894136@linuxfoundation.org>
References: <20181204103726.750894136@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

commit c113187d38ff85dc302a1bb55864b203ebb2ba10 upstream.

The tls ulp overrides sk->prot with a new tls specific proto structs.
The tls specific structs were previously based on the ipv4 specific
tcp_prot sturct.
As a result, attaching the tls ulp to an ipv6 tcp socket replaced
some ipv6 callback with the ipv4 equivalents.

This patch adds ipv6 tls proto structs and uses them when
attached to ipv6 sockets.

Fixes: 3c4d7559159b ('tls: kernel TLS support')
Signed-off-by: Boris Pismenny <borisp@mellanox.com>
Signed-off-by: Ilya Lesokhin <ilyal@mellanox.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/tls/tls_main.c | 52 +++++++++++++++++++++++++++++++++-------------
 1 file changed, 37 insertions(+), 15 deletions(-)

diff --git a/net/tls/tls_main.c b/net/tls/tls_main.c
index 33187e34599b..e903bdd39b9f 100644
--- a/net/tls/tls_main.c
+++ b/net/tls/tls_main.c
@@ -46,17 +46,27 @@ MODULE_DESCRIPTION("Transport Layer Security Support");
 MODULE_LICENSE("Dual BSD/GPL");
 MODULE_ALIAS_TCP_ULP("tls");
 
+enum {
+	TLSV4,
+	TLSV6,
+	TLS_NUM_PROTS,
+};
+
 enum {
 	TLS_BASE_TX,
 	TLS_SW_TX,
 	TLS_NUM_CONFIG,
 };
 
-static struct proto tls_prots[TLS_NUM_CONFIG];
+static struct proto *saved_tcpv6_prot;
+static DEFINE_MUTEX(tcpv6_prot_mutex);
+static struct proto tls_prots[TLS_NUM_PROTS][TLS_NUM_CONFIG];
 
 static inline void update_sk_prot(struct sock *sk, struct tls_context *ctx)
 {
-	sk->sk_prot = &tls_prots[ctx->tx_conf];
+	int ip_ver = sk->sk_family == AF_INET6 ? TLSV6 : TLSV4;
+
+	sk->sk_prot = &tls_prots[ip_ver][ctx->tx_conf];
 }
 
 int wait_on_pending_writer(struct sock *sk, long *timeo)
@@ -476,8 +486,21 @@ static int tls_setsockopt(struct sock *sk, int level, int optname,
 	return do_tls_setsockopt(sk, optname, optval, optlen);
 }
 
+static void build_protos(struct proto *prot, struct proto *base)
+{
+	prot[TLS_BASE_TX] = *base;
+	prot[TLS_BASE_TX].setsockopt	= tls_setsockopt;
+	prot[TLS_BASE_TX].getsockopt	= tls_getsockopt;
+	prot[TLS_BASE_TX].close		= tls_sk_proto_close;
+
+	prot[TLS_SW_TX] = prot[TLS_BASE_TX];
+	prot[TLS_SW_TX].sendmsg		= tls_sw_sendmsg;
+	prot[TLS_SW_TX].sendpage	= tls_sw_sendpage;
+}
+
 static int tls_init(struct sock *sk)
 {
+	int ip_ver = sk->sk_family == AF_INET6 ? TLSV6 : TLSV4;
 	struct inet_connection_sock *icsk = inet_csk(sk);
 	struct tls_context *ctx;
 	int rc = 0;
@@ -502,6 +525,17 @@ static int tls_init(struct sock *sk)
 	ctx->getsockopt = sk->sk_prot->getsockopt;
 	ctx->sk_proto_close = sk->sk_prot->close;
 
+	/* Build IPv6 TLS whenever the address of tcpv6_prot changes */
+	if (ip_ver == TLSV6 &&
+	    unlikely(sk->sk_prot != smp_load_acquire(&saved_tcpv6_prot))) {
+		mutex_lock(&tcpv6_prot_mutex);
+		if (likely(sk->sk_prot != saved_tcpv6_prot)) {
+			build_protos(tls_prots[TLSV6], sk->sk_prot);
+			smp_store_release(&saved_tcpv6_prot, sk->sk_prot);
+		}
+		mutex_unlock(&tcpv6_prot_mutex);
+	}
+
 	ctx->tx_conf = TLS_BASE_TX;
 	update_sk_prot(sk, ctx);
 out:
@@ -514,21 +548,9 @@ static struct tcp_ulp_ops tcp_tls_ulp_ops __read_mostly = {
 	.init			= tls_init,
 };
 
-static void build_protos(struct proto *prot, struct proto *base)
-{
-	prot[TLS_BASE_TX] = *base;
-	prot[TLS_BASE_TX].setsockopt	= tls_setsockopt;
-	prot[TLS_BASE_TX].getsockopt	= tls_getsockopt;
-	prot[TLS_BASE_TX].close		= tls_sk_proto_close;
-
-	prot[TLS_SW_TX] = prot[TLS_BASE_TX];
-	prot[TLS_SW_TX].sendmsg		= tls_sw_sendmsg;
-	prot[TLS_SW_TX].sendpage	= tls_sw_sendpage;
-}
-
 static int __init tls_register(void)
 {
-	build_protos(tls_prots, &tcp_prot);
+	build_protos(tls_prots[TLSV4], &tcp_prot);
 
 	tcp_register_ulp(&tcp_tls_ulp_ops);
 
-- 
2.17.1



