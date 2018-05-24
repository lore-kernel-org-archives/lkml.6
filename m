Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S971365AbeEXUL7 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 16:11:59 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39006 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S968880AbeEXULS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 16:11:18 -0400
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
To: zohar@linux.vnet.ibm.com, sgrubb@redhat.com
Cc: linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-audit@redhat.com, Stefan Berger <stefanb@linux.vnet.ibm.com>
Subject: [PATCH 6/8] integrity: Factor out common part of integrity_audit_msg()
Date: Thu, 24 May 2018 16:11:03 -0400
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180524201105.3179904-1-stefanb@linux.vnet.ibm.com>
References: <20180524201105.3179904-1-stefanb@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18052420-0040-0000-0000-000004317D4B
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009065; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000261; SDB=6.01036001; UDB=6.00529949; IPR=6.00815130;
 MB=3.00021234; MTD=3.00000008; XFM=3.00000015; UTC=2018-05-24 20:11:14
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18052420-0041-0000-0000-000008379AE8
Message-Id: <20180524201105.3179904-7-stefanb@linux.vnet.ibm.com>
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

Factor out a common part of integrity_audit_msg() that others
can also call.

Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
---
 security/integrity/integrity.h       | 16 ++++++++++++++++
 security/integrity/integrity_audit.c | 24 ++++++++++++++++--------
 2 files changed, 32 insertions(+), 8 deletions(-)

diff --git a/security/integrity/integrity.h b/security/integrity/integrity.h
index 5e58e02ba8dc..9f2924cafa53 100644
--- a/security/integrity/integrity.h
+++ b/security/integrity/integrity.h
@@ -15,6 +15,7 @@
 #include <linux/integrity.h>
 #include <crypto/sha.h>
 #include <linux/key.h>
+#include <linux/audit.h>
 
 /* iint action cache flags */
 #define IMA_MEASURE		0x00000001
@@ -197,6 +198,11 @@ static inline void evm_load_x509(void)
 void integrity_audit_msg(int audit_msgno, struct inode *inode,
 			 const unsigned char *fname, const char *op,
 			 const char *cause, int result, int info);
+
+void integrity_audit_msg_common(struct audit_buffer *ab, struct inode *inode,
+				const unsigned char *fname, const char *op,
+				const char *cause, int result);
+
 #else
 static inline void integrity_audit_msg(int audit_msgno, struct inode *inode,
 				       const unsigned char *fname,
@@ -204,4 +210,14 @@ static inline void integrity_audit_msg(int audit_msgno, struct inode *inode,
 				       int result, int info)
 {
 }
+
+static inline void integrity_audit_msg_common(struct audit_buffer *ab,
+					      struct inode *inode,
+					      const unsigned char *fname,
+					      const char *op,
+					      const char *cause,
+					      int result)
+{
+}
+
 #endif
diff --git a/security/integrity/integrity_audit.c b/security/integrity/integrity_audit.c
index 8d25d3c4dcca..8f80b7c042a7 100644
--- a/security/integrity/integrity_audit.c
+++ b/security/integrity/integrity_audit.c
@@ -28,17 +28,12 @@ static int __init integrity_audit_setup(char *str)
 }
 __setup("integrity_audit=", integrity_audit_setup);
 
-void integrity_audit_msg(int audit_msgno, struct inode *inode,
-			 const unsigned char *fname, const char *op,
-			 const char *cause, int result, int audit_info)
+void integrity_audit_msg_common(struct audit_buffer *ab, struct inode *inode,
+				const unsigned char *fname, const char *op,
+				const char *cause, int result)
 {
-	struct audit_buffer *ab;
 	char name[TASK_COMM_LEN];
 
-	if (!integrity_audit_info && audit_info == 1)	/* Skip info messages */
-		return;
-
-	ab = audit_log_start(current->audit_context, GFP_KERNEL, audit_msgno);
 	audit_log_format(ab, "pid=%d uid=%u auid=%u ses=%u",
 			 task_pid_nr(current),
 			 from_kuid(&init_user_ns, current_cred()->uid),
@@ -59,5 +54,18 @@ void integrity_audit_msg(int audit_msgno, struct inode *inode,
 	audit_log_d_path_exe(ab, current->mm);
 	audit_log_tty(ab, current);
 	audit_log_format(ab, " res=%d", !result);
+}
+
+void integrity_audit_msg(int audit_msgno, struct inode *inode,
+			 const unsigned char *fname, const char *op,
+			 const char *cause, int result, int audit_info)
+{
+	struct audit_buffer *ab;
+
+	if (!integrity_audit_info && audit_info == 1)	/* Skip info messages */
+		return;
+
+	ab = audit_log_start(current->audit_context, GFP_KERNEL, audit_msgno);
+	integrity_audit_msg_common(ab, inode, fname, op, cause, result);
 	audit_log_end(ab);
 }
-- 
2.13.6
