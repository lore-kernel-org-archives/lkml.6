Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753779AbeCPUje (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 16:39:34 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:46256 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753749AbeCPUj2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 16:39:28 -0400
From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
To: linux-integrity@vger.kernel.org
Cc: linux-security-module@vger.kernel.org, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>,
        David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>, Jessica Yu <jeyu@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        "AKASHI, Takahiro" <takahiro.akashi@linaro.org>,
        Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Subject: [PATCH v6 01/12] MODSIGN: Export module signature definitions
Date: Fri, 16 Mar 2018 17:38:26 -0300
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316203837.10174-1-bauerman@linux.vnet.ibm.com>
References: <20180316203837.10174-1-bauerman@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18031620-8235-0000-0000-00000D2BE07A
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008686; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000254; SDB=6.01004029; UDB=6.00511020; IPR=6.00783318;
 MB=3.00020079; MTD=3.00000008; XFM=3.00000015; UTC=2018-03-16 20:39:26
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18031620-8236-0000-0000-00004016E2E4
Message-Id: <20180316203837.10174-2-bauerman@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-16_13:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1803160243
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IMA will use the module_signature format for append signatures, so export
the relevant definitions and factor out the code which verifies that the
appended signature trailer is valid.

Also, create a CONFIG_MODULE_SIG_FORMAT option so that IMA can select it
and be able to use validate_module_sig() without having to depend on
CONFIG_MODULE_SIG.

Signed-off-by: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Reviewed-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: Jessica Yu <jeyu@kernel.org>
---
 include/linux/module.h           |  3 --
 include/linux/module_signature.h | 44 +++++++++++++++++++++++
 init/Kconfig                     |  6 +++-
 kernel/Makefile                  |  2 +-
 kernel/module.c                  |  1 +
 kernel/module_signing.c          | 77 ++++++++++++++++++----------------------
 6 files changed, 85 insertions(+), 48 deletions(-)

diff --git a/include/linux/module.h b/include/linux/module.h
index d44df9b2c131..275cbc2579eb 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -24,9 +24,6 @@
 #include <linux/percpu.h>
 #include <asm/module.h>
 
-/* In stripped ARM and x86-64 modules, ~ is surprisingly rare. */
-#define MODULE_SIG_STRING "~Module signature appended~\n"
-
 /* Not Yet Implemented */
 #define MODULE_SUPPORTED_DEVICE(name)
 
diff --git a/include/linux/module_signature.h b/include/linux/module_signature.h
new file mode 100644
index 000000000000..890135437b6b
--- /dev/null
+++ b/include/linux/module_signature.h
@@ -0,0 +1,44 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Module signature handling.
+ *
+ * Copyright (C) 2012 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ */
+
+#ifndef _LINUX_MODULE_SIGNATURE_H
+#define _LINUX_MODULE_SIGNATURE_H
+
+/* In stripped ARM and x86-64 modules, ~ is surprisingly rare. */
+#define MODULE_SIG_STRING "~Module signature appended~\n"
+
+enum pkey_id_type {
+	PKEY_ID_PGP,		/* OpenPGP generated key ID */
+	PKEY_ID_X509,		/* X.509 arbitrary subjectKeyIdentifier */
+	PKEY_ID_PKCS7,		/* Signature in PKCS#7 message */
+};
+
+/*
+ * Module signature information block.
+ *
+ * The constituents of the signature section are, in order:
+ *
+ *	- Signer's name
+ *	- Key identifier
+ *	- Signature data
+ *	- Information block
+ */
+struct module_signature {
+	u8	algo;		/* Public-key crypto algorithm [0] */
+	u8	hash;		/* Digest algorithm [0] */
+	u8	id_type;	/* Key identifier type [PKEY_ID_PKCS7] */
+	u8	signer_len;	/* Length of signer's name [0] */
+	u8	key_id_len;	/* Length of key identifier [0] */
+	u8	__pad[3];
+	__be32	sig_len;	/* Length of signature data */
+};
+
+int validate_module_sig(const struct module_signature *ms, size_t file_len);
+int mod_verify_sig(const void *mod, unsigned long *_modlen);
+
+#endif /* _LINUX_MODULE_SIGNATURE_H */
diff --git a/init/Kconfig b/init/Kconfig
index e37f4b2a6445..56a9679671b5 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1760,7 +1760,7 @@ config MODULE_SRCVERSION_ALL
 config MODULE_SIG
 	bool "Module signature verification"
 	depends on MODULES
-	select SYSTEM_DATA_VERIFICATION
+	select MODULE_SIG_FORMAT
 	help
 	  Check modules for valid signatures upon load: the signature
 	  is simply appended to the module. For more information see
@@ -1775,6 +1775,10 @@ config MODULE_SIG
 	  debuginfo strip done by some packagers (such as rpmbuild) and
 	  inclusion into an initramfs that wants the module size reduced.
 
+config MODULE_SIG_FORMAT
+	def_bool n
+	select SYSTEM_DATA_VERIFICATION
+
 config MODULE_SIG_FORCE
 	bool "Require modules to be validly signed"
 	depends on MODULE_SIG
diff --git a/kernel/Makefile b/kernel/Makefile
index f85ae5dfa474..a4c7a7a0cce7 100644
--- a/kernel/Makefile
+++ b/kernel/Makefile
@@ -58,7 +58,7 @@ obj-y += up.o
 endif
 obj-$(CONFIG_UID16) += uid16.o
 obj-$(CONFIG_MODULES) += module.o
-obj-$(CONFIG_MODULE_SIG) += module_signing.o
+obj-$(CONFIG_MODULE_SIG_FORMAT) += module_signing.o
 obj-$(CONFIG_KALLSYMS) += kallsyms.o
 obj-$(CONFIG_BSD_PROCESS_ACCT) += acct.o
 obj-$(CONFIG_CRASH_CORE) += crash_core.o
diff --git a/kernel/module.c b/kernel/module.c
index ad2d420024f6..292eee54e390 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -19,6 +19,7 @@
 #include <linux/export.h>
 #include <linux/extable.h>
 #include <linux/moduleloader.h>
+#include <linux/module_signature.h>
 #include <linux/trace_events.h>
 #include <linux/init.h>
 #include <linux/kallsyms.h>
diff --git a/kernel/module_signing.c b/kernel/module_signing.c
index 937c844bee4a..a7c2c461c598 100644
--- a/kernel/module_signing.c
+++ b/kernel/module_signing.c
@@ -11,36 +11,41 @@
 
 #include <linux/kernel.h>
 #include <linux/errno.h>
+#include <linux/module_signature.h>
 #include <linux/string.h>
 #include <linux/verification.h>
 #include <crypto/public_key.h>
 #include "module-internal.h"
 
-enum pkey_id_type {
-	PKEY_ID_PGP,		/* OpenPGP generated key ID */
-	PKEY_ID_X509,		/* X.509 arbitrary subjectKeyIdentifier */
-	PKEY_ID_PKCS7,		/* Signature in PKCS#7 message */
-};
-
-/*
- * Module signature information block.
+/**
+ * validate_module_sig - validate that the given signature is sane
  *
- * The constituents of the signature section are, in order:
- *
- *	- Signer's name
- *	- Key identifier
- *	- Signature data
- *	- Information block
+ * @ms:		Signature to validate.
+ * @file_len:	Size of the file to which @ms is appended.
  */
-struct module_signature {
-	u8	algo;		/* Public-key crypto algorithm [0] */
-	u8	hash;		/* Digest algorithm [0] */
-	u8	id_type;	/* Key identifier type [PKEY_ID_PKCS7] */
-	u8	signer_len;	/* Length of signer's name [0] */
-	u8	key_id_len;	/* Length of key identifier [0] */
-	u8	__pad[3];
-	__be32	sig_len;	/* Length of signature data */
-};
+int validate_module_sig(const struct module_signature *ms, size_t file_len)
+{
+	if (be32_to_cpu(ms->sig_len) >= file_len - sizeof(*ms))
+		return -EBADMSG;
+
+	if (ms->id_type != PKEY_ID_PKCS7) {
+		pr_err("Module is not signed with expected PKCS#7 message\n");
+		return -ENOPKG;
+	}
+
+	if (ms->algo != 0 ||
+	    ms->hash != 0 ||
+	    ms->signer_len != 0 ||
+	    ms->key_id_len != 0 ||
+	    ms->__pad[0] != 0 ||
+	    ms->__pad[1] != 0 ||
+	    ms->__pad[2] != 0) {
+		pr_err("PKCS#7 signature info has unexpected non-zero params\n");
+		return -EBADMSG;
+	}
+
+	return 0;
+}
 
 /*
  * Verify the signature on a module.
@@ -49,6 +54,7 @@ int mod_verify_sig(const void *mod, unsigned long *_modlen)
 {
 	struct module_signature ms;
 	size_t modlen = *_modlen, sig_len;
+	int ret;
 
 	pr_devel("==>%s(,%zu)\n", __func__, modlen);
 
@@ -56,30 +62,15 @@ int mod_verify_sig(const void *mod, unsigned long *_modlen)
 		return -EBADMSG;
 
 	memcpy(&ms, mod + (modlen - sizeof(ms)), sizeof(ms));
-	modlen -= sizeof(ms);
+
+	ret = validate_module_sig(&ms, modlen);
+	if (ret)
+		return ret;
 
 	sig_len = be32_to_cpu(ms.sig_len);
-	if (sig_len >= modlen)
-		return -EBADMSG;
-	modlen -= sig_len;
+	modlen -= sig_len + sizeof(ms);
 	*_modlen = modlen;
 
-	if (ms.id_type != PKEY_ID_PKCS7) {
-		pr_err("Module is not signed with expected PKCS#7 message\n");
-		return -ENOPKG;
-	}
-
-	if (ms.algo != 0 ||
-	    ms.hash != 0 ||
-	    ms.signer_len != 0 ||
-	    ms.key_id_len != 0 ||
-	    ms.__pad[0] != 0 ||
-	    ms.__pad[1] != 0 ||
-	    ms.__pad[2] != 0) {
-		pr_err("PKCS#7 signature info has unexpected non-zero params\n");
-		return -EBADMSG;
-	}
-
 	return verify_pkcs7_signature(mod, modlen, mod + modlen, sig_len,
 				      NULL, VERIFYING_MODULE_SIGNATURE,
 				      NULL, NULL);
