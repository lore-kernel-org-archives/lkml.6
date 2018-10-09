Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FA5AECDE3A
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 16:48:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E12532087D
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 16:48:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E12532087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727452AbeJJAF4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 20:05:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37076 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726434AbeJJAF4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 20:05:56 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 09D775F78F;
        Tue,  9 Oct 2018 16:48:05 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-149.rdu2.redhat.com [10.10.120.149])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6846568C60;
        Tue,  9 Oct 2018 16:48:03 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 10/22] KEYS: asym_tpm: add skeleton for asym_tpm [ver #2]
From:   David Howells <dhowells@redhat.com>
To:     jmorris@namei.org
Cc:     Denis Kenzior <denkenz@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Marcel Holtmann <marcel@holtmann.org>, dhowells@redhat.com,
        denkenz@gmail.com, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 09 Oct 2018 17:48:02 +0100
Message-ID: <153910368260.12141.584080509971034256.stgit@warthog.procyon.org.uk>
In-Reply-To: <153910360263.12141.6032694262361399627.stgit@warthog.procyon.org.uk>
References: <153910360263.12141.6032694262361399627.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Tue, 09 Oct 2018 16:48:05 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Denis Kenzior <denkenz@gmail.com>

This patch adds the basic skeleton for the asym_tpm asymmetric key
subtype.

Signed-off-by: Denis Kenzior <denkenz@gmail.com>
Signed-off-by: David Howells <dhowells@redhat.com>
Tested-by: Marcel Holtmann <marcel@holtmann.org>
Reviewed-by: Marcel Holtmann <marcel@holtmann.org>
---

 crypto/asymmetric_keys/Kconfig    |   11 +++++
 crypto/asymmetric_keys/Makefile   |    1 
 crypto/asymmetric_keys/asym_tpm.c |   90 +++++++++++++++++++++++++++++++++++++
 include/crypto/asym_tpm_subtype.h |   16 +++++++
 4 files changed, 118 insertions(+)
 create mode 100644 crypto/asymmetric_keys/asym_tpm.c
 create mode 100644 include/crypto/asym_tpm_subtype.h

diff --git a/crypto/asymmetric_keys/Kconfig b/crypto/asymmetric_keys/Kconfig
index 66a7dad7ed3d..b75555c7d8ae 100644
--- a/crypto/asymmetric_keys/Kconfig
+++ b/crypto/asymmetric_keys/Kconfig
@@ -21,6 +21,17 @@ config ASYMMETRIC_PUBLIC_KEY_SUBTYPE
 	  appropriate hash algorithms (such as SHA-1) must be available.
 	  ENOPKG will be reported if the requisite algorithm is unavailable.
 
+config ASYMMETRIC_TPM_KEY_SUBTYPE
+	tristate "Asymmetric TPM backed private key subtype"
+	depends on TCG_TPM
+	select CRYPTO_HMAC
+	select CRYPTO_SHA1
+	select CRYPTO_HASH_INFO
+	help
+	  This option provides support for TPM backed private key type handling.
+	  Operations such as sign, verify, encrypt, decrypt are performed by
+	  the TPM after the private key is loaded.
+
 config X509_CERTIFICATE_PARSER
 	tristate "X.509 certificate parser"
 	depends on ASYMMETRIC_PUBLIC_KEY_SUBTYPE
diff --git a/crypto/asymmetric_keys/Makefile b/crypto/asymmetric_keys/Makefile
index c38424f55b08..73fbe650ff1d 100644
--- a/crypto/asymmetric_keys/Makefile
+++ b/crypto/asymmetric_keys/Makefile
@@ -11,6 +11,7 @@ asymmetric_keys-y := \
 	signature.o
 
 obj-$(CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE) += public_key.o
+obj-$(CONFIG_ASYMMETRIC_TPM_KEY_SUBTYPE) += asym_tpm.o
 
 #
 # X.509 Certificate handling
diff --git a/crypto/asymmetric_keys/asym_tpm.c b/crypto/asymmetric_keys/asym_tpm.c
new file mode 100644
index 000000000000..d0b2b97e8e54
--- /dev/null
+++ b/crypto/asymmetric_keys/asym_tpm.c
@@ -0,0 +1,90 @@
+// SPDX-License-Identifier: GPL-2.0
+#define pr_fmt(fmt) "ASYM-TPM: "fmt
+#include <linux/slab.h>
+#include <linux/module.h>
+#include <linux/export.h>
+#include <linux/kernel.h>
+#include <linux/seq_file.h>
+#include <linux/scatterlist.h>
+#include <linux/tpm.h>
+#include <keys/asymmetric-subtype.h>
+#include <crypto/asym_tpm_subtype.h>
+
+/*
+ * Provide a part of a description of the key for /proc/keys.
+ */
+static void asym_tpm_describe(const struct key *asymmetric_key,
+			      struct seq_file *m)
+{
+	struct tpm_key *tk = asymmetric_key->payload.data[asym_crypto];
+
+	if (!tk)
+		return;
+
+	seq_printf(m, "TPM1.2/Blob");
+}
+
+static void asym_tpm_destroy(void *payload0, void *payload3)
+{
+	struct tpm_key *tk = payload0;
+
+	if (!tk)
+		return;
+
+	kfree(tk->blob);
+	tk->blob_len = 0;
+
+	kfree(tk);
+}
+
+/* Given the blob, parse it and load it into the TPM */
+struct tpm_key *tpm_key_create(const void *blob, uint32_t blob_len)
+{
+	int r;
+	struct tpm_key *tk;
+
+	r = tpm_is_tpm2(NULL);
+	if (r < 0)
+		goto error;
+
+	/* We don't support TPM2 yet */
+	if (r > 0) {
+		r = -ENODEV;
+		goto error;
+	}
+
+	r = -ENOMEM;
+	tk = kzalloc(sizeof(struct tpm_key), GFP_KERNEL);
+	if (!tk)
+		goto error;
+
+	tk->blob = kmemdup(blob, blob_len, GFP_KERNEL);
+	if (!tk->blob)
+		goto error_memdup;
+
+	tk->blob_len = blob_len;
+
+	return tk;
+
+error_memdup:
+	kfree(tk);
+error:
+	return ERR_PTR(r);
+}
+EXPORT_SYMBOL_GPL(tpm_key_create);
+
+/*
+ * TPM-based asymmetric key subtype
+ */
+struct asymmetric_key_subtype asym_tpm_subtype = {
+	.owner			= THIS_MODULE,
+	.name			= "asym_tpm",
+	.name_len		= sizeof("asym_tpm") - 1,
+	.describe		= asym_tpm_describe,
+	.destroy		= asym_tpm_destroy,
+};
+EXPORT_SYMBOL_GPL(asym_tpm_subtype);
+
+MODULE_DESCRIPTION("TPM based asymmetric key subtype");
+MODULE_AUTHOR("Intel Corporation");
+MODULE_LICENSE("GPL v2");
diff --git a/include/crypto/asym_tpm_subtype.h b/include/crypto/asym_tpm_subtype.h
new file mode 100644
index 000000000000..03550b850998
--- /dev/null
+++ b/include/crypto/asym_tpm_subtype.h
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: GPL-2.0
+#ifndef _LINUX_ASYM_TPM_SUBTYPE_H
+#define _LINUX_ASYM_TPM_SUBTYPE_H
+
+#include <linux/keyctl.h>
+
+struct tpm_key {
+	void *blob;
+	u32 blob_len;
+};
+
+struct tpm_key *tpm_key_create(const void *blob, uint32_t blob_len);
+
+extern struct asymmetric_key_subtype asym_tpm_subtype;
+
+#endif /* _LINUX_ASYM_TPM_SUBTYPE_H */

