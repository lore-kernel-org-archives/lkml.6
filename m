Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AD02C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 10:34:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F1C4223C8
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 10:34:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F1C4223C8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729235AbeKLU0y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 15:26:54 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:32743 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727204AbeKLU0y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 15:26:54 -0500
Received: from lhreml701-cah.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id 87A75B77B6083;
        Mon, 12 Nov 2018 10:32:29 +0000 (GMT)
Received: from roberto-HP-EliteDesk-800-G2-DM-65W.huawei.com (10.204.65.153)
 by smtpsuk.huawei.com (10.201.108.42) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Mon, 12 Nov 2018 10:32:24 +0000
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     <dhowells@redhat.com>, <dwmw2@infradead.org>,
        <herbert@gondor.apana.org.au>, <davem@davemloft.net>
CC:     <keyrings@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
        <linux-integrity@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <silviu.vlasceanu@huawei.com>,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: [RFC][PATCH 09/12] verification: introduce verify_pgp_signature()
Date:   Mon, 12 Nov 2018 11:24:20 +0100
Message-ID: <20181112102423.30415-10-roberto.sassu@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181112102423.30415-1-roberto.sassu@huawei.com>
References: <20181112102423.30415-1-roberto.sassu@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.204.65.153]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce verify_pgp_signature() to to verify PGP signatures from data or
a digest. One user of this function would be IMA, that can verify the
signature of RPM headers when appraisal is enabled.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 certs/system_keyring.c       | 39 ++++++++++++++++++++++++++++++++++++
 include/linux/verification.h |  5 +++++
 2 files changed, 44 insertions(+)

diff --git a/certs/system_keyring.c b/certs/system_keyring.c
index 81728717523d..e4c59a5c7a9d 100644
--- a/certs/system_keyring.c
+++ b/certs/system_keyring.c
@@ -19,6 +19,7 @@
 #include <keys/asymmetric-type.h>
 #include <keys/system_keyring.h>
 #include <crypto/pkcs7.h>
+#include <linux/pgp_sig.h>
 
 static struct key *builtin_trusted_keys;
 #ifdef CONFIG_SECONDARY_TRUSTED_KEYRING
@@ -265,4 +266,42 @@ int verify_pkcs7_signature(const void *data, size_t len,
 }
 EXPORT_SYMBOL_GPL(verify_pkcs7_signature);
 
+/**
+ * verify_pgp_signature - Verify a PGP-based signature on system data.
+ * @data: The data to be verified (NULL if expecting internal data).
+ * @len: Size of @data.
+ * @digest: Digest for signature verification.
+ * @digest_size: Size of @digest.
+ * @raw_pgp: The PGP message that is the signature.
+ * @pgp_len: Size of @raw_pgp.
+ * @trusted_keys: Trusted keys to use (NULL for builtin trusted keys only,
+ *				       (void *)1UL for all trusted keys).
+ */
+int verify_pgp_signature(const void *data, size_t len,
+			 const void *digest, size_t digest_size,
+			 const void *raw_pgp, size_t pgp_len,
+			 struct key *trusted_keys)
+{
+	int ret = -ENOTSUPP;
+
+#ifdef CONFIG_PGP_KEY_PARSER
+	if (!trusted_keys) {
+		trusted_keys = builtin_trusted_keys;
+	} else if (trusted_keys == (void *)1UL) {
+#ifdef CONFIG_SECONDARY_TRUSTED_KEYRING
+		trusted_keys = secondary_trusted_keys;
+#else
+		trusted_keys = builtin_trusted_keys;
+#endif
+	}
+
+	ret = pgp_verify_sig(trusted_keys, data, len, digest, digest_size,
+			     raw_pgp, pgp_len);
+
+#endif /* CONFIG_PGP_KEY_PARSER */
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(verify_pgp_signature);
+
 #endif /* CONFIG_SYSTEM_DATA_VERIFICATION */
diff --git a/include/linux/verification.h b/include/linux/verification.h
index cfa4730d607a..6fd7bf60efaa 100644
--- a/include/linux/verification.h
+++ b/include/linux/verification.h
@@ -45,6 +45,11 @@ extern int verify_pkcs7_signature(const void *data, size_t len,
 						      size_t asn1hdrlen),
 				  void *ctx);
 
+extern int verify_pgp_signature(const void *data, size_t len,
+				const void *digest, size_t digest_size,
+				const void *raw_pgp, size_t pgp_len,
+				struct key *trusted_keys);
+
 #ifdef CONFIG_SIGNED_PE_FILE_VERIFICATION
 extern int verify_pefile_signature(const void *pebuf, unsigned pelen,
 				   struct key *trusted_keys,
-- 
2.17.1

