Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752185AbeDGPku (ORCPT <rfc822;w@1wt.eu>);
        Sat, 7 Apr 2018 11:40:50 -0400
Received: from la.guarana.org ([173.254.219.205]:58870 "EHLO la.guarana.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751807AbeDGPkr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Apr 2018 11:40:47 -0400
Date: Sat, 7 Apr 2018 11:40:47 -0400
From: Kevin Easton <kevin@guarana.org>
To: Steffen Klassert <steffen.klassert@secunet.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] af_key: Use DIV_ROUND_UP() instead of open-coded
 equivalent
Message-ID: <494dcebdc07530d6afbd7eda300da890a3e68e1c.1523115061.git.kevin@guarana.org>
References: <cover.1523115061.git.kevin@guarana.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1523115061.git.kevin@guarana.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Several places use (x + 7) / 8 to convert from a number of bits to a number
of bytes.  Replace those with DIV_ROUND_UP(x, 8) instead, for consistency
with other parts of the same file.

Signed-off-by: Kevin Easton <kevin@guarana.org>
---
 net/key/af_key.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/net/key/af_key.c b/net/key/af_key.c
index e62e52e..f3ebb84 100644
--- a/net/key/af_key.c
+++ b/net/key/af_key.c
@@ -822,12 +822,12 @@ static struct sk_buff *__pfkey_xfrm_state2msg(const struct xfrm_state *x,
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
@@ -987,7 +987,8 @@ static struct sk_buff *__pfkey_xfrm_state2msg(const struct xfrm_state *x,
 		key->sadb_key_exttype = SADB_EXT_KEY_AUTH;
 		key->sadb_key_bits = x->aalg->alg_key_len;
 		key->sadb_key_reserved = 0;
-		memcpy(key + 1, x->aalg->alg_key, (x->aalg->alg_key_len+7)/8);
+		memcpy(key + 1, x->aalg->alg_key,
+			DIV_ROUND_UP(x->aalg->alg_key_len, 8));
 	}
 	/* encrypt key */
 	if (add_keys && encrypt_key_size) {
@@ -998,7 +999,7 @@ static struct sk_buff *__pfkey_xfrm_state2msg(const struct xfrm_state *x,
 		key->sadb_key_bits = x->ealg->alg_key_len;
 		key->sadb_key_reserved = 0;
 		memcpy(key + 1, x->ealg->alg_key,
-		       (x->ealg->alg_key_len+7)/8);
+			DIV_ROUND_UP(x->ealg->alg_key_len, 8));
 	}
 
 	/* sa */
@@ -1193,7 +1194,7 @@ static struct xfrm_state * pfkey_msg2xfrm_state(struct net *net,
 			goto out;
 		}
 		if (key)
-			keysize = (key->sadb_key_bits + 7) / 8;
+			keysize = DIV_ROUND_UP(key->sadb_key_bits, 8);
 		x->aalg = kmalloc(sizeof(*x->aalg) + keysize, GFP_KERNEL);
 		if (!x->aalg) {
 			err = -ENOMEM;
@@ -1232,7 +1233,7 @@ static struct xfrm_state * pfkey_msg2xfrm_state(struct net *net,
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
