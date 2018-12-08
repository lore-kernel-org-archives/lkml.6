Return-Path: <SRS0=1bfu=OR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47320C04EB8
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 20:31:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18B502082D
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 20:31:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18B502082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726317AbeLHUbA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Dec 2018 15:31:00 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:49936 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726310AbeLHUa5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Dec 2018 15:30:57 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wB8KTBYX038292
        for <linux-kernel@vger.kernel.org>; Sat, 8 Dec 2018 15:30:56 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2p8ax58nba-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Sat, 08 Dec 2018 15:30:56 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <nayna@linux.ibm.com>;
        Sat, 8 Dec 2018 20:30:53 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sat, 8 Dec 2018 20:30:49 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wB8KUmgc55312462
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sat, 8 Dec 2018 20:30:49 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D15A34C040;
        Sat,  8 Dec 2018 20:30:48 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BDB7F4C050;
        Sat,  8 Dec 2018 20:30:45 +0000 (GMT)
Received: from swastik.ibmuc.com (unknown [9.85.68.82])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Sat,  8 Dec 2018 20:30:45 +0000 (GMT)
From:   Nayna Jain <nayna@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     linux-security-module@vger.kernel.org, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org, zohar@linux.ibm.com,
        dhowells@redhat.com, jforbes@redhat.com,
        seth.forshee@canonical.com, kexec@lists.infradead.org,
        keyrings@vger.kernel.org, vgoyal@redhat.com, ebiederm@xmission.com,
        mpe@ellerman.id.au
Subject: [PATCH v2 3/7] efi: Add EFI signature data types
Date:   Sun,  9 Dec 2018 01:57:01 +0530
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20181208202705.18673-1-nayna@linux.ibm.com>
References: <20181208202705.18673-1-nayna@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18120820-0012-0000-0000-000002D67D11
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18120820-0013-0000-0000-0000210BEAF3
Message-Id: <20181208202705.18673-4-nayna@linux.ibm.com>
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

From: Dave Howells <dhowells@redhat.com>

Add the data types that are used for containing hashes, keys and
certificates for cryptographic verification along with their corresponding
type GUIDs.

Signed-off-by: David Howells <dhowells@redhat.com>
Acked-by: Nayna Jain <nayna@linux.ibm.com>
Acked-by: Serge Hallyn <serge@hallyn.com>
---
Changelog:

v0:
- No changes

 include/linux/efi.h | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/include/linux/efi.h b/include/linux/efi.h
index 845174e113ce..214516b29b36 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -663,6 +663,10 @@ void efi_native_runtime_setup(void);
 #define EFI_IMAGE_SECURITY_DATABASE_GUID	EFI_GUID(0xd719b2cb, 0x3d3a, 0x4596,  0xa3, 0xbc, 0xda, 0xd0, 0x0e, 0x67, 0x65, 0x6f)
 #define EFI_SHIM_LOCK_GUID			EFI_GUID(0x605dab50, 0xe046, 0x4300,  0xab, 0xb6, 0x3d, 0xd8, 0x10, 0xdd, 0x8b, 0x23)
 
+#define EFI_CERT_SHA256_GUID			EFI_GUID(0xc1c41626, 0x504c, 0x4092, 0xac, 0xa9, 0x41, 0xf9, 0x36, 0x93, 0x43, 0x28)
+#define EFI_CERT_X509_GUID			EFI_GUID(0xa5c059a1, 0x94e4, 0x4aa7, 0x87, 0xb5, 0xab, 0x15, 0x5c, 0x2b, 0xf0, 0x72)
+#define EFI_CERT_X509_SHA256_GUID		EFI_GUID(0x3bd2a492, 0x96c0, 0x4079, 0xb4, 0x20, 0xfc, 0xf9, 0x8e, 0xf1, 0x03, 0xed)
+
 /*
  * This GUID is used to pass to the kernel proper the struct screen_info
  * structure that was populated by the stub based on the GOP protocol instance
@@ -934,6 +938,27 @@ typedef struct {
 	efi_memory_desc_t entry[0];
 } efi_memory_attributes_table_t;
 
+typedef struct  {
+	efi_guid_t signature_owner;
+	u8 signature_data[];
+} efi_signature_data_t;
+
+typedef struct {
+	efi_guid_t signature_type;
+	u32 signature_list_size;
+	u32 signature_header_size;
+	u32 signature_size;
+	u8 signature_header[];
+	/* efi_signature_data_t signatures[][] */
+} efi_signature_list_t;
+
+typedef u8 efi_sha256_hash_t[32];
+
+typedef struct {
+	efi_sha256_hash_t to_be_signed_hash;
+	efi_time_t time_of_revocation;
+} efi_cert_x509_sha256_t;
+
 /*
  * All runtime access to EFI goes through this structure:
  */
-- 
2.13.6

