Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEBFBC282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 10:17:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B2DD2086C
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 10:17:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729612AbfBAKRW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 05:17:22 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:32854 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726116AbfBAKRV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 05:17:21 -0500
Received: from lhreml709-cah.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id 2B6C2D340E138F36CE91;
        Fri,  1 Feb 2019 10:17:20 +0000 (GMT)
Received: from roberto-HP-EliteDesk-800-G2-DM-65W.huawei.com (10.204.65.141)
 by smtpsuk.huawei.com (10.201.108.32) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Fri, 1 Feb 2019 10:17:13 +0000
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     <jarkko.sakkinen@linux.intel.com>, <zohar@linux.ibm.com>,
        <david.safford@ge.com>, <monty.wiseman@ge.com>,
        <matthewgarrett@google.com>
CC:     <linux-integrity@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <keyrings@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <silviu.vlasceanu@huawei.com>,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH v9 5/6] KEYS: trusted: explicitly use tpm_chip structure from tpm_default_chip()
Date:   Fri, 1 Feb 2019 11:06:40 +0100
Message-ID: <20190201100641.26936-6-roberto.sassu@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190201100641.26936-1-roberto.sassu@huawei.com>
References: <20190201100641.26936-1-roberto.sassu@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.204.65.141]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When crypto agility support will be added to the TPM driver, users of the
driver have to retrieve the allocated banks from chip->allocated_banks and
use this information to prepare the array of tpm_digest structures to be
passed to tpm_pcr_extend().

This patch retrieves a tpm_chip pointer from tpm_default_chip() so that the
pointer can be used to prepare the array of tpm_digest structures.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 security/keys/trusted.c | 38 ++++++++++++++++++++++++--------------
 1 file changed, 24 insertions(+), 14 deletions(-)

diff --git a/security/keys/trusted.c b/security/keys/trusted.c
index 4d98f4f87236..5b852263eae1 100644
--- a/security/keys/trusted.c
+++ b/security/keys/trusted.c
@@ -34,6 +34,7 @@
 
 static const char hmac_alg[] = "hmac(sha1)";
 static const char hash_alg[] = "sha1";
+static struct tpm_chip *chip;
 
 struct sdesc {
 	struct shash_desc shash;
@@ -362,7 +363,7 @@ int trusted_tpm_send(unsigned char *cmd, size_t buflen)
 	int rc;
 
 	dump_tpm_buf(cmd);
-	rc = tpm_send(NULL, cmd, buflen);
+	rc = tpm_send(chip, cmd, buflen);
 	dump_tpm_buf(cmd);
 	if (rc > 0)
 		/* Can't return positive return codes values to keyctl */
@@ -384,10 +385,10 @@ static int pcrlock(const int pcrnum)
 
 	if (!capable(CAP_SYS_ADMIN))
 		return -EPERM;
-	ret = tpm_get_random(NULL, hash, SHA1_DIGEST_SIZE);
+	ret = tpm_get_random(chip, hash, SHA1_DIGEST_SIZE);
 	if (ret != SHA1_DIGEST_SIZE)
 		return ret;
-	return tpm_pcr_extend(NULL, pcrnum, hash) ? -EINVAL : 0;
+	return tpm_pcr_extend(chip, pcrnum, hash) ? -EINVAL : 0;
 }
 
 /*
@@ -400,7 +401,7 @@ static int osap(struct tpm_buf *tb, struct osapsess *s,
 	unsigned char ononce[TPM_NONCE_SIZE];
 	int ret;
 
-	ret = tpm_get_random(NULL, ononce, TPM_NONCE_SIZE);
+	ret = tpm_get_random(chip, ononce, TPM_NONCE_SIZE);
 	if (ret != TPM_NONCE_SIZE)
 		return ret;
 
@@ -496,7 +497,7 @@ static int tpm_seal(struct tpm_buf *tb, uint16_t keytype,
 	if (ret < 0)
 		goto out;
 
-	ret = tpm_get_random(NULL, td->nonceodd, TPM_NONCE_SIZE);
+	ret = tpm_get_random(chip, td->nonceodd, TPM_NONCE_SIZE);
 	if (ret != TPM_NONCE_SIZE)
 		goto out;
 	ordinal = htonl(TPM_ORD_SEAL);
@@ -606,7 +607,7 @@ static int tpm_unseal(struct tpm_buf *tb,
 
 	ordinal = htonl(TPM_ORD_UNSEAL);
 	keyhndl = htonl(SRKHANDLE);
-	ret = tpm_get_random(NULL, nonceodd, TPM_NONCE_SIZE);
+	ret = tpm_get_random(chip, nonceodd, TPM_NONCE_SIZE);
 	if (ret != TPM_NONCE_SIZE) {
 		pr_info("trusted_key: tpm_get_random failed (%d)\n", ret);
 		return ret;
@@ -751,7 +752,7 @@ static int getoptions(char *c, struct trusted_key_payload *pay,
 	int i;
 	int tpm2;
 
-	tpm2 = tpm_is_tpm2(NULL);
+	tpm2 = tpm_is_tpm2(chip);
 	if (tpm2 < 0)
 		return tpm2;
 
@@ -920,7 +921,7 @@ static struct trusted_key_options *trusted_options_alloc(void)
 	struct trusted_key_options *options;
 	int tpm2;
 
-	tpm2 = tpm_is_tpm2(NULL);
+	tpm2 = tpm_is_tpm2(chip);
 	if (tpm2 < 0)
 		return NULL;
 
@@ -970,7 +971,7 @@ static int trusted_instantiate(struct key *key,
 	size_t key_len;
 	int tpm2;
 
-	tpm2 = tpm_is_tpm2(NULL);
+	tpm2 = tpm_is_tpm2(chip);
 	if (tpm2 < 0)
 		return tpm2;
 
@@ -1011,7 +1012,7 @@ static int trusted_instantiate(struct key *key,
 	switch (key_cmd) {
 	case Opt_load:
 		if (tpm2)
-			ret = tpm_unseal_trusted(NULL, payload, options);
+			ret = tpm_unseal_trusted(chip, payload, options);
 		else
 			ret = key_unseal(payload, options);
 		dump_payload(payload);
@@ -1021,13 +1022,13 @@ static int trusted_instantiate(struct key *key,
 		break;
 	case Opt_new:
 		key_len = payload->key_len;
-		ret = tpm_get_random(NULL, payload->key, key_len);
+		ret = tpm_get_random(chip, payload->key, key_len);
 		if (ret != key_len) {
 			pr_info("trusted_key: key_create failed (%d)\n", ret);
 			goto out;
 		}
 		if (tpm2)
-			ret = tpm_seal_trusted(NULL, payload, options);
+			ret = tpm_seal_trusted(chip, payload, options);
 		else
 			ret = key_seal(payload, options);
 		if (ret < 0)
@@ -1225,17 +1226,26 @@ static int __init init_trusted(void)
 {
 	int ret;
 
+	chip = tpm_default_chip();
+	if (!chip)
+		return -ENOENT;
 	ret = trusted_shash_alloc();
 	if (ret < 0)
-		return ret;
+		goto err_put;
 	ret = register_key_type(&key_type_trusted);
 	if (ret < 0)
-		trusted_shash_release();
+		goto err_release;
+	return 0;
+err_release:
+	trusted_shash_release();
+err_put:
+	put_device(&chip->dev);
 	return ret;
 }
 
 static void __exit cleanup_trusted(void)
 {
+	put_device(&chip->dev);
 	trusted_shash_release();
 	unregister_key_type(&key_type_trusted);
 }
-- 
2.17.1

