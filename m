Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752522AbeFDHAJ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 03:00:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:52956 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752481AbeFDHAB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 03:00:01 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 4.9 23/29] objtool: Detect RIP-relative switch table references
Date: Mon,  4 Jun 2018 08:58:19 +0200
Message-Id: <20180604065803.083869458@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180604065802.157744637@linuxfoundation.org>
References: <20180604065802.157744637@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Josh Poimboeuf <jpoimboe@redhat.com>

commit 6f5ec2993b1f39aed12fa6fd56e8dc2272ee8a33 upstream.

Typically a switch table can be found by detecting a .rodata access
followed an indirect jump:

    1969:	4a 8b 0c e5 00 00 00 	mov    0x0(,%r12,8),%rcx
    1970:	00
			196d: R_X86_64_32S	.rodata+0x438
    1971:	e9 00 00 00 00       	jmpq   1976 <dispc_runtime_suspend+0xb6a>
			1972: R_X86_64_PC32	__x86_indirect_thunk_rcx-0x4

Randy Dunlap reported a case (seen with GCC 4.8) where the .rodata
access uses RIP-relative addressing:

    19bd:	48 8b 3d 00 00 00 00 	mov    0x0(%rip),%rdi        # 19c4 <dispc_runtime_suspend+0xbb8>
			19c0: R_X86_64_PC32	.rodata+0x45c
    19c4:	e9 00 00 00 00       	jmpq   19c9 <dispc_runtime_suspend+0xbbd>
			19c5: R_X86_64_PC32	__x86_indirect_thunk_rdi-0x4

In this case the relocation addend needs to be adjusted accordingly in
order to find the location of the switch table.

The fix is for case 3 (as described in the comments), but also make the
existing case 1 & 2 checks more precise by only adjusting the addend for
R_X86_64_PC32 relocations.

This fixes the following warnings:

  drivers/video/fbdev/omap2/omapfb/dss/dispc.o: warning: objtool: dispc_runtime_suspend()+0xbb8: sibling call from callable instruction with modified stack frame
  drivers/video/fbdev/omap2/omapfb/dss/dispc.o: warning: objtool: dispc_runtime_resume()+0xcc5: sibling call from callable instruction with modified stack frame

Reported-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/b6098294fd67afb69af8c47c9883d7a68bf0f8ea.1526305958.git.jpoimboe@redhat.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 tools/objtool/check.c |   33 ++++++++++++++++++---------------
 1 file changed, 18 insertions(+), 15 deletions(-)

--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -898,24 +898,24 @@ static struct rela *find_switch_table(st
 {
 	struct rela *text_rela, *rodata_rela;
 	struct instruction *orig_insn = insn;
+	unsigned long table_offset;
 
+	/* case 1 & 2 */
 	text_rela = find_rela_by_dest_range(insn->sec, insn->offset, insn->len);
 	if (text_rela && text_rela->sym == file->rodata->sym &&
 	    !find_symbol_containing(file->rodata, text_rela->addend)) {
 
-		/* case 1 */
-		rodata_rela = find_rela_by_dest(file->rodata,
-						text_rela->addend);
-		if (rodata_rela)
-			return rodata_rela;
+		table_offset = text_rela->addend;
+		if (text_rela->type == R_X86_64_PC32) {
+			/* case 2 */
+			table_offset += 4;
+			file->ignore_unreachables = true;
+		}
 
-		/* case 2 */
-		rodata_rela = find_rela_by_dest(file->rodata,
-						text_rela->addend + 4);
+		rodata_rela = find_rela_by_dest(file->rodata, table_offset);
 		if (!rodata_rela)
 			return NULL;
 
-		file->ignore_unreachables = true;
 		return rodata_rela;
 	}
 
@@ -949,18 +949,21 @@ static struct rela *find_switch_table(st
 		if (!text_rela || text_rela->sym != file->rodata->sym)
 			continue;
 
+		table_offset = text_rela->addend;
+		if (text_rela->type == R_X86_64_PC32)
+			table_offset += 4;
+
 		/*
 		 * Make sure the .rodata address isn't associated with a
 		 * symbol.  gcc jump tables are anonymous data.
 		 */
-		if (find_symbol_containing(file->rodata, text_rela->addend))
+		if (find_symbol_containing(file->rodata, table_offset))
 			continue;
 
-		rodata_rela = find_rela_by_dest(file->rodata, text_rela->addend);
-		if (!rodata_rela)
-			continue;
-
-		return rodata_rela;
+		/* mov [rodata addr], %reg */
+		rodata_rela = find_rela_by_dest(file->rodata, table_offset);
+		if (rodata_rela)
+			return rodata_rela;
 	}
 
 	return NULL;
