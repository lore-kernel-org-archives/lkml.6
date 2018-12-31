Return-Path: <SRS0=w+lf=PI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3869C43612
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 07:20:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B68D213A2
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 07:20:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727109AbeLaHUk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Dec 2018 02:20:40 -0500
Received: from ex13-edg-ou-002.vmware.com ([208.91.0.190]:25217 "EHLO
        EX13-EDG-OU-002.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726381AbeLaHUj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Dec 2018 02:20:39 -0500
Received: from sc9-mailhost3.vmware.com (10.113.161.73) by
 EX13-EDG-OU-002.vmware.com (10.113.208.156) with Microsoft SMTP Server id
 15.0.1156.6; Sun, 30 Dec 2018 23:20:33 -0800
Received: from sc2-haas01-esx0118.eng.vmware.com (sc2-haas01-esx0118.eng.vmware.com [10.172.44.118])
        by sc9-mailhost3.vmware.com (Postfix) with ESMTP id BF5C540BB0;
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
Subject: [RFC v2 5/6] x86: learning and patching indirect branch targets
Date:   Sun, 30 Dec 2018 23:21:11 -0800
Message-ID: <20181231072112.21051-6-namit@vmware.com>
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

During runtime, we collect the targets of indirect branch targets and
patch them in. Patching is done asynchronously, by modifying each of the
relpoline code-paths separately while diverting code execution to the
other path during patching. Preemption is disabled while the code runs,
and we wait for preemption to occur on each core to ensure no core is
executing the patched code.

To make use of relpolines, a worker goes over the experienced indirect
calls targets and sorts them according to frequency. The target that
was encountered most times is patched in.

Periodically, the indirect branches are set back into learning mode to
see whether the targets have changed. The current policy might be too
aggressive.

Signed-off-by: Nadav Amit <namit@vmware.com>
---
 arch/x86/kernel/nospec-branch.c | 992 ++++++++++++++++++++++++++++++++
 include/linux/cpuhotplug.h      |   1 +
 2 files changed, 993 insertions(+)

diff --git a/arch/x86/kernel/nospec-branch.c b/arch/x86/kernel/nospec-branch.c
index 5ae12681b23b..1503c312f715 100644
--- a/arch/x86/kernel/nospec-branch.c
+++ b/arch/x86/kernel/nospec-branch.c
@@ -4,8 +4,1000 @@
  */
 
 #include <linux/percpu.h>
+#include <linux/cpumask.h>
+#include <linux/sort.h>
+#include <linux/workqueue.h>
+#include <linux/mutex.h>
+#include <linux/memory.h>
+#include <linux/cpu.h>
+#include <linux/module.h>
+#include <linux/list.h>
+#include <linux/slab.h>
+#include <linux/cpumask.h>
+#include <linux/mm.h>
+#include <linux/debugfs.h>
+#include <linux/jump_label.h>
+#include <linux/rhashtable.h>
 #include <asm/nospec-branch.h>
+#include <asm/text-patching.h>
+#include <asm/asm-offsets.h>
+#include <asm/sections.h>
+#include <asm/mmu_context.h>
+
+#define REX_B			(0x41)
+#define JNZ_REL8_OPCODE		(0x75)
+#define JMP_REL8_OPCODE		(0xeb)
+#define CALL_REL32_OPCODE	(0xe8)
+#define CMP_IMM32_OPCODE	(0x81)
+#define NOP_OPCODE		(0x90)
+#define INT3_OPCODE		(0xcc)
+#define CALL_IND_INS		"\xff\xd0"
+
+#define OP_READJUST_SECONDS	(1)
+#define OP_REENABLE_IN_EPOCH	(4)
+#define OP_ENABLE_IN_EPOCH	(512)
+#define OP_SAMPLE_MSECS		(30000)
+
+enum code_state {
+	OPTPOLINE_SLOWPATH,
+	OPTPOLINE_FASTPATH,
+	OPTPOLINE_COND
+};
+
+/*
+ * Information for optpolines as it dynamically changes during execution.
+ */
+struct optpoline {
+	struct list_head node;
+	struct rhash_head rhash;
+	u32 rip;
+	u32 target;
+
+	/* The register that is used by the indirect branch */
+	u8 reg : 4;
+
+	/* The state of the optpoline, which indicates on which list it is */
+	u8 state : 3;
+
+	/* Whether we ever encountered more than one target */
+	u8 unstable : 1;
+
+	/* Whether there is a valid target */
+	u8 has_target : 1;
+
+	/*
+	 * Whether the optpoline needs to be set into training mode. This is a
+	 * transitory indication, which is cleared once it is set in learning
+	 * mode.
+	 */
+	u8 to_learn : 1;
+};
+
+struct optpoline_list {
+	/* @num: number of elements in the list */
+	unsigned int num;
+
+	struct list_head list;
+};
+
+static const struct rhashtable_params optpoline_rht_params = {
+	.automatic_shrinking = true,
+	.key_len = sizeof(u32),
+	.key_offset = offsetof(struct optpoline, rip),
+	.head_offset = offsetof(struct optpoline, rhash),
+};
 
 DEFINE_PER_CPU_ALIGNED(struct optpoline_sample[OPTPOLINE_SAMPLES_NUM],
 		       optpoline_samples);
 DEFINE_PER_CPU(u8, has_optpoline_samples);
+
+enum optpoline_state {
+	OP_STATE_NEW,			/* New, no known target */
+	OP_STATE_LEARN,			/* Learning for the first time */
+	OP_STATE_RELEARN,		/* Learning when a target is known */
+	OP_STATE_STABLE,		/* Calls with a single target */
+	OP_STATE_UNSTABLE,		/* Calls with multiple targets */
+	OP_STATE_UPDATING,		/* Undergoing an update */
+	OP_STATE_LAST = OP_STATE_UPDATING,
+	OP_STATE_W_TARGET_FIRST = OP_STATE_RELEARN,
+	OP_STATE_W_TARGET_LAST = OP_STATE_UNSTABLE
+};
+
+#define OP_STATE_NUM		(OP_STATE_LAST + 1)
+
+static const char *const optpoline_state_name[OP_STATE_NUM] = {
+	[OP_STATE_NEW] = "new",
+	[OP_STATE_LEARN] = "learning",
+	[OP_STATE_RELEARN] = "relearning",
+	[OP_STATE_STABLE] = "stable",
+	[OP_STATE_UNSTABLE] = "unstable",
+	[OP_STATE_UPDATING] = "updating",
+};
+
+struct optpolines {
+	struct mutex mutex;
+	struct optpoline_sample *samples_copy;
+
+	/*
+	 * Hashtable that holds all the optpolines, key'd by the instruction
+	 * pointer of the optpoline code block.
+	 */
+	struct rhashtable rhead;
+
+	/*
+	 * List of optpolines according to their states.
+	 */
+	struct optpoline_list list[OP_STATE_NUM];
+
+	/*
+	 * Indications whether optpolines are enabled. They might be disabled if
+	 * an error occurs.
+	 */
+	u8 enabled : 1;
+
+	/*
+	 * Unfortunately, the resizable hash-table cannot be destroyed if it
+	 * wasn't initialized, so we need to keep track of it.
+	 */
+	u8 rhead_initialized : 1;
+
+	 /* Number of unstable optpolines that are pending relearning. */
+	unsigned int pending_relearn;
+
+	/* Kernel (excluding modules) optpolines */
+	struct optpoline *kernel_optpolines;
+
+	struct dentry *dbg_entry;
+
+	ktime_t sample_time;
+};
+
+static struct optpolines optpolines;
+
+static inline void *kernel_ptr(u32 low_addr)
+{
+	return (void *)(low_addr | 0xffffffff00000000ul);
+}
+
+static inline u8 optpoline_cmp_rex_prefix(u8 reg)
+{
+	return 0x48 | ((reg & 8) >> 3);
+}
+
+static inline u8 optpoline_cmp_modrm(u8 reg)
+{
+	return 0xf8 | reg;
+}
+
+static void clear_optpoline_samples(void)
+{
+	int cpu, i;
+
+	for_each_online_cpu(cpu) {
+		/*
+		 * Do not update the target to avoid racing with the sampling.
+		 * Try to avoid having the wrong target, which might cause a
+		 * call with a single target to be considered having multiple
+		 * ones, leading to unnecessary learning cycles.
+		 */
+		for (i = 0; i < OPTPOLINE_SAMPLES_NUM; i++) {
+			per_cpu(optpoline_samples, cpu)[i].src = 0;
+			per_cpu(optpoline_samples, cpu)[i].cnt = 0;
+		}
+		per_cpu(has_optpoline_samples, cpu) = false;
+	}
+}
+
+static void add_optpoline_to_list(struct optpoline *op,
+					 enum optpoline_state rp_state)
+{
+	optpolines.list[rp_state].num++;
+
+	/*
+	 * Add to the tail, so when putting back into the list, it will be
+	 * considered for learning last.
+	 */
+	list_add_tail(&op->node, &optpolines.list[rp_state].list);
+	op->state = rp_state;
+}
+
+static void remove_optpoline_from_list(struct optpoline *op)
+{
+	optpolines.list[op->state].num--;
+	list_del_init(&op->node);
+}
+
+static inline void change_optpoline_state(struct optpoline *op,
+					  enum optpoline_state rp_state)
+{
+	remove_optpoline_from_list(op);
+	add_optpoline_to_list(op, rp_state);
+}
+
+static int add_optpolines(const struct optpoline_entry *entries,
+			  unsigned int n_entries, struct module *mod)
+{
+	struct optpoline *op;
+	int i, r = 0;
+
+	op = kvmalloc_array(n_entries, sizeof(*op), GFP_KERNEL|__GFP_ZERO);
+	if (!op)
+		return -ENOMEM;
+
+	if (mod)
+		mod->optpolines = op;
+	else
+		optpolines.kernel_optpolines = op;
+
+	for (i = 0; i < n_entries; i++) {
+		enum optpoline_state state = OP_STATE_NEW;
+		uintptr_t rip = (uintptr_t)entries[i].rip;
+
+		/* Knowningly, we take only 32-bits to save space */
+		op->rip = (u32)rip;
+		op->reg = entries[i].reg;
+
+		r = rhashtable_insert_fast(&optpolines.rhead, &op->rhash,
+					   optpoline_rht_params);
+		if (r < 0)
+			break;
+
+		add_optpoline_to_list(op, state);
+		op++;
+	}
+
+	if (r < 0)
+		WARN_ONCE(1, "Error loading optpolines\n");
+
+	return r;
+}
+
+static void remove_module_optpolines(struct module *mod)
+{
+	unsigned int i;
+
+	for (i = 0; i < mod->num_optpolines; i++) {
+		struct optpoline *op = &mod->optpolines[i];
+
+		/* If init somehow failed, we may see uninitialized entries */
+		if (op->rip == 0)
+			continue;
+
+		remove_optpoline_from_list(op);
+
+		rhashtable_remove_fast(&optpolines.rhead, &op->rhash,
+				       optpoline_rht_params);
+	}
+
+	kvfree(mod->optpolines);
+	mod->optpolines = NULL;
+}
+
+/*
+ * optpoline_sample_src_cmp_func() - sort by source and target
+ */
+static int optpoline_sample_src_cmp_func(const void *l, const void *r)
+{
+	const struct optpoline_sample *s1 = l;
+	const struct optpoline_sample *s2 = r;
+
+	if (s1->src != s2->src)
+		return s1->src - s2->src;
+	return s1->tgt - s2->tgt;
+}
+
+/*
+ * optpoline_sample_cnt_cmp_func() - sort by the number of samples
+ */
+static int optpoline_sample_cnt_cmp_func(const void *l, const void *r)
+{
+	const struct optpoline_sample *s1 = l;
+	const struct optpoline_sample *s2 = r;
+
+	return s2->cnt - s1->cnt;
+}
+
+/*
+ * copy_optpoline_samples() - copy the samples to the local copy
+ *
+ * As we need to process the samples without them being written concurrently,
+ * and since anyhow they might reside on remote NUMA nodes, copy them first
+ * to the local buffer. During the copy, the source ip is adjusted, and samples
+ * are sorted.
+ */
+static int copy_optpoline_samples(void)
+{
+	struct optpoline_sample *p_copy = optpolines.samples_copy;
+	int cpu, i, n_entries;
+
+	for_each_online_cpu(cpu) {
+		struct optpoline_sample *orig;
+
+		if (!per_cpu(has_optpoline_samples, cpu))
+			continue;
+
+		orig = per_cpu(optpoline_samples, cpu);
+
+		for (i = 0; i < OPTPOLINE_SAMPLES_NUM; i++, orig++) {
+			p_copy->src = orig->src;
+
+			/* Do some sanity checks while we are at it */
+			if (p_copy->src == 0)
+				continue;
+
+			if (init_kernel_text((uintptr_t)kernel_ptr(p_copy->src)))
+				continue;
+
+			p_copy->src -= offsetofend(struct optpoline_code,
+						   fallback);
+
+			/*
+			 * Although we can live with potentially wrong info, as
+			 * it only affects performance, wrong destination might
+			 * be somehow (completely theoretically) be exploited
+			 * through speculative execution. Avoid torn reads. The
+			 * read/write are naturally aligned so we are safe.
+			 */
+			p_copy->tgt = READ_ONCE(orig->tgt);
+
+			p_copy->cnt = orig->cnt;
+			p_copy++;
+		}
+	}
+
+	n_entries = p_copy - optpolines.samples_copy;
+
+	/* Sort by the call source (first) and destination (second) */
+	sort(optpolines.samples_copy, n_entries, sizeof(*optpolines.samples_copy),
+	     optpoline_sample_src_cmp_func, NULL);
+
+	return n_entries;
+}
+
+static void analyze_optpoline_samples(struct optpoline *op,
+				      struct optpoline_sample *samples,
+				      unsigned int n_entries)
+{
+	int i, n_targets = 0;
+
+	/* Merge destinations with the same source and sum their samples. */
+	for (i = 0; i < n_entries; i++) {
+		if (n_targets == 0 ||
+		    samples[n_targets-1].tgt != samples[i].tgt) {
+			/* New target */
+			samples[n_targets++] = samples[i];
+			continue;
+		}
+
+		/* Known target, add samples */
+		samples[n_targets - 1].cnt += samples[i].cnt;
+	}
+
+	/* Sort targets by frequency */
+	sort(samples, n_targets, sizeof(*samples),
+	     optpoline_sample_cnt_cmp_func, NULL);
+
+	/* Mark as unstable if there is more than a single target */
+	if ((op->has_target && op->target != samples[0].tgt) || n_targets > 1)
+		op->unstable = true;
+
+	op->target = samples[0].tgt;
+	op->has_target = true;
+}
+
+/*
+ * Returns the number of decisions.
+ */
+static void process_optpoline_samples(void)
+{
+	unsigned int end, start;
+	int n_copied;
+
+	/*
+	 * First we copy the optpolines for a certain hash index to prevent it
+	 * from messing up with our data. While we can cope with races that
+	 * modify the destination, we need the source rip to be consistent.
+	 */
+	n_copied = copy_optpoline_samples();
+
+	for (start = 0; start < n_copied; start = end) {
+		struct optpoline_code *code;
+		struct optpoline *op;
+
+		code = kernel_ptr(optpolines.samples_copy[start].src);
+		op = rhashtable_lookup_fast(&optpolines.rhead, &code,
+					    optpoline_rht_params);
+
+		/* Races might cause the source to be wrong. Live with it. */
+		if (!op) {
+			end = start + 1;
+			continue;
+		}
+
+		/* Find all the relevant entries */
+		for (end = start + 1; end < n_copied; end++) {
+			if (optpolines.samples_copy[start].src !=
+			    optpolines.samples_copy[end].src)
+				break;
+		}
+
+		analyze_optpoline_samples(op, &optpolines.samples_copy[start],
+					  end - start);
+
+		change_optpoline_state(op, OP_STATE_UPDATING);
+	}
+}
+
+static inline bool is_learning_optpoline(struct optpoline *op)
+{
+	/* Was explicitly required to learn */
+	if (op->to_learn)
+		return true;
+
+	/* Don't get updates if we know there are multiple targets */
+	if (op->unstable)
+		return false;
+
+	/* If we still don't know what the target, learning is needed */
+	return !op->has_target;
+}
+
+static inline bool is_conditional_optpoline(struct optpoline *op)
+{
+	/* During learning we disable the condition */
+	if (op->to_learn)
+		return false;
+
+	/* If we don't know where to go, the condition is useless */
+	return op->has_target;
+}
+
+#define CALL_OFFSET(op, offset, target)					\
+	(s32)((uintptr_t)target - (uintptr_t)kernel_ptr(op->rip) -	\
+	      offsetofend(struct optpoline_code, offset))
+
+static void make_common_optpoline(struct optpoline *op,
+				  struct optpoline_code *code,
+				  const void *fallback_target)
+{
+	code->jmp_done.opcode = JMP_REL8_OPCODE;
+	code->jmp_done.rel = offsetofend(struct optpoline_code, fallback) -
+			     offsetofend(struct optpoline_code, jmp_done);
+
+	code->fallback.rex = KERNEL_RESTARTABLE_PREFIX;
+	code->fallback.opcode = CALL_REL32_OPCODE;
+	code->fallback.rel = CALL_OFFSET(op, fallback, fallback_target);
+}
+
+static void make_conditional_optpoline(struct optpoline *op,
+				       struct optpoline_code *code,
+				       const void *fallback_target)
+{
+	code->cmp.rex = optpoline_cmp_rex_prefix(op->reg);
+	code->cmp.opcode = CMP_IMM32_OPCODE;
+	code->cmp.modrm = optpoline_cmp_modrm(op->reg);
+	code->cmp.imm = op->target;
+
+	code->jnz.rex = KERNEL_RESTARTABLE_PREFIX;
+	code->jnz.opcode = JNZ_REL8_OPCODE;
+	code->jnz.rel = offsetof(struct optpoline_code, fallback) -
+			offsetofend(struct optpoline_code, jnz);
+
+	code->call.rex = KERNEL_RESTARTABLE_PREFIX;
+	code->call.opcode = CALL_REL32_OPCODE;
+	code->call.rel = CALL_OFFSET(op, call, kernel_ptr(op->target));
+
+	make_common_optpoline(op, code, fallback_target);
+}
+
+static void make_unconditional_optpoline(struct optpoline *op,
+					 struct optpoline_code *code,
+					 const void *fallback_target)
+{
+	/*
+	 * Avoid having some partial code that may complicate debugging, and try
+	 * to catch bugs.
+	 */
+	memset(code, INT3_OPCODE, offsetofend(struct optpoline_code, call));
+
+	code->skip.opcode = JMP_REL8_OPCODE;
+	code->skip.rel = offsetof(struct optpoline_code, fallback) -
+			 offsetofend(struct optpoline_code, skip);
+
+	code->fallback.rex = KERNEL_RESTARTABLE_PREFIX;
+	code->fallback.opcode = CALL_REL32_OPCODE;
+	code->fallback.rel = CALL_OFFSET(op, fallback, fallback_target);
+
+	make_common_optpoline(op, code, fallback_target);
+}
+
+/**
+ * update_optpolines() - Patch the optpoline code
+ *
+ * @list: List of optpolines to patch
+ * @learn: If true, the optpolines will be set in learning mode.
+ *
+ * Ensure all cores no longer run the optpolines we play with. Since preemption
+ * is disabled between the optpoline compare and call, this would mean they are
+ * all safe.
+ */
+static void update_optpolines(void)
+{
+	struct list_head *list = &optpolines.list[OP_STATE_UPDATING].list;
+	const u8 patching_offset = offsetofend(struct optpoline_code,
+					       patching_call);
+	struct optpoline *op, *tmp;
+
+	mutex_lock(&text_mutex);
+
+	list_for_each_entry_safe(op, tmp, list, node) {
+		const void *fallback_target, *end_of_optpoline;
+		struct optpoline_code code, *p_code;
+		enum optpoline_state state;
+
+		p_code = kernel_ptr(op->rip);
+
+		fallback_target = (is_learning_optpoline(op)) ?
+					save_optpoline_funcs[op->reg] :
+					indirect_thunks[op->reg];
+
+		end_of_optpoline = (const void *)(p_code + 1);
+
+		/*
+		 * Read the original code, since we are lazy to intialize all of
+		 * it.
+		 */
+		memcpy(&code, p_code, sizeof(code));
+
+		/* Skip the code, calling the retpoline during patching */
+		BUILD_BUG_ON(sizeof(code.cmp) < sizeof(code.patching_call));
+		memset(&code.patching_call, INT3_OPCODE, sizeof(code.cmp));
+		code.patching_call.opcode = CALL_REL32_OPCODE;
+		code.patching_call.rel = CALL_OFFSET(op, patching_call,
+						     skip_optpoline_funcs[op->reg]);
+
+		BUILD_BUG_ON(sizeof_field(struct optpoline_code, patching_call) != 5);
+
+		text_poke_bp(p_code, &code, sizeof(code.patching_call),
+			     &p_code->fallback);
+
+		/* Wait for everyone to sees the updated version */
+		synchronize_sched();
+
+		if (is_conditional_optpoline(op))
+			make_conditional_optpoline(op, &code, fallback_target);
+		else
+			make_unconditional_optpoline(op, &code, fallback_target);
+
+		/* Patch everything but the first instruction */
+		text_poke((u8 *)p_code + patching_offset,
+			  (const u8 *)&code + patching_offset,
+			  sizeof(code) - patching_offset);
+
+		text_poke_bp(p_code, &code, sizeof(code.patching_call),
+			     &p_code->fallback);
+
+		if (is_conditional_optpoline(op)) {
+			state = op->unstable ? OP_STATE_UNSTABLE :
+					       OP_STATE_STABLE;
+		} else if (op->has_target)
+			state = OP_STATE_RELEARN;
+		else
+			state = op->to_learn ? OP_STATE_LEARN : OP_STATE_NEW;
+
+		op->to_learn = false;
+		change_optpoline_state(op, state);
+	}
+	mutex_unlock(&text_mutex);
+}
+
+static void optpoline_work(struct work_struct *work);
+
+static DECLARE_DELAYED_WORK(c_work, optpoline_work);
+
+static unsigned int set_optpolines_to_learn(enum optpoline_state state,
+					    unsigned int n)
+{
+	struct optpoline *op, *tmp;
+	unsigned int i = 0;
+
+	list_for_each_entry_safe(op, tmp, &optpolines.list[state].list, node) {
+		if (i == n)
+			break;
+
+		op->to_learn = true;
+		change_optpoline_state(op, OP_STATE_UPDATING);
+		i++;
+	}
+	return i;
+}
+
+/**
+ * relearn_pending() - Relearn optpolines which are waiting to be relearned.
+ *
+ * First relearn the targets of new indirect branches (after boot, or module
+ * load). Second, take those that have more than a single target and relearn
+ * them. Pace the learning to prevent too many collisions in our sampling
+ * data-structures.
+ */
+static int relearn_pending(void)
+{
+	unsigned int n;
+
+	n = set_optpolines_to_learn(OP_STATE_NEW, OP_ENABLE_IN_EPOCH);
+
+	if (n == 0) {
+		n = set_optpolines_to_learn(OP_STATE_UNSTABLE,
+			    min_t(unsigned int, optpolines.pending_relearn,
+						OP_REENABLE_IN_EPOCH));
+		optpolines.pending_relearn -= n;
+	}
+
+	if (n > 0)
+		update_optpolines();
+	return n;
+}
+
+static void optpolines_autolearn(void)
+{
+	if (relearn_pending() > 0) {
+		optpolines.sample_time = ktime_get();
+		return;
+	}
+
+	if (ktime_ms_delta(ktime_get(), optpolines.sample_time) < OP_SAMPLE_MSECS)
+		return;
+
+	/* Start another training period */
+	optpolines.pending_relearn = optpolines.list[OP_STATE_UNSTABLE].num;
+}
+
+static void optpoline_work(struct work_struct *work)
+{
+	struct optpoline *op, *tmp;
+	bool enabled;
+
+	mutex_lock(&optpolines.mutex);
+	cpus_read_lock();
+
+	enabled = optpolines.enabled;
+
+	/*
+	 * If something went wrong and the optpolines were disabled, we need to
+	 * bail out.
+	 */
+	if (unlikely(!enabled))
+		goto out;
+
+	/* Pickup the new samples */
+	process_optpoline_samples();
+
+	/*
+	 * For all those indirect branches that had a target before, but got no
+	 * samples, just set the target that we had before.
+	 */
+	list_for_each_entry_safe(op, tmp,
+				 &optpolines.list[OP_STATE_RELEARN].list, node)
+		change_optpoline_state(op, OP_STATE_UPDATING);
+
+	if (!list_empty(&optpolines.list[OP_STATE_UPDATING].list)) {
+		update_optpolines();
+		clear_optpoline_samples();
+	} else
+		optpolines_autolearn();
+
+out:
+	cpus_read_unlock();
+	mutex_unlock(&optpolines.mutex);
+
+	if (likely(enabled))
+		schedule_delayed_work(&c_work, HZ * OP_READJUST_SECONDS);
+}
+
+static void reset_optpolines(enum optpoline_state state,
+			     const struct module *mod)
+{
+	struct list_head *list = &optpolines.list[state].list;
+	struct optpoline *op, *tmp;
+
+	list_for_each_entry_safe(op, tmp, list, node) {
+		if (mod && !within_module((uintptr_t)kernel_ptr(op->target), mod))
+			continue;
+
+		op->unstable = false;
+		op->has_target = false;
+		op->to_learn = false;
+		change_optpoline_state(op, OP_STATE_UPDATING);
+	}
+}
+
+#ifdef CONFIG_MODULES
+/*
+ * reset_optpoline_module_targets() - reset optpolines with module targets
+ *
+ * @mod:	the module which optpolines that point to are removed
+ *
+ * Remove optpolines whose target is in the module as a safety precaution
+ * against speculative execution that will jump to the target.
+ */
+static void reset_optpoline_module_targets(const struct module *mod)
+{
+	enum optpoline_state state;
+
+	for (state = OP_STATE_W_TARGET_FIRST; state <= OP_STATE_W_TARGET_LAST; state++)
+		reset_optpolines(state, mod);
+
+	update_optpolines();
+}
+
+static int optpoline_module_notify(struct notifier_block *self,
+				   unsigned long val, void *data)
+{
+	struct module *mod = data;
+
+	mutex_lock(&optpolines.mutex);
+
+	switch (val) {
+	case MODULE_STATE_COMING:
+		add_optpolines(mod->optpoline_entries, mod->num_optpolines, mod);
+		break;
+	case MODULE_STATE_GOING:
+		/* Remove those which jump from the module source */
+		remove_module_optpolines(mod);
+
+		/* Remove those that point to the module */
+		reset_optpoline_module_targets(mod);
+
+		/* Clear the samples since they may point to the module */
+		clear_optpoline_samples();
+	}
+
+	mutex_unlock(&optpolines.mutex);
+	return 0;
+}
+#else
+static int optpoline_module_notify(struct notifier_block *self,
+				   unsigned long val, void *data)
+{
+}
+#endif
+
+static struct notifier_block optpoline_module_nb = {
+	.notifier_call = optpoline_module_notify,
+	.priority = 1,
+};
+
+#ifdef CONFIG_PREEMPT
+/**
+ * optpoline_rseq() - restart a retpoline due to preemption
+ *
+ * @regs: pointer to the registers of the task.
+ *
+ * This function should be called only when the kernel is preempted and when the
+ * KERNEL_RSEQ_PREFIX is at the beginning of the preempted instruction.
+ */
+asmlinkage __visible void optpoline_restart_rseq(struct pt_regs *regs)
+{
+	u8 i;
+	u8 offsets[3] = {
+		offsetof(struct optpoline_code, jnz),
+		offsetof(struct optpoline_code, call),
+		offsetof(struct optpoline_code, fallback)
+	};
+
+	rcu_read_lock();
+	for (i = 0; i < ARRAY_SIZE(offsets); i++) {
+		unsigned long rip = regs->ip + offsets[i];
+		struct optpoline *op;
+
+		op = rhashtable_lookup(&optpolines.rhead, &rip,
+				       optpoline_rht_params);
+
+		if (op) {
+			/*
+			 * We found an appropriate entry, move the pointer to
+			 * the start of the optpoline.
+			 */
+			regs->ip -= offsets[i];
+			break;
+		}
+	};
+	rcu_read_unlock();
+}
+#endif
+
+static int optpoline_debug_show(struct seq_file *f, void *offset)
+{
+	int i;
+
+	for (i = 0; i < OP_STATE_NUM; i++)
+		seq_printf(f, "%s %u\n", optpoline_state_name[i],
+			   optpolines.list[i].num);
+
+	return 0;
+}
+
+static int optpoline_debug_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, optpoline_debug_show, inode->i_private);
+}
+
+static ssize_t optpoline_debug_write(struct file *file, const char __user *ubuf,
+				     size_t count, loff_t *ppos)
+{
+	u8 kbuf[40] = {0};
+	ssize_t ret = 0;
+	size_t len;
+
+	len = min(count, sizeof(kbuf) - 1);
+
+	if (len == 0)
+		return -EINVAL;
+
+	if (copy_from_user(kbuf, ubuf, len))
+		return -EFAULT;
+
+	kbuf[len] = '\0';
+	if (kbuf[len - 1] == '\n')
+		kbuf[len - 1] = '\0';
+
+	mutex_lock(&optpolines.mutex);
+
+	if (strcmp(kbuf, "relearn") == 0) {
+		/* Reinitiate immediate relearning of all the unstable ones */
+
+		optpolines.pending_relearn = optpolines.list[OP_STATE_UNSTABLE].num;
+	} else if (strcmp(kbuf, "reset") == 0) {
+		/* Forget everything we know */
+
+		reset_optpolines(OP_STATE_UNSTABLE, NULL);
+		reset_optpolines(OP_STATE_RELEARN, NULL);
+		optpolines.pending_relearn = 0;
+		update_optpolines();
+	} else
+		ret = -EINVAL;
+
+	mutex_unlock(&optpolines.mutex);
+
+	return count;
+}
+
+static const struct file_operations optpoline_debug_fops = {
+	.owner		= THIS_MODULE,
+	.open		= optpoline_debug_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+	.write		= optpoline_debug_write,
+};
+
+static int __init create_optpoline_debugfs(void)
+{
+	int r;
+
+	if (!IS_ENABLED(CONFIG_DEBUG_FS))
+		return 0;
+
+	optpolines.dbg_entry = debugfs_create_file("optpolines", 0600, NULL,
+						  NULL, &optpoline_debug_fops);
+	if (IS_ERR(optpolines.dbg_entry)) {
+		r = PTR_ERR(optpolines.dbg_entry);
+		pr_err("failed to create debugfs entry, error: %d", r);
+		return r;
+	}
+
+	return 0;
+}
+
+static void optpolines_destroy(void)
+{
+	kvfree(optpolines.samples_copy);
+	optpolines.samples_copy = NULL;
+
+	unregister_module_notifier(&optpoline_module_nb);
+
+	if (optpolines.rhead_initialized)
+		rhashtable_destroy(&optpolines.rhead);
+	optpolines.rhead_initialized = false;
+
+	kvfree(optpolines.kernel_optpolines);
+	optpolines.kernel_optpolines = NULL;
+
+	optpolines.enabled = false;
+}
+
+static int optpoline_realloc_samples_copy(unsigned int n_cpus)
+{
+	kvfree(optpolines.samples_copy);
+
+	optpolines.samples_copy = kvmalloc_array(n_cpus * OPTPOLINE_SAMPLES_NUM,
+					sizeof(*optpolines.samples_copy),
+					GFP_KERNEL);
+
+	if (optpolines.samples_copy == NULL) {
+		/*
+		 * Indicate for the worker to stop all work on the next
+		 * iteration. We will not break anything, but we must disable
+		 * all optpolines.
+		 */
+		WARN(1, "error allocating optpoline memory");
+		optpolines_destroy();
+	}
+
+	return 0;
+}
+
+static int optpoline_cpu_online(unsigned int cpu, struct hlist_node *node)
+{
+	unsigned int n_cpus = num_online_cpus() + !cpu_online(cpu);
+
+	if (!optpolines.enabled)
+		return 0;
+
+	return optpoline_realloc_samples_copy(n_cpus);
+}
+
+static int optpoline_cpu_prep_down(unsigned int cpu, struct hlist_node *node)
+{
+	unsigned int n_cpus = num_online_cpus() - !!cpu_online(cpu);
+
+	if (!optpolines.enabled)
+		return 0;
+
+	return optpoline_realloc_samples_copy(n_cpus);
+}
+
+static int __init optpolines_init(void)
+{
+	int i, r;
+
+	mutex_init(&optpolines.mutex);
+
+	r = rhashtable_init(&optpolines.rhead, &optpoline_rht_params);
+	if (r)
+		goto error;
+
+	optpolines.rhead_initialized = true;
+
+	if (IS_ENABLED(CONFIG_DEBUG_FS)) {
+		r = create_optpoline_debugfs();
+		if (r)
+			goto error;
+	}
+
+	optpolines.sample_time = ktime_get();
+
+	r = optpoline_realloc_samples_copy(num_online_cpus());
+	if (r)
+		goto error;
+
+	r = register_module_notifier(&optpoline_module_nb);
+	if (r) {
+		WARN(1, "error initializing optpolines");
+		goto error;
+	}
+
+	for (i = 0; i < OP_STATE_NUM; i++) {
+		INIT_LIST_HEAD(&optpolines.list[i].list);
+		optpolines.list[i].num = 0;
+	}
+
+	/*
+	 * Ignoring errors here, only part of the optpolines would be enabled.
+	 */
+	add_optpolines(__optpolines, __optpolines_end - __optpolines, NULL);
+
+	r = cpuhp_setup_state_multi(CPUHP_AP_X86_OPTPOLINE_CHANGE,
+				    "optpoline:online", optpoline_cpu_online,
+				    optpoline_cpu_prep_down);
+	if (r)
+		goto error;
+
+	optpolines.enabled = true;
+	schedule_delayed_work(&c_work, HZ * OP_READJUST_SECONDS * 10);
+	return 0;
+error:
+	optpolines_destroy();
+	return r;
+}
+late_initcall(optpolines_init);
diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
index e0cd2baa8380..4caf4d5941db 100644
--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -167,6 +167,7 @@ enum cpuhp_state {
 	CPUHP_AP_PERF_POWERPC_NEST_IMC_ONLINE,
 	CPUHP_AP_PERF_POWERPC_CORE_IMC_ONLINE,
 	CPUHP_AP_PERF_POWERPC_THREAD_IMC_ONLINE,
+	CPUHP_AP_X86_OPTPOLINE_CHANGE,
 	CPUHP_AP_WATCHDOG_ONLINE,
 	CPUHP_AP_WORKQUEUE_ONLINE,
 	CPUHP_AP_RCUTREE_ONLINE,
-- 
2.17.1

