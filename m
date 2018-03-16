Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753178AbeCPSQZ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 14:16:25 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39096 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753063AbeCPSOg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 14:14:36 -0400
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
Subject: [PATCH v5 9/9] ipc: Conserve sequence numbers in extended IPCMNI mode
Date: Fri, 16 Mar 2018 14:13:50 -0400
Message-Id: <1521224030-2185-10-git-send-email-longman@redhat.com>
In-Reply-To: <1521224030-2185-1-git-send-email-longman@redhat.com>
References: <1521224030-2185-1-git-send-email-longman@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The mixing in of a sequence number into the IPC IDs is probably to
avoid ID reuse in userspace as much as possible. With extended IPCMNI
mode, the number of usable sequecne numbers is greatly reduced leading
to higher chance of ID reuse.

To address this issue, we need to conserve the sequence number space
as much as possible. Right now, the sequence number is incremented
for every new ID created. In reality, we only need to increment the
sequence number when one or more IDs have been removed previously to
make sure that those IDs will not be reused when a new one is built.
This is being done in the extended IPCMNI mode,

Signed-off-by: Waiman Long <longman@redhat.com>
---
 include/linux/ipc_namespace.h |  1 +
 ipc/ipc_sysctl.c              |  2 ++
 ipc/util.c                    | 29 ++++++++++++++++++++++-------
 ipc/util.h                    |  1 +
 4 files changed, 26 insertions(+), 7 deletions(-)

diff --git a/include/linux/ipc_namespace.h b/include/linux/ipc_namespace.h
index b5630c8..9c86fd9 100644
--- a/include/linux/ipc_namespace.h
+++ b/include/linux/ipc_namespace.h
@@ -16,6 +16,7 @@
 struct ipc_ids {
 	int in_use;
 	unsigned short seq;
+	unsigned short deleted;
 	bool tables_initialized;
 	struct rw_semaphore rwsem;
 	struct idr ipcs_idr;
diff --git a/ipc/ipc_sysctl.c b/ipc/ipc_sysctl.c
index 5f7cfae..61a832d 100644
--- a/ipc/ipc_sysctl.c
+++ b/ipc/ipc_sysctl.c
@@ -111,6 +111,7 @@ static int proc_ipc_sem_dointvec(struct ctl_table *table, int write,
 static int int_max = INT_MAX;
 int ipc_mni __read_mostly = IPCMNI;
 int ipc_mni_shift __read_mostly = IPCMNI_SHIFT;
+bool ipc_mni_extended __read_mostly;
 
 static struct ctl_table ipc_kern_table[] = {
 	{
@@ -243,6 +244,7 @@ static int __init ipc_mni_extend(char *str)
 {
 	ipc_mni = IPCMNI_EXTEND;
 	ipc_mni_shift = IPCMNI_EXTEND_SHIFT;
+	ipc_mni_extended = true;
 	pr_info("IPCMNI extended to %d.\n", ipc_mni);
 	return 0;
 }
diff --git a/ipc/util.c b/ipc/util.c
index daee305..8b38a6f 100644
--- a/ipc/util.c
+++ b/ipc/util.c
@@ -118,7 +118,8 @@ int ipc_init_ids(struct ipc_ids *ids)
 {
 	int err;
 	ids->in_use = 0;
-	ids->seq = 0;
+	ids->deleted = false;
+	ids->seq = ipc_mni_extended ? 0 : -1; /* seq # is pre-incremented */
 	init_rwsem(&ids->rwsem);
 	err = rhashtable_init(&ids->key_ht, &ipc_kht_params);
 	if (err)
@@ -192,6 +193,11 @@ static struct kern_ipc_perm *ipc_findkey(struct ipc_ids *ids, key_t key)
 	return NULL;
 }
 
+/*
+ * To conserve sequence number space with extended ipc_mni when new ID
+ * is built, the sequence number is incremented only when one or more
+ * IDs have been removed previously.
+ */
 #ifdef CONFIG_CHECKPOINT_RESTORE
 /*
  * Specify desired id for next allocated IPC object.
@@ -205,9 +211,13 @@ static inline int ipc_buildid(int id, struct ipc_ids *ids,
 			      struct kern_ipc_perm *new)
 {
 	if (ids->next_id < 0) { /* default, behave as !CHECKPOINT_RESTORE */
-		new->seq = ids->seq++;
-		if (ids->seq > IPCID_SEQ_MAX)
-			ids->seq = 0;
+		if (!ipc_mni_extended || ids->deleted) {
+			ids->seq++;
+			if (ids->seq > IPCID_SEQ_MAX)
+				ids->seq = 0;
+			ids->deleted = false;
+		}
+		new->seq = ids->seq;
 	} else {
 		new->seq = ipcid_to_seqx(ids->next_id);
 		ids->next_id = -1;
@@ -223,9 +233,13 @@ static inline int ipc_buildid(int id, struct ipc_ids *ids,
 static inline int ipc_buildid(int id, struct ipc_ids *ids,
 			      struct kern_ipc_perm *new)
 {
-	new->seq = ids->seq++;
-	if (ids->seq > IPCID_SEQ_MAX)
-		ids->seq = 0;
+	if (!ipc_mni_extended || ids->deleted) {
+		ids->seq++;
+		if (ids->seq > IPCID_SEQ_MAX)
+			ids->seq = 0;
+		ids->deleted = false;
+	}
+	new->seq = ids->seq;
 
 	return (new->seq << SEQ_SHIFT) + id;
 }
@@ -435,6 +449,7 @@ void ipc_rmid(struct ipc_ids *ids, struct kern_ipc_perm *ipcp)
 	idr_remove(&ids->ipcs_idr, lid);
 	ipc_kht_remove(ids, ipcp);
 	ids->in_use--;
+	ids->deleted = true;
 	ipcp->deleted = true;
 
 	if (unlikely(lid == ids->max_id)) {
diff --git a/ipc/util.h b/ipc/util.h
index 6871ca9..e6c2055 100644
--- a/ipc/util.h
+++ b/ipc/util.h
@@ -17,6 +17,7 @@
 
 extern int ipc_mni;
 extern int ipc_mni_shift;
+extern bool ipc_mni_extended;
 
 #define SEQ_SHIFT	ipc_mni_shift
 #define SEQ_MASK	((1 << ipc_mni_shift) - 1)
-- 
1.8.3.1
