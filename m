Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13E85C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 16:46:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0BB52185A
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 16:46:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0BB52185A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727864AbeHQTuJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 15:50:09 -0400
Received: from mx2.suse.de ([195.135.220.15]:49886 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727218AbeHQTuI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 15:50:08 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 7E227AD98;
        Fri, 17 Aug 2018 16:46:01 +0000 (UTC)
Date:   Fri, 17 Aug 2018 09:45:48 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Waiman Long <longman@redhat.com>
Cc:     "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Takashi Iwai <tiwai@suse.de>, Davidlohr Bueso <dbueso@suse.de>,
        manfred@colorfullife.com
Subject: Re: [PATCH v8 3/5] ipc: Allow boot time extension of IPCMNI from 32k
 to 2M
Message-ID: <20180817164548.GA32382@linux-r8p5>
References: <1529317698-16575-1-git-send-email-longman@redhat.com>
 <1529317698-16575-4-git-send-email-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <1529317698-16575-4-git-send-email-longman@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cc'ing Manfred.

On Mon, 18 Jun 2018, Waiman Long wrote:

>The maximum number of unique System V IPC identifiers was limited to
>32k.  That limit should be big enough for most use cases.
>
>However, there are some users out there requesting for more. To satisfy
>the need of those users, a new boot time kernel option "ipcmni_extend"
>is added to extend the IPCMNI value to 2M. This is a 64X increase which
>hopefully is big enough for them.

Could you please provide more info on the need of these users and how
you came up with this new value (which just seems quite arbitrary)?

Thanks,
Davidlohr

>
>This new option does have the side effect of reducing the maximum
>number of unique sequence numbers from 64k down to 1k. So it is
>a trade-off.
>
>Signed-off-by: Waiman Long <longman@redhat.com>
>---
> Documentation/admin-guide/kernel-parameters.txt |  3 ++
> ipc/ipc_sysctl.c                                | 12 ++++++-
> ipc/util.c                                      | 12 +++----
> ipc/util.h                                      | 42 +++++++++++++++++++------
> 4 files changed, 52 insertions(+), 17 deletions(-)
>
>diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
>index efc7aa7..6712a42 100644
>--- a/Documentation/admin-guide/kernel-parameters.txt
>+++ b/Documentation/admin-guide/kernel-parameters.txt
>@@ -1744,6 +1744,9 @@
> 	ip=		[IP_PNP]
> 			See Documentation/filesystems/nfs/nfsroot.txt.
>
>+	ipcmni_extend	[KNL] Extend the maximum number of unique System V
>+			IPC identifiers from 32768 to 2097152.
>+
> 	irqaffinity=	[SMP] Set the default irq affinity mask
> 			The argument is a cpu list, as described above.
>
>diff --git a/ipc/ipc_sysctl.c b/ipc/ipc_sysctl.c
>index 49f9bf4..73b7782 100644
>--- a/ipc/ipc_sysctl.c
>+++ b/ipc/ipc_sysctl.c
>@@ -120,7 +120,8 @@ static int proc_ipc_sem_dointvec(struct ctl_table *table, int write,
> static int zero;
> static int one = 1;
> static int int_max = INT_MAX;
>-static int ipc_mni = IPCMNI;
>+int ipc_mni = IPCMNI;
>+int ipc_mni_shift = IPCMNI_SHIFT;
>
> static struct ctl_table ipc_kern_table[] = {
> 	{
>@@ -246,3 +247,12 @@ static int __init ipc_sysctl_init(void)
> }
>
> device_initcall(ipc_sysctl_init);
>+
>+static int __init ipc_mni_extend(char *str)
>+{
>+	ipc_mni = IPCMNI_EXTEND;
>+	ipc_mni_shift = IPCMNI_EXTEND_SHIFT;
>+	pr_info("IPCMNI extended to %d.\n", ipc_mni);
>+	return 0;
>+}
>+early_param("ipcmni_extend", ipc_mni_extend);
>diff --git a/ipc/util.c b/ipc/util.c
>index 4e81182..782a8d0 100644
>--- a/ipc/util.c
>+++ b/ipc/util.c
>@@ -113,7 +113,7 @@ static int __init ipc_init(void)
>  * @ids: ipc identifier set
>  *
>  * Set up the sequence range to use for the ipc identifier range (limited
>- * below IPCMNI) then initialise the keys hashtable and ids idr.
>+ * below ipc_mni) then initialise the keys hashtable and ids idr.
>  */
> int ipc_init_ids(struct ipc_ids *ids)
> {
>@@ -214,7 +214,7 @@ static inline int ipc_buildid(int id, struct ipc_ids *ids,
> 		ids->next_id = -1;
> 	}
>
>-	return SEQ_MULTIPLIER * new->seq + id;
>+	return (new->seq << SEQ_SHIFT) + id;
> }
>
> #else
>@@ -228,7 +228,7 @@ static inline int ipc_buildid(int id, struct ipc_ids *ids,
> 	if (ids->seq > IPCID_SEQ_MAX)
> 		ids->seq = 0;
>
>-	return SEQ_MULTIPLIER * new->seq + id;
>+	return (new->seq << SEQ_SHIFT) + id;
> }
>
> #endif /* CONFIG_CHECKPOINT_RESTORE */
>@@ -252,8 +252,8 @@ int ipc_addid(struct ipc_ids *ids, struct kern_ipc_perm *new, int limit)
> 	kgid_t egid;
> 	int id, err;
>
>-	if (limit > IPCMNI)
>-		limit = IPCMNI;
>+	if (limit > ipc_mni)
>+		limit = ipc_mni;
>
> 	if (!ids->tables_initialized || ids->in_use >= limit)
> 		return -ENOSPC;
>@@ -777,7 +777,7 @@ static struct kern_ipc_perm *sysvipc_find_ipc(struct ipc_ids *ids, loff_t pos,
> 	if (total >= ids->in_use)
> 		return NULL;
>
>-	for (; pos < IPCMNI; pos++) {
>+	for (; pos < ipc_mni; pos++) {
> 		ipc = idr_find(&ids->ipcs_idr, pos);
> 		if (ipc != NULL) {
> 			*new_pos = pos + 1;
>diff --git a/ipc/util.h b/ipc/util.h
>index 8e9c52c..d103630 100644
>--- a/ipc/util.h
>+++ b/ipc/util.h
>@@ -15,8 +15,30 @@
> #include <linux/err.h>
> #include <linux/ipc_namespace.h>
>
>-#define IPCMNI 32768  /* <= MAX_INT limit for ipc arrays (including sysctl changes) */
>-#define SEQ_MULTIPLIER	(IPCMNI)
>+/*
>+ * By default, the ipc arrays can have up to 32k (15 bits) entries.
>+ * When IPCMNI extension mode is turned on, the ipc arrays can have up
>+ * to 2M (21 bits) entries. However, the space for sequence number will
>+ * be shrunk from 16 bits to 10 bits.
>+ */
>+#define IPCMNI_SHIFT		15
>+#define IPCMNI_EXTEND_SHIFT	21
>+#define IPCMNI			(1 << IPCMNI_SHIFT)
>+#define IPCMNI_EXTEND		(1 << IPCMNI_EXTEND_SHIFT)
>+
>+#ifdef CONFIG_SYSVIPC_SYSCTL
>+extern int ipc_mni;
>+extern int ipc_mni_shift;
>+
>+#define SEQ_SHIFT		ipc_mni_shift
>+#define SEQ_MASK		((1 << ipc_mni_shift) - 1)
>+
>+#else /* CONFIG_SYSVIPC_SYSCTL */
>+
>+#define ipc_mni 		IPCMNI
>+#define SEQ_SHIFT		IPCMNI_SHIFT
>+#define SEQ_MASK		((1 << IPCMNI_SHIFT) - 1)
>+#endif /* CONFIG_SYSVIPC_SYSCTL */
>
> int sem_init(void);
> int msg_init(void);
>@@ -96,9 +118,9 @@ void __init ipc_init_proc_interface(const char *path, const char *header,
> #define IPC_MSG_IDS	1
> #define IPC_SHM_IDS	2
>
>-#define ipcid_to_idx(id) ((id) % SEQ_MULTIPLIER)
>-#define ipcid_to_seqx(id) ((id) / SEQ_MULTIPLIER)
>-#define IPCID_SEQ_MAX min_t(int, INT_MAX/SEQ_MULTIPLIER, USHRT_MAX)
>+#define ipcid_to_idx(id)  ((id) & SEQ_MASK)
>+#define ipcid_to_seqx(id) ((id) >> SEQ_SHIFT)
>+#define IPCID_SEQ_MAX	  (INT_MAX >> SEQ_SHIFT)
>
> /* must be called with ids->rwsem acquired for writing */
> int ipc_addid(struct ipc_ids *, struct kern_ipc_perm *, int);
>@@ -123,8 +145,8 @@ static inline int ipc_get_maxid(struct ipc_ids *ids)
> 	if (ids->in_use == 0)
> 		return -1;
>
>-	if (ids->in_use == IPCMNI)
>-		return IPCMNI - 1;
>+	if (ids->in_use == ipc_mni)
>+		return ipc_mni - 1;
>
> 	return ids->max_id;
> }
>@@ -175,7 +197,7 @@ static inline void ipc_update_pid(struct pid **pos, struct pid *pid)
>
> static inline int ipc_checkid(struct kern_ipc_perm *ipcp, int uid)
> {
>-	return uid / SEQ_MULTIPLIER != ipcp->seq;
>+	return (uid >> SEQ_SHIFT) != ipcp->seq;
> }
>
> static inline void ipc_lock_object(struct kern_ipc_perm *perm)
>@@ -220,10 +242,10 @@ void free_ipcs(struct ipc_namespace *ns, struct ipc_ids *ids,
>
> static inline int sem_check_semmni(struct ipc_namespace *ns) {
> 	/*
>-	 * Check semmni range [0, IPCMNI]
>+	 * Check semmni range [0, ipc_mni]
> 	 * semmni is the last element of sem_ctls[4] array
> 	 */
>-	return ((ns->sem_ctls[3] < 0) || (ns->sem_ctls[3] > IPCMNI))
>+	return ((ns->sem_ctls[3] < 0) || (ns->sem_ctls[3] > ipc_mni))
> 		? -ERANGE : 0;
> }
>
>-- 
>1.8.3.1
>
