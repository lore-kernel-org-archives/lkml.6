Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751888AbeBYQy0 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 25 Feb 2018 11:54:26 -0500
Received: from mail-pl0-f68.google.com ([209.85.160.68]:44742 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751670AbeBYQyW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Feb 2018 11:54:22 -0500
X-Google-Smtp-Source: AH8x2265hA+iPdSLQcBOcn5vEtBjImc+QZhH6y4cUcRvs5cLqXYy9hmj8FHeOWr0i/73YEzok1xWew==
Date: Sun, 25 Feb 2018 08:54:20 -0800
From: Kees Cook <keescook@chromium.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>, Borislav Petkov <bp@alien8.de>,
        Richard Weinberger <richard.weinberger@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] bug: Use %pB in BUG and stack protector failure
Message-ID: <20180225165420.GA11879@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The BUG and stack protector reports were still using a raw %p. This
changes it to %pB for more meaningful output.

Fixes: ad67b74d2469 ("printk: hash addresses printed with %p")
Cc: stable@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 kernel/panic.c | 2 +-
 lib/bug.c      | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/panic.c b/kernel/panic.c
index 2cfef408fec9..4b794f1d8561 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -640,7 +640,7 @@ device_initcall(register_warn_debugfs);
  */
 __visible void __stack_chk_fail(void)
 {
-	panic("stack-protector: Kernel stack is corrupted in: %p\n",
+	panic("stack-protector: Kernel stack is corrupted in: %pB\n",
 		__builtin_return_address(0));
 }
 EXPORT_SYMBOL(__stack_chk_fail);
diff --git a/lib/bug.c b/lib/bug.c
index 551e4d405307..1077366f496b 100644
--- a/lib/bug.c
+++ b/lib/bug.c
@@ -193,7 +193,7 @@ enum bug_trap_type report_bug(unsigned long bugaddr, struct pt_regs *regs)
 	if (file)
 		pr_crit("kernel BUG at %s:%u!\n", file, line);
 	else
-		pr_crit("Kernel BUG at %p [verbose debug info unavailable]\n",
+		pr_crit("Kernel BUG at %pB [verbose debug info unavailable]\n",
 			(void *)bugaddr);
 
 	return BUG_TRAP_TYPE_BUG;
-- 
2.7.4


-- 
Kees Cook
Pixel Security
