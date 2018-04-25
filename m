Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753931AbeDYLOm (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 07:14:42 -0400
Received: from mx2.suse.de ([195.135.220.15]:56981 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754111AbeDYLNx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 07:13:53 -0400
From: Petr Mladek <pmladek@suse.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        "Tobin C . Harding" <me@tobin.cc>, Joe Perches <joe@perches.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.cz>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-kernel@vger.kernel.org, Petr Mladek <pmladek@suse.com>
Subject: [PATCH v5 10/11] vsprintf: WARN() on invalid pointer access
Date: Wed, 25 Apr 2018 13:12:50 +0200
Message-Id: <20180425111251.13246-11-pmladek@suse.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180425111251.13246-1-pmladek@suse.com>
References: <20180425111251.13246-1-pmladek@suse.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

vsprintf puts "(efault)" into the output string when it is unable
to read information from the given address.

But "(efault)" might be hard to spot. And any invalid pointer is likely
to cause problems later. It is reasonable to WARN() about it.

The only problem might be a code that rely on the fact that some
specifiers, e.g. %s, printed (null) for invalid addresses pointing
to the first or the last memory page. Such a behavior should be
avoided. But it is the reason why this change is done in a separate
patch so that it can be easily reverted.

Also we must not trigger WARN_ON() when panic_on_warn() is enabled.
Note that probe_kernel_address() was added to avoid panic() and
a potentially silent crash in printk_safe context.

Finally, we want to avoid WARN() also when testing invalid pointer access
in test_printf module. It would taint kernel and mess the kernel log.

Signed-off-by: Petr Mladek <pmladek@suse.com>
---
 Documentation/core-api/printk-formats.rst | 3 +++
 lib/test_printf.c                         | 7 +++++++
 lib/vsprintf.c                            | 9 ++++++++-
 3 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/Documentation/core-api/printk-formats.rst b/Documentation/core-api/printk-formats.rst
index 7c73bed2fad8..3b25adde1ec7 100644
--- a/Documentation/core-api/printk-formats.rst
+++ b/Documentation/core-api/printk-formats.rst
@@ -57,6 +57,9 @@ might be printed instead of the unreachable information::
 	(null)	 data on plain NULL address
 	(efault) data on invalid address
 
+Also a WARN_ON() is triggered when non-NULL address is not reachable
+and panic_on_warn is disabled.
+
 Plain Pointers
 --------------
 
diff --git a/lib/test_printf.c b/lib/test_printf.c
index 45c33143fb4a..74dff6c44ec6 100644
--- a/lib/test_printf.c
+++ b/lib/test_printf.c
@@ -285,12 +285,19 @@ null_pointer(void)
 
 #define PTR_INVALID ((void *)0x000000ab)
 
+extern int test_printf_pointer_access;
+
 static void __init
 invalid_pointer(void)
 {
+	/* Avoid calling WARN() */
+	test_printf_pointer_access = 1;
+
 	plain(PTR_INVALID);
 	test(ZEROS "000000ab", "%px", PTR_INVALID);
 	test("(efault)", "%pE", PTR_INVALID);
+
+	test_printf_pointer_access = 0;
 }
 
 static void __init
diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index 5dfdc7e11d05..46e3e7c71229 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -610,6 +610,9 @@ static char *valid_string(char *buf, char *end, const char *s,
 	return widen_string(buf, len, end, spec);
 }
 
+int test_printf_pointer_access;
+EXPORT_SYMBOL_GPL(test_printf_pointer_access);
+
  /*
   * This is not a fool-proof test. 99% of the time that this will fault is
   * due to a bad pointer, not one that crosses into bad memory. Just test
@@ -623,8 +626,12 @@ static const char *check_pointer_access(const void *ptr)
 	if (!ptr)
 		return "(null)";
 
-	if (probe_kernel_address(ptr, byte))
+	/* Prevent silent crashes when called in printk_safe context. */
+	if (probe_kernel_address(ptr, byte)) {
+		WARN(!panic_on_warn && !test_printf_pointer_access,
+		     "vsprintf: invalid pointer address\n");
 		return "(efault)";
+	}
 
 	return NULL;
 }
-- 
2.13.6
