Return-Path: <SRS0=1bfu=OR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	URIBL_SBL,URIBL_SBL_A,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0801BC64EB1
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 20:31:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA8462082D
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 20:31:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA8462082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726354AbeLHUbL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Dec 2018 15:31:11 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:56302 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726338AbeLHUbK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Dec 2018 15:31:10 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wB8KTB1x030531
        for <linux-kernel@vger.kernel.org>; Sat, 8 Dec 2018 15:31:09 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2p895tcc71-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Sat, 08 Dec 2018 15:31:08 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <nayna@linux.ibm.com>;
        Sat, 8 Dec 2018 20:31:06 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sat, 8 Dec 2018 20:31:01 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wB8KV08f22806550
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sat, 8 Dec 2018 20:31:00 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 273874C040;
        Sat,  8 Dec 2018 20:31:00 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9A2614C04E;
        Sat,  8 Dec 2018 20:30:56 +0000 (GMT)
Received: from swastik.ibmuc.com (unknown [9.85.68.82])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Sat,  8 Dec 2018 20:30:56 +0000 (GMT)
From:   Nayna Jain <nayna@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     linux-security-module@vger.kernel.org, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org, zohar@linux.ibm.com,
        dhowells@redhat.com, jforbes@redhat.com,
        seth.forshee@canonical.com, kexec@lists.infradead.org,
        keyrings@vger.kernel.org, vgoyal@redhat.com, ebiederm@xmission.com,
        mpe@ellerman.id.au, Josh Boyer <jwboyer@fedoraproject.org>,
        Nayna Jain <nayna@linux.ibm.com>
Subject: [PATCH v2 5/7] efi: Import certificates from UEFI Secure Boot
Date:   Sun,  9 Dec 2018 01:57:03 +0530
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20181208202705.18673-1-nayna@linux.ibm.com>
References: <20181208202705.18673-1-nayna@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18120820-0012-0000-0000-000002D67D18
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18120820-0013-0000-0000-0000210BEAFC
Message-Id: <20181208202705.18673-6-nayna@linux.ibm.com>
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

From: Josh Boyer <jwboyer@fedoraproject.org>

New Patch Description:
======================

Secure Boot stores a list of allowed certificates in the 'db' variable.
This patch imports those certificates into the platform keyring. The shim
UEFI bootloader has a similar certificate list stored in the 'MokListRT'
variable. We import those as well.

Secure Boot also maintains a list of disallowed certificates in the 'dbx'
variable. We load those certificates into the system blacklist keyring
and forbid any kernel signed with those from loading.

Original Patch Description:
============================

Secure Boot stores a list of allowed certificates in the 'db' variable.
This imports those certificates into the system trusted keyring.  This
allows for a third party signing certificate to be used in conjunction
with signed modules. By importing the public certificate into the 'db'
variable, a user can allow a module signed with that certificate to
load. The shim UEFI bootloader has a similar certificate list stored
in the 'MokListRT' variable. We import those as well.

Secure Boot also maintains a list of disallowed certificates in the 'dbx'
variable. We load those certificates into the newly introduced system
blacklist keyring and forbid any module signed with those from loading and
forbid the use within the kernel of any key with a matching hash.

This facility is enabled by setting CONFIG_LOAD_UEFI_KEYS.

Signed-off-by: Josh Boyer <jwboyer@fedoraproject.org>
Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: Nayna Jain <nayna@linux.ibm.com>
Acked-by: Serge Hallyn <serge@hallyn.com>
---
Changelog:

v0:
- This patch replaces the loading of certificates onto the secondary
  keyring with platform keyring
- removed the CONFIG LOAD_UEFI_KEYS
- moved the file load_uefi.o from certs to security/integrity/platform_certs

v2:
- Fixed the checkpatch.pl warnings

 security/integrity/Makefile                   |   5 +-
 security/integrity/platform_certs/load_uefi.c | 171 ++++++++++++++++++++++++++
 2 files changed, 175 insertions(+), 1 deletion(-)
 create mode 100644 security/integrity/platform_certs/load_uefi.c

diff --git a/security/integrity/Makefile b/security/integrity/Makefile
index 6ee9058866cd..86df9aba8c0f 100644
--- a/security/integrity/Makefile
+++ b/security/integrity/Makefile
@@ -10,7 +10,10 @@ integrity-$(CONFIG_INTEGRITY_AUDIT) += integrity_audit.o
 integrity-$(CONFIG_INTEGRITY_SIGNATURE) += digsig.o
 integrity-$(CONFIG_INTEGRITY_ASYMMETRIC_KEYS) += digsig_asymmetric.o
 integrity-$(CONFIG_INTEGRITY_PLATFORM_KEYRING) += platform_certs/platform_keyring.o \
-						  platform_certs/efi_parser.o
+						  platform_certs/efi_parser.o \
+						  platform_certs/load_uefi.o
+obj-$(CONFIG_LOAD_UEFI_KEYS) += platform_certs/load_uefi.o
+$(obj)/load_uefi.o: KBUILD_CFLAGS += -fshort-wchar
 
 subdir-$(CONFIG_IMA)			+= ima
 obj-$(CONFIG_IMA)			+= ima/
diff --git a/security/integrity/platform_certs/load_uefi.c b/security/integrity/platform_certs/load_uefi.c
new file mode 100644
index 000000000000..acd9db90dde7
--- /dev/null
+++ b/security/integrity/platform_certs/load_uefi.c
@@ -0,0 +1,171 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/kernel.h>
+#include <linux/sched.h>
+#include <linux/cred.h>
+#include <linux/err.h>
+#include <linux/efi.h>
+#include <linux/slab.h>
+#include <keys/asymmetric-type.h>
+#include <keys/system_keyring.h>
+#include "../integrity.h"
+
+static efi_guid_t efi_cert_x509_guid __initdata = EFI_CERT_X509_GUID;
+static efi_guid_t efi_cert_x509_sha256_guid __initdata =
+	EFI_CERT_X509_SHA256_GUID;
+static efi_guid_t efi_cert_sha256_guid __initdata = EFI_CERT_SHA256_GUID;
+
+/*
+ * Get a certificate list blob from the named EFI variable.
+ */
+static __init void *get_cert_list(efi_char16_t *name, efi_guid_t *guid,
+				  unsigned long *size)
+{
+	efi_status_t status;
+	unsigned long lsize = 4;
+	unsigned long tmpdb[4];
+	void *db;
+
+	status = efi.get_variable(name, guid, NULL, &lsize, &tmpdb);
+	if (status != EFI_BUFFER_TOO_SMALL) {
+		pr_err("Couldn't get size: 0x%lx\n", status);
+		return NULL;
+	}
+
+	db = kmalloc(lsize, GFP_KERNEL);
+	if (!db)
+		return NULL;
+
+	status = efi.get_variable(name, guid, NULL, &lsize, db);
+	if (status != EFI_SUCCESS) {
+		kfree(db);
+		pr_err("Error reading db var: 0x%lx\n", status);
+		return NULL;
+	}
+
+	*size = lsize;
+	return db;
+}
+
+/*
+ * Blacklist an X509 TBS hash.
+ */
+static __init void uefi_blacklist_x509_tbs(const char *source,
+					   const void *data, size_t len)
+{
+	char *hash, *p;
+
+	hash = kmalloc(4 + len * 2 + 1, GFP_KERNEL);
+	if (!hash)
+		return;
+	p = memcpy(hash, "tbs:", 4);
+	p += 4;
+	bin2hex(p, data, len);
+	p += len * 2;
+	*p = 0;
+
+	mark_hash_blacklisted(hash);
+	kfree(hash);
+}
+
+/*
+ * Blacklist the hash of an executable.
+ */
+static __init void uefi_blacklist_binary(const char *source,
+					 const void *data, size_t len)
+{
+	char *hash, *p;
+
+	hash = kmalloc(4 + len * 2 + 1, GFP_KERNEL);
+	if (!hash)
+		return;
+	p = memcpy(hash, "bin:", 4);
+	p += 4;
+	bin2hex(p, data, len);
+	p += len * 2;
+	*p = 0;
+
+	mark_hash_blacklisted(hash);
+	kfree(hash);
+}
+
+/*
+ * Return the appropriate handler for particular signature list types found in
+ * the UEFI db and MokListRT tables.
+ */
+static __init efi_element_handler_t get_handler_for_db(const efi_guid_t *
+						       sig_type)
+{
+	if (efi_guidcmp(*sig_type, efi_cert_x509_guid) == 0)
+		return add_to_platform_keyring;
+	return 0;
+}
+
+/*
+ * Return the appropriate handler for particular signature list types found in
+ * the UEFI dbx and MokListXRT tables.
+ */
+static __init efi_element_handler_t get_handler_for_dbx(const efi_guid_t *
+							sig_type)
+{
+	if (efi_guidcmp(*sig_type, efi_cert_x509_sha256_guid) == 0)
+		return uefi_blacklist_x509_tbs;
+	if (efi_guidcmp(*sig_type, efi_cert_sha256_guid) == 0)
+		return uefi_blacklist_binary;
+	return 0;
+}
+
+/*
+ * Load the certs contained in the UEFI databases
+ */
+static int __init load_uefi_certs(void)
+{
+	efi_guid_t secure_var = EFI_IMAGE_SECURITY_DATABASE_GUID;
+	efi_guid_t mok_var = EFI_SHIM_LOCK_GUID;
+	void *db = NULL, *dbx = NULL, *mok = NULL;
+	unsigned long dbsize = 0, dbxsize = 0, moksize = 0;
+	int rc = 0;
+
+	if (!efi.get_variable)
+		return false;
+
+	/* Get db, MokListRT, and dbx.  They might not exist, so it isn't
+	 * an error if we can't get them.
+	 */
+	db = get_cert_list(L"db", &secure_var, &dbsize);
+	if (!db) {
+		pr_err("Couldn't get UEFI db list\n");
+	} else {
+		rc = parse_efi_signature_list("UEFI:db",
+					      db, dbsize, get_handler_for_db);
+		if (rc)
+			pr_err("Couldn't parse db signatures: %d\n", rc);
+		kfree(db);
+	}
+
+	mok = get_cert_list(L"MokListRT", &mok_var, &moksize);
+	if (!mok) {
+		pr_info("Couldn't get UEFI MokListRT\n");
+	} else {
+		rc = parse_efi_signature_list("UEFI:MokListRT",
+					      mok, moksize, get_handler_for_db);
+		if (rc)
+			pr_err("Couldn't parse MokListRT signatures: %d\n", rc);
+		kfree(mok);
+	}
+
+	dbx = get_cert_list(L"dbx", &secure_var, &dbxsize);
+	if (!dbx) {
+		pr_info("Couldn't get UEFI dbx list\n");
+	} else {
+		rc = parse_efi_signature_list("UEFI:dbx",
+					      dbx, dbxsize,
+					      get_handler_for_dbx);
+		if (rc)
+			pr_err("Couldn't parse dbx signatures: %d\n", rc);
+		kfree(dbx);
+	}
+
+	return rc;
+}
+late_initcall(load_uefi_certs);
-- 
2.13.6

