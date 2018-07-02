Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.1 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E16A6C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 14:39:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9ACF225427
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 14:39:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9ACF225427
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752619AbeGBOjC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 10:39:02 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:59894 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751878AbeGBOi7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 10:38:59 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w62EcZ7P185912
        for <linux-kernel@vger.kernel.org>; Mon, 2 Jul 2018 10:38:58 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2jym8fms90-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 10:38:58 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Mon, 2 Jul 2018 15:38:56 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 2 Jul 2018 15:38:52 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w62EcpVQ41615502
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 2 Jul 2018 14:38:51 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D817211C050;
        Mon,  2 Jul 2018 15:38:34 +0100 (BST)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 73BAD11C04C;
        Mon,  2 Jul 2018 15:38:33 +0100 (BST)
Received: from localhost.ibm.com (unknown [9.80.97.108])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  2 Jul 2018 15:38:33 +0100 (BST)
From:   Mimi Zohar <zohar@linux.vnet.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>,
        "Luis R . Rodriguez" <mcgrof@kernel.org>,
        Eric Biederman <ebiederm@xmission.com>,
        kexec@lists.infradead.org, Andres Rodriguez <andresx7@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH v5 3/8] ima: based on policy require signed kexec kernel images
Date:   Mon,  2 Jul 2018 10:37:58 -0400
X-Mailer: git-send-email 2.7.5
In-Reply-To: <1530542283-26145-1-git-send-email-zohar@linux.vnet.ibm.com>
References: <1530542283-26145-1-git-send-email-zohar@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18070214-0008-0000-0000-0000024ECDEE
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18070214-0009-0000-0000-000021B4D7F4
Message-Id: <1530542283-26145-4-git-send-email-zohar@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-02_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807020168
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The original kexec_load syscall can not verify file signatures, nor can
the kexec image be measured.  Based on policy, deny the kexec_load
syscall.

Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: Eric Biederman <ebiederm@xmission.com>
Cc: Luis R. Rodriguez <mcgrof@kernel.org>
Cc: Kees Cook <keescook@chromium.org>
Cc: David Howells <dhowells@redhat.com>

---
Changelog v3:
- use switch/case

 include/linux/ima.h                 |  7 +++++++
 security/integrity/ima/ima.h        |  1 +
 security/integrity/ima/ima_main.c   | 27 +++++++++++++++++++++++++++
 security/integrity/ima/ima_policy.c |  2 ++
 security/security.c                 |  7 ++++++-
 5 files changed, 43 insertions(+), 1 deletion(-)

diff --git a/include/linux/ima.h b/include/linux/ima.h
index 0e4647e0eb60..84806b54b50a 100644
--- a/include/linux/ima.h
+++ b/include/linux/ima.h
@@ -11,6 +11,7 @@
 #define _LINUX_IMA_H
 
 #include <linux/fs.h>
+#include <linux/security.h>
 #include <linux/kexec.h>
 struct linux_binprm;
 
@@ -19,6 +20,7 @@ extern int ima_bprm_check(struct linux_binprm *bprm);
 extern int ima_file_check(struct file *file, int mask, int opened);
 extern void ima_file_free(struct file *file);
 extern int ima_file_mmap(struct file *file, unsigned long prot);
+extern int ima_load_data(enum kernel_load_data_id id);
 extern int ima_read_file(struct file *file, enum kernel_read_file_id id);
 extern int ima_post_read_file(struct file *file, void *buf, loff_t size,
 			      enum kernel_read_file_id id);
@@ -49,6 +51,11 @@ static inline int ima_file_mmap(struct file *file, unsigned long prot)
 	return 0;
 }
 
+static inline int ima_load_data(enum kernel_load_data_id id)
+{
+	return 0;
+}
+
 static inline int ima_read_file(struct file *file, enum kernel_read_file_id id)
 {
 	return 0;
diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index 2ab1affffa36..588e4813370c 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -232,6 +232,7 @@ int ima_policy_show(struct seq_file *m, void *v);
 #define IMA_APPRAISE_MODULES	0x08
 #define IMA_APPRAISE_FIRMWARE	0x10
 #define IMA_APPRAISE_POLICY	0x20
+#define IMA_APPRAISE_KEXEC	0x40
 
 #ifdef CONFIG_IMA_APPRAISE
 int ima_appraise_measurement(enum ima_hooks func,
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index dca44cf7838e..71fecfef0939 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -496,6 +496,33 @@ int ima_post_read_file(struct file *file, void *buf, loff_t size,
 				   MAY_READ, func, 0);
 }
 
+/**
+ * ima_load_data - appraise decision based on policy
+ * @id: kernel load data caller identifier
+ *
+ * Callers of this LSM hook can not measure, appraise, or audit the
+ * data provided by userspace.  Enforce policy rules requring a file
+ * signature (eg. kexec'ed kernel image).
+ *
+ * For permission return 0, otherwise return -EACCES.
+ */
+int ima_load_data(enum kernel_load_data_id id)
+{
+	if ((ima_appraise & IMA_APPRAISE_ENFORCE) != IMA_APPRAISE_ENFORCE)
+		return 0;
+
+	switch (id) {
+	case LOADING_KEXEC_IMAGE:
+		if (ima_appraise & IMA_APPRAISE_KEXEC) {
+			pr_err("impossible to appraise a kernel image without a file descriptor; try using kexec_file_load syscall.\n");
+			return -EACCES;	/* INTEGRITY_UNKNOWN */
+		}
+	default:
+		break;
+	}
+	return 0;
+}
+
 static int __init init_ima(void)
 {
 	int error;
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index 7f4a4de7e831..ebfb389b79df 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -448,6 +448,8 @@ static int ima_appraise_flag(enum ima_hooks func)
 		return IMA_APPRAISE_FIRMWARE;
 	else if (func == POLICY_CHECK)
 		return IMA_APPRAISE_POLICY;
+	else if (func == KEXEC_KERNEL_CHECK)
+		return IMA_APPRAISE_KEXEC;
 	return 0;
 }
 
diff --git a/security/security.c b/security/security.c
index 05fe5b1932d7..7b870df0a335 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1063,7 +1063,12 @@ EXPORT_SYMBOL_GPL(security_kernel_post_read_file);
 
 int security_kernel_load_data(enum kernel_load_data_id id)
 {
-	return call_int_hook(kernel_load_data, 0, id);
+	int ret;
+
+	ret = call_int_hook(kernel_load_data, 0, id);
+	if (ret)
+		return ret;
+	return ima_load_data(id);
 }
 
 int security_task_fix_setuid(struct cred *new, const struct cred *old,
-- 
2.7.5

