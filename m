Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0957DECDE42
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 00:56:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BEA62145D
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 00:56:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BEA62145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vmware.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727459AbeJRIye (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 04:54:34 -0400
Received: from ex13-edg-ou-001.vmware.com ([208.91.0.189]:46860 "EHLO
        EX13-EDG-OU-001.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726943AbeJRIyd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 04:54:33 -0400
Received: from sc9-mailhost3.vmware.com (10.113.161.73) by
 EX13-EDG-OU-001.vmware.com (10.113.208.155) with Microsoft SMTP Server id
 15.0.1156.6; Wed, 17 Oct 2018 17:55:42 -0700
Received: from sc2-haas01-esx0118.eng.vmware.com (sc2-haas01-esx0118.eng.vmware.com [10.172.44.118])
        by sc9-mailhost3.vmware.com (Postfix) with ESMTP id 5A7FF40926;
        Wed, 17 Oct 2018 17:56:09 -0700 (PDT)
From:   Nadav Amit <namit@vmware.com>
To:     Ingo Molnar <mingo@redhat.com>
CC:     Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "H . Peter Anvin " <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        <linux-kernel@vger.kernel.org>, Nadav Amit <nadav.amit@gmail.com>,
        <x86@kernel.org>, Borislav Petkov <bp@alien8.de>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Nadav Amit <namit@vmware.com>
Subject: [RFC PATCH 4/5] x86: learning and patching indirect branch targets
Date:   Wed, 17 Oct 2018 17:54:19 -0700
Message-ID: <20181018005420.82993-5-namit@vmware.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181018005420.82993-1-namit@vmware.com>
References: <20181018005420.82993-1-namit@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (EX13-EDG-OU-001.vmware.com: namit@vmware.com does not
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
 arch/x86/include/asm/nospec-branch.h |   3 +
 arch/x86/kernel/nospec-branch.c      | 894 +++++++++++++++++++++++++++
 2 files changed, 897 insertions(+)

diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
index a4496c141143..360caad7a890 100644
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -406,6 +406,9 @@ struct relpoline_entry {
 	u8 reg;
 } __packed;
 
+extern const void *indirect_thunks[16];
+extern const void *save_relpoline_funcs[16];
+
 /* The Intel SPEC CTRL MSR base value cache */
 extern u64 x86_spec_ctrl_base;
 
diff --git a/arch/x86/kernel/nospec-branch.c b/arch/x86/kernel/nospec-branch.c
index b3027761442b..2a2cfc2db9d8 100644
--- a/arch/x86/kernel/nospec-branch.c
+++ b/arch/x86/kernel/nospec-branch.c
@@ -1,5 +1,899 @@
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
+#define CMP_REG_IMM32_OPCODE	(0x81)
+#define JNZ_REL8_OPCODE		(0x75)
+#define JMP_REL8_OPCODE		(0xeb)
+#define CALL_REL32_OPCODE	(0xe8)
+#define CALL_IND_INS		"\xff\xd0"
+
+#ifdef CONFIG_PREEMPT
+#define NO_PREEMPT_PREFIX	u8 no_preempt_prefix
+#else
+#define NO_PREEMPT_PREFIX
+#endif
+
+#define RP_READJUST_SECONDS	(1)
+#define RP_REENABLE_IN_EPOCH	(4)
+#define RP_TARGETS		(1)
+#define RP_MAX_DECISIONS	(64)
+#define RP_SAMPLE_MSECS		(60000)
+
+enum code_state {
+	RELPOLINE_SLOWPATH,
+	RELPOLINE_FASTPATH,
+	RELPOLINE_COND
+};
+
+/*
+ * Reflects the structure of the assembly code. We exclude the compare
+ * opcode which depends on the register.
+ */
+struct relpoline_code {
+	u32 cmp_imm;
+	struct {
+		NO_PREEMPT_PREFIX;
+		u8 opcode;
+		int8_t rel;
+	} __packed jnz;
+	struct {
+		NO_PREEMPT_PREFIX;
+		u8 opcode;
+		int32_t rel;
+	} __packed call;
+	struct {
+		u8 opcode;
+		u8 rel;
+	} __packed jmp_done;
+	struct {
+		NO_PREEMPT_PREFIX;
+		u8 opcode;
+		int32_t rel;
+	} __packed fallback;
+} __packed;
+
+/*
+ * Information for relpolines as it dynamically changes during execution.
+ */
+struct relpoline {
+	struct relpoline_code *code;
+	struct list_head node;
+	struct rhash_head rhash;
+	/*
+	 * The following information can be obtained by disassembly, but saving
+	 * it here does not consume too much memory and makes the code simpler.
+	 */
+	u8 reg : 4;
+	u8 state : 4; /* enum relpoline_state */
+	u8 n_dsts : 7;
+	u8 overflow : 1;
+};
+
+struct relpoline_list {
+	unsigned int num;
+	struct list_head list;
+};
+
+static struct kmem_cache *relpoline_info_cache;
+
+static const struct rhashtable_params relpoline_rht_params = {
+	.automatic_shrinking = true,
+	.key_len = sizeof(uintptr_t),
+	.key_offset = offsetof(struct relpoline, code),
+	.head_offset = offsetof(struct relpoline, rhash),
+};
+
+struct relpoline_transition {
+	u32 dsts[RP_TARGETS];
+	struct relpoline *rp;
+	u8 n_dsts: 7;
+	u8 overflow: 1;
+	u8 prev_n_dsts : 7;
+	u8 reset : 1;
+};
 
 DEFINE_PER_CPU_ALIGNED(struct relpoline_sample[RELPOLINE_SAMPLES_NUM],
 		       relpoline_samples);
+
+enum relpoline_state {
+	RP_STATE_LEARNING,
+	RP_STATE_STABLE,
+	RP_STATE_UNSTABLE,
+	RP_STATE_LAST = RP_STATE_UNSTABLE
+};
+
+#define RP_STATE_NUM		(RP_STATE_LAST + 1)
+
+static struct relpoline_list relpoline_list[RP_STATE_NUM];
+
+static struct rhashtable relpolines_rhead;
+
+/*
+ * List of relpolines that are not learning. We do not want misbehaving
+ * relpolines to wreck havoc and prevent us from figuring out the target of
+ * relpolines that have a stable target.
+ */
+static struct mutex relpoline_mutex;
+static struct relpoline_sample *relpoline_samples_copy;
+static struct relpoline_transition cp_changes[RP_MAX_DECISIONS];
+
+struct relpolines_stat {
+	u32 n_dsts[RP_TARGETS];
+	u32 n_overflow;
+};
+
+#ifdef CONFIG_DEBUG_FS
+	/* debugfs file exporting statistics */
+struct dentry *relpoline_dbg_entry;
+#endif
+
+static struct relpolines_stat	*relpolines_stat;
+static ktime_t			relpolines_sample_time;
+static unsigned int relpolines_resampling_count;
+
+static inline void *kernel_ptr(u32 low_addr)
+{
+	return (void *)(low_addr | 0xffffffff00000000ul);
+}
+
+static inline
+int32_t inline_fastpath_rel(struct relpoline_code *code,
+			    const void *dst)
+{
+	return (unsigned long)dst - (unsigned long)code -
+		offsetofend(struct relpoline_code, call);
+}
+
+static inline
+void set_inline_fastpath_rel(struct relpoline_code *code, const void *dst)
+{
+	int32_t rel = inline_fastpath_rel(code, dst);
+
+	text_poke(&code->call.rel, &rel, sizeof(rel));
+}
+
+static inline
+int32_t slowpath_rel(const struct relpoline_code *code, const void *dst)
+{
+	return (unsigned long)dst - (unsigned long)code -
+		offsetofend(struct relpoline_code, fallback);
+}
+
+static void set_slowpath_rel(struct relpoline_code *code, const void *dst)
+{
+	int32_t rel = slowpath_rel(code, dst);
+	u8 opcode = CALL_REL32_OPCODE;
+
+	/*
+	 * The opcode will be already ok in most configurations, but not if we
+	 * change an indirect branch to direct one, which would happen in
+	 * systems which do not use retpolines.
+	 */
+	if (code->fallback.opcode != opcode)
+		text_poke(&code->fallback.opcode, &opcode, sizeof(opcode));
+	text_poke(&code->fallback.rel, &rel, sizeof(rel));
+}
+
+static void direct_relpoline(struct relpoline_code *code, enum code_state state)
+{
+	u8 opcode;
+	char rel;
+
+	/*
+	 * We set the jump targets based on the previous instruction, since we
+	 * have the no-preempt-prefix field which is not always there.
+	 */
+	switch (state) {
+	case RELPOLINE_SLOWPATH:
+		opcode = JMP_REL8_OPCODE;
+		rel = offsetof(struct relpoline_code, fallback);
+		break;
+	case RELPOLINE_FASTPATH:
+		opcode = JMP_REL8_OPCODE;
+		rel = offsetof(struct relpoline_code, call);
+		break;
+	case RELPOLINE_COND:
+		opcode = JNZ_REL8_OPCODE;
+		rel = offsetof(struct relpoline_code, fallback);
+	}
+
+	rel -= offsetofend(struct relpoline_code, jnz);
+
+	/*
+	 * Our atomicity requirements mean that we can only change one byte and
+	 * another one must stay the same.
+	 */
+	BUG_ON(opcode != code->jnz.opcode && rel != code->jnz.rel);
+
+	if (code->jnz.opcode != opcode)
+		text_poke(&code->jnz.opcode, &opcode, 1);
+	if (code->jnz.rel != rel)
+		text_poke(&code->jnz.rel, &rel, 1);
+}
+
+static void update_relpoline_info(struct relpoline_transition *transition)
+{
+	struct relpoline *rp = transition->rp;
+
+	/* Update the statistics */
+	if (rp->overflow)
+		relpolines_stat->n_overflow--;
+	else if (rp->n_dsts != 0)
+		relpolines_stat->n_dsts[rp->n_dsts-1]--;
+
+	if (transition->overflow)
+		relpolines_stat->n_overflow++;
+	else if (transition->n_dsts != 0)
+		relpolines_stat->n_dsts[transition->n_dsts-1]++;
+
+
+	/* Store the state */
+	rp->n_dsts = transition->n_dsts;
+	rp->overflow = transition->overflow;
+}
+
+static void make_inline_relpoline(struct relpoline_code *code, u32 dst)
+{
+	/*
+	 * Update the compared target; we only compare the low 32-bits,
+	 * since the modules and the kernel text always have the same
+	 * upper 32-bits.
+	 */
+	text_poke(&code->cmp_imm, &dst, sizeof(code->cmp_imm));
+
+	set_inline_fastpath_rel(code, kernel_ptr(dst));
+}
+
+static void clear_learned_relpolines(void)
+{
+	int cpu;
+
+	for_each_online_cpu(cpu) {
+		memset(&per_cpu(relpoline_samples, cpu)[0], 0,
+		       RELPOLINE_SAMPLES_NUM * sizeof(struct relpoline_sample));
+	}
+}
+
+static void change_relpoline_state(struct relpoline *rp,
+				   enum relpoline_state rp_state, bool new_rp)
+{
+	if (!new_rp) {
+		relpoline_list[rp->state].num--;
+		list_del(&rp->node);
+	}
+
+	relpoline_list[rp_state].num++;
+	list_add(&rp->node, &relpoline_list[rp_state].list);
+	rp->state = rp_state;
+}
+
+static int add_relpolines(const struct relpoline_entry *entries,
+			  unsigned int n_entries)
+{
+	struct relpoline *rp;
+	int i, r = 0;
+
+	for (i = 0; i < n_entries; i++) {
+		if (init_kernel_text((uintptr_t)entries[i].rip))
+			continue;
+
+		rp = kmem_cache_alloc(relpoline_info_cache,
+					   GFP_KERNEL|__GFP_ZERO);
+		if (!rp) {
+			r = -ENOMEM;
+			break;
+		}
+
+		rp->code = entries[i].rip;
+		rp->reg = entries[i].reg;
+
+		r = rhashtable_insert_fast(&relpolines_rhead,
+					   &rp->rhash,
+					   relpoline_rht_params);
+		if (r < 0) {
+			kmem_cache_free(relpoline_info_cache,
+					rp);
+			break;
+		}
+
+		change_relpoline_state(rp, RP_STATE_LEARNING, true);
+	}
+	if (r < 0)
+		WARN_ONCE(1, "Error loading relpolines\n");
+
+	return r;
+}
+
+static void remove_relpolines(const struct relpoline_entry *entries,
+			      unsigned int n_entries)
+{
+	struct relpoline *rp;
+	unsigned int i;
+
+	for (i = 0; i < n_entries; i++) {
+		rp = rhashtable_lookup_fast(&relpolines_rhead, &entries[i].rip,
+					    relpoline_rht_params);
+		if (!rp)
+			continue;
+
+		list_del(&rp->node);
+		rhashtable_remove_fast(&relpolines_rhead, &rp->rhash,
+				       relpoline_rht_params);
+
+		/* TODO: Relearn everything! */
+		kmem_cache_free(relpoline_info_cache, rp);
+	}
+}
+
+static int
+relpoline_module_notify(struct notifier_block *self, unsigned long val,
+			  void *data)
+{
+	struct module *mod = data;
+
+	mutex_lock(&relpoline_mutex);
+
+	switch (val) {
+	case MODULE_STATE_COMING:
+		add_relpolines(mod->relpolines, mod->num_relpolines);
+		break;
+	case MODULE_STATE_GOING:
+		remove_relpolines(mod->relpolines, mod->num_relpolines);
+	}
+
+	mutex_unlock(&relpoline_mutex);
+
+	return 0;
+}
+
+static struct notifier_block relpoline_module_nb = {
+	.notifier_call = relpoline_module_notify,
+	.priority = 1,
+};
+
+static int relpoline_sample_src_cmp_func(const void *l, const void *r)
+{
+	const struct relpoline_sample *s1 = l;
+	const struct relpoline_sample *s2 = r;
+
+	if (s1->src != s2->src)
+		return s1->src - s2->src;
+
+	return s1->dst - s2->dst;
+}
+
+static int relpoline_sample_cnt_cmp_func(const void *l, const void *r)
+{
+	const struct relpoline_sample *s1 = l;
+	const struct relpoline_sample *s2 = r;
+
+	return s2->cnt - s1->cnt;
+}
+
+static int copy_relpolines(void)
+{
+	struct relpoline_sample *p_copy = relpoline_samples_copy;
+	int cpu, i, n_entries;
+
+	for_each_online_cpu(cpu) {
+		struct relpoline_sample *orig;
+
+		orig = per_cpu(relpoline_samples, cpu);
+
+		for (i = 0; i < RELPOLINE_SAMPLES_NUM; i++, orig++) {
+			p_copy->src = READ_ONCE(orig->src);
+
+			/* Do some sanity checks while we are at it */
+			if (p_copy->src == 0)
+				continue;
+
+			if (init_kernel_text((uintptr_t)kernel_ptr(p_copy->src)))
+				continue;
+
+			/* Do the adjusting now to simplify later work */
+			p_copy->src -= offsetofend(struct relpoline_code,
+						   fallback);
+
+			/*
+			 * Ignore the risk of getting wrong data. We can live
+			 * with it (with some performance impact)
+			 */
+			p_copy->dst = READ_ONCE(orig->dst);
+			p_copy->cnt = READ_ONCE(orig->cnt);
+			p_copy++;
+		}
+	}
+
+	n_entries = p_copy - relpoline_samples_copy;
+
+	/* Sort by src */
+	sort(relpoline_samples_copy, n_entries, sizeof(*relpoline_samples_copy),
+	     relpoline_sample_src_cmp_func, NULL);
+
+	return n_entries;
+}
+
+/*
+ * Goes over the sources starting from src_idx. Returns whether a new decision
+ * that is different than the current behavior has been done.
+ */
+static void relpoline_one_decision(struct relpoline_sample *samples,
+				   unsigned int n_entries,
+				   struct relpoline_transition *transition)
+{
+	struct relpoline *rp = transition->rp;
+	int i, j, k, n_new = 0, n_dsts = 0;
+
+	if (!transition->reset && rp->n_dsts != 0) {
+		transition->dsts[0] = rp->code->cmp_imm;
+		n_dsts++;
+	}
+
+	/*
+	 * Merge destinations with the same source and sum their samples.
+	 */
+	for (i = 1, j = 0; i < n_entries; i++) {
+		if (samples[j].dst != samples[i].dst) {
+			/* New target */
+			samples[++j] = samples[i];
+			continue;
+		}
+		/* Known target, add samples */
+		samples[j].cnt += samples[i].cnt;
+	}
+	n_new = j + 1;
+
+	/*
+	 * Remove entries that are already set. It is not likely to happen, but
+	 * this should not be too expensive. Do not use sort, since it uses
+	 * indirect branches, and likely to be slower than silly test.
+	 */
+	for (i = 0, j = 0; i < n_new; i++) {
+		for (k = 0; k < n_dsts; k++) {
+			if (samples[i].dst == transition->dsts[k])
+				break;
+		}
+
+		if (k == n_dsts) {
+			/* New entry */
+			samples[j++] = samples[i];
+		}
+	}
+
+	/* Change the new number based on the duplicates we detected */
+	n_new = j;
+
+	sort(samples, n_new, sizeof(*samples), relpoline_sample_cnt_cmp_func,
+	     NULL);
+
+	/* Add the new ones */
+	for (i = 0; i < n_new && n_dsts < ARRAY_SIZE(transition->dsts);
+	     i++, n_dsts++)
+		transition->dsts[n_dsts] = samples[i].dst;
+
+	if (n_dsts + n_new > 1) {
+		transition->n_dsts = 1;
+		transition->overflow = true;
+	}
+	transition->n_dsts = n_dsts;
+}
+
+static void init_relpoline_transition(struct relpoline_transition *rp_trans,
+				      struct relpoline *rp,
+				      bool reset)
+{
+	rp_trans->rp = rp;
+	rp_trans->n_dsts = 0;
+	rp_trans->overflow = 0;
+	rp_trans->prev_n_dsts = rp->n_dsts;
+	rp_trans->reset = reset;
+}
+
+/*
+ * Returns the number of decisions.
+ */
+static int make_relpoline_decisions(struct relpoline_transition *transition)
+{
+	unsigned int end, start, n_decisions = 0;
+	int n_copied;
+
+	/*
+	 * First we copy the relpolines for a certain hash index to prevent it
+	 * from messing up with our data. While we can cope with races that
+	 * modify the destination, we need the source rip to be consistent.
+	 */
+	n_copied = copy_relpolines();
+
+	for (start = 0, n_decisions = 0;
+	     start < n_copied && n_decisions < RP_MAX_DECISIONS; start = end) {
+		struct relpoline_code *code;
+		struct relpoline *rp;
+
+		code = kernel_ptr(relpoline_samples_copy[start].src);
+		rp = rhashtable_lookup_fast(&relpolines_rhead, &code,
+					    relpoline_rht_params);
+
+		/* Races might cause the source to be wrong. Live with it */
+		if (!rp) {
+			end = start + 1;
+			continue;
+		}
+
+		/* Find all the relevant entries */
+		for (end = start + 1; end < n_copied; end++) {
+			if (relpoline_samples_copy[start].src !=
+			    relpoline_samples_copy[end].src)
+				break;
+		}
+
+		init_relpoline_transition(&transition[n_decisions], rp, false);
+
+		relpoline_one_decision(&relpoline_samples_copy[start],
+					 end - start, &transition[n_decisions]);
+
+		n_decisions++;
+	}
+	return n_decisions;
+}
+
+static void change_retpoline_to_indirect(struct relpoline_code *code, u8 reg)
+{
+	u8 copy_len, offset, nop_len, call_len = 2;
+	u8 patched[sizeof(code->fallback)];
+
+	copy_len = offsetofend(typeof(*code), fallback) -
+		   offsetof(typeof(*code), fallback.opcode);
+
+	/* Save a byte for no-preempt prefix */
+	if (IS_ENABLED(CONFIG_PREEMPT))
+		call_len++;
+
+	/* Save a byte for call */
+	if (reg >= ARCH_R8)
+		call_len++;
+
+	/* We leave the no-preempt prefix unmodified, so we ignore it */
+	nop_len = copy_len - call_len;
+	memcpy(patched, ideal_nops[nop_len], nop_len);
+
+	offset = nop_len;
+	if (IS_ENABLED(CONFIG_PREEMPT))
+		patched[offset++] = PREEMPT_DISABLE_PREFIX;
+	if (reg >= ARCH_R8)
+		patched[offset++] = REX_B;
+
+	memcpy(&patched[offset], CALL_IND_INS, sizeof(CALL_IND_INS) - 1);
+	patched[copy_len - 1] |= reg & 7;
+
+	text_poke(&code->fallback.opcode, patched, copy_len);
+}
+
+static void update_slowpath(struct relpoline_transition *transition)
+{
+	struct relpoline *rp = transition->rp;
+	struct relpoline_code *code = rp->code;
+	u8 reg = rp->reg;
+
+	if (transition->overflow) {
+		if (static_cpu_has(X86_FEATURE_RETPOLINE))
+			set_slowpath_rel(code, indirect_thunks[reg]);
+		else
+			change_retpoline_to_indirect(code, reg);
+	} else
+		set_slowpath_rel(code, save_relpoline_funcs[reg]);
+}
+
+static void update_relpolines(struct relpoline_transition *transitions, int n)
+{
+	struct relpoline_transition *start, *cur, *end;
+
+	mutex_lock(&text_mutex);
+	start = transitions;
+	end = transitions + n;
+
+	for (cur = start; cur != end; cur++) {
+		update_relpoline_info(cur);
+
+		direct_relpoline(cur->rp->code, RELPOLINE_SLOWPATH);
+	}
+
+	/*
+	 * Ensure all cores no longer run the disabled relpolines.  Since
+	 * preemption is disabled between the relpoline compare and call, this
+	 * would mean they are all safe.
+	 */
+	synchronize_sched();
+
+	for (cur = start; cur != end; cur++) {
+		/*
+		 * During the transition the fast-path behaves as a fallback.
+		 */
+		set_inline_fastpath_rel(cur->rp->code,
+					indirect_thunks[cur->rp->reg]);
+
+		/*
+		 * Move everything to the fast-path.
+		 */
+		direct_relpoline(cur->rp->code, RELPOLINE_FASTPATH);
+	}
+
+	synchronize_sched();
+
+	/* Now we can quietly update the slow-path */
+	for (cur = start; cur != end; cur++) {
+		update_slowpath(cur);
+		direct_relpoline(cur->rp->code, RELPOLINE_SLOWPATH);
+	}
+
+	synchronize_sched();
+
+	/* Update the compared value and the call targets */
+	for (cur = start; cur != end; cur++) {
+		struct relpoline *rp = cur->rp;
+		enum relpoline_state state;
+
+		/*
+		 * If there are destinations, enable; otherwise, keep disabled.
+		 */
+		if (cur->n_dsts == 0) {
+			state = RP_STATE_LEARNING;
+		} else {
+			make_inline_relpoline(rp->code, cur->dsts[0]);
+			direct_relpoline(rp->code, RELPOLINE_COND);
+
+			if (cur->overflow || cur->n_dsts > 1)
+				state = RP_STATE_UNSTABLE;
+			else
+				state = RP_STATE_STABLE;
+		}
+
+		change_relpoline_state(rp, state, false);
+	}
+	mutex_unlock(&text_mutex);
+}
+
+static void relearn_relpolines(unsigned int n)
+{
+	struct list_head *list = &relpoline_list[RP_STATE_UNSTABLE].list;
+	struct relpoline *rp, *tmp;
+	unsigned int done = 0;
+
+	while (!list_empty(list) && done < n) {
+		unsigned int i = 0;
+
+		list_for_each_entry_safe(rp, tmp, list, node) {
+			init_relpoline_transition(&cp_changes[i], rp, true);
+
+			i++;
+			done++;
+
+			if (i >= RP_MAX_DECISIONS || done >= n)
+				break;
+		}
+		update_relpolines(cp_changes, i);
+	}
+}
+
+static void relpoline_work(struct work_struct *work);
+
+static DECLARE_DELAYED_WORK(c_work, relpoline_work);
+
+static void relpolines_autolearn(void)
+{
+	if (relpolines_resampling_count != 0) {
+		unsigned int resampled;
+
+		resampled = min_t(unsigned int, relpolines_resampling_count,
+				  RP_REENABLE_IN_EPOCH);
+
+		relearn_relpolines(resampled);
+
+		relpolines_resampling_count -= resampled;
+
+		/*
+		 * We defer starting the next start-time from the end of the
+		 * current one.
+		 */
+		relpolines_sample_time = ktime_get();
+		return;
+	}
+
+	if (ktime_ms_delta(ktime_get(), relpolines_sample_time) <
+	    RP_SAMPLE_MSECS)
+		return;
+
+	/* Start another training period */
+	relpolines_resampling_count = relpoline_list[RP_STATE_UNSTABLE].num;
+}
+
+
+static void relpoline_work(struct work_struct *work)
+{
+	int n;
+
+	mutex_lock(&relpoline_mutex);
+	cpus_read_lock();
+
+	n = make_relpoline_decisions(cp_changes);
+
+	if (n != 0) {
+		update_relpolines(cp_changes, n);
+		clear_learned_relpolines();
+	} else
+		relpolines_autolearn();
+
+	cpus_read_unlock();
+	mutex_unlock(&relpoline_mutex);
+
+	schedule_delayed_work(&c_work, HZ * RP_READJUST_SECONDS);
+}
+
+static int relpoline_debug_show(struct seq_file *f, void *offset)
+{
+	int i;
+
+	seq_puts(f, "Destinations distribution\n");
+	for (i = 0; i < RP_TARGETS; i++)
+		seq_printf(f, "%d, %u\n", i+1, relpolines_stat->n_dsts[i]);
+	seq_printf(f, "%d, %u\n", i+1, relpolines_stat->n_overflow);
+	return 0;
+}
+
+static int relpoline_debug_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, relpoline_debug_show, inode->i_private);
+}
+
+static ssize_t relpoline_debug_write(struct file *file, const char __user *ubuf,
+				     size_t count, loff_t *ppos)
+{
+	u8 kbuf[40] = {0};
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
+	if (strcmp(kbuf, "relearn") == 0) {
+		mutex_lock(&relpoline_mutex);
+		relearn_relpolines(UINT_MAX);
+		mutex_unlock(&relpoline_mutex);
+	} else
+		return -EINVAL;
+
+	return count;
+}
+
+static const struct file_operations relpoline_debug_fops = {
+	.owner		= THIS_MODULE,
+	.open		= relpoline_debug_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+	.write		= relpoline_debug_write,
+};
+
+static int __init create_relpoline_debugfs(void)
+{
+	int r;
+
+	relpoline_dbg_entry = debugfs_create_file("relpolines", 0444, NULL,
+						  NULL, &relpoline_debug_fops);
+	if (IS_ERR(relpoline_dbg_entry)) {
+		r = PTR_ERR(relpoline_dbg_entry);
+		pr_err("failed to create debugfs entry, error: %d", r);
+		return r;
+	}
+
+	relpolines_stat = kzalloc(sizeof(*(relpolines_stat)), GFP_KERNEL);
+
+	return 0;
+}
+
+static void release_relpoline_debugfs(void)
+{
+	kfree(relpolines_stat);
+	relpolines_stat = NULL;
+}
+
+static int __init relpoline_init(void)
+{
+	bool relpolines_rhead_initialized = false;
+	int i, r;
+
+	if (IS_ENABLED(CONFIG_DEBUG_FS)) {
+		r = create_relpoline_debugfs();
+		if (r)
+			goto error;
+	}
+
+	mutex_init(&relpoline_mutex);
+
+	r = rhashtable_init(&relpolines_rhead, &relpoline_rht_params);
+	if (r)
+		goto error;
+
+	relpolines_rhead_initialized = true;
+
+	relpoline_info_cache = kmem_cache_create("relpoline_cache",
+				sizeof(struct relpoline), 0, 0, NULL);
+	if (!relpoline_info_cache)
+		goto error;
+
+	relpolines_sample_time = ktime_get();
+
+	/*
+	 * TODO: this array needs to be reallocated if CPUs are hotplugged
+	 */
+	relpoline_samples_copy = kmalloc_array(num_online_cpus() * RELPOLINE_SAMPLES_NUM,
+					       sizeof(*relpoline_samples_copy),
+					       GFP_KERNEL);
+
+	if (relpoline_samples_copy == NULL) {
+		r = -ENOMEM;
+		WARN(1, "error allocating relpoline memory");
+		goto error;
+	}
+
+	r = register_module_notifier(&relpoline_module_nb);
+	if (r) {
+		WARN(1, "error initializing relpolines");
+		goto error;
+	}
+
+	for (i = 0; i < RP_STATE_NUM; i++) {
+		INIT_LIST_HEAD(&relpoline_list[i].list);
+		relpoline_list[i].num = 0;
+	}
+
+	/*
+	 * Ignoring errors here, only part of the relpolines would be enabled.
+	 */
+	add_relpolines(__relpolines, __relpolines_end - __relpolines);
+
+	schedule_delayed_work(&c_work, HZ * RP_READJUST_SECONDS * 10);
+
+	return 0;
+error:
+	kfree(relpoline_samples_copy);
+	relpoline_samples_copy = NULL;
+	unregister_module_notifier(&relpoline_module_nb);
+
+	kmem_cache_destroy(relpoline_info_cache);
+	relpoline_info_cache = NULL;
+
+	if (relpolines_rhead_initialized)
+		rhashtable_destroy(&relpolines_rhead);
+	relpolines_rhead_initialized = false;
+
+	release_relpoline_debugfs();
+	return r;
+}
+late_initcall(relpoline_init);
-- 
2.17.1

