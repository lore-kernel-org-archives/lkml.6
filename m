Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932626AbeCIUOw (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 15:14:52 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34752 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S932377AbeCIUOn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 15:14:43 -0500
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
To: linux-ima-devel@lists.sourceforge.net
Cc: containers@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, tycho@docker.com,
        serge@hallyn.com, sunyuqiong1988@gmail.com, david.safford@ge.com,
        mkayaalp@cs.binghamton.edu, linux-integrity@vger.kernel.org,
        James.Bottomley@HansenPartnership.com, zohar@linux.vnet.ibm.com,
        Mehmet Kayaalp <mkayaalp@linux.vnet.ibm.com>
Subject: [RFC PATCH v2 2/3] ima: Add ns_status for storing namespaced iint data
Date: Fri,  9 Mar 2018 15:14:20 -0500
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180309201421.6150-1-stefanb@linux.vnet.ibm.com>
References: <20180309201421.6150-1-stefanb@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18030920-0048-0000-0000-00000247A6C8
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008642; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000254; SDB=6.01000666; UDB=6.00509012; IPR=6.00779996;
 MB=3.00019944; MTD=3.00000008; XFM=3.00000015; UTC=2018-03-09 20:14:40
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18030920-0049-0000-0000-000044633678
Message-Id: <20180309201421.6150-3-stefanb@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-09_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1803090239
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
---
 include/linux/ima.h                      |   3 +
 security/integrity/ima/ima.h             |  19 +++++
 security/integrity/ima/ima_init_ima_ns.c |   6 ++
 security/integrity/ima/ima_ns.c          | 117 +++++++++++++++++++++++++++++++
 4 files changed, 145 insertions(+)

diff --git a/include/linux/ima.h b/include/linux/ima.h
index fd150dfde277..52c9d338819c 100644
--- a/include/linux/ima.h
+++ b/include/linux/ima.h
@@ -111,6 +111,9 @@ struct ima_namespace {
 	struct kref kref;
 	struct user_namespace *user_ns;
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
index 4b081dbfac07..9e0d5fafdfba 100644
--- a/security/integrity/ima/ima_init_ima_ns.c
+++ b/security/integrity/ima/ima_init_ima_ns.c
@@ -10,9 +10,15 @@
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
index 7ab4322c88ae..03acf1431868 100644
--- a/security/integrity/ima/ima_ns.c
+++ b/security/integrity/ima/ima_ns.c
@@ -73,10 +73,24 @@ struct ima_namespace *copy_ima(struct user_namespace *user_ns,
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
 	put_user_ns(ns->user_ns);
 	put_ima_ns(ns->parent);
+	free_ns_status_cache(ns);
 	kfree(ns);
 }
 
@@ -89,3 +103,106 @@ void free_ima_ns(struct kref *kref)
 
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
2.13.6
