Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752007AbeCUNmw (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 09:42:52 -0400
Received: from gateway24.websitewelcome.com ([192.185.51.209]:34657 "EHLO
        gateway24.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751597AbeCUNmu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 09:42:50 -0400
Date: Wed, 21 Mar 2018 08:42:47 -0500
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To: Johannes Berg <johannes@sipsolutions.net>,
        "David S. Miller" <davem@davemloft.net>
Cc: linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] mac80211: aes-cmac: remove VLA usage
Message-ID: <20180321134247.GA1275@embeddedgus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.145.54.187
X-Source-L: No
X-Exim-ID: 1eye0v-000H1e-0p
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedgus) [189.145.54.187]:43252
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 5
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to enabling -Wvla, remove VLAs and replace them
with dynamic memory allocation instead.

The use of stack Variable Length Arrays needs to be avoided, as they
can be a vector for stack exhaustion, which can be both a runtime bug
or a security flaw. Also, in general, as code evolves it is easy to
lose track of how big a VLA can get. Thus, we can end up having runtime
failures that are hard to debug.

Also, fixed as part of the directive to remove all VLAs from
the kernel: https://lkml.org/lkml/2018/3/7/621

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 net/mac80211/aes_cmac.c | 36 ++++++++++++++++++++++++------------
 1 file changed, 24 insertions(+), 12 deletions(-)

diff --git a/net/mac80211/aes_cmac.c b/net/mac80211/aes_cmac.c
index 2fb6558..c9444bf 100644
--- a/net/mac80211/aes_cmac.c
+++ b/net/mac80211/aes_cmac.c
@@ -27,30 +27,42 @@ static const u8 zero[CMAC_TLEN_256];
 void ieee80211_aes_cmac(struct crypto_shash *tfm, const u8 *aad,
 			const u8 *data, size_t data_len, u8 *mic)
 {
-	SHASH_DESC_ON_STACK(desc, tfm);
+	struct shash_desc *shash;
 	u8 out[AES_BLOCK_SIZE];
 
-	desc->tfm = tfm;
+	shash = kmalloc(sizeof(*shash) + crypto_shash_descsize(tfm),
+			GFP_KERNEL);
+	if (!shash)
+		return;
 
-	crypto_shash_init(desc);
-	crypto_shash_update(desc, aad, AAD_LEN);
-	crypto_shash_update(desc, data, data_len - CMAC_TLEN);
-	crypto_shash_finup(desc, zero, CMAC_TLEN, out);
+	shash->tfm = tfm;
+
+	crypto_shash_init(shash);
+	crypto_shash_update(shash, aad, AAD_LEN);
+	crypto_shash_update(shash, data, data_len - CMAC_TLEN);
+	crypto_shash_finup(shash, zero, CMAC_TLEN, out);
 
 	memcpy(mic, out, CMAC_TLEN);
+	kfree(shash);
 }
 
 void ieee80211_aes_cmac_256(struct crypto_shash *tfm, const u8 *aad,
 			    const u8 *data, size_t data_len, u8 *mic)
 {
-	SHASH_DESC_ON_STACK(desc, tfm);
+	struct shash_desc *shash;
+
+	shash = kmalloc(sizeof(*shash) + crypto_shash_descsize(tfm),
+			GFP_KERNEL);
+	if (!shash)
+		return;
 
-	desc->tfm = tfm;
+	shash->tfm = tfm;
 
-	crypto_shash_init(desc);
-	crypto_shash_update(desc, aad, AAD_LEN);
-	crypto_shash_update(desc, data, data_len - CMAC_TLEN_256);
-	crypto_shash_finup(desc, zero, CMAC_TLEN_256, mic);
+	crypto_shash_init(shash);
+	crypto_shash_update(shash, aad, AAD_LEN);
+	crypto_shash_update(shash, data, data_len - CMAC_TLEN_256);
+	crypto_shash_finup(shash, zero, CMAC_TLEN_256, mic);
+	kfree(shash);
 }
 
 struct crypto_shash *ieee80211_aes_cmac_key_setup(const u8 key[],
-- 
2.7.4
