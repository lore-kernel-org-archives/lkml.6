Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x225ANrBrcCBSy2L07AKdp9JqAGAyK+wC+/uNc/LQUmWB1Y8Xj0hzyspLPPu4yFpeKV2cDBTj
ARC-Seal: i=1; a=rsa-sha256; t=1518709077; cv=none;
        d=google.com; s=arc-20160816;
        b=aL2j+mEfwLOPIr05ie02keVrZ2NoNEz5AcSuIUmcyBX54maAOqI8VTVfQx1pPzwhHO
         YDz38KR+PXxubBDFQOLZ148Arv9qgq7c+9ioshghsFTuaGCLV/VemhN7+c5MP0Ji0xqz
         /tyKRl8bQJ25kP5XY6AxUoxjHCwLoXrXpmPg/ZrnDEqFqE+t+T3yJvSxm4v3B5Km27xo
         8dMk8U3XA2T+UYUlFFUIrTQenkAi8XITsDb+B4W/AKGzCDpUVakWNTDJczk+KyP9R3iZ
         bk1qKIlQ4jB0Qasz7Bc865W1yqzoL1GX2/jnZfIxMm0HNH0h7BHvvrhzSKsrITO+pCSW
         g1dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=/7lRRWHgUFeOvC/2idh36xF/NLGFvdO7V25JRsbieD8=;
        b=jo27etiXNY/eM9jT7OJwmyKJUMMFx30TV9gnxqVuP3MCJWmlfjVlOX/GcYb/DJLp+e
         CbuAvcdqtPR7eBycnp5Mb3DjI8biru71Bp46heM69Ca3v+byvzP5o4OwQ/jdjQnV9Ck0
         fhVdX6eLjMTO9PhaZnfxwlYv75FqvN2iDcQIpTAtiK3RFjl4g/21zycmPvzS9R6pEblJ
         02Ow3jKURSTBOo4L/IBglmL1RQdpL0c9Vns72c+C/znSXxz9ua3C9PWLgfnyr5px84ey
         6KcOjcAFq3Ly/Vsfuid8U8ofGueFHoP0awSCbleGOe38/O8oINdyIdPj2KBf0gNZx32+
         9lZQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Josh Poimboeuf <jpoimboe@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 4.14 183/195] objtool: Fix switch-table detection
Date: Thu, 15 Feb 2018 16:17:54 +0100
Message-Id: <20180215151715.411955917@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151705.738773577@linuxfoundation.org>
References: <20180215151705.738773577@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592481890062626260?=
X-GMAIL-MSGID: =?utf-8?q?1592481890062626260?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Peter Zijlstra <peterz@infradead.org>

commit 99ce7962d52d1948ad6f2785e308d48e76e0a6ef upstream.

Linus reported that GCC-7.3 generated a switch-table construct that
confused objtool. It turns out that, in particular due to KASAN, it is
possible to have unrelated .rodata usage in between the .rodata setup
for the switch-table and the following indirect jump.

The simple linear reverse search from the indirect jump would hit upon
the KASAN .rodata usage first and fail to find a switch_table,
resulting in a spurious 'sibling call with modified stack frame'
warning.

Fix this by creating a 'jump-stack' which we can 'unwind' during
reversal, thereby skipping over much of the in-between code.

This is not fool proof by any means, but is sufficient to make the
known cases work. Future work would be to construct more comprehensive
flow analysis code.

Reported-and-tested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/20180208130232.GF25235@hirez.programming.kicks-ass.net
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 tools/objtool/check.c |   41 +++++++++++++++++++++++++++++++++++++++--
 tools/objtool/check.h |    1 +
 2 files changed, 40 insertions(+), 2 deletions(-)

--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -851,8 +851,14 @@ static int add_switch_table(struct objto
  *    This is a fairly uncommon pattern which is new for GCC 6.  As of this
  *    writing, there are 11 occurrences of it in the allmodconfig kernel.
  *
+ *    As of GCC 7 there are quite a few more of these and the 'in between' code
+ *    is significant. Esp. with KASAN enabled some of the code between the mov
+ *    and jmpq uses .rodata itself, which can confuse things.
+ *
  *    TODO: Once we have DWARF CFI and smarter instruction decoding logic,
  *    ensure the same register is used in the mov and jump instructions.
+ *
+ *    NOTE: RETPOLINE made it harder still to decode dynamic jumps.
  */
 static struct rela *find_switch_table(struct objtool_file *file,
 				      struct symbol *func,
@@ -874,12 +880,25 @@ static struct rela *find_switch_table(st
 						text_rela->addend + 4);
 		if (!rodata_rela)
 			return NULL;
+
 		file->ignore_unreachables = true;
 		return rodata_rela;
 	}
 
 	/* case 3 */
-	func_for_each_insn_continue_reverse(file, func, insn) {
+	/*
+	 * Backward search using the @first_jump_src links, these help avoid
+	 * much of the 'in between' code. Which avoids us getting confused by
+	 * it.
+	 */
+	for (insn = list_prev_entry(insn, list);
+
+	     &insn->list != &file->insn_list &&
+	     insn->sec == func->sec &&
+	     insn->offset >= func->offset;
+
+	     insn = insn->first_jump_src ?: list_prev_entry(insn, list)) {
+
 		if (insn->type == INSN_JUMP_DYNAMIC)
 			break;
 
@@ -909,14 +928,32 @@ static struct rela *find_switch_table(st
 	return NULL;
 }
 
+
 static int add_func_switch_tables(struct objtool_file *file,
 				  struct symbol *func)
 {
-	struct instruction *insn, *prev_jump = NULL;
+	struct instruction *insn, *last = NULL, *prev_jump = NULL;
 	struct rela *rela, *prev_rela = NULL;
 	int ret;
 
 	func_for_each_insn(file, func, insn) {
+		if (!last)
+			last = insn;
+
+		/*
+		 * Store back-pointers for unconditional forward jumps such
+		 * that find_switch_table() can back-track using those and
+		 * avoid some potentially confusing code.
+		 */
+		if (insn->type == INSN_JUMP_UNCONDITIONAL && insn->jump_dest &&
+		    insn->offset > last->offset &&
+		    insn->jump_dest->offset > insn->offset &&
+		    !insn->jump_dest->first_jump_src) {
+
+			insn->jump_dest->first_jump_src = insn;
+			last = insn->jump_dest;
+		}
+
 		if (insn->type != INSN_JUMP_DYNAMIC)
 			continue;
 
--- a/tools/objtool/check.h
+++ b/tools/objtool/check.h
@@ -47,6 +47,7 @@ struct instruction {
 	bool alt_group, visited, dead_end, ignore, hint, save, restore, ignore_alts;
 	struct symbol *call_dest;
 	struct instruction *jump_dest;
+	struct instruction *first_jump_src;
 	struct list_head alts;
 	struct symbol *func;
 	struct stack_op stack_op;
