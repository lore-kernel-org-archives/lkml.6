Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S971340AbeEXULx (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 16:11:53 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:33512 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S971302AbeEXULU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 16:11:20 -0400
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
To: zohar@linux.vnet.ibm.com, sgrubb@redhat.com
Cc: linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-audit@redhat.com, Stefan Berger <stefanb@linux.vnet.ibm.com>
Subject: [PATCH 8/8] ima: Differentiate auditing policy rules from "audit" actions
Date: Thu, 24 May 2018 16:11:05 -0400
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180524201105.3179904-1-stefanb@linux.vnet.ibm.com>
References: <20180524201105.3179904-1-stefanb@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18052420-0040-0000-0000-000004317D4E
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009065; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000261; SDB=6.01036001; UDB=6.00529949; IPR=6.00815130;
 MB=3.00021234; MTD=3.00000008; XFM=3.00000015; UTC=2018-05-24 20:11:16
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18052420-0041-0000-0000-000008379AEC
Message-Id: <20180524201105.3179904-9-stefanb@linux.vnet.ibm.com>
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

The AUDIT_INTEGRITY_RULE is used for auditing IMA policy rules and
the IMA "audit" policy action.  This patch defines
AUDIT_INTEGRITY_POLICY_RULE to reflect the IMA policy rules.

With this change we now call integrity_audit_msg_common() to get
common integrity auditing fields. This now produces the following
record when parsing an IMA policy rule:

type=UNKNOWN[1806] msg=audit(1527004216.690:311): action=dont_measure \
  fsmagic=0x9fa0 pid=1613 uid=0 auid=0 ses=2 \
  subj=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 \
  op=policy_update cause=parse_rule comm="echo" exe="/usr/bin/echo" \
  tty=tty2 res=1

Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
---
 include/uapi/linux/audit.h          | 3 ++-
 security/integrity/ima/ima_policy.c | 5 +++--
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/include/uapi/linux/audit.h b/include/uapi/linux/audit.h
index 4e61a9e05132..776e0abd35cf 100644
--- a/include/uapi/linux/audit.h
+++ b/include/uapi/linux/audit.h
@@ -146,7 +146,8 @@
 #define AUDIT_INTEGRITY_STATUS	    1802 /* Integrity enable status */
 #define AUDIT_INTEGRITY_HASH	    1803 /* Integrity HASH type */
 #define AUDIT_INTEGRITY_PCR	    1804 /* PCR invalidation msgs */
-#define AUDIT_INTEGRITY_RULE	    1805 /* policy rule */
+#define AUDIT_INTEGRITY_RULE	    1805 /* IMA "audit" action policy msgs  */
+#define AUDIT_INTEGRITY_POLICY_RULE 1806 /* IMA policy rules */
 
 #define AUDIT_KERNEL		2000	/* Asynchronous audit record. NOT A REQUEST. */
 
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index 3aed25a7178a..a8ae47a386b4 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -634,7 +634,7 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
 	int result = 0;
 
 	ab = integrity_audit_log_start(NULL, GFP_KERNEL,
-				       AUDIT_INTEGRITY_RULE);
+				       AUDIT_INTEGRITY_POLICY_RULE);
 
 	entry->uid = INVALID_UID;
 	entry->fowner = INVALID_UID;
@@ -926,7 +926,8 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
 		temp_ima_appraise |= IMA_APPRAISE_FIRMWARE;
 	else if (entry->func == POLICY_CHECK)
 		temp_ima_appraise |= IMA_APPRAISE_POLICY;
-	audit_log_format(ab, "res=%d", !result);
+	integrity_audit_msg_common(ab, NULL, NULL,
+				   "policy_update", "parse_rule", result);
 	audit_log_end(ab);
 	return result;
 }
-- 
2.13.6
