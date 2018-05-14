Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752369AbeENWfK (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 18:35:10 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:37392 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752133AbeENWfI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 18:35:08 -0400
X-Google-Smtp-Source: AB8JxZrKNZrSi4guxM9MGZa3/kHBuEksYmY5boyY/X1tlWr7xURssFNwhkRuKjcjDzE1rwZHVMRkJA==
Date: Tue, 15 May 2018 01:35:04 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: jpoimboe@redhat.com, peterz@infradead.org, mingo@kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] objtool: ignore INT3 padding
Message-ID: <20180514223504.GA14804@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

NOP padding doesn't count as unreachable instruction
neither should INT3.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 tools/objtool/arch.h            |    3 ++-
 tools/objtool/arch/x86/decode.c |    4 ++++
 tools/objtool/check.c           |    3 +++
 3 files changed, 9 insertions(+), 1 deletion(-)

--- a/tools/objtool/arch.h
+++ b/tools/objtool/arch.h
@@ -34,7 +34,8 @@
 #define INSN_BUG		9
 #define INSN_NOP		10
 #define INSN_OTHER		11
-#define INSN_LAST		INSN_OTHER
+#define INSN_INT3		12
+#define INSN_LAST		INSN_INT3
 
 enum op_dest_type {
 	OP_DEST_REG,
--- a/tools/objtool/arch/x86/decode.c
+++ b/tools/objtool/arch/x86/decode.c
@@ -440,6 +440,10 @@ int arch_decode_instruction(struct elf *elf, struct section *sec,
 		*type = INSN_CONTEXT_SWITCH;
 		break;
 
+	case 0xcc:
+		*type = INSN_INT3;
+		break;
+
 	case 0xe8:
 		*type = INSN_CALL;
 		break;
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -1998,6 +1998,9 @@ static bool ignore_unreachable_insn(struct instruction *insn)
 
 	if (insn->ignore || insn->type == INSN_NOP)
 		return true;
+	/* Inter-function padding. */
+	if (insn->type == INSN_INT3)
+		return true;
 
 	/*
 	 * Ignore any unused exceptions.  This can happen when a whitelisted
