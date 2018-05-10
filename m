Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966357AbeEJPrP (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 11:47:15 -0400
Received: from smtprelay0168.hostedemail.com ([216.40.44.168]:56268 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S966316AbeEJPqo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 11:46:44 -0400
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::::,RULES_HIT:2:41:69:355:379:541:800:960:966:968:973:982:988:989:1260:1345:1359:1437:1535:1730:1747:1777:1792:2196:2199:2393:2559:2562:2894:2895:3138:3139:3140:3141:3142:3352:3865:3867:3871:4050:4119:4321:4385:4419:4605:5007:6119:6261:10004:10848:11026:11473:11658:11914:12043:12296:12438:12555:12679:12683:12895:13255:14110:14394:21080:21433:21451:21627:30054:30070,0,RBL:47.151.150.235:@perches.com:.lbl8.mailshell.net-62.8.0.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:3,LUA_SUMMARY:none
X-HE-Tag: mask55_1cf91d2a5a145
X-Filterd-Recvd-Size: 8795
From: Joe Perches <joe@perches.com>
To: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: David Howells <dhowells@redhat.com>, James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>, linux-integrity@vger.kernel.org,
        keyrings@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 17/18] security: encrypted-keys: Remove pr_fmt duplicate logging prefixes
Date: Thu, 10 May 2018 08:45:43 -0700
Message-Id: <fd41a51e9258970fa0de06912884bfd673609581.1525964386.git.joe@perches.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <cover.1525964381.git.joe@perches.com>
References: <cover.1525964381.git.joe@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Converting pr_fmt from a simple define to use KBUILD_MODNAME added
some duplicate logging prefixes to existing uses.

Remove them.

Signed-off-by: Joe Perches <joe@perches.com>
---
 security/keys/encrypted-keys/encrypted.c | 63 ++++++++++++++------------------
 1 file changed, 28 insertions(+), 35 deletions(-)

diff --git a/security/keys/encrypted-keys/encrypted.c b/security/keys/encrypted-keys/encrypted.c
index d92cbf9687c3..40a14d5c6ae5 100644
--- a/security/keys/encrypted-keys/encrypted.c
+++ b/security/keys/encrypted-keys/encrypted.c
@@ -84,8 +84,7 @@ static int aes_get_sizes(void)
 
 	tfm = crypto_alloc_skcipher(blkcipher_alg, 0, CRYPTO_ALG_ASYNC);
 	if (IS_ERR(tfm)) {
-		pr_err("encrypted_key: failed to alloc_cipher (%ld)\n",
-		       PTR_ERR(tfm));
+		pr_err("failed to alloc_cipher (%ld)\n", PTR_ERR(tfm));
 		return PTR_ERR(tfm);
 	}
 	ivsize = crypto_skcipher_ivsize(tfm);
@@ -106,15 +105,14 @@ static int valid_ecryptfs_desc(const char *ecryptfs_desc)
 	int i;
 
 	if (strlen(ecryptfs_desc) != KEY_ECRYPTFS_DESC_LEN) {
-		pr_err("encrypted_key: key description must be %d hexadecimal "
-		       "characters long\n", KEY_ECRYPTFS_DESC_LEN);
+		pr_err("key description must be %d hexadecimal characters long\n",
+		       KEY_ECRYPTFS_DESC_LEN);
 		return -EINVAL;
 	}
 
 	for (i = 0; i < KEY_ECRYPTFS_DESC_LEN; i++) {
 		if (!isxdigit(ecryptfs_desc[i])) {
-			pr_err("encrypted_key: key description must contain "
-			       "only hexadecimal characters\n");
+			pr_err("key description must contain only hexadecimal characters\n");
 			return -EINVAL;
 		}
 	}
@@ -180,7 +178,7 @@ static int datablob_parse(char *datablob, const char **format,
 
 	keyword = strsep(&datablob, " \t");
 	if (!keyword) {
-		pr_info("encrypted_key: insufficient parameters specified\n");
+		pr_info("insufficient parameters specified\n");
 		return ret;
 	}
 	key_cmd = match_token(keyword, key_tokens, args);
@@ -188,7 +186,7 @@ static int datablob_parse(char *datablob, const char **format,
 	/* Get optional format: default | ecryptfs */
 	p = strsep(&datablob, " \t");
 	if (!p) {
-		pr_err("encrypted_key: insufficient parameters specified\n");
+		pr_err("insufficient parameters specified\n");
 		return ret;
 	}
 
@@ -205,20 +203,20 @@ static int datablob_parse(char *datablob, const char **format,
 	}
 
 	if (!*master_desc) {
-		pr_info("encrypted_key: master key parameter is missing\n");
+		pr_info("master key parameter is missing\n");
 		goto out;
 	}
 
 	if (valid_master_desc(*master_desc, NULL) < 0) {
-		pr_info("encrypted_key: master key parameter \'%s\' "
-			"is invalid\n", *master_desc);
+		pr_info("master key parameter \'%s\' is invalid\n",
+			*master_desc);
 		goto out;
 	}
 
 	if (decrypted_datalen) {
 		*decrypted_datalen = strsep(&datablob, " \t");
 		if (!*decrypted_datalen) {
-			pr_info("encrypted_key: keylen parameter is missing\n");
+			pr_info("keylen parameter is missing\n");
 			goto out;
 		}
 	}
@@ -226,37 +224,35 @@ static int datablob_parse(char *datablob, const char **format,
 	switch (key_cmd) {
 	case Opt_new:
 		if (!decrypted_datalen) {
-			pr_info("encrypted_key: keyword \'%s\' not allowed "
-				"when called from .update method\n", keyword);
+			pr_info("keyword \'%s\' not allowed when called from .update method\n",
+				keyword);
 			break;
 		}
 		ret = 0;
 		break;
 	case Opt_load:
 		if (!decrypted_datalen) {
-			pr_info("encrypted_key: keyword \'%s\' not allowed "
-				"when called from .update method\n", keyword);
+			pr_info("keyword \'%s\' not allowed when called from .update method\n",
+				keyword);
 			break;
 		}
 		*hex_encoded_iv = strsep(&datablob, " \t");
 		if (!*hex_encoded_iv) {
-			pr_info("encrypted_key: hex blob is missing\n");
+			pr_info("hex blob is missing\n");
 			break;
 		}
 		ret = 0;
 		break;
 	case Opt_update:
 		if (decrypted_datalen) {
-			pr_info("encrypted_key: keyword \'%s\' not allowed "
-				"when called from .instantiate method\n",
+			pr_info("keyword \'%s\' not allowed when called from .instantiate method\n",
 				keyword);
 			break;
 		}
 		ret = 0;
 		break;
 	case Opt_err:
-		pr_info("encrypted_key: keyword \'%s\' not recognized\n",
-			keyword);
+		pr_info("keyword \'%s\' not recognized\n", keyword);
 		break;
 	}
 out:
@@ -344,7 +340,7 @@ static int calc_hmac(u8 *digest, const u8 *key, unsigned int keylen,
 
 	tfm = crypto_alloc_shash(hmac_alg, 0, CRYPTO_ALG_ASYNC);
 	if (IS_ERR(tfm)) {
-		pr_err("encrypted_key: can't alloc %s transform: %ld\n",
+		pr_err("can't alloc %s transform: %ld\n",
 		       hmac_alg, PTR_ERR(tfm));
 		return PTR_ERR(tfm);
 	}
@@ -395,22 +391,21 @@ static struct skcipher_request *init_skcipher_req(const u8 *key,
 
 	tfm = crypto_alloc_skcipher(blkcipher_alg, 0, CRYPTO_ALG_ASYNC);
 	if (IS_ERR(tfm)) {
-		pr_err("encrypted_key: failed to load %s transform (%ld)\n",
+		pr_err("failed to load %s transform (%ld)\n",
 		       blkcipher_alg, PTR_ERR(tfm));
 		return ERR_CAST(tfm);
 	}
 
 	ret = crypto_skcipher_setkey(tfm, key, key_len);
 	if (ret < 0) {
-		pr_err("encrypted_key: failed to setkey (%d)\n", ret);
+		pr_err("failed to setkey (%d)\n", ret);
 		crypto_free_skcipher(tfm);
 		return ERR_PTR(ret);
 	}
 
 	req = skcipher_request_alloc(tfm, GFP_KERNEL);
 	if (!req) {
-		pr_err("encrypted_key: failed to allocate request for %s\n",
-		       blkcipher_alg);
+		pr_err("failed to allocate request for %s\n", blkcipher_alg);
 		crypto_free_skcipher(tfm);
 		return ERR_PTR(-ENOMEM);
 	}
@@ -441,11 +436,10 @@ static struct key *request_master_key(struct encrypted_key_payload *epayload,
 		int ret = PTR_ERR(mkey);
 
 		if (ret == -ENOTSUPP)
-			pr_info("encrypted_key: key %s not supported",
+			pr_info("key %s not supported\n",
 				epayload->master_desc);
 		else
-			pr_info("encrypted_key: key %s not found",
-				epayload->master_desc);
+			pr_info("key %s not found\n", epayload->master_desc);
 		goto out;
 	}
 
@@ -490,7 +484,7 @@ static int derived_key_encrypt(struct encrypted_key_payload *epayload,
 	skcipher_request_free(req);
 	crypto_free_skcipher(tfm);
 	if (ret < 0)
-		pr_err("encrypted_key: failed to encrypt (%d)\n", ret);
+		pr_err("failed to encrypt (%d)\n", ret);
 	else
 		dump_encrypted_data(epayload, encrypted_datalen);
 out:
@@ -627,8 +621,7 @@ static struct encrypted_key_payload *encrypted_key_alloc(struct key *key,
 	payload_datalen = decrypted_datalen;
 	if (format && !strcmp(format, key_format_ecryptfs)) {
 		if (dlen != ECRYPTFS_MAX_KEY_BYTES) {
-			pr_err("encrypted_key: keylen for the ecryptfs format "
-			       "must be equal to %d bytes\n",
+			pr_err("keylen for the ecryptfs format must be equal to %d bytes\n",
 			       ECRYPTFS_MAX_KEY_BYTES);
 			return ERR_PTR(-EINVAL);
 		}
@@ -696,7 +689,7 @@ static int encrypted_key_decrypt(struct encrypted_key_payload *epayload,
 
 	ret = datablob_hmac_verify(epayload, format, master_key, master_keylen);
 	if (ret < 0) {
-		pr_err("encrypted_key: bad hmac (%d)\n", ret);
+		pr_err("bad hmac (%d)\n", ret);
 		goto out;
 	}
 
@@ -706,7 +699,7 @@ static int encrypted_key_decrypt(struct encrypted_key_payload *epayload,
 
 	ret = derived_key_decrypt(epayload, derived_key, sizeof derived_key);
 	if (ret < 0)
-		pr_err("encrypted_key: failed to decrypt key (%d)\n", ret);
+		pr_err("failed to decrypt key (%d)\n", ret);
 out:
 	up_read(&mkey->sem);
 	key_put(mkey);
@@ -986,7 +979,7 @@ static int __init init_encrypted(void)
 
 	hash_tfm = crypto_alloc_shash(hash_alg, 0, CRYPTO_ALG_ASYNC);
 	if (IS_ERR(hash_tfm)) {
-		pr_err("encrypted_key: can't allocate %s transform: %ld\n",
+		pr_err("can't allocate %s transform: %ld\n",
 		       hash_alg, PTR_ERR(hash_tfm));
 		return PTR_ERR(hash_tfm);
 	}
-- 
2.15.0
