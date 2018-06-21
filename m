Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2204C43142
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 21:36:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94BF322440
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 21:36:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94BF322440
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934054AbeFUVgY (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 17:36:24 -0400
Received: from smtp2.provo.novell.com ([137.65.250.81]:59130 "EHLO
        smtp2.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933884AbeFUV3A (ORCPT
        <rfc822;groupwise-linux-kernel@vger.kernel.org:0:0>);
        Thu, 21 Jun 2018 17:29:00 -0400
Received: from linux-r8p5.suse.cz (prv-ext-foundry1int.gns.novell.com [137.65.251.240])
        by smtp2.provo.novell.com with ESMTP (TLS encrypted); Thu, 21 Jun 2018 15:28:51 -0600
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     akpm@linux-foundation.org, torvalds@linux-foundation.org
Cc:     tgraf@suug.ch, herbert@gondor.apana.org.au,
        manfred@colorfullife.com, mhocko@kernel.org,
        guillaume.knispel@supersonicimagine.com, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org, dave@stgolabs.net,
        Davidlohr Bueso <dbueso@suse.de>
Subject: [PATCH 3/4] ipc: get rid of ids->tables_initialized hack
Date:   Thu, 21 Jun 2018 14:28:24 -0700
Message-Id: <20180621212825.3059-4-dave@stgolabs.net>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180621212825.3059-1-dave@stgolabs.net>
References: <20180621212825.3059-1-dave@stgolabs.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In sysvipc we have an ids->tables_initialized regarding the
rhashtable, introduced in:

    0cfb6aee70b (ipc: optimize semget/shmget/msgget for lots of keys).

It's there, specifically, to prevent nil pointer dereferences,
from using an uninitialized api. Considering how rhashtable_init()
can fail (probably due to ENOMEM, if anything), this made the
overall ipc initialization capable of failure as well. That alone
is ugly, but fine, however I've spotted a few issues regarding the
semantics of tables_initialized (however unlikely they may be):

- There is inconsistency in what we return to userspace: ipc_addid()
returns ENOSPC which is certainly _wrong_, while ipc_obtain_object_idr()
returns EINVAL.

- After we started using rhashtables, ipc_findkey() can return nil upon
!tables_initialized, but the caller expects nil for when the ipc structure
isn't found, and can therefore call into ipcget() callbacks.

Now that rhashtable initialization cannot fail, we can properly
get rid of the hack altogether.

Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
---
 include/linux/ipc_namespace.h |  1 -
 ipc/util.c                    | 23 ++++++++---------------
 2 files changed, 8 insertions(+), 16 deletions(-)

diff --git a/include/linux/ipc_namespace.h b/include/linux/ipc_namespace.h
index b5630c8eb2f3..37f3a4b7c637 100644
--- a/include/linux/ipc_namespace.h
+++ b/include/linux/ipc_namespace.h
@@ -16,7 +16,6 @@ struct user_namespace;
 struct ipc_ids {
 	int in_use;
 	unsigned short seq;
-	bool tables_initialized;
 	struct rw_semaphore rwsem;
 	struct idr ipcs_idr;
 	int max_id;
diff --git a/ipc/util.c b/ipc/util.c
index 4e81182fa0ac..823e09e72c58 100644
--- a/ipc/util.c
+++ b/ipc/util.c
@@ -125,7 +125,6 @@ int ipc_init_ids(struct ipc_ids *ids)
 	if (err)
 		return err;
 	idr_init(&ids->ipcs_idr);
-	ids->tables_initialized = true;
 	ids->max_id = -1;
 #ifdef CONFIG_CHECKPOINT_RESTORE
 	ids->next_id = -1;
@@ -178,19 +177,16 @@ void __init ipc_init_proc_interface(const char *path, const char *header,
  */
 static struct kern_ipc_perm *ipc_findkey(struct ipc_ids *ids, key_t key)
 {
-	struct kern_ipc_perm *ipcp = NULL;
+	struct kern_ipc_perm *ipcp;
 
-	if (likely(ids->tables_initialized))
-		ipcp = rhashtable_lookup_fast(&ids->key_ht, &key,
+	ipcp = rhashtable_lookup_fast(&ids->key_ht, &key,
 					      ipc_kht_params);
+	if (!ipcp)
+		return NULL;
 
-	if (ipcp) {
-		rcu_read_lock();
-		ipc_lock_object(ipcp);
-		return ipcp;
-	}
-
-	return NULL;
+	rcu_read_lock();
+	ipc_lock_object(ipcp);
+	return ipcp;
 }
 
 #ifdef CONFIG_CHECKPOINT_RESTORE
@@ -255,7 +251,7 @@ int ipc_addid(struct ipc_ids *ids, struct kern_ipc_perm *new, int limit)
 	if (limit > IPCMNI)
 		limit = IPCMNI;
 
-	if (!ids->tables_initialized || ids->in_use >= limit)
+	if (ids->in_use >= limit)
 		return -ENOSPC;
 
 	idr_preload(GFP_KERNEL);
@@ -566,9 +562,6 @@ struct kern_ipc_perm *ipc_obtain_object_idr(struct ipc_ids *ids, int id)
 	struct kern_ipc_perm *out;
 	int lid = ipcid_to_idx(id);
 
-	if (unlikely(!ids->tables_initialized))
-		return ERR_PTR(-EINVAL);
-
 	out = idr_find(&ids->ipcs_idr, lid);
 	if (!out)
 		return ERR_PTR(-EINVAL);
-- 
2.16.4

