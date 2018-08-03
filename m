Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF482C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 09:15:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EF452174C
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 09:15:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EF452174C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732440AbeHCLKv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 07:10:51 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51848 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728442AbeHCLKv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 07:10:51 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 985D740201DA;
        Fri,  3 Aug 2018 09:15:26 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-78.rdu2.redhat.com [10.10.120.78])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AEAE0215670D;
        Fri,  3 Aug 2018 09:15:25 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH net-next] rxrpc: Reuse SKCIPHER_REQUEST_ON_STACK buffer
From:   David Howells <dhowells@redhat.com>
To:     netdev@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>, Arnd Bergmann <arnd@arndb.de>,
        dhowells@redhat.com, linux-afs@lists.infradead.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 03 Aug 2018 10:15:25 +0100
Message-ID: <153328772507.9245.16028483796299905227.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Fri, 03 Aug 2018 09:15:26 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Fri, 03 Aug 2018 09:15:26 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'dhowells@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kees Cook <keescook@chromium.org>

The use of SKCIPHER_REQUEST_ON_STACK() will trigger FRAME_WARN warnings
(when less than 2048) once the VLA is no longer hidden from the check:

net/rxrpc/rxkad.c:398:1: warning: the frame size of 1152 bytes is larger than 1024 bytes [-Wframe-larger-than=]
net/rxrpc/rxkad.c:242:1: warning: the frame size of 1152 bytes is larger than 1024 bytes [-Wframe-larger-than=]

This passes the initial SKCIPHER_REQUEST_ON_STACK allocation to the leaf
functions for reuse. Two requests allocated on the stack is not needed
when only one is used at a time.

Signed-off-by: Kees Cook <keescook@chromium.org>
Acked-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: David Howells <dhowells@redhat.com>
---

 net/rxrpc/rxkad.c |   25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/net/rxrpc/rxkad.c b/net/rxrpc/rxkad.c
index 6988073ae842..eaf8f4f446b0 100644
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

