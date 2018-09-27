Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51748C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 09:16:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC94F2152F
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 09:16:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC94F2152F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728844AbeI0PeG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 11:34:06 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:55918 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727321AbeI0PeG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 11:34:06 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 343A81117;
        Thu, 27 Sep 2018 09:16:48 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sabrina Dubroca <sd@queasysnail.net>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 12/64] tls: zero the crypto information from tls_context before freeing
Date:   Thu, 27 Sep 2018 11:03:29 +0200
Message-Id: <20180927090251.401406514@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180927090249.801943776@linuxfoundation.org>
References: <20180927090249.801943776@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

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
 include/net/tls.h  |   14 ++++++++------
 net/tls/tls_main.c |   15 ++++++++++++---
 net/tls/tls_sw.c   |    2 +-
 3 files changed, 21 insertions(+), 10 deletions(-)

--- a/include/net/tls.h
+++ b/include/net/tls.h
@@ -79,11 +79,13 @@ enum {
 	TLS_PENDING_CLOSED_RECORD
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
+	union tls_crypto_context crypto_send;
 
 	void *priv_ctx;
 
@@ -208,8 +210,8 @@ static inline void tls_fill_prepend(stru
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
--- a/net/tls/tls_main.c
+++ b/net/tls/tls_main.c
@@ -218,6 +218,15 @@ static void tls_write_space(struct sock
 	ctx->sk_write_space(sk);
 }
 
+static void tls_ctx_free(struct tls_context *ctx)
+{
+	if (!ctx)
+		return;
+
+	memzero_explicit(&ctx->crypto_send, sizeof(ctx->crypto_send));
+	kfree(ctx);
+}
+
 static void tls_sk_proto_close(struct sock *sk, long timeout)
 {
 	struct tls_context *ctx = tls_get_ctx(sk);
@@ -246,7 +255,7 @@ static void tls_sk_proto_close(struct so
 	kfree(ctx->iv);
 
 	sk_proto_close = ctx->sk_proto_close;
-	kfree(ctx);
+	tls_ctx_free(ctx);
 
 	release_sock(sk);
 	sk_proto_close(sk, timeout);
@@ -274,7 +283,7 @@ static int do_tls_getsockopt_tx(struct s
 	}
 
 	/* get user crypto info */
-	crypto_info = &ctx->crypto_send;
+	crypto_info = &ctx->crypto_send.info;
 
 	if (!TLS_CRYPTO_INFO_READY(crypto_info)) {
 		rc = -EBUSY;
@@ -371,7 +380,7 @@ static int do_tls_setsockopt_tx(struct s
 	}
 
 	/* get user crypto info */
-	crypto_info = &ctx->crypto_send;
+	crypto_info = &ctx->crypto_send.info;
 
 	/* Currently we don't support set crypto info more than one time */
 	if (TLS_CRYPTO_INFO_READY(crypto_info)) {
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -687,7 +687,7 @@ int tls_set_sw_offload(struct sock *sk,
 	ctx->priv_ctx = (struct tls_offload_context *)sw_ctx;
 	ctx->free_resources = tls_sw_free_resources;
 
-	crypto_info = &ctx->crypto_send;
+	crypto_info = &ctx->crypto_send.info;
 	switch (crypto_info->cipher_type) {
 	case TLS_CIPHER_AES_GCM_128: {
 		nonce_size = TLS_CIPHER_AES_GCM_128_IV_SIZE;


