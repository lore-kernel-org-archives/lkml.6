Return-Path: <SRS0=bZNE=OE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF530C18DF5
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 15:18:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 857B620865
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 15:18:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 857B620865
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726656AbeKZCKD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Nov 2018 21:10:03 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:32804 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726580AbeKZCKB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Nov 2018 21:10:01 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wAPFEb8N057466
        for <linux-kernel@vger.kernel.org>; Sun, 25 Nov 2018 10:18:44 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2nymdv78wd-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Sun, 25 Nov 2018 10:18:44 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <nayna@linux.ibm.com>;
        Sun, 25 Nov 2018 15:18:42 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sun, 25 Nov 2018 15:18:38 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wAPFIb1H55377972
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 25 Nov 2018 15:18:37 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 28DBC4C058;
        Sun, 25 Nov 2018 15:18:37 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BE8954C040;
        Sun, 25 Nov 2018 15:18:33 +0000 (GMT)
Received: from swastik.ibmuc.com (unknown [9.85.72.131])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Sun, 25 Nov 2018 15:18:33 +0000 (GMT)
From:   Nayna Jain <nayna@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     linux-security-module@vger.kernel.org, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org, zohar@linux.ibm.com,
        dhowells@redhat.com, jforbes@redhat.com,
        seth.forshee@canonical.com, kexec@lists.infradead.org,
        keyrings@vger.kernel.org, vgoyal@redhat.com, ebiederm@xmission.com,
        mpe@ellerman.id.au, Nayna Jain <nayna@linux.ibm.com>
Subject: [PATCH 2/7] integrity: Load certs to the platform keyring
Date:   Sun, 25 Nov 2018 20:44:55 +0530
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20181125151500.8298-1-nayna@linux.ibm.com>
References: <20181125151500.8298-1-nayna@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18112515-0012-0000-0000-000002CFEAE1
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18112515-0013-0000-0000-000021052447
Message-Id: <20181125151500.8298-3-nayna@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-25_14:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1811250071
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch refactors integrity_load_x509(), making it a wrapper for a new
function named integrity_add_key(). This patch also defines a new
function named integrity_load_cert() for loading the platform keys.

Signed-off-by: Nayna Jain <nayna@linux.ibm.com>
Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
---
 security/integrity/digsig.c                        | 71 ++++++++++++++--------
 security/integrity/integrity.h                     | 20 ++++++
 .../integrity/platform_certs/platform_keyring.c    | 23 +++++++
 3 files changed, 90 insertions(+), 24 deletions(-)

diff --git a/security/integrity/digsig.c b/security/integrity/digsig.c
index fef2a858300c..ab30c451a19b 100644
--- a/security/integrity/digsig.c
+++ b/security/integrity/digsig.c
@@ -82,8 +82,7 @@ static int __integrity_init_keyring(const unsigned int id, key_perm_t perm,
 
 	keyring[id] = keyring_alloc(keyring_name[id], KUIDT_INIT(0),
 				    KGIDT_INIT(0), cred, perm,
-				    KEY_ALLOC_NOT_IN_QUOTA,
-				    restriction, NULL);
+				    KEY_ALLOC_NOT_IN_QUOTA, restriction, NULL);
 	if (IS_ERR(keyring[id])) {
 		err = PTR_ERR(keyring[id]);
 		pr_info("Can't allocate %s keyring (%d)\n",
@@ -124,16 +123,38 @@ int __init integrity_init_keyring(const unsigned int id)
 	return err;
 }
 
-int __init integrity_load_x509(const unsigned int id, const char *path)
+int __init integrity_add_key(const unsigned int id, const void *data,
+			     off_t size, key_perm_t perm)
 {
 	key_ref_t key;
-	void *data;
-	loff_t size;
-	int rc;
+	int rc = 0;
 
 	if (!keyring[id])
 		return -EINVAL;
 
+	key = key_create_or_update(make_key_ref(keyring[id], 1), "asymmetric",
+				   NULL, data, size, perm,
+				   KEY_ALLOC_NOT_IN_QUOTA);
+	if (IS_ERR(key)) {
+		rc = PTR_ERR(key);
+		pr_err("Problem loading X.509 certificate %d\n", rc);
+	} else {
+		pr_notice("Loaded X.509 cert '%s'\n",
+			  key_ref_to_ptr(key)->description);
+		key_ref_put(key);
+	}
+
+	return rc;
+
+}
+
+int __init integrity_load_x509(const unsigned int id, const char *path)
+{
+	void *data;
+	loff_t size;
+	int rc;
+	key_perm_t perm;
+
 	rc = kernel_read_file_from_path(path, &data, &size, 0,
 					READING_X509_CERTIFICATE);
 	if (rc < 0) {
@@ -141,23 +162,25 @@ int __init integrity_load_x509(const unsigned int id, const char *path)
 		return rc;
 	}
 
-	key = key_create_or_update(make_key_ref(keyring[id], 1),
-				   "asymmetric",
-				   NULL,
-				   data,
-				   size,
-				   ((KEY_POS_ALL & ~KEY_POS_SETATTR) |
-				    KEY_USR_VIEW | KEY_USR_READ),
-				   KEY_ALLOC_NOT_IN_QUOTA);
-	if (IS_ERR(key)) {
-		rc = PTR_ERR(key);
-		pr_err("Problem loading X.509 certificate (%d): %s\n",
-		       rc, path);
-	} else {
-		pr_notice("Loaded X.509 cert '%s': %s\n",
-			  key_ref_to_ptr(key)->description, path);
-		key_ref_put(key);
-	}
+	perm = (KEY_POS_ALL & ~KEY_POS_SETATTR) | KEY_USR_VIEW | KEY_USR_READ;
+
+	pr_info("Loading X.509 certificate: %s\n", path);
+	rc = integrity_add_key(id, (const void *)data, size, perm);
+
 	vfree(data);
-	return 0;
+	return rc;
+}
+
+int __init integrity_load_cert(const unsigned int id, const char *source,
+			       const void *data, size_t len, key_perm_t perm)
+{
+	int rc;
+
+	if (!data)
+		return -EINVAL;
+
+	pr_info("Loading X.509 certificate: %s\n", source);
+	rc = integrity_add_key(id, data, len, perm);
+
+	return rc;
 }
diff --git a/security/integrity/integrity.h b/security/integrity/integrity.h
index c2332a44799e..3517d2852a07 100644
--- a/security/integrity/integrity.h
+++ b/security/integrity/integrity.h
@@ -154,6 +154,8 @@ int integrity_digsig_verify(const unsigned int id, const char *sig, int siglen,
 
 int __init integrity_init_keyring(const unsigned int id);
 int __init integrity_load_x509(const unsigned int id, const char *path);
+int __init integrity_load_cert(const unsigned int id, const char *source,
+			       const void *data, size_t len, key_perm_t perm);
 #else
 
 static inline int integrity_digsig_verify(const unsigned int id,
@@ -167,6 +169,14 @@ static inline int integrity_init_keyring(const unsigned int id)
 {
 	return 0;
 }
+
+static inline int __init integrity_load_cert(const unsigned int id,
+					     const char *source,
+					     const void *data, size_t len,
+					     key_perm_t perm)
+{
+	return 0;
+}
 #endif /* CONFIG_INTEGRITY_SIGNATURE */
 
 #ifdef CONFIG_INTEGRITY_ASYMMETRIC_KEYS
@@ -223,3 +233,13 @@ integrity_audit_log_start(struct audit_context *ctx, gfp_t gfp_mask, int type)
 }
 
 #endif
+
+#ifdef CONFIG_INTEGRITY_PLATFORM_KEYRING
+void __init add_to_platform_keyring(const char *source, const void *data,
+				    size_t len);
+#else
+static inline void __init add_to_platform_keyring(const char *source,
+						  const void *data, size_t len)
+{
+}
+#endif
diff --git a/security/integrity/platform_certs/platform_keyring.c b/security/integrity/platform_certs/platform_keyring.c
index dfc206bbe2ff..dc49b3b02697 100644
--- a/security/integrity/platform_certs/platform_keyring.c
+++ b/security/integrity/platform_certs/platform_keyring.c
@@ -18,6 +18,29 @@
 #include <linux/slab.h>
 #include "../integrity.h"
 
+/**
+ * add_to_platform_keyring - Add to platform keyring without validation.
+ * @source: Source of key
+ * @data: The blob holding the key
+ * @len: The length of the data blob
+ *
+ * Add a key to the platform keyring without checking its trust chain.  This
+ * is available only during kernel initialisation.
+ */
+void __init add_to_platform_keyring(const char *source, const void *data,
+				    size_t len)
+{
+	key_perm_t perm;
+	int rc;
+
+	perm = (KEY_POS_ALL & ~KEY_POS_SETATTR) | KEY_USR_VIEW;
+
+	rc = integrity_load_cert(INTEGRITY_KEYRING_PLATFORM, source, data, len,
+				 perm);
+	if (rc)
+		pr_info("Error adding keys to platform keyring %s\n", source);
+}
+
 /*
  * Create the trusted keyrings.
  */
-- 
2.13.6

