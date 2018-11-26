Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21F86C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 17:56:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D656720663
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 17:56:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D656720663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726881AbeK0EvX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 23:51:23 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36898 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726251AbeK0EvW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 23:51:22 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1D54F80F81;
        Mon, 26 Nov 2018 17:56:31 +0000 (UTC)
Received: from treble (ovpn-121-105.rdu2.redhat.com [10.10.121.105])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 535ED1057076;
        Mon, 26 Nov 2018 17:56:27 +0000 (UTC)
Date:   Mon, 26 Nov 2018 11:56:24 -0600
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Andy Lutomirski <luto@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jason Baron <jbaron@akamai.com>, Jiri Kosina <jkosina@suse.cz>,
        David Laight <David.Laight@ACULAB.COM>,
        Borislav Petkov <bp@alien8.de>,
        Julia Cartwright <julia@ni.com>, Jessica Yu <jeyu@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v2 4/4] x86/static_call: Add inline static call
 implementation for x86-64
Message-ID: <20181126175624.bruqfbkngbucpvxr@treble>
References: <cover.1543200841.git.jpoimboe@redhat.com>
 <62188c62f6dda49ca2e20629ee8e5a62a6c0b500.1543200841.git.jpoimboe@redhat.com>
 <20181126160217.GR2113@hirez.programming.kicks-ass.net>
 <20181126171036.chcbmb35ygpxziub@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181126171036.chcbmb35ygpxziub@treble>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Mon, 26 Nov 2018 17:56:31 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 26, 2018 at 11:10:36AM -0600, Josh Poimboeuf wrote:
> On Mon, Nov 26, 2018 at 05:02:17PM +0100, Peter Zijlstra wrote:
> > On Mon, Nov 26, 2018 at 07:55:00AM -0600, Josh Poimboeuf wrote:
> > > diff --git a/arch/x86/kernel/static_call.c b/arch/x86/kernel/static_call.c
> > > index 8026d176f25c..d3869295b88d 100644
> > > --- a/arch/x86/kernel/static_call.c
> > > +++ b/arch/x86/kernel/static_call.c
> > > @@ -9,13 +9,21 @@
> > >  
> > >  void static_call_bp_handler(void);
> > >  void *bp_handler_dest;
> > > +void *bp_handler_continue;
> > >  
> > >  asm(".pushsection .text, \"ax\"						\n"
> > >      ".globl static_call_bp_handler					\n"
> > >      ".type static_call_bp_handler, @function				\n"
> > >      "static_call_bp_handler:						\n"
> > > -    "ANNOTATE_RETPOLINE_SAFE						\n"
> > > +#ifdef CONFIG_HAVE_STATIC_CALL_INLINE
> > > +    ANNOTATE_RETPOLINE_SAFE
> > > +    "call *bp_handler_dest						\n"
> > > +    ANNOTATE_RETPOLINE_SAFE
> > > +    "jmp *bp_handler_continue						\n"
> > > +#else /* !CONFIG_HAVE_STATIC_CALL_INLINE */
> > > +    ANNOTATE_RETPOLINE_SAFE
> > >      "jmp *bp_handler_dest						\n"
> > > +#endif
> > >      ".popsection							\n");
> > >  
> > >  void arch_static_call_transform(void *site, void *tramp, void *func)
> > > @@ -25,7 +33,10 @@ void arch_static_call_transform(void *site, void *tramp, void *func)
> > >  	unsigned char insn_opcode;
> > >  	unsigned char opcodes[CALL_INSN_SIZE];
> > >  
> > > -	insn = (unsigned long)tramp;
> > > +	if (IS_ENABLED(CONFIG_HAVE_STATIC_CALL_INLINE))
> > > +		insn = (unsigned long)site;
> > > +	else
> > > +		insn = (unsigned long)tramp;
> > >  
> > >  	mutex_lock(&text_mutex);
> > >  
> > > @@ -41,8 +52,10 @@ void arch_static_call_transform(void *site, void *tramp, void *func)
> > >  	opcodes[0] = insn_opcode;
> > >  	memcpy(&opcodes[1], &dest_relative, CALL_INSN_SIZE - 1);
> > >  
> > > -	/* Set up the variable for the breakpoint handler: */
> > > +	/* Set up the variables for the breakpoint handler: */
> > >  	bp_handler_dest = func;
> > > +	if (IS_ENABLED(CONFIG_HAVE_STATIC_CALL_INLINE))
> > > +		bp_handler_continue = (void *)(insn + CALL_INSN_SIZE);
> > >  
> > >  	/* Patch the call site: */
> > >  	text_poke_bp((void *)insn, opcodes, CALL_INSN_SIZE,
> > 
> > OK, so this is where that static_call_bp_handler comes from; you need
> > that CALL to frob the stack.
> > 
> > But I still think it is broken; consider:
> > 
> > 	CPU0				CPU1
> > 
> > 	bp_handler = ponies;
> > 
> > 	text_poke_bp(, &static_call_bp_handler)
> > 	  text_poke(&int3);
> > 	  on_each_cpu(sync)
> > 	  				<IPI>
> > 					  ...
> > 					</IPI>
> > 
> > 	  text_poke(/* all but first bytes */)
> > 	  on_each_cpu(sync)
> > 	  				<IPI>
> > 					  ...
> > 					</IPI>
> > 
> > 	  				<int3>
> > 					  pt_regs->ip = &static_call_bp_handler
> > 					</int3>
> > 
> > 					// VCPU takes a nap...
> > 	  text_poke(/* first byte */)
> > 	  on_each_cpu(sync)
> > 	  				<IPI>
> > 					  ...
> > 					</IPI>
> > 
> > 					// VCPU sleeps more
> > 	bp_handler = unicorn;
> > 
> > 					CALL unicorn
> > 
> > *whoops*
> > 
> > Now, granted, that is all rather 'unlikely', but that never stopped
> > Murphy.
> 
> Good find, thanks Peter.
> 
> As we discussed on IRC, we'll need to fix this from within the int3
> exception handler by faking the call: putting a fake return address on
> the stack (pointing to right after the call) and setting regs->ip to the
> called function.
> 
> And for the out-of-line case we can just jump straight to the function,
> so the function itself will be the text_poke_bp() "handler".
> 
> So the static_call_bp_handler() trampoline will go away.

Peter suggested updating the text_poke_bp() interface to add a handler
which is called from int3 context.  This seems to work.

diff --git a/arch/x86/include/asm/text-patching.h b/arch/x86/include/asm/text-patching.h
index e85ff65c43c3..7fcaa37c1876 100644
--- a/arch/x86/include/asm/text-patching.h
+++ b/arch/x86/include/asm/text-patching.h
@@ -20,6 +20,8 @@ static inline void apply_paravirt(struct paravirt_patch_site *start,
 
 extern void *text_poke_early(void *addr, const void *opcode, size_t len);
 
+typedef void (*bp_handler_t)(struct pt_regs *regs);
+
 /*
  * Clear and restore the kernel write-protection flag on the local CPU.
  * Allows the kernel to edit read-only pages.
@@ -36,7 +38,8 @@ extern void *text_poke_early(void *addr, const void *opcode, size_t len);
  */
 extern void *text_poke(void *addr, const void *opcode, size_t len);
 extern int poke_int3_handler(struct pt_regs *regs);
-extern void *text_poke_bp(void *addr, const void *opcode, size_t len, void *handler);
+extern void *text_poke_bp(void *addr, const void *opcode, size_t len,
+			  bp_handler_t handler, void *resume);
 extern int after_bootmem;
 
 #endif /* _ASM_X86_TEXT_PATCHING_H */
diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index ebeac487a20c..b6fb645488be 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -738,7 +738,8 @@ static void do_sync_core(void *info)
 }
 
 static bool bp_patching_in_progress;
-static void *bp_int3_handler, *bp_int3_addr;
+static void *bp_int3_resume, *bp_int3_addr;
+static bp_handler_t bp_int3_handler;
 
 int poke_int3_handler(struct pt_regs *regs)
 {
@@ -746,11 +747,11 @@ int poke_int3_handler(struct pt_regs *regs)
 	 * Having observed our INT3 instruction, we now must observe
 	 * bp_patching_in_progress.
 	 *
-	 * 	in_progress = TRUE		INT3
-	 * 	WMB				RMB
-	 * 	write INT3			if (in_progress)
+	 *	in_progress = TRUE		INT3
+	 *	WMB				RMB
+	 *	write INT3			if (in_progress)
 	 *
-	 * Idem for bp_int3_handler.
+	 * Idem for bp_int3_resume.
 	 */
 	smp_rmb();
 
@@ -760,8 +761,10 @@ int poke_int3_handler(struct pt_regs *regs)
 	if (user_mode(regs) || regs->ip != (unsigned long)bp_int3_addr)
 		return 0;
 
-	/* set up the specified breakpoint handler */
-	regs->ip = (unsigned long) bp_int3_handler;
+	if (bp_int3_handler)
+		bp_int3_handler(regs);
+
+	regs->ip = (unsigned long)bp_int3_resume;
 
 	return 1;
 
@@ -772,7 +775,8 @@ int poke_int3_handler(struct pt_regs *regs)
  * @addr:	address to patch
  * @opcode:	opcode of new instruction
  * @len:	length to copy
- * @handler:	address to jump to when the temporary breakpoint is hit
+ * @handler:	handler to call from int3 context (optional)
+ * @resume:	address to jump to when returning from int3 context
  *
  * Modify multi-byte instruction by using int3 breakpoint on SMP.
  * We completely avoid stop_machine() here, and achieve the
@@ -787,11 +791,13 @@ int poke_int3_handler(struct pt_regs *regs)
  *	  replacing opcode
  *	- sync cores
  */
-void *text_poke_bp(void *addr, const void *opcode, size_t len, void *handler)
+void *text_poke_bp(void *addr, const void *opcode, size_t len,
+		   bp_handler_t handler, void *resume)
 {
 	unsigned char int3 = 0xcc;
 
 	bp_int3_handler = handler;
+	bp_int3_resume = resume;
 	bp_int3_addr = (u8 *)addr + sizeof(int3);
 	bp_patching_in_progress = true;
 
diff --git a/arch/x86/kernel/jump_label.c b/arch/x86/kernel/jump_label.c
index aac0c1f7e354..1a54c5c6d9f3 100644
--- a/arch/x86/kernel/jump_label.c
+++ b/arch/x86/kernel/jump_label.c
@@ -90,7 +90,7 @@ static void __ref __jump_label_transform(struct jump_entry *entry,
 		return;
 	}
 
-	text_poke_bp((void *)jump_entry_code(entry), code, JUMP_LABEL_NOP_SIZE,
+	text_poke_bp((void *)jump_entry_code(entry), code, JUMP_LABEL_NOP_SIZE, NULL,
 		     (void *)jump_entry_code(entry) + JUMP_LABEL_NOP_SIZE);
 }
 
diff --git a/arch/x86/kernel/kprobes/opt.c b/arch/x86/kernel/kprobes/opt.c
index 40b16b270656..5787f48be243 100644
--- a/arch/x86/kernel/kprobes/opt.c
+++ b/arch/x86/kernel/kprobes/opt.c
@@ -446,7 +446,7 @@ void arch_optimize_kprobes(struct list_head *oplist)
 		insn_buf[0] = RELATIVEJUMP_OPCODE;
 		*(s32 *)(&insn_buf[1]) = rel;
 
-		text_poke_bp(op->kp.addr, insn_buf, RELATIVEJUMP_SIZE,
+		text_poke_bp(op->kp.addr, insn_buf, RELATIVEJUMP_SIZE, NULL,
 			     op->optinsn.insn);
 
 		list_del_init(&op->list);
@@ -461,7 +461,7 @@ void arch_unoptimize_kprobe(struct optimized_kprobe *op)
 	/* Set int3 to first byte for kprobes */
 	insn_buf[0] = BREAKPOINT_INSTRUCTION;
 	memcpy(insn_buf + 1, op->optinsn.copied_insn, RELATIVE_ADDR_SIZE);
-	text_poke_bp(op->kp.addr, insn_buf, RELATIVEJUMP_SIZE,
+	text_poke_bp(op->kp.addr, insn_buf, RELATIVEJUMP_SIZE, NULL,
 		     op->optinsn.insn);
 }
 
diff --git a/arch/x86/kernel/static_call.c b/arch/x86/kernel/static_call.c
index d3869295b88d..8fd6c8556750 100644
--- a/arch/x86/kernel/static_call.c
+++ b/arch/x86/kernel/static_call.c
@@ -7,24 +7,19 @@
 
 #define CALL_INSN_SIZE 5
 
-void static_call_bp_handler(void);
-void *bp_handler_dest;
-void *bp_handler_continue;
+unsigned long bp_handler_call_return_addr;
 
-asm(".pushsection .text, \"ax\"						\n"
-    ".globl static_call_bp_handler					\n"
-    ".type static_call_bp_handler, @function				\n"
-    "static_call_bp_handler:						\n"
+static void static_call_bp_handler(struct pt_regs *regs)
+{
 #ifdef CONFIG_HAVE_STATIC_CALL_INLINE
-    ANNOTATE_RETPOLINE_SAFE
-    "call *bp_handler_dest						\n"
-    ANNOTATE_RETPOLINE_SAFE
-    "jmp *bp_handler_continue						\n"
-#else /* !CONFIG_HAVE_STATIC_CALL_INLINE */
-    ANNOTATE_RETPOLINE_SAFE
-    "jmp *bp_handler_dest						\n"
+	/*
+	 * Push the return address on the stack so the "called" function will
+	 * return to immediately after the call site.
+	 */
+	regs->sp -= sizeof(long);
+	*(unsigned long *)regs->sp = bp_handler_call_return_addr;
 #endif
-    ".popsection							\n");
+}
 
 void arch_static_call_transform(void *site, void *tramp, void *func)
 {
@@ -52,14 +47,12 @@ void arch_static_call_transform(void *site, void *tramp, void *func)
 	opcodes[0] = insn_opcode;
 	memcpy(&opcodes[1], &dest_relative, CALL_INSN_SIZE - 1);
 
-	/* Set up the variables for the breakpoint handler: */
-	bp_handler_dest = func;
 	if (IS_ENABLED(CONFIG_HAVE_STATIC_CALL_INLINE))
-		bp_handler_continue = (void *)(insn + CALL_INSN_SIZE);
+		bp_handler_call_return_addr = insn + CALL_INSN_SIZE;
 
 	/* Patch the call site: */
 	text_poke_bp((void *)insn, opcodes, CALL_INSN_SIZE,
-		     static_call_bp_handler);
+		     static_call_bp_handler, func);
 
 done:
 	mutex_unlock(&text_mutex);
