Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAE18C6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 23:32:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 691DD20685
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 23:32:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 691DD20685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731866AbeGZAqW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 20:46:22 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:59458 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731852AbeGZAqU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 20:46:20 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6PNTU9T095361
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jul 2018 19:32:22 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2kf1a7b5tv-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jul 2018 19:32:21 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <erichte@linux.vnet.ibm.com>;
        Thu, 26 Jul 2018 00:32:20 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 26 Jul 2018 00:32:15 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w6PNWEDd42991802
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 25 Jul 2018 23:32:14 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 24862AE04D;
        Thu, 26 Jul 2018 02:32:22 +0100 (BST)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C4E2AAE045;
        Thu, 26 Jul 2018 02:32:20 +0100 (BST)
Received: from yorha.ibmmodules.com (unknown [9.80.225.100])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 26 Jul 2018 02:32:20 +0100 (BST)
From:   Eric Richter <erichte@linux.vnet.ibm.com>
To:     linux-integrity <linux-integrity@vger.kernel.org>
Cc:     linux-security-module <linux-security-module@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Seth Forshee <seth.forshee@canonical.com>,
        Justin Forbes <jforbes@redhat.com>,
        Eric Richter <erichte@linux.vnet.ibm.com>
Subject: [PATCH 4/4] x86/ima: define arch_get_ima_policy() for x86
Date:   Wed, 25 Jul 2018 18:32:00 -0500
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180725233200.761-1-erichte@linux.vnet.ibm.com>
References: <20180725233200.761-1-erichte@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18072523-0012-0000-0000-0000028ED4F4
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18072523-0013-0000-0000-000020C0BE99
Message-Id: <20180725233200.761-5-erichte@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-25_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807250240
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch implements an example arch-specific IMA policy for x86 to enable
measurement and appraisal of any kernel images loaded for kexec, and
disables the kexec_load syscall.

To avoid conflicting with the existing CONFIG_KERNEL_VERIFY_SIG option, the
policy only "appraises" the target image on kexec_load. Without this, the
target kexec image would have to be verified by both the above option as
well as by IMA appraisal.

Since signature verification for kexec_load is not possible via appraisal
(or VERIFY_SIG), this results in a failure and thus effectively prevents
the kexec_load syscall from succeeding when set.

Signed-off-by: Eric Richter <erichte@linux.vnet.ibm.com>
---
 arch/x86/kernel/Makefile       |  2 ++
 arch/x86/kernel/ima_arch.c     | 27 +++++++++++++++++++++++++++
 include/linux/ima.h            |  8 ++++++++
 security/integrity/ima/Kconfig |  8 ++++++++
 4 files changed, 45 insertions(+)
 create mode 100644 arch/x86/kernel/ima_arch.c

diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index 02d6f5cf4e7..f3e1d76ed9b 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -149,3 +149,5 @@ ifeq ($(CONFIG_X86_64),y)
 	obj-$(CONFIG_MMCONF_FAM10H)	+= mmconf-fam10h_64.o
 	obj-y				+= vsmp_64.o
 endif
+
+obj-$(CONFIG_IMA_ARCH_POLICY) += ima_arch.o
diff --git a/arch/x86/kernel/ima_arch.c b/arch/x86/kernel/ima_arch.c
new file mode 100644
index 00000000000..5eb10e29db0
--- /dev/null
+++ b/arch/x86/kernel/ima_arch.c
@@ -0,0 +1,27 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (C) 2018 IBM Corporation
+ */
+#include <linux/efi.h>
+#include <linux/ima.h>
+
+extern struct boot_params boot_params;
+
+/* arch rules for audit and user mode */
+static const char * const sb_arch_rules[] = {
+#ifdef CONFIG_KEXEC_VERIFY_SIG
+	"appraise func=KEXEC_ORIG_KERNEL_CHECK appraise_type=imasig",
+#else
+	"appraise func=KEXEC_KERNEL_CHECK appraise_type=imasig",
+#endif /* CONFIG_KEXEC_VERIFY_SIG */
+	"measure func=KEXEC_KERNEL_CHECK",
+	NULL
+};
+
+const char * const *arch_get_ima_policy(void)
+{
+	if (efi_enabled(EFI_BOOT) &&
+	    (boot_params.secure_boot == efi_secureboot_mode_enabled))
+		return sb_arch_rules;
+	return NULL;
+}
diff --git a/include/linux/ima.h b/include/linux/ima.h
index 7fd272f0b1f..495fa290b14 100644
--- a/include/linux/ima.h
+++ b/include/linux/ima.h
@@ -30,10 +30,14 @@ extern void ima_post_path_mknod(struct dentry *dentry);
 extern void ima_add_kexec_buffer(struct kimage *image);
 #endif
 
+#if defined(CONFIG_IMA_ARCH_POLICY) && defined(CONFIG_X86)
+extern const char * const *arch_get_ima_policy(void);
+#else
 static inline const char * const *arch_get_ima_policy(void)
 {
 	return NULL;
 }
+#endif
 
 #else
 static inline int ima_bprm_check(struct linux_binprm *bprm)
@@ -77,6 +81,10 @@ static inline void ima_post_path_mknod(struct dentry *dentry)
 	return;
 }
 
+static inline const char * const *arch_get_ima_policy(void)
+{
+	return NULL;
+}
 #endif /* CONFIG_IMA */
 
 #ifndef CONFIG_IMA_KEXEC
diff --git a/security/integrity/ima/Kconfig b/security/integrity/ima/Kconfig
index 13b446328dd..18de132bbda 100644
--- a/security/integrity/ima/Kconfig
+++ b/security/integrity/ima/Kconfig
@@ -157,6 +157,14 @@ config IMA_APPRAISE
 	  <http://linux-ima.sourceforge.net>
 	  If unsure, say N.
 
+config IMA_ARCH_POLICY
+	bool "Enable loading an IMA architecture specific policy"
+	depends on IMA_APPRAISE && INTEGRITY_ASYMMETRIC_KEYS
+	default n
+	help
+	  This option enables loading an IMA architecture specific policy
+	  based on run time secure boot flags.
+
 config IMA_APPRAISE_BUILD_POLICY
 	bool "IMA build time configured policy rules"
 	depends on IMA_APPRAISE && INTEGRITY_ASYMMETRIC_KEYS
-- 
2.14.4

