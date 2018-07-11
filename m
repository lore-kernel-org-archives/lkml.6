Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD3C8C5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 19:38:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B97D20873
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 19:38:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B97D20873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389768AbeGKToT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 15:44:19 -0400
Received: from mx2.suse.de ([195.135.220.15]:49944 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389745AbeGKToT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 15:44:19 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 56A46ACDF;
        Wed, 11 Jul 2018 19:38:28 +0000 (UTC)
Date:   Wed, 11 Jul 2018 12:38:23 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Manfred Spraul <manfred@colorfullife.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        LKML <linux-kernel@vger.kernel.org>, 1vier1@web.de,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH 06/12] ipc: rename ipc_lock() to ipc_lock_idr()
Message-ID: <20180711193823.o6tb2swhnb2xyv33@linux-r8p5>
References: <20180709151019.1336-1-manfred@colorfullife.com>
 <20180709151019.1336-7-manfred@colorfullife.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20180709151019.1336-7-manfred@colorfullife.com>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 09 Jul 2018, Manfred Spraul wrote:

>ipc/util.c contains multiple functions to get the ipc object
>pointer given an id number.
>
>There are two sets of function: One set verifies the sequence
>counter part of the id number, other functions do not check
>the sequence counter.
>
>The standard for function names in ipc/util.c is
>- ..._check() functions verify the sequence counter
>- ..._idr() functions do not verify the sequence counter
>
>ipc_lock() is an exception: It does not verify the sequence
>counter value, but this is not obvious from the function name.

Agreed.

>
>Therefore: Rename the function to ipc_lock_idr(), to make it
>obvious that it does not check the sequence counter.

The rename doesn't make it more obvious either I don't think. Since
the only user of ipc_lock() is shm, how about we just move the
logic in there. Sure, we'd now have an 'ipc_unlock()' counter part,
but that's just ipc_unlock_object + rcu unlock, so leaving it as is
wouldn't be the end of the world methinks. Unlike the ipc_lock(),
the unlocking is also used by util.c.

Thanks.

----8<----------------------------------------------------------------
[PATCH] ipc: drop ipc_lock()

ipc/util.c contains multiple functions to get the ipc object
pointer given an id number.

There are two sets of function: One set verifies the sequence
counter part of the id number, other functions do not check
the sequence counter.

The standard for function names in ipc/util.c is
- ..._check() functions verify the sequence counter
- ..._idr() functions do not verify the sequence counter

ipc_lock() is an exception: It does not verify the sequence
counter value, but this is not obvious from the function name.

Furthermore, shm.c is the only user of this helper. Thus, we
can simply move the logic into shm_lock() and get rid of the
function altogether.

[changelog mostly by manfred]
Signed-off-by: Davidlohr Bueso <dbueso@suse.de>

---
 ipc/shm.c  | 29 +++++++++++++++++++++++------
 ipc/util.c | 36 ------------------------------------
 ipc/util.h |  1 -
 3 files changed, 23 insertions(+), 43 deletions(-)

diff --git a/ipc/shm.c b/ipc/shm.c
index 051a3e1fb8df..f3b19bce349d 100644
--- a/ipc/shm.c
+++ b/ipc/shm.c
@@ -179,16 +179,33 @@ static inline struct shmid_kernel *shm_obtain_object_check(struct ipc_namespace
  */
 static inline struct shmid_kernel *shm_lock(struct ipc_namespace *ns, int id)
 {
-	struct kern_ipc_perm *ipcp = ipc_lock(&shm_ids(ns), id);
+	struct kern_ipc_perm *ipcp;
+
+	rcu_read_lock();
+	ipcp = ipc_obtain_object_idr(&shm_ids(ns), id);
+	if (IS_ERR(ipcp))
+		goto err;
 
+	ipc_lock_object(ipcp);
+	/*
+	 * ipc_rmid() may have already freed the ID while ipc_lock_object()
+	 * was spinning: here verify that the structure is still valid.
+	 * Upon races with RMID, return -EIDRM, thus indicating that
+	 * the ID points to a removed identifier.
+	 */
+	if (ipc_valid_object(ipcp)) {
+		/* return a locked ipc object upon success */
+		return container_of(ipcp, struct shmid_kernel, shm_perm);
+	}
+
+	ipc_unlock_object(ipcp);
+err:
+	rcu_read_unlock();
 	/*
 	 * Callers of shm_lock() must validate the status of the returned ipc
-	 * object pointer (as returned by ipc_lock()), and error out as
-	 * appropriate.
+	 * object pointer and error out as appropriate.
 	 */
-	if (IS_ERR(ipcp))
-		return (void *)ipcp;
-	return container_of(ipcp, struct shmid_kernel, shm_perm);
+	return (void *)ipcp;
 }
 
 static inline void shm_lock_by_ptr(struct shmid_kernel *ipcp)
diff --git a/ipc/util.c b/ipc/util.c
index 4e81182fa0ac..fe61559cd64b 100644
--- a/ipc/util.c
+++ b/ipc/util.c
@@ -576,42 +576,6 @@ struct kern_ipc_perm *ipc_obtain_object_idr(struct ipc_ids *ids, int id)
 	return out;
 }
 
-/**
- * ipc_lock - lock an ipc structure without rwsem held
- * @ids: ipc identifier set
- * @id: ipc id to look for
- *
- * Look for an id in the ipc ids idr and lock the associated ipc object.
- *
- * The ipc object is locked on successful exit.
- */
-struct kern_ipc_perm *ipc_lock(struct ipc_ids *ids, int id)
-{
-	struct kern_ipc_perm *out;
-
-	rcu_read_lock();
-	out = ipc_obtain_object_idr(ids, id);
-	if (IS_ERR(out))
-		goto err;
-
-	spin_lock(&out->lock);
-
-	/*
-	 * ipc_rmid() may have already freed the ID while ipc_lock()
-	 * was spinning: here verify that the structure is still valid.
-	 * Upon races with RMID, return -EIDRM, thus indicating that
-	 * the ID points to a removed identifier.
-	 */
-	if (ipc_valid_object(out))
-		return out;
-
-	spin_unlock(&out->lock);
-	out = ERR_PTR(-EIDRM);
-err:
-	rcu_read_unlock();
-	return out;
-}
-
 /**
  * ipc_obtain_object_check
  * @ids: ipc identifier set
diff --git a/ipc/util.h b/ipc/util.h
index 0aba3230d007..cdb9259e05d1 100644
--- a/ipc/util.h
+++ b/ipc/util.h
@@ -142,7 +142,6 @@ int ipc_rcu_getref(struct kern_ipc_perm *ptr);
 void ipc_rcu_putref(struct kern_ipc_perm *ptr,
 			void (*func)(struct rcu_head *head));
 
-struct kern_ipc_perm *ipc_lock(struct ipc_ids *, int);
 struct kern_ipc_perm *ipc_obtain_object_idr(struct ipc_ids *ids, int id);
 
 void kernel_to_ipc64_perm(struct kern_ipc_perm *in, struct ipc64_perm *out);
-- 
2.16.4

