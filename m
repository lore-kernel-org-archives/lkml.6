Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,T_MIXED_ES
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84D08C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 21:59:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43B9E20811
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 21:59:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43B9E20811
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728384AbeLMV7z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 16:59:55 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41720 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727904AbeLMV7y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 16:59:54 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 42FFE3001FFA;
        Thu, 13 Dec 2018 21:59:54 +0000 (UTC)
Received: from llong.com (dhcp-17-223.bos.redhat.com [10.18.17.223])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0836A5D6A9;
        Thu, 13 Dec 2018 21:59:49 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Dmitry Safonov <dima@arista.com>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH v2] debugobjects: Move printk out of db lock critical sections
Date:   Thu, 13 Dec 2018 16:59:37 -0500
Message-Id: <1544738377-3848-1-git-send-email-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Thu, 13 Dec 2018 21:59:54 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The db->lock is a raw spinlock and so the lock hold time is supposed to
be short. This will not be the case when printk() is being involved in
some of the critical sections.

In order to avoid the long hold time, in case some messages need to be
printed, all the debug_object_is_on_stack() and debug_print_object()
calls are now moved out of those critical sections in the following
functions.

 - __debug_object_init()
 - debug_object_activate()
 - debug_object_deactivate()
 - debug_object_destroy()
 - debug_object_free()
 - debug_object_active_state()
 - __debug_check_no_obj_freed()
 - check_results()

Holding the db->lock while calling printk() may lead to deadlock if
printk() somehow requires the allocation/freeing of debug object that
happens to be in the same hash bucket or a circular lock dependency
warning from lockdep as reported in

  https://lkml.kernel.org/r/20181211091154.GL23332@shao2-debian

[   87.209665] WARNING: possible circular locking dependency detected
[   87.210547] 4.20.0-rc4-00057-gc96cf92 #1 Tainted: G        W
[   87.211449] ------------------------------------------------------
[   87.212405] getty/519 is trying to acquire lock:
[   87.213074] (____ptrval____) (&obj_hash[i].lock){-.-.}, at: debug_check_no_obj_freed+0xb4/0x302
[   87.214343]
[   87.214343] but task is already holding lock:
[   87.215174] (____ptrval____) (&port_lock_key){-.-.}, at: uart_shutdown+0x3a3/0x4e2
[   87.216260]
[   87.216260] which lock already depends on the new lock.

This patch was also found to be able to fix a boot hanging problem
when the initramfs image was switched on after a debugobjects splat
from the EFI code.

 v2: Move debug_print_object() in check_results(), eliminate
     debug_print_obj & modify URL.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 lib/debugobjects.c | 66 ++++++++++++++++++++++++++++++----------------
 1 file changed, 44 insertions(+), 22 deletions(-)

diff --git a/lib/debugobjects.c b/lib/debugobjects.c
index 14afeeb7d6ef..2fe55745d641 100644
--- a/lib/debugobjects.c
+++ b/lib/debugobjects.c
@@ -375,6 +375,7 @@ __debug_object_init(void *addr, struct debug_obj_descr *descr, int onstack)
 	struct debug_bucket *db;
 	struct debug_obj *obj;
 	unsigned long flags;
+	bool check_object_on_stack = false;
 
 	fill_pool();
 
@@ -391,7 +392,7 @@ __debug_object_init(void *addr, struct debug_obj_descr *descr, int onstack)
 			debug_objects_oom();
 			return;
 		}
-		debug_object_is_on_stack(addr, onstack);
+		check_object_on_stack = true;
 	}
 
 	switch (obj->state) {
@@ -402,20 +403,24 @@ __debug_object_init(void *addr, struct debug_obj_descr *descr, int onstack)
 		break;
 
 	case ODEBUG_STATE_ACTIVE:
-		debug_print_object(obj, "init");
 		state = obj->state;
 		raw_spin_unlock_irqrestore(&db->lock, flags);
+		debug_print_object(obj, "init");
 		debug_object_fixup(descr->fixup_init, addr, state);
 		return;
 
 	case ODEBUG_STATE_DESTROYED:
+		raw_spin_unlock_irqrestore(&db->lock, flags);
 		debug_print_object(obj, "init");
-		break;
+		return;
 	default:
 		break;
 	}
 
 	raw_spin_unlock_irqrestore(&db->lock, flags);
+	if (check_object_on_stack)
+		debug_object_is_on_stack(addr, onstack);
+
 }
 
 /**
@@ -473,33 +478,34 @@ int debug_object_activate(void *addr, struct debug_obj_descr *descr)
 
 	obj = lookup_object(addr, db);
 	if (obj) {
+		ret = 0;
 		switch (obj->state) {
 		case ODEBUG_STATE_INIT:
 		case ODEBUG_STATE_INACTIVE:
 			obj->state = ODEBUG_STATE_ACTIVE;
-			ret = 0;
 			break;
 
 		case ODEBUG_STATE_ACTIVE:
-			debug_print_object(obj, "activate");
 			state = obj->state;
 			raw_spin_unlock_irqrestore(&db->lock, flags);
+			debug_print_object(obj, "activate");
 			ret = debug_object_fixup(descr->fixup_activate, addr, state);
 			return ret ? 0 : -EINVAL;
 
 		case ODEBUG_STATE_DESTROYED:
-			debug_print_object(obj, "activate");
 			ret = -EINVAL;
 			break;
 		default:
-			ret = 0;
 			break;
 		}
 		raw_spin_unlock_irqrestore(&db->lock, flags);
+		if (ret)
+			debug_print_object(obj, "activate");
 		return ret;
 	}
 
 	raw_spin_unlock_irqrestore(&db->lock, flags);
+
 	/*
 	 * We are here when a static object is activated. We
 	 * let the type specific code confirm whether this is
@@ -548,24 +554,30 @@ void debug_object_deactivate(void *addr, struct debug_obj_descr *descr)
 			if (!obj->astate)
 				obj->state = ODEBUG_STATE_INACTIVE;
 			else
-				debug_print_object(obj, "deactivate");
+				goto out_unlock_print;
 			break;
 
 		case ODEBUG_STATE_DESTROYED:
-			debug_print_object(obj, "deactivate");
-			break;
+			goto out_unlock_print;
+
 		default:
 			break;
 		}
-	} else {
+	}
+
+	raw_spin_unlock_irqrestore(&db->lock, flags);
+	if (!obj) {
 		struct debug_obj o = { .object = addr,
 				       .state = ODEBUG_STATE_NOTAVAILABLE,
 				       .descr = descr };
 
 		debug_print_object(&o, "deactivate");
 	}
+	return;
 
+out_unlock_print:
 	raw_spin_unlock_irqrestore(&db->lock, flags);
+	debug_print_object(obj, "deactivate");
 }
 EXPORT_SYMBOL_GPL(debug_object_deactivate);
 
@@ -599,15 +611,16 @@ void debug_object_destroy(void *addr, struct debug_obj_descr *descr)
 		obj->state = ODEBUG_STATE_DESTROYED;
 		break;
 	case ODEBUG_STATE_ACTIVE:
-		debug_print_object(obj, "destroy");
 		state = obj->state;
 		raw_spin_unlock_irqrestore(&db->lock, flags);
+		debug_print_object(obj, "destroy");
 		debug_object_fixup(descr->fixup_destroy, addr, state);
 		return;
 
 	case ODEBUG_STATE_DESTROYED:
+		raw_spin_unlock_irqrestore(&db->lock, flags);
 		debug_print_object(obj, "destroy");
-		break;
+		return;
 	default:
 		break;
 	}
@@ -641,9 +654,9 @@ void debug_object_free(void *addr, struct debug_obj_descr *descr)
 
 	switch (obj->state) {
 	case ODEBUG_STATE_ACTIVE:
-		debug_print_object(obj, "free");
 		state = obj->state;
 		raw_spin_unlock_irqrestore(&db->lock, flags);
+		debug_print_object(obj, "free");
 		debug_object_fixup(descr->fixup_free, addr, state);
 		return;
 	default:
@@ -731,22 +744,27 @@ debug_object_active_state(void *addr, struct debug_obj_descr *descr,
 			if (obj->astate == expect)
 				obj->astate = next;
 			else
-				debug_print_object(obj, "active_state");
+				goto out_unlock_print;
 			break;
 
 		default:
-			debug_print_object(obj, "active_state");
-			break;
+			goto out_unlock_print;
 		}
-	} else {
+	}
+
+	raw_spin_unlock_irqrestore(&db->lock, flags);
+	if (!obj) {
 		struct debug_obj o = { .object = addr,
 				       .state = ODEBUG_STATE_NOTAVAILABLE,
 				       .descr = descr };
 
 		debug_print_object(&o, "active_state");
 	}
+	return;
 
+out_unlock_print:
 	raw_spin_unlock_irqrestore(&db->lock, flags);
+	debug_print_object(obj, "active_state");
 }
 EXPORT_SYMBOL_GPL(debug_object_active_state);
 
@@ -782,10 +800,10 @@ static void __debug_check_no_obj_freed(const void *address, unsigned long size)
 
 			switch (obj->state) {
 			case ODEBUG_STATE_ACTIVE:
-				debug_print_object(obj, "free");
 				descr = obj->descr;
 				state = obj->state;
 				raw_spin_unlock_irqrestore(&db->lock, flags);
+				debug_print_object(obj, "free");
 				debug_object_fixup(descr->fixup_free,
 						   (void *) oaddr, state);
 				goto repeat;
@@ -978,19 +996,24 @@ check_results(void *addr, enum debug_obj_state state, int fixups, int warnings)
 	struct debug_obj *obj;
 	unsigned long flags;
 	int res = -EINVAL;
+	enum debug_obj_state obj_state;
 
 	db = get_bucket((unsigned long) addr);
 
 	raw_spin_lock_irqsave(&db->lock, flags);
 
 	obj = lookup_object(addr, db);
+	obj_state = obj ? obj->state : state;
+
+	raw_spin_unlock_irqrestore(&db->lock, flags);
+
 	if (!obj && state != ODEBUG_STATE_NONE) {
 		WARN(1, KERN_ERR "ODEBUG: selftest object not found\n");
 		goto out;
 	}
-	if (obj && obj->state != state) {
+	if (obj_state != state) {
 		WARN(1, KERN_ERR "ODEBUG: selftest wrong state: %d != %d\n",
-		       obj->state, state);
+		       obj_state, state);
 		goto out;
 	}
 	if (fixups != debug_objects_fixups) {
@@ -1005,7 +1028,6 @@ check_results(void *addr, enum debug_obj_state state, int fixups, int warnings)
 	}
 	res = 0;
 out:
-	raw_spin_unlock_irqrestore(&db->lock, flags);
 	if (res)
 		debug_objects_enabled = 0;
 	return res;
-- 
2.18.1

