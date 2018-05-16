Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752383AbeEPDat (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 23:30:49 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51588 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752172AbeEPDas (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 23:30:48 -0400
Date: Tue, 15 May 2018 22:30:44 -0500
From: Josh Poimboeuf <jpoimboe@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Alexey Dobriyan <adobriyan@gmail.com>,
        Peter Anvin <h.peter.anvin@intel.com>,
        kernel test robot <xiaolong.ye@intel.com>,
        Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
        Andrew Lutomirski <luto@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Brian Gerst <brgerst@gmail.com>, Denys Vlasenko <dvlasenk@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Anvin <hpa@zytor.com>, tipbuild@zytor.com, LKP <lkp@01.org>
Subject: Re: [lkp-robot] [x86/asm] 51bad67ffb: int3:#[##]
Message-ID: <20180516033044.odb74pdgcn5nacwb@treble>
References: <20180515080033.GA7714@yexl-desktop>
 <20180515210757.GA12225@avx2>
 <C40DC70F50313144AB3AF8625D4F407F90689B42@ORSMSX101.amr.corp.intel.com>
 <20180515214337.GA18021@avx2>
 <20180515222211.ods5hzne46hozojq@treble>
 <CA+55aFw1MxjUKtrt-KyiNxmpuKUY273L5uy8ggzOFjBSYMwwog@mail.gmail.com>
 <20180515224354.zmygmsnlqj5lrdbo@treble>
 <CA+55aFzTpkn_fokmm+ddi+cgk5K3EOftRmPad+NkUb5W2z0Fqg@mail.gmail.com>
 <CA+55aFwrT-BAvdujUonX5MvB=8GFopQJT4x6xMhtjNN2G0AxSw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+55aFwrT-BAvdujUonX5MvB=8GFopQJT4x6xMhtjNN2G0AxSw@mail.gmail.com>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 15, 2018 at 04:05:33PM -0700, Linus Torvalds wrote:
> I wonder if there's some way to add a test for "ENTRY only works in a code
> section"?

I suppose we could add a discardable annotation to the ENTRY macro and
have objtool validate that it's in a text section.  I'm not sure whether
it's worth it, but I could do it if you think it's a good idea.

Below is a tentative objtool patch which catches asm code falling
through to INT3 padding, though objtool is 64-bit only so there won't be
any 32-bit coverage.  It found zero hits on my config.  I'll clean it up
and submit it tomorrow-ish.

diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
index 8344dd2f310a..3ed8cec6e765 100644
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -285,11 +285,9 @@ ENTRY(early_idt_handler_array)
 	.endif
 	pushq $i		# 72(%rsp) Vector number
 	jmp early_idt_handler_common
-	UNWIND_HINT_IRET_REGS
 	i = i + 1
 	.fill early_idt_handler_array + i*EARLY_IDT_HANDLER_SIZE - ., 1, 0xcc
 	.endr
-	UNWIND_HINT_IRET_REGS offset=16
 END(early_idt_handler_array)
 
 early_idt_handler_common:
diff --git a/tools/objtool/arch.h b/tools/objtool/arch.h
index b0d7dc3d71b5..6eb058a8ac00 100644
--- a/tools/objtool/arch.h
+++ b/tools/objtool/arch.h
@@ -33,7 +33,8 @@
 #define INSN_STACK		8
 #define INSN_BUG		9
 #define INSN_NOP		10
-#define INSN_OTHER		11
+#define INSN_PADDING		11
+#define INSN_OTHER		12
 #define INSN_LAST		INSN_OTHER
 
 enum op_dest_type {
diff --git a/tools/objtool/arch/x86/decode.c b/tools/objtool/arch/x86/decode.c
index 7e86a743f851..82b41bb93c02 100644
--- a/tools/objtool/arch/x86/decode.c
+++ b/tools/objtool/arch/x86/decode.c
@@ -421,7 +421,7 @@ int arch_decode_instruction(struct elf *elf, struct section *sec,
 
 	case 0xcc:
 		/* int3: used for asm function padding by the __ALIGN macro */
-		*type = INSN_NOP;
+		*type = INSN_PADDING;
 		break;
 
 	case 0xe3:
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index f4bbce838433..8a83a0d1693a 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -1936,6 +1936,14 @@ static int validate_branch(struct objtool_file *file, struct instruction *first,
 			}
 			return 0;
 
+		case INSN_PADDING:
+			if (!func) {
+				WARN_FUNC("code falls through to INT3 padding",
+					  insn->sec, insn->offset);
+				return 1;
+			}
+			break;
+
 		case INSN_STACK:
 			if (update_insn_state(insn, &state))
 				return 1;
@@ -2032,7 +2040,8 @@ static bool ignore_unreachable_insn(struct instruction *insn)
 {
 	int i;
 
-	if (insn->ignore || insn->type == INSN_NOP)
+	if (insn->ignore || insn->type == INSN_NOP ||
+	    insn->type == INSN_PADDING)
 		return true;
 
 	/*
