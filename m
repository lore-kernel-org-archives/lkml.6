Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752228AbeBHXKC (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 18:10:02 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56764 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752159AbeBHXJ7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 18:09:59 -0500
From: Josh Poimboeuf <jpoimboe@redhat.com>
To: x86@kernel.org
Cc: Borislav Petkov <bp@alien8.de>, Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        kbuild test robot <fengguang.wu@intel.com>,
        Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, Arjan van de Ven <arjan@linux.intel.com>
Subject: [PATCH 2/2] x86: Annotate WARN-related UD2 as reachable
Date: Thu,  8 Feb 2018 17:09:26 -0600
Message-Id: <0e483379275a42626ba8898117f918e1bf661e40.1518130694.git.jpoimboe@redhat.com>
In-Reply-To: <cover.1518130694.git.jpoimboe@redhat.com>
References: <20180208203146.GF577@pd.tnic> <cover.1518130694.git.jpoimboe@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

By default, objtool assumes that a UD2 is a dead end.  This is mainly
because GCC 7+ sometimes inserts a UD2 when it detects a divide-by-zero
condition.

Now that WARN() is moving back to UD2, annotate the code after it as
reachable so objtool can follow the code flow.

Reported-by: Borislav Petkov <bp@alien8.de>
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 arch/x86/include/asm/bug.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/bug.h b/arch/x86/include/asm/bug.h
index f2da5fc90e5c..697d89d6fa76 100644
--- a/arch/x86/include/asm/bug.h
+++ b/arch/x86/include/asm/bug.h
@@ -74,7 +74,11 @@ do {								\
 	unreachable();						\
 } while (0)
 
-#define __WARN_FLAGS(flags)	_BUG_FLAGS(ASM_UD2, BUGFLAG_WARNING|(flags))
+#define __WARN_FLAGS(flags)					\
+do {								\
+	_BUG_FLAGS(ASM_UD2, BUGFLAG_WARNING|(flags));		\
+	annotate_reachable();					\
+} while (0)
 
 #include <asm-generic/bug.h>
 
-- 
2.14.3
