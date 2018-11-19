Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19B6FC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 19:56:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D283D20831
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 19:56:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D283D20831
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730726AbeKTGVr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 01:21:47 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:42990 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730687AbeKTGVq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 01:21:46 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wAJJsSdM004946
        for <linux-kernel@vger.kernel.org>; Mon, 19 Nov 2018 14:56:36 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2nv0qbqy98-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 19 Nov 2018 14:56:35 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <zohar@linux.ibm.com>;
        Mon, 19 Nov 2018 19:56:34 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 19 Nov 2018 19:56:30 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wAJJuSk67930206
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 19 Nov 2018 19:56:28 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B3E04A4054;
        Mon, 19 Nov 2018 19:56:28 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8BB4FA405C;
        Mon, 19 Nov 2018 19:56:27 +0000 (GMT)
Received: from dhcp-9-31-102-82.watson.ibm.com (unknown [9.31.102.82])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 19 Nov 2018 19:56:27 +0000 (GMT)
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        linux-security-module@vger.kernel.org, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org, dhowells@redhat.com,
        jforbes@redhat.com, seth.forshee@canonical.com,
        kexec@lists.infradead.org, Nayna Jain <nayna@linux.ibm.com>
Subject: [PATCH 3/3] x86/ima: retry detecting secure boot mode
Date:   Mon, 19 Nov 2018 14:56:11 -0500
X-Mailer: git-send-email 2.7.5
In-Reply-To: <1542657371-7019-1-git-send-email-zohar@linux.ibm.com>
References: <1542657371-7019-1-git-send-email-zohar@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18111919-0020-0000-0000-000002EA70BE
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18111919-0021-0000-0000-000021399F03
Message-Id: <1542657371-7019-4-git-send-email-zohar@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-19_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=5 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=883 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1811190178
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The secure boot mode may not be detected on boot for some reason (eg.
buggy firmware).  This patch attempts one more time to detect the
secure boot mode.

Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
 arch/x86/kernel/Makefile   |  2 ++
 arch/x86/kernel/ima_arch.c | 46 ++++++++++++++++++++++++++++++++++++++++++++--
 include/linux/ima.h        |  2 +-
 3 files changed, 47 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index f0910a1e1db7..eb51b0e1189c 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -151,4 +151,6 @@ ifeq ($(CONFIG_X86_64),y)
 	obj-y				+= vsmp_64.o
 endif
 
+ifdef CONFIG_EFI
 obj-$(CONFIG_IMA)			+= ima_arch.o
+endif
diff --git a/arch/x86/kernel/ima_arch.c b/arch/x86/kernel/ima_arch.c
index 6c248616ee57..e47cd9390ab4 100644
--- a/arch/x86/kernel/ima_arch.c
+++ b/arch/x86/kernel/ima_arch.c
@@ -7,10 +7,52 @@
 
 extern struct boot_params boot_params;
 
+static enum efi_secureboot_mode get_sb_mode(void)
+{
+	efi_char16_t efi_SecureBoot_name[] = L"SecureBoot";
+	efi_guid_t efi_variable_guid = EFI_GLOBAL_VARIABLE_GUID;
+	efi_status_t status;
+	unsigned long size;
+	u8 secboot;
+
+	size = sizeof(secboot);
+
+	/* Get variable contents into buffer */
+	status = efi.get_variable(efi_SecureBoot_name, &efi_variable_guid,
+				  NULL, &size, &secboot);
+	if (status == EFI_NOT_FOUND) {
+		pr_info("ima: secureboot mode disabled\n");
+		return efi_secureboot_mode_disabled;
+	}
+
+	if (status != EFI_SUCCESS) {
+		pr_info("ima: secureboot mode unknown\n");
+		return efi_secureboot_mode_unknown;
+	}
+
+	if (secboot == 0) {
+		pr_info("ima: secureboot mode disabled\n");
+		return efi_secureboot_mode_disabled;
+	}
+
+	pr_info("ima: secureboot mode enabled\n");
+	return efi_secureboot_mode_enabled;
+}
+
 bool arch_ima_get_secureboot(void)
 {
-	if (efi_enabled(EFI_BOOT) &&
-		(boot_params.secure_boot == efi_secureboot_mode_enabled))
+	static enum efi_secureboot_mode sb_mode;
+	static bool initialized;
+
+	if (!initialized && efi_enabled(EFI_BOOT)) {
+		sb_mode = boot_params.secure_boot;
+
+		if (sb_mode == efi_secureboot_mode_unset)
+			sb_mode = get_sb_mode();
+		initialized = true;
+	}
+
+	if (sb_mode == efi_secureboot_mode_enabled)
 		return true;
 	else
 		return false;
diff --git a/include/linux/ima.h b/include/linux/ima.h
index 5ab9134d4fd7..b5e16b8c50b7 100644
--- a/include/linux/ima.h
+++ b/include/linux/ima.h
@@ -30,7 +30,7 @@ extern void ima_post_path_mknod(struct dentry *dentry);
 extern void ima_add_kexec_buffer(struct kimage *image);
 #endif
 
-#ifdef CONFIG_X86
+#if defined(CONFIG_X86) && defined(CONFIG_EFI)
 extern bool arch_ima_get_secureboot(void);
 extern const char * const *arch_get_ima_policy(void);
 #else
-- 
2.7.5

