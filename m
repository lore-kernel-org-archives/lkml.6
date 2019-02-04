Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1EF5C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 20:01:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A41992081B
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 20:01:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727560AbfBDUBN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 15:01:13 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35050 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726789AbfBDUBM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 15:01:12 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id EC32B81F0D;
        Mon,  4 Feb 2019 20:01:10 +0000 (UTC)
Received: from t460s.bristot.redhat.com (ovpn-117-55.phx2.redhat.com [10.3.117.55])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2F9259DA8C;
        Mon,  4 Feb 2019 20:00:59 +0000 (UTC)
From:   Daniel Bristot de Oliveira <bristot@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     bristot@redhat.com, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Jiri Kosina <jkosina@suse.cz>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Chris von Recklinghausen <crecklin@redhat.com>,
        Jason Baron <jbaron@akamai.com>, Scott Wood <swood@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Clark Williams <williams@redhat.com>, x86@kernel.org
Subject: [PATCH V4 7/9] x86/alternative: Batch of patch operations
Date:   Mon,  4 Feb 2019 20:59:00 +0100
Message-Id: <84e6b00634085f0fca721e4e7e5aaf43cd062564.1549308412.git.bristot@redhat.com>
In-Reply-To: <cover.1549308412.git.bristot@redhat.com>
References: <cover.1549308412.git.bristot@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Mon, 04 Feb 2019 20:01:11 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, the patch of an address is done in three steps:

-- Pseudo-code #1 - Current implementation ---
        1) add an int3 trap to the address that will be patched
            sync cores (send IPI to all other CPUs)
        2) update all but the first byte of the patched range
            sync cores (send IPI to all other CPUs)
        3) replace the first byte (int3) by the first byte of replacing opcode
            sync cores (send IPI to all other CPUs)
-- Pseudo-code #1 ---

When a static key has more than one entry, these steps are called once for
each entry. The number of IPIs then is linear with regard to the number 'n' of
entries of a key: O(n*3), which is O(n).

This algorithm works fine for the update of a single key. But we think
it is possible to optimize the case in which a static key has more than
one entry. For instance, the sched_schedstats jump label has 56 entries
in my (updated) fedora kernel, resulting in 168 IPIs for each CPU in
which the thread that is enabling the key is _not_ running.

With this patch, rather than receiving a single patch to be processed, a vector
of patches is passed, enabling the rewrite of the pseudo-code #1 in this
way:

-- Pseudo-code #2 - This patch  ---
1)  for each patch in the vector:
        add an int3 trap to the address that will be patched

    sync cores (send IPI to all other CPUs)

2)  for each patch in the vector:
        update all but the first byte of the patched range

    sync cores (send IPI to all other CPUs)

3)  for each patch in the vector:
        replace the first byte (int3) by the first byte of replacing opcode

    sync cores (send IPI to all other CPUs)
-- Pseudo-code #2 - This patch  ---

Doing the update in this way, the number of IPI becomes O(3) with regard
to the number of keys, which is O(1).

The batch mode is done with the function text_poke_bp_batch(), that receives
two arguments: a vector of "struct text_to_poke", and the number of entries
in the vector.

The vector must be sorted by the addr field of the text_to_poke structure,
enabling the binary search of a handler in the poke_int3_handler function
(a fast path).

Signed-off-by: Daniel Bristot de Oliveira <bristot@redhat.com>
Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Cc: Jiri Kosina <jkosina@suse.cz>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>
Cc: Chris von Recklinghausen <crecklin@redhat.com>
Cc: Jason Baron <jbaron@akamai.com>
Cc: Scott Wood <swood@redhat.com>
Cc: Marcelo Tosatti <mtosatti@redhat.com>
Cc: Clark Williams <williams@redhat.com>
Cc: x86@kernel.org
Cc: linux-kernel@vger.kernel.org
---
 arch/x86/include/asm/text-patching.h |  15 ++++
 arch/x86/kernel/alternative.c        | 124 ++++++++++++++++++++++-----
 2 files changed, 118 insertions(+), 21 deletions(-)

diff --git a/arch/x86/include/asm/text-patching.h b/arch/x86/include/asm/text-patching.h
index e85ff65c43c3..42ea7846df33 100644
--- a/arch/x86/include/asm/text-patching.h
+++ b/arch/x86/include/asm/text-patching.h
@@ -18,6 +18,20 @@ static inline void apply_paravirt(struct paravirt_patch_site *start,
 #define __parainstructions_end	NULL
 #endif
 
+/*
+ * Currently, the max observed size in the kernel code is
+ * JUMP_LABEL_NOP_SIZE/RELATIVEJUMP_SIZE, which are 5.
+ * Raise it if needed.
+ */
+#define POKE_MAX_OPCODE_SIZE	5
+
+struct text_to_poke {
+	void *handler;
+	void *addr;
+	size_t len;
+	const char opcode[POKE_MAX_OPCODE_SIZE];
+};
+
 extern void *text_poke_early(void *addr, const void *opcode, size_t len);
 
 /*
@@ -37,6 +51,7 @@ extern void *text_poke_early(void *addr, const void *opcode, size_t len);
 extern void *text_poke(void *addr, const void *opcode, size_t len);
 extern int poke_int3_handler(struct pt_regs *regs);
 extern void *text_poke_bp(void *addr, const void *opcode, size_t len, void *handler);
+extern void text_poke_bp_batch(struct text_to_poke *tp, unsigned int nr_entries);
 extern int after_bootmem;
 
 #endif /* _ASM_X86_TEXT_PATCHING_H */
diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 202af29c43c0..318b6867dc5a 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -11,6 +11,8 @@
 #include <linux/stop_machine.h>
 #include <linux/slab.h>
 #include <linux/kdebug.h>
+#include <linux/kprobes.h>
+#include <linux/bsearch.h>
 #include <asm/text-patching.h>
 #include <asm/alternative.h>
 #include <asm/sections.h>
@@ -738,10 +740,26 @@ static void do_sync_core(void *info)
 }
 
 static bool bp_patching_in_progress;
-static void *bp_int3_handler, *bp_int3_addr;
+static struct text_to_poke *bp_int3_tpv;
+static unsigned int bp_int3_tpv_nr;
+
+static int text_bp_batch_bsearch(const void *key, const void *elt)
+{
+	struct text_to_poke *tp = (struct text_to_poke *) elt;
+
+	if (key < tp->addr)
+		return -1;
+	if (key > tp->addr)
+		return 1;
+	return 0;
+}
+NOKPROBE_SYMBOL(text_bp_batch_bsearch);
 
 int poke_int3_handler(struct pt_regs *regs)
 {
+	void *ip;
+	struct text_to_poke *tp;
+
 	/*
 	 * Having observed our INT3 instruction, we now must observe
 	 * bp_patching_in_progress.
@@ -757,21 +775,40 @@ int poke_int3_handler(struct pt_regs *regs)
 	if (likely(!bp_patching_in_progress))
 		return 0;
 
-	if (user_mode(regs) || regs->ip != (unsigned long)bp_int3_addr)
+	if (user_mode(regs))
 		return 0;
 
-	/* set up the specified breakpoint handler */
-	regs->ip = (unsigned long) bp_int3_handler;
+	ip = (void *) regs->ip - sizeof(unsigned char);
 
-	return 1;
+	/*
+	 * Skip the binary search if there is a single member in the vector.
+	 */
+	if (unlikely(bp_int3_tpv_nr == 1))
+		goto single_poke;
+
+	tp = bsearch(ip, bp_int3_tpv, bp_int3_tpv_nr,
+		     sizeof(struct text_to_poke),
+		     text_bp_batch_bsearch);
+	if (tp) {
+		/* set up the specified breakpoint handler */
+		regs->ip = (unsigned long) tp->handler;
+		return 1;
+	}
 
+	return 0;
+
+single_poke:
+	if (ip == bp_int3_tpv->addr) {
+		regs->ip = (unsigned long) bp_int3_tpv->handler;
+		return 1;
+	}
+
+	return 0;
 }
 
 static void text_poke_bp_set_handler(void *addr, void *handler,
 				     unsigned char int3)
 {
-	bp_int3_handler = handler;
-	bp_int3_addr = (u8 *)addr + sizeof(int3);
 	text_poke(addr, &int3, sizeof(int3));
 }
 
@@ -791,31 +828,36 @@ static void patch_first_byte(void *addr, const void *opcode, unsigned char int3)
 }
 
 /**
- * text_poke_bp() -- update instructions on live kernel on SMP
- * @addr:	address to patch
- * @opcode:	opcode of new instruction
- * @len:	length to copy
- * @handler:	address to jump to when the temporary breakpoint is hit
+ * text_poke_bp_batch() -- update instructions on live kernel on SMP
+ * @tp:		vector of instructions to patch
+ * @nr_entries:	number of entries in the vector
  *
  * Modify multi-byte instruction by using int3 breakpoint on SMP.
  * We completely avoid stop_machine() here, and achieve the
  * synchronization using int3 breakpoint.
  *
  * The way it is done:
- *	- add a int3 trap to the address that will be patched
+ *	- For each entry in the vector:
+ *	    - add a int3 trap to the address that will be patched
  *	- sync cores
- *	- update all but the first byte of the patched range
+ *	- For each entry in the vector:
+ *	    - update all but the first byte of the patched range
  *	- sync cores
- *	- replace the first byte (int3) by the first byte of
- *	  replacing opcode
+ *	- For each entry in the vector:
+ *	    - replace the first byte (int3) by the first byte of
+ *	      replacing opcode
  *	- sync cores
  */
-void *text_poke_bp(void *addr, const void *opcode, size_t len, void *handler)
+void text_poke_bp_batch(struct text_to_poke *tp, unsigned int nr_entries)
 {
+	unsigned int i;
 	unsigned char int3 = 0xcc;
+	int patched_all_but_first = 0;
 
 	lockdep_assert_held(&text_mutex);
 
+	bp_int3_tpv = tp;
+	bp_int3_tpv_nr = nr_entries;
 	bp_patching_in_progress = true;
 	/*
 	 * Corresponding read barrier in int3 notifier for making sure the
@@ -823,12 +865,20 @@ void *text_poke_bp(void *addr, const void *opcode, size_t len, void *handler)
 	 */
 	smp_wmb();
 
-	text_poke_bp_set_handler(addr, handler, int3);
+	for (i = 0; i < nr_entries; i++)
+		text_poke_bp_set_handler(tp[i].addr, tp[i].handler, int3);
 
 	on_each_cpu(do_sync_core, NULL, 1);
 
-	if (len - sizeof(int3) > 0) {
-		patch_all_but_first_byte(addr, opcode, len, int3);
+	for (i = 0; i < nr_entries; i++) {
+		if (tp[i].len - sizeof(int3) > 0) {
+			patch_all_but_first_byte(tp[i].addr, tp[i].opcode,
+						 tp[i].len, int3);
+			patched_all_but_first++;
+		}
+	}
+
+	if (patched_all_but_first) {
 		/*
 		 * According to Intel, this core syncing is very likely
 		 * not necessary and we'd be safe even without it. But
@@ -837,14 +887,46 @@ void *text_poke_bp(void *addr, const void *opcode, size_t len, void *handler)
 		on_each_cpu(do_sync_core, NULL, 1);
 	}
 
-	patch_first_byte(addr, opcode, int3);
+	for (i = 0; i < nr_entries; i++)
+		patch_first_byte(tp[i].addr, tp[i].opcode, int3);
 
 	on_each_cpu(do_sync_core, NULL, 1);
 	/*
 	 * sync_core() implies an smp_mb() and orders this store against
 	 * the writing of the new instruction.
 	 */
+	bp_int3_tpv_nr = 0;
+	bp_int3_tpv = NULL;
 	bp_patching_in_progress = false;
+}
+
+/**
+ * text_poke_bp() -- update instructions on live kernel on SMP
+ * @addr:	address to patch
+ * @opcode:	opcode of new instruction
+ * @len:	length to copy
+ * @handler:	address to jump to when the temporary breakpoint is hit
+ *
+ * Update a single instruction with the vector in the stack, avoiding
+ * dynamically allocated memory. This function should be used when it is
+ * not possible to allocate memory.
+ */
+void *text_poke_bp(void *addr, const void *opcode, size_t len, void *handler)
+{
+	struct text_to_poke tp = {
+		.handler = handler,
+		.addr = addr,
+		.len = len,
+	};
+
+	if (len > POKE_MAX_OPCODE_SIZE) {
+		WARN_ONCE(1, "len is larger than %d\n", POKE_MAX_OPCODE_SIZE);
+		return NULL;
+	}
+
+	memcpy((void *)tp.opcode, opcode, len);
+
+	text_poke_bp_batch(&tp, 1);
 
 	return addr;
 }
-- 
2.17.1

