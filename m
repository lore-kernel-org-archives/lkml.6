Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752981AbeC0N54 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 09:57:56 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:51770 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752856AbeC0N5b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 09:57:31 -0400
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
To: linux-integrity@vger.kernel.org
Cc: containers@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, tycho@docker.com,
        serge@hallyn.com, sunyuqiong1988@gmail.com, david.safford@ge.com,
        mkayaalp@cs.binghamton.edu, James.Bottomley@HansenPartnership.com,
        zohar@linux.vnet.ibm.com, ebiederm@xmission.com,
        Mehmet Kayaalp <mkayaalp@linux.vnet.ibm.com>
Subject: [RFC PATCH v3 3/3] ima: mamespace audit status flags
Date: Tue, 27 Mar 2018 09:57:18 -0400
X-Mailer: git-send-email 2.5.5
In-Reply-To: <1522159038-14175-1-git-send-email-stefanb@linux.vnet.ibm.com>
References: <1522159038-14175-1-git-send-email-stefanb@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18032713-0036-0000-0000-000002D6C82D
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008753; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000255; SDB=6.01009167; UDB=6.00514062; IPR=6.00788449;
 MB=3.00020268; MTD=3.00000008; XFM=3.00000015; UTC=2018-03-27 13:57:26
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18032713-0037-0000-0000-000043C73AD8
Message-Id: <1522159038-14175-4-git-send-email-stefanb@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-27_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1803270141
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mehmet Kayaalp <mkayaalp@linux.vnet.ibm.com>

The iint cache stores whether the file is measured, appraised, audited
etc. This patch moves the IMA_AUDITED flag into the per-namespace
ns_status, enabling IMA audit mechanism to audit the same file each time
it is accessed in a new namespace.

The ns_status is not looked up if the CONFIG_IMA_NS is disabled or if
any of the IMA_NS_STATUS_ACTIONS (currently only IMA_AUDIT) is not
enabled.

Read and write operations on the iint flags is replaced with function
calls. For reading, iint_flags() returns the bitwise AND of iint->flags
and ns_status->flags. The ns_status flags are masked with
IMA_NS_STATUS_FLAGS (currently only IMA_AUDITED). Similarly
set_iint_flags() only writes the masked portion to the ns_status flags,
while the iint flags is set as before. The ns_status parameter added to
ima_audit_measurement() is used with the above functions to query and
set the ns_status flags.

Signed-off-by: Mehmet Kayaalp <mkayaalp@linux.vnet.ibm.com>

Changelog:
v2:
 * fixed flag calculation in iint_flags()
---
 init/Kconfig                      |  4 +++-
 security/integrity/ima/ima.h      | 24 +++++++++++++++++++++++-
 security/integrity/ima/ima_api.c  |  8 +++++---
 security/integrity/ima/ima_main.c | 15 ++++++++++++---
 security/integrity/ima/ima_ns.c   | 22 ++++++++++++++++++++++
 5 files changed, 65 insertions(+), 8 deletions(-)

diff --git a/init/Kconfig b/init/Kconfig
index a1ad5384e081..f792ae235424 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -938,7 +938,9 @@ config IMA_NS
 	help
 	  Allow the creation of IMA namespaces for each mount namespace.
 	  Namespaced IMA data enables having IMA features work separately
-	  for each mount namespace.
+	  for each mount namespace. Currently, only the audit status flags
+	  are stored in the namespace, which allows the same file to be
+	  audited each time it is accessed in a new namespace.
 
 endif # NAMESPACES
 
diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index e51a39ff75ff..86fd3c1c0caf 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -210,7 +210,8 @@ void ima_store_measurement(struct integrity_iint_cache *iint, struct file *file,
 			   struct evm_ima_xattr_data *xattr_value,
 			   int xattr_len, int pcr);
 void ima_audit_measurement(struct integrity_iint_cache *iint,
-			   const unsigned char *filename);
+			   const unsigned char *filename,
+			   struct ns_status *status);
 int ima_alloc_init_template(struct ima_event_data *event_data,
 			    struct ima_template_entry **entry);
 int ima_store_template(struct ima_template_entry *entry, int violation,
@@ -299,6 +300,9 @@ static inline int ima_read_xattr(struct dentry *dentry,
 
 #endif /* CONFIG_IMA_APPRAISE */
 
+#define IMA_NS_STATUS_ACTIONS   IMA_AUDIT
+#define IMA_NS_STATUS_FLAGS     IMA_AUDITED
+
 int ima_ns_init(void);
 struct ima_namespace;
 int ima_init_namespace(struct ima_namespace *ns);
@@ -306,12 +310,30 @@ int ima_init_namespace(struct ima_namespace *ns);
 #ifdef CONFIG_IMA_NS
 struct ns_status *ima_get_ns_status(struct ima_namespace *ns,
 				    struct inode *inode);
+unsigned long iint_flags(struct integrity_iint_cache *iint,
+			 struct ns_status *status);
+unsigned long set_iint_flags(struct integrity_iint_cache *iint,
+			     struct ns_status *status, unsigned long flags);
 #else
 static inline struct ns_status *ima_get_ns_status(struct ima_namespace *ns,
 						  struct inode *inode)
 {
 	return NULL;
 }
+
+static inline unsigned long iint_flags(struct integrity_iint_cache *iint,
+				       struct ns_status *status)
+{
+	return iint->flags;
+}
+
+static inline unsigned long set_iint_flags(struct integrity_iint_cache *iint,
+					   struct ns_status *status,
+					   unsigned long flags)
+{
+	iint->flags = flags;
+	return flags;
+}
 #endif /* CONFIG_IMA_NS */
 
 /* LSM based policy rules require audit */
diff --git a/security/integrity/ima/ima_api.c b/security/integrity/ima/ima_api.c
index c7e8db0ea4c0..ee55dfd6afdb 100644
--- a/security/integrity/ima/ima_api.c
+++ b/security/integrity/ima/ima_api.c
@@ -304,15 +304,17 @@ void ima_store_measurement(struct integrity_iint_cache *iint,
 }
 
 void ima_audit_measurement(struct integrity_iint_cache *iint,
-			   const unsigned char *filename)
+			   const unsigned char *filename,
+			   struct ns_status *status)
 {
 	struct audit_buffer *ab;
 	char hash[(iint->ima_hash->length * 2) + 1];
 	const char *algo_name = hash_algo_name[iint->ima_hash->algo];
 	char algo_hash[sizeof(hash) + strlen(algo_name) + 2];
 	int i;
+	unsigned long flags = iint_flags(iint, status);
 
-	if (iint->flags & IMA_AUDITED)
+	if (flags & IMA_AUDITED)
 		return;
 
 	for (i = 0; i < iint->ima_hash->length; i++)
@@ -333,7 +335,7 @@ void ima_audit_measurement(struct integrity_iint_cache *iint,
 	audit_log_task_info(ab, current);
 	audit_log_end(ab);
 
-	iint->flags |= IMA_AUDITED;
+	set_iint_flags(iint, status, flags | IMA_AUDITED);
 }
 
 /*
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 770654694efc..9328e57d3f09 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -164,6 +164,7 @@ static int process_measurement(struct file *file, char *buf, loff_t size,
 {
 	struct inode *inode = file_inode(file);
 	struct integrity_iint_cache *iint = NULL;
+	struct ns_status *status = NULL;
 	struct ima_template_desc *template_desc;
 	char *pathbuf = NULL;
 	char filename[NAME_MAX];
@@ -174,6 +175,7 @@ static int process_measurement(struct file *file, char *buf, loff_t size,
 	int xattr_len = 0;
 	bool violation_check;
 	enum hash_algo hash_algo;
+	unsigned long flags;
 
 	if (!ima_policy_flag || !S_ISREG(inode->i_mode))
 		return 0;
@@ -200,6 +202,12 @@ static int process_measurement(struct file *file, char *buf, loff_t size,
 		iint = integrity_inode_get(inode);
 		if (!iint)
 			goto out;
+
+		if (action & IMA_NS_STATUS_ACTIONS) {
+			status = ima_get_ns_status(get_current_ns(), inode);
+			if (IS_ERR(status))
+				goto out;
+		}
 	}
 
 	if (violation_check) {
@@ -215,9 +223,10 @@ static int process_measurement(struct file *file, char *buf, loff_t size,
 	 * (IMA_MEASURE, IMA_MEASURED, IMA_XXXX_APPRAISE, IMA_XXXX_APPRAISED,
 	 *  IMA_AUDIT, IMA_AUDITED)
 	 */
-	iint->flags |= action;
+	flags = iint_flags(iint, status);
+	flags = set_iint_flags(iint, status, flags | action);
 	action &= IMA_DO_MASK;
-	action &= ~((iint->flags & (IMA_DONE_MASK ^ IMA_MEASURED)) >> 1);
+	action &= ~((flags & (IMA_DONE_MASK ^ IMA_MEASURED)) >> 1);
 
 	/* If target pcr is already measured, unset IMA_MEASURE action */
 	if ((action & IMA_MEASURE) && (iint->measured_pcrs & (0x1 << pcr)))
@@ -252,7 +261,7 @@ static int process_measurement(struct file *file, char *buf, loff_t size,
 		rc = ima_appraise_measurement(func, iint, file, pathname,
 					      xattr_value, xattr_len, opened);
 	if (action & IMA_AUDIT)
-		ima_audit_measurement(iint, pathname);
+		ima_audit_measurement(iint, pathname, status);
 
 	if ((file->f_flags & O_DIRECT) && (iint->flags & IMA_PERMIT_DIRECTIO))
 		rc = 0;
diff --git a/security/integrity/ima/ima_ns.c b/security/integrity/ima/ima_ns.c
index ef70fd1e25c6..8e2e388ea808 100644
--- a/security/integrity/ima/ima_ns.c
+++ b/security/integrity/ima/ima_ns.c
@@ -201,3 +201,25 @@ struct ns_status *ima_get_ns_status(struct ima_namespace *ns,
 
 	return status;
 }
+
+#define IMA_NS_STATUS_ACTIONS	IMA_AUDIT
+#define IMA_NS_STATUS_FLAGS	IMA_AUDITED
+
+unsigned long iint_flags(struct integrity_iint_cache *iint,
+			 struct ns_status *status)
+{
+	if (!status)
+		return iint->flags;
+
+	return (iint->flags & ~IMA_NS_STATUS_FLAGS) | (status->flags & IMA_NS_STATUS_FLAGS);
+}
+
+unsigned long set_iint_flags(struct integrity_iint_cache *iint,
+			     struct ns_status *status, unsigned long flags)
+{
+	iint->flags = flags;
+	if (status)
+		status->flags = flags & IMA_NS_STATUS_FLAGS;
+
+	return flags;
+}
-- 
2.14.3
