Return-Path: <SRS0=1bfu=OR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BC22C04EB8
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 20:31:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D94272082D
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 20:31:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D94272082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726335AbeLHUbF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Dec 2018 15:31:05 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:42936 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726318AbeLHUbC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Dec 2018 15:31:02 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wB8KT1OD045310
        for <linux-kernel@vger.kernel.org>; Sat, 8 Dec 2018 15:31:01 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2p8aqg19b2-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Sat, 08 Dec 2018 15:31:01 -0500
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <nayna@linux.ibm.com>;
        Sat, 8 Dec 2018 20:30:59 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sat, 8 Dec 2018 20:30:55 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wB8KUsVu61079630
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sat, 8 Dec 2018 20:30:54 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4550B4C040;
        Sat,  8 Dec 2018 20:30:54 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F40ED4C050;
        Sat,  8 Dec 2018 20:30:50 +0000 (GMT)
Received: from swastik.ibmuc.com (unknown [9.85.68.82])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Sat,  8 Dec 2018 20:30:50 +0000 (GMT)
From:   Nayna Jain <nayna@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     linux-security-module@vger.kernel.org, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org, zohar@linux.ibm.com,
        dhowells@redhat.com, jforbes@redhat.com,
        seth.forshee@canonical.com, kexec@lists.infradead.org,
        keyrings@vger.kernel.org, vgoyal@redhat.com, ebiederm@xmission.com,
        mpe@ellerman.id.au, Nayna Jain <nayna@linux.ibm.com>
Subject: [PATCH v2 4/7] efi: Add an EFI signature blob parser
Date:   Sun,  9 Dec 2018 01:57:02 +0530
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20181208202705.18673-1-nayna@linux.ibm.com>
References: <20181208202705.18673-1-nayna@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18120820-4275-0000-0000-000002EDF2A7
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18120820-4276-0000-0000-000037FB099B
Message-Id: <20181208202705.18673-5-nayna@linux.ibm.com>
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

Add a function to parse an EFI signature blob looking for elements of
interest. A list is made up of a series of sublists, where all the
elements in a sublist are of the same type, but sublists can be of
different types.

For each sublist encountered, the function pointed to by the
get_handler_for_guid argument is called with the type specifier GUID and
returns either a pointer to a function to handle elements of that type or
NULL if the type is not of interest.

If the sublist is of interest, each element is passed to the handler
function in turn.

Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: Nayna Jain <nayna@linux.ibm.com>
Acked-by: Serge Hallyn <serge@hallyn.com>
---
Changelog:

v0:
- removed the CONFIG EFI_SIGNATURE_LIST_PARSER
- moved efi_parser.c from certs to security/integrity/platform_certs
  directory

v2:
- Fixed the checkpatch.pl warnings

 include/linux/efi.h                            |   9 +++
 security/integrity/Makefile                    |   3 +-
 security/integrity/platform_certs/efi_parser.c | 108 +++++++++++++++++++++++++
 3 files changed, 119 insertions(+), 1 deletion(-)
 create mode 100644 security/integrity/platform_certs/efi_parser.c

diff --git a/include/linux/efi.h b/include/linux/efi.h
index 214516b29b36..c3206b134137 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -1141,6 +1141,15 @@ extern int efi_memattr_apply_permissions(struct mm_struct *mm,
 char * __init efi_md_typeattr_format(char *buf, size_t size,
 				     const efi_memory_desc_t *md);
 
+
+typedef void (*efi_element_handler_t)(const char *source,
+				      const void *element_data,
+				      size_t element_size);
+extern int __init parse_efi_signature_list(
+	const char *source,
+	const void *data, size_t size,
+	efi_element_handler_t (*get_handler_for_guid)(const efi_guid_t *));
+
 /**
  * efi_range_is_wc - check the WC bit on an address range
  * @start: starting kvirt address
diff --git a/security/integrity/Makefile b/security/integrity/Makefile
index 046ffc1bb42d..6ee9058866cd 100644
--- a/security/integrity/Makefile
+++ b/security/integrity/Makefile
@@ -9,7 +9,8 @@ integrity-y := iint.o
 integrity-$(CONFIG_INTEGRITY_AUDIT) += integrity_audit.o
 integrity-$(CONFIG_INTEGRITY_SIGNATURE) += digsig.o
 integrity-$(CONFIG_INTEGRITY_ASYMMETRIC_KEYS) += digsig_asymmetric.o
-integrity-$(CONFIG_INTEGRITY_PLATFORM_KEYRING) += platform_certs/platform_keyring.o
+integrity-$(CONFIG_INTEGRITY_PLATFORM_KEYRING) += platform_certs/platform_keyring.o \
+						  platform_certs/efi_parser.o
 
 subdir-$(CONFIG_IMA)			+= ima
 obj-$(CONFIG_IMA)			+= ima/
diff --git a/security/integrity/platform_certs/efi_parser.c b/security/integrity/platform_certs/efi_parser.c
new file mode 100644
index 000000000000..18f01f36fe6a
--- /dev/null
+++ b/security/integrity/platform_certs/efi_parser.c
@@ -0,0 +1,108 @@
+// SPDX-License-Identifier: GPL-2.0+
+/* EFI signature/key/certificate list parser
+ *
+ * Copyright (C) 2012, 2016 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ */
+
+#define pr_fmt(fmt) "EFI: "fmt
+#include <linux/module.h>
+#include <linux/printk.h>
+#include <linux/err.h>
+#include <linux/efi.h>
+
+/**
+ * parse_efi_signature_list - Parse an EFI signature list for certificates
+ * @source: The source of the key
+ * @data: The data blob to parse
+ * @size: The size of the data blob
+ * @get_handler_for_guid: Get the handler func for the sig type (or NULL)
+ *
+ * Parse an EFI signature list looking for elements of interest.  A list is
+ * made up of a series of sublists, where all the elements in a sublist are of
+ * the same type, but sublists can be of different types.
+ *
+ * For each sublist encountered, the @get_handler_for_guid function is called
+ * with the type specifier GUID and returns either a pointer to a function to
+ * handle elements of that type or NULL if the type is not of interest.
+ *
+ * If the sublist is of interest, each element is passed to the handler
+ * function in turn.
+ *
+ * Error EBADMSG is returned if the list doesn't parse correctly and 0 is
+ * returned if the list was parsed correctly.  No error can be returned from
+ * the @get_handler_for_guid function or the element handler function it
+ * returns.
+ */
+int __init parse_efi_signature_list(
+	const char *source,
+	const void *data, size_t size,
+	efi_element_handler_t (*get_handler_for_guid)(const efi_guid_t *))
+{
+	efi_element_handler_t handler;
+	unsigned int offs = 0;
+
+	pr_devel("-->%s(,%zu)\n", __func__, size);
+
+	while (size > 0) {
+		const efi_signature_data_t *elem;
+		efi_signature_list_t list;
+		size_t lsize, esize, hsize, elsize;
+
+		if (size < sizeof(list))
+			return -EBADMSG;
+
+		memcpy(&list, data, sizeof(list));
+		pr_devel("LIST[%04x] guid=%pUl ls=%x hs=%x ss=%x\n",
+			 offs,
+			 list.signature_type.b, list.signature_list_size,
+			 list.signature_header_size, list.signature_size);
+
+		lsize = list.signature_list_size;
+		hsize = list.signature_header_size;
+		esize = list.signature_size;
+		elsize = lsize - sizeof(list) - hsize;
+
+		if (lsize > size) {
+			pr_devel("<--%s() = -EBADMSG [overrun @%x]\n",
+				 __func__, offs);
+			return -EBADMSG;
+		}
+
+		if (lsize < sizeof(list) ||
+		    lsize - sizeof(list) < hsize ||
+		    esize < sizeof(*elem) ||
+		    elsize < esize ||
+		    elsize % esize != 0) {
+			pr_devel("- bad size combo @%x\n", offs);
+			return -EBADMSG;
+		}
+
+		handler = get_handler_for_guid(&list.signature_type);
+		if (!handler) {
+			data += lsize;
+			size -= lsize;
+			offs += lsize;
+			continue;
+		}
+
+		data += sizeof(list) + hsize;
+		size -= sizeof(list) + hsize;
+		offs += sizeof(list) + hsize;
+
+		for (; elsize > 0; elsize -= esize) {
+			elem = data;
+
+			pr_devel("ELEM[%04x]\n", offs);
+			handler(source,
+				&elem->signature_data,
+				esize - sizeof(*elem));
+
+			data += esize;
+			size -= esize;
+			offs += esize;
+		}
+	}
+
+	return 0;
+}
-- 
2.13.6

