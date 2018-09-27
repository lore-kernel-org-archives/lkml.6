Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3E65C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 09:10:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C57021582
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 09:10:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C57021582
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728423AbeI0P1m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 11:27:42 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:55148 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727084AbeI0P1m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 11:27:42 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 449CB1117;
        Thu, 27 Sep 2018 09:10:25 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sabrina Dubroca <sd@queasysnail.net>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.18 09/88] tls: zero the crypto information from tls_context before freeing
Date:   Thu, 27 Sep 2018 11:02:50 +0200
Message-Id: <20180927090301.647998485@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180927090300.631426620@linuxfoundation.org>
References: <20180927090300.631426620@linuxfoundation.org>
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

From: Sabrina Dubroca <sd@queasysnail.net>

[ Upstream commit 86029d10af18381814881d6cce2dd6872163b59f ]

This contains key material in crypto_send_aes_gcm_128 and
crypto_recv_aes_gcm_128.

Introduce union tls_crypto_context, and replace the two identical
unions directly embedded in struct tls_context with it. We can then
use this union to clean up the memory in the new tls_ctx_free()
function.

Fixes: 3c4d7559159b ("tls: kernel TLS support")
Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/net/tls.h             |   19 +++++++++----------
 net/tls/tls_device.c          |    4 ++--
 net/tls/tls_device_fallback.c |    2 +-
 net/tls/tls_main.c            |   20 +++++++++++++++-----
 net/tls/tls_sw.c              |    8 ++++----
 5 files changed, 31 insertions(+), 22 deletions(-)

--- a/include/net/tls.h
+++ b/include/net/tls.h
@@ -165,15 +165,14 @@ struct cipher_context {
 	char *rec_seq;
 };
 
+union tls_crypto_context {
+	struct tls_crypto_info info;
+	struct tls12_crypto_info_aes_gcm_128 aes_gcm_128;
+};
+
 struct tls_context {
-	union {
-		struct tls_crypto_info crypto_send;
-		struct tls12_crypto_info_aes_gcm_128 crypto_send_aes_gcm_128;
-	};
-	union {
-		struct tls_crypto_info crypto_recv;
-		struct tls12_crypto_info_aes_gcm_128 crypto_recv_aes_gcm_128;
-	};
+	union tls_crypto_context crypto_send;
+	union tls_crypto_context crypto_recv;
 
 	struct list_head list;
 	struct net_device *netdev;
@@ -337,8 +336,8 @@ static inline void tls_fill_prepend(stru
 	 * size KTLS_DTLS_HEADER_SIZE + KTLS_DTLS_NONCE_EXPLICIT_SIZE
 	 */
 	buf[0] = record_type;
-	buf[1] = TLS_VERSION_MINOR(ctx->crypto_send.version);
-	buf[2] = TLS_VERSION_MAJOR(ctx->crypto_send.version);
+	buf[1] = TLS_VERSION_MINOR(ctx->crypto_send.info.version);
+	buf[2] = TLS_VERSION_MAJOR(ctx->crypto_send.info.version);
 	/* we can use IV for nonce explicit according to spec */
 	buf[3] = pkt_len >> 8;
 	buf[4] = pkt_len & 0xFF;
--- a/net/tls/tls_device.c
+++ b/net/tls/tls_device.c
@@ -552,7 +552,7 @@ int tls_set_device_offload(struct sock *
 		goto free_marker_record;
 	}
 
-	crypto_info = &ctx->crypto_send;
+	crypto_info = &ctx->crypto_send.info;
 	switch (crypto_info->cipher_type) {
 	case TLS_CIPHER_AES_GCM_128:
 		nonce_size = TLS_CIPHER_AES_GCM_128_IV_SIZE;
@@ -650,7 +650,7 @@ int tls_set_device_offload(struct sock *
 
 	ctx->priv_ctx_tx = offload_ctx;
 	rc = netdev->tlsdev_ops->tls_dev_add(netdev, sk, TLS_OFFLOAD_CTX_DIR_TX,
-					     &ctx->crypto_send,
+					     &ctx->crypto_send.info,
 					     tcp_sk(sk)->write_seq);
 	if (rc)
 		goto release_netdev;
--- a/net/tls/tls_device_fallback.c
+++ b/net/tls/tls_device_fallback.c
@@ -320,7 +320,7 @@ static struct sk_buff *tls_enc_skb(struc
 		goto free_req;
 
 	iv = buf;
-	memcpy(iv, tls_ctx->crypto_send_aes_gcm_128.salt,
+	memcpy(iv, tls_ctx->crypto_send.aes_gcm_128.salt,
 	       TLS_CIPHER_AES_GCM_128_SALT_SIZE);
 	aad = buf + TLS_CIPHER_AES_GCM_128_SALT_SIZE +
 	      TLS_CIPHER_AES_GCM_128_IV_SIZE;
--- a/net/tls/tls_main.c
+++ b/net/tls/tls_main.c
@@ -245,6 +245,16 @@ static void tls_write_space(struct sock
 	ctx->sk_write_space(sk);
 }
 
+static void tls_ctx_free(struct tls_context *ctx)
+{
+	if (!ctx)
+		return;
+
+	memzero_explicit(&ctx->crypto_send, sizeof(ctx->crypto_send));
+	memzero_explicit(&ctx->crypto_recv, sizeof(ctx->crypto_recv));
+	kfree(ctx);
+}
+
 static void tls_sk_proto_close(struct sock *sk, long timeout)
 {
 	struct tls_context *ctx = tls_get_ctx(sk);
@@ -295,7 +305,7 @@ static void tls_sk_proto_close(struct so
 #else
 	{
 #endif
-		kfree(ctx);
+		tls_ctx_free(ctx);
 		ctx = NULL;
 	}
 
@@ -306,7 +316,7 @@ skip_tx_cleanup:
 	 * for sk->sk_prot->unhash [tls_hw_unhash]
 	 */
 	if (free_ctx)
-		kfree(ctx);
+		tls_ctx_free(ctx);
 }
 
 static int do_tls_getsockopt_tx(struct sock *sk, char __user *optval,
@@ -331,7 +341,7 @@ static int do_tls_getsockopt_tx(struct s
 	}
 
 	/* get user crypto info */
-	crypto_info = &ctx->crypto_send;
+	crypto_info = &ctx->crypto_send.info;
 
 	if (!TLS_CRYPTO_INFO_READY(crypto_info)) {
 		rc = -EBUSY;
@@ -418,9 +428,9 @@ static int do_tls_setsockopt_conf(struct
 	}
 
 	if (tx)
-		crypto_info = &ctx->crypto_send;
+		crypto_info = &ctx->crypto_send.info;
 	else
-		crypto_info = &ctx->crypto_recv;
+		crypto_info = &ctx->crypto_recv.info;
 
 	/* Currently we don't support set crypto info more than one time */
 	if (TLS_CRYPTO_INFO_READY(crypto_info)) {
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -989,8 +989,8 @@ static int tls_read_size(struct strparse
 		goto read_failure;
 	}
 
-	if (header[1] != TLS_VERSION_MINOR(tls_ctx->crypto_recv.version) ||
-	    header[2] != TLS_VERSION_MAJOR(tls_ctx->crypto_recv.version)) {
+	if (header[1] != TLS_VERSION_MINOR(tls_ctx->crypto_recv.info.version) ||
+	    header[2] != TLS_VERSION_MAJOR(tls_ctx->crypto_recv.info.version)) {
 		ret = -EINVAL;
 		goto read_failure;
 	}
@@ -1099,11 +1099,11 @@ int tls_set_sw_offload(struct sock *sk,
 	}
 
 	if (tx) {
-		crypto_info = &ctx->crypto_send;
+		crypto_info = &ctx->crypto_send.info;
 		cctx = &ctx->tx;
 		aead = &sw_ctx_tx->aead_send;
 	} else {
-		crypto_info = &ctx->crypto_recv;
+		crypto_info = &ctx->crypto_recv.info;
 		cctx = &ctx->rx;
 		aead = &sw_ctx_rx->aead_recv;
 	}


