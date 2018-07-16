Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75A4BECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 03:50:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1382E20873
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 03:50:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jsuzBESl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1382E20873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726811AbeGPEPK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 00:15:10 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:36231 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726012AbeGPEPK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 00:15:10 -0400
Received: by mail-pg1-f196.google.com with SMTP id m19-v6so6979400pgv.3
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jul 2018 20:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=OiK51L/PxjpUuWTryNUg+/GOgiXpmpK8aCN/BU4XM1o=;
        b=jsuzBESlqQdIZ7464OMnASnx87MlSsnMyxDh3cUtebd2KIYz7uTEp1RtdyMjE+4Tmv
         LIClp/cD3nqEBykEsnu0Yr7ozyLbUz8NSeQV0IUejhYzqQOcFryBEC02bPy51A1feiQ0
         MknvRGBNs/DimapYIx9kKk9PvEqLELuxbb/tE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=OiK51L/PxjpUuWTryNUg+/GOgiXpmpK8aCN/BU4XM1o=;
        b=SSDf93zkNbudCuw0VAxpeyccfaUKVKweHx7FaZoSKSQJ6Y7qkW6fHQz+qqr8P91dn+
         JgX7+RKCRE4rSevx+bTyuj45xIra7Mfy1ykYR3rToXPNcGlpwe1dvQ6LK0fsjF7No5AF
         NZCtSPSNfe/2zQZI2LyaOy2+hrwdeROoHaubcULJIzpDQB+7ni5ipX2c6iRc1msxeGq3
         lZswQW5poLOu5jTNp7ax07fpM3XdxxqyT0avp9eRETv9jp5tazNovXZGbsOPz3Wc1ucF
         b5L0ujk5jvzNPthLcMElbjCAGulKhXc8T8DCAuWfE/OfTTzjAU7po5gEA7S7jH0N60Lg
         y0Cg==
X-Gm-Message-State: AOUpUlHLlb1nrQH6FmiSJIPbhX9B10e0QgwQ5ty2p7iTHTimzHCfuRFp
        8QeHQ3ZrT35U0djsvkNP0ZOsYg==
X-Google-Smtp-Source: AAOMgpfL9eF/9+OA8ZTaZ6ZRgEVIRZrtwHnXj0+XjKW0rGAWi/Ix0Yabj+8JEE0UkDbJ3gpAk4kLhw==
X-Received: by 2002:aa7:82c3:: with SMTP id f3-v6mr3435320pfn.136.1531712990093;
        Sun, 15 Jul 2018 20:49:50 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id n12-v6sm34912027pfh.146.2018.07.15.20.49.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 15 Jul 2018 20:49:48 -0700 (PDT)
Date:   Sun, 15 Jul 2018 20:49:47 -0700
From:   Kees Cook <keescook@chromium.org>
To:     David Howells <dhowells@redhat.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        Arnd Bergmann <arnd@arndb.de>,
        Eric Biggers <ebiggers@google.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] rxrpc: Reuse SKCIPHER_REQUEST_ON_STACK buffer
Message-ID: <20180716034947.GA32022@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The use of SKCIPHER_REQUEST_ON_STACK() will trigger FRAME_WARN warnings
(when less than 2048) once the VLA is no longer hidden from the check:

net/rxrpc/rxkad.c:398:1: warning: the frame size of 1152 bytes is larger than 1024 bytes [-Wframe-larger-than=]
net/rxrpc/rxkad.c:242:1: warning: the frame size of 1152 bytes is larger than 1024 bytes [-Wframe-larger-than=]

This passes the initial SKCIPHER_REQUEST_ON_STACK allocation to the leaf
functions for reuse. Two requests allocated on the stack are not needed
when only one is used at a time.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 net/rxrpc/rxkad.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/net/rxrpc/rxkad.c b/net/rxrpc/rxkad.c
index 278ac0807a60..6393391fac86 100644
--- a/net/rxrpc/rxkad.c
+++ b/net/rxrpc/rxkad.c
@@ -146,10 +146,10 @@ static int rxkad_prime_packet_security(struct rxrpc_connection *conn)
 static int rxkad_secure_packet_auth(const struct rxrpc_call *call,
 				    struct sk_buff *skb,
 				    u32 data_size,
-				    void *sechdr)
+				    void *sechdr,
+				    struct skcipher_request *req)
 {
 	struct rxrpc_skb_priv *sp = rxrpc_skb(skb);
-	SKCIPHER_REQUEST_ON_STACK(req, call->conn->cipher);
 	struct rxkad_level1_hdr hdr;
 	struct rxrpc_crypt iv;
 	struct scatterlist sg;
@@ -183,12 +183,12 @@ static int rxkad_secure_packet_auth(const struct rxrpc_call *call,
 static int rxkad_secure_packet_encrypt(const struct rxrpc_call *call,
 				       struct sk_buff *skb,
 				       u32 data_size,
-				       void *sechdr)
+				       void *sechdr,
+				       struct skcipher_request *req)
 {
 	const struct rxrpc_key_token *token;
 	struct rxkad_level2_hdr rxkhdr;
 	struct rxrpc_skb_priv *sp;
-	SKCIPHER_REQUEST_ON_STACK(req, call->conn->cipher);
 	struct rxrpc_crypt iv;
 	struct scatterlist sg[16];
 	struct sk_buff *trailer;
@@ -296,11 +296,12 @@ static int rxkad_secure_packet(struct rxrpc_call *call,
 		ret = 0;
 		break;
 	case RXRPC_SECURITY_AUTH:
-		ret = rxkad_secure_packet_auth(call, skb, data_size, sechdr);
+		ret = rxkad_secure_packet_auth(call, skb, data_size, sechdr,
+					       req);
 		break;
 	case RXRPC_SECURITY_ENCRYPT:
 		ret = rxkad_secure_packet_encrypt(call, skb, data_size,
-						  sechdr);
+						  sechdr, req);
 		break;
 	default:
 		ret = -EPERM;
@@ -316,10 +317,10 @@ static int rxkad_secure_packet(struct rxrpc_call *call,
  */
 static int rxkad_verify_packet_1(struct rxrpc_call *call, struct sk_buff *skb,
 				 unsigned int offset, unsigned int len,
-				 rxrpc_seq_t seq)
+				 rxrpc_seq_t seq,
+				 struct skcipher_request *req)
 {
 	struct rxkad_level1_hdr sechdr;
-	SKCIPHER_REQUEST_ON_STACK(req, call->conn->cipher);
 	struct rxrpc_crypt iv;
 	struct scatterlist sg[16];
 	struct sk_buff *trailer;
@@ -402,11 +403,11 @@ static int rxkad_verify_packet_1(struct rxrpc_call *call, struct sk_buff *skb,
  */
 static int rxkad_verify_packet_2(struct rxrpc_call *call, struct sk_buff *skb,
 				 unsigned int offset, unsigned int len,
-				 rxrpc_seq_t seq)
+				 rxrpc_seq_t seq,
+				 struct skcipher_request *req)
 {
 	const struct rxrpc_key_token *token;
 	struct rxkad_level2_hdr sechdr;
-	SKCIPHER_REQUEST_ON_STACK(req, call->conn->cipher);
 	struct rxrpc_crypt iv;
 	struct scatterlist _sg[4], *sg;
 	struct sk_buff *trailer;
@@ -549,9 +550,9 @@ static int rxkad_verify_packet(struct rxrpc_call *call, struct sk_buff *skb,
 	case RXRPC_SECURITY_PLAIN:
 		return 0;
 	case RXRPC_SECURITY_AUTH:
-		return rxkad_verify_packet_1(call, skb, offset, len, seq);
+		return rxkad_verify_packet_1(call, skb, offset, len, seq, req);
 	case RXRPC_SECURITY_ENCRYPT:
-		return rxkad_verify_packet_2(call, skb, offset, len, seq);
+		return rxkad_verify_packet_2(call, skb, offset, len, seq, req);
 	default:
 		return -ENOANO;
 	}
-- 
2.17.1


-- 
Kees Cook
Pixel Security
