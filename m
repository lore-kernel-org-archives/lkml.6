Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 850ACC04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:23:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4604C2146D
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:23:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Enf95dN3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4604C2146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727673AbeLDLXW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 06:23:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:47448 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726450AbeLDLBr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 06:01:47 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3FD422146D;
        Tue,  4 Dec 2018 11:01:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543921306;
        bh=yYQjijM7Ej61OxHyeUbINRz8g2bmcLkIzyUSSjNd+RA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Enf95dN32nxLrhalFqGYWJu44ONYfO2pWyxDJj9hoowL5fgRkitLUdTU+ZRdfJRfy
         ENh7hF9lazTL8IiTFwzJFHviFRUBEbDEgSBEayeHX/RkmhrvtdO+Fg4T25Yp4SZen2
         owPqFbobyvuJgcsmFfa0GdpVTmUTPVP6lMjVyFRM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ilya Lesokhin <ilyal@mellanox.com>,
        "David S. Miller" <davem@davemloft.net>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 020/146] tls: Add function to update the TLS socket configuration
Date:   Tue,  4 Dec 2018 11:48:26 +0100
Message-Id: <20181204103727.605356968@linuxfoundation.org>
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

commit 6d88207fcfddc002afe3e2e4a455e5201089d5d9 upstream.

The tx configuration is now stored in ctx->tx_conf.
And sk->sk_prot is updated trough a function
This will simplify things when we add rx
and support for different possible
tx and rx cross configurations.

Signed-off-by: Ilya Lesokhin <ilyal@mellanox.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/tls.h  |  2 ++
 net/tls/tls_main.c | 46 ++++++++++++++++++++++++++++++++--------------
 2 files changed, 34 insertions(+), 14 deletions(-)

diff --git a/include/net/tls.h b/include/net/tls.h
index 86ed3dd80fe7..0c3ab2af74d3 100644
--- a/include/net/tls.h
+++ b/include/net/tls.h
@@ -89,6 +89,8 @@ struct tls_context {
 
 	void *priv_ctx;
 
+	u8 tx_conf:2;
+
 	u16 prepend_size;
 	u16 tag_size;
 	u16 overhead_size;
diff --git a/net/tls/tls_main.c b/net/tls/tls_main.c
index 4f2971f528db..191a8adee3ea 100644
--- a/net/tls/tls_main.c
+++ b/net/tls/tls_main.c
@@ -46,8 +46,18 @@ MODULE_DESCRIPTION("Transport Layer Security Support");
 MODULE_LICENSE("Dual BSD/GPL");
 MODULE_ALIAS_TCP_ULP("tls");
 
-static struct proto tls_base_prot;
-static struct proto tls_sw_prot;
+enum {
+	TLS_BASE_TX,
+	TLS_SW_TX,
+	TLS_NUM_CONFIG,
+};
+
+static struct proto tls_prots[TLS_NUM_CONFIG];
+
+static inline void update_sk_prot(struct sock *sk, struct tls_context *ctx)
+{
+	sk->sk_prot = &tls_prots[ctx->tx_conf];
+}
 
 int wait_on_pending_writer(struct sock *sk, long *timeo)
 {
@@ -364,8 +374,8 @@ static int do_tls_setsockopt_tx(struct sock *sk, char __user *optval,
 {
 	struct tls_crypto_info *crypto_info, tmp_crypto_info;
 	struct tls_context *ctx = tls_get_ctx(sk);
-	struct proto *prot = NULL;
 	int rc = 0;
+	int tx_conf;
 
 	if (!optval || (optlen < sizeof(*crypto_info))) {
 		rc = -EINVAL;
@@ -422,11 +432,12 @@ static int do_tls_setsockopt_tx(struct sock *sk, char __user *optval,
 
 	/* currently SW is default, we will have ethtool in future */
 	rc = tls_set_sw_offload(sk, ctx);
-	prot = &tls_sw_prot;
+	tx_conf = TLS_SW_TX;
 	if (rc)
 		goto err_crypto_info;
 
-	sk->sk_prot = prot;
+	ctx->tx_conf = tx_conf;
+	update_sk_prot(sk, ctx);
 	goto out;
 
 err_crypto_info:
@@ -488,7 +499,9 @@ static int tls_init(struct sock *sk)
 	icsk->icsk_ulp_data = ctx;
 	ctx->setsockopt = sk->sk_prot->setsockopt;
 	ctx->getsockopt = sk->sk_prot->getsockopt;
-	sk->sk_prot = &tls_base_prot;
+
+	ctx->tx_conf = TLS_BASE_TX;
+	update_sk_prot(sk, ctx);
 out:
 	return rc;
 }
@@ -499,16 +512,21 @@ static struct tcp_ulp_ops tcp_tls_ulp_ops __read_mostly = {
 	.init			= tls_init,
 };
 
+static void build_protos(struct proto *prot, struct proto *base)
+{
+	prot[TLS_BASE_TX] = *base;
+	prot[TLS_BASE_TX].setsockopt = tls_setsockopt;
+	prot[TLS_BASE_TX].getsockopt = tls_getsockopt;
+
+	prot[TLS_SW_TX] = prot[TLS_BASE_TX];
+	prot[TLS_SW_TX].close		= tls_sk_proto_close;
+	prot[TLS_SW_TX].sendmsg		= tls_sw_sendmsg;
+	prot[TLS_SW_TX].sendpage	= tls_sw_sendpage;
+}
+
 static int __init tls_register(void)
 {
-	tls_base_prot			= tcp_prot;
-	tls_base_prot.setsockopt	= tls_setsockopt;
-	tls_base_prot.getsockopt	= tls_getsockopt;
-
-	tls_sw_prot			= tls_base_prot;
-	tls_sw_prot.sendmsg		= tls_sw_sendmsg;
-	tls_sw_prot.sendpage            = tls_sw_sendpage;
-	tls_sw_prot.close               = tls_sk_proto_close;
+	build_protos(tls_prots, &tcp_prot);
 
 	tcp_register_ulp(&tcp_tls_ulp_ops);
 
-- 
2.17.1



