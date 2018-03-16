Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753334AbeCPSQm (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 14:16:42 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40440 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753020AbeCPSOf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 14:14:35 -0400
From: Waiman Long <longman@redhat.com>
To: "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-doc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH v5 8/9] ipc: Allow boot time extension of IPCMNI from 32k to 2M
Date: Fri, 16 Mar 2018 14:13:49 -0400
Message-Id: <1521224030-2185-9-git-send-email-longman@redhat.com>
In-Reply-To: <1521224030-2185-1-git-send-email-longman@redhat.com>
References: <1521224030-2185-1-git-send-email-longman@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The maximum number of unique System V IPC identifiers was limited to
32k.  That limit should be big enough for most use cases.

However, there are some users out there requesting for more. To satisfy
the need of those users, a new boot time kernel option "ipcmni_extend"
is added to extend the IPCMNI value to 2M. This is a 64X increase which
hopefully is big enough for them.

This new option does have the side effect of reducing the maximum
number of unique sequence numbers from 64k down to 1k. So it is
a trade-off.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 Documentation/admin-guide/kernel-parameters.txt |  3 +++
 include/linux/ipc.h                             | 11 ++++++++++-
 ipc/ipc_sysctl.c                                | 12 +++++++++++-
 ipc/util.c                                      | 12 ++++++------
 ipc/util.h                                      | 18 +++++++++++-------
 5 files changed, 41 insertions(+), 15 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 1d1d53f..2be35a4 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1733,6 +1733,9 @@
 	ip=		[IP_PNP]
 			See Documentation/filesystems/nfs/nfsroot.txt.
 
+	ipcmni_extend	[KNL] Extend the maximum number of unique System V
+			IPC identifiers from 32768 to 2097152.
+
 	irqaffinity=	[SMP] Set the default irq affinity mask
 			The argument is a cpu list, as described above.
 
diff --git a/include/linux/ipc.h b/include/linux/ipc.h
index 821b2f2..3ecd869 100644
--- a/include/linux/ipc.h
+++ b/include/linux/ipc.h
@@ -8,7 +8,16 @@
 #include <uapi/linux/ipc.h>
 #include <linux/refcount.h>
 
-#define IPCMNI 32768  /* <= MAX_INT limit for ipc arrays (including sysctl changes) */
+/*
+ * By default, the ipc arrays can have up to 32k (15 bits) entries.
+ * When IPCMNI extension mode is turned on, the ipc arrays can have up
+ * to 2M (21 bits) entries. However, the space for sequence number will
+ * be shrunk from 16 bits to 10 bits.
+ */
+#define IPCMNI_SHIFT		15
+#define IPCMNI_EXTEND_SHIFT	21
+#define IPCMNI			(1 << IPCMNI_SHIFT)
+#define IPCMNI_EXTEND		(1 << IPCMNI_EXTEND_SHIFT)
 
 /* used by in-kernel data structures */
 struct kern_ipc_perm {
diff --git a/ipc/ipc_sysctl.c b/ipc/ipc_sysctl.c
index 0ad7088..5f7cfae 100644
--- a/ipc/ipc_sysctl.c
+++ b/ipc/ipc_sysctl.c
@@ -109,7 +109,8 @@ static int proc_ipc_sem_dointvec(struct ctl_table *table, int write,
 static int zero;
 static int one = 1;
 static int int_max = INT_MAX;
-static int ipc_mni = IPCMNI;
+int ipc_mni __read_mostly = IPCMNI;
+int ipc_mni_shift __read_mostly = IPCMNI_SHIFT;
 
 static struct ctl_table ipc_kern_table[] = {
 	{
@@ -237,3 +238,12 @@ static int __init ipc_sysctl_init(void)
 }
 
 device_initcall(ipc_sysctl_init);
+
+static int __init ipc_mni_extend(char *str)
+{
+	ipc_mni = IPCMNI_EXTEND;
+	ipc_mni_shift = IPCMNI_EXTEND_SHIFT;
+	pr_info("IPCMNI extended to %d.\n", ipc_mni);
+	return 0;
+}
+early_param("ipcmni_extend", ipc_mni_extend);
diff --git a/ipc/util.c b/ipc/util.c
index 4ed5a17..daee305 100644
--- a/ipc/util.c
+++ b/ipc/util.c
@@ -112,7 +112,7 @@ static int __init ipc_init(void)
  * @ids: ipc identifier set
  *
  * Set up the sequence range to use for the ipc identifier range (limited
- * below IPCMNI) then initialise the keys hashtable and ids idr.
+ * below ipc_mni) then initialise the keys hashtable and ids idr.
  */
 int ipc_init_ids(struct ipc_ids *ids)
 {
@@ -213,7 +213,7 @@ static inline int ipc_buildid(int id, struct ipc_ids *ids,
 		ids->next_id = -1;
 	}
 
-	return SEQ_MULTIPLIER * new->seq + id;
+	return (new->seq << SEQ_SHIFT) + id;
 }
 
 #else
@@ -227,7 +227,7 @@ static inline int ipc_buildid(int id, struct ipc_ids *ids,
 	if (ids->seq > IPCID_SEQ_MAX)
 		ids->seq = 0;
 
-	return SEQ_MULTIPLIER * new->seq + id;
+	return (new->seq << SEQ_SHIFT) + id;
 }
 
 #endif /* CONFIG_CHECKPOINT_RESTORE */
@@ -251,8 +251,8 @@ int ipc_addid(struct ipc_ids *ids, struct kern_ipc_perm *new, int limit)
 	kgid_t egid;
 	int id, err;
 
-	if (limit > IPCMNI)
-		limit = IPCMNI;
+	if (limit > ipc_mni)
+		limit = ipc_mni;
 
 	if (!ids->tables_initialized || ids->in_use >= limit)
 		return -ENOSPC;
@@ -769,7 +769,7 @@ static struct kern_ipc_perm *sysvipc_find_ipc(struct ipc_ids *ids, loff_t pos,
 	if (total >= ids->in_use)
 		return NULL;
 
-	for (; pos < IPCMNI; pos++) {
+	for (; pos < ipc_mni; pos++) {
 		ipc = idr_find(&ids->ipcs_idr, pos);
 		if (ipc != NULL) {
 			*new_pos = pos + 1;
diff --git a/ipc/util.h b/ipc/util.h
index af57394..6871ca9 100644
--- a/ipc/util.h
+++ b/ipc/util.h
@@ -15,7 +15,11 @@
 #include <linux/err.h>
 #include <linux/ipc_namespace.h>
 
-#define SEQ_MULTIPLIER	(IPCMNI)
+extern int ipc_mni;
+extern int ipc_mni_shift;
+
+#define SEQ_SHIFT	ipc_mni_shift
+#define SEQ_MASK	((1 << ipc_mni_shift) - 1)
 
 int sem_init(void);
 int msg_init(void);
@@ -93,9 +97,9 @@ void __init ipc_init_proc_interface(const char *path, const char *header,
 #define IPC_MSG_IDS	1
 #define IPC_SHM_IDS	2
 
-#define ipcid_to_idx(id) ((id) % SEQ_MULTIPLIER)
-#define ipcid_to_seqx(id) ((id) / SEQ_MULTIPLIER)
-#define IPCID_SEQ_MAX min_t(int, INT_MAX/SEQ_MULTIPLIER, USHRT_MAX)
+#define ipcid_to_idx(id)  ((id) & SEQ_MASK)
+#define ipcid_to_seqx(id) ((id) >> SEQ_SHIFT)
+#define IPCID_SEQ_MAX	  (INT_MAX >> SEQ_SHIFT)
 
 /* must be called with ids->rwsem acquired for writing */
 int ipc_addid(struct ipc_ids *, struct kern_ipc_perm *, int);
@@ -120,8 +124,8 @@ static inline int ipc_get_maxid(struct ipc_ids *ids)
 	if (ids->in_use == 0)
 		return -1;
 
-	if (ids->in_use == IPCMNI)
-		return IPCMNI - 1;
+	if (ids->in_use == ipc_mni)
+		return ipc_mni - 1;
 
 	return ids->max_id;
 }
@@ -163,7 +167,7 @@ struct kern_ipc_perm *ipcctl_pre_down_nolock(struct ipc_namespace *ns,
 
 static inline int ipc_checkid(struct kern_ipc_perm *ipcp, int uid)
 {
-	return uid / SEQ_MULTIPLIER != ipcp->seq;
+	return (uid >> SEQ_SHIFT) != ipcp->seq;
 }
 
 static inline void ipc_lock_object(struct kern_ipc_perm *perm)
-- 
1.8.3.1
