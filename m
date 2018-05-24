Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968975AbeEXULS (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 16:11:18 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:42386 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S967771AbeEXULO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 16:11:14 -0400
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
To: zohar@linux.vnet.ibm.com, sgrubb@redhat.com
Cc: linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-audit@redhat.com, Stefan Berger <stefanb@linux.vnet.ibm.com>
Subject: [PATCH 3/8] audit: Implement audit_log_tty()
Date: Thu, 24 May 2018 16:11:00 -0400
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180524201105.3179904-1-stefanb@linux.vnet.ibm.com>
References: <20180524201105.3179904-1-stefanb@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18052420-0044-0000-0000-0000041A804B
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009065; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000261; SDB=6.01036001; UDB=6.00529949; IPR=6.00815130;
 MB=3.00021234; MTD=3.00000008; XFM=3.00000015; UTC=2018-05-24 20:11:11
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18052420-0045-0000-0000-0000084C9D6D
Message-Id: <20180524201105.3179904-4-stefanb@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-24_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805240228
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement audit_log_tty() so that IMA can add tty= to its audit records.

Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
---
 include/linux/audit.h | 5 +++++
 kernel/audit.c        | 8 ++++++++
 2 files changed, 13 insertions(+)

diff --git a/include/linux/audit.h b/include/linux/audit.h
index 90aa63ddc9be..2deb76c74d10 100644
--- a/include/linux/audit.h
+++ b/include/linux/audit.h
@@ -154,6 +154,7 @@ extern void audit_log_task_info(struct audit_buffer *ab,
 				struct task_struct *tsk);
 
 extern int		    audit_update_lsm_rules(void);
+extern void audit_log_tty(struct audit_buffer *ab, struct task_struct *tsk);
 
 				/* Private API (for audit.c only) */
 extern int audit_rule_change(int type, int seq, void *data, size_t datasz);
@@ -202,6 +203,10 @@ static inline int audit_log_task_context(struct audit_buffer *ab)
 static inline void audit_log_task_info(struct audit_buffer *ab,
 				       struct task_struct *tsk)
 { }
+
+static inline void audit_log_tty(struct audit_buffer *ab,
+				 struct task_struct *tsk)
+{ }
 #define audit_enabled 0
 #endif /* CONFIG_AUDIT */
 
diff --git a/kernel/audit.c b/kernel/audit.c
index 670665c6e2a6..fa54695962b4 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -2305,6 +2305,14 @@ void audit_log_task_info(struct audit_buffer *ab, struct task_struct *tsk)
 }
 EXPORT_SYMBOL(audit_log_task_info);
 
+void audit_log_tty(struct audit_buffer *ab, struct task_struct *tsk)
+{
+	struct tty_struct *tty = audit_get_tty(tsk);
+
+	audit_log_format(ab, " tty=%s", tty ? tty_name(tty) : "(none)");
+	audit_put_tty(tty);
+}
+
 /**
  * audit_log_link_denied - report a link restriction denial
  * @operation: specific link operation
-- 
2.13.6
