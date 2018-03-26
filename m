Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751995AbeCZLja (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 07:39:30 -0400
Received: from la.guarana.org ([173.254.219.205]:47754 "EHLO la.guarana.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751890AbeCZLj3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 07:39:29 -0400
Date: Mon, 26 Mar 2018 07:39:29 -0400
From: Kevin Easton <kevin@guarana.org>
To: Steffen Klassert <steffen.klassert@secunet.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] af_key: Always verify length of provided sadb_key
Message-ID: <43d418aeb2390080eb71ef4161bc029758118f93.1522063171.git.kevin@guarana.org>
References: <cover.1522063171.git.kevin@guarana.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1522063171.git.kevin@guarana.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Key extensions (struct sadb_key) include a user-specified number of key
bits.  The kernel uses that number to determine how much key data to copy
out of the message in pfkey_msg2xfrm_state().

The length of the sadb_key message must be verified to be long enough,
even in the case of SADB_X_AALG_NULL.  Furthermore, the sadb_key_len value
must be long enough to include both the key data and the struct sadb_key
itself.

Introduce a helper function verify_key_len(), and call it from
parse_exthdrs() where other exthdr types are similarly checked for
correctness.

Signed-off-by: Kevin Easton <kevin@guarana.org>
Reported-by: syzbot+5022a34ca5a3d49b84223653fab632dfb7b4cf37@syzkaller.appspotmail.com
---
 net/key/af_key.c | 45 +++++++++++++++++++++++++++++++++++----------
 1 file changed, 35 insertions(+), 10 deletions(-)

diff --git a/net/key/af_key.c b/net/key/af_key.c
index 911b68d..f3ebb84 100644
--- a/net/key/af_key.c
+++ b/net/key/af_key.c
@@ -437,6 +437,24 @@ static int verify_address_len(const void *p)
 	return 0;
 }
 
+static inline int sadb_key_len(const struct sadb_key *key)
+{
+	int key_bytes = DIV_ROUND_UP(key->sadb_key_bits, 8);
+
+	return DIV_ROUND_UP(sizeof(struct sadb_key) + key_bytes,
+			    sizeof(uint64_t));
+}
+
+static int verify_key_len(const void *p)
+{
+	const struct sadb_key *key = p;
+
+	if (sadb_key_len(key) > key->sadb_key_len)
+		return -EINVAL;
+
+	return 0;
+}
+
 static inline int pfkey_sec_ctx_len(const struct sadb_x_sec_ctx *sec_ctx)
 {
 	return DIV_ROUND_UP(sizeof(struct sadb_x_sec_ctx) +
@@ -533,16 +551,25 @@ static int parse_exthdrs(struct sk_buff *skb, const struct sadb_msg *hdr, void *
 				return -EINVAL;
 			if (ext_hdrs[ext_type-1] != NULL)
 				return -EINVAL;
-			if (ext_type == SADB_EXT_ADDRESS_SRC ||
-			    ext_type == SADB_EXT_ADDRESS_DST ||
-			    ext_type == SADB_EXT_ADDRESS_PROXY ||
-			    ext_type == SADB_X_EXT_NAT_T_OA) {
+			switch (ext_type) {
+			case SADB_EXT_ADDRESS_SRC:
+			case SADB_EXT_ADDRESS_DST:
+			case SADB_EXT_ADDRESS_PROXY:
+			case SADB_X_EXT_NAT_T_OA:
 				if (verify_address_len(p))
 					return -EINVAL;
-			}
-			if (ext_type == SADB_X_EXT_SEC_CTX) {
+				break;
+			case SADB_X_EXT_SEC_CTX:
 				if (verify_sec_ctx_len(p))
 					return -EINVAL;
+				break;
+			case SADB_EXT_KEY_AUTH:
+			case SADB_EXT_KEY_ENCRYPT:
+				if (verify_key_len(p))
+					return -EINVAL;
+				break;
+			default:
+				break;
 			}
 			ext_hdrs[ext_type-1] = (void *) p;
 		}
@@ -1105,14 +1132,12 @@ static struct xfrm_state * pfkey_msg2xfrm_state(struct net *net,
 	key = ext_hdrs[SADB_EXT_KEY_AUTH - 1];
 	if (key != NULL &&
 	    sa->sadb_sa_auth != SADB_X_AALG_NULL &&
-	    (DIV_ROUND_UP(key->sadb_key_bits, 8) == 0 ||
-	     DIV_ROUND_UP(key->sadb_key_bits, 8) > key->sadb_key_len * sizeof(uint64_t)))
+	    key->sadb_key_bits == 0)
 		return ERR_PTR(-EINVAL);
 	key = ext_hdrs[SADB_EXT_KEY_ENCRYPT-1];
 	if (key != NULL &&
 	    sa->sadb_sa_encrypt != SADB_EALG_NULL &&
-	    (DIV_ROUND_UP(key->sadb_key_bits, 8) == 0 ||
-	     DIV_ROUND_UP(key->sadb_key_bits, 8) > key->sadb_key_len * sizeof(uint64_t)))
+	    key->sadb_key_bits == 0)
 		return ERR_PTR(-EINVAL);
 
 	x = xfrm_state_alloc(net);
-- 
2.8.1
