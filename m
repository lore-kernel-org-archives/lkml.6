Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72C90C67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 23:32:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27B7D20685
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 23:32:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27B7D20685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731605AbeGZAqT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 20:46:19 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:47820 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731834AbeGZAqR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 20:46:17 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6PNTWZC086363
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jul 2018 19:32:19 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2key1bqxyn-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jul 2018 19:32:19 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <erichte@linux.vnet.ibm.com>;
        Thu, 26 Jul 2018 00:32:16 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 26 Jul 2018 00:32:12 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w6PNWCYB38010976
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 25 Jul 2018 23:32:12 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 74691AE053;
        Thu, 26 Jul 2018 02:32:19 +0100 (BST)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 173B3AE051;
        Thu, 26 Jul 2018 02:32:18 +0100 (BST)
Received: from yorha.ibmmodules.com (unknown [9.80.225.100])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 26 Jul 2018 02:32:17 +0100 (BST)
From:   Eric Richter <erichte@linux.vnet.ibm.com>
To:     linux-integrity <linux-integrity@vger.kernel.org>
Cc:     linux-security-module <linux-security-module@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Seth Forshee <seth.forshee@canonical.com>,
        Justin Forbes <jforbes@redhat.com>,
        Eric Richter <erichte@linux.vnet.ibm.com>
Subject: [PATCH 3/4] ima: add support for KEXEC_ORIG_KERNEL_CHECK
Date:   Wed, 25 Jul 2018 18:31:59 -0500
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180725233200.761-1-erichte@linux.vnet.ibm.com>
References: <20180725233200.761-1-erichte@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18072523-4275-0000-0000-0000029E0335
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18072523-4276-0000-0000-000037A60332
Message-Id: <20180725233200.761-4-erichte@linux.vnet.ibm.com>
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

IMA can verify the signature of kernel images loaded with kexec_file_load,
but can not verify images loaded with the regular kexec_load syscall.
Therefore, the appraisal will automatically fail during kexec_load when an
appraise policy rule is set for func=KEXEC_KERNEL_CHECK. This can be used
to effectively disable the kexec_load syscall, while still allowing the
kexec_file_load to operate so long as the target kernel image is signed.

However, this conflicts with CONFIG_KEXEC_VERIFY_SIG. If that option is
enabled and there is an appraise rule set, then the target kernel would
have to be verifiable by both IMA and the architecture specific kernel
verification procedure.

This patch adds a new func= for IMA appraisal specifically for the original
kexec_load syscall. Therefore, the kexec_load syscall can be effectively
disabled via IMA policy, leaving the kexec_file_load syscall able to do its
own signature verification, and not require it to be signed via IMA. To
retain compatibility, the existing func=KEXEC_KERNEL_CHECK flag is
unchanged, and thus enables appraisal for both kexec syscalls.

Signed-off-by: Eric Richter <erichte@linux.vnet.ibm.com>
---
 Documentation/ABI/testing/ima_policy | 1 +
 security/integrity/ima/ima.h         | 2 ++
 security/integrity/ima/ima_main.c    | 3 ++-
 security/integrity/ima/ima_policy.c  | 5 +++++
 4 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/ima_policy b/Documentation/ABI/testing/ima_policy
index 74c6702de74..031417779ec 100644
--- a/Documentation/ABI/testing/ima_policy
+++ b/Documentation/ABI/testing/ima_policy
@@ -29,6 +29,7 @@ Description:
 		base: 	func:= [BPRM_CHECK][MMAP_CHECK][CREDS_CHECK][FILE_CHECK][MODULE_CHECK]
 				[FIRMWARE_CHECK]
 				[KEXEC_KERNEL_CHECK] [KEXEC_INITRAMFS_CHECK]
+				[KEXEC_ORIG_KERNEL_CHECK]
 			mask:= [[^]MAY_READ] [[^]MAY_WRITE] [[^]MAY_APPEND]
 			       [[^]MAY_EXEC]
 			fsmagic:= hex value
diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index 6e5fa7c4280..c76e53c982b 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -181,6 +181,7 @@ static inline unsigned long ima_hash_key(u8 *digest)
 	hook(MODULE_CHECK)		\
 	hook(FIRMWARE_CHECK)		\
 	hook(KEXEC_KERNEL_CHECK)	\
+	hook(KEXEC_ORIG_KERNEL_CHECK)	\
 	hook(KEXEC_INITRAMFS_CHECK)	\
 	hook(POLICY_CHECK)		\
 	hook(MAX_CHECK)
@@ -233,6 +234,7 @@ int ima_policy_show(struct seq_file *m, void *v);
 #define IMA_APPRAISE_FIRMWARE	0x10
 #define IMA_APPRAISE_POLICY	0x20
 #define IMA_APPRAISE_KEXEC	0x40
+#define IMA_APPRAISE_ORIG_KEXEC	0x80
 
 #ifdef CONFIG_IMA_APPRAISE
 int ima_appraise_measurement(enum ima_hooks func,
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index dce0a8a217b..a7b4220043d 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -512,7 +512,8 @@ int ima_load_data(enum kernel_load_data_id id)
 
 	switch (id) {
 	case LOADING_KEXEC_IMAGE:
-		if (ima_appraise & IMA_APPRAISE_KEXEC) {
+		if (ima_appraise &
+		    (IMA_APPRAISE_ORIG_KEXEC | IMA_APPRAISE_KEXEC)) {
 			pr_err("impossible to appraise a kernel image without a file descriptor; try using kexec_file_load syscall.\n");
 			return -EACCES;	/* INTEGRITY_UNKNOWN */
 		}
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index 402e5bd1093..7a33e3f6eca 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -475,6 +475,8 @@ static int ima_appraise_flag(enum ima_hooks func)
 		return IMA_APPRAISE_POLICY;
 	else if (func == KEXEC_KERNEL_CHECK)
 		return IMA_APPRAISE_KEXEC;
+	else if (func == KEXEC_ORIG_KERNEL_CHECK)
+		return IMA_APPRAISE_ORIG_KEXEC;
 	return 0;
 }
 
@@ -879,6 +881,9 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
 			else if (strcmp(args[0].from, "KEXEC_KERNEL_CHECK") ==
 				 0)
 				entry->func = KEXEC_KERNEL_CHECK;
+			else if (strcmp(args[0].from,
+				 "KEXEC_ORIG_KERNEL_CHECK") == 0)
+				entry->func = KEXEC_ORIG_KERNEL_CHECK;
 			else if (strcmp(args[0].from, "KEXEC_INITRAMFS_CHECK")
 				 == 0)
 				entry->func = KEXEC_INITRAMFS_CHECK;
-- 
2.14.4

