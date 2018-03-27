Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752918AbeC0N5f (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 09:57:35 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44336 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752538AbeC0N52 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 09:57:28 -0400
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
To: linux-integrity@vger.kernel.org
Cc: containers@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, tycho@docker.com,
        serge@hallyn.com, sunyuqiong1988@gmail.com, david.safford@ge.com,
        mkayaalp@cs.binghamton.edu, James.Bottomley@HansenPartnership.com,
        zohar@linux.vnet.ibm.com, ebiederm@xmission.com,
        Mehmet Kayaalp <mkayaalp@linux.vnet.ibm.com>
Subject: [RFC PATCH v3 2/3] ima: Add ns_status for storing namespaced iint data
Date: Tue, 27 Mar 2018 09:57:17 -0400
X-Mailer: git-send-email 2.5.5
In-Reply-To: <1522159038-14175-1-git-send-email-stefanb@linux.vnet.ibm.com>
References: <1522159038-14175-1-git-send-email-stefanb@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18032713-0036-0000-0000-000002D6C82B
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008753; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000255; SDB=6.01009167; UDB=6.00514062; IPR=6.00788449;
 MB=3.00020268; MTD=3.00000008; XFM=3.00000015; UTC=2018-03-27 13:57:25
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18032713-0037-0000-0000-000043C73AD7
Message-Id: <1522159038-14175-3-git-send-email-stefanb@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-27_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1803270141
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mehmet Kayaalp <mkayaalp@linux.vnet.ibm.com>

This patch adds an rbtree to the IMA namespace structure that stores a
namespaced version of iint->flags in ns_status struct. Similar to the
integrity_iint_cache, both the iint ns_struct are looked up using the
inode pointer value. The lookup, allocate, and insertion code is also
similar, except ns_struct is not free'd when the inode is free'd.
Instead, the lookup verifies the i_ino and i_generation fields are also a
match. This could be replaced by a lazy clean up of the rbtree.

Signed-off-by: Mehmet Kayaalp <mkayaalp@linux.vnet.ibm.com>

Changelog:
v2:
 * fixed tree traversal in __ima_ns_status_find()
---
 include/linux/ima.h                      |   3 +
 security/integrity/ima/ima.h             |  19 +++++
 security/integrity/ima/ima_init_ima_ns.c |   6 ++
 security/integrity/ima/ima_ns.c          | 117 +++++++++++++++++++++++++++++++
 4 files changed, 145 insertions(+)

diff --git a/include/linux/ima.h b/include/linux/ima.h
index 8bca67df0ad3..734934261011 100644
--- a/include/linux/ima.h
+++ b/include/linux/ima.h
@@ -110,6 +110,9 @@ static inline int ima_inode_removexattr(struct dentry *dentry,
 struct ima_namespace {
 	struct kref kref;
 	struct ima_namespace *parent;
+	struct rb_root ns_status_tree;
+	rwlock_t ns_status_lock;
+	struct kmem_cache *ns_status_cache;
 };
 
 extern struct ima_namespace init_ima_ns;
diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index e98c11c7cf75..e51a39ff75ff 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -128,6 +128,14 @@ static inline void ima_load_kexec_buffer(void) {}
  */
 extern bool ima_canonical_fmt;
 
+struct ns_status {
+	struct rb_node rb_node;
+	struct inode *inode;
+	ino_t i_ino;
+	u32 i_generation;
+	unsigned long flags;
+};
+
 /* Internal IMA function definitions */
 int ima_init(void);
 int ima_fs_init(void);
@@ -295,6 +303,17 @@ int ima_ns_init(void);
 struct ima_namespace;
 int ima_init_namespace(struct ima_namespace *ns);
 
+#ifdef CONFIG_IMA_NS
+struct ns_status *ima_get_ns_status(struct ima_namespace *ns,
+				    struct inode *inode);
+#else
+static inline struct ns_status *ima_get_ns_status(struct ima_namespace *ns,
+						  struct inode *inode)
+{
+	return NULL;
+}
+#endif /* CONFIG_IMA_NS */
+
 /* LSM based policy rules require audit */
 #ifdef CONFIG_IMA_LSM_RULES
 
diff --git a/security/integrity/ima/ima_init_ima_ns.c b/security/integrity/ima/ima_init_ima_ns.c
index 52cb94b1d392..66b681c1c722 100644
--- a/security/integrity/ima/ima_init_ima_ns.c
+++ b/security/integrity/ima/ima_init_ima_ns.c
@@ -12,9 +12,15 @@
 #include <linux/export.h>
 #include <linux/user_namespace.h>
 #include <linux/ima.h>
+#include <linux/slab.h>
+
+#include "ima.h"
 
 int ima_init_namespace(struct ima_namespace *ns)
 {
+	ns->ns_status_tree = RB_ROOT;
+	rwlock_init(&ns->ns_status_lock);
+	ns->ns_status_cache = KMEM_CACHE(ns_status, SLAB_PANIC);
 	return 0;
 }
 
diff --git a/security/integrity/ima/ima_ns.c b/security/integrity/ima/ima_ns.c
index 62148908015a..ef70fd1e25c6 100644
--- a/security/integrity/ima/ima_ns.c
+++ b/security/integrity/ima/ima_ns.c
@@ -69,9 +69,23 @@ struct ima_namespace *copy_ima(struct ima_namespace *old_ns)
 	return new_ns;
 }
 
+static void free_ns_status_cache(struct ima_namespace *ns)
+{
+	struct ns_status *status, *next;
+
+	write_lock(&ns->ns_status_lock);
+	rbtree_postorder_for_each_entry_safe(status, next,
+					     &ns->ns_status_tree, rb_node)
+		kmem_cache_free(ns->ns_status_cache, status);
+	ns->ns_status_tree = RB_ROOT;
+	write_unlock(&ns->ns_status_lock);
+	kmem_cache_destroy(ns->ns_status_cache);
+}
+
 static void destroy_ima_ns(struct ima_namespace *ns)
 {
 	put_ima_ns(ns->parent);
+	free_ns_status_cache(ns);
 	kfree(ns);
 }
 
@@ -84,3 +98,106 @@ void free_ima_ns(struct kref *kref)
 
 	destroy_ima_ns(ns);
 }
+
+/*
+ * __ima_ns_status_find - return the ns_status associated with an inode
+ */
+static struct ns_status *__ima_ns_status_find(struct ima_namespace *ns,
+					      struct inode *inode)
+{
+	struct ns_status *status;
+	struct rb_node *n = ns->ns_status_tree.rb_node;
+
+	while (n) {
+		status = rb_entry(n, struct ns_status, rb_node);
+
+		if (inode < status->inode)
+			n = n->rb_left;
+		else if (inode > status->inode)
+			n = n->rb_right;
+		else
+			break;
+	}
+	if (!n)
+		return NULL;
+
+	return status;
+}
+
+/*
+ * ima_ns_status_find - return the ns_status associated with an inode
+ */
+static struct ns_status *ima_ns_status_find(struct ima_namespace *ns,
+					    struct inode *inode)
+{
+	struct ns_status *status;
+
+	read_lock(&ns->ns_status_lock);
+	status = __ima_ns_status_find(ns, inode);
+	read_unlock(&ns->ns_status_lock);
+
+	return status;
+}
+
+void insert_ns_status(struct ima_namespace *ns, struct inode *inode,
+		      struct ns_status *status)
+{
+	struct rb_node **p;
+	struct rb_node *node, *parent = NULL;
+	struct ns_status *test_status;
+
+	p = &ns->ns_status_tree.rb_node;
+	while (*p) {
+		parent = *p;
+		test_status = rb_entry(parent, struct ns_status, rb_node);
+		if (inode < test_status->inode)
+			p = &(*p)->rb_left;
+		else
+			p = &(*p)->rb_right;
+	}
+	node = &status->rb_node;
+	rb_link_node(node, parent, p);
+	rb_insert_color(node, &ns->ns_status_tree);
+}
+
+struct ns_status *ima_get_ns_status(struct ima_namespace *ns,
+				    struct inode *inode)
+{
+	struct ns_status *status;
+	int skip_insert = 0;
+
+	status = ima_ns_status_find(ns, inode);
+	if (status) {
+		/*
+		 * Unlike integrity_iint_cache we are not free'ing the
+		 * ns_status data when the inode is free'd. So, in addition to
+		 * checking the inode pointer, we need to make sure the
+		 * (i_generation, i_ino) pair matches as well. In the future
+		 * we might want to add support for lazily walking the rbtree
+		 * to clean it up.
+		 */
+		if (inode->i_ino == status->i_ino &&
+		    inode->i_generation == status->i_generation)
+			return status;
+
+		/* Same inode number is reused, overwrite the ns_status */
+		skip_insert = 1;
+	} else {
+		status = kmem_cache_alloc(ns->ns_status_cache, GFP_NOFS);
+		if (!status)
+			return ERR_PTR(-ENOMEM);
+	}
+
+	write_lock(&ns->ns_status_lock);
+
+	if (!skip_insert)
+		insert_ns_status(ns, inode, status);
+
+	status->inode = inode;
+	status->i_ino = inode->i_ino;
+	status->i_generation = inode->i_generation;
+	status->flags = 0UL;
+	write_unlock(&ns->ns_status_lock);
+
+	return status;
+}
-- 
2.14.3
