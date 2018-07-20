Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26A74ECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 06:04:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF420206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 06:04:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF420206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727388AbeGTGvE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 02:51:04 -0400
Received: from inva021.nxp.com ([92.121.34.21]:60408 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726555AbeGTGvE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 02:51:04 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 927EE200076;
        Fri, 20 Jul 2018 07:47:21 +0200 (CEST)
Received: from smtp.na-rdc02.nxp.com (inv1260.us-phx01.nxp.com [134.27.49.11])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 31042200058;
        Fri, 20 Jul 2018 07:47:21 +0200 (CEST)
Received: from az84smr01.freescale.net (az84smr01.freescale.net [10.64.34.197])
        by inv1260.na-rdc02.nxp.com (Postfix) with ESMTP id D49A440A56;
        Thu, 19 Jul 2018 22:47:20 -0700 (MST)
Received: from vinitha-OptiPlex-790.ap.freescale.net (vinitha-OptiPlex-790.ap.freescale.net [10.232.134.124])
        by az84smr01.freescale.net (8.14.3/8.14.0) with ESMTP id w6K5l5gM026022;
        Thu, 19 Jul 2018 22:47:17 -0700
From:   Udit Agarwal <udit.agarwal@nxp.com>
To:     dhowells@redhat.com, zohar@linux.vnet.ibm.com, jmorris@namei.org,
        serge@hallyn.com, linux-integrity@vger.kernel.org,
        keyrings@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     sahil.malhotra@nxp.com, Udit Agarwal <udit.agarwal@nxp.com>
Subject: [PATCH 2/2] encrypted_keys: Adds support for secure key-type as master key.
Date:   Fri, 20 Jul 2018 11:16:56 +0530
Message-Id: <20180720054656.29143-2-udit.agarwal@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180720054656.29143-1-udit.agarwal@nxp.com>
References: <20180720054656.29143-1-udit.agarwal@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Encrypted keys can use secure key-type as master key along with
trusted/user keys.

Secure key as master key uses, secure key type payload derieved
using CAAM hardware.

Signed-off-by: Udit Agarwal <udit.agarwal@nxp.com>
Reviewed-by: Sahil Malhotra <sahil.malhotra@nxp.com>
---
 MAINTAINERS                                   |  1 +
 security/keys/encrypted-keys/Makefile         |  2 +
 security/keys/encrypted-keys/encrypted.c      | 13 ++++++-
 security/keys/encrypted-keys/encrypted.h      | 13 +++++++
 .../keys/encrypted-keys/masterkey_secure.c    | 37 +++++++++++++++++++
 5 files changed, 64 insertions(+), 2 deletions(-)
 create mode 100644 security/keys/encrypted-keys/masterkey_secure.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 654be2ee4b0a..847254eec22a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7949,6 +7949,7 @@ F:	include/keys/secure-type.h
 F:	security/keys/secure_key.c
 F:	security/keys/securekey_desc.c
 F:	security/keys/securekey_desc.h
+F:	security/keys/encrypted-keys/masterkey_secure.c
 
 KEYS/KEYRINGS:
 M:	David Howells <dhowells@redhat.com>
diff --git a/security/keys/encrypted-keys/Makefile b/security/keys/encrypted-keys/Makefile
index 7a44dce6f69d..df2b906b7d24 100644
--- a/security/keys/encrypted-keys/Makefile
+++ b/security/keys/encrypted-keys/Makefile
@@ -7,5 +7,7 @@ obj-$(CONFIG_ENCRYPTED_KEYS) += encrypted-keys.o
 
 encrypted-keys-y := encrypted.o ecryptfs_format.o
 masterkey-$(CONFIG_TRUSTED_KEYS) := masterkey_trusted.o
+masterkey-$(CONFIG_SECURE_KEYS) := masterkey_secure.o
 masterkey-$(CONFIG_TRUSTED_KEYS)-$(CONFIG_ENCRYPTED_KEYS) := masterkey_trusted.o
+masterkey-$(CONFIG_SECURE_KEYS)-$(CONFIG_ENCRYPTED_KEYS) := masterkey_secure.o
 encrypted-keys-y += $(masterkey-y) $(masterkey-m-m)
diff --git a/security/keys/encrypted-keys/encrypted.c b/security/keys/encrypted-keys/encrypted.c
index d92cbf9687c3..258b38094705 100644
--- a/security/keys/encrypted-keys/encrypted.c
+++ b/security/keys/encrypted-keys/encrypted.c
@@ -39,6 +39,7 @@
 #include "ecryptfs_format.h"
 
 static const char KEY_TRUSTED_PREFIX[] = "trusted:";
+static const char KEY_SECURE_PREFIX[] = "secure:";
 static const char KEY_USER_PREFIX[] = "user:";
 static const char hash_alg[] = "sha256";
 static const char hmac_alg[] = "hmac(sha256)";
@@ -49,6 +50,7 @@ static unsigned int ivsize;
 static int blksize;
 
 #define KEY_TRUSTED_PREFIX_LEN (sizeof (KEY_TRUSTED_PREFIX) - 1)
+#define KEY_SECURE_PREFIX_LEN (sizeof(KEY_SECURE_PREFIX) - 1)
 #define KEY_USER_PREFIX_LEN (sizeof (KEY_USER_PREFIX) - 1)
 #define KEY_ECRYPTFS_DESC_LEN 16
 #define HASH_SIZE SHA256_DIGEST_SIZE
@@ -125,7 +127,7 @@ static int valid_ecryptfs_desc(const char *ecryptfs_desc)
 /*
  * valid_master_desc - verify the 'key-type:desc' of a new/updated master-key
  *
- * key-type:= "trusted:" | "user:"
+ * key-type:= "trusted:" | "user:" | "secure:"
  * desc:= master-key description
  *
  * Verify that 'key-type' is valid and that 'desc' exists. On key update,
@@ -140,6 +142,8 @@ static int valid_master_desc(const char *new_desc, const char *orig_desc)
 
 	if (!strncmp(new_desc, KEY_TRUSTED_PREFIX, KEY_TRUSTED_PREFIX_LEN))
 		prefix_len = KEY_TRUSTED_PREFIX_LEN;
+	else if (!strncmp(new_desc, KEY_SECURE_PREFIX, KEY_SECURE_PREFIX_LEN))
+		prefix_len = KEY_SECURE_PREFIX_LEN;
 	else if (!strncmp(new_desc, KEY_USER_PREFIX, KEY_USER_PREFIX_LEN))
 		prefix_len = KEY_USER_PREFIX_LEN;
 	else
@@ -358,7 +362,7 @@ static int calc_hmac(u8 *digest, const u8 *key, unsigned int keylen,
 
 enum derived_key_type { ENC_KEY, AUTH_KEY };
 
-/* Derive authentication/encryption key from trusted key */
+/* Derive authentication/encryption key from trusted/secure key */
 static int get_derived_key(u8 *derived_key, enum derived_key_type key_type,
 			   const u8 *master_key, size_t master_keylen)
 {
@@ -429,6 +433,11 @@ static struct key *request_master_key(struct encrypted_key_payload *epayload,
 		mkey = request_trusted_key(epayload->master_desc +
 					   KEY_TRUSTED_PREFIX_LEN,
 					   master_key, master_keylen);
+	} else if (!strncmp(epayload->master_desc, KEY_SECURE_PREFIX,
+			    KEY_SECURE_PREFIX_LEN)) {
+		mkey = request_secure_key(epayload->master_desc +
+					  KEY_SECURE_PREFIX_LEN,
+					  master_key, master_keylen);
 	} else if (!strncmp(epayload->master_desc, KEY_USER_PREFIX,
 			    KEY_USER_PREFIX_LEN)) {
 		mkey = request_user_key(epayload->master_desc +
diff --git a/security/keys/encrypted-keys/encrypted.h b/security/keys/encrypted-keys/encrypted.h
index 1809995db452..f1cb73611e77 100644
--- a/security/keys/encrypted-keys/encrypted.h
+++ b/security/keys/encrypted-keys/encrypted.h
@@ -16,6 +16,19 @@ static inline struct key *request_trusted_key(const char *trusted_desc,
 }
 #endif
 
+#if defined(CONFIG_SECURE_KEYS)
+extern struct key *request_secure_key(const char *secure_desc,
+				      const u8 **master_key,
+				      size_t *master_keylen);
+#else
+static inline struct key *request_secure_key(const char *secure_desc,
+					     const u8 **master_key,
+					     size_t *master_keylen)
+{
+	return ERR_PTR(-EOPNOTSUPP);
+}
+#endif
+
 #if ENCRYPTED_DEBUG
 static inline void dump_master_key(const u8 *master_key, size_t master_keylen)
 {
diff --git a/security/keys/encrypted-keys/masterkey_secure.c b/security/keys/encrypted-keys/masterkey_secure.c
new file mode 100644
index 000000000000..87068c966111
--- /dev/null
+++ b/security/keys/encrypted-keys/masterkey_secure.c
@@ -0,0 +1,37 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2018 NXP.
+ *
+ */
+
+#include <linux/uaccess.h>
+#include <linux/module.h>
+#include <linux/err.h>
+#include <keys/secure-type.h>
+#include <keys/encrypted-type.h>
+#include "encrypted.h"
+
+/*
+ * request_secure_key - request the secure key
+ *
+ * Secure keys and their blobs are derived from CAAM hardware.
+ * Userspace manages secure  key-type data, but key data is not
+ * visible in plain form. It is presented as blobs.
+ */
+struct key *request_secure_key(const char *secure_desc,
+				const u8 **master_key, size_t *master_keylen)
+{
+	struct secure_key_payload *spayload;
+	struct key *skey;
+
+	skey = request_key(&key_type_secure, secure_desc, NULL);
+	if (IS_ERR(skey))
+		goto error;
+
+	down_read(&skey->sem);
+	spayload = skey->payload.data[0];
+	*master_key = spayload->key;
+	*master_keylen = spayload->key_len;
+error:
+	return skey;
+}
-- 
2.17.1

