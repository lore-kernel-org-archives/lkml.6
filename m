Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNWANTED_LANGUAGE_BODY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A49CCC43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 21:56:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DE4820839
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 21:56:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DE4820839
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728179AbeIFC2O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 22:28:14 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:32794 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727592AbeIFC2O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 22:28:14 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D8233402242D;
        Wed,  5 Sep 2018 21:56:04 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-123-84.rdu2.redhat.com [10.10.123.84])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 03C18202706C;
        Wed,  5 Sep 2018 21:56:03 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 16/22] KEYS: Move trusted.h to include/keys
From:   David Howells <dhowells@redhat.com>
To:     jmorris@namei.org
Cc:     denkenz@gmail.com, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 05 Sep 2018 22:56:03 +0100
Message-ID: <153618456351.7946.16069792174440572937.stgit@warthog.procyon.org.uk>
In-Reply-To: <153618445730.7946.10001472635835806478.stgit@warthog.procyon.org.uk>
References: <153618445730.7946.10001472635835806478.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Wed, 05 Sep 2018 21:56:04 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Wed, 05 Sep 2018 21:56:04 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'dhowells@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Denis Kenzior <denkenz@gmail.com>

Signed-off-by: Denis Kenzior <denkenz@gmail.com>
Signed-off-by: David Howells <dhowells@redhat.com>
---

 include/keys/trusted.h  |  136 +++++++++++++++++++++++++++++++++++++++++++++++
 security/keys/trusted.c |    2 -
 security/keys/trusted.h |  136 -----------------------------------------------
 3 files changed, 137 insertions(+), 137 deletions(-)
 create mode 100644 include/keys/trusted.h
 delete mode 100644 security/keys/trusted.h

diff --git a/include/keys/trusted.h b/include/keys/trusted.h
new file mode 100644
index 000000000000..adbcb6817826
--- /dev/null
+++ b/include/keys/trusted.h
@@ -0,0 +1,136 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __TRUSTED_KEY_H
+#define __TRUSTED_KEY_H
+
+/* implementation specific TPM constants */
+#define MAX_BUF_SIZE			1024
+#define TPM_GETRANDOM_SIZE		14
+#define TPM_OSAP_SIZE			36
+#define TPM_OIAP_SIZE			10
+#define TPM_SEAL_SIZE			87
+#define TPM_UNSEAL_SIZE			104
+#define TPM_SIZE_OFFSET			2
+#define TPM_RETURN_OFFSET		6
+#define TPM_DATA_OFFSET			10
+
+#define LOAD32(buffer, offset)	(ntohl(*(uint32_t *)&buffer[offset]))
+#define LOAD32N(buffer, offset)	(*(uint32_t *)&buffer[offset])
+#define LOAD16(buffer, offset)	(ntohs(*(uint16_t *)&buffer[offset]))
+
+struct tpm_buf {
+	int len;
+	unsigned char data[MAX_BUF_SIZE];
+};
+
+#define INIT_BUF(tb) (tb->len = 0)
+
+struct osapsess {
+	uint32_t handle;
+	unsigned char secret[SHA1_DIGEST_SIZE];
+	unsigned char enonce[TPM_NONCE_SIZE];
+};
+
+/* discrete values, but have to store in uint16_t for TPM use */
+enum {
+	SEAL_keytype = 1,
+	SRK_keytype = 4
+};
+
+int TSS_authhmac(unsigned char *digest, const unsigned char *key,
+			unsigned int keylen, unsigned char *h1,
+			unsigned char *h2, unsigned char h3, ...);
+int TSS_checkhmac1(unsigned char *buffer,
+			  const uint32_t command,
+			  const unsigned char *ononce,
+			  const unsigned char *key,
+			  unsigned int keylen, ...);
+
+int trusted_tpm_send(unsigned char *cmd, size_t buflen);
+int oiap(struct tpm_buf *tb, uint32_t *handle, unsigned char *nonce);
+
+#define TPM_DEBUG 0
+
+#if TPM_DEBUG
+static inline void dump_options(struct trusted_key_options *o)
+{
+	pr_info("trusted_key: sealing key type %d\n", o->keytype);
+	pr_info("trusted_key: sealing key handle %0X\n", o->keyhandle);
+	pr_info("trusted_key: pcrlock %d\n", o->pcrlock);
+	pr_info("trusted_key: pcrinfo %d\n", o->pcrinfo_len);
+	print_hex_dump(KERN_INFO, "pcrinfo ", DUMP_PREFIX_NONE,
+		       16, 1, o->pcrinfo, o->pcrinfo_len, 0);
+}
+
+static inline void dump_payload(struct trusted_key_payload *p)
+{
+	pr_info("trusted_key: key_len %d\n", p->key_len);
+	print_hex_dump(KERN_INFO, "key ", DUMP_PREFIX_NONE,
+		       16, 1, p->key, p->key_len, 0);
+	pr_info("trusted_key: bloblen %d\n", p->blob_len);
+	print_hex_dump(KERN_INFO, "blob ", DUMP_PREFIX_NONE,
+		       16, 1, p->blob, p->blob_len, 0);
+	pr_info("trusted_key: migratable %d\n", p->migratable);
+}
+
+static inline void dump_sess(struct osapsess *s)
+{
+	print_hex_dump(KERN_INFO, "trusted-key: handle ", DUMP_PREFIX_NONE,
+		       16, 1, &s->handle, 4, 0);
+	pr_info("trusted-key: secret:\n");
+	print_hex_dump(KERN_INFO, "", DUMP_PREFIX_NONE,
+		       16, 1, &s->secret, SHA1_DIGEST_SIZE, 0);
+	pr_info("trusted-key: enonce:\n");
+	print_hex_dump(KERN_INFO, "", DUMP_PREFIX_NONE,
+		       16, 1, &s->enonce, SHA1_DIGEST_SIZE, 0);
+}
+
+static inline void dump_tpm_buf(unsigned char *buf)
+{
+	int len;
+
+	pr_info("\ntrusted-key: tpm buffer\n");
+	len = LOAD32(buf, TPM_SIZE_OFFSET);
+	print_hex_dump(KERN_INFO, "", DUMP_PREFIX_NONE, 16, 1, buf, len, 0);
+}
+#else
+static inline void dump_options(struct trusted_key_options *o)
+{
+}
+
+static inline void dump_payload(struct trusted_key_payload *p)
+{
+}
+
+static inline void dump_sess(struct osapsess *s)
+{
+}
+
+static inline void dump_tpm_buf(unsigned char *buf)
+{
+}
+#endif
+
+static inline void store8(struct tpm_buf *buf, const unsigned char value)
+{
+	buf->data[buf->len++] = value;
+}
+
+static inline void store16(struct tpm_buf *buf, const uint16_t value)
+{
+	*(uint16_t *) & buf->data[buf->len] = htons(value);
+	buf->len += sizeof value;
+}
+
+static inline void store32(struct tpm_buf *buf, const uint32_t value)
+{
+	*(uint32_t *) & buf->data[buf->len] = htonl(value);
+	buf->len += sizeof value;
+}
+
+static inline void storebytes(struct tpm_buf *buf, const unsigned char *in,
+			      const int len)
+{
+	memcpy(buf->data + buf->len, in, len);
+	buf->len += len;
+}
+#endif
diff --git a/security/keys/trusted.c b/security/keys/trusted.c
index 1c025fdfe0e0..ff6789365a12 100644
--- a/security/keys/trusted.c
+++ b/security/keys/trusted.c
@@ -30,7 +30,7 @@
 #include <linux/tpm.h>
 #include <linux/tpm_command.h>
 
-#include "trusted.h"
+#include <keys/trusted.h>
 
 static const char hmac_alg[] = "hmac(sha1)";
 static const char hash_alg[] = "sha1";
diff --git a/security/keys/trusted.h b/security/keys/trusted.h
deleted file mode 100644
index adbcb6817826..000000000000
--- a/security/keys/trusted.h
+++ /dev/null
@@ -1,136 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef __TRUSTED_KEY_H
-#define __TRUSTED_KEY_H
-
-/* implementation specific TPM constants */
-#define MAX_BUF_SIZE			1024
-#define TPM_GETRANDOM_SIZE		14
-#define TPM_OSAP_SIZE			36
-#define TPM_OIAP_SIZE			10
-#define TPM_SEAL_SIZE			87
-#define TPM_UNSEAL_SIZE			104
-#define TPM_SIZE_OFFSET			2
-#define TPM_RETURN_OFFSET		6
-#define TPM_DATA_OFFSET			10
-
-#define LOAD32(buffer, offset)	(ntohl(*(uint32_t *)&buffer[offset]))
-#define LOAD32N(buffer, offset)	(*(uint32_t *)&buffer[offset])
-#define LOAD16(buffer, offset)	(ntohs(*(uint16_t *)&buffer[offset]))
-
-struct tpm_buf {
-	int len;
-	unsigned char data[MAX_BUF_SIZE];
-};
-
-#define INIT_BUF(tb) (tb->len = 0)
-
-struct osapsess {
-	uint32_t handle;
-	unsigned char secret[SHA1_DIGEST_SIZE];
-	unsigned char enonce[TPM_NONCE_SIZE];
-};
-
-/* discrete values, but have to store in uint16_t for TPM use */
-enum {
-	SEAL_keytype = 1,
-	SRK_keytype = 4
-};
-
-int TSS_authhmac(unsigned char *digest, const unsigned char *key,
-			unsigned int keylen, unsigned char *h1,
-			unsigned char *h2, unsigned char h3, ...);
-int TSS_checkhmac1(unsigned char *buffer,
-			  const uint32_t command,
-			  const unsigned char *ononce,
-			  const unsigned char *key,
-			  unsigned int keylen, ...);
-
-int trusted_tpm_send(unsigned char *cmd, size_t buflen);
-int oiap(struct tpm_buf *tb, uint32_t *handle, unsigned char *nonce);
-
-#define TPM_DEBUG 0
-
-#if TPM_DEBUG
-static inline void dump_options(struct trusted_key_options *o)
-{
-	pr_info("trusted_key: sealing key type %d\n", o->keytype);
-	pr_info("trusted_key: sealing key handle %0X\n", o->keyhandle);
-	pr_info("trusted_key: pcrlock %d\n", o->pcrlock);
-	pr_info("trusted_key: pcrinfo %d\n", o->pcrinfo_len);
-	print_hex_dump(KERN_INFO, "pcrinfo ", DUMP_PREFIX_NONE,
-		       16, 1, o->pcrinfo, o->pcrinfo_len, 0);
-}
-
-static inline void dump_payload(struct trusted_key_payload *p)
-{
-	pr_info("trusted_key: key_len %d\n", p->key_len);
-	print_hex_dump(KERN_INFO, "key ", DUMP_PREFIX_NONE,
-		       16, 1, p->key, p->key_len, 0);
-	pr_info("trusted_key: bloblen %d\n", p->blob_len);
-	print_hex_dump(KERN_INFO, "blob ", DUMP_PREFIX_NONE,
-		       16, 1, p->blob, p->blob_len, 0);
-	pr_info("trusted_key: migratable %d\n", p->migratable);
-}
-
-static inline void dump_sess(struct osapsess *s)
-{
-	print_hex_dump(KERN_INFO, "trusted-key: handle ", DUMP_PREFIX_NONE,
-		       16, 1, &s->handle, 4, 0);
-	pr_info("trusted-key: secret:\n");
-	print_hex_dump(KERN_INFO, "", DUMP_PREFIX_NONE,
-		       16, 1, &s->secret, SHA1_DIGEST_SIZE, 0);
-	pr_info("trusted-key: enonce:\n");
-	print_hex_dump(KERN_INFO, "", DUMP_PREFIX_NONE,
-		       16, 1, &s->enonce, SHA1_DIGEST_SIZE, 0);
-}
-
-static inline void dump_tpm_buf(unsigned char *buf)
-{
-	int len;
-
-	pr_info("\ntrusted-key: tpm buffer\n");
-	len = LOAD32(buf, TPM_SIZE_OFFSET);
-	print_hex_dump(KERN_INFO, "", DUMP_PREFIX_NONE, 16, 1, buf, len, 0);
-}
-#else
-static inline void dump_options(struct trusted_key_options *o)
-{
-}
-
-static inline void dump_payload(struct trusted_key_payload *p)
-{
-}
-
-static inline void dump_sess(struct osapsess *s)
-{
-}
-
-static inline void dump_tpm_buf(unsigned char *buf)
-{
-}
-#endif
-
-static inline void store8(struct tpm_buf *buf, const unsigned char value)
-{
-	buf->data[buf->len++] = value;
-}
-
-static inline void store16(struct tpm_buf *buf, const uint16_t value)
-{
-	*(uint16_t *) & buf->data[buf->len] = htons(value);
-	buf->len += sizeof value;
-}
-
-static inline void store32(struct tpm_buf *buf, const uint32_t value)
-{
-	*(uint32_t *) & buf->data[buf->len] = htonl(value);
-	buf->len += sizeof value;
-}
-
-static inline void storebytes(struct tpm_buf *buf, const unsigned char *in,
-			      const int len)
-{
-	memcpy(buf->data + buf->len, in, len);
-	buf->len += len;
-}
-#endif

