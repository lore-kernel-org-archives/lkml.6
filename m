Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99CD7C6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 23:32:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3927220685
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 23:32:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3927220685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731813AbeGZAqM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 20:46:12 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:57338 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731644AbeGZAqL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 20:46:11 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6PNTR0s020536
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jul 2018 19:32:13 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2kexu6gnn5-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jul 2018 19:32:13 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <erichte@linux.vnet.ibm.com>;
        Thu, 26 Jul 2018 00:32:10 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 26 Jul 2018 00:32:07 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w6PNW6kY30670954
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 25 Jul 2018 23:32:06 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 45477AE056;
        Thu, 26 Jul 2018 02:32:14 +0100 (BST)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 644BAAE055;
        Thu, 26 Jul 2018 02:32:12 +0100 (BST)
Received: from yorha.ibmmodules.com (unknown [9.80.225.100])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 26 Jul 2018 02:32:12 +0100 (BST)
From:   Eric Richter <erichte@linux.vnet.ibm.com>
To:     linux-integrity <linux-integrity@vger.kernel.org>
Cc:     linux-security-module <linux-security-module@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Seth Forshee <seth.forshee@canonical.com>,
        Justin Forbes <jforbes@redhat.com>,
        Nayna Jain <nayna@linux.vnet.ibm.com>,
        Mimi Zohar <zohar@linux.ibm.com>
Subject: [PATCH 1/4] ima: add support for arch specific policies
Date:   Wed, 25 Jul 2018 18:31:57 -0500
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180725233200.761-1-erichte@linux.vnet.ibm.com>
References: <20180725233200.761-1-erichte@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18072523-0012-0000-0000-0000028ED4EF
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18072523-0013-0000-0000-000020C0BE94
Message-Id: <20180725233200.761-2-erichte@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-25_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807250240
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nayna Jain <nayna@linux.vnet.ibm.com>

Builtin IMA policies can be enabled on the boot command line, and
replaced with a custom policy, normally during early boot in the
initramfs.  Build time IMA policy rules were recently added.  These
rules are automatically enabled on boot and persist after loading a
custom policy.

There is a need for yet another type of policy, an architecture specific
policy, which is derived at runtime during kernel boot, based on the
runtime secure boot flags.  Like the build time policy rules, these
rules persist after loading a custom policy.

This patch adds support for loading an architecture specific IMA
policy.

Signed-off-by: Nayna Jain <nayna@linux.vnet.ibm.com>
- Defined function to convert the arch policy strings to an array of
ima_entry_rules.  The memory can then be freed after loading a custom
policy.
- Rename ima_get_arch_policy to arch_get_ima_policy.
Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
 include/linux/ima.h                 |  5 ++
 security/integrity/ima/ima_policy.c | 95 +++++++++++++++++++++++++++++++++++++
 2 files changed, 100 insertions(+)

diff --git a/include/linux/ima.h b/include/linux/ima.h
index 84806b54b50..7fd272f0b1f 100644
--- a/include/linux/ima.h
+++ b/include/linux/ima.h
@@ -30,6 +30,11 @@ extern void ima_post_path_mknod(struct dentry *dentry);
 extern void ima_add_kexec_buffer(struct kimage *image);
 #endif
 
+static inline const char * const *arch_get_ima_policy(void)
+{
+	return NULL;
+}
+
 #else
 static inline int ima_bprm_check(struct linux_binprm *bprm)
 {
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index 8c9499867c9..b47db4d7fea 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -20,6 +20,7 @@
 #include <linux/rculist.h>
 #include <linux/genhd.h>
 #include <linux/seq_file.h>
+#include <linux/ima.h>
 
 #include "ima.h"
 
@@ -193,6 +194,10 @@ static struct ima_rule_entry secure_boot_rules[] __ro_after_init = {
 	 .flags = IMA_FUNC | IMA_DIGSIG_REQUIRED},
 };
 
+/* An array of architecture specific rules */
+struct ima_rule_entry **arch_policy_rules __ro_after_init;
+struct ima_rule_entry *arch_policy_entry __ro_after_init;
+
 static LIST_HEAD(ima_default_rules);
 static LIST_HEAD(ima_policy_rules);
 static LIST_HEAD(ima_temp_rules);
@@ -473,6 +478,59 @@ static int ima_appraise_flag(enum ima_hooks func)
 	return 0;
 }
 
+static int ima_parse_rule(char *rule, struct ima_rule_entry *entry);
+
+/*
+ * ima_init_arch_policy - convert arch policy strings to rules
+ *
+ * Return number of arch specific rules.
+ */
+static int __init ima_init_arch_policy(void)
+{
+	const char * const *arch_rules;
+	const char * const *rules;
+	int arch_entries = 0;
+	int i = 0;
+
+	arch_rules = arch_get_ima_policy();
+	if (!arch_rules) {
+		pr_info("No architecture policy rules.\n");
+		return arch_entries;
+	}
+
+	/* Get number of rules */
+	for (rules = arch_rules; *rules != NULL; rules++)
+		arch_entries++;
+
+	arch_policy_rules = kcalloc(arch_entries + 1,
+				    sizeof(*arch_policy_rules), GFP_KERNEL);
+	if (!arch_policy_rules)
+		return 0;
+
+	arch_policy_entry = kcalloc(arch_entries + 1,
+				    sizeof(*arch_policy_entry), GFP_KERNEL);
+
+	/* Convert arch policy string rules to struct ima_rule_entry format */
+	for (rules = arch_rules, i = 0; *rules != NULL; rules++) {
+		char rule[255];
+		int result;
+
+		result = strlcpy(rule, *rules, sizeof(rule));
+
+		INIT_LIST_HEAD(&arch_policy_entry[i].list);
+		result = ima_parse_rule(rule, &arch_policy_entry[i]);
+		if (result) {
+			pr_warn("Skipping unknown architecture policy rule: %s\n", rule);
+			memset(&arch_policy_entry[i], 0,
+			       sizeof(*arch_policy_entry));
+			continue;
+		}
+		arch_policy_rules[i] = &arch_policy_entry[i];
+		i++;
+	}
+	return i;
+}
+
 /**
  * ima_init_policy - initialize the default measure rules.
  *
@@ -482,6 +540,7 @@ static int ima_appraise_flag(enum ima_hooks func)
 void __init ima_init_policy(void)
 {
 	int i, measure_entries, appraise_entries, secure_boot_entries;
+	int arch_policy_entries;
 
 	/* if !ima_policy set entries = 0 so we load NO default rules */
 	measure_entries = ima_policy ? ARRAY_SIZE(dont_measure_rules) : 0;
@@ -507,6 +566,33 @@ void __init ima_init_policy(void)
 		break;
 	}
 
+	/*
+	 * Based on runtime secure boot flags, insert arch specific measurement
+	 * and appraise rules requiring file signatures for both the initial
+	 * and custom policies, prior to other appraise rules.
+	 * (Highest priority)
+	 */
+	arch_policy_entries = ima_init_arch_policy();
+	if (arch_policy_entries > 0)
+		pr_info("Adding %d architecture policy rules.\n", arch_policy_entries);
+	for (i = 0; i < arch_policy_entries; i++) {
+		struct ima_rule_entry *entry;
+
+		list_add_tail(&arch_policy_rules[i]->list, &ima_default_rules);
+
+		entry = kmemdup(&arch_policy_entry[i], sizeof(*entry),
+				GFP_KERNEL);
+		if (!entry) {
+			WARN_ONCE(true, "Failed adding architecture rules to custom policy\n");
+			continue;
+		}
+
+		INIT_LIST_HEAD(&entry->list);
+		list_add_tail(&entry->list, &ima_policy_rules);
+		if (entry->action == APPRAISE)
+			build_ima_appraise |= ima_appraise_flag(entry->func);
+	}
+
 	/*
 	 * Insert the builtin "secure_boot" policy rules requiring file
 	 * signatures, prior to any other appraise rules.
@@ -576,6 +662,15 @@ void ima_update_policy(void)
 	if (ima_rules != policy) {
 		ima_policy_flag = 0;
 		ima_rules = policy;
+
+		/*
+		 * IMA architecture specific policy rules are specified
+		 * as strings and converted to an array of ima_entry_rules
+		 * on boot.  After loading a custom policy, free the
+		 * architecture specific rules stored as an array.
+		 */
+		kfree(arch_policy_rules);
+		kfree(arch_policy_entry);
 	}
 	ima_update_policy_flag();
 }
-- 
2.14.4

