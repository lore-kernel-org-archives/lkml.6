Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751515AbeFDUzN (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 16:55:13 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59690 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751394AbeFDUzI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 16:55:08 -0400
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
To: zohar@linux.vnet.ibm.com, paul@paul-moore.com,
        linux-integrity@vger.kernel.org, linux-audit@redhat.com
Cc: sgrubb@redhat.com, linux-kernel@vger.kernel.org,
        Stefan Berger <stefanb@linux.vnet.ibm.com>
Subject: [PATCH v3 3/4] ima: Do not audit if CONFIG_INTEGRITY_AUDIT is not set
Date: Mon,  4 Jun 2018 16:54:54 -0400
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180604205455.2325754-1-stefanb@linux.vnet.ibm.com>
References: <20180604205455.2325754-1-stefanb@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18060420-0016-0000-0000-000008E299D6
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009129; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000265; SDB=6.01042340; UDB=6.00533730; IPR=6.00821470;
 MB=3.00021461; MTD=3.00000008; XFM=3.00000015; UTC=2018-06-04 20:55:06
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18060420-0017-0000-0000-00003F1933FA
Message-Id: <20180604205455.2325754-4-stefanb@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-04_14:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1805220000 definitions=main-1806040238
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If Integrity is not auditing, IMA shouldn't audit, either.

Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
---
 security/integrity/ima/Kconfig      |  1 +
 security/integrity/ima/ima_policy.c |  6 +++++-
 security/integrity/integrity.h      | 15 +++++++++++++++
 3 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/security/integrity/ima/Kconfig b/security/integrity/ima/Kconfig
index 6a8f67714c83..94c2151331aa 100644
--- a/security/integrity/ima/Kconfig
+++ b/security/integrity/ima/Kconfig
@@ -12,6 +12,7 @@ config IMA
 	select TCG_TIS if TCG_TPM && X86
 	select TCG_CRB if TCG_TPM && ACPI
 	select TCG_IBMVTPM if TCG_TPM && PPC_PSERIES
+	select INTEGRITY_AUDIT if AUDIT
 	help
 	  The Trusted Computing Group(TCG) runtime Integrity
 	  Measurement Architecture(IMA) maintains a list of hash
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index 3fcf0935468c..bc99713dfe57 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -628,6 +628,9 @@ static int ima_lsm_rule_init(struct ima_rule_entry *entry,
 static void ima_log_string_op(struct audit_buffer *ab, char *key, char *value,
 			      bool (*rule_operator)(kuid_t, kuid_t))
 {
+	if (!ab)
+		return;
+
 	if (rule_operator == &uid_gt)
 		audit_log_format(ab, "%s>", key);
 	else if (rule_operator == &uid_lt)
@@ -649,7 +652,8 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
 	bool uid_token;
 	int result = 0;
 
-	ab = audit_log_start(NULL, GFP_KERNEL, AUDIT_INTEGRITY_RULE);
+	ab = integrity_audit_log_start(NULL, GFP_KERNEL,
+				       AUDIT_INTEGRITY_RULE);
 
 	entry->uid = INVALID_UID;
 	entry->fowner = INVALID_UID;
diff --git a/security/integrity/integrity.h b/security/integrity/integrity.h
index 0bb372eed62a..e60473b13a8d 100644
--- a/security/integrity/integrity.h
+++ b/security/integrity/integrity.h
@@ -15,6 +15,7 @@
 #include <linux/integrity.h>
 #include <crypto/sha.h>
 #include <linux/key.h>
+#include <linux/audit.h>
 
 /* iint action cache flags */
 #define IMA_MEASURE		0x00000001
@@ -199,6 +200,13 @@ static inline void evm_load_x509(void)
 void integrity_audit_msg(int audit_msgno, struct inode *inode,
 			 const unsigned char *fname, const char *op,
 			 const char *cause, int result, int info);
+
+static inline struct audit_buffer *
+integrity_audit_log_start(struct audit_context *ctx, gfp_t gfp_mask, int type)
+{
+	return audit_log_start(ctx, gfp_mask, type);
+}
+
 #else
 static inline void integrity_audit_msg(int audit_msgno, struct inode *inode,
 				       const unsigned char *fname,
@@ -206,4 +214,11 @@ static inline void integrity_audit_msg(int audit_msgno, struct inode *inode,
 				       int result, int info)
 {
 }
+
+static inline struct audit_buffer *
+integrity_audit_log_start(struct audit_context *ctx, gfp_t gfp_mask, int type)
+{
+	return NULL;
+}
+
 #endif
-- 
2.13.6
