Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87A98C6786F
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 15:40:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F19A2081F
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 15:40:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F19A2081F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728073AbeKCAre (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 20:47:34 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:38847 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727576AbeKCArd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 20:47:33 -0400
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue106 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MCb2L-1gSBuw3auR-009eu7; Fri, 02 Nov 2018 16:39:33 +0100
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue106 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MCb2L-1gSBuw3auR-009eu7; Fri, 02 Nov 2018 16:39:33 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Richard Weinberger <richard@nod.at>,
        Artem Bityutskiy <dedekind1@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ubifs: replay: fix high stack usage
Date:   Fri,  2 Nov 2018 16:39:24 +0100
Message-Id: <20181102153932.1750967-1-arnd@arndb.de>
X-Mailer: git-send-email 2.18.0
X-Provags-ID: V03:K1:Gy7xVXvuiokBNjKUv/MCIilGtPZe6keHML0M6mEtEiu3doG0h8G
 QkA2VJLyhjwvQMI24kK/+27IpGcZ7AbC+BaC1ZkFAGA8+OTuoknkoST1OKzDr6/yCgZ++eB
 uAPpjWxdWbsyjDcMzn9yFwfor8mNZd/k0ei//Rph0iPvNrWPrkNkDbfSwQCNYuSdKpQs161
 RwfLMuJapu6qoMXN6c7uw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:TO3gOLLOteQ=:cUiqOXhbF1IEQBMYsv7rnX
 mXsjk5MqT8ENpZCJ8QdgAHJIHrMF/xyQyVCECzoNyt64qJApoy4CJB786yxxTV9e+nYkHPSTd
 /eC0ZfO3EpzpSGMEFKN8chRbZW2l28wgNDfZOdnHW8Ty+1axTKNrDW8DW56S13dWVVwnojXrC
 KN7Eq4YpL6m4byd5K8ut7OPx81QlxIotTvvaFm/7iuW3v40j50NUmNJbatRF0NorqPOKz050v
 v84yh0xAHz8ua9uDBQEA1/d+vqd7mtbmguoDG8DDPqaG8V1XfBNPbBuJDA0RfgxbcJCeiJNAi
 Vlp1+p/8/cS0d409T/BV1kdiaPaIZQ1pP3T8vUDXeSwtRWJn6Ed0N1BcpTJ27mklRpw65BBnt
 JXfGDTfFSyzYMBJWKxbiC/URaIAGxujZFpTNTmRzWQNlfiJqErUme/GKU4+RO4uwTzCyek0QV
 PNvBP3lr8VONYw9RwDgypnn5YTla9H+vsiPEoJThrZee8l3txZ4le+MGCrbRjOXgOjqVWw1sp
 PukRYq/xuJckr/e7LHhSr3WU0oZx7MQW2bgpeDufX9M0FeQRhHoY+7ignKCK2hwiUxmgkXFuz
 ESE3mEb/NxLToKjy+u9DmyfqCCML+dgbQEY+pIpRTjcMbA1MXNQEdKeYJpslF4maRIAZoJ2xl
 7eC+56XNWOFSGcwvE98haB0I4393C1p0LXnlwFk2sPyTT9Al2c/JHQw+BZb48TK4f+4U=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Having two shash descriptors on the stack cause a very significant kernel
stack usage that can cross the warning threshold:

fs/ubifs/replay.c: In function 'authenticate_sleb':
fs/ubifs/replay.c:633:1: error: the frame size of 1144 bytes is larger than 1024 bytes [-Werror=frame-larger-than=]

Normally, gcc optimizes the out, but with CONFIG_CC_OPTIMIZE_FOR_DEBUGGING,
it does not. Splitting the two stack allocations into separate functions
means that they will use the same memory again. In normal configurations
(optimizing for size or performance), those should get inlined and we get
the same behavior as before.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 fs/ubifs/replay.c | 35 ++++++++++++++++++++++++-----------
 1 file changed, 24 insertions(+), 11 deletions(-)

diff --git a/fs/ubifs/replay.c b/fs/ubifs/replay.c
index 75f961c4c044..a08c5b7030ea 100644
--- a/fs/ubifs/replay.c
+++ b/fs/ubifs/replay.c
@@ -533,6 +533,28 @@ static int is_last_bud(struct ubifs_info *c, struct ubifs_bud *bud)
 	return data == 0xFFFFFFFF;
 }
 
+/* authenticate_sleb_hash and authenticate_sleb_hmac are split out for stack usage */
+static int authenticate_sleb_hash(struct ubifs_info *c, struct shash_desc *log_hash, u8 *hash)
+{
+	SHASH_DESC_ON_STACK(hash_desc, c->hash_tfm);
+
+	hash_desc->tfm = c->hash_tfm;
+	hash_desc->flags = CRYPTO_TFM_REQ_MAY_SLEEP;
+
+	ubifs_shash_copy_state(c, log_hash, hash_desc);
+	return crypto_shash_final(hash_desc, hash);
+}
+
+static int authenticate_sleb_hmac(struct ubifs_info *c, u8 *hash, u8 *hmac)
+{
+	SHASH_DESC_ON_STACK(hmac_desc, c->hmac_tfm);
+
+	hmac_desc->tfm = c->hmac_tfm;
+	hmac_desc->flags = CRYPTO_TFM_REQ_MAY_SLEEP;
+
+	return crypto_shash_digest(hmac_desc, hash, c->hash_len, hmac);
+}
+
 /**
  * authenticate_sleb - authenticate one scan LEB
  * @c: UBIFS file-system description object
@@ -574,21 +596,12 @@ static int authenticate_sleb(struct ubifs_info *c, struct ubifs_scan_leb *sleb,
 
 		if (snod->type == UBIFS_AUTH_NODE) {
 			struct ubifs_auth_node *auth = snod->node;
-			SHASH_DESC_ON_STACK(hash_desc, c->hash_tfm);
-			SHASH_DESC_ON_STACK(hmac_desc, c->hmac_tfm);
-
-			hash_desc->tfm = c->hash_tfm;
-			hash_desc->flags = CRYPTO_TFM_REQ_MAY_SLEEP;
 
-			ubifs_shash_copy_state(c, log_hash, hash_desc);
-			err = crypto_shash_final(hash_desc, hash);
+			err = authenticate_sleb_hash(c, log_hash, hash);
 			if (err)
 				goto out;
 
-			hmac_desc->tfm = c->hmac_tfm;
-			hmac_desc->flags = CRYPTO_TFM_REQ_MAY_SLEEP;
-			err = crypto_shash_digest(hmac_desc, hash, c->hash_len,
-						  hmac);
+			err = authenticate_sleb_hmac(c, hash, hmac);
 			if (err)
 				goto out;
 
-- 
2.18.0

