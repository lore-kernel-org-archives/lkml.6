Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9FF8C6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 16:56:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6468F20875
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 16:56:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CgkzIzBn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6468F20875
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388602AbeGXSDx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 14:03:53 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:34049 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388539AbeGXSDm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 14:03:42 -0400
Received: by mail-pg1-f194.google.com with SMTP id y5-v6so3319374pgv.1
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jul 2018 09:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0ojuoFtpY49pRoRZrlcC4u6qgVkehMZZO1daFH4ebQg=;
        b=CgkzIzBn05lmhk+e5TxjjScesDSSObcCCDKeeEetNTDQqzFBrOQOV5dpyPCniZo7Vx
         ya0Qd8SN1iPqfA/0N1NH3sMbIObBCd3gLY9JtF7Eol3k1gcOI0v7oiPJWAB6Rb4aejv+
         1n3po6/tG1epyvHDeSHaxKEgii74YV5qc+tvQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0ojuoFtpY49pRoRZrlcC4u6qgVkehMZZO1daFH4ebQg=;
        b=HFuz9ty78AFiFod9CWQBH1BK627lFRUqVVHCjFoB2wRUIFG69Vt93rBvKwgMos8s+i
         vYcfFZbDCMWd0yPaTV55bvteMZkM/gNC5hOrYsMHjQEpg09lc9u/R8BxDwGCDWayVwQB
         zjCUts6JpbP4PwQLLmos//IqvP7fHUBw6QhS1TfK9jhPeeUZfVCeb5BVWR8Ip1ppVzDO
         bXQWGtbuMXLsiA2WtoSaqIrbuKT9WhYhGPV73f79q/OcMIje8vhKWtvMZSLPjo6aq2+9
         EKYyQfd5kce5Uz1AlGlZhjtb6fSVPuHF2fsW4HwSLduwsY/nJRExMzVyqlWNQWxzzCQP
         8CHA==
X-Gm-Message-State: AOUpUlFscn3EYQAx3OA4QZNLeCA1aUYg8iZJuluFzjx3EguId/nh9hF0
        yhdVWYoLVYcaofngSHWW9uWKlQ==
X-Google-Smtp-Source: AAOMgpf+xHiYmSuy+iFsx+BWYX3LSu60mgKBhzZNEgiNUYprSNUZMSYoiShz+vEbEyowvo14sudtLA==
X-Received: by 2002:a63:714a:: with SMTP id b10-v6mr16668343pgn.73.1532451379202;
        Tue, 24 Jul 2018 09:56:19 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id b12-v6sm17874054pfe.148.2018.07.24.09.56.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 24 Jul 2018 09:56:17 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Kees Cook <keescook@chromium.org>, Arnd Bergmann <arnd@arndb.de>,
        Eric Biggers <ebiggers@google.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Alasdair Kergon <agk@redhat.com>,
        Rabin Vincent <rabinv@axis.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Philipp Reisner <philipp.reisner@linbit.com>,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        Jens Axboe <axboe@kernel.dk>,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Paul Mackerras <paulus@samba.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Howells <dhowells@redhat.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Tudor-Dan Ambarus <tudor.ambarus@microchip.com>,
        Jia-Ju Bai <baijiaju1990@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Will Deacon <will.deacon@arm.com>, dm-devel@redhat.com,
        linux-pm@vger.kernel.org, linux-crypto@vger.kernel.org,
        drbd-dev@lists.linbit.com, linux-block@vger.kernel.org,
        qat-linux@intel.com, linux-ppp@vger.kernel.org,
        netdev@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-afs@lists.infradead.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 16/18] rxrpc: Reuse SKCIPHER_REQUEST_ON_STACK buffer
Date:   Tue, 24 Jul 2018 09:49:34 -0700
Message-Id: <20180724164936.37477-17-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180724164936.37477-1-keescook@chromium.org>
References: <20180724164936.37477-1-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The use of SKCIPHER_REQUEST_ON_STACK() will trigger FRAME_WARN warnings
(when less than 2048) once the VLA is no longer hidden from the check:

net/rxrpc/rxkad.c:398:1: warning: the frame size of 1152 bytes is larger than 1024 bytes [-Wframe-larger-than=]
net/rxrpc/rxkad.c:242:1: warning: the frame size of 1152 bytes is larger than 1024 bytes [-Wframe-larger-than=]

This passes the initial SKCIPHER_REQUEST_ON_STACK allocation to the leaf
functions for reuse. Two requests allocated on the stack is not needed
when only one is used at a time.

Signed-off-by: Kees Cook <keescook@chromium.org>
Acked-by: Arnd Bergmann <arnd@arndb.de>
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

