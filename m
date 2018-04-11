Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752783AbeDKAwj (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 20:52:39 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:39064 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752245AbeDKAwh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 20:52:37 -0400
X-Google-Smtp-Source: AIpwx491bJXNr1r9hC2eCaXJyw93Z960zu5++7+WXSclPoUao3/um5kV14L3INpKp8tj3KF0vlYXcA==
Date: Tue, 10 Apr 2018 17:52:34 -0700
From: Kees Cook <keescook@chromium.org>
To: Dave Watson <davejwatson@fb.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        Ilya Lesokhin <ilyal@mellanox.com>,
        Aviad Yehezkel <aviadye@mellanox.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH] net/tls: Remove VLA usage
Message-ID: <20180411005234.GA39848@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the quest to remove VLAs from the kernel[1], this replaces the VLA
size with the only possible size used in the code, and adds a mechanism
to double-check future IV sizes.

[1] https://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=qPXydAacU1RqZWA@mail.gmail.com

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 net/tls/tls_sw.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index 4dc766b03f00..71e79597f940 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -41,6 +41,8 @@
 #include <net/strparser.h>
 #include <net/tls.h>
 
+#define MAX_IV_SIZE	TLS_CIPHER_AES_GCM_128_IV_SIZE
+
 static int tls_do_decryption(struct sock *sk,
 			     struct scatterlist *sgin,
 			     struct scatterlist *sgout,
@@ -673,7 +675,7 @@ static int decrypt_skb(struct sock *sk, struct sk_buff *skb,
 {
 	struct tls_context *tls_ctx = tls_get_ctx(sk);
 	struct tls_sw_context *ctx = tls_sw_ctx(tls_ctx);
-	char iv[TLS_CIPHER_AES_GCM_128_SALT_SIZE + tls_ctx->rx.iv_size];
+	char iv[TLS_CIPHER_AES_GCM_128_SALT_SIZE + MAX_IV_SIZE];
 	struct scatterlist sgin_arr[MAX_SKB_FRAGS + 2];
 	struct scatterlist *sgin = &sgin_arr[0];
 	struct strp_msg *rxm = strp_msg(skb);
@@ -1094,6 +1096,12 @@ int tls_set_sw_offload(struct sock *sk, struct tls_context *ctx, int tx)
 		goto free_priv;
 	}
 
+	/* Sanity-check the IV size for stack allocations. */
+	if (iv_size > MAX_IV_SIZE) {
+		rc = -EINVAL;
+		goto free_priv;
+	}
+
 	cctx->prepend_size = TLS_HEADER_SIZE + nonce_size;
 	cctx->tag_size = tag_size;
 	cctx->overhead_size = cctx->prepend_size + cctx->tag_size;
-- 
2.7.4


-- 
Kees Cook
Pixel Security
