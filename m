Return-Path: <daniel.vetter@ffwll.ch>
ARC-Seal: i=1; a=rsa-sha256; t=1521561785; cv=none;
        d=google.com; s=arc-20160816;
        b=HbSOM3BmX27zkMlHnBG5ksijbcmOLV9Ad2tTzZ4LoCAstpRsMuw6sW/WaRnf0ADAGv
         ETdShk2bPEWLJSPsb3c4hbMV/ldToQcYNRJFiEnWhO1BQp2AxML27spcIeY6dbUe25Qm
         k3IYqMyHwX6jU9wiW3rrIzJBmk10mVOWeoDZ6SI/lyN9X9lM/SzWIxjUOpog7gdj7CIq
         5KDjuIUnOfN8gWritCimOuhUs+XvWpQgBROfZwH2cyoXvYv1UPHj8cwlI49ohX01v8x1
         xHSYWWs4qYxEERJS/bYkPJkawQMbNpMltDxtFnzPmtdrwQ/ztXmATgsF8/YXlpMLralU
         VklA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=GFmYyDaRXNdyDXS+ka8h/XRlijrUjUYsYDQzfsLVzYo=;
        b=cj1j7joOE0ux2N9HeZefydR2Mbs7f+1m4f6NP2JpEP9p9AyT/bVlmbui6O7NKz9gQr
         ApkhVG51Trs6B5zEJLn17gPo7aDF/6JQKrPh76FpT6PHImI0v6O6KYmv35Eqn3UO4kvo
         UT49ULZR4wTjWW01wRmhK8LnYYugZJspKTW6WEpp7PxJP+rl9z7rsXtQb3X3a82VWCp4
         TptNvqK/NMFTxG4DJY2UMHVnONnfN2d5XyNrZLObqliYxGiiBtcAKqtI5KmIeRgnQ+dy
         PkvPEYzmiJcvf3CODU1LhoJOLZADeFaNtQ06pLLjWHrksAeZ5uHEbAhevw1Rvv1jHP3p
         pl7A==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@ffwll.ch header.s=google header.b=VK93NXqh;
       spf=neutral (google.com: 209.85.220.65 is neither permitted nor denied by best guess record for domain of daniel.vetter@ffwll.ch) smtp.mailfrom=daniel.vetter@ffwll.ch
Authentication-Results: mx.google.com;
       dkim=pass header.i=@ffwll.ch header.s=google header.b=VK93NXqh;
       spf=neutral (google.com: 209.85.220.65 is neither permitted nor denied by best guess record for domain of daniel.vetter@ffwll.ch) smtp.mailfrom=daniel.vetter@ffwll.ch
X-Google-Smtp-Source: AG47ELtp+I1gSmRsjKXTaqDUpqpbByVDJzQVFra2BQsHDdtP1UEetTI9ngzaXowNaBYHp49AEl5tbg==
From: Daniel Vetter <daniel.vetter@ffwll.ch>
To: Intel Graphics Development <intel-gfx@lists.freedesktop.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Daniel Vetter <daniel.vetter@ffwll.ch>,
	Philippe Ombredanne <pombredanne@nexb.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Kate Stewart <kstewart@linuxfoundation.org>,
	Waiman Long <longman@redhat.com>,
	Daniel Vetter <daniel.vetter@intel.com>
Subject: [PATCH] RFC: debugobjects: capture stack traces at _init() time
Date: Tue, 20 Mar 2018 17:02:58 +0100
Message-Id: <20180320160258.11381-1-daniel.vetter@ffwll.ch>
X-Mailer: git-send-email 2.16.2
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595473170470511522?=
X-GMAIL-MSGID: =?utf-8?q?1595473170470511522?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Sometimes it's really easy to know which object has gone boom and
where the offending code is, and sometimes it's really hard. One case
we're trying to hunt down is when module unload catches a live debug
object, with a module with lots of them.

Capture a full stack trace from debug_object_init() and dump it when
there's a problem.

FIXME: Should we have a separate Kconfig knob for the backtraces,
they're quite expensive? Atm I'm just selecting it for the general
debug object stuff.

v2: Drop the locks for gathering&storing the backtrace. This is
required because depot_save_stack can call free_pages (to drop it's
preallocation), which can call debug_check_no_obj_freed, which will
recurse into the db->lock spinlocks.

Cc: Philippe Ombredanne <pombredanne@nexb.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Kate Stewart <kstewart@linuxfoundation.org>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Waiman Long <longman@redhat.com>
Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
---
 include/linux/debugobjects.h |  2 ++
 lib/Kconfig.debug            |  1 +
 lib/debugobjects.c           | 57 +++++++++++++++++++++++++++++++++++++++-----
 3 files changed, 54 insertions(+), 6 deletions(-)

diff --git a/include/linux/debugobjects.h b/include/linux/debugobjects.h
index afc416e5dcab..d3a6ca1a7756 100644
--- a/include/linux/debugobjects.h
+++ b/include/linux/debugobjects.h
@@ -4,6 +4,7 @@
 
 #include <linux/list.h>
 #include <linux/spinlock.h>
+#include <linux/stackdepot.h>
 
 enum debug_obj_state {
 	ODEBUG_STATE_NONE,
@@ -31,6 +32,7 @@ struct debug_obj {
 	unsigned int		astate;
 	void			*object;
 	struct debug_obj_descr	*descr;
+	depot_stack_handle_t	stack;
 };
 
 /**
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 64155e310a9f..894dd792e771 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -442,6 +442,7 @@ source mm/Kconfig.debug
 config DEBUG_OBJECTS
 	bool "Debug object operations"
 	depends on DEBUG_KERNEL
+	select STACKDEPOT
 	help
 	  If you say Y here, additional code will be inserted into the
 	  kernel to track the life time of various objects and validate
diff --git a/lib/debugobjects.c b/lib/debugobjects.c
index 2f5349c6e81a..2acad7150bee 100644
--- a/lib/debugobjects.c
+++ b/lib/debugobjects.c
@@ -19,6 +19,7 @@
 #include <linux/slab.h>
 #include <linux/hash.h>
 #include <linux/kmemleak.h>
+#include <linux/stacktrace.h>
 
 #define ODEBUG_HASH_BITS	14
 #define ODEBUG_HASH_SIZE	(1 << ODEBUG_HASH_BITS)
@@ -30,6 +31,8 @@
 #define ODEBUG_CHUNK_SIZE	(1 << ODEBUG_CHUNK_SHIFT)
 #define ODEBUG_CHUNK_MASK	(~(ODEBUG_CHUNK_SIZE - 1))
 
+#define ODEBUG_STACKDEPTH 32
+
 struct debug_bucket {
 	struct hlist_head	list;
 	raw_spinlock_t		lock;
@@ -280,15 +283,24 @@ static void debug_print_object(struct debug_obj *obj, char *msg)
 {
 	struct debug_obj_descr *descr = obj->descr;
 	static int limit;
+	unsigned long entries[ODEBUG_STACKDEPTH];
+	struct stack_trace trace = {
+		.entries = entries,
+		.max_entries = ODEBUG_STACKDEPTH
+	};
+
 
 	if (limit < 5 && descr != descr_test) {
 		void *hint = descr->debug_hint ?
 			descr->debug_hint(obj->object) : NULL;
 		limit++;
+		depot_fetch_stack(obj->stack, &trace);
 		WARN(1, KERN_ERR "ODEBUG: %s %s (active state %u) "
 				 "object type: %s hint: %pS\n",
 			msg, obj_states[obj->state], obj->astate,
 			descr->name, hint);
+		pr_err("ODEBUG: debug object originally initialized at:\n");
+		print_stack_trace(&trace, 2);
 	}
 	debug_objects_warnings++;
 }
@@ -328,6 +340,24 @@ static void debug_object_is_on_stack(void *addr, int onstack)
 	WARN_ON(1);
 }
 
+static noinline depot_stack_handle_t save_stack(struct debug_obj *obj)
+{
+	unsigned long entries[ODEBUG_STACKDEPTH];
+	struct stack_trace trace = {
+		.entries = entries,
+		.max_entries = ODEBUG_STACKDEPTH,
+		.skip = 2
+	};
+
+	save_stack_trace(&trace);
+	if (trace.nr_entries != 0 &&
+	    trace.entries[trace.nr_entries-1] == ULONG_MAX)
+		trace.nr_entries--;
+
+	/* May be called under spinlock, so avoid sleeping */
+	return depot_save_stack(&trace, GFP_NOWAIT);
+}
+
 static void
 __debug_object_init(void *addr, struct debug_obj_descr *descr, int onstack)
 {
@@ -344,14 +374,29 @@ __debug_object_init(void *addr, struct debug_obj_descr *descr, int onstack)
 
 	obj = lookup_object(addr, db);
 	if (!obj) {
-		obj = alloc_object(addr, db, descr);
+		depot_stack_handle_t stack;
+
+		/*
+		 * must drop locks while storing the stack trace to avoid
+		 * recursive deadlock through depot_save_stack
+		 * allocating/freeing memory.
+		 */
+		raw_spin_unlock_irqrestore(&db->lock, flags);
+		stack = save_stack(obj);
+		raw_spin_lock_irqsave(&db->lock, flags);
+
+		obj = lookup_object(addr, db);
 		if (!obj) {
-			debug_objects_enabled = 0;
-			raw_spin_unlock_irqrestore(&db->lock, flags);
-			debug_objects_oom();
-			return;
+			obj = alloc_object(addr, db, descr);
+			if (!obj) {
+				debug_objects_enabled = 0;
+				raw_spin_unlock_irqrestore(&db->lock, flags);
+				debug_objects_oom();
+				return;
+			}
+			debug_object_is_on_stack(addr, onstack);
+			obj->stack = stack;
 		}
-		debug_object_is_on_stack(addr, onstack);
 	}
 
 	switch (obj->state) {
-- 
2.16.2
