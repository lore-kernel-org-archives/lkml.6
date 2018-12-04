Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77DA8C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:01:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30714214F1
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:01:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="0MyTo4Qb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30714214F1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727534AbeLDLBw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 06:01:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:47484 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727165AbeLDLBt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 06:01:49 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C6F5D2087F;
        Tue,  4 Dec 2018 11:01:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543921309;
        bh=AKmUmhDj0Qkkr7IIBILIJUaVCfG2QA5cRtyyM7h+6i4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0MyTo4QbkFiDeFJkEoqcvdqHBW5HYCrC9WoqbpZRUYZoEtVWIPfSsL6gi13H2lRy7
         zkYxGCTkWMzt6QZdHSFJM2W2nEh7dEs9BLXJefOISbbQDXZoDrWMeJKnx4f3BaTbzH
         QybRBJRQFx63vhMyfIIcFLrywb70C5u+itxCv64U=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ilya Lesokhin <ilyal@mellanox.com>,
        "David S. Miller" <davem@davemloft.net>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 021/146] tls: Fix TLS ulp context leak, when TLS_TX setsockopt is not used.
Date:   Tue,  4 Dec 2018 11:48:27 +0100
Message-Id: <20181204103727.653383532@linuxfoundation.org>
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

commit ff45d820a2df163957ad8ab459b6eb6976144c18 upstream.

Previously the TLS ulp context would leak if we attached a TLS ulp
to a socket but did not use the TLS_TX setsockopt,
or did use it but it failed.
This patch solves the issue by overriding prot[TLS_BASE_TX].close
and fixing tls_sk_proto_close to work properly
when its called with ctx->tx_conf == TLS_BASE_TX.
This patch also removes ctx->free_resources as we can use ctx->tx_conf
to obtain the relevant information.

Fixes: 3c4d7559159b ('tls: kernel TLS support')
Signed-off-by: Ilya Lesokhin <ilyal@mellanox.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
[bwh: Backported to 4.14: Keep using tls_ctx_free() as introduced by
 the earlier backport of "tls: zero the crypto information from
 tls_context before freeing"]
Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/tls.h  |  2 +-
 net/tls/tls_main.c | 24 ++++++++++++++++--------
 net/tls/tls_sw.c   |  3 +--
 3 files changed, 18 insertions(+), 11 deletions(-)

diff --git a/include/net/tls.h b/include/net/tls.h
index 0c3ab2af74d3..604fd982da19 100644
--- a/include/net/tls.h
+++ b/include/net/tls.h
@@ -106,7 +106,6 @@ struct tls_context {
 
 	u16 pending_open_record_frags;
 	int (*push_pending_record)(struct sock *sk, int flags);
-	void (*free_resources)(struct sock *sk);
 
 	void (*sk_write_space)(struct sock *sk);
 	void (*sk_proto_close)(struct sock *sk, long timeout);
@@ -131,6 +130,7 @@ int tls_sw_sendmsg(struct sock *sk, struct msghdr *msg, size_t size);
 int tls_sw_sendpage(struct sock *sk, struct page *page,
 		    int offset, size_t size, int flags);
 void tls_sw_close(struct sock *sk, long timeout);
+void tls_sw_free_tx_resources(struct sock *sk);
 
 void tls_sk_destruct(struct sock *sk, struct tls_context *ctx);
 void tls_icsk_clean_acked(struct sock *sk);
diff --git a/net/tls/tls_main.c b/net/tls/tls_main.c
index 191a8adee3ea..b5f9c578bcf0 100644
--- a/net/tls/tls_main.c
+++ b/net/tls/tls_main.c
@@ -249,6 +249,12 @@ static void tls_sk_proto_close(struct sock *sk, long timeout)
 	void (*sk_proto_close)(struct sock *sk, long timeout);
 
 	lock_sock(sk);
+	sk_proto_close = ctx->sk_proto_close;
+
+	if (ctx->tx_conf == TLS_BASE_TX) {
+		tls_ctx_free(ctx);
+		goto skip_tx_cleanup;
+	}
 
 	if (!tls_complete_pending_work(sk, ctx, 0, &timeo))
 		tls_handle_open_record(sk, 0);
@@ -265,13 +271,16 @@ static void tls_sk_proto_close(struct sock *sk, long timeout)
 			sg++;
 		}
 	}
-	ctx->free_resources(sk);
+
 	kfree(ctx->rec_seq);
 	kfree(ctx->iv);
 
-	sk_proto_close = ctx->sk_proto_close;
-	tls_ctx_free(ctx);
+	if (ctx->tx_conf == TLS_SW_TX) {
+		tls_sw_free_tx_resources(sk);
+		tls_ctx_free(ctx);
+	}
 
+skip_tx_cleanup:
 	release_sock(sk);
 	sk_proto_close(sk, timeout);
 }
@@ -428,8 +437,6 @@ static int do_tls_setsockopt_tx(struct sock *sk, char __user *optval,
 	ctx->sk_write_space = sk->sk_write_space;
 	sk->sk_write_space = tls_write_space;
 
-	ctx->sk_proto_close = sk->sk_prot->close;
-
 	/* currently SW is default, we will have ethtool in future */
 	rc = tls_set_sw_offload(sk, ctx);
 	tx_conf = TLS_SW_TX;
@@ -499,6 +506,7 @@ static int tls_init(struct sock *sk)
 	icsk->icsk_ulp_data = ctx;
 	ctx->setsockopt = sk->sk_prot->setsockopt;
 	ctx->getsockopt = sk->sk_prot->getsockopt;
+	ctx->sk_proto_close = sk->sk_prot->close;
 
 	ctx->tx_conf = TLS_BASE_TX;
 	update_sk_prot(sk, ctx);
@@ -515,11 +523,11 @@ static struct tcp_ulp_ops tcp_tls_ulp_ops __read_mostly = {
 static void build_protos(struct proto *prot, struct proto *base)
 {
 	prot[TLS_BASE_TX] = *base;
-	prot[TLS_BASE_TX].setsockopt = tls_setsockopt;
-	prot[TLS_BASE_TX].getsockopt = tls_getsockopt;
+	prot[TLS_BASE_TX].setsockopt	= tls_setsockopt;
+	prot[TLS_BASE_TX].getsockopt	= tls_getsockopt;
+	prot[TLS_BASE_TX].close		= tls_sk_proto_close;
 
 	prot[TLS_SW_TX] = prot[TLS_BASE_TX];
-	prot[TLS_SW_TX].close		= tls_sk_proto_close;
 	prot[TLS_SW_TX].sendmsg		= tls_sw_sendmsg;
 	prot[TLS_SW_TX].sendpage	= tls_sw_sendpage;
 }
diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index 6ae9ca567d6c..5996fb5756e1 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -646,7 +646,7 @@ sendpage_end:
 	return ret;
 }
 
-static void tls_sw_free_resources(struct sock *sk)
+void tls_sw_free_tx_resources(struct sock *sk)
 {
 	struct tls_context *tls_ctx = tls_get_ctx(sk);
 	struct tls_sw_context *ctx = tls_sw_ctx(tls_ctx);
@@ -685,7 +685,6 @@ int tls_set_sw_offload(struct sock *sk, struct tls_context *ctx)
 	}
 
 	ctx->priv_ctx = (struct tls_offload_context *)sw_ctx;
-	ctx->free_resources = tls_sw_free_resources;
 
 	crypto_info = &ctx->crypto_send.info;
 	switch (crypto_info->cipher_type) {
-- 
2.17.1



