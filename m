Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6B57C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 12:25:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CB7020684
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 12:25:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CB7020684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728148AbeIZSiK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 14:38:10 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:48646 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727482AbeIZSiK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 14:38:10 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8QCOjFg077042
        for <linux-kernel@vger.kernel.org>; Wed, 26 Sep 2018 08:25:24 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2mr8k7w60q-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 26 Sep 2018 08:25:24 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <nayna@linux.vnet.ibm.com>;
        Wed, 26 Sep 2018 13:25:22 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 26 Sep 2018 13:25:19 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w8QCPInP52822262
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 26 Sep 2018 12:25:19 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 12C815204F;
        Wed, 26 Sep 2018 15:25:00 +0100 (BST)
Received: from swastik.in.ibm.com (unknown [9.124.31.41])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 9553652050;
        Wed, 26 Sep 2018 15:24:58 +0100 (BST)
From:   Nayna Jain <nayna@linux.vnet.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     zohar@linux.ibm.com, linux-security-module@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        dhowells@redhat.com, jforbes@redhat.com,
        Nayna Jain <nayna@linux.vnet.ibm.com>
Subject: [PATCH v4 3/6] ima: refactor ima_init_policy()
Date:   Wed, 26 Sep 2018 17:52:07 +0530
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180926122210.14642-1-nayna@linux.vnet.ibm.com>
References: <20180926122210.14642-1-nayna@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18092612-0016-0000-0000-0000020AD293
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18092612-0017-0000-0000-00003261F1CC
Message-Id: <20180926122210.14642-4-nayna@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-26_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1809260123
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes the code duplication in ima_init_policy() by defining
a new function named add_rules().

Signed-off-by: Nayna Jain <nayna@linux.vnet.ibm.com>
---
 security/integrity/ima/ima_policy.c | 98 +++++++++++++++++++++----------------
 1 file changed, 57 insertions(+), 41 deletions(-)

diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index 8c9499867c91..d5b327320d3a 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -58,6 +58,8 @@ enum lsm_rule_types { LSM_OBJ_USER, LSM_OBJ_ROLE, LSM_OBJ_TYPE,
 
 enum policy_types { ORIGINAL_TCB = 1, DEFAULT_TCB };
 
+enum policy_rule_list { IMA_DEFAULT_POLICY = 1, IMA_CUSTOM_POLICY };
+
 struct ima_rule_entry {
 	struct list_head list;
 	int action;
@@ -473,6 +475,33 @@ static int ima_appraise_flag(enum ima_hooks func)
 	return 0;
 }
 
+static void add_rules(struct ima_rule_entry *entries, int count,
+		      enum policy_rule_list file)
+{
+	int i = 0;
+
+	for (i = 0; i < count; i++) {
+		struct ima_rule_entry *entry;
+
+		if (file & IMA_DEFAULT_POLICY)
+			list_add_tail(&entries[i].list, &ima_default_rules);
+
+		if (file & IMA_CUSTOM_POLICY) {
+			entry = kmemdup(&entries[i], sizeof(*entry),
+					GFP_KERNEL);
+			if (!entry)
+				continue;
+
+			INIT_LIST_HEAD(&entry->list);
+			list_add_tail(&entry->list, &ima_policy_rules);
+		}
+		if (entries[i].action == APPRAISE)
+			temp_ima_appraise |= ima_appraise_flag(entries[i].func);
+		if (entries[i].func == POLICY_CHECK)
+			temp_ima_appraise |= IMA_APPRAISE_POLICY;
+	}
+}
+
 /**
  * ima_init_policy - initialize the default measure rules.
  *
@@ -481,28 +510,23 @@ static int ima_appraise_flag(enum ima_hooks func)
  */
 void __init ima_init_policy(void)
 {
-	int i, measure_entries, appraise_entries, secure_boot_entries;
-
-	/* if !ima_policy set entries = 0 so we load NO default rules */
-	measure_entries = ima_policy ? ARRAY_SIZE(dont_measure_rules) : 0;
-	appraise_entries = ima_use_appraise_tcb ?
-			 ARRAY_SIZE(default_appraise_rules) : 0;
-	secure_boot_entries = ima_use_secure_boot ?
-			ARRAY_SIZE(secure_boot_rules) : 0;
+	int build_appraise_entries;
 
-	for (i = 0; i < measure_entries; i++)
-		list_add_tail(&dont_measure_rules[i].list, &ima_default_rules);
+	/* if !ima_policy, we load NO default rules */
+	if (ima_policy)
+		add_rules(dont_measure_rules, ARRAY_SIZE(dont_measure_rules),
+			  IMA_DEFAULT_POLICY);
 
 	switch (ima_policy) {
 	case ORIGINAL_TCB:
-		for (i = 0; i < ARRAY_SIZE(original_measurement_rules); i++)
-			list_add_tail(&original_measurement_rules[i].list,
-				      &ima_default_rules);
+		add_rules(original_measurement_rules,
+			  ARRAY_SIZE(original_measurement_rules),
+			  IMA_DEFAULT_POLICY);
 		break;
 	case DEFAULT_TCB:
-		for (i = 0; i < ARRAY_SIZE(default_measurement_rules); i++)
-			list_add_tail(&default_measurement_rules[i].list,
-				      &ima_default_rules);
+		add_rules(default_measurement_rules,
+			  ARRAY_SIZE(default_measurement_rules),
+			  IMA_DEFAULT_POLICY);
 	default:
 		break;
 	}
@@ -511,38 +535,30 @@ void __init ima_init_policy(void)
 	 * Insert the builtin "secure_boot" policy rules requiring file
 	 * signatures, prior to any other appraise rules.
 	 */
-	for (i = 0; i < secure_boot_entries; i++) {
-		list_add_tail(&secure_boot_rules[i].list, &ima_default_rules);
-		temp_ima_appraise |=
-		    ima_appraise_flag(secure_boot_rules[i].func);
-	}
+	if (ima_use_secure_boot)
+		add_rules(secure_boot_rules, ARRAY_SIZE(secure_boot_rules),
+			  IMA_DEFAULT_POLICY);
 
 	/*
 	 * Insert the build time appraise rules requiring file signatures
 	 * for both the initial and custom policies, prior to other appraise
-	 * rules.
+	 * rules. As the secure boot rules includes all of the build time
+	 * rules, include either one or the other set of rules, but not both.
 	 */
-	for (i = 0; i < ARRAY_SIZE(build_appraise_rules); i++) {
-		struct ima_rule_entry *entry;
-
-		if (!secure_boot_entries)
-			list_add_tail(&build_appraise_rules[i].list,
-				      &ima_default_rules);
-
-		entry = kmemdup(&build_appraise_rules[i], sizeof(*entry),
-				GFP_KERNEL);
-		if (entry)
-			list_add_tail(&entry->list, &ima_policy_rules);
-		build_ima_appraise |=
-			ima_appraise_flag(build_appraise_rules[i].func);
+	build_appraise_entries = ARRAY_SIZE(build_appraise_rules);
+	if (build_appraise_entries) {
+		if (ima_use_secure_boot)
+			add_rules(build_appraise_rules, build_appraise_entries,
+				  IMA_CUSTOM_POLICY);
+		else
+			add_rules(build_appraise_rules, build_appraise_entries,
+				  IMA_DEFAULT_POLICY | IMA_CUSTOM_POLICY);
 	}
 
-	for (i = 0; i < appraise_entries; i++) {
-		list_add_tail(&default_appraise_rules[i].list,
-			      &ima_default_rules);
-		if (default_appraise_rules[i].func == POLICY_CHECK)
-			temp_ima_appraise |= IMA_APPRAISE_POLICY;
-	}
+	if (ima_use_appraise_tcb)
+		add_rules(default_appraise_rules,
+			  ARRAY_SIZE(default_appraise_rules),
+			  IMA_DEFAULT_POLICY);
 
 	ima_rules = &ima_default_rules;
 	ima_update_policy_flag();
-- 
2.13.6

