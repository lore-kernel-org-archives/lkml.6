Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752091AbeFCMa7 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 3 Jun 2018 08:30:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:54990 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751852AbeFCM2b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jun 2018 08:28:31 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Josh Poimboeuf <jpoimboe@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 23/29] objtool: Detect RIP-relative switch table references
Date: Sun,  3 Jun 2018 14:26:46 +0200
Message-Id: <20180603122652.17453-24-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180603122652.17453-1-gregkh@linuxfoundation.org>
References: <20180603122652.17453-1-gregkh@linuxfoundation.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
 tools/objtool/check.c | 33 ++++++++++++++++++---------------
 1 file changed, 18 insertions(+), 15 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 063afbdec42d..27c79e4d274c 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -898,24 +898,24 @@ static struct rela *find_switch_table(struct objtool_file *file,
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
 
@@ -949,18 +949,21 @@ static struct rela *find_switch_table(struct objtool_file *file,
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
-			continue;
-
-		rodata_rela = find_rela_by_dest(file->rodata, text_rela->addend);
-		if (!rodata_rela)
+		if (find_symbol_containing(file->rodata, table_offset))
 			continue;
 
-		return rodata_rela;
+		/* mov [rodata addr], %reg */
+		rodata_rela = find_rela_by_dest(file->rodata, table_offset);
+		if (rodata_rela)
+			return rodata_rela;
 	}
 
 	return NULL;
-- 
2.17.1
