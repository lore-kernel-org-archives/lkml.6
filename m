Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F9CEECE566
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 13:19:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D1E42152A
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 13:19:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D1E42152A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=benyossef.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732695AbeITTCs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 15:02:48 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:45846 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732555AbeITTCs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 15:02:48 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A976B1596;
        Thu, 20 Sep 2018 06:19:18 -0700 (PDT)
Received: from sugar.kfn.arm.com (E110176.Emea.Arm.com [10.50.4.176])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3E04E3F5BD;
        Thu, 20 Sep 2018 06:19:17 -0700 (PDT)
From:   Gilad Ben-Yossef <gilad@benyossef.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
Cc:     ofir.drang@arm.com, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] crypto: testmgr: update sm4 test vectors
Date:   Thu, 20 Sep 2018 14:18:38 +0100
Message-Id: <1537449521-16182-2-git-send-email-gilad@benyossef.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1537449521-16182-1-git-send-email-gilad@benyossef.com>
References: <1537449521-16182-1-git-send-email-gilad@benyossef.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add additional test vectors from "The SM4 Blockcipher Algorithm And Its
Modes Of Operations" draft-ribose-cfrg-sm4-10 and register cipher speed
tests for sm4.

Signed-off-by: Gilad Ben-Yossef <gilad@benyossef.com>
---
 crypto/tcrypt.c  |  16 ++++++++
 crypto/tcrypt.h  |   1 +
 crypto/testmgr.c |  12 ++++++
 crypto/testmgr.h | 122 +++++++++++++++++++++++++++++++++++++++++++++++++++----
 4 files changed, 144 insertions(+), 7 deletions(-)

diff --git a/crypto/tcrypt.c b/crypto/tcrypt.c
index bdde95e..e56c3e1 100644
--- a/crypto/tcrypt.c
+++ b/crypto/tcrypt.c
@@ -2033,6 +2033,8 @@ static int do_test(const char *alg, u32 type, u32 mask, int m, u32 num_mb)
 		break;
 	case 191:
 		ret += tcrypt_test("ecb(sm4)");
+		ret += tcrypt_test("cbc(sm4)");
+		ret += tcrypt_test("ctr(sm4)");
 		break;
 	case 200:
 		test_cipher_speed("ecb(aes)", ENCRYPT, sec, NULL, 0,
@@ -2282,6 +2284,20 @@ static int do_test(const char *alg, u32 type, u32 mask, int m, u32 num_mb)
 				   num_mb);
 		break;
 
+	case 218:
+		test_cipher_speed("ecb(sm4)", ENCRYPT, sec, NULL, 0,
+				speed_template_16);
+		test_cipher_speed("ecb(sm4)", DECRYPT, sec, NULL, 0,
+				speed_template_16);
+		test_cipher_speed("cbc(sm4)", ENCRYPT, sec, NULL, 0,
+				speed_template_16);
+		test_cipher_speed("cbc(sm4)", DECRYPT, sec, NULL, 0,
+				speed_template_16);
+		test_cipher_speed("ctr(sm4)", ENCRYPT, sec, NULL, 0,
+				speed_template_16);
+		test_cipher_speed("ctr(sm4)", DECRYPT, sec, NULL, 0,
+				speed_template_16);
+		break;
 	case 300:
 		if (alg) {
 			test_hash_speed(alg, sec, generic_hash_speed_template);
diff --git a/crypto/tcrypt.h b/crypto/tcrypt.h
index f0bfee1..d09ea8b 100644
--- a/crypto/tcrypt.h
+++ b/crypto/tcrypt.h
@@ -51,6 +51,7 @@ static struct cipher_speed_template des3_speed_template[] = {
  * Cipher speed tests
  */
 static u8 speed_template_8[] = {8, 0};
+static u8 speed_template_16[] = {16, 0};
 static u8 speed_template_24[] = {24, 0};
 static u8 speed_template_8_16[] = {8, 16, 0};
 static u8 speed_template_8_32[] = {8, 32, 0};
diff --git a/crypto/testmgr.c b/crypto/testmgr.c
index 1c9bf38..bd13bc9 100644
--- a/crypto/testmgr.c
+++ b/crypto/testmgr.c
@@ -2662,6 +2662,12 @@ static const struct alg_test_desc alg_test_descs[] = {
 			.cipher = __VECS(serpent_cbc_tv_template)
 		},
 	}, {
+		.alg = "cbc(sm4)",
+		.test = alg_test_skcipher,
+		.suite = {
+			.cipher = __VECS(sm4_cbc_tv_template)
+		}
+	}, {
 		.alg = "cbc(twofish)",
 		.test = alg_test_skcipher,
 		.suite = {
@@ -2785,6 +2791,12 @@ static const struct alg_test_desc alg_test_descs[] = {
 			.cipher = __VECS(serpent_ctr_tv_template)
 		}
 	}, {
+		.alg = "ctr(sm4)",
+		.test = alg_test_skcipher,
+		.suite = {
+			.cipher = __VECS(sm4_ctr_tv_template)
+		}
+	}, {
 		.alg = "ctr(twofish)",
 		.test = alg_test_skcipher,
 		.suite = {
diff --git a/crypto/testmgr.h b/crypto/testmgr.h
index 0b3d7ca..b091b2e 100644
--- a/crypto/testmgr.h
+++ b/crypto/testmgr.h
@@ -10133,12 +10133,13 @@ static const struct cipher_testvec serpent_xts_tv_template[] = {
 };
 
 /*
- * SM4 test vector taken from the draft RFC
- * https://tools.ietf.org/html/draft-crypto-sm4-00#ref-GBT.32907-2016
+ * SM4 test vectors taken from the "The SM4 Blockcipher Algorithm And Its
+ * Modes Of Operations" draft RFC
+ * https://datatracker.ietf.org/doc/draft-ribose-cfrg-sm4
  */
 
 static const struct cipher_testvec sm4_tv_template[] = {
-	{ /* SM4 Appendix A: Example Calculations. Example 1. */
+	{ /* GB/T 32907-2016 Example 1. */
 		.key	= "\x01\x23\x45\x67\x89\xAB\xCD\xEF"
 			  "\xFE\xDC\xBA\x98\x76\x54\x32\x10",
 		.klen	= 16,
@@ -10147,10 +10148,7 @@ static const struct cipher_testvec sm4_tv_template[] = {
 		.ctext	= "\x68\x1E\xDF\x34\xD2\x06\x96\x5E"
 			  "\x86\xB3\xE9\x4F\x53\x6E\x42\x46",
 		.len	= 16,
-	}, { /*
-	      *  SM4 Appendix A: Example Calculations.
-	      *  Last 10 iterations of Example 2.
-	      */
+	}, { /* Last 10 iterations of GB/T 32907-2016 Example 2. */
 		.key    = "\x01\x23\x45\x67\x89\xAB\xCD\xEF"
 			  "\xFE\xDC\xBA\x98\x76\x54\x32\x10",
 		.klen	= 16,
@@ -10195,6 +10193,116 @@ static const struct cipher_testvec sm4_tv_template[] = {
 			  "\x59\x52\x98\xc7\xc6\xfd\x27\x1f"
 			  "\x4\x2\xf8\x4\xc3\x3d\x3f\x66",
 		.len	= 160
+	}, { /* A.2.1.1 SM4-ECB Example 1 */
+		.key	= "\x01\x23\x45\x67\x89\xAB\xCD\xEF"
+			  "\xFE\xDC\xBA\x98\x76\x54\x32\x10",
+		.klen	= 16,
+		.ptext	= "\xaa\xaa\xaa\xaa\xbb\xbb\xbb\xbb"
+			  "\xcc\xcc\xcc\xcc\xdd\xdd\xdd\xdd"
+			  "\xee\xee\xee\xee\xff\xff\xff\xff"
+			  "\xaa\xaa\xaa\xaa\xbb\xbb\xbb\xbb",
+		.ctext	= "\x5e\xc8\x14\x3d\xe5\x09\xcf\xf7"
+			  "\xb5\x17\x9f\x8f\x47\x4b\x86\x19"
+			  "\x2f\x1d\x30\x5a\x7f\xb1\x7d\xf9"
+			  "\x85\xf8\x1c\x84\x82\x19\x23\x04",
+		.len	= 32,
+	}, { /* A.2.1.2 SM4-ECB Example 2 */
+		.key	= "\xFE\xDC\xBA\x98\x76\x54\x32\x10"
+			  "\x01\x23\x45\x67\x89\xAB\xCD\xEF",
+		.klen	= 16,
+		.ptext	= "\xaa\xaa\xaa\xaa\xbb\xbb\xbb\xbb"
+			  "\xcc\xcc\xcc\xcc\xdd\xdd\xdd\xdd"
+			  "\xee\xee\xee\xee\xff\xff\xff\xff"
+			  "\xaa\xaa\xaa\xaa\xbb\xbb\xbb\xbb",
+		.ctext	= "\xC5\x87\x68\x97\xE4\xA5\x9B\xBB"
+			  "\xA7\x2A\x10\xC8\x38\x72\x24\x5B"
+			  "\x12\xDD\x90\xBC\x2D\x20\x06\x92"
+			  "\xB5\x29\xA4\x15\x5A\xC9\xE6\x00",
+		.len	= 32,
+	}
+};
+
+static const struct cipher_testvec sm4_cbc_tv_template[] = {
+	{ /* A.2.2.1 SM4-CBC Example 1 */
+		.key	= "\x01\x23\x45\x67\x89\xAB\xCD\xEF"
+			  "\xFE\xDC\xBA\x98\x76\x54\x32\x10",
+		.klen	= 16,
+		.ptext	= "\xaa\xaa\xaa\xaa\xbb\xbb\xbb\xbb"
+			  "\xcc\xcc\xcc\xcc\xdd\xdd\xdd\xdd"
+			  "\xee\xee\xee\xee\xff\xff\xff\xff"
+			  "\xaa\xaa\xaa\xaa\xbb\xbb\xbb\xbb",
+		.iv	= "\x00\x01\x02\x03\x04\x05\x06\x07"
+			  "\x08\x09\x0A\x0B\x0C\x0D\x0E\x0F",
+		.ctext	= "\x78\xEB\xB1\x1C\xC4\x0B\x0A\x48"
+			  "\x31\x2A\xAE\xB2\x04\x02\x44\xCB"
+			  "\x4C\xB7\x01\x69\x51\x90\x92\x26"
+			  "\x97\x9B\x0D\x15\xDC\x6A\x8F\x6D",
+		.len	= 32,
+	}, { /* A.2.2.2 SM4-CBC Example 2 */
+		.key	= "\xFE\xDC\xBA\x98\x76\x54\x32\x10"
+			  "\x01\x23\x45\x67\x89\xAB\xCD\xEF",
+		.klen	= 16,
+		.ptext	= "\xaa\xaa\xaa\xaa\xbb\xbb\xbb\xbb"
+			  "\xcc\xcc\xcc\xcc\xdd\xdd\xdd\xdd"
+			  "\xee\xee\xee\xee\xff\xff\xff\xff"
+			  "\xaa\xaa\xaa\xaa\xbb\xbb\xbb\xbb",
+		.iv	= "\x00\x01\x02\x03\x04\x05\x06\x07"
+			  "\x08\x09\x0A\x0B\x0C\x0D\x0E\x0F",
+		.ctext	= "\x0d\x3a\x6d\xdc\x2d\x21\xc6\x98"
+			  "\x85\x72\x15\x58\x7b\x7b\xb5\x9a"
+			  "\x91\xf2\xc1\x47\x91\x1a\x41\x44"
+			  "\x66\x5e\x1f\xa1\xd4\x0b\xae\x38",
+		.len	= 32,
+	}
+};
+
+static const struct cipher_testvec sm4_ctr_tv_template[] = {
+	{ /* A.2.5.1 SM4-CTR Example 1 */
+		.key	= "\x01\x23\x45\x67\x89\xAB\xCD\xEF"
+			  "\xFE\xDC\xBA\x98\x76\x54\x32\x10",
+		.klen	= 16,
+		.ptext	= "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
+			  "\xbb\xbb\xbb\xbb\xbb\xbb\xbb\xbb"
+			  "\xcc\xcc\xcc\xcc\xcc\xcc\xcc\xcc"
+			  "\xdd\xdd\xdd\xdd\xdd\xdd\xdd\xdd"
+			  "\xee\xee\xee\xee\xee\xee\xee\xee"
+			  "\xff\xff\xff\xff\xff\xff\xff\xff"
+			  "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
+			  "\xbb\xbb\xbb\xbb\xbb\xbb\xbb\xbb",
+		.iv	= "\x00\x01\x02\x03\x04\x05\x06\x07"
+			  "\x08\x09\x0A\x0B\x0C\x0D\x0E\x0F",
+		.ctext	= "\xac\x32\x36\xcb\x97\x0c\xc2\x07"
+			  "\x91\x36\x4c\x39\x5a\x13\x42\xd1"
+			  "\xa3\xcb\xc1\x87\x8c\x6f\x30\xcd"
+			  "\x07\x4c\xce\x38\x5c\xdd\x70\xc7"
+			  "\xf2\x34\xbc\x0e\x24\xc1\x19\x80"
+			  "\xfd\x12\x86\x31\x0c\xe3\x7b\x92"
+			  "\x6e\x02\xfc\xd0\xfa\xa0\xba\xf3"
+			  "\x8b\x29\x33\x85\x1d\x82\x45\x14",
+		.len	= 64,
+	}, { /* A.2.5.2 SM4-CTR Example 2 */
+		.key	= "\xFE\xDC\xBA\x98\x76\x54\x32\x10"
+			  "\x01\x23\x45\x67\x89\xAB\xCD\xEF",
+		.klen	= 16,
+		.ptext	= "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
+			  "\xbb\xbb\xbb\xbb\xbb\xbb\xbb\xbb"
+			  "\xcc\xcc\xcc\xcc\xcc\xcc\xcc\xcc"
+			  "\xdd\xdd\xdd\xdd\xdd\xdd\xdd\xdd"
+			  "\xee\xee\xee\xee\xee\xee\xee\xee"
+			  "\xff\xff\xff\xff\xff\xff\xff\xff"
+			  "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
+			  "\xbb\xbb\xbb\xbb\xbb\xbb\xbb\xbb",
+		.iv	= "\x00\x01\x02\x03\x04\x05\x06\x07"
+			  "\x08\x09\x0A\x0B\x0C\x0D\x0E\x0F",
+		.ctext	= "\x5d\xcc\xcd\x25\xb9\x5a\xb0\x74"
+			  "\x17\xa0\x85\x12\xee\x16\x0e\x2f"
+			  "\x8f\x66\x15\x21\xcb\xba\xb4\x4c"
+			  "\xc8\x71\x38\x44\x5b\xc2\x9e\x5c"
+			  "\x0a\xe0\x29\x72\x05\xd6\x27\x04"
+			  "\x17\x3b\x21\x23\x9b\x88\x7f\x6c"
+			  "\x8c\xb5\xb8\x00\x91\x7a\x24\x88"
+			  "\x28\x4b\xde\x9e\x16\xea\x29\x06",
+		.len	= 64,
 	}
 };
 
-- 
2.7.4

