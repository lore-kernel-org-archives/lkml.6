Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C26DC070C3
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 08:03:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44AA020882
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 08:03:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44AA020882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728219AbeINNQb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 09:16:31 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:33716 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727881AbeINNQ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 09:16:29 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8E7xRT4041418
        for <linux-kernel@vger.kernel.org>; Fri, 14 Sep 2018 04:03:12 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2mg90erf12-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 14 Sep 2018 04:03:12 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <nayna@linux.vnet.ibm.com>;
        Fri, 14 Sep 2018 09:03:09 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 14 Sep 2018 09:03:07 +0100
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w8E836vk52232236
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 14 Sep 2018 08:03:06 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7F7094203F;
        Fri, 14 Sep 2018 11:02:56 +0100 (BST)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 20B3F42056;
        Fri, 14 Sep 2018 11:02:55 +0100 (BST)
Received: from swastik.in.ibm.com (unknown [9.124.31.41])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 14 Sep 2018 11:02:54 +0100 (BST)
From:   Nayna Jain <nayna@linux.vnet.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     zohar@linux.ibm.com, linux-security-module@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        dhowells@redhat.com, jforbes@redhat.com,
        Nayna Jain <nayna@linux.vnet.ibm.com>
Subject: [PATCH v2 4/6] ima: add support for arch specific policies
Date:   Fri, 14 Sep 2018 13:30:03 +0530
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180914080005.6138-1-nayna@linux.vnet.ibm.com>
References: <20180914080005.6138-1-nayna@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18091408-4275-0000-0000-000002BA3E71
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18091408-4276-0000-0000-000037C37AB9
Message-Id: <20180914080005.6138-5-nayna@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-14_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1809140085
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Builtin IMA policies can be enabled on the boot command line, and replaced
with a custom policy, normally during early boot in the initramfs. Build
time IMA policy rules were recently added. These rules are automatically
enabled on boot and persist after loading a custom policy.

There is a need for yet another type of policy, an architecture specific
policy, which is derived at runtime during kernel boot, based on the
runtime secure boot flags.  Like the build time policy rules, these rules
persist after loading a custom policy.

This patch adds support for loading an architecture specific IMA policy.

Signed-off-by: Nayna Jain <nayna@linux.vnet.ibm.com>
- Defined function to convert the arch policy strings to an array of
ima_entry_rules.  The memory can then be freed after loading a custom
policy.
- Rename ima_get_arch_policy to arch_get_ima_policy.
Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
- Modified ima_init_arch_policy() and ima_init_policy() to use add_rules()
from previous patch.
Signed-off-by: Nayna Jain <nayna@linux.vnet.ibm.com>
---
 include/linux/ima.h                 |  5 +++
 security/integrity/ima/ima_policy.c | 70 +++++++++++++++++++++++++++++++++++--
 2 files changed, 73 insertions(+), 2 deletions(-)

diff --git a/include/linux/ima.h b/include/linux/ima.h
index 4852255aa4f4..350fa957f8a6 100644
--- a/include/linux/ima.h
+++ b/include/linux/ima.h
@@ -39,6 +39,11 @@ static inline bool arch_ima_get_secureboot(void)
 }
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
index b58906a05736..23f3aa214016 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -20,6 +20,7 @@
 #include <linux/rculist.h>
 #include <linux/genhd.h>
 #include <linux/seq_file.h>
+#include <linux/ima.h>
 
 #include "ima.h"
 
@@ -195,6 +196,9 @@ static struct ima_rule_entry secure_boot_rules[] __ro_after_init = {
 	 .flags = IMA_FUNC | IMA_DIGSIG_REQUIRED},
 };
 
+/* An array of architecture specific rules */
+struct ima_rule_entry *arch_policy_entry __ro_after_init;
+
 static LIST_HEAD(ima_default_rules);
 static LIST_HEAD(ima_policy_rules);
 static LIST_HEAD(ima_temp_rules);
@@ -492,7 +496,6 @@ static void add_rules(struct ima_rule_entry *entries, int count,
 			if (!entry)
 				continue;
 
-			INIT_LIST_HEAD(&entry->list);
 			list_add_tail(&entry->list, &ima_policy_rules);
 		}
 		if (entries[i].action == APPRAISE)
@@ -502,6 +505,48 @@ static void add_rules(struct ima_rule_entry *entries, int count,
 	}
 }
 
+static int ima_parse_rule(char *rule, struct ima_rule_entry *entry);
+
+static int __init ima_init_arch_policy(void)
+{
+	const char * const *arch_rules;
+	const char * const *rules;
+	int arch_entries = 0;
+	int i = 0;
+
+	arch_rules = arch_get_ima_policy();
+	if (!arch_rules)
+		return arch_entries;
+
+	/* Get number of rules */
+	for (rules = arch_rules; *rules != NULL; rules++)
+		arch_entries++;
+
+	arch_policy_entry = kcalloc(arch_entries + 1,
+				    sizeof(*arch_policy_entry), GFP_KERNEL);
+	if (!arch_policy_entry)
+		return 0;
+
+	/* Convert each policy string rules to struct ima_rule_entry format */
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
+		i++;
+	}
+	return i;
+}
+
 /**
  * ima_init_policy - initialize the default measure rules.
  *
@@ -510,7 +555,7 @@ static void add_rules(struct ima_rule_entry *entries, int count,
  */
 void __init ima_init_policy(void)
 {
-	int build_appraise_entries;
+	int build_appraise_entries, arch_entries;
 
 	/* if !ima_policy, we load NO default rules */
 	if (ima_policy)
@@ -532,6 +577,19 @@ void __init ima_init_policy(void)
 	}
 
 	/*
+	 * Based on runtime secure boot flags, insert arch specific measurement
+	 * and appraise rules requiring file signatures for both the initial
+	 * and custom policies, prior to other appraise rules.
+	 * (Highest priority)
+	 */
+	arch_entries = ima_init_arch_policy();
+	if (!arch_entries)
+		pr_info("No architecture policies found\n");
+	else
+		add_rules(arch_policy_entry, arch_entries,
+			  IMA_DEFAULT_POLICY | IMA_CUSTOM_POLICY);
+
+	/*
 	 * Insert the builtin "secure_boot" policy rules requiring file
 	 * signatures, prior to any other appraise rules.
 	 */
@@ -592,6 +650,14 @@ void ima_update_policy(void)
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
+		kfree(arch_policy_entry);
 	}
 	ima_update_policy_flag();
 }
-- 
2.13.6

