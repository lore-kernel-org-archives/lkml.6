Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032439AbeBOAjQ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 19:39:16 -0500
Received: from terminus.zytor.com ([198.137.202.136]:41881 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1032245AbeBOAjN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 19:39:13 -0500
Date: Wed, 14 Feb 2018 16:26:40 -0800
From: tip-bot for Josh Poimboeuf <tipbot@zytor.com>
Message-ID: <tip-2b5db66862b95532cb6cca8165ae6eb73633cf85@git.kernel.org>
Cc: luto@kernel.org, torvalds@linux-foundation.org, mingo@kernel.org,
        tglx@linutronix.de, hpa@zytor.com, dvlasenk@redhat.com,
        linux-kernel@vger.kernel.org, bp@alien8.de, peterz@infradead.org,
        arjan@linux.intel.com, brgerst@gmail.com, fengguang.wu@intel.com,
        jpoimboe@redhat.com
Reply-To: tglx@linutronix.de, hpa@zytor.com, dvlasenk@redhat.com,
        linux-kernel@vger.kernel.org, bp@alien8.de,
        torvalds@linux-foundation.org, luto@kernel.org, mingo@kernel.org,
        brgerst@gmail.com, jpoimboe@redhat.com, fengguang.wu@intel.com,
        peterz@infradead.org, arjan@linux.intel.com
In-Reply-To: <0e483379275a42626ba8898117f918e1bf661e40.1518130694.git.jpoimboe@redhat.com>
References: <0e483379275a42626ba8898117f918e1bf661e40.1518130694.git.jpoimboe@redhat.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/pti] x86/debug, objtool: Annotate WARN()-related UD2 as
 reachable
Git-Commit-ID: 2b5db66862b95532cb6cca8165ae6eb73633cf85
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  2b5db66862b95532cb6cca8165ae6eb73633cf85
Gitweb:     https://git.kernel.org/tip/2b5db66862b95532cb6cca8165ae6eb73633cf85
Author:     Josh Poimboeuf <jpoimboe@redhat.com>
AuthorDate: Thu, 8 Feb 2018 17:09:26 -0600
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Thu, 15 Feb 2018 01:15:49 +0100

x86/debug, objtool: Annotate WARN()-related UD2 as reachable

By default, objtool assumes that a UD2 is a dead end.  This is mainly
because GCC 7+ sometimes inserts a UD2 when it detects a divide-by-zero
condition.

Now that WARN() is moving back to UD2, annotate the code after it as
reachable so objtool can follow the code flow.

Reported-by: Borislav Petkov <bp@alien8.de>
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Arjan van de Ven <arjan@linux.intel.com>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Denys Vlasenko <dvlasenk@redhat.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: kbuild test robot <fengguang.wu@intel.com>
Link: http://lkml.kernel.org/r/0e483379275a42626ba8898117f918e1bf661e40.1518130694.git.jpoimboe@redhat.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/include/asm/bug.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/bug.h b/arch/x86/include/asm/bug.h
index 34d99af4..71e6f4bf 100644
--- a/arch/x86/include/asm/bug.h
+++ b/arch/x86/include/asm/bug.h
@@ -77,7 +77,11 @@ do {								\
 	unreachable();						\
 } while (0)
 
-#define __WARN_FLAGS(flags)	_BUG_FLAGS(ASM_UD0, BUGFLAG_WARNING|(flags))
+#define __WARN_FLAGS(flags)					\
+do {								\
+	_BUG_FLAGS(ASM_UD0, BUGFLAG_WARNING|(flags));		\
+	annotate_reachable();					\
+} while (0)
 
 #include <asm-generic/bug.h>
 
