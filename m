Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EE5FC433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 10:29:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22626208A6
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 10:29:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22626208A6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937168AbeFRK3d (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 06:29:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44068 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S937099AbeFRK3B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 06:29:01 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id EBC6B3082A48;
        Mon, 18 Jun 2018 10:29:00 +0000 (UTC)
Received: from llong.com (ovpn-116-106.phx2.redhat.com [10.3.116.106])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D05575C257;
        Mon, 18 Jun 2018 10:28:57 +0000 (UTC)
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
        Waiman Long <longman@redhat.com>
Subject: [PATCH v8 4/5] ipc: Conserve sequence numbers in extended IPCMNI mode
Date:   Mon, 18 Jun 2018 18:28:17 +0800
Message-Id: <1529317698-16575-5-git-send-email-longman@redhat.com>
In-Reply-To: <1529317698-16575-1-git-send-email-longman@redhat.com>
References: <1529317698-16575-1-git-send-email-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Mon, 18 Jun 2018 10:29:01 +0000 (UTC)
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
This is being done in the extended IPCMNI mode,

Signed-off-by: Waiman Long <longman@redhat.com>
---
 include/linux/ipc_namespace.h |  1 +
 ipc/ipc_sysctl.c              |  2 ++
 ipc/util.c                    | 29 ++++++++++++++++++++++-------
 ipc/util.h                    |  2 ++
 4 files changed, 27 insertions(+), 7 deletions(-)

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
index 782a8d0..7c8e733 100644
--- a/ipc/util.c
+++ b/ipc/util.c
@@ -119,7 +119,8 @@ int ipc_init_ids(struct ipc_ids *ids)
 {
 	int err;
 	ids->in_use = 0;
-	ids->seq = 0;
+	ids->deleted = false;
+	ids->seq = ipc_mni_extended ? 0 : -1; /* seq # is pre-incremented */
 	init_rwsem(&ids->rwsem);
 	err = rhashtable_init(&ids->key_ht, &ipc_kht_params);
 	if (err)
@@ -193,6 +194,11 @@ static struct kern_ipc_perm *ipc_findkey(struct ipc_ids *ids, key_t key)
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
@@ -206,9 +212,13 @@ static inline int ipc_buildid(int id, struct ipc_ids *ids,
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
@@ -224,9 +234,13 @@ static inline int ipc_buildid(int id, struct ipc_ids *ids,
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
@@ -436,6 +450,7 @@ void ipc_rmid(struct ipc_ids *ids, struct kern_ipc_perm *ipcp)
 	idr_remove(&ids->ipcs_idr, lid);
 	ipc_kht_remove(ids, ipcp);
 	ids->in_use--;
+	ids->deleted = true;
 	ipcp->deleted = true;
 
 	if (unlikely(lid == ids->max_id)) {
diff --git a/ipc/util.h b/ipc/util.h
index d103630..62b6247 100644
--- a/ipc/util.h
+++ b/ipc/util.h
@@ -29,6 +29,7 @@
 #ifdef CONFIG_SYSVIPC_SYSCTL
 extern int ipc_mni;
 extern int ipc_mni_shift;
+extern bool ipc_mni_extended;
 
 #define SEQ_SHIFT		ipc_mni_shift
 #define SEQ_MASK		((1 << ipc_mni_shift) - 1)
@@ -36,6 +37,7 @@
 #else /* CONFIG_SYSVIPC_SYSCTL */
 
 #define ipc_mni 		IPCMNI
+#define ipc_mni_extended	false
 #define SEQ_SHIFT		IPCMNI_SHIFT
 #define SEQ_MASK		((1 << IPCMNI_SHIFT) - 1)
 #endif /* CONFIG_SYSVIPC_SYSCTL */
-- 
1.8.3.1

