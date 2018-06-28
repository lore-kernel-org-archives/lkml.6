Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 049A3C43142
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 07:33:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6967244E6
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 07:33:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6967244E6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=benyossef.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964936AbeF1Hdr (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 03:33:47 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:42222 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934133AbeF1HdF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 03:33:05 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4F25F18A;
        Thu, 28 Jun 2018 00:33:05 -0700 (PDT)
Received: from sugar.kfn.arm.com (unknown [10.45.48.147])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A0EF63F5C0;
        Thu, 28 Jun 2018 00:33:03 -0700 (PDT)
From:   Gilad Ben-Yossef <gilad@benyossef.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
Cc:     Ofir Drang <ofir.drang@arm.com>, Hadar Gat <hadar.gat@arm.com>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] crypto: testmgr: add hash finup tests
Date:   Thu, 28 Jun 2018 08:32:52 +0100
Message-Id: <1530171175-31960-3-git-send-email-gilad@benyossef.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1530171175-31960-1-git-send-email-gilad@benyossef.com>
References: <1530171175-31960-1-git-send-email-gilad@benyossef.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The testmgr hash tests were testing init, digest, update and final
methods but not the finup method. Add a test for this one too.

While doing this, make sure we only run the partial tests once with
the digest tests and skip them with the final and finup tests since
they are the same.

Signed-off-by: Gilad Ben-Yossef <gilad@benyossef.com>
---
 crypto/testmgr.c | 55 ++++++++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 46 insertions(+), 9 deletions(-)

diff --git a/crypto/testmgr.c b/crypto/testmgr.c
index 11e4535..ca475f6 100644
--- a/crypto/testmgr.c
+++ b/crypto/testmgr.c
@@ -259,9 +259,15 @@ static int ahash_partial_update(struct ahash_request **preq,
 	return ret;
 }
 
+enum hash_test {
+	HASH_TEST_DIGEST,
+	HASH_TEST_FINAL,
+	HASH_TEST_FINUP
+};
+
 static int __test_hash(struct crypto_ahash *tfm,
 		       const struct hash_testvec *template, unsigned int tcount,
-		       bool use_digest, const int align_offset)
+		       enum hash_test test_type, const int align_offset)
 {
 	const char *algo = crypto_tfm_alg_driver_name(crypto_ahash_tfm(tfm));
 	size_t digest_size = crypto_ahash_digestsize(tfm);
@@ -332,14 +338,17 @@ static int __test_hash(struct crypto_ahash *tfm,
 		}
 
 		ahash_request_set_crypt(req, sg, result, template[i].psize);
-		if (use_digest) {
+		switch (test_type) {
+		case HASH_TEST_DIGEST:
 			ret = crypto_wait_req(crypto_ahash_digest(req), &wait);
 			if (ret) {
 				pr_err("alg: hash: digest failed on test %d "
 				       "for %s: ret=%d\n", j, algo, -ret);
 				goto out;
 			}
-		} else {
+			break;
+
+		case HASH_TEST_FINAL:
 			memset(result, 1, digest_size);
 			ret = crypto_wait_req(crypto_ahash_init(req), &wait);
 			if (ret) {
@@ -371,6 +380,29 @@ static int __test_hash(struct crypto_ahash *tfm,
 				       "for %s: ret=%d\n", j, algo, -ret);
 				goto out;
 			}
+			break;
+
+		case HASH_TEST_FINUP:
+			memset(result, 1, digest_size);
+			ret = crypto_wait_req(crypto_ahash_init(req), &wait);
+			if (ret) {
+				pr_err("alg: hash: init failed on test %d "
+				       "for %s: ret=%d\n", j, algo, -ret);
+				goto out;
+			}
+			ret = ahash_guard_result(result, 1, digest_size);
+			if (ret) {
+				pr_err("alg: hash: init failed on test %d "
+				       "for %s: used req->result\n", j, algo);
+				goto out;
+			}
+			ret = crypto_wait_req(crypto_ahash_finup(req), &wait);
+			if (ret) {
+				pr_err("alg: hash: final failed on test %d "
+				       "for %s: ret=%d\n", j, algo, -ret);
+				goto out;
+			}
+			break;
 		}
 
 		if (memcmp(result, template[i].digest,
@@ -383,6 +415,9 @@ static int __test_hash(struct crypto_ahash *tfm,
 		}
 	}
 
+	if (test_type)
+		goto out;
+
 	j = 0;
 	for (i = 0; i < tcount; i++) {
 		/* alignment tests are only done with continuous buffers */
@@ -540,24 +575,24 @@ static int __test_hash(struct crypto_ahash *tfm,
 
 static int test_hash(struct crypto_ahash *tfm,
 		     const struct hash_testvec *template,
-		     unsigned int tcount, bool use_digest)
+		     unsigned int tcount, enum hash_test test_type)
 {
 	unsigned int alignmask;
 	int ret;
 
-	ret = __test_hash(tfm, template, tcount, use_digest, 0);
+	ret = __test_hash(tfm, template, tcount, test_type, 0);
 	if (ret)
 		return ret;
 
 	/* test unaligned buffers, check with one byte offset */
-	ret = __test_hash(tfm, template, tcount, use_digest, 1);
+	ret = __test_hash(tfm, template, tcount, test_type, 1);
 	if (ret)
 		return ret;
 
 	alignmask = crypto_tfm_alg_alignmask(&tfm->base);
 	if (alignmask) {
 		/* Check if alignment mask for tfm is correctly set. */
-		ret = __test_hash(tfm, template, tcount, use_digest,
+		ret = __test_hash(tfm, template, tcount, test_type,
 				  alignmask + 1);
 		if (ret)
 			return ret;
@@ -1803,9 +1838,11 @@ static int __alg_test_hash(const struct hash_testvec *template,
 		return PTR_ERR(tfm);
 	}
 
-	err = test_hash(tfm, template, tcount, true);
+	err = test_hash(tfm, template, tcount, HASH_TEST_DIGEST);
+	if (!err)
+		err = test_hash(tfm, template, tcount, HASH_TEST_FINAL);
 	if (!err)
-		err = test_hash(tfm, template, tcount, false);
+		err = test_hash(tfm, template, tcount, HASH_TEST_FINUP);
 	crypto_free_ahash(tfm);
 	return err;
 }
-- 
2.7.4

