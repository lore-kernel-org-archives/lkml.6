Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4A43C0044C
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 20:11:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AAEA20855
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 20:11:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AAEA20855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728214AbeKJFx6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 00:53:58 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49274 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725872AbeKJFx6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 00:53:58 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6F09C308428C;
        Fri,  9 Nov 2018 20:11:50 +0000 (UTC)
Received: from llong.com (dhcp-17-55.bos.redhat.com [10.18.17.55])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 09830608C8;
        Fri,  9 Nov 2018 20:11:48 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-doc@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Takashi Iwai <tiwai@suse.de>, Davidlohr Bueso <dbueso@suse.de>,
        Manfred Spraul <manfred@colorfullife.com>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH v11 1/3] ipc: Allow boot time extension of IPCMNI from 32k to 16M
Date:   Fri,  9 Nov 2018 15:11:30 -0500
Message-Id: <1541794292-19425-2-git-send-email-longman@redhat.com>
In-Reply-To: <1541794292-19425-1-git-send-email-longman@redhat.com>
References: <1541794292-19425-1-git-send-email-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Fri, 09 Nov 2018 20:11:50 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The maximum number of unique System V IPC identifiers was limited to
32k.  That limit should be big enough for most use cases.

However, there are some users out there requesting for more, especially
those that are migrating from Solaris which uses 24 bits for unique
identifiers. To satisfy the need of those users, a new boot time kernel
option "ipcmni_extend" is added to extend the IPCMNI value to 16M. This
is a 512X increase which should be big enough for users out there that
need a large number of unique IPC identifier.

The use of this new option will change the pattern of the IPC identifiers
returned by functions like shmget(2). An application that depends on
such pattern may not work properly.  So it should only be used if the
users really need more than 32k of unique IPC numbers.

This new option does have the side effect of reducing the maximum number
of unique sequence numbers from 64k down to 128. So it is a trade-off.

The computation of a new IPC id is not done in the performance critical
path.  So a little bit of additional overhead shouldn't have any real
performance impact.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 Documentation/admin-guide/kernel-parameters.txt |  3 ++
 ipc/ipc_sysctl.c                                | 12 ++++++-
 ipc/util.c                                      | 10 +++---
 ipc/util.h                                      | 44 ++++++++++++++++++++-----
 4 files changed, 54 insertions(+), 15 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 81d1d5a..93d1454 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1799,6 +1799,9 @@
 	ip=		[IP_PNP]
 			See Documentation/filesystems/nfs/nfsroot.txt.
 
+	ipcmni_extend	[KNL] Extend the maximum number of unique System V
+			IPC identifiers from 32,768 to 16,777,216.
+
 	irqaffinity=	[SMP] Set the default irq affinity mask
 			The argument is a cpu list, as described above.
 
diff --git a/ipc/ipc_sysctl.c b/ipc/ipc_sysctl.c
index 49f9bf4..73b7782 100644
--- a/ipc/ipc_sysctl.c
+++ b/ipc/ipc_sysctl.c
@@ -120,7 +120,8 @@ static int proc_ipc_sem_dointvec(struct ctl_table *table, int write,
 static int zero;
 static int one = 1;
 static int int_max = INT_MAX;
-static int ipc_mni = IPCMNI;
+int ipc_mni = IPCMNI;
+int ipc_mni_shift = IPCMNI_SHIFT;
 
 static struct ctl_table ipc_kern_table[] = {
 	{
@@ -246,3 +247,12 @@ static int __init ipc_sysctl_init(void)
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
index 0af0575..07ae117 100644
--- a/ipc/util.c
+++ b/ipc/util.c
@@ -110,7 +110,7 @@ static int __init ipc_init(void)
  * @ids: ipc identifier set
  *
  * Set up the sequence range to use for the ipc identifier range (limited
- * below IPCMNI) then initialise the keys hashtable and ids idr.
+ * below ipc_mni) then initialise the keys hashtable and ids idr.
  */
 void ipc_init_ids(struct ipc_ids *ids)
 {
@@ -226,7 +226,7 @@ static inline int ipc_idr_alloc(struct ipc_ids *ids, struct kern_ipc_perm *new)
 				0, GFP_NOWAIT);
 	}
 	if (idx >= 0)
-		new->id = SEQ_MULTIPLIER * new->seq + idx;
+		new->id = (new->seq << IPCMNI_SEQ_SHIFT) + idx;
 	return idx;
 }
 
@@ -254,8 +254,8 @@ int ipc_addid(struct ipc_ids *ids, struct kern_ipc_perm *new, int limit)
 	/* 1) Initialize the refcount so that ipc_rcu_putref works */
 	refcount_set(&new->refcount, 1);
 
-	if (limit > IPCMNI)
-		limit = IPCMNI;
+	if (limit > ipc_mni)
+		limit = ipc_mni;
 
 	if (ids->in_use >= limit)
 		return -ENOSPC;
@@ -738,7 +738,7 @@ static struct kern_ipc_perm *sysvipc_find_ipc(struct ipc_ids *ids, loff_t pos,
 	if (total >= ids->in_use)
 		return NULL;
 
-	for (; pos < IPCMNI; pos++) {
+	for (; pos < ipc_mni; pos++) {
 		ipc = idr_find(&ids->ipcs_idr, pos);
 		if (ipc != NULL) {
 			*new_pos = pos + 1;
diff --git a/ipc/util.h b/ipc/util.h
index d768fdb..6a88d51 100644
--- a/ipc/util.h
+++ b/ipc/util.h
@@ -15,8 +15,34 @@
 #include <linux/err.h>
 #include <linux/ipc_namespace.h>
 
-#define IPCMNI 32768  /* <= MAX_INT limit for ipc arrays (including sysctl changes) */
-#define SEQ_MULTIPLIER	(IPCMNI)
+/*
+ * The IPC ID contains 2 separate numbers - index and sequence number.
+ * By default,
+ *   bits  0-14: index (32k, 15 bits)
+ *   bits 15-30: sequence number (64k, 16 bits)
+ *
+ * When IPCMNI extension mode is turned on, the composition changes:
+ *   bits  0-23: index (16M, 24 bits)
+ *   bits 24-30: sequence number (128, 7 bits)
+ */
+#define IPCMNI_SHIFT		15
+#define IPCMNI_EXTEND_SHIFT	24
+#define IPCMNI			(1 << IPCMNI_SHIFT)
+#define IPCMNI_EXTEND		(1 << IPCMNI_EXTEND_SHIFT)
+
+#ifdef CONFIG_SYSVIPC_SYSCTL
+extern int ipc_mni;
+extern int ipc_mni_shift;
+
+#define IPCMNI_SEQ_SHIFT	ipc_mni_shift
+#define IPCMNI_IDX_MASK		((1 << ipc_mni_shift) - 1)
+
+#else /* CONFIG_SYSVIPC_SYSCTL */
+
+#define ipc_mni			IPCMNI
+#define IPCMNI_SEQ_SHIFT	IPCMNI_SHIFT
+#define IPCMNI_IDX_MASK		((1 << IPCMNI_SHIFT) - 1)
+#endif /* CONFIG_SYSVIPC_SYSCTL */
 
 void sem_init(void);
 void msg_init(void);
@@ -96,9 +122,9 @@ void __init ipc_init_proc_interface(const char *path, const char *header,
 #define IPC_MSG_IDS	1
 #define IPC_SHM_IDS	2
 
-#define ipcid_to_idx(id) ((id) % SEQ_MULTIPLIER)
-#define ipcid_to_seqx(id) ((id) / SEQ_MULTIPLIER)
-#define IPCID_SEQ_MAX min_t(int, INT_MAX/SEQ_MULTIPLIER, USHRT_MAX)
+#define ipcid_to_idx(id)  ((id) & IPCMNI_IDX_MASK)
+#define ipcid_to_seqx(id) ((id) >> IPCMNI_SEQ_SHIFT)
+#define IPCID_SEQ_MAX	  (INT_MAX >> IPCMNI_SEQ_SHIFT)
 
 /* must be called with ids->rwsem acquired for writing */
 int ipc_addid(struct ipc_ids *, struct kern_ipc_perm *, int);
@@ -123,8 +149,8 @@ static inline int ipc_get_maxidx(struct ipc_ids *ids)
 	if (ids->in_use == 0)
 		return -1;
 
-	if (ids->in_use == IPCMNI)
-		return IPCMNI - 1;
+	if (ids->in_use == ipc_mni)
+		return ipc_mni - 1;
 
 	return ids->max_idx;
 }
@@ -219,10 +245,10 @@ void free_ipcs(struct ipc_namespace *ns, struct ipc_ids *ids,
 
 static inline int sem_check_semmni(struct ipc_namespace *ns) {
 	/*
-	 * Check semmni range [0, IPCMNI]
+	 * Check semmni range [0, ipc_mni]
 	 * semmni is the last element of sem_ctls[4] array
 	 */
-	return ((ns->sem_ctls[3] < 0) || (ns->sem_ctls[3] > IPCMNI))
+	return ((ns->sem_ctls[3] < 0) || (ns->sem_ctls[3] > ipc_mni))
 		? -ERANGE : 0;
 }
 
-- 
1.8.3.1

