Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S971352AbeEXUL5 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 16:11:57 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:41046 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S969004AbeEXULT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 16:11:19 -0400
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
To: zohar@linux.vnet.ibm.com, sgrubb@redhat.com
Cc: linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-audit@redhat.com, Stefan Berger <stefanb@linux.vnet.ibm.com>
Subject: [PATCH 7/8] ima: Do not audit if CONFIG_INTEGRITY_AUDIT is not set
Date: Thu, 24 May 2018 16:11:04 -0400
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180524201105.3179904-1-stefanb@linux.vnet.ibm.com>
References: <20180524201105.3179904-1-stefanb@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18052420-0056-0000-0000-000004547EDA
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009065; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000261; SDB=6.01036001; UDB=6.00529949; IPR=6.00815130;
 MB=3.00021234; MTD=3.00000008; XFM=3.00000015; UTC=2018-05-24 20:11:16
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18052420-0057-0000-0000-000008989C3B
Message-Id: <20180524201105.3179904-8-stefanb@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-24_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805240228
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If Integrity is not auditing, IMA shouldn't audit, either.

Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
---
 security/integrity/ima/Kconfig      |  1 +
 security/integrity/ima/ima_policy.c |  6 +++++-
 security/integrity/integrity.h      | 10 ++++++++++
 3 files changed, 16 insertions(+), 1 deletion(-)

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
index 7297450b813c..3aed25a7178a 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -609,6 +609,9 @@ static int ima_lsm_rule_init(struct ima_rule_entry *entry,
 static void ima_log_string_op(struct audit_buffer *ab, char *key, char *value,
 			      bool (*rule_operator)(kuid_t, kuid_t))
 {
+	if (!ab)
+		return;
+
 	if (rule_operator == &uid_gt)
 		audit_log_format(ab, "%s>", key);
 	else if (rule_operator == &uid_lt)
@@ -630,7 +633,8 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
 	bool uid_token;
 	int result = 0;
 
-	ab = audit_log_start(NULL, GFP_KERNEL, AUDIT_INTEGRITY_RULE);
+	ab = integrity_audit_log_start(NULL, GFP_KERNEL,
+				       AUDIT_INTEGRITY_RULE);
 
 	entry->uid = INVALID_UID;
 	entry->fowner = INVALID_UID;
diff --git a/security/integrity/integrity.h b/security/integrity/integrity.h
index 9f2924cafa53..2afa266aea42 100644
--- a/security/integrity/integrity.h
+++ b/security/integrity/integrity.h
@@ -203,6 +203,11 @@ void integrity_audit_msg_common(struct audit_buffer *ab, struct inode *inode,
 				const unsigned char *fname, const char *op,
 				const char *cause, int result);
 
+static inline struct audit_buffer *
+integrity_audit_log_start(struct audit_context *ctx, gfp_t gfp_mask, int type)
+{
+	return audit_log_start(ctx, gfp_mask, type);
+}
 #else
 static inline void integrity_audit_msg(int audit_msgno, struct inode *inode,
 				       const unsigned char *fname,
@@ -220,4 +225,9 @@ static inline void integrity_audit_msg_common(struct audit_buffer *ab,
 {
 }
 
+static inline struct audit_buffer *
+integrity_audit_log_start(struct audit_context *ctx, gfp_t gfp_mask, int type)
+{
+	return NULL;
+}
 #endif
-- 
2.13.6
