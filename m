Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751443AbeDDI7l (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 04:59:41 -0400
Received: from mx2.suse.de ([195.135.220.15]:34609 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751413AbeDDI7j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 04:59:39 -0400
From: Petr Mladek <pmladek@suse.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        "Tobin C . Harding" <me@tobin.cc>, Joe Perches <joe@perches.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.cz>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-kernel@vger.kernel.org, Petr Mladek <pmladek@suse.com>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH v4 7/9] vsprintf: Factor out %pO handler as kobject_string()
Date: Wed,  4 Apr 2018 10:58:41 +0200
Message-Id: <20180404085843.16050-8-pmladek@suse.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180404085843.16050-1-pmladek@suse.com>
References: <20180404085843.16050-1-pmladek@suse.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move code from the long pointer() function. We are going to add a check for
the access to the address that will make it even more complicated.

Also it is better to warn about unknown specifier instead of falling
back to the %p behavior. It will help people to understand what is
going wrong. They expect some device node names and not a pointer
in this situation.

In fact, this avoids leaking the address when invalid %pO format
specifier is used. The old code fallen back to printing the
non-hashed value.

Fixes: commit 7b1924a1d930eb27f ("vsprintf: add printk specifier %px")
Signed-off-by: Petr Mladek <pmladek@suse.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Tobin Harding <me@tobin.cc>
Cc: Kees Cook <keescook@chromium.org>
---
 lib/vsprintf.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index f20eaa3f0092..3551b7957d9e 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -1772,6 +1772,19 @@ char *device_node_string(char *buf, char *end, struct device_node *dn,
 }
 
 static noinline_for_stack
+char *kobject_string(char *buf, char *end, void *ptr,
+		     struct printf_spec spec, const char *fmt)
+{
+	switch (fmt[1]) {
+	case 'F':
+		return device_node_string(buf, end, ptr, spec, fmt + 1);
+	}
+
+	WARN_ONCE(1, "Unsupported pointer format specifier: %%pO%c\n", fmt[1]);
+	return buf;
+}
+
+static noinline_for_stack
 char *pointer_string(char *buf, char *end, const void *ptr,
 		     struct printf_spec spec)
 {
@@ -1982,10 +1995,7 @@ char *pointer(const char *fmt, char *buf, char *end, void *ptr,
 	case 'G':
 		return flags_string(buf, end, ptr, fmt);
 	case 'O':
-		switch (fmt[1]) {
-		case 'F':
-			return device_node_string(buf, end, ptr, spec, fmt + 1);
-		}
+		return kobject_string(buf, end, ptr, spec, fmt);
 	case 'x':
 		return pointer_string(buf, end, ptr, spec);
 	}
-- 
2.13.6
