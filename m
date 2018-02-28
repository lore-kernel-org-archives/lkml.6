Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934778AbeB1R5P (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 12:57:15 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33736 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S934465AbeB1R5I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 12:57:08 -0500
From: Nayna Jain <nayna@linux.vnet.ibm.com>
To: dhowells@redhat.com
Cc: keyrings@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        Nayna Jain <nayna@linux.vnet.ibm.com>
Subject: [PATCH 3/3] ima: support platform keyring for kernel appraisal
Date: Wed, 28 Feb 2018 23:25:21 +0530
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180228175521.10287-1-nayna@linux.vnet.ibm.com>
References: <20180228175521.10287-1-nayna@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18022817-0008-0000-0000-000004D6177C
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18022817-0009-0000-0000-00001E69186A
Message-Id: <20180228175521.10287-3-nayna@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-28_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1802280218
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Distros may sign the kernel images and, possibly, the initramfs with
platform trusted keys. On secure boot enabled systems or embedded
devices, these signatures are to be validated using keys on the platform
keyring.

This patch enables IMA-appraisal to access the platform keyring, based
on a new Kconfig option "IMA_USE_PLATFORM_KEYRING".

Signed-off-by: Nayna Jain <nayna@linux.vnet.ibm.com>
---
 security/integrity/digsig.c           | 15 +++++++++++++++
 security/integrity/ima/Kconfig        | 10 ++++++++++
 security/integrity/ima/ima_appraise.c | 22 +++++++++++++++++-----
 security/integrity/ima/ima_init.c     |  4 ++++
 security/integrity/integrity.h        | 17 ++++++++++++++++-
 5 files changed, 62 insertions(+), 6 deletions(-)

diff --git a/security/integrity/digsig.c b/security/integrity/digsig.c
index 6f9e4ce568cd..87f2ae5ba48c 100644
--- a/security/integrity/digsig.c
+++ b/security/integrity/digsig.c
@@ -34,6 +34,8 @@ static const char *keyring_name[INTEGRITY_KEYRING_MAX] = {
 	".ima",
 #endif
 	"_module",
+	".platform_keys",
+
 };
 
 #ifdef CONFIG_INTEGRITY_TRUSTED_KEYRING
@@ -78,6 +80,19 @@ int integrity_digsig_verify(const unsigned int id, const char *sig, int siglen,
 	return -EOPNOTSUPP;
 }
 
+#ifdef CONFIG_IMA_USE_PLATFORM_KEYRING
+int __init integrity_load_keyring(const unsigned int id)
+{
+
+	keyring[id] = find_keyring_by_name(keyring_name[id], 0);
+	if (IS_ERR(keyring[id]))
+		if (PTR_ERR(keyring[id]) != -ENOKEY)
+			return PTR_ERR(keyring[id]);
+	return 0;
+
+}
+#endif
+
 int __init integrity_init_keyring(const unsigned int id)
 {
 	const struct cred *cred = current_cred();
diff --git a/security/integrity/ima/Kconfig b/security/integrity/ima/Kconfig
index 35ef69312811..2e89d4f8a364 100644
--- a/security/integrity/ima/Kconfig
+++ b/security/integrity/ima/Kconfig
@@ -227,3 +227,13 @@ config IMA_APPRAISE_SIGNED_INIT
 	default n
 	help
 	   This option requires user-space init to be signed.
+
+config IMA_USE_PLATFORM_KEYRING
+       bool "IMA uses keys from Platform Keyring for verification"
+       depends on PLATFORM_KEYRING
+       depends on IMA_APPRAISE
+       depends on INTEGRITY_ASYMMETRIC_KEYS
+       default n
+       help
+	  This option enables IMA appraisal to look for the platform
+	  trusted keys in .platform_keys keyring.
diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
index f2803a40ff82..5fec29f40595 100644
--- a/security/integrity/ima/ima_appraise.c
+++ b/security/integrity/ima/ima_appraise.c
@@ -276,13 +276,25 @@ int ima_appraise_measurement(enum ima_hooks func,
 					     (const char *)xattr_value, rc,
 					     iint->ima_hash->digest,
 					     iint->ima_hash->length);
-		if (rc == -EOPNOTSUPP) {
-			status = INTEGRITY_UNKNOWN;
-		} else if (rc) {
+		if (rc) {
+			if (rc == -EOPNOTSUPP) {
+				status = INTEGRITY_UNKNOWN;
+				break;
+			}
+			if (func == KEXEC_KERNEL_CHECK) {
+				rc = integrity_digsig_verify(
+						INTEGRITY_KEYRING_PLATFORM,
+						(const char *)xattr_value,
+						xattr_len,
+						iint->ima_hash->digest,
+						iint->ima_hash->length);
+				if (!rc) {
+					status = INTEGRITY_PASS;
+					break;
+				}
+			}
 			cause = "invalid-signature";
 			status = INTEGRITY_FAIL;
-		} else {
-			status = INTEGRITY_PASS;
 		}
 		break;
 	default:
diff --git a/security/integrity/ima/ima_init.c b/security/integrity/ima/ima_init.c
index 29b72cd2502e..fda38b6c3ab3 100644
--- a/security/integrity/ima/ima_init.c
+++ b/security/integrity/ima/ima_init.c
@@ -122,6 +122,10 @@ int __init ima_init(void)
 	if (rc)
 		return rc;
 
+	rc = integrity_load_keyring(INTEGRITY_KEYRING_PLATFORM);
+	if (rc)
+		pr_info("Platform keyring is not found. (rc=%d)\n", rc);
+
 	rc = ima_init_crypto();
 	if (rc)
 		return rc;
diff --git a/security/integrity/integrity.h b/security/integrity/integrity.h
index 50a8e3365df7..d0aeb6a39036 100644
--- a/security/integrity/integrity.h
+++ b/security/integrity/integrity.h
@@ -136,13 +136,23 @@ int integrity_kernel_read(struct file *file, loff_t offset,
 #define INTEGRITY_KEYRING_EVM		0
 #define INTEGRITY_KEYRING_IMA		1
 #define INTEGRITY_KEYRING_MODULE	2
-#define INTEGRITY_KEYRING_MAX		3
+#define INTEGRITY_KEYRING_PLATFORM	3
+#define INTEGRITY_KEYRING_MAX		4
 
 #ifdef CONFIG_INTEGRITY_SIGNATURE
 
 int integrity_digsig_verify(const unsigned int id, const char *sig, int siglen,
 			    const char *digest, int digestlen);
 
+#ifdef CONFIG_IMA_USE_PLATFORM_KEYRING
+int __init integrity_load_keyring(const unsigned int id);
+#else
+static inline int __init integrity_load_keyring(const unsigned int id)
+{
+	return 0;
+}
+#endif
+
 int __init integrity_init_keyring(const unsigned int id);
 int __init integrity_load_x509(const unsigned int id, const char *path);
 #else
@@ -154,6 +164,11 @@ static inline int integrity_digsig_verify(const unsigned int id,
 	return -EOPNOTSUPP;
 }
 
+static inline int __init integrity_load_keyring(const unsigned int id)
+{
+	return 0;
+}
+
 static inline int integrity_init_keyring(const unsigned int id)
 {
 	return 0;
-- 
2.13.6
