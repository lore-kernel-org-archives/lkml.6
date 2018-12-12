Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,T_MIXED_ES,
	UNWANTED_LANGUAGE_BODY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F4F2C65BAF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 22:28:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D31520989
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 22:28:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D31520989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728467AbeLLW2c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 17:28:32 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37329 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727131AbeLLW2b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 17:28:31 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7724830C57CD;
        Wed, 12 Dec 2018 22:28:30 +0000 (UTC)
Received: from llong.com (dhcp-17-223.bos.redhat.com [10.18.17.223])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E80FC6314C;
        Wed, 12 Dec 2018 22:28:28 +0000 (UTC)
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
Subject: [PATCH] debugobjects: Move printk out of db lock critical sections
Date:   Wed, 12 Dec 2018 17:28:14 -0500
Message-Id: <1544653694-27873-1-git-send-email-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Wed, 12 Dec 2018 22:28:31 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The db->lock is a raw spinlock and so the lock hold time is supposed
to be short. This will not be the case when printk() is being involved
in some of the critical sections. In order to avoid the long hold time,
in case some messages need to be printed, the debug_object_is_on_stack()
and debug_print_object() calls are now moved out of those critical
sections.

Holding the db->lock while calling printk() may lead to deadlock if
printk() somehow requires the allocation/freeing of debug object that
happens to be in the same hash bucket or a circular lock dependency
warning from lockdep as reported in https://lkml.org/lkml/2018/12/11/143.

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

Signed-off-by: Waiman Long <longman@redhat.com>
---
 lib/debugobjects.c | 61 +++++++++++++++++++++++++++++++++++++-----------------
 1 file changed, 42 insertions(+), 19 deletions(-)

diff --git a/lib/debugobjects.c b/lib/debugobjects.c
index 14afeeb..c30e786 100644
--- a/lib/debugobjects.c
+++ b/lib/debugobjects.c
@@ -375,6 +375,8 @@ static void debug_object_is_on_stack(void *addr, int onstack)
 	struct debug_bucket *db;
 	struct debug_obj *obj;
 	unsigned long flags;
+	bool debug_printobj = false;
+	bool debug_chkstack = false;
 
 	fill_pool();
 
@@ -391,7 +393,7 @@ static void debug_object_is_on_stack(void *addr, int onstack)
 			debug_objects_oom();
 			return;
 		}
-		debug_object_is_on_stack(addr, onstack);
+		debug_chkstack = true;
 	}
 
 	switch (obj->state) {
@@ -402,20 +404,25 @@ static void debug_object_is_on_stack(void *addr, int onstack)
 		break;
 
 	case ODEBUG_STATE_ACTIVE:
-		debug_print_object(obj, "init");
 		state = obj->state;
 		raw_spin_unlock_irqrestore(&db->lock, flags);
+		debug_print_object(obj, "init");
 		debug_object_fixup(descr->fixup_init, addr, state);
 		return;
 
 	case ODEBUG_STATE_DESTROYED:
-		debug_print_object(obj, "init");
+		debug_printobj = true;
 		break;
 	default:
 		break;
 	}
 
 	raw_spin_unlock_irqrestore(&db->lock, flags);
+	if (debug_chkstack)
+		debug_object_is_on_stack(addr, onstack);
+	if (debug_printobj)
+		debug_print_object(obj, "init");
+
 }
 
 /**
@@ -473,6 +480,8 @@ int debug_object_activate(void *addr, struct debug_obj_descr *descr)
 
 	obj = lookup_object(addr, db);
 	if (obj) {
+		bool debug_printobj = false;
+
 		switch (obj->state) {
 		case ODEBUG_STATE_INIT:
 		case ODEBUG_STATE_INACTIVE:
@@ -481,14 +490,14 @@ int debug_object_activate(void *addr, struct debug_obj_descr *descr)
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
+			debug_printobj = true;
 			ret = -EINVAL;
 			break;
 		default:
@@ -496,10 +505,13 @@ int debug_object_activate(void *addr, struct debug_obj_descr *descr)
 			break;
 		}
 		raw_spin_unlock_irqrestore(&db->lock, flags);
+		if (debug_printobj)
+			debug_print_object(obj, "activate");
 		return ret;
 	}
 
 	raw_spin_unlock_irqrestore(&db->lock, flags);
+
 	/*
 	 * We are here when a static object is activated. We
 	 * let the type specific code confirm whether this is
@@ -531,6 +543,7 @@ void debug_object_deactivate(void *addr, struct debug_obj_descr *descr)
 	struct debug_bucket *db;
 	struct debug_obj *obj;
 	unsigned long flags;
+	bool debug_printobj = false;
 
 	if (!debug_objects_enabled)
 		return;
@@ -548,24 +561,27 @@ void debug_object_deactivate(void *addr, struct debug_obj_descr *descr)
 			if (!obj->astate)
 				obj->state = ODEBUG_STATE_INACTIVE;
 			else
-				debug_print_object(obj, "deactivate");
+				debug_printobj = true;
 			break;
 
 		case ODEBUG_STATE_DESTROYED:
-			debug_print_object(obj, "deactivate");
+			debug_printobj = true;
 			break;
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
+	} else if (debug_printobj) {
+		debug_print_object(obj, "deactivate");
 	}
-
-	raw_spin_unlock_irqrestore(&db->lock, flags);
 }
 EXPORT_SYMBOL_GPL(debug_object_deactivate);
 
@@ -580,6 +596,7 @@ void debug_object_destroy(void *addr, struct debug_obj_descr *descr)
 	struct debug_bucket *db;
 	struct debug_obj *obj;
 	unsigned long flags;
+	bool debug_printobj = false;
 
 	if (!debug_objects_enabled)
 		return;
@@ -599,20 +616,22 @@ void debug_object_destroy(void *addr, struct debug_obj_descr *descr)
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
-		debug_print_object(obj, "destroy");
+		debug_printobj = true;
 		break;
 	default:
 		break;
 	}
 out_unlock:
 	raw_spin_unlock_irqrestore(&db->lock, flags);
+	if (debug_printobj)
+		debug_print_object(obj, "destroy");
 }
 EXPORT_SYMBOL_GPL(debug_object_destroy);
 
@@ -641,9 +660,9 @@ void debug_object_free(void *addr, struct debug_obj_descr *descr)
 
 	switch (obj->state) {
 	case ODEBUG_STATE_ACTIVE:
-		debug_print_object(obj, "free");
 		state = obj->state;
 		raw_spin_unlock_irqrestore(&db->lock, flags);
+		debug_print_object(obj, "free");
 		debug_object_fixup(descr->fixup_free, addr, state);
 		return;
 	default:
@@ -716,6 +735,7 @@ void debug_object_assert_init(void *addr, struct debug_obj_descr *descr)
 	struct debug_bucket *db;
 	struct debug_obj *obj;
 	unsigned long flags;
+	bool debug_printobj = false;
 
 	if (!debug_objects_enabled)
 		return;
@@ -731,22 +751,25 @@ void debug_object_assert_init(void *addr, struct debug_obj_descr *descr)
 			if (obj->astate == expect)
 				obj->astate = next;
 			else
-				debug_print_object(obj, "active_state");
+				debug_printobj = true;
 			break;
 
 		default:
-			debug_print_object(obj, "active_state");
+			debug_printobj = true;
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
 
 		debug_print_object(&o, "active_state");
+	} else if (debug_printobj) {
+		debug_print_object(obj, "active_state");
 	}
-
-	raw_spin_unlock_irqrestore(&db->lock, flags);
 }
 EXPORT_SYMBOL_GPL(debug_object_active_state);
 
@@ -782,10 +805,10 @@ static void __debug_check_no_obj_freed(const void *address, unsigned long size)
 
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
-- 
1.8.3.1

