Return-Path: <SRS0=1bfu=OR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	URIBL_SBL,URIBL_SBL_A,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 349A7C65BAF
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 20:31:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 052F62082D
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 20:31:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 052F62082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726370AbeLHUbQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Dec 2018 15:31:16 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:56668 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726357AbeLHUbO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Dec 2018 15:31:14 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wB8KTDh8030654
        for <linux-kernel@vger.kernel.org>; Sat, 8 Dec 2018 15:31:13 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2p895tcc8f-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Sat, 08 Dec 2018 15:31:13 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <nayna@linux.ibm.com>;
        Sat, 8 Dec 2018 20:31:10 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sat, 8 Dec 2018 20:31:06 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wB8KV53B45744276
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sat, 8 Dec 2018 20:31:06 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D017D4C044;
        Sat,  8 Dec 2018 20:31:05 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8B07F4C040;
        Sat,  8 Dec 2018 20:31:02 +0000 (GMT)
Received: from swastik.ibmuc.com (unknown [9.85.68.82])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Sat,  8 Dec 2018 20:31:02 +0000 (GMT)
From:   Nayna Jain <nayna@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     linux-security-module@vger.kernel.org, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org, zohar@linux.ibm.com,
        dhowells@redhat.com, jforbes@redhat.com,
        seth.forshee@canonical.com, kexec@lists.infradead.org,
        keyrings@vger.kernel.org, vgoyal@redhat.com, ebiederm@xmission.com,
        mpe@ellerman.id.au, Josh Boyer <jwboyer@fedoraproject.org>
Subject: [PATCH v2 6/7] efi: Allow the "db" UEFI variable to be suppressed
Date:   Sun,  9 Dec 2018 01:57:04 +0530
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20181208202705.18673-1-nayna@linux.ibm.com>
References: <20181208202705.18673-1-nayna@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18120820-0012-0000-0000-000002D67D1A
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18120820-0013-0000-0000-0000210BEAFD
Message-Id: <20181208202705.18673-7-nayna@linux.ibm.com>
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

If a user tells shim to not use the certs/hashes in the UEFI db variable
for verification purposes, shim will set a UEFI variable called
MokIgnoreDB. Have the uefi import code look for this and ignore the db
variable if it is found.

Signed-off-by: Josh Boyer <jwboyer@fedoraproject.org>
Signed-off-by: David Howells <dhowells@redhat.com>
Acked-by: Nayna Jain <nayna@linux.ibm.com>
Acked-by: Serge Hallyn <serge@hallyn.com>
---
Changelog:

v0:
- No changes

v2:
- Fixed the checkpatch.pl warnings

 security/integrity/platform_certs/load_uefi.c | 45 +++++++++++++++++++++------
 1 file changed, 35 insertions(+), 10 deletions(-)

diff --git a/security/integrity/platform_certs/load_uefi.c b/security/integrity/platform_certs/load_uefi.c
index acd9db90dde7..8bd2e9b421e1 100644
--- a/security/integrity/platform_certs/load_uefi.c
+++ b/security/integrity/platform_certs/load_uefi.c
@@ -16,6 +16,26 @@ static efi_guid_t efi_cert_x509_sha256_guid __initdata =
 static efi_guid_t efi_cert_sha256_guid __initdata = EFI_CERT_SHA256_GUID;
 
 /*
+ * Look to see if a UEFI variable called MokIgnoreDB exists and return true if
+ * it does.
+ *
+ * This UEFI variable is set by the shim if a user tells the shim to not use
+ * the certs/hashes in the UEFI db variable for verification purposes.  If it
+ * is set, we should ignore the db variable also and the true return indicates
+ * this.
+ */
+static __init bool uefi_check_ignore_db(void)
+{
+	efi_status_t status;
+	unsigned int db = 0;
+	unsigned long size = sizeof(db);
+	efi_guid_t guid = EFI_SHIM_LOCK_GUID;
+
+	status = efi.get_variable(L"MokIgnoreDB", &guid, NULL, &size, &db);
+	return status == EFI_SUCCESS;
+}
+
+/*
  * Get a certificate list blob from the named EFI variable.
  */
 static __init void *get_cert_list(efi_char16_t *name, efi_guid_t *guid,
@@ -116,7 +136,9 @@ static __init efi_element_handler_t get_handler_for_dbx(const efi_guid_t *
 }
 
 /*
- * Load the certs contained in the UEFI databases
+ * Load the certs contained in the UEFI databases into the secondary trusted
+ * keyring and the UEFI blacklisted X.509 cert SHA256 hashes into the blacklist
+ * keyring.
  */
 static int __init load_uefi_certs(void)
 {
@@ -132,15 +154,18 @@ static int __init load_uefi_certs(void)
 	/* Get db, MokListRT, and dbx.  They might not exist, so it isn't
 	 * an error if we can't get them.
 	 */
-	db = get_cert_list(L"db", &secure_var, &dbsize);
-	if (!db) {
-		pr_err("Couldn't get UEFI db list\n");
-	} else {
-		rc = parse_efi_signature_list("UEFI:db",
-					      db, dbsize, get_handler_for_db);
-		if (rc)
-			pr_err("Couldn't parse db signatures: %d\n", rc);
-		kfree(db);
+	if (!uefi_check_ignore_db()) {
+		db = get_cert_list(L"db", &secure_var, &dbsize);
+		if (!db) {
+			pr_err("MODSIGN: Couldn't get UEFI db list\n");
+		} else {
+			rc = parse_efi_signature_list("UEFI:db",
+					db, dbsize, get_handler_for_db);
+			if (rc)
+				pr_err("Couldn't parse db signatures: %d\n",
+				       rc);
+			kfree(db);
+		}
 	}
 
 	mok = get_cert_list(L"MokListRT", &mok_var, &moksize);
-- 
2.13.6

