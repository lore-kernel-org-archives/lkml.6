Return-Path: <zohar@linux.vnet.ibm.com>
X-Google-Smtp-Source: AB8JxZqeTFVPoauokN89mREi4aveS80mwMwdWYZA1nKZ86iPuS16PgMJjCsToxZrOMQKUwaZG5DL
ARC-Seal: i=1; a=rsa-sha256; t=1526568597; cv=none;
        d=google.com; s=arc-20160816;
        b=Iqz0W061BjfbPpHH+2xpomfqgXIVcYxmhH74GGJ5De7vo0K+yMQa4hn3gtQUvaeI+G
         TjJf/FVBNBQZqpraYWnJymy7WBK2Th3oLt0NXgjxjMq0qo1bAGrR2Di2a22XlFDgi0y4
         vHzgLUDchTyozW+s0eCJw+UjRE6ErH/xSGBxyWtIPqhPl0FEgttdNciBuXon8jNEIEAb
         1IbWpAzcjka9BodT5MOnpWn0fg0AJ8cW9vQSHi3NZFuOWvzdhJvyvjidbmYuBtiIu8SA
         C5ogFThyRneciLLSVOtNR5UnZ4uXhhF7aVmVrwMZqY8NcvjUPImhdU7qpCSwN/uQ4Ea+
         9PJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:references:in-reply-to:date:subject:cc:to:from
         :arc-authentication-results;
        bh=rx3LUSXdIXX0sN+62fEwINbGglSzSV+VwIEfHF16/y0=;
        b=CxsmclBeSs9x9f2AO5M34ZqKyfVyXL1woQ9E2nX4/HmEalWlN+HgK3Sx2pL5+jGlhh
         /KRGSgc44Bq0lAxXiA38q0S9WtCg+eopnmUM6uNwB7+U1SBccaSaE7muNR8d/cM7B5Bl
         Nc02byDzPrM9Fqj2mIdPROz8SUmGEGdNlnLj+xiTSgOl9ACCH02ziD9sulg+zyyvRlPC
         ep1wCUyA5j5y7V5Xn6BAa3UnQh0sufi7jEc6XDhT/tCbKcDvPln+28+wyzzRSTdWEUbA
         xs2+0mt4zV7TCUmO4H1YLfbvk8ZktOIWCyaZEX74F8YpjxEMz3zVO9PzcWgcprhDH2jV
         AmVg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 148.163.158.5 is neither permitted nor denied by best guess record for domain of zohar@linux.vnet.ibm.com) smtp.mailfrom=zohar@linux.vnet.ibm.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 148.163.158.5 is neither permitted nor denied by best guess record for domain of zohar@linux.vnet.ibm.com) smtp.mailfrom=zohar@linux.vnet.ibm.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=ibm.com
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: linux-integrity@vger.kernel.org
Cc: Mimi Zohar <zohar@linux.vnet.ibm.com>,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Howells <dhowells@redhat.com>,
        "Luis R . Rodriguez" <mcgrof@kernel.org>,
        Eric Biederman <ebiederm@xmission.com>, kexec@lists.infradead.org,
        Andres Rodriguez <andresx7@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: [PATCH v2 8/9] ima: add build time policy
Date: Thu, 17 May 2018 10:48:49 -0400
X-Mailer: git-send-email 2.7.5
In-Reply-To: <1526568530-9144-1-git-send-email-zohar@linux.vnet.ibm.com>
References: <1526568530-9144-1-git-send-email-zohar@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18051714-0012-0000-0000-000005D7A705
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18051714-0013-0000-0000-00001954D35E
Message-Id: <1526568530-9144-9-git-send-email-zohar@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-17_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805170137
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600723193893787851?=
X-GMAIL-MSGID: =?utf-8?q?1600723193893787851?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

IMA by default does not measure, appraise or audit files, but can be
enabled at runtime by specifying a builtin policy on the boot command line
or by loading a custom policy.

This patch defines a build time policy, which verifies kernel modules,
firmware, kexec image, and/or the IMA policy signatures.  This build time
policy is automatically enabled at runtime.  The build time policy rules
persist after loading a custom policy.

Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
---
 security/integrity/ima/Kconfig      | 58 +++++++++++++++++++++++++++++++++++++
 security/integrity/ima/ima_policy.c | 46 +++++++++++++++++++++++++++--
 2 files changed, 101 insertions(+), 3 deletions(-)

diff --git a/security/integrity/ima/Kconfig b/security/integrity/ima/Kconfig
index 6a8f67714c83..004919d9bf09 100644
--- a/security/integrity/ima/Kconfig
+++ b/security/integrity/ima/Kconfig
@@ -156,6 +156,64 @@ config IMA_APPRAISE
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
index c27f6993b07a..3c0bc8a1a88e 100644
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
