Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1162773AbeCAW7i (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 17:59:38 -0500
Received: from mail-pf0-f194.google.com ([209.85.192.194]:35554 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1162681AbeCAW7h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 17:59:37 -0500
X-Google-Smtp-Source: AG47ELsCSNwOJTa1mfpRRViG+O2SJPK7qtOWgdjD9pcU/m/7gcDws6NSFEWSAcpXuhTRX24BDEcryg==
Date: Thu, 1 Mar 2018 14:59:34 -0800
From: Kees Cook <keescook@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>, Borislav Petkov <bp@alien8.de>,
        Richard Weinberger <richard.weinberger@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: [RESEND][PATCH] bug: Exclude non-BUG/WARN exceptions from
 report_bug()
Message-ID: <20180301225934.GA34350@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit:

  b8347c219649 ("x86/debug: Handle warnings before the notifier chain, to fix KGDB crash")

changed the ordering of fixups, and did not take into account the case of
x86 processing non-WARN() and non-BUG() exceptions. This would lead to
output of a false BUG line with no other information. In the case of
a refcount exception, it would be immediately followed by the refcount
WARN(), producing very strange double-"cut here":

lkdtm: attempting bad refcount_inc() overflow
------------[ cut here ]------------
Kernel BUG at 0000000065f29de5 [verbose debug info unavailable]
------------[ cut here ]------------
refcount_t overflow at lkdtm_REFCOUNT_INC_OVERFLOW+0x6b/0x90 in cat[3065], uid/euid: 0/0
WARNING: CPU: 0 PID: 3065 at kernel/panic.c:657 refcount_error_report+0x9a/0xa4
...

In the prior ordering, exceptions were searched first:

 do_trap_no_signal(struct task_struct *tsk, int trapnr, char *str,
 ...
                if (fixup_exception(regs, trapnr))
                        return 0;

-               if (fixup_bug(regs, trapnr))
-                       return 0;
-

As a result, fixup_bugs()'s is_valid_bugaddr() didn't take into account
needing to search the exception list first, since that had already
happened.

So, instead of searching the exception list twice (once in
is_valid_bugaddr() and then again in fixup_exception()), just add a
simple sanity check to report_bug() that will immediately bail out
if a BUG() (or WARN()) entry is not found.

Fixes: b8347c219649 ("x86/debug: Handle warnings before the notifier chain, to fix KGDB crash")
Cc: stable@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
Resending through akpm since this technically isn't x86-specific.
---
 lib/bug.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/lib/bug.c b/lib/bug.c
index c1b0fad31b10..551e4d405307 100644
--- a/lib/bug.c
+++ b/lib/bug.c
@@ -150,6 +150,8 @@ enum bug_trap_type report_bug(unsigned long bugaddr, struct pt_regs *regs)
 		return BUG_TRAP_TYPE_NONE;
 
 	bug = find_bug(bugaddr);
+	if (!bug)
+		return BUG_TRAP_TYPE_NONE;
 
 	file = NULL;
 	line = 0;
-- 
2.7.4


-- 
Kees Cook
Pixel Security
