Return-Path: <SRS0=1bfu=OR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46528C04EB8
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 20:30:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 179E72083D
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 20:30:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 179E72083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726284AbeLHUas (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Dec 2018 15:30:48 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:58974 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726260AbeLHUar (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Dec 2018 15:30:47 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wB8KT7au122599
        for <linux-kernel@vger.kernel.org>; Sat, 8 Dec 2018 15:30:46 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2p8bbq01gw-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Sat, 08 Dec 2018 15:30:46 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <nayna@linux.ibm.com>;
        Sat, 8 Dec 2018 20:30:44 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sat, 8 Dec 2018 20:30:39 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wB8KUcrk5374216
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sat, 8 Dec 2018 20:30:38 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E5A554C040;
        Sat,  8 Dec 2018 20:30:37 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 968784C04E;
        Sat,  8 Dec 2018 20:30:34 +0000 (GMT)
Received: from swastik.ibmuc.com (unknown [9.85.68.82])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Sat,  8 Dec 2018 20:30:34 +0000 (GMT)
From:   Nayna Jain <nayna@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     linux-security-module@vger.kernel.org, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org, zohar@linux.ibm.com,
        dhowells@redhat.com, jforbes@redhat.com,
        seth.forshee@canonical.com, kexec@lists.infradead.org,
        keyrings@vger.kernel.org, vgoyal@redhat.com, ebiederm@xmission.com,
        mpe@ellerman.id.au, Nayna Jain <nayna@linux.ibm.com>
Subject: [PATCH v2 1/7] integrity: Define a trusted platform keyring
Date:   Sun,  9 Dec 2018 01:56:59 +0530
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20181208202705.18673-1-nayna@linux.ibm.com>
References: <20181208202705.18673-1-nayna@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18120820-0012-0000-0000-000002D67D06
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18120820-0013-0000-0000-0000210BEAE9
Message-Id: <20181208202705.18673-2-nayna@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-08_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1812080192
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On secure boot enabled systems, a verified kernel may need to kexec
additional kernels. For example, it may be used as a bootloader needing
to kexec a target kernel or it may need to kexec a crashdump kernel. In
such cases, it may want to verify the signature of the next kernel
image.

It is further possible that the kernel image is signed with third party
keys which are stored as platform or firmware keys in the 'db' variable.
The kernel, however, can not directly verify these platform keys, and an
administrator may therefore not want to trust them for arbitrary usage.
In order to differentiate platform keys from other keys and provide the
necessary separation of trust, the kernel needs an additional keyring to
store platform keys.

This patch creates the new keyring called ".platform" to isolate keys
provided by platform from keys by kernel. These keys are used to
facilitate signature verification during kexec. Since the scope of this
keyring is only the platform/firmware keys, it cannot be updated from
userspace.

This keyring can be enabled by setting CONFIG_INTEGRITY_PLATFORM_KEYRING.

Signed-off-by: Nayna Jain <nayna@linux.ibm.com>
Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
Acked-by: Serge Hallyn <serge@hallyn.com>
---
 security/integrity/Kconfig                         | 11 +++++
 security/integrity/Makefile                        |  1 +
 security/integrity/digsig.c                        | 48 +++++++++++++++-------
 security/integrity/integrity.h                     |  3 +-
 .../integrity/platform_certs/platform_keyring.c    | 39 ++++++++++++++++++
 5 files changed, 87 insertions(+), 15 deletions(-)
 create mode 100644 security/integrity/platform_certs/platform_keyring.c

diff --git a/security/integrity/Kconfig b/security/integrity/Kconfig
index da9565891738..4b4d2aeef539 100644
--- a/security/integrity/Kconfig
+++ b/security/integrity/Kconfig
@@ -51,6 +51,17 @@ config INTEGRITY_TRUSTED_KEYRING
 	   .evm keyrings be signed by a key on the system trusted
 	   keyring.
 
+config INTEGRITY_PLATFORM_KEYRING
+        bool "Provide keyring for platform/firmware trusted keys"
+        depends on INTEGRITY_ASYMMETRIC_KEYS
+        depends on SYSTEM_BLACKLIST_KEYRING
+        depends on EFI
+        help
+         Provide a separate, distinct keyring for platform trusted keys, which
+         the kernel automatically populates during initialization from values
+         provided by the platform for verifying the kexec'ed kerned image
+         and, possibly, the initramfs signature.
+
 config INTEGRITY_AUDIT
 	bool "Enables integrity auditing support "
 	depends on AUDIT
diff --git a/security/integrity/Makefile b/security/integrity/Makefile
index 04d6e462b079..046ffc1bb42d 100644
--- a/security/integrity/Makefile
+++ b/security/integrity/Makefile
@@ -9,6 +9,7 @@ integrity-y := iint.o
 integrity-$(CONFIG_INTEGRITY_AUDIT) += integrity_audit.o
 integrity-$(CONFIG_INTEGRITY_SIGNATURE) += digsig.o
 integrity-$(CONFIG_INTEGRITY_ASYMMETRIC_KEYS) += digsig_asymmetric.o
+integrity-$(CONFIG_INTEGRITY_PLATFORM_KEYRING) += platform_certs/platform_keyring.o
 
 subdir-$(CONFIG_IMA)			+= ima
 obj-$(CONFIG_IMA)			+= ima/
diff --git a/security/integrity/digsig.c b/security/integrity/digsig.c
index 5eacba858e4b..b5b180ff1434 100644
--- a/security/integrity/digsig.c
+++ b/security/integrity/digsig.c
@@ -35,6 +35,7 @@ static const char * const keyring_name[INTEGRITY_KEYRING_MAX] = {
 	".ima",
 #endif
 	"_module",
+	".platform",
 };
 
 #ifdef CONFIG_IMA_KEYRINGS_PERMIT_SIGNED_BY_BUILTIN_OR_SECONDARY
@@ -73,12 +74,40 @@ int integrity_digsig_verify(const unsigned int id, const char *sig, int siglen,
 	return -EOPNOTSUPP;
 }
 
-int __init integrity_init_keyring(const unsigned int id)
+static int __integrity_init_keyring(const unsigned int id, key_perm_t perm,
+				    struct key_restriction *restriction)
 {
 	const struct cred *cred = current_cred();
+	int err = 0;
+
+	keyring[id] = keyring_alloc(keyring_name[id], KUIDT_INIT(0),
+				    KGIDT_INIT(0), cred, perm,
+				    KEY_ALLOC_NOT_IN_QUOTA,
+				    restriction, NULL);
+	if (IS_ERR(keyring[id])) {
+		err = PTR_ERR(keyring[id]);
+		pr_info("Can't allocate %s keyring (%d)\n",
+			keyring_name[id], err);
+		keyring[id] = NULL;
+	}
+
+	return err;
+}
+
+int __init integrity_init_keyring(const unsigned int id)
+{
 	struct key_restriction *restriction;
+	key_perm_t perm;
 	int err = 0;
 
+	perm = (KEY_POS_ALL & ~KEY_POS_SETATTR) | KEY_USR_VIEW
+		| KEY_USR_READ | KEY_USR_SEARCH;
+
+	if (id == INTEGRITY_KEYRING_PLATFORM) {
+		restriction = NULL;
+		goto out;
+	}
+
 	if (!IS_ENABLED(CONFIG_INTEGRITY_TRUSTED_KEYRING))
 		return 0;
 
@@ -87,20 +116,11 @@ int __init integrity_init_keyring(const unsigned int id)
 		return -ENOMEM;
 
 	restriction->check = restrict_link_to_ima;
+	perm |= KEY_USR_WRITE;
+
+out:
+	err = __integrity_init_keyring(id, perm, restriction);
 
-	keyring[id] = keyring_alloc(keyring_name[id], KUIDT_INIT(0),
-				    KGIDT_INIT(0), cred,
-				    ((KEY_POS_ALL & ~KEY_POS_SETATTR) |
-				     KEY_USR_VIEW | KEY_USR_READ |
-				     KEY_USR_WRITE | KEY_USR_SEARCH),
-				    KEY_ALLOC_NOT_IN_QUOTA,
-				    restriction, NULL);
-	if (IS_ERR(keyring[id])) {
-		err = PTR_ERR(keyring[id]);
-		pr_info("Can't allocate %s keyring (%d)\n",
-			keyring_name[id], err);
-		keyring[id] = NULL;
-	}
 	return err;
 }
 
diff --git a/security/integrity/integrity.h b/security/integrity/integrity.h
index e60473b13a8d..c2332a44799e 100644
--- a/security/integrity/integrity.h
+++ b/security/integrity/integrity.h
@@ -142,7 +142,8 @@ int integrity_kernel_read(struct file *file, loff_t offset,
 #define INTEGRITY_KEYRING_EVM		0
 #define INTEGRITY_KEYRING_IMA		1
 #define INTEGRITY_KEYRING_MODULE	2
-#define INTEGRITY_KEYRING_MAX		3
+#define INTEGRITY_KEYRING_PLATFORM	3
+#define INTEGRITY_KEYRING_MAX		4
 
 extern struct dentry *integrity_dir;
 
diff --git a/security/integrity/platform_certs/platform_keyring.c b/security/integrity/platform_certs/platform_keyring.c
new file mode 100644
index 000000000000..dfc206bbe2ff
--- /dev/null
+++ b/security/integrity/platform_certs/platform_keyring.c
@@ -0,0 +1,39 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Platform keyring for firmware/platform keys
+ *
+ * Copyright (C) 2012 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public Licence
+ * as published by the Free Software Foundation; either version
+ * 2 of the Licence, or (at your option) any later version.
+ */
+
+#include <linux/export.h>
+#include <linux/kernel.h>
+#include <linux/sched.h>
+#include <linux/cred.h>
+#include <linux/err.h>
+#include <linux/slab.h>
+#include "../integrity.h"
+
+/*
+ * Create the trusted keyrings.
+ */
+static __init int platform_keyring_init(void)
+{
+	int rc;
+
+	rc = integrity_init_keyring(INTEGRITY_KEYRING_PLATFORM);
+	if (rc)
+		return rc;
+
+	pr_notice("Platform Keyring initialized\n");
+	return 0;
+}
+
+/*
+ * Must be initialised before we try and load the keys into the keyring.
+ */
+device_initcall(platform_keyring_init);
-- 
2.13.6

