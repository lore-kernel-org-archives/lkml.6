Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BA6EC65BAE
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 17:43:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FEB921473
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 17:43:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FEB921473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728974AbeJFAnT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 20:43:19 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:52716 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728876AbeJFAnT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 20:43:19 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w95HdQbW114239
        for <linux-kernel@vger.kernel.org>; Fri, 5 Oct 2018 13:43:33 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2mx9wr85nq-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 05 Oct 2018 13:43:32 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <nayna@linux.vnet.ibm.com>;
        Fri, 5 Oct 2018 18:43:31 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 5 Oct 2018 18:43:28 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w95HhQTE56230062
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 5 Oct 2018 17:43:26 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 87E1211C04C;
        Fri,  5 Oct 2018 20:43:02 +0100 (BST)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5A6F811C04A;
        Fri,  5 Oct 2018 20:42:59 +0100 (BST)
Received: from swastik.in.ibm.com (unknown [9.124.221.60])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  5 Oct 2018 20:42:59 +0100 (BST)
From:   Nayna Jain <nayna@linux.vnet.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     zohar@linux.ibm.com, linux-security-module@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        dhowells@redhat.com, jforbes@redhat.com,
        seth.forshee@canonical.com, kexec@lists.infradead.org,
        Nayna Jain <nayna@linux.ibm.com>
Subject: [PATCH v5 1/5] x86/ima: define arch_ima_get_secureboot
Date:   Fri,  5 Oct 2018 23:10:11 +0530
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20181005174015.21939-1-nayna@linux.vnet.ibm.com>
References: <20181005174015.21939-1-nayna@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18100517-0008-0000-0000-0000027B88D5
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18100517-0009-0000-0000-000021E4B4CC
Message-Id: <20181005174015.21939-2-nayna@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-05_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1810050174
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nayna Jain <nayna@linux.ibm.com>

Distros are concerned about totally disabling the kexec_load syscall.
As a compromise, the kexec_load syscall will only be disabled when
CONFIG_KEXEC_VERIFY_SIG is configured and the system is booted with
secureboot enabled.

This patch defines the new arch specific function called
arch_ima_get_secureboot() to retrieve the secureboot state of the system.

Signed-off-by: Nayna Jain <nayna@linux.ibm.com>
Suggested-by: Seth Forshee <seth.forshee@canonical.com>
---
 arch/x86/kernel/Makefile   |  2 ++
 arch/x86/kernel/ima_arch.c | 17 +++++++++++++++++
 include/linux/ima.h        |  9 +++++++++
 3 files changed, 28 insertions(+)
 create mode 100644 arch/x86/kernel/ima_arch.c

diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index 02d6f5cf4e70..f32406e51424 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -149,3 +149,5 @@ ifeq ($(CONFIG_X86_64),y)
 	obj-$(CONFIG_MMCONF_FAM10H)	+= mmconf-fam10h_64.o
 	obj-y				+= vsmp_64.o
 endif
+
+obj-$(CONFIG_IMA)			+= ima_arch.o
diff --git a/arch/x86/kernel/ima_arch.c b/arch/x86/kernel/ima_arch.c
new file mode 100644
index 000000000000..bb5a88d2b271
--- /dev/null
+++ b/arch/x86/kernel/ima_arch.c
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (C) 2018 IBM Corporation
+ */
+#include <linux/efi.h>
+#include <linux/ima.h>
+
+extern struct boot_params boot_params;
+
+bool arch_ima_get_secureboot(void)
+{
+	if (efi_enabled(EFI_BOOT) &&
+		(boot_params.secure_boot == efi_secureboot_mode_enabled))
+		return true;
+	else
+		return false;
+}
diff --git a/include/linux/ima.h b/include/linux/ima.h
index 84806b54b50a..4852255aa4f4 100644
--- a/include/linux/ima.h
+++ b/include/linux/ima.h
@@ -30,6 +30,15 @@ extern void ima_post_path_mknod(struct dentry *dentry);
 extern void ima_add_kexec_buffer(struct kimage *image);
 #endif
 
+#ifdef CONFIG_X86
+extern bool arch_ima_get_secureboot(void);
+#else
+static inline bool arch_ima_get_secureboot(void)
+{
+	return false;
+}
+#endif
+
 #else
 static inline int ima_bprm_check(struct linux_binprm *bprm)
 {
-- 
2.13.6

