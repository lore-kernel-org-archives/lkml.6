Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751275AbeDDI7a (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 04:59:30 -0400
Received: from mx2.suse.de ([195.135.220.15]:34542 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751216AbeDDI73 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 04:59:29 -0400
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
Subject: [PATCH v4 2/9] vsprintf: Consistent %pK handling for kptr_restrict == 0
Date: Wed,  4 Apr 2018 10:58:36 +0200
Message-Id: <20180404085843.16050-3-pmladek@suse.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180404085843.16050-1-pmladek@suse.com>
References: <20180404085843.16050-1-pmladek@suse.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

restricted_pointer() pretends that it prints the address when kptr_restrict
is set to zero. But it is never called in this situation. Instead,
pointer() falls back to ptr_to_id() and hashes the pointer.

This patch removes the potential confusion. klp_restrict is checked only
in restricted_pointer().

It should actually fix a small race when the address might get printed
unhashed:

CPU0                            CPU1

pointer()
  if (!kptr_restrict)
     /* for example set to 2 */
  restricted_pointer()
				/* echo 0 >/proc/sys/kernel/kptr_restrict */
				proc_dointvec_minmax_sysadmin()
				  klpr_restrict = 0;
    switch(kptr_restrict)
      case 0:
	break:

    number()

Fixes: commit ef0010a30935de4e0211 ("vsprintf: don't use 'restricted_pointer()' when not restricting")
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Tobin Harding <me@tobin.cc>
Cc: Kees Cook <keescook@chromium.org>
Signed-off-by: Petr Mladek <pmladek@suse.com>
---
 lib/vsprintf.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index c0c677c6a833..9ade2c4f21ba 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -637,7 +637,8 @@ static int __init initialize_ptr_random(void)
 early_initcall(initialize_ptr_random);
 
 /* Maps a pointer to a 32 bit unique identifier. */
-static char *ptr_to_id(char *buf, char *end, void *ptr, struct printf_spec spec)
+static char *ptr_to_id(char *buf, char *end,
+		       const void *ptr, struct printf_spec spec)
 {
 	unsigned long hashval;
 	const int default_width = 2 * sizeof(ptr);
@@ -1426,8 +1427,8 @@ char *restricted_pointer(char *buf, char *end, const void *ptr,
 
 	switch (kptr_restrict) {
 	case 0:
-		/* Always print %pK values */
-		break;
+		/* Handle as %p, hash and do _not_ leak addresses. */
+		return ptr_to_id(buf, end, ptr, spec);
 	case 1: {
 		const struct cred *cred;
 
@@ -1931,8 +1932,6 @@ char *pointer(const char *fmt, char *buf, char *end, void *ptr,
 			return buf;
 		}
 	case 'K':
-		if (!kptr_restrict)
-			break;
 		return restricted_pointer(buf, end, ptr, spec);
 	case 'N':
 		return netdev_bits(buf, end, ptr, fmt);
-- 
2.13.6
