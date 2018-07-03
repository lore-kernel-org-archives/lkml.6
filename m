Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4903C6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 20:04:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64082248C3
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 20:04:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64082248C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753123AbeGCUEG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 16:04:06 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:45332 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752910AbeGCUCE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 16:02:04 -0400
Received: from localhost ([127.0.0.1] helo=bazinga.breakpoint.cc)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1faRUv-0001tM-Gj; Tue, 03 Jul 2018 22:02:01 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 5/6] userns: Use refcount_t for reference counting instead atomic_t
Date:   Tue,  3 Jul 2018 22:01:40 +0200
Message-Id: <20180703200141.28415-6-bigeasy@linutronix.de>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180703200141.28415-1-bigeasy@linutronix.de>
References: <20180703200141.28415-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

refcount_t type and corresponding API should be used instead of atomic_t wh=
en
the variable is used as a reference counter. This allows to avoid accidental
refcounter overflows that might lead to use-after-free situations.

Cc: Andrew Morton <akpm@linux-foundation.org>
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 include/linux/sched/user.h | 5 +++--
 kernel/user.c              | 8 ++++----
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/include/linux/sched/user.h b/include/linux/sched/user.h
index 96fe289c4c6e..39ad98c09c58 100644
--- a/include/linux/sched/user.h
+++ b/include/linux/sched/user.h
@@ -4,6 +4,7 @@
=20
 #include <linux/uidgid.h>
 #include <linux/atomic.h>
+#include <linux/refcount.h>
 #include <linux/ratelimit.h>
=20
 struct key;
@@ -12,7 +13,7 @@ struct key;
  * Some day this will be a full-fledged user tracking system..
  */
 struct user_struct {
-	atomic_t __count;	/* reference count */
+	refcount_t __count;	/* reference count */
 	atomic_t processes;	/* How many processes does this user have? */
 	atomic_t sigpending;	/* How many pending signals does this user have? */
 #ifdef CONFIG_FANOTIFY
@@ -59,7 +60,7 @@ extern struct user_struct root_user;
 extern struct user_struct * alloc_uid(kuid_t);
 static inline struct user_struct *get_uid(struct user_struct *u)
 {
-	atomic_inc(&u->__count);
+	refcount_inc(&u->__count);
 	return u;
 }
 extern void free_uid(struct user_struct *);
diff --git a/kernel/user.c b/kernel/user.c
index 36288d840675..5f65ef195259 100644
--- a/kernel/user.c
+++ b/kernel/user.c
@@ -96,7 +96,7 @@ static DEFINE_SPINLOCK(uidhash_lock);
=20
 /* root_user.__count is 1, for init task cred */
 struct user_struct root_user =3D {
-	.__count	=3D ATOMIC_INIT(1),
+	.__count	=3D REFCOUNT_INIT(1),
 	.processes	=3D ATOMIC_INIT(1),
 	.sigpending	=3D ATOMIC_INIT(0),
 	.locked_shm     =3D 0,
@@ -123,7 +123,7 @@ static struct user_struct *uid_hash_find(kuid_t uid, st=
ruct hlist_head *hashent)
=20
 	hlist_for_each_entry(user, hashent, uidhash_node) {
 		if (uid_eq(user->uid, uid)) {
-			atomic_inc(&user->__count);
+			refcount_inc(&user->__count);
 			return user;
 		}
 	}
@@ -170,7 +170,7 @@ void free_uid(struct user_struct *up)
 		return;
=20
 	local_irq_save(flags);
-	if (atomic_dec_and_lock(&up->__count, &uidhash_lock))
+	if (refcount_dec_and_lock(&up->__count, &uidhash_lock))
 		free_user(up, flags);
 	else
 		local_irq_restore(flags);
@@ -191,7 +191,7 @@ struct user_struct *alloc_uid(kuid_t uid)
 			goto out_unlock;
=20
 		new->uid =3D uid;
-		atomic_set(&new->__count, 1);
+		refcount_set(&new->__count, 1);
 		ratelimit_state_init(&new->ratelimit, HZ, 100);
 		ratelimit_set_flags(&new->ratelimit, RATELIMIT_MSG_ON_RELEASE);
=20
--=20
2.18.0

