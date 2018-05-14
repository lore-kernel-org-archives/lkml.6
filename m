Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932192AbeENNmJ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 09:42:09 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35032 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752366AbeENNmH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 09:42:07 -0400
Date: Mon, 14 May 2018 08:42:05 -0500
From: Josh Poimboeuf <jpoimboe@redhat.com>
To: Jiri Slaby <jslaby@suse.cz>
Cc: mingo@redhat.com, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>,
        x86@kernel.org
Subject: Re: [PATCH 1/2] x86/stacktrace: do not fail when regs on stack for
 ORC
Message-ID: <20180514134205.sbvgxactzwrakbt5@treble>
References: <20171218033749.ihpwkjh7qfnilj4s@treble>
 <20171220174544.g34v2lkjrz2r6kh7@treble>
 <bf832ed0-47f4-2e8c-f320-1f54bce76e5c@suse.cz>
 <20180416221653.bf3or5yarlame3co@treble>
 <20180419134222.truupyqhwcpnhuis@treble>
 <a27a7de0-cc28-cfc8-7d0b-7d284f5d5788@suse.cz>
 <20180510124916.ckgjtgmmcy33ahtd@treble>
 <16f714bb-1a32-9203-39d5-aab927fba6c9@suse.cz>
 <20180511151252.sihxdvl4ip7hjjoc@treble>
 <6931a360-c07e-140d-55d9-b1bb3334e1af@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6931a360-c07e-140d-55d9-b1bb3334e1af@suse.cz>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 14, 2018 at 01:08:40PM +0200, Jiri Slaby wrote:
> On 05/11/2018, 05:12 PM, Josh Poimboeuf wrote:
> > I assume you're going to carry this as
> > part of your patches to enable HAVE_RELIABLE_STACKTRACE?
> 
> Sure.
> 
> > --- a/tools/objtool/orc_dump.c
> > +++ b/tools/objtool/orc_dump.c
> > @@ -203,7 +203,8 @@ int orc_dump(const char *_objname)
> >  
> >  		print_reg(orc[i].bp_reg, orc[i].bp_offset);
> >  
> > -		printf(" type:%s\n", orc_type_name(orc[i].type));
> > +		printf(" type:%s end:%d\n",
> > +		       orc_type_name(orc[i].type), orc[i].end);
> 
> Maybe just " type:%s%s\n" and »orc[i].end ? " END" : ""«?

All those 'end:0' strings are a bit repetitive, but I think that's ok.
'type:call' already has the same issue.  I'd rather keep the formatting
consistent with the rest of the printed variables.

> >  	}
> >  
> >  	elf_end(elf);
> > diff --git a/tools/objtool/orc_gen.c b/tools/objtool/orc_gen.c
> > index 18384d9be4e1..229c12e3fcf6 100644
> > --- a/tools/objtool/orc_gen.c
> > +++ b/tools/objtool/orc_gen.c
> > @@ -86,6 +86,7 @@ int create_orc(struct objtool_file *file)
> >  		orc->sp_offset = cfa->offset;
> >  		orc->bp_offset = bp->offset;
> >  		orc->type = insn->state.type;
> > +		orc->end = insn->state.end;
> 
> So you moved the assignment below of 'if (cfa->base == CFI_UNDEFINED)' –
> this assignment will never happen, as I have just verified.
> 
> --- a/tools/objtool/orc_gen.c
> +++ b/tools/objtool/orc_gen.c
> @@ -31,6 +31,8 @@ int create_orc(struct objtool_file *file)
>                 struct cfi_reg *cfa = &insn->state.cfa;
>                 struct cfi_reg *bp = &insn->state.regs[CFI_BP];
> 
> +               orc->end = insn->state.end;
> +
>                 if (cfa->base == CFI_UNDEFINED) {
>                         orc->sp_reg = ORC_REG_UNDEFINED;
>                         continue;
> @@ -86,7 +88,6 @@ int create_orc(struct objtool_file *file)
>                 orc->sp_offset = cfa->offset;
>                 orc->bp_offset = bp->offset;
>                 orc->type = insn->state.type;
> -               orc->end = insn->state.end;
>         }
> 
>         return 0;

Oops.  How about this one:

From: Josh Poimboeuf <jpoimboe@redhat.com>
Subject: [PATCH v2] x86/unwind/orc: Detect the end of the stack

The existing UNWIND_HINT_EMPTY annotations happen to be good indicators
of where entry code calls into C code for the first time.  So also use
them to mark the end of the stack for the ORC unwinder.

Use that information to set unwind->error if the ORC unwinder doesn't
unwind all the way to the end.  This will be needed for enabling
HAVE_RELIABLE_STACKTRACE for the ORC unwinder so we can use it with the
livepatch consistency model.

Thanks to Jiri Slaby for teaching the ORCs about the unwind hints.

Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 arch/x86/entry/entry_64.S                     |  1 +
 arch/x86/include/asm/orc_types.h              |  2 +
 arch/x86/include/asm/unwind_hints.h           | 16 +++---
 arch/x86/kernel/unwind_orc.c                  | 52 +++++++++++--------
 .../objtool/arch/x86/include/asm/orc_types.h  |  2 +
 tools/objtool/check.c                         |  1 +
 tools/objtool/check.h                         |  2 +-
 tools/objtool/orc_dump.c                      |  3 +-
 tools/objtool/orc_gen.c                       |  2 +
 9 files changed, 52 insertions(+), 29 deletions(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index ab4f451aeb97..e35dbc507425 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -408,6 +408,7 @@ ENTRY(ret_from_fork)
 
 1:
 	/* kernel thread */
+	UNWIND_HINT_EMPTY
 	movq	%r12, %rdi
 	CALL_NOSPEC %rbx
 	/*
diff --git a/arch/x86/include/asm/orc_types.h b/arch/x86/include/asm/orc_types.h
index 9c9dc579bd7d..46f516dd80ce 100644
--- a/arch/x86/include/asm/orc_types.h
+++ b/arch/x86/include/asm/orc_types.h
@@ -88,6 +88,7 @@ struct orc_entry {
 	unsigned	sp_reg:4;
 	unsigned	bp_reg:4;
 	unsigned	type:2;
+	unsigned	end:1;
 } __packed;
 
 /*
@@ -101,6 +102,7 @@ struct unwind_hint {
 	s16		sp_offset;
 	u8		sp_reg;
 	u8		type;
+	u8		end;
 };
 #endif /* __ASSEMBLY__ */
 
diff --git a/arch/x86/include/asm/unwind_hints.h b/arch/x86/include/asm/unwind_hints.h
index bae46fc6b9de..0bcdb1279361 100644
--- a/arch/x86/include/asm/unwind_hints.h
+++ b/arch/x86/include/asm/unwind_hints.h
@@ -26,7 +26,7 @@
  * the debuginfo as necessary.  It will also warn if it sees any
  * inconsistencies.
  */
-.macro UNWIND_HINT sp_reg=ORC_REG_SP sp_offset=0 type=ORC_TYPE_CALL
+.macro UNWIND_HINT sp_reg=ORC_REG_SP sp_offset=0 type=ORC_TYPE_CALL end=0
 #ifdef CONFIG_STACK_VALIDATION
 .Lunwind_hint_ip_\@:
 	.pushsection .discard.unwind_hints
@@ -35,12 +35,14 @@
 		.short \sp_offset
 		.byte \sp_reg
 		.byte \type
+		.byte \end
+		.balign 4
 	.popsection
 #endif
 .endm
 
 .macro UNWIND_HINT_EMPTY
-	UNWIND_HINT sp_reg=ORC_REG_UNDEFINED
+	UNWIND_HINT sp_reg=ORC_REG_UNDEFINED end=1
 .endm
 
 .macro UNWIND_HINT_REGS base=%rsp offset=0 indirect=0 extra=1 iret=0
@@ -86,19 +88,21 @@
 
 #else /* !__ASSEMBLY__ */
 
-#define UNWIND_HINT(sp_reg, sp_offset, type)			\
+#define UNWIND_HINT(sp_reg, sp_offset, type, end)		\
 	"987: \n\t"						\
 	".pushsection .discard.unwind_hints\n\t"		\
 	/* struct unwind_hint */				\
 	".long 987b - .\n\t"					\
-	".short " __stringify(sp_offset) "\n\t"		\
+	".short " __stringify(sp_offset) "\n\t"			\
 	".byte " __stringify(sp_reg) "\n\t"			\
 	".byte " __stringify(type) "\n\t"			\
+	".byte " __stringify(end) "\n\t"			\
+	".balign 4 \n\t"					\
 	".popsection\n\t"
 
-#define UNWIND_HINT_SAVE UNWIND_HINT(0, 0, UNWIND_HINT_TYPE_SAVE)
+#define UNWIND_HINT_SAVE UNWIND_HINT(0, 0, UNWIND_HINT_TYPE_SAVE, 0)
 
-#define UNWIND_HINT_RESTORE UNWIND_HINT(0, 0, UNWIND_HINT_TYPE_RESTORE)
+#define UNWIND_HINT_RESTORE UNWIND_HINT(0, 0, UNWIND_HINT_TYPE_RESTORE, 0)
 
 #endif /* __ASSEMBLY__ */
 
diff --git a/arch/x86/kernel/unwind_orc.c b/arch/x86/kernel/unwind_orc.c
index feb28fee6cea..26038eacf74a 100644
--- a/arch/x86/kernel/unwind_orc.c
+++ b/arch/x86/kernel/unwind_orc.c
@@ -198,7 +198,7 @@ static int orc_sort_cmp(const void *_a, const void *_b)
 	 * whitelisted .o files which didn't get objtool generation.
 	 */
 	orc_a = cur_orc_table + (a - cur_orc_ip_table);
-	return orc_a->sp_reg == ORC_REG_UNDEFINED ? -1 : 1;
+	return orc_a->sp_reg == ORC_REG_UNDEFINED && !orc_a->end ? -1 : 1;
 }
 
 #ifdef CONFIG_MODULES
@@ -352,7 +352,7 @@ static bool deref_stack_iret_regs(struct unwind_state *state, unsigned long addr
 
 bool unwind_next_frame(struct unwind_state *state)
 {
-	unsigned long ip_p, sp, orig_ip, prev_sp = state->sp;
+	unsigned long ip_p, sp, orig_ip = state->ip, prev_sp = state->sp;
 	enum stack_type prev_type = state->stack_info.type;
 	struct orc_entry *orc;
 	bool indirect = false;
@@ -363,9 +363,9 @@ bool unwind_next_frame(struct unwind_state *state)
 	/* Don't let modules unload while we're reading their ORC data. */
 	preempt_disable();
 
-	/* Have we reached the end? */
+	/* End-of-stack check for user tasks: */
 	if (state->regs && user_mode(state->regs))
-		goto done;
+		goto the_end;
 
 	/*
 	 * Find the orc_entry associated with the text address.
@@ -374,9 +374,16 @@ bool unwind_next_frame(struct unwind_state *state)
 	 * calls and calls to noreturn functions.
 	 */
 	orc = orc_find(state->signal ? state->ip : state->ip - 1);
-	if (!orc || orc->sp_reg == ORC_REG_UNDEFINED)
-		goto done;
-	orig_ip = state->ip;
+	if (!orc)
+		goto err;
+
+	/* End-of-stack check for kernel threads: */
+	if (orc->sp_reg == ORC_REG_UNDEFINED) {
+		if (!orc->end)
+			goto err;
+
+		goto the_end;
+	}
 
 	/* Find the previous frame's stack: */
 	switch (orc->sp_reg) {
@@ -402,7 +409,7 @@ bool unwind_next_frame(struct unwind_state *state)
 		if (!state->regs || !state->full_regs) {
 			orc_warn("missing regs for base reg R10 at ip %pB\n",
 				 (void *)state->ip);
-			goto done;
+			goto err;
 		}
 		sp = state->regs->r10;
 		break;
@@ -411,7 +418,7 @@ bool unwind_next_frame(struct unwind_state *state)
 		if (!state->regs || !state->full_regs) {
 			orc_warn("missing regs for base reg R13 at ip %pB\n",
 				 (void *)state->ip);
-			goto done;
+			goto err;
 		}
 		sp = state->regs->r13;
 		break;
@@ -420,7 +427,7 @@ bool unwind_next_frame(struct unwind_state *state)
 		if (!state->regs || !state->full_regs) {
 			orc_warn("missing regs for base reg DI at ip %pB\n",
 				 (void *)state->ip);
-			goto done;
+			goto err;
 		}
 		sp = state->regs->di;
 		break;
@@ -429,7 +436,7 @@ bool unwind_next_frame(struct unwind_state *state)
 		if (!state->regs || !state->full_regs) {
 			orc_warn("missing regs for base reg DX at ip %pB\n",
 				 (void *)state->ip);
-			goto done;
+			goto err;
 		}
 		sp = state->regs->dx;
 		break;
@@ -437,12 +444,12 @@ bool unwind_next_frame(struct unwind_state *state)
 	default:
 		orc_warn("unknown SP base reg %d for ip %pB\n",
 			 orc->sp_reg, (void *)state->ip);
-		goto done;
+		goto err;
 	}
 
 	if (indirect) {
 		if (!deref_stack_reg(state, sp, &sp))
-			goto done;
+			goto err;
 	}
 
 	/* Find IP, SP and possibly regs: */
@@ -451,7 +458,7 @@ bool unwind_next_frame(struct unwind_state *state)
 		ip_p = sp - sizeof(long);
 
 		if (!deref_stack_reg(state, ip_p, &state->ip))
-			goto done;
+			goto err;
 
 		state->ip = ftrace_graph_ret_addr(state->task, &state->graph_idx,
 						  state->ip, (void *)ip_p);
@@ -465,7 +472,7 @@ bool unwind_next_frame(struct unwind_state *state)
 		if (!deref_stack_regs(state, sp, &state->ip, &state->sp)) {
 			orc_warn("can't dereference registers at %p for ip %pB\n",
 				 (void *)sp, (void *)orig_ip);
-			goto done;
+			goto err;
 		}
 
 		state->regs = (struct pt_regs *)sp;
@@ -477,7 +484,7 @@ bool unwind_next_frame(struct unwind_state *state)
 		if (!deref_stack_iret_regs(state, sp, &state->ip, &state->sp)) {
 			orc_warn("can't dereference iret registers at %p for ip %pB\n",
 				 (void *)sp, (void *)orig_ip);
-			goto done;
+			goto err;
 		}
 
 		state->regs = (void *)sp - IRET_FRAME_OFFSET;
@@ -500,18 +507,18 @@ bool unwind_next_frame(struct unwind_state *state)
 
 	case ORC_REG_PREV_SP:
 		if (!deref_stack_reg(state, sp + orc->bp_offset, &state->bp))
-			goto done;
+			goto err;
 		break;
 
 	case ORC_REG_BP:
 		if (!deref_stack_reg(state, state->bp + orc->bp_offset, &state->bp))
-			goto done;
+			goto err;
 		break;
 
 	default:
 		orc_warn("unknown BP base reg %d for ip %pB\n",
 			 orc->bp_reg, (void *)orig_ip);
-		goto done;
+		goto err;
 	}
 
 	/* Prevent a recursive loop due to bad ORC data: */
@@ -520,13 +527,16 @@ bool unwind_next_frame(struct unwind_state *state)
 	    state->sp <= prev_sp) {
 		orc_warn("stack going in the wrong direction? ip=%pB\n",
 			 (void *)orig_ip);
-		goto done;
+		goto err;
 	}
 
 	preempt_enable();
 	return true;
 
-done:
+err:
+	state->error = true;
+
+the_end:
 	preempt_enable();
 	state->stack_info.type = STACK_TYPE_UNKNOWN;
 	return false;
diff --git a/tools/objtool/arch/x86/include/asm/orc_types.h b/tools/objtool/arch/x86/include/asm/orc_types.h
index 9c9dc579bd7d..46f516dd80ce 100644
--- a/tools/objtool/arch/x86/include/asm/orc_types.h
+++ b/tools/objtool/arch/x86/include/asm/orc_types.h
@@ -88,6 +88,7 @@ struct orc_entry {
 	unsigned	sp_reg:4;
 	unsigned	bp_reg:4;
 	unsigned	type:2;
+	unsigned	end:1;
 } __packed;
 
 /*
@@ -101,6 +102,7 @@ struct unwind_hint {
 	s16		sp_offset;
 	u8		sp_reg;
 	u8		type;
+	u8		end;
 };
 #endif /* __ASSEMBLY__ */
 
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 5409f6f6c48d..fef15cea9f1e 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -1109,6 +1109,7 @@ static int read_unwind_hints(struct objtool_file *file)
 
 		cfa->offset = hint->sp_offset;
 		insn->state.type = hint->type;
+		insn->state.end = hint->end;
 	}
 
 	return 0;
diff --git a/tools/objtool/check.h b/tools/objtool/check.h
index c6b68fcb926f..95700a2bcb7c 100644
--- a/tools/objtool/check.h
+++ b/tools/objtool/check.h
@@ -31,7 +31,7 @@ struct insn_state {
 	int stack_size;
 	unsigned char type;
 	bool bp_scratch;
-	bool drap;
+	bool drap, end;
 	int drap_reg, drap_offset;
 	struct cfi_reg vals[CFI_NUM_REGS];
 };
diff --git a/tools/objtool/orc_dump.c b/tools/objtool/orc_dump.c
index c3343820916a..faa444270ee3 100644
--- a/tools/objtool/orc_dump.c
+++ b/tools/objtool/orc_dump.c
@@ -203,7 +203,8 @@ int orc_dump(const char *_objname)
 
 		print_reg(orc[i].bp_reg, orc[i].bp_offset);
 
-		printf(" type:%s\n", orc_type_name(orc[i].type));
+		printf(" type:%s end:%d\n",
+		       orc_type_name(orc[i].type), orc[i].end);
 	}
 
 	elf_end(elf);
diff --git a/tools/objtool/orc_gen.c b/tools/objtool/orc_gen.c
index 18384d9be4e1..3f98dcfbc177 100644
--- a/tools/objtool/orc_gen.c
+++ b/tools/objtool/orc_gen.c
@@ -31,6 +31,8 @@ int create_orc(struct objtool_file *file)
 		struct cfi_reg *cfa = &insn->state.cfa;
 		struct cfi_reg *bp = &insn->state.regs[CFI_BP];
 
+		orc->end = insn->state.end;
+
 		if (cfa->base == CFI_UNDEFINED) {
 			orc->sp_reg = ORC_REG_UNDEFINED;
 			continue;
-- 
2.17.0
