Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8FC8C43610
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 20:11:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A34F02086C
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 20:11:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A34F02086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728327AbeKJFyA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 00:54:00 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34428 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725872AbeKJFx7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 00:53:59 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id F35D65D698;
        Fri,  9 Nov 2018 20:11:51 +0000 (UTC)
Received: from llong.com (dhcp-17-55.bos.redhat.com [10.18.17.55])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8C43D6B8C8;
        Fri,  9 Nov 2018 20:11:50 +0000 (UTC)
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
Subject: [PATCH v11 2/3] ipc: Conserve sequence numbers in ipcmni_extend mode
Date:   Fri,  9 Nov 2018 15:11:31 -0500
Message-Id: <1541794292-19425-3-git-send-email-longman@redhat.com>
In-Reply-To: <1541794292-19425-1-git-send-email-longman@redhat.com>
References: <1541794292-19425-1-git-send-email-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Fri, 09 Nov 2018 20:11:52 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The mixing in of a sequence number into the IPC IDs is probably to
avoid ID reuse in userspace as much as possible. With ipcmni_extend
mode, the number of usable sequence numbers is greatly reduced leading
to higher chance of ID reuse.

To address this issue, we need to conserve the sequence number space
as much as possible. Right now, the sequence number is incremented
for every new ID created. In reality, we only need to increment the
sequence number when one or more IDs have been removed previously to
make sure that those IDs will not be reused when a new one is built.
This is being done irrespective of the ipcmni mode.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 include/linux/ipc_namespace.h |  1 +
 ipc/util.c                    | 16 +++++++++++++---
 2 files changed, 14 insertions(+), 3 deletions(-)

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
diff --git a/ipc/util.c b/ipc/util.c
index 07ae117..00000a1 100644
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
@@ -193,6 +194,10 @@ static struct kern_ipc_perm *ipc_findkey(struct ipc_ids *ids, key_t key)
  *
  * The caller must own kern_ipc_perm.lock.of the new object.
  * On error, the function returns a (negative) error code.
+ *
+ * To conserve sequence number space, especially with extended ipc_mni,
+ * the sequence number is incremented only when one or more IDs have been
+ * removed previously.
  */
 static inline int ipc_idr_alloc(struct ipc_ids *ids, struct kern_ipc_perm *new)
 {
@@ -216,9 +221,13 @@ static inline int ipc_idr_alloc(struct ipc_ids *ids, struct kern_ipc_perm *new)
 	 */
 
 	if (next_id < 0) { /* !CHECKPOINT_RESTORE or next_id is unset */
-		new->seq = ids->seq++;
-		if (ids->seq > IPCID_SEQ_MAX)
-			ids->seq = 0;
+		if (ids->deleted) {
+			ids->seq++;
+			if (ids->seq > IPCID_SEQ_MAX)
+				ids->seq = 0;
+			ids->deleted = false;
+		}
+		new->seq = ids->seq;
 		idx = idr_alloc(&ids->ipcs_idr, new, 0, 0, GFP_NOWAIT);
 	} else {
 		new->seq = ipcid_to_seqx(next_id);
@@ -436,6 +445,7 @@ void ipc_rmid(struct ipc_ids *ids, struct kern_ipc_perm *ipcp)
 	idr_remove(&ids->ipcs_idr, idx);
 	ipc_kht_remove(ids, ipcp);
 	ids->in_use--;
+	ids->deleted = true;
 	ipcp->deleted = true;
 
 	if (unlikely(idx == ids->max_idx)) {
-- 
1.8.3.1

