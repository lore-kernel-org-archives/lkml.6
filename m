Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751625AbeFDUzw (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 16:55:52 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34864 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751427AbeFDUzK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 16:55:10 -0400
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
To: zohar@linux.vnet.ibm.com, paul@paul-moore.com,
        linux-integrity@vger.kernel.org, linux-audit@redhat.com
Cc: sgrubb@redhat.com, linux-kernel@vger.kernel.org,
        Stefan Berger <stefanb@linux.vnet.ibm.com>
Subject: [PATCH v3 4/4] ima: Differentiate auditing policy rules from "audit" actions
Date: Mon,  4 Jun 2018 16:54:55 -0400
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180604205455.2325754-1-stefanb@linux.vnet.ibm.com>
References: <20180604205455.2325754-1-stefanb@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18060420-0016-0000-0000-000008E299DD
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009129; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000265; SDB=6.01042340; UDB=6.00533730; IPR=6.00821470;
 MB=3.00021461; MTD=3.00000008; XFM=3.00000015; UTC=2018-06-04 20:55:08
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18060420-0017-0000-0000-00003F193406
Message-Id: <20180604205455.2325754-5-stefanb@linux.vnet.ibm.com>
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

The AUDIT_INTEGRITY_RULE is used for auditing IMA policy rules and
the IMA "audit" policy action.  This patch defines
AUDIT_INTEGRITY_POLICY_RULE to reflect the IMA policy rules.

Since we defined a new message type we can now also pass the
audit_context and get an associated SYSCALL record. This now produces
the following records when parsing IMA policy's rules:

type=UNKNOWN[1807] msg=audit(1527888965.738:320): action=audit \
  func=MMAP_CHECK mask=MAY_EXEC res=1
type=UNKNOWN[1807] msg=audit(1527888965.738:320): action=audit \
  func=FILE_CHECK mask=MAY_READ res=1
type=SYSCALL msg=audit(1527888965.738:320): arch=c000003e syscall=1 \
  success=yes exit=17 a0=1 a1=55bcfcca9030 a2=11 a3=7fcc1b55fb38 \
  items=0 ppid=1567 pid=1601 auid=0 uid=0 gid=0 euid=0 suid=0 \
  fsuid=0 egid=0 sgid=0 fsgid=0 tty=tty2 ses=2 comm="echo" \
  exe="/usr/bin/echo" \
  subj=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 key=(null)

Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
---
 include/uapi/linux/audit.h          | 1 +
 security/integrity/ima/ima_policy.c | 4 ++--
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/audit.h b/include/uapi/linux/audit.h
index 65d9293f1fb8..cb358551376b 100644
--- a/include/uapi/linux/audit.h
+++ b/include/uapi/linux/audit.h
@@ -148,6 +148,7 @@
 #define AUDIT_INTEGRITY_PCR	    1804 /* PCR invalidation msgs */
 #define AUDIT_INTEGRITY_RULE	    1805 /* policy rule */
 #define AUDIT_INTEGRITY_EVM_XATTR   1806 /* New EVM-covered xattr */
+#define AUDIT_INTEGRITY_POLICY_RULE 1807 /* IMA policy rules */
 
 #define AUDIT_KERNEL		2000	/* Asynchronous audit record. NOT A REQUEST. */
 
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index bc99713dfe57..f7230db217a7 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -652,8 +652,8 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
 	bool uid_token;
 	int result = 0;
 
-	ab = integrity_audit_log_start(NULL, GFP_KERNEL,
-				       AUDIT_INTEGRITY_RULE);
+	ab = integrity_audit_log_start(current->audit_context, GFP_KERNEL,
+				       AUDIT_INTEGRITY_POLICY_RULE);
 
 	entry->uid = INVALID_UID;
 	entry->fowner = INVALID_UID;
-- 
2.13.6
