Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C597FC43141
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 13:32:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AA7820883
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 13:32:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kU2pDwAR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AA7820883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933409AbeFUNcg (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 09:32:36 -0400
Received: from merlin.infradead.org ([205.233.59.134]:54568 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933356AbeFUNcb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 09:32:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=f//xd7K1VbYfydDQjB8FSgqflSDl5X8hxjhnHNleTPE=; b=kU2pDwARVwhkFRPw+9Wmi5Urj
        mV3n09XSg36BUTrh5SA8VWqC7xQvDX8pEoVPuGBwuIZrN2LJLj52gG7ezBBCY9w/0MzBMWx0a1ogN
        Z7NUmMIfXGb83Ua8eZrF2/pPtUC3+uPcMnkL9IU2uPAUNBuCUlnQ6fRW3b7MEp5Um7RYdLxHnuegc
        AMwUHPfBI+AT5Jl2SnHw7mT3zzWsai8G2VrWbrjmzkFUNhJxbwvbx+6WabtSbmpSl1ADLbbdKFL3M
        oVWswlOsVJaa6KvHQSOu4H20xaIydE+AisrzXykVhf+KKwjSKCgwg2593g7stX+F2KfNxwdgDROdR
        IwrXLBtLg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fVzfg-0007Ep-6C; Thu, 21 Jun 2018 13:30:44 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D07CC2029F1D5; Thu, 21 Jun 2018 15:30:41 +0200 (CEST)
Date:   Thu, 21 Jun 2018 15:30:41 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Pavel Tatashin <pasha.tatashin@oracle.com>
Cc:     feng.tang@intel.com, Steven Sistare <steven.sistare@oracle.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        linux@armlinux.org.uk, schwidefsky@de.ibm.com,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        John Stultz <john.stultz@linaro.org>, sboyd@codeaurora.org,
        x86@kernel.org, LKML <linux-kernel@vger.kernel.org>,
        mingo@redhat.com, tglx@linutronix.de, hpa@zytor.com,
        douly.fnst@cn.fujitsu.com, prarit@redhat.com,
        Petr Mladek <pmladek@suse.com>, gnomes@lxorguk.ukuu.org.uk,
        Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v11 6/6] x86/tsc: use tsc early
Message-ID: <20180621133041.GZ2494@hirez.programming.kicks-ass.net>
References: <20180620212700.29178-1-pasha.tatashin@oracle.com>
 <20180620212700.29178-7-pasha.tatashin@oracle.com>
 <20180621055144.i65hhyqe5dofop33@shbuild888>
 <CAGM2reYethiqDLM0dRRSihvRCi24b_B=eBR05G=nWVQSL9LVww@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGM2reYethiqDLM0dRRSihvRCi24b_B=eBR05G=nWVQSL9LVww@mail.gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 21, 2018 at 07:16:32AM -0400, Pavel Tatashin wrote:
> > Do we still need add a static_key? after Peter worked out the patch
> > to enable ealy jump_label_init?
> 
> Hi Feng,
> 
> With Pete's patch we will still need at least one static branch, but
> as I replied to Pete's email I like the idea of initializing
> jump_label_init() early, but in my opinion it should be a separate
> work, with tsc.c cleanup patch.

Bah, no, we don't make a mess first and then maybe clean it up.

Have a look at the below. The patch is a mess, but I have two sick kids
on hands, please clean up / split where appropriate.

Seems to work though:

Booting the kernel.
[    0.000000] microcode: microcode updated early to revision 0x428, date = 2014-05-29
[    0.000000] Linux version 4.17.0-09589-g7a36b8fc167a-dirty (root@ivb-ep) (gcc version 7.3.0 (Debian 7.3.0-3)) #360 SMP PREEMPT Thu Jun 21 15:03:32 CEST 2018
[    0.000000] Command line: BOOT_IMAGE=/boot/vmlinuz-4.17.0-09589-g7a36b8fc167a-dirty root=UUID=ee91c0f0-977f-434d-bfaa-92daf7cdbe07 ro possible_cpus=40 debug ignore_loglevel sysrq_always_enabled ftrace=nop earlyprintk=serial,ttyS0,115200 console=ttyS0,115200 no_console_suspend force_early_printk sched_debug
[    0.000000] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
[    0.000000] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
[    0.000000] x86/fpu: Enabled xstate features 0x7, context size is 832 bytes, using 'standard' format.
[    0.000000] key: ffffffff83033e90 enabled: 0 enable: 1
[    0.000000] transform: setup_arch+0x104/0xc6a type: 1
[    0.000000] transform: setup_arch+0xcf/0xc6a type: 1
[    0.000000] transform: setup_arch+0xf3/0xc6a type: 0
[    0.000000] transform: setup_arch+0xbe/0xc6a type: 0
[    0.000000] post-likely
[    0.000000] post-unlikely

---
 arch/x86/include/asm/jump_label.h |  2 ++
 arch/x86/kernel/alternative.c     |  2 ++
 arch/x86/kernel/cpu/amd.c         | 13 +++++++-----
 arch/x86/kernel/cpu/common.c      |  2 ++
 arch/x86/kernel/jump_label.c      | 43 +++++++++++++++++++++++++++++++++------
 arch/x86/kernel/setup.c           | 19 +++++++++++++++--
 include/linux/jump_label.h        | 25 +++++++++++++++++++----
 kernel/jump_label.c               | 16 ---------------
 8 files changed, 89 insertions(+), 33 deletions(-)

diff --git a/arch/x86/include/asm/jump_label.h b/arch/x86/include/asm/jump_label.h
index 8c0de4282659..555fb57ea872 100644
--- a/arch/x86/include/asm/jump_label.h
+++ b/arch/x86/include/asm/jump_label.h
@@ -74,6 +74,8 @@ struct jump_entry {
 	jump_label_t key;
 };
 
+extern void jump_label_update_early(struct static_key *key, bool enable);
+
 #else	/* __ASSEMBLY__ */
 
 .macro STATIC_JUMP_IF_TRUE target, key, def
diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index a481763a3776..874bb274af2f 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -215,6 +215,7 @@ void __init arch_init_ideal_nops(void)
 			   ideal_nops = p6_nops;
 		} else {
 #ifdef CONFIG_X86_64
+			/* FEATURE_NOPL is unconditionally true on 64bit so this is dead code */
 			ideal_nops = k8_nops;
 #else
 			ideal_nops = intel_nops;
@@ -668,6 +669,7 @@ void *__init_or_module text_poke_early(void *addr, const void *opcode,
 	local_irq_save(flags);
 	memcpy(addr, opcode, len);
 	local_irq_restore(flags);
+	sync_core();
 	/* Could also do a CLFLUSH here to speed up CPU recovery; but
 	   that causes hangs on some VIA CPUs. */
 	return addr;
diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index 082d7875cef8..355105aebc4e 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -232,8 +232,6 @@ static void init_amd_k7(struct cpuinfo_x86 *c)
 		}
 	}
 
-	set_cpu_cap(c, X86_FEATURE_K7);
-
 	/* calling is from identify_secondary_cpu() ? */
 	if (!c->cpu_index)
 		return;
@@ -615,6 +613,14 @@ static void early_init_amd(struct cpuinfo_x86 *c)
 
 	early_init_amd_mc(c);
 
+#ifdef CONFIG_X86_32
+	if (c->x86 == 6)
+		set_cpu_cap(c, X86_FEATURE_K7);
+#endif
+
+	if (c->x86 >= 0xf)
+		set_cpu_cap(c, X86_FEATURE_K8);
+
 	rdmsr_safe(MSR_AMD64_PATCH_LEVEL, &c->microcode, &dummy);
 
 	/*
@@ -861,9 +867,6 @@ static void init_amd(struct cpuinfo_x86 *c)
 
 	init_amd_cacheinfo(c);
 
-	if (c->x86 >= 0xf)
-		set_cpu_cap(c, X86_FEATURE_K8);
-
 	if (cpu_has(c, X86_FEATURE_XMM2)) {
 		unsigned long long val;
 		int ret;
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 910b47ee8078..2a4024f7a222 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1086,6 +1086,8 @@ static void __init early_identify_cpu(struct cpuinfo_x86 *c)
 	 */
 	if (!pgtable_l5_enabled())
 		setup_clear_cpu_cap(X86_FEATURE_LA57);
+
+	detect_nopl(c);
 }
 
 void __init early_cpu_init(void)
diff --git a/arch/x86/kernel/jump_label.c b/arch/x86/kernel/jump_label.c
index e56c95be2808..abebe1318e6b 100644
--- a/arch/x86/kernel/jump_label.c
+++ b/arch/x86/kernel/jump_label.c
@@ -52,16 +52,14 @@ static void __jump_label_transform(struct jump_entry *entry,
 			 * Jump label is enabled for the first time.
 			 * So we expect a default_nop...
 			 */
-			if (unlikely(memcmp((void *)entry->code, default_nop, 5)
-				     != 0))
+			if (unlikely(memcmp((void *)entry->code, default_nop, 5) != 0))
 				bug_at((void *)entry->code, __LINE__);
 		} else {
 			/*
 			 * ...otherwise expect an ideal_nop. Otherwise
 			 * something went horribly wrong.
 			 */
-			if (unlikely(memcmp((void *)entry->code, ideal_nop, 5)
-				     != 0))
+			if (unlikely(memcmp((void *)entry->code, ideal_nop, 5) != 0))
 				bug_at((void *)entry->code, __LINE__);
 		}
 
@@ -80,8 +78,8 @@ static void __jump_label_transform(struct jump_entry *entry,
 				bug_at((void *)entry->code, __LINE__);
 		} else {
 			code.jump = 0xe9;
-			code.offset = entry->target -
-				(entry->code + JUMP_LABEL_NOP_SIZE);
+			code.offset = entry->target - (entry->code + JUMP_LABEL_NOP_SIZE);
+
 			if (unlikely(memcmp((void *)entry->code, &code, 5) != 0))
 				bug_at((void *)entry->code, __LINE__);
 		}
@@ -140,4 +138,37 @@ __init_or_module void arch_jump_label_transform_static(struct jump_entry *entry,
 		__jump_label_transform(entry, type, text_poke_early, 1);
 }
 
+void jump_label_update_early(struct static_key *key, bool enable)
+{
+	struct jump_entry *entry, *stop = __stop___jump_table;
+
+	/*
+	 * We need the table sorted and key->entries set up.
+	 */
+	WARN_ON_ONCE(!static_key_initialized);
+
+	entry = static_key_entries(key);
+
+	/*
+	 * Sanity check for early users, there had beter be a core kernel user.
+	 */
+	if (!entry || !entry->code || !core_kernel_text(entry->code)) {
+		WARN_ON(1);
+		return;
+	}
+
+	printk("key: %px enabled: %d enable: %d\n", key, atomic_read(&key->enabled), (int)enable);
+
+	if (!(!!atomic_read(&key->enabled) ^ !!enable))
+		return;
+
+	for ( ; (entry < stop) && (jump_entry_key(entry) == key); entry++) {
+		enum jump_label_type type = enable ^ jump_entry_branch(entry);
+		printk("transform: %pS type: %d\n", (void *)entry->code, type);
+		__jump_label_transform(entry, type, text_poke_early, 0);
+	}
+
+	atomic_set_release(&key->enabled, !!enable);
+}
+
 #endif
diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index 2f86d883dd95..3731245b8ec7 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -805,6 +805,8 @@ dump_kernel_offset(struct notifier_block *self, unsigned long v, void *p)
 	return 0;
 }
 
+static DEFINE_STATIC_KEY_FALSE(__test);
+
 /*
  * Determine if we were loaded by an EFI loader.  If so, then we have also been
  * passed the efi memmap, systab, etc., so we should use these data structures
@@ -866,6 +868,21 @@ void __init setup_arch(char **cmdline_p)
 
 	idt_setup_early_traps();
 	early_cpu_init();
+	arch_init_ideal_nops();
+	jump_label_init();
+
+	if (static_branch_likely(&__test))
+		printk("pre-likely\n");
+	if (static_branch_unlikely(&__test))
+		printk("pre-unlikely\n");
+
+	jump_label_update_early(&__test.key, true);
+
+	if (static_branch_likely(&__test))
+		printk("post-likely\n");
+	if (static_branch_unlikely(&__test))
+		printk("post-unlikely\n");
+
 	early_ioremap_init();
 
 	setup_olpc_ofw_pgd();
@@ -1272,8 +1289,6 @@ void __init setup_arch(char **cmdline_p)
 
 	mcheck_init();
 
-	arch_init_ideal_nops();
-
 	register_refined_jiffies(CLOCK_TICK_RATE);
 
 #ifdef CONFIG_EFI
diff --git a/include/linux/jump_label.h b/include/linux/jump_label.h
index b46b541c67c4..7a693d0fb5b5 100644
--- a/include/linux/jump_label.h
+++ b/include/linux/jump_label.h
@@ -79,6 +79,7 @@
 
 #include <linux/types.h>
 #include <linux/compiler.h>
+#include <linux/bug.h>
 
 extern bool static_key_initialized;
 
@@ -110,6 +111,17 @@ struct static_key {
 	};
 };
 
+#define JUMP_TYPE_FALSE		0UL
+#define JUMP_TYPE_TRUE		1UL
+#define JUMP_TYPE_LINKED	2UL
+#define JUMP_TYPE_MASK		3UL
+
+static inline struct jump_entry *static_key_entries(struct static_key *key)
+{
+	WARN_ON_ONCE(key->type & JUMP_TYPE_LINKED);
+	return (struct jump_entry *)(key->type & ~JUMP_TYPE_MASK);
+}
+
 #else
 struct static_key {
 	atomic_t enabled;
@@ -132,10 +144,15 @@ struct module;
 
 #ifdef HAVE_JUMP_LABEL
 
-#define JUMP_TYPE_FALSE		0UL
-#define JUMP_TYPE_TRUE		1UL
-#define JUMP_TYPE_LINKED	2UL
-#define JUMP_TYPE_MASK		3UL
+static inline struct static_key *jump_entry_key(struct jump_entry *entry)
+{
+	return (struct static_key *)((unsigned long)entry->key & ~1UL);
+}
+
+static inline bool jump_entry_branch(struct jump_entry *entry)
+{
+	return (unsigned long)entry->key & 1UL;
+}
 
 static __always_inline bool static_key_false(struct static_key *key)
 {
diff --git a/kernel/jump_label.c b/kernel/jump_label.c
index 01ebdf1f9f40..9710fa7582aa 100644
--- a/kernel/jump_label.c
+++ b/kernel/jump_label.c
@@ -295,12 +295,6 @@ void __weak __init_or_module arch_jump_label_transform_static(struct jump_entry
 	arch_jump_label_transform(entry, type);
 }
 
-static inline struct jump_entry *static_key_entries(struct static_key *key)
-{
-	WARN_ON_ONCE(key->type & JUMP_TYPE_LINKED);
-	return (struct jump_entry *)(key->type & ~JUMP_TYPE_MASK);
-}
-
 static inline bool static_key_type(struct static_key *key)
 {
 	return key->type & JUMP_TYPE_TRUE;
@@ -321,16 +315,6 @@ static inline void static_key_set_linked(struct static_key *key)
 	key->type |= JUMP_TYPE_LINKED;
 }
 
-static inline struct static_key *jump_entry_key(struct jump_entry *entry)
-{
-	return (struct static_key *)((unsigned long)entry->key & ~1UL);
-}
-
-static bool jump_entry_branch(struct jump_entry *entry)
-{
-	return (unsigned long)entry->key & 1UL;
-}
-
 /***
  * A 'struct static_key' uses a union such that it either points directly
  * to a table of 'struct jump_entry' or to a linked list of modules which in
