Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1046AC0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 15:46:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D56112085A
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 15:46:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D56112085A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730152AbeKFBGQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 20:06:16 -0500
Received: from mx1.redhat.com ([209.132.183.28]:32992 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729019AbeKFBGP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 20:06:15 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DDAF73DD47;
        Mon,  5 Nov 2018 15:45:56 +0000 (UTC)
Received: from llong.com (dhcp-17-8.bos.redhat.com [10.18.17.8])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CECAC108BF00;
        Mon,  5 Nov 2018 15:45:54 +0000 (UTC)
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
Subject: [PATCH v10 2/4] ipc: Conserve sequence numbers in extended IPCMNI mode
Date:   Mon,  5 Nov 2018 10:43:44 -0500
Message-Id: <1541432626-27780-3-git-send-email-longman@redhat.com>
In-Reply-To: <1541432626-27780-1-git-send-email-longman@redhat.com>
References: <1541432626-27780-1-git-send-email-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Mon, 05 Nov 2018 15:45:57 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The mixing in of a sequence number into the IPC IDs is probably to
avoid ID reuse in userspace as much as possible. With extended IPCMNI
mode, the number of usable sequence numbers is greatly reduced leading
to higher chance of ID reuse.

To address this issue, we need to conserve the sequence number space
as much as possible. Right now, the sequence number is incremented
for every new ID created. In reality, we only need to increment the
sequence number when one or more IDs have been removed previously to
make sure that those IDs will not be reused when a new one is built.
This is being done only in the new extended IPCMNI mode.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 include/linux/ipc_namespace.h |  1 +
 ipc/ipc_sysctl.c              |  2 ++
 ipc/util.c                    | 17 ++++++++++++++---
 ipc/util.h                    |  2 ++
 4 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/include/linux/ipc_namespace.h b/include/linux/ipc_namespace.h
index 6ab8c1b..7d5f553 100644
--- a/include/linux/ipc_namespace.h
+++ b/include/linux/ipc_namespace.h
@@ -16,6 +16,7 @@
 struct ipc_ids {
 	int in_use;
 	unsigned short seq;
+	unsigned short deleted;
 	struct rw_semaphore rwsem;
 	struct idr ipcs_idr;
 	int max_idx;
diff --git a/ipc/ipc_sysctl.c b/ipc/ipc_sysctl.c
index 73b7782..d9ac6ca 100644
--- a/ipc/ipc_sysctl.c
+++ b/ipc/ipc_sysctl.c
@@ -122,6 +122,7 @@ static int proc_ipc_sem_dointvec(struct ctl_table *table, int write,
 static int int_max = INT_MAX;
 int ipc_mni = IPCMNI;
 int ipc_mni_shift = IPCMNI_SHIFT;
+bool ipc_mni_extended;
 
 static struct ctl_table ipc_kern_table[] = {
 	{
@@ -252,6 +253,7 @@ static int __init ipc_mni_extend(char *str)
 {
 	ipc_mni = IPCMNI_EXTEND;
 	ipc_mni_shift = IPCMNI_EXTEND_SHIFT;
+	ipc_mni_extended = true;
 	pr_info("IPCMNI extended to %d.\n", ipc_mni);
 	return 0;
 }
diff --git a/ipc/util.c b/ipc/util.c
index 07ae117..6ae0007 100644
--- a/ipc/util.c
+++ b/ipc/util.c
@@ -115,6 +115,7 @@ static int __init ipc_init(void)
 void ipc_init_ids(struct ipc_ids *ids)
 {
 	ids->in_use = 0;
+	ids->deleted = false;
 	ids->seq = 0;
 	init_rwsem(&ids->rwsem);
 	rhashtable_init(&ids->key_ht, &ipc_kht_params);
@@ -198,6 +199,11 @@ static inline int ipc_idr_alloc(struct ipc_ids *ids, struct kern_ipc_perm *new)
 {
 	int idx, next_id = -1;
 
+/*
+ * To conserve sequence number space with extended ipc_mni when new ID
+ * is built, the sequence number is incremented only when one or more
+ * IDs have been removed previously.
+ */
 #ifdef CONFIG_CHECKPOINT_RESTORE
 	next_id = ids->next_id;
 	ids->next_id = -1;
@@ -216,9 +222,13 @@ static inline int ipc_idr_alloc(struct ipc_ids *ids, struct kern_ipc_perm *new)
 	 */
 
 	if (next_id < 0) { /* !CHECKPOINT_RESTORE or next_id is unset */
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
 		idx = idr_alloc(&ids->ipcs_idr, new, 0, 0, GFP_NOWAIT);
 	} else {
 		new->seq = ipcid_to_seqx(next_id);
@@ -436,6 +446,7 @@ void ipc_rmid(struct ipc_ids *ids, struct kern_ipc_perm *ipcp)
 	idr_remove(&ids->ipcs_idr, idx);
 	ipc_kht_remove(ids, ipcp);
 	ids->in_use--;
+	ids->deleted = true;
 	ipcp->deleted = true;
 
 	if (unlikely(idx == ids->max_idx)) {
diff --git a/ipc/util.h b/ipc/util.h
index 640f916..1f19729 100644
--- a/ipc/util.h
+++ b/ipc/util.h
@@ -33,6 +33,7 @@
 #ifdef CONFIG_SYSVIPC_SYSCTL
 extern int ipc_mni;
 extern int ipc_mni_shift;
+extern bool ipc_mni_extended;
 
 #define IPCMNI_SEQ_SHIFT	ipc_mni_shift
 #define IPCMNI_IDX_MASK		((1 << ipc_mni_shift) - 1)
@@ -40,6 +41,7 @@
 #else /* CONFIG_SYSVIPC_SYSCTL */
 
 #define ipc_mni		IPCMNI
+#define ipc_mni_extended	false
 #define IPCMNI_SEQ_SHIFT	IPCMNI_SHIFT
 #define IPCMNI_IDX_MASK		((1 << IPCMNI_SHIFT) - 1)
 #endif /* CONFIG_SYSVIPC_SYSCTL */
-- 
1.8.3.1

