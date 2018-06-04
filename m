Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751465AbeFDUzM (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 16:55:12 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:55002 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751406AbeFDUzI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 16:55:08 -0400
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
To: zohar@linux.vnet.ibm.com, paul@paul-moore.com,
        linux-integrity@vger.kernel.org, linux-audit@redhat.com
Cc: sgrubb@redhat.com, linux-kernel@vger.kernel.org,
        Stefan Berger <stefanb@linux.vnet.ibm.com>
Subject: [PATCH v3 2/4] ima: Use audit_log_format() rather than audit_log_string()
Date: Mon,  4 Jun 2018 16:54:53 -0400
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180604205455.2325754-1-stefanb@linux.vnet.ibm.com>
References: <20180604205455.2325754-1-stefanb@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18060420-0004-0000-0000-0000143E8C8F
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009130; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000265; SDB=6.01042340; UDB=6.00533730; IPR=6.00821470;
 MB=3.00021461; MTD=3.00000008; XFM=3.00000015; UTC=2018-06-04 20:55:05
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18060420-0005-0000-0000-000087901BF4
Message-Id: <20180604205455.2325754-3-stefanb@linux.vnet.ibm.com>
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

Remove the usage of audit_log_string() and replace it with
audit_log_format().

Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
Suggested-by: Steve Grubb <sgrubb@redhat.com>
Reviewed-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
Acked-by: Paul Moore <paul@paul-moore.com>
---
 security/integrity/ima/ima_policy.c  | 3 +--
 security/integrity/integrity_audit.c | 6 +-----
 2 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index 1d00db19d167..3fcf0935468c 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -634,8 +634,7 @@ static void ima_log_string_op(struct audit_buffer *ab, char *key, char *value,
 		audit_log_format(ab, "%s<", key);
 	else
 		audit_log_format(ab, "%s=", key);
-	audit_log_string(ab, value);
-	audit_log_format(ab, " ");
+	audit_log_format(ab, "%s ", value);
 }
 static void ima_log_string(struct audit_buffer *ab, char *key, char *value)
 {
diff --git a/security/integrity/integrity_audit.c b/security/integrity/integrity_audit.c
index 90987d15b6fe..db30763d5525 100644
--- a/security/integrity/integrity_audit.c
+++ b/security/integrity/integrity_audit.c
@@ -45,11 +45,7 @@ void integrity_audit_msg(int audit_msgno, struct inode *inode,
 			 from_kuid(&init_user_ns, audit_get_loginuid(current)),
 			 audit_get_sessionid(current));
 	audit_log_task_context(ab);
-	audit_log_format(ab, " op=");
-	audit_log_string(ab, op);
-	audit_log_format(ab, " cause=");
-	audit_log_string(ab, cause);
-	audit_log_format(ab, " comm=");
+	audit_log_format(ab, " op=%s cause=%s comm=", op, cause);
 	audit_log_untrustedstring(ab, get_task_comm(name, current));
 	if (fname) {
 		audit_log_format(ab, " name=");
-- 
2.13.6
