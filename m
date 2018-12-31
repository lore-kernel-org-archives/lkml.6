Return-Path: <SRS0=w+lf=PI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C60AEC43613
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 07:20:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2B4A21019
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 07:20:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727124AbeLaHUp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Dec 2018 02:20:45 -0500
Received: from ex13-edg-ou-002.vmware.com ([208.91.0.190]:25217 "EHLO
        EX13-EDG-OU-002.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726442AbeLaHUl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Dec 2018 02:20:41 -0500
Received: from sc9-mailhost3.vmware.com (10.113.161.73) by
 EX13-EDG-OU-002.vmware.com (10.113.208.156) with Microsoft SMTP Server id
 15.0.1156.6; Sun, 30 Dec 2018 23:20:33 -0800
Received: from sc2-haas01-esx0118.eng.vmware.com (sc2-haas01-esx0118.eng.vmware.com [10.172.44.118])
        by sc9-mailhost3.vmware.com (Postfix) with ESMTP id D0EE140687;
        Sun, 30 Dec 2018 23:20:35 -0800 (PST)
From:   Nadav Amit <namit@vmware.com>
To:     Ingo Molnar <mingo@redhat.com>, Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Edward Cree <ecree@solarflare.com>
CC:     "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Nadav Amit <nadav.amit@gmail.com>, X86 ML <x86@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Nadav Amit <namit@vmware.com>
Subject: [RFC v2 6/6] x86: outline optpoline
Date:   Sun, 30 Dec 2018 23:21:12 -0800
Message-ID: <20181231072112.21051-7-namit@vmware.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181231072112.21051-1-namit@vmware.com>
References: <20181231072112.21051-1-namit@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (EX13-EDG-OU-002.vmware.com: namit@vmware.com does not
 designate permitted sender hosts)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When there is more than a single target, we can set an outline block to
hold optimized for few more targets. This is done dynamically during
runtime, limiting the potential memory consumption.

If preemption is performed while we are running the outline block, we
jump to the indirect thunk, and continue execution from there.

The current version does not reclaim memory if an entire page of
outline optpoline blocks is released (e.g., due to module removal).
There are various additional optimizations that are possible to reduce
the memory consumption of each optpoline.

Signed-off-by: Nadav Amit <namit@vmware.com>
---
 arch/x86/kernel/nospec-branch.c | 372 ++++++++++++++++++++++++++++----
 1 file changed, 331 insertions(+), 41 deletions(-)

diff --git a/arch/x86/kernel/nospec-branch.c b/arch/x86/kernel/nospec-branch.c
index 1503c312f715..df787a00a51a 100644
--- a/arch/x86/kernel/nospec-branch.c
+++ b/arch/x86/kernel/nospec-branch.c
@@ -18,6 +18,8 @@
 #include <linux/debugfs.h>
 #include <linux/jump_label.h>
 #include <linux/rhashtable.h>
+#include <linux/moduleloader.h>
+#include <linux/set_memory.h>
 #include <asm/nospec-branch.h>
 #include <asm/text-patching.h>
 #include <asm/asm-offsets.h>
@@ -32,11 +34,16 @@
 #define NOP_OPCODE		(0x90)
 #define INT3_OPCODE		(0xcc)
 #define CALL_IND_INS		"\xff\xd0"
+#define JMP_REL32_OPCODE        (0xe9)
+#define JZ_REL32_OPCODE		"\x0f\x84"
 
 #define OP_READJUST_SECONDS	(1)
 #define OP_REENABLE_IN_EPOCH	(4)
 #define OP_ENABLE_IN_EPOCH	(512)
 #define OP_SAMPLE_MSECS		(30000)
+#define OP_INLINED_TARGETS	(1)
+#define OP_OUTLINED_TARGETS	(6)
+#define OP_N_TARGETS		(OP_INLINED_TARGETS + OP_OUTLINED_TARGETS)
 
 enum code_state {
 	OPTPOLINE_SLOWPATH,
@@ -46,12 +53,25 @@ enum code_state {
 
 /*
  * Information for optpolines as it dynamically changes during execution.
+ *
+ * TODO: This structure is under-optimized. For example, we can reduce its size
+ * and not save the targets, but instead realize them from the code itself.
  */
 struct optpoline {
 	struct list_head node;
 	struct rhash_head rhash;
+
+	/*
+	 * Using hashtable to look for the optpoline by the instruction-pointer.
+	 */
+	struct rhash_head outline_rhash;
+
+	/* Outline code block; NULL if none */
+	union outline_optpoline *outline_op;
+
 	u32 rip;
-	u32 target;
+	u32 outline_rip;
+	u32 targets[OP_N_TARGETS];
 
 	/* The register that is used by the indirect branch */
 	u8 reg : 4;
@@ -59,12 +79,6 @@ struct optpoline {
 	/* The state of the optpoline, which indicates on which list it is */
 	u8 state : 3;
 
-	/* Whether we ever encountered more than one target */
-	u8 unstable : 1;
-
-	/* Whether there is a valid target */
-	u8 has_target : 1;
-
 	/*
 	 * Whether the optpoline needs to be set into training mode. This is a
 	 * transitory indication, which is cleared once it is set in learning
@@ -87,8 +101,16 @@ static const struct rhashtable_params optpoline_rht_params = {
 	.head_offset = offsetof(struct optpoline, rhash),
 };
 
+static const struct rhashtable_params outline_optpoline_rht_params = {
+	.automatic_shrinking = true,
+	.key_len = sizeof(u32),
+	.key_offset = offsetof(struct optpoline, outline_rip),
+	.head_offset = offsetof(struct optpoline, outline_rhash),
+};
+
+
 DEFINE_PER_CPU_ALIGNED(struct optpoline_sample[OPTPOLINE_SAMPLES_NUM],
-		       optpoline_samples);
+			optpoline_samples);
 DEFINE_PER_CPU(u8, has_optpoline_samples);
 
 enum optpoline_state {
@@ -114,6 +136,38 @@ static const char *const optpoline_state_name[OP_STATE_NUM] = {
 	[OP_STATE_UPDATING] = "updating",
 };
 
+union outline_optpoline_entry {
+	struct {
+		struct {
+			u8 no_preempt_prefix;
+			u8 rex_prefix;
+			u8 opcode;
+			u8 modrm;
+			u32 imm;
+		} __packed cmp;
+		struct {
+			u8 no_preempt_prefix;
+			u8 opcode[2];
+			int32_t rel;
+		} __packed jz;
+	} __packed;
+	struct {
+		u8 no_preempt_prefix;
+		u8 opcode;
+		int32_t rel;
+	} __packed fallback;
+} __packed;
+
+#define OP_OUTLINE_SIZE							\
+	(ALIGN(sizeof(union outline_optpoline_entry) *			\
+		(OP_OUTLINED_TARGETS + 1), SMP_CACHE_BYTES))
+
+union outline_optpoline {
+	union outline_optpoline_entry entries[OP_OUTLINED_TARGETS + 1];
+	union outline_optpoline *next_free;
+	u8 padding[OP_OUTLINE_SIZE];
+} __packed;
+
 struct optpolines {
 	struct mutex mutex;
 	struct optpoline_sample *samples_copy;
@@ -124,6 +178,12 @@ struct optpolines {
 	 */
 	struct rhashtable rhead;
 
+	/*
+	 * Hashtable that holds all the outlined optpolines, key'd by the
+	 * instruction pointer of the outline optpoline code block, aligned.
+	 */
+	struct rhashtable outline_rhead;
+
 	/*
 	 * List of optpolines according to their states.
 	 */
@@ -140,6 +200,7 @@ struct optpolines {
 	 * wasn't initialized, so we need to keep track of it.
 	 */
 	u8 rhead_initialized : 1;
+	u8 outline_rhead_initialized : 1;
 
 	 /* Number of unstable optpolines that are pending relearning. */
 	unsigned int pending_relearn;
@@ -147,11 +208,18 @@ struct optpolines {
 	/* Kernel (excluding modules) optpolines */
 	struct optpoline *kernel_optpolines;
 
+	union outline_optpoline *outline_free_list;
+
 	struct dentry *dbg_entry;
 
 	ktime_t sample_time;
 };
 
+struct optpoline_target {
+	u32 target;
+	u32 count;
+};
+
 static struct optpolines optpolines;
 
 static inline void *kernel_ptr(u32 low_addr)
@@ -169,6 +237,149 @@ static inline u8 optpoline_cmp_modrm(u8 reg)
 	return 0xf8 | reg;
 }
 
+static void release_outline_branch_block(struct optpoline *op)
+{
+	union outline_optpoline *p_outline = kernel_ptr(op->outline_rip);
+
+	if (!p_outline)
+		return;
+
+	/*
+	 * Update the linked-list, but since these are code pages, we need to do
+	 * it by poking the text.
+	 */
+	text_poke(&p_outline->next_free, optpolines.outline_free_list,
+		  sizeof(p_outline->next_free));
+	optpolines.outline_free_list = p_outline;
+
+	rhashtable_remove_fast(&optpolines.outline_rhead, &op->outline_rhash,
+			       outline_optpoline_rht_params);
+
+	op->outline_rip = 0;
+
+	/* TODO: release the whole page if its reference count drops to zero */
+}
+
+static void alloc_outline_branch_block(struct optpoline *op)
+{
+	const u32 entries_per_chunk = PAGE_SIZE / OP_OUTLINE_SIZE;
+	union outline_optpoline *outline, *chunk;
+	unsigned int i;
+	int r;
+
+retry:
+	outline = optpolines.outline_free_list;
+	if (outline) {
+		op->outline_rip = (u32)(uintptr_t)outline;
+		r = rhashtable_insert_fast(&optpolines.outline_rhead, &op->rhash,
+					   outline_optpoline_rht_params);
+
+		if (unlikely(r < 0)) {
+			WARN_ONCE(1, "outline block allocation failed");
+			op->outline_rip = 0;
+			return;
+		}
+
+		optpolines.outline_free_list = outline->next_free;
+		return;
+	}
+
+	chunk = module_alloc(PAGE_SIZE);
+	if (unlikely(!chunk)) {
+		WARN_ONCE(1, "outline block allocation failed");
+		return;
+	}
+
+	/* Add the entries from the newly allocated chunk to the linked list */
+	for (i = 1; i < entries_per_chunk; i++)
+		chunk[i - 1].next_free = &chunk[i];
+
+	chunk[entries_per_chunk - 1].next_free = optpolines.outline_free_list;
+	optpolines.outline_free_list = &chunk[0];
+
+	set_memory_ro((uintptr_t)chunk, 1);
+	goto retry;
+}
+
+static int make_outline_optpoline(struct optpoline *op)
+{
+	union outline_optpoline outline_op, *p_outline;
+	union outline_optpoline_entry *entry;
+	uintptr_t rel_from, rel_to;
+	size_t set_bytes;
+	unsigned int i;
+	u8 *last_byte;
+	s64 offset;
+
+	if (!op->outline_rip) {
+		alloc_outline_branch_block(op);
+
+		/*
+		 * If we hit some allocation error, only use the first
+		 * destination and override the previous decision.
+		 */
+		if (unlikely(!op->outline_rip))
+			return -ENOMEM;
+	}
+
+	p_outline = kernel_ptr(op->outline_rip);
+
+	/* Offset to adjust the pointer before poking */
+	offset = (uintptr_t)p_outline - (uintptr_t)&outline_op;
+
+	for (i = 0, entry = &outline_op.entries[0]; i < OP_OUTLINED_TARGETS;
+	     i++, entry++) {
+		u32 target = op->targets[i + OP_INLINED_TARGETS];
+
+		if (target == 0)
+			break;
+
+		/* compare target to immediate */
+		entry->cmp.no_preempt_prefix = KERNEL_RESTARTABLE_PREFIX;
+		entry->cmp.opcode = CMP_IMM32_OPCODE;
+		entry->cmp.imm = target;
+		entry->cmp.rex_prefix = optpoline_cmp_rex_prefix(op->reg);
+		entry->cmp.modrm = optpoline_cmp_modrm(op->reg);
+
+		/*
+		 * During installation of the outline cachepoline, we set all
+		 * the entries as JMPs, and patch them into JNZ only once we
+		 * enable them.
+		 */
+		entry->jz.no_preempt_prefix = KERNEL_RESTARTABLE_PREFIX;
+		memcpy(entry->jz.opcode, JZ_REL32_OPCODE, sizeof(JZ_REL32_OPCODE));
+
+		rel_from = (uintptr_t)&entry->jz + sizeof(entry->jz) + offset;
+		rel_to = (uintptr_t)kernel_ptr(target);
+		entry->jz.rel = (s32)(rel_to - rel_from);
+	}
+
+	entry->fallback.no_preempt_prefix = KERNEL_RESTARTABLE_PREFIX;
+	entry->fallback.opcode = JMP_REL32_OPCODE;
+
+	rel_from = (uintptr_t)&entry->fallback + sizeof(entry->fallback) + offset;
+
+	/*
+	 * If we ran out of space, stop learning, since it would thrash the
+	 * learning hash-table.
+	 */
+	if (entry == &outline_op.entries[OP_OUTLINED_TARGETS])
+		rel_to = (uintptr_t)indirect_thunks[op->reg];
+	else
+		rel_to = (uintptr_t)save_optpoline_funcs[op->reg];
+
+	entry->fallback.rel = (s32)(rel_to - rel_from);
+
+	/* Fill the rest with int3 */
+	last_byte = (u8 *)&entry->fallback + sizeof(entry->fallback);
+	set_bytes = (uintptr_t)last_byte - (uintptr_t)&outline_op;
+	memset(last_byte, INT3_OPCODE, OP_OUTLINE_SIZE - set_bytes);
+
+	text_poke(p_outline, &outline_op, sizeof(outline_op));
+
+	return 0;
+}
+
 static void clear_optpoline_samples(void)
 {
 	int cpu, i;
@@ -264,6 +475,7 @@ static void remove_module_optpolines(struct module *mod)
 			continue;
 
 		remove_optpoline_from_list(op);
+		release_outline_branch_block(op);
 
 		rhashtable_remove_fast(&optpolines.rhead, &op->rhash,
 				       optpoline_rht_params);
@@ -358,31 +570,44 @@ static void analyze_optpoline_samples(struct optpoline *op,
 				      struct optpoline_sample *samples,
 				      unsigned int n_entries)
 {
-	int i, n_targets = 0;
+	unsigned int i, j, k, n_new_targets, n_prev_targets;
+
+	/* Count the number of previous targets */
+	for (n_prev_targets = 0; n_prev_targets < OP_N_TARGETS; n_prev_targets++) {
+		if (op->targets[n_prev_targets] == 0)
+			break;
+	}
 
 	/* Merge destinations with the same source and sum their samples. */
-	for (i = 0; i < n_entries; i++) {
-		if (n_targets == 0 ||
-		    samples[n_targets-1].tgt != samples[i].tgt) {
+	for (i = 0, n_new_targets = 0; i < n_entries; i++) {
+		if (n_new_targets == 0 ||
+		    samples[n_new_targets-1].tgt != samples[i].tgt) {
 			/* New target */
-			samples[n_targets++] = samples[i];
+			samples[n_new_targets++] = samples[i];
 			continue;
 		}
 
 		/* Known target, add samples */
-		samples[n_targets - 1].cnt += samples[i].cnt;
+		samples[n_new_targets - 1].cnt += samples[i].cnt;
 	}
 
 	/* Sort targets by frequency */
-	sort(samples, n_targets, sizeof(*samples),
+	sort(samples, n_new_targets, sizeof(*samples),
 	     optpoline_sample_cnt_cmp_func, NULL);
 
-	/* Mark as unstable if there is more than a single target */
-	if ((op->has_target && op->target != samples[0].tgt) || n_targets > 1)
-		op->unstable = true;
+	for (i = n_prev_targets, j = 0;
+	     i < OP_N_TARGETS && j < n_new_targets; j++) {
+		bool duplicate = false;
 
-	op->target = samples[0].tgt;
-	op->has_target = true;
+		/* Check if the new target is already considered */
+		for (k = 0; k < n_new_targets; k++)
+			duplicate |= (samples[j].tgt == op->targets[k]);
+
+		if (duplicate)
+			continue;
+
+		op->targets[i++] = samples[j].tgt;
+	}
 }
 
 /*
@@ -435,11 +660,11 @@ static inline bool is_learning_optpoline(struct optpoline *op)
 		return true;
 
 	/* Don't get updates if we know there are multiple targets */
-	if (op->unstable)
+	if (op->targets[OP_INLINED_TARGETS])
 		return false;
 
 	/* If we still don't know what the target, learning is needed */
-	return !op->has_target;
+	return op->targets[0] != 0;
 }
 
 static inline bool is_conditional_optpoline(struct optpoline *op)
@@ -449,7 +674,7 @@ static inline bool is_conditional_optpoline(struct optpoline *op)
 		return false;
 
 	/* If we don't know where to go, the condition is useless */
-	return op->has_target;
+	return op->targets[0];
 }
 
 #define CALL_OFFSET(op, offset, target)					\
@@ -470,13 +695,13 @@ static void make_common_optpoline(struct optpoline *op,
 }
 
 static void make_conditional_optpoline(struct optpoline *op,
-				       struct optpoline_code *code,
-				       const void *fallback_target)
+					struct optpoline_code *code,
+					const void *fallback_target)
 {
 	code->cmp.rex = optpoline_cmp_rex_prefix(op->reg);
 	code->cmp.opcode = CMP_IMM32_OPCODE;
 	code->cmp.modrm = optpoline_cmp_modrm(op->reg);
-	code->cmp.imm = op->target;
+	code->cmp.imm = op->targets[0];
 
 	code->jnz.rex = KERNEL_RESTARTABLE_PREFIX;
 	code->jnz.opcode = JNZ_REL8_OPCODE;
@@ -485,7 +710,7 @@ static void make_conditional_optpoline(struct optpoline *op,
 
 	code->call.rex = KERNEL_RESTARTABLE_PREFIX;
 	code->call.opcode = CALL_REL32_OPCODE;
-	code->call.rel = CALL_OFFSET(op, call, kernel_ptr(op->target));
+	code->call.rel = CALL_OFFSET(op, call, kernel_ptr(op->targets[0]));
 
 	make_common_optpoline(op, code, fallback_target);
 }
@@ -525,7 +750,7 @@ static void update_optpolines(void)
 {
 	struct list_head *list = &optpolines.list[OP_STATE_UPDATING].list;
 	const u8 patching_offset = offsetofend(struct optpoline_code,
-					       patching_call);
+						patching_call);
 	struct optpoline *op, *tmp;
 
 	mutex_lock(&text_mutex);
@@ -537,10 +762,6 @@ static void update_optpolines(void)
 
 		p_code = kernel_ptr(op->rip);
 
-		fallback_target = (is_learning_optpoline(op)) ?
-					save_optpoline_funcs[op->reg] :
-					indirect_thunks[op->reg];
-
 		end_of_optpoline = (const void *)(p_code + 1);
 
 		/*
@@ -564,6 +785,25 @@ static void update_optpolines(void)
 		/* Wait for everyone to sees the updated version */
 		synchronize_sched();
 
+		if (op->targets[OP_INLINED_TARGETS]) {
+			int r = make_outline_optpoline(op);
+
+			/*
+			 * If there is an error in creating the outline, fall
+			 * back to a single target.
+			 */
+			if (r)
+				op->targets[OP_INLINED_TARGETS] = 0;
+		}
+
+		/* Choose the appropriate target */
+		if (is_learning_optpoline(op))
+			fallback_target = save_optpoline_funcs[op->reg];
+		else if (op->outline_rip)
+			fallback_target = kernel_ptr(op->outline_rip);
+		else
+			fallback_target = indirect_thunks[op->reg];
+
 		if (is_conditional_optpoline(op))
 			make_conditional_optpoline(op, &code, fallback_target);
 		else
@@ -578,9 +818,10 @@ static void update_optpolines(void)
 			     &p_code->fallback);
 
 		if (is_conditional_optpoline(op)) {
-			state = op->unstable ? OP_STATE_UNSTABLE :
-					       OP_STATE_STABLE;
-		} else if (op->has_target)
+			state = op->targets[OP_INLINED_TARGETS] ?
+						OP_STATE_UNSTABLE :
+						OP_STATE_STABLE;
+		} else if (op->targets[0])
 			state = OP_STATE_RELEARN;
 		else
 			state = op->to_learn ? OP_STATE_LEARN : OP_STATE_NEW;
@@ -694,6 +935,19 @@ static void optpoline_work(struct work_struct *work)
 		schedule_delayed_work(&c_work, HZ * OP_READJUST_SECONDS);
 }
 
+static bool optpoline_has_targets_in_module(struct optpoline *op,
+					    const struct module *mod)
+{
+	unsigned int i;
+
+	for (i = 0; i < OP_N_TARGETS && op->targets[i]; i++) {
+		if (within_module((uintptr_t)kernel_ptr(op->targets[i]), mod))
+			return true;
+	}
+
+	return false;
+}
+
 static void reset_optpolines(enum optpoline_state state,
 			     const struct module *mod)
 {
@@ -701,13 +955,20 @@ static void reset_optpolines(enum optpoline_state state,
 	struct optpoline *op, *tmp;
 
 	list_for_each_entry_safe(op, tmp, list, node) {
-		if (mod && !within_module((uintptr_t)kernel_ptr(op->target), mod))
+		if (mod && !optpoline_has_targets_in_module(op, mod))
 			continue;
 
-		op->unstable = false;
-		op->has_target = false;
+		op->targets[0] = 0;
 		op->to_learn = false;
 		change_optpoline_state(op, OP_STATE_UPDATING);
+
+		/*
+		 * TODO: To be super safe, we should disable the optpolines
+		 * immediately instead of deferring the update. Otherwise, there
+		 * is a time-window in which the optpoline can speculatively
+		 * jump to the wrong target. Someone may use BPF to set his own
+		 * code on the call target, for example, and exploit it.
+		 */
 	}
 }
 
@@ -778,6 +1039,8 @@ static struct notifier_block optpoline_module_nb = {
  */
 asmlinkage __visible void optpoline_restart_rseq(struct pt_regs *regs)
 {
+	uintptr_t outline_start;
+	struct optpoline *op;
 	u8 i;
 	u8 offsets[3] = {
 		offsetof(struct optpoline_code, jnz),
@@ -786,12 +1049,13 @@ asmlinkage __visible void optpoline_restart_rseq(struct pt_regs *regs)
 	};
 
 	rcu_read_lock();
+
+	/* Check the inline optpoline */
 	for (i = 0; i < ARRAY_SIZE(offsets); i++) {
 		unsigned long rip = regs->ip + offsets[i];
-		struct optpoline *op;
 
 		op = rhashtable_lookup(&optpolines.rhead, &rip,
-				       optpoline_rht_params);
+					optpoline_rht_params);
 
 		if (op) {
 			/*
@@ -799,9 +1063,25 @@ asmlinkage __visible void optpoline_restart_rseq(struct pt_regs *regs)
 			 * the start of the optpoline.
 			 */
 			regs->ip -= offsets[i];
-			break;
+			goto out;
 		}
 	};
+
+	/* Check the outline optpoline. Use the alignment to ease the search */
+	outline_start = (regs->ip & PAGE_MASK) |
+			ALIGN_DOWN(offset_in_page(regs->ip), OP_OUTLINE_SIZE);
+
+	op = rhashtable_lookup(&optpolines.outline_rhead, &outline_start,
+			       outline_optpoline_rht_params);
+
+	/*
+	 * We already have performed the call and we don't want to mess with the
+	 * stack, so just move the rip to the indirect call thunk.
+	 */
+	if (op)
+		regs->ip = (uintptr_t)indirect_thunks[op->reg];
+
+out:
 	rcu_read_unlock();
 }
 #endif
@@ -900,6 +1180,10 @@ static void optpolines_destroy(void)
 		rhashtable_destroy(&optpolines.rhead);
 	optpolines.rhead_initialized = false;
 
+	if (optpolines.outline_rhead_initialized)
+		rhashtable_destroy(&optpolines.outline_rhead);
+	optpolines.outline_rhead_initialized = false;
+
 	kvfree(optpolines.kernel_optpolines);
 	optpolines.kernel_optpolines = NULL;
 
@@ -959,6 +1243,12 @@ static int __init optpolines_init(void)
 
 	optpolines.rhead_initialized = true;
 
+	r = rhashtable_init(&optpolines.outline_rhead, &outline_optpoline_rht_params);
+	if (r)
+		goto error;
+
+	optpolines.outline_rhead_initialized = true;
+
 	if (IS_ENABLED(CONFIG_DEBUG_FS)) {
 		r = create_optpoline_debugfs();
 		if (r)
-- 
2.17.1

