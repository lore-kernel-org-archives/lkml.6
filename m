Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751865AbeCZLjS (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 07:39:18 -0400
Received: from la.guarana.org ([173.254.219.205]:47542 "EHLO la.guarana.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751674AbeCZLjR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 07:39:17 -0400
Date: Mon, 26 Mar 2018 07:39:16 -0400
From: Kevin Easton <kevin@guarana.org>
To: Steffen Klassert <steffen.klassert@secunet.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] af_key: Use DIV_ROUND_UP() instead of open-coded
 equivalent
Message-ID: <930c4e2a88e93c6863ddb97df9ebd0fa1b32149e.1522063171.git.kevin@guarana.org>
References: <cover.1522063171.git.kevin@guarana.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1522063171.git.kevin@guarana.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Several places use (x + 7) / 8 to convert from a number of bits to a number
of bytes.  Replace those with DIV_ROUND_UP(x, 8) instead, for consistency
with other parts of the same file.

Signed-off-by: Kevin Easton <kevin@guarana.org>
---
 net/key/af_key.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/net/key/af_key.c b/net/key/af_key.c
index 7e2e718..911b68d 100644
--- a/net/key/af_key.c
+++ b/net/key/af_key.c
@@ -795,12 +795,12 @@ static struct sk_buff *__pfkey_xfrm_state2msg(const struct xfrm_state *x,
 	if (add_keys) {
 		if (x->aalg && x->aalg->alg_key_len) {
 			auth_key_size =
-				PFKEY_ALIGN8((x->aalg->alg_key_len + 7) / 8);
+				PFKEY_ALIGN8(DIV_ROUND_UP(x->aalg->alg_key_len, 8));
 			size += sizeof(struct sadb_key) + auth_key_size;
 		}
 		if (x->ealg && x->ealg->alg_key_len) {
 			encrypt_key_size =
-				PFKEY_ALIGN8((x->ealg->alg_key_len+7) / 8);
+				PFKEY_ALIGN8(DIV_ROUND_UP(x->ealg->alg_key_len, 8));
 			size += sizeof(struct sadb_key) + encrypt_key_size;
 		}
 	}
@@ -960,7 +960,8 @@ static struct sk_buff *__pfkey_xfrm_state2msg(const struct xfrm_state *x,
 		key->sadb_key_exttype = SADB_EXT_KEY_AUTH;
 		key->sadb_key_bits = x->aalg->alg_key_len;
 		key->sadb_key_reserved = 0;
-		memcpy(key + 1, x->aalg->alg_key, (x->aalg->alg_key_len+7)/8);
+		memcpy(key + 1, x->aalg->alg_key,
+			DIV_ROUND_UP(x->aalg->alg_key_len, 8));
 	}
 	/* encrypt key */
 	if (add_keys && encrypt_key_size) {
@@ -971,7 +972,7 @@ static struct sk_buff *__pfkey_xfrm_state2msg(const struct xfrm_state *x,
 		key->sadb_key_bits = x->ealg->alg_key_len;
 		key->sadb_key_reserved = 0;
 		memcpy(key + 1, x->ealg->alg_key,
-		       (x->ealg->alg_key_len+7)/8);
+			DIV_ROUND_UP(x->ealg->alg_key_len, 8));
 	}
 
 	/* sa */
@@ -1104,14 +1105,14 @@ static struct xfrm_state * pfkey_msg2xfrm_state(struct net *net,
 	key = ext_hdrs[SADB_EXT_KEY_AUTH - 1];
 	if (key != NULL &&
 	    sa->sadb_sa_auth != SADB_X_AALG_NULL &&
-	    ((key->sadb_key_bits+7) / 8 == 0 ||
-	     (key->sadb_key_bits+7) / 8 > key->sadb_key_len * sizeof(uint64_t)))
+	    (DIV_ROUND_UP(key->sadb_key_bits, 8) == 0 ||
+	     DIV_ROUND_UP(key->sadb_key_bits, 8) > key->sadb_key_len * sizeof(uint64_t)))
 		return ERR_PTR(-EINVAL);
 	key = ext_hdrs[SADB_EXT_KEY_ENCRYPT-1];
 	if (key != NULL &&
 	    sa->sadb_sa_encrypt != SADB_EALG_NULL &&
-	    ((key->sadb_key_bits+7) / 8 == 0 ||
-	     (key->sadb_key_bits+7) / 8 > key->sadb_key_len * sizeof(uint64_t)))
+	    (DIV_ROUND_UP(key->sadb_key_bits, 8) == 0 ||
+	     DIV_ROUND_UP(key->sadb_key_bits, 8) > key->sadb_key_len * sizeof(uint64_t)))
 		return ERR_PTR(-EINVAL);
 
 	x = xfrm_state_alloc(net);
@@ -1168,7 +1169,7 @@ static struct xfrm_state * pfkey_msg2xfrm_state(struct net *net,
 			goto out;
 		}
 		if (key)
-			keysize = (key->sadb_key_bits + 7) / 8;
+			keysize = DIV_ROUND_UP(key->sadb_key_bits, 8);
 		x->aalg = kmalloc(sizeof(*x->aalg) + keysize, GFP_KERNEL);
 		if (!x->aalg) {
 			err = -ENOMEM;
@@ -1207,7 +1208,7 @@ static struct xfrm_state * pfkey_msg2xfrm_state(struct net *net,
 			}
 			key = (struct sadb_key*) ext_hdrs[SADB_EXT_KEY_ENCRYPT-1];
 			if (key)
-				keysize = (key->sadb_key_bits + 7) / 8;
+				keysize = DIV_ROUND_UP(key->sadb_key_bits, 8);
 			x->ealg = kmalloc(sizeof(*x->ealg) + keysize, GFP_KERNEL);
 			if (!x->ealg) {
 				err = -ENOMEM;
-- 
2.8.1
