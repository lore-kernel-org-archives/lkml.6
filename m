Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91A92C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 15:46:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53FB02085B
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 15:46:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53FB02085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730188AbeKFBGS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 20:06:18 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37178 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729019AbeKFBGR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 20:06:17 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E10933001BF3;
        Mon,  5 Nov 2018 15:45:58 +0000 (UTC)
Received: from llong.com (dhcp-17-8.bos.redhat.com [10.18.17.8])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B57B3108BF15;
        Mon,  5 Nov 2018 15:45:56 +0000 (UTC)
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
Subject: [PATCH v10 3/4] ipc: Make the new sequence number generation mode available to all
Date:   Mon,  5 Nov 2018 10:43:45 -0500
Message-Id: <1541432626-27780-4-git-send-email-longman@redhat.com>
In-Reply-To: <1541432626-27780-1-git-send-email-longman@redhat.com>
References: <1541432626-27780-1-git-send-email-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Mon, 05 Nov 2018 15:45:59 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It happens that the new IPC id sequence number inrement mode can be
useful to reduce the chance of IPC id reuse even if the ipcmni_extend
boot command line parameter isn't specified. So a new ipcid_mode sysctl
parameter is added to control the sequence number generation mode -
legacy and delete modes.

In the legacy mode, the sequence number is incremented every time a new
ID is generated. In the delete mode, the number is incremented only if
one or more IDs have been previously deleted. The default is legacy for
non-ipcmni_extend and delete for ipcmni_extend. This new ipcid_mode
parameter is specific to each of the IPC namespaces.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 Documentation/sysctl/kernel.txt | 17 +++++++++++++++++
 include/linux/ipc_namespace.h   | 12 ++++++++++++
 ipc/ipc_sysctl.c                | 10 ++++++++++
 ipc/msg.c                       |  3 ++-
 ipc/namespace.c                 |  2 ++
 ipc/sem.c                       |  3 ++-
 ipc/shm.c                       |  3 ++-
 ipc/util.c                      | 10 ++++++----
 ipc/util.h                      |  3 ++-
 9 files changed, 55 insertions(+), 8 deletions(-)

diff --git a/Documentation/sysctl/kernel.txt b/Documentation/sysctl/kernel.txt
index 37a6795..91bada1 100644
--- a/Documentation/sysctl/kernel.txt
+++ b/Documentation/sysctl/kernel.txt
@@ -41,6 +41,7 @@ show up in /proc/sys/kernel:
 - hung_task_check_interval_secs
 - hung_task_warnings
 - hyperv_record_panic_msg
+- ipcid_mode
 - kexec_load_disabled
 - kptr_restrict
 - l2cr                        [ PPC only ]
@@ -398,6 +399,22 @@ Controls whether the panic kmsg data should be reported to Hyper-V.
 
 ==============================================================
 
+ipcid_mode:
+
+Controls how the IPC ids returned by msgget(), semget() and shmget()
+are being generated.
+
+0: legacy mode
+1: delete mode
+
+There are two components in an IPC id - an integer identifier and a
+sequence number. In the legacy mode, the sequence number is incremented
+every time a new id is generated. In the delete mode, the sequence number
+is only incremented if one or more ids have been previously deleted. The
+delete mode reduces the chance that a given id will be reused again.
+
+==============================================================
+
 kexec_load_disabled:
 
 A toggle indicating if the kexec_load syscall has been disabled. This
diff --git a/include/linux/ipc_namespace.h b/include/linux/ipc_namespace.h
index 7d5f553..79d9d50 100644
--- a/include/linux/ipc_namespace.h
+++ b/include/linux/ipc_namespace.h
@@ -26,6 +26,15 @@ struct ipc_ids {
 	struct rhashtable key_ht;
 };
 
+/*
+ * IPC id generation mode for controlling how the IPC id returned by
+ * {msg,sem,shm}get() is being generated.
+ */
+enum ipc_id_mode {
+	ipc_id_legacy,	/* Sequence # incremented on every allocation */
+	ipc_id_delete,	/* Sequence # incremented only if an ID was deleted */
+};
+
 struct ipc_namespace {
 	refcount_t	count;
 	struct ipc_ids	ids[3];
@@ -39,6 +48,9 @@ struct ipc_namespace {
 	atomic_t	msg_bytes;
 	atomic_t	msg_hdrs;
 
+	/* IPC id generation mode */
+	unsigned int	ipcid_mode;
+
 	size_t		shm_ctlmax;
 	size_t		shm_ctlall;
 	unsigned long	shm_tot;
diff --git a/ipc/ipc_sysctl.c b/ipc/ipc_sysctl.c
index d9ac6ca..4c30e62 100644
--- a/ipc/ipc_sysctl.c
+++ b/ipc/ipc_sysctl.c
@@ -200,6 +200,15 @@ static int proc_ipc_sem_dointvec(struct ctl_table *table, int write,
 		.mode		= 0644,
 		.proc_handler	= proc_ipc_sem_dointvec,
 	},
+	{
+		.procname	= "ipcid_mode",
+		.data		= &init_ipc_ns.ipcid_mode,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= proc_ipc_dointvec_minmax,
+		.extra1		= &zero,
+		.extra2		= &one,
+	},
 #ifdef CONFIG_CHECKPOINT_RESTORE
 	{
 		.procname	= "sem_next_id",
@@ -254,6 +263,7 @@ static int __init ipc_mni_extend(char *str)
 	ipc_mni = IPCMNI_EXTEND;
 	ipc_mni_shift = IPCMNI_EXTEND_SHIFT;
 	ipc_mni_extended = true;
+	init_ipc_ns.ipcid_mode = ipc_id_delete;
 	pr_info("IPCMNI extended to %d.\n", ipc_mni);
 	return 0;
 }
diff --git a/ipc/msg.c b/ipc/msg.c
index 0833c64..b401ba2 100644
--- a/ipc/msg.c
+++ b/ipc/msg.c
@@ -161,7 +161,8 @@ static int newque(struct ipc_namespace *ns, struct ipc_params *params)
 	INIT_LIST_HEAD(&msq->q_senders);
 
 	/* ipc_addid() locks msq upon success. */
-	retval = ipc_addid(&msg_ids(ns), &msq->q_perm, ns->msg_ctlmni);
+	retval = ipc_addid(&msg_ids(ns), &msq->q_perm, ns->msg_ctlmni,
+			   ns->ipcid_mode);
 	if (retval < 0) {
 		ipc_rcu_putref(&msq->q_perm, msg_rcu_free);
 		return retval;
diff --git a/ipc/namespace.c b/ipc/namespace.c
index 2160779..8b62cbd0 100644
--- a/ipc/namespace.c
+++ b/ipc/namespace.c
@@ -55,6 +55,8 @@ static struct ipc_namespace *create_ipc_ns(struct user_namespace *user_ns,
 	ns->user_ns = get_user_ns(user_ns);
 	ns->ucounts = ucounts;
 
+	ns->ipcid_mode = ipc_mni_extended ? ipc_id_delete : ipc_id_legacy;
+
 	err = mq_init_ns(ns);
 	if (err)
 		goto fail_put;
diff --git a/ipc/sem.c b/ipc/sem.c
index 745dc61..51af634 100644
--- a/ipc/sem.c
+++ b/ipc/sem.c
@@ -553,7 +553,8 @@ static int newary(struct ipc_namespace *ns, struct ipc_params *params)
 	sma->sem_ctime = ktime_get_real_seconds();
 
 	/* ipc_addid() locks sma upon success. */
-	retval = ipc_addid(&sem_ids(ns), &sma->sem_perm, ns->sc_semmni);
+	retval = ipc_addid(&sem_ids(ns), &sma->sem_perm, ns->sc_semmni,
+			   ns->ipcid_mode);
 	if (retval < 0) {
 		ipc_rcu_putref(&sma->sem_perm, sem_rcu_free);
 		return retval;
diff --git a/ipc/shm.c b/ipc/shm.c
index 0842411..182ae4c 100644
--- a/ipc/shm.c
+++ b/ipc/shm.c
@@ -676,7 +676,8 @@ static int newseg(struct ipc_namespace *ns, struct ipc_params *params)
 	shp->shm_creator = current;
 
 	/* ipc_addid() locks shp upon success. */
-	error = ipc_addid(&shm_ids(ns), &shp->shm_perm, ns->shm_ctlmni);
+	error = ipc_addid(&shm_ids(ns), &shp->shm_perm, ns->shm_ctlmni,
+			  ns->ipcid_mode);
 	if (error < 0)
 		goto no_id;
 
diff --git a/ipc/util.c b/ipc/util.c
index 6ae0007..04c8e31 100644
--- a/ipc/util.c
+++ b/ipc/util.c
@@ -195,7 +195,8 @@ static struct kern_ipc_perm *ipc_findkey(struct ipc_ids *ids, key_t key)
  * The caller must own kern_ipc_perm.lock.of the new object.
  * On error, the function returns a (negative) error code.
  */
-static inline int ipc_idr_alloc(struct ipc_ids *ids, struct kern_ipc_perm *new)
+static inline int ipc_idr_alloc(struct ipc_ids *ids, struct kern_ipc_perm *new,
+				int idmode)
 {
 	int idx, next_id = -1;
 
@@ -222,7 +223,7 @@ static inline int ipc_idr_alloc(struct ipc_ids *ids, struct kern_ipc_perm *new)
 	 */
 
 	if (next_id < 0) { /* !CHECKPOINT_RESTORE or next_id is unset */
-		if (!ipc_mni_extended || ids->deleted) {
+		if (idmode == ipc_id_legacy || ids->deleted) {
 			ids->seq++;
 			if (ids->seq > IPCID_SEQ_MAX)
 				ids->seq = 0;
@@ -255,7 +256,8 @@ static inline int ipc_idr_alloc(struct ipc_ids *ids, struct kern_ipc_perm *new)
  *
  * Called with writer ipc_ids.rwsem held.
  */
-int ipc_addid(struct ipc_ids *ids, struct kern_ipc_perm *new, int limit)
+int ipc_addid(struct ipc_ids *ids, struct kern_ipc_perm *new, int limit,
+	      int idmode)
 {
 	kuid_t euid;
 	kgid_t egid;
@@ -282,7 +284,7 @@ int ipc_addid(struct ipc_ids *ids, struct kern_ipc_perm *new, int limit)
 
 	new->deleted = false;
 
-	idx = ipc_idr_alloc(ids, new);
+	idx = ipc_idr_alloc(ids, new, idmode);
 	idr_preload_end();
 
 	if (idx >= 0 && new->key != IPC_PRIVATE) {
diff --git a/ipc/util.h b/ipc/util.h
index 1f19729..c8f2d0ed 100644
--- a/ipc/util.h
+++ b/ipc/util.h
@@ -129,7 +129,8 @@ void __init ipc_init_proc_interface(const char *path, const char *header,
 #define IPCID_SEQ_MAX	  (INT_MAX >> IPCMNI_SEQ_SHIFT)
 
 /* must be called with ids->rwsem acquired for writing */
-int ipc_addid(struct ipc_ids *, struct kern_ipc_perm *, int);
+int ipc_addid(struct ipc_ids *ids, struct kern_ipc_perm *new, int limit,
+	      int idmode);
 
 /* must be called with both locks acquired. */
 void ipc_rmid(struct ipc_ids *, struct kern_ipc_perm *);
-- 
1.8.3.1

