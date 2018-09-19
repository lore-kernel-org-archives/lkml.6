Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02335ECE561
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 02:12:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85166214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 02:12:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TU30HTn/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85166214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731091AbeISHri (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 03:47:38 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:46668 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730950AbeISHqn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 03:46:43 -0400
Received: by mail-pl1-f193.google.com with SMTP id t19-v6so1850774ply.13
        for <linux-kernel@vger.kernel.org>; Tue, 18 Sep 2018 19:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0npKhypEj5VJ9eArFb+OgsloY11mz5XIZSdSjPh1TKU=;
        b=TU30HTn/dycsfQZhEE3qKWBB9Xd84Ksv02d1wTerGD1242zBcMoYbLD5/qpDzpnxH3
         /ebvBVUwYR5KdQV7dWBecT9YyeUy9VL4AlkBfzjitzc1JXdiGatnaRy6Y/cYR0jf22iQ
         gcHr3IPu5qRlqagZFGgcbGNxaEqmAmxc6yA7Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0npKhypEj5VJ9eArFb+OgsloY11mz5XIZSdSjPh1TKU=;
        b=OJOjZ2UOQNEHoyhno63l4LKoYWGo0uKD+znPD5O+pzm3dpG0zJ8LrYg7D81LQ89/VW
         IK99v12ucB9R8hX2jh3QS721KFyU7vHVef3ot+vP56wCzdXK+r4fHl6b+f9KnQsCuPUO
         KL8ts0cFia9QgGV7HTj3O9IO5Tjc/1FyDp8iw/AS18dGWnkNpHN2OnoeN3dvZEkg5/hU
         HLvU11b1T0A7rf3fMnA2JXivDsMEayxcANTTBsScztJ+/+I0UkvmWPA6WuzRRbxja/Br
         it3A8KxiZdEfxWbfOC2j3gc1bxjiunZCbSnQfpnGM10bwNT1YqvGdelu7Ol4VtDtObCR
         lHKQ==
X-Gm-Message-State: APzg51AecPSnCcnaBmOHk/FzjbmO37zGkr3qG4oqrWcnX5shkrrBDcfC
        YWaKWLRVbCWcgmGh3Z6WqaDvGQ==
X-Google-Smtp-Source: ANB0VdYiH3hMVUe8+8w7FxIaGwMj9Mabkd1Rp+CkD5xf12iTofOO4XhjnD0Ua3olZQc/kAa85BBsCg==
X-Received: by 2002:a17:902:3041:: with SMTP id u59-v6mr31291639plb.99.1537323076117;
        Tue, 18 Sep 2018 19:11:16 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id j16-v6sm37140718pfk.125.2018.09.18.19.11.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 18 Sep 2018 19:11:10 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Kees Cook <keescook@chromium.org>,
        David Howells <dhowells@redhat.com>,
        linux-afs@lists.infradead.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Eric Biggers <ebiggers@google.com>,
        linux-crypto <linux-crypto@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH crypto-next 10/23] rxrpc: Remove VLA usage of skcipher
Date:   Tue, 18 Sep 2018 19:10:47 -0700
Message-Id: <20180919021100.3380-11-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180919021100.3380-1-keescook@chromium.org>
References: <20180919021100.3380-1-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the quest to remove all stack VLA usage from the kernel[1], this
replaces struct crypto_skcipher and SKCIPHER_REQUEST_ON_STACK() usage
with struct crypto_sync_skcipher and SYNC_SKCIPHER_REQUEST_ON_STACK(),
which uses a fixed stack size.

[1] https://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=qPXydAacU1RqZWA@mail.gmail.com

Cc: David Howells <dhowells@redhat.com>
Cc: linux-afs@lists.infradead.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 net/rxrpc/ar-internal.h |  2 +-
 net/rxrpc/rxkad.c       | 44 ++++++++++++++++++++---------------------
 2 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/net/rxrpc/ar-internal.h b/net/rxrpc/ar-internal.h
index c97558710421..41be33c9eecf 100644
--- a/net/rxrpc/ar-internal.h
+++ b/net/rxrpc/ar-internal.h
@@ -442,7 +442,7 @@ struct rxrpc_connection {
 	struct sk_buff_head	rx_queue;	/* received conn-level packets */
 	const struct rxrpc_security *security;	/* applied security module */
 	struct key		*server_key;	/* security for this service */
-	struct crypto_skcipher	*cipher;	/* encryption handle */
+	struct crypto_sync_skcipher *cipher;	/* encryption handle */
 	struct rxrpc_crypt	csum_iv;	/* packet checksum base */
 	unsigned long		flags;
 	unsigned long		events;
diff --git a/net/rxrpc/rxkad.c b/net/rxrpc/rxkad.c
index cea16838d588..cbef9ea43dec 100644
--- a/net/rxrpc/rxkad.c
+++ b/net/rxrpc/rxkad.c
@@ -46,7 +46,7 @@ struct rxkad_level2_hdr {
  * alloc routine, but since we have it to hand, we use it to decrypt RESPONSE
  * packets
  */
-static struct crypto_skcipher *rxkad_ci;
+static struct crypto_sync_skcipher *rxkad_ci;
 static DEFINE_MUTEX(rxkad_ci_mutex);
 
 /*
@@ -54,7 +54,7 @@ static DEFINE_MUTEX(rxkad_ci_mutex);
  */
 static int rxkad_init_connection_security(struct rxrpc_connection *conn)
 {
-	struct crypto_skcipher *ci;
+	struct crypto_sync_skcipher *ci;
 	struct rxrpc_key_token *token;
 	int ret;
 
@@ -63,14 +63,14 @@ static int rxkad_init_connection_security(struct rxrpc_connection *conn)
 	token = conn->params.key->payload.data[0];
 	conn->security_ix = token->security_index;
 
-	ci = crypto_alloc_skcipher("pcbc(fcrypt)", 0, CRYPTO_ALG_ASYNC);
+	ci = crypto_alloc_sync_skcipher("pcbc(fcrypt)", 0, 0);
 	if (IS_ERR(ci)) {
 		_debug("no cipher");
 		ret = PTR_ERR(ci);
 		goto error;
 	}
 
-	if (crypto_skcipher_setkey(ci, token->kad->session_key,
+	if (crypto_sync_skcipher_setkey(ci, token->kad->session_key,
 				   sizeof(token->kad->session_key)) < 0)
 		BUG();
 
@@ -104,7 +104,7 @@ static int rxkad_init_connection_security(struct rxrpc_connection *conn)
 static int rxkad_prime_packet_security(struct rxrpc_connection *conn)
 {
 	struct rxrpc_key_token *token;
-	SKCIPHER_REQUEST_ON_STACK(req, conn->cipher);
+	SYNC_SKCIPHER_REQUEST_ON_STACK(req, conn->cipher);
 	struct scatterlist sg;
 	struct rxrpc_crypt iv;
 	__be32 *tmpbuf;
@@ -128,7 +128,7 @@ static int rxkad_prime_packet_security(struct rxrpc_connection *conn)
 	tmpbuf[3] = htonl(conn->security_ix);
 
 	sg_init_one(&sg, tmpbuf, tmpsize);
-	skcipher_request_set_tfm(req, conn->cipher);
+	skcipher_request_set_sync_tfm(req, conn->cipher);
 	skcipher_request_set_callback(req, 0, NULL, NULL);
 	skcipher_request_set_crypt(req, &sg, &sg, tmpsize, iv.x);
 	crypto_skcipher_encrypt(req);
@@ -167,7 +167,7 @@ static int rxkad_secure_packet_auth(const struct rxrpc_call *call,
 	memset(&iv, 0, sizeof(iv));
 
 	sg_init_one(&sg, sechdr, 8);
-	skcipher_request_set_tfm(req, call->conn->cipher);
+	skcipher_request_set_sync_tfm(req, call->conn->cipher);
 	skcipher_request_set_callback(req, 0, NULL, NULL);
 	skcipher_request_set_crypt(req, &sg, &sg, 8, iv.x);
 	crypto_skcipher_encrypt(req);
@@ -212,7 +212,7 @@ static int rxkad_secure_packet_encrypt(const struct rxrpc_call *call,
 	memcpy(&iv, token->kad->session_key, sizeof(iv));
 
 	sg_init_one(&sg[0], sechdr, sizeof(rxkhdr));
-	skcipher_request_set_tfm(req, call->conn->cipher);
+	skcipher_request_set_sync_tfm(req, call->conn->cipher);
 	skcipher_request_set_callback(req, 0, NULL, NULL);
 	skcipher_request_set_crypt(req, &sg[0], &sg[0], sizeof(rxkhdr), iv.x);
 	crypto_skcipher_encrypt(req);
@@ -250,7 +250,7 @@ static int rxkad_secure_packet(struct rxrpc_call *call,
 			       void *sechdr)
 {
 	struct rxrpc_skb_priv *sp;
-	SKCIPHER_REQUEST_ON_STACK(req, call->conn->cipher);
+	SYNC_SKCIPHER_REQUEST_ON_STACK(req, call->conn->cipher);
 	struct rxrpc_crypt iv;
 	struct scatterlist sg;
 	u32 x, y;
@@ -279,7 +279,7 @@ static int rxkad_secure_packet(struct rxrpc_call *call,
 	call->crypto_buf[1] = htonl(x);
 
 	sg_init_one(&sg, call->crypto_buf, 8);
-	skcipher_request_set_tfm(req, call->conn->cipher);
+	skcipher_request_set_sync_tfm(req, call->conn->cipher);
 	skcipher_request_set_callback(req, 0, NULL, NULL);
 	skcipher_request_set_crypt(req, &sg, &sg, 8, iv.x);
 	crypto_skcipher_encrypt(req);
@@ -352,7 +352,7 @@ static int rxkad_verify_packet_1(struct rxrpc_call *call, struct sk_buff *skb,
 	/* start the decryption afresh */
 	memset(&iv, 0, sizeof(iv));
 
-	skcipher_request_set_tfm(req, call->conn->cipher);
+	skcipher_request_set_sync_tfm(req, call->conn->cipher);
 	skcipher_request_set_callback(req, 0, NULL, NULL);
 	skcipher_request_set_crypt(req, sg, sg, 8, iv.x);
 	crypto_skcipher_decrypt(req);
@@ -450,7 +450,7 @@ static int rxkad_verify_packet_2(struct rxrpc_call *call, struct sk_buff *skb,
 	token = call->conn->params.key->payload.data[0];
 	memcpy(&iv, token->kad->session_key, sizeof(iv));
 
-	skcipher_request_set_tfm(req, call->conn->cipher);
+	skcipher_request_set_sync_tfm(req, call->conn->cipher);
 	skcipher_request_set_callback(req, 0, NULL, NULL);
 	skcipher_request_set_crypt(req, sg, sg, len, iv.x);
 	crypto_skcipher_decrypt(req);
@@ -506,7 +506,7 @@ static int rxkad_verify_packet(struct rxrpc_call *call, struct sk_buff *skb,
 			       unsigned int offset, unsigned int len,
 			       rxrpc_seq_t seq, u16 expected_cksum)
 {
-	SKCIPHER_REQUEST_ON_STACK(req, call->conn->cipher);
+	SYNC_SKCIPHER_REQUEST_ON_STACK(req, call->conn->cipher);
 	struct rxrpc_crypt iv;
 	struct scatterlist sg;
 	bool aborted;
@@ -529,7 +529,7 @@ static int rxkad_verify_packet(struct rxrpc_call *call, struct sk_buff *skb,
 	call->crypto_buf[1] = htonl(x);
 
 	sg_init_one(&sg, call->crypto_buf, 8);
-	skcipher_request_set_tfm(req, call->conn->cipher);
+	skcipher_request_set_sync_tfm(req, call->conn->cipher);
 	skcipher_request_set_callback(req, 0, NULL, NULL);
 	skcipher_request_set_crypt(req, &sg, &sg, 8, iv.x);
 	crypto_skcipher_encrypt(req);
@@ -755,7 +755,7 @@ static void rxkad_encrypt_response(struct rxrpc_connection *conn,
 				   struct rxkad_response *resp,
 				   const struct rxkad_key *s2)
 {
-	SKCIPHER_REQUEST_ON_STACK(req, conn->cipher);
+	SYNC_SKCIPHER_REQUEST_ON_STACK(req, conn->cipher);
 	struct rxrpc_crypt iv;
 	struct scatterlist sg[1];
 
@@ -764,7 +764,7 @@ static void rxkad_encrypt_response(struct rxrpc_connection *conn,
 
 	sg_init_table(sg, 1);
 	sg_set_buf(sg, &resp->encrypted, sizeof(resp->encrypted));
-	skcipher_request_set_tfm(req, conn->cipher);
+	skcipher_request_set_sync_tfm(req, conn->cipher);
 	skcipher_request_set_callback(req, 0, NULL, NULL);
 	skcipher_request_set_crypt(req, sg, sg, sizeof(resp->encrypted), iv.x);
 	crypto_skcipher_encrypt(req);
@@ -1021,7 +1021,7 @@ static void rxkad_decrypt_response(struct rxrpc_connection *conn,
 				   struct rxkad_response *resp,
 				   const struct rxrpc_crypt *session_key)
 {
-	SKCIPHER_REQUEST_ON_STACK(req, rxkad_ci);
+	SYNC_SKCIPHER_REQUEST_ON_STACK(req, rxkad_ci);
 	struct scatterlist sg[1];
 	struct rxrpc_crypt iv;
 
@@ -1031,7 +1031,7 @@ static void rxkad_decrypt_response(struct rxrpc_connection *conn,
 	ASSERT(rxkad_ci != NULL);
 
 	mutex_lock(&rxkad_ci_mutex);
-	if (crypto_skcipher_setkey(rxkad_ci, session_key->x,
+	if (crypto_sync_skcipher_setkey(rxkad_ci, session_key->x,
 				   sizeof(*session_key)) < 0)
 		BUG();
 
@@ -1039,7 +1039,7 @@ static void rxkad_decrypt_response(struct rxrpc_connection *conn,
 
 	sg_init_table(sg, 1);
 	sg_set_buf(sg, &resp->encrypted, sizeof(resp->encrypted));
-	skcipher_request_set_tfm(req, rxkad_ci);
+	skcipher_request_set_sync_tfm(req, rxkad_ci);
 	skcipher_request_set_callback(req, 0, NULL, NULL);
 	skcipher_request_set_crypt(req, sg, sg, sizeof(resp->encrypted), iv.x);
 	crypto_skcipher_decrypt(req);
@@ -1218,7 +1218,7 @@ static void rxkad_clear(struct rxrpc_connection *conn)
 	_enter("");
 
 	if (conn->cipher)
-		crypto_free_skcipher(conn->cipher);
+		crypto_free_sync_skcipher(conn->cipher);
 }
 
 /*
@@ -1228,7 +1228,7 @@ static int rxkad_init(void)
 {
 	/* pin the cipher we need so that the crypto layer doesn't invoke
 	 * keventd to go get it */
-	rxkad_ci = crypto_alloc_skcipher("pcbc(fcrypt)", 0, CRYPTO_ALG_ASYNC);
+	rxkad_ci = crypto_alloc_sync_skcipher("pcbc(fcrypt)", 0, 0);
 	return PTR_ERR_OR_ZERO(rxkad_ci);
 }
 
@@ -1238,7 +1238,7 @@ static int rxkad_init(void)
 static void rxkad_exit(void)
 {
 	if (rxkad_ci)
-		crypto_free_skcipher(rxkad_ci);
+		crypto_free_sync_skcipher(rxkad_ci);
 }
 
 /*
-- 
2.17.1

