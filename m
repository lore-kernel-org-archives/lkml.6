Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02367C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 16:11:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C148F206A2
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 16:10:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="Aa5XnttE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388209AbeLQQK6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 11:10:58 -0500
Received: from conuserg-07.nifty.com ([210.131.2.74]:64878 "EHLO
        conuserg-07.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727841AbeLQQKy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 11:10:54 -0500
Received: from grover.tkatk1.zaq.ne.jp (zaqdadce369.zaq.ne.jp [218.220.227.105]) (authenticated)
        by conuserg-07.nifty.com with ESMTP id wBHG3bRe008119;
        Tue, 18 Dec 2018 01:03:40 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com wBHG3bRe008119
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1545062621;
        bh=1OFuCwKdWclDokp4HuH6tNSQ6qZ1JvrJw7BVa4cUhdc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Aa5XnttEaP0u87mkoYRbDobvtL9zWX6FMR7V5pC4wzQSegovxMFNURtB0DPvIRwAT
         /qz1BwVUAj9dQ+hpXCO401fOoPGzDISU9OHQpWhSoxTx8DLVznFePYMiaxITsh035O
         /vJj0KZJZQNf0WRfT9crTwlzplyVDR6mv+34YtiRUdExcswaKwQgooU7y4iH9whNx+
         f+his9eQTy8QimfffPkmCDaGeDleMiAqpLwSGmM21+Ve5SnjdFdWho3cCXNH49wTcg
         Wc7QbePYfUOBbXKvKOLNAUi2JRq9fwvGWE/D1SZo5peh10gd6DnQ1+s2zjF28HIC9v
         BagTcdX1sGEBA==
X-Nifty-SrcIP: [218.220.227.105]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>
Cc:     Richard Biener <rguenther@suse.de>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Juergen Gross <jgross@suse.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Nadav Amit <namit@vmware.com>
Subject: [PATCH v3 01/12] Revert "x86/jump-labels: Macrofy inline assembly code to work around GCC inlining bugs"
Date:   Tue, 18 Dec 2018 01:03:16 +0900
Message-Id: <1545062607-8599-2-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1545062607-8599-1-git-send-email-yamada.masahiro@socionext.com>
References: <1545062607-8599-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This partially reverts commit 5bdcd510c2ac9efaf55c4cbd8d46421d8e2320cd.

The in-kernel workarounds will be replaced with GCC's new
"asm inline" syntax.

Only the asm_volatile_goto parts were reverted.

The other cleanups (removal of unneeded #error, replacement of
STATIC_JUMP_IF_TRUE/FALSE with STATIC_JUMP_IF_NOP/JMP) are kept.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/x86/include/asm/jump_label.h | 22 +++++++++++++++++-----
 arch/x86/kernel/macros.S          |  1 -
 2 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/jump_label.h b/arch/x86/include/asm/jump_label.h
index a5fb34f..cf88ebf 100644
--- a/arch/x86/include/asm/jump_label.h
+++ b/arch/x86/include/asm/jump_label.h
@@ -20,9 +20,15 @@
 
 static __always_inline bool arch_static_branch(struct static_key *key, bool branch)
 {
-	asm_volatile_goto("STATIC_BRANCH_NOP l_yes=\"%l[l_yes]\" key=\"%c0\" "
-			  "branch=\"%c1\""
-			: :  "i" (key), "i" (branch) : : l_yes);
+	asm_volatile_goto("1:"
+		".byte " __stringify(STATIC_KEY_INIT_NOP) "\n\t"
+		".pushsection __jump_table,  \"aw\" \n\t"
+		_ASM_ALIGN "\n\t"
+		".long 1b - ., %l[l_yes] - . \n\t"
+		_ASM_PTR "%c0 + %c1 - .\n\t"
+		".popsection \n\t"
+		: :  "i" (key), "i" (branch) : : l_yes);
+
 	return false;
 l_yes:
 	return true;
@@ -30,8 +36,14 @@ static __always_inline bool arch_static_branch(struct static_key *key, bool bran
 
 static __always_inline bool arch_static_branch_jump(struct static_key *key, bool branch)
 {
-	asm_volatile_goto("STATIC_BRANCH_JMP l_yes=\"%l[l_yes]\" key=\"%c0\" "
-			  "branch=\"%c1\""
+	asm_volatile_goto("1:"
+		".byte 0xe9\n\t .long %l[l_yes] - 2f\n\t"
+		"2:\n\t"
+		".pushsection __jump_table,  \"aw\" \n\t"
+		_ASM_ALIGN "\n\t"
+		".long 1b - ., %l[l_yes] - . \n\t"
+		_ASM_PTR "%c0 + %c1 - .\n\t"
+		".popsection \n\t"
 		: :  "i" (key), "i" (branch) : : l_yes);
 
 	return false;
diff --git a/arch/x86/kernel/macros.S b/arch/x86/kernel/macros.S
index 161c950..bf8b9c9 100644
--- a/arch/x86/kernel/macros.S
+++ b/arch/x86/kernel/macros.S
@@ -13,4 +13,3 @@
 #include <asm/paravirt.h>
 #include <asm/asm.h>
 #include <asm/cpufeature.h>
-#include <asm/jump_label.h>
-- 
2.7.4

