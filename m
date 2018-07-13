Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D43ACECDFB1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 18:06:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 878F820842
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 18:06:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 878F820842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733205AbeGMSWQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 14:22:16 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:40138 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1733101AbeGMSWP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 14:22:15 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6DI4EUB134292
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jul 2018 14:06:33 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2k6x8qy3ec-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jul 2018 14:06:33 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Fri, 13 Jul 2018 19:06:30 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 13 Jul 2018 19:06:27 +0100
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w6DI6Qgp39583912
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 13 Jul 2018 18:06:26 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 30D7942042;
        Fri, 13 Jul 2018 21:06:47 +0100 (BST)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3BAE44203F;
        Fri, 13 Jul 2018 21:06:46 +0100 (BST)
Received: from dhcp-9-31-103-18.watson.ibm.com (unknown [9.31.103.18])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 13 Jul 2018 21:06:46 +0100 (BST)
From:   Mimi Zohar <zohar@linux.vnet.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Luis R . Rodriguez" <mcgrof@kernel.org>,
        Eric Biederman <ebiederm@xmission.com>,
        kexec@lists.infradead.org, Andres Rodriguez <andresx7@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v6 6/8] ima: add build time policy
Date:   Fri, 13 Jul 2018 14:06:01 -0400
X-Mailer: git-send-email 2.7.5
In-Reply-To: <1531505163-20227-1-git-send-email-zohar@linux.vnet.ibm.com>
References: <1531505163-20227-1-git-send-email-zohar@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18071318-0012-0000-0000-00000289F207
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18071318-0013-0000-0000-000020BBA031
Message-Id: <1531505163-20227-7-git-send-email-zohar@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-13_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=6 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807130159
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IMA by default does not measure, appraise or audit files, but can be
enabled at runtime by specifying a builtin policy on the boot command line
or by loading a custom policy.

This patch defines a build time policy, which verifies kernel modules,
firmware, kexec image, and/or the IMA policy signatures.  This build time
policy is automatically enabled at runtime and persists after loading a
custom policy.

Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
---
 security/integrity/ima/Kconfig      | 58 +++++++++++++++++++++++++++++++++++++
 security/integrity/ima/ima_policy.c | 46 +++++++++++++++++++++++++++--
 2 files changed, 101 insertions(+), 3 deletions(-)

diff --git a/security/integrity/ima/Kconfig b/security/integrity/ima/Kconfig
index 94c2151331aa..13b446328dda 100644
--- a/security/integrity/ima/Kconfig
+++ b/security/integrity/ima/Kconfig
@@ -157,6 +157,64 @@ config IMA_APPRAISE
 	  <http://linux-ima.sourceforge.net>
 	  If unsure, say N.
 
+config IMA_APPRAISE_BUILD_POLICY
+	bool "IMA build time configured policy rules"
+	depends on IMA_APPRAISE && INTEGRITY_ASYMMETRIC_KEYS
+	default n
+	help
+	  This option defines an IMA appraisal policy at build time, which
+	  is enforced at run time without having to specify a builtin
+	  policy name on the boot command line.  The build time appraisal
+	  policy rules persist after loading a custom policy.
+
+	  Depending on the rules configured, this policy may require kernel
+	  modules, firmware, the kexec kernel image, and/or the IMA policy
+	  to be signed.  Unsigned files might prevent the system from
+	  booting or applications from working properly.
+
+config IMA_APPRAISE_REQUIRE_FIRMWARE_SIGS
+	bool "Appraise firmware signatures"
+	depends on IMA_APPRAISE_BUILD_POLICY
+	default n
+	help
+	  This option defines a policy requiring all firmware to be signed,
+	  including the regulatory.db.  If both this option and
+	  CFG80211_REQUIRE_SIGNED_REGDB are enabled, then both signature
+	  verification methods are necessary.
+
+config IMA_APPRAISE_REQUIRE_KEXEC_SIGS
+	bool "Appraise kexec kernel image signatures"
+	depends on IMA_APPRAISE_BUILD_POLICY
+	default n
+	help
+	  Enabling this rule will require all kexec'ed kernel images to
+	  be signed and verified by a public key on the trusted IMA
+	  keyring.
+
+	  Kernel image signatures can not be verified by the original
+	  kexec_load syscall.  Enabling this rule will prevent its
+	  usage.
+
+config IMA_APPRAISE_REQUIRE_MODULE_SIGS
+	bool "Appraise kernel modules signatures"
+	depends on IMA_APPRAISE_BUILD_POLICY
+	default n
+	help
+	  Enabling this rule will require all kernel modules to be signed
+	  and verified by a public key on the trusted IMA keyring.
+
+	  Kernel module signatures can only be verified by IMA-appraisal,
+	  via the finit_module syscall. Enabling this rule will prevent
+	  the usage of the init_module syscall.
+
+config IMA_APPRAISE_REQUIRE_POLICY_SIGS
+	bool "Appraise IMA policy signature"
+	depends on IMA_APPRAISE_BUILD_POLICY
+	default n
+	help
+	  Enabling this rule will require the IMA policy to be signed and
+	  and verified by a key on the trusted IMA keyring.
+
 config IMA_APPRAISE_BOOTPARAM
 	bool "ima_appraise boot parameter"
 	depends on IMA_APPRAISE
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index ebfb389b79df..8c9499867c91 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -49,6 +49,7 @@
 
 int ima_policy_flag;
 static int temp_ima_appraise;
+static int build_ima_appraise __ro_after_init;
 
 #define MAX_LSM_RULES 6
 enum lsm_rule_types { LSM_OBJ_USER, LSM_OBJ_ROLE, LSM_OBJ_TYPE,
@@ -162,6 +163,25 @@ static struct ima_rule_entry default_appraise_rules[] __ro_after_init = {
 #endif
 };
 
+static struct ima_rule_entry build_appraise_rules[] __ro_after_init = {
+#ifdef CONFIG_IMA_APPRAISE_REQUIRE_MODULE_SIGS
+	{.action = APPRAISE, .func = MODULE_CHECK,
+	 .flags = IMA_FUNC | IMA_DIGSIG_REQUIRED},
+#endif
+#ifdef CONFIG_IMA_APPRAISE_REQUIRE_FIRMWARE_SIGS
+	{.action = APPRAISE, .func = FIRMWARE_CHECK,
+	 .flags = IMA_FUNC | IMA_DIGSIG_REQUIRED},
+#endif
+#ifdef CONFIG_IMA_APPRAISE_REQUIRE_KEXEC_SIGS
+	{.action = APPRAISE, .func = KEXEC_KERNEL_CHECK,
+	 .flags = IMA_FUNC | IMA_DIGSIG_REQUIRED},
+#endif
+#ifdef CONFIG_IMA_APPRAISE_REQUIRE_POLICY_SIGS
+	{.action = APPRAISE, .func = POLICY_CHECK,
+	 .flags = IMA_FUNC | IMA_DIGSIG_REQUIRED},
+#endif
+};
+
 static struct ima_rule_entry secure_boot_rules[] __ro_after_init = {
 	{.action = APPRAISE, .func = MODULE_CHECK,
 	 .flags = IMA_FUNC | IMA_DIGSIG_REQUIRED},
@@ -435,7 +455,7 @@ void ima_update_policy_flag(void)
 			ima_policy_flag |= entry->action;
 	}
 
-	ima_appraise |= temp_ima_appraise;
+	ima_appraise |= (build_ima_appraise | temp_ima_appraise);
 	if (!ima_appraise)
 		ima_policy_flag &= ~IMA_APPRAISE;
 }
@@ -488,8 +508,8 @@ void __init ima_init_policy(void)
 	}
 
 	/*
-	 * Insert the appraise rules requiring file signatures, prior to
-	 * any other appraise rules.
+	 * Insert the builtin "secure_boot" policy rules requiring file
+	 * signatures, prior to any other appraise rules.
 	 */
 	for (i = 0; i < secure_boot_entries; i++) {
 		list_add_tail(&secure_boot_rules[i].list, &ima_default_rules);
@@ -497,6 +517,26 @@ void __init ima_init_policy(void)
 		    ima_appraise_flag(secure_boot_rules[i].func);
 	}
 
+	/*
+	 * Insert the build time appraise rules requiring file signatures
+	 * for both the initial and custom policies, prior to other appraise
+	 * rules.
+	 */
+	for (i = 0; i < ARRAY_SIZE(build_appraise_rules); i++) {
+		struct ima_rule_entry *entry;
+
+		if (!secure_boot_entries)
+			list_add_tail(&build_appraise_rules[i].list,
+				      &ima_default_rules);
+
+		entry = kmemdup(&build_appraise_rules[i], sizeof(*entry),
+				GFP_KERNEL);
+		if (entry)
+			list_add_tail(&entry->list, &ima_policy_rules);
+		build_ima_appraise |=
+			ima_appraise_flag(build_appraise_rules[i].func);
+	}
+
 	for (i = 0; i < appraise_entries; i++) {
 		list_add_tail(&default_appraise_rules[i].list,
 			      &ima_default_rules);
-- 
2.7.5

