Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751602AbeDDI74 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 04:59:56 -0400
Received: from mx2.suse.de ([195.135.220.15]:34647 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751413AbeDDI7n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 04:59:43 -0400
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
        linux-kernel@vger.kernel.org, Petr Mladek <pmladek@suse.com>
Subject: [PATCH v4 9/9] vsprintf: Avoid confusion between invalid address and value
Date: Wed,  4 Apr 2018 10:58:43 +0200
Message-Id: <20180404085843.16050-10-pmladek@suse.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180404085843.16050-1-pmladek@suse.com>
References: <20180404085843.16050-1-pmladek@suse.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We are able to detect invalid values handled by %p[iI] printk specifier.
The current error message is "invalid address". It might cause confusion
against "(efault)" reported by the generic valid_pointer_address() check.

Let's unify the style and use the more appropriate error code description
"(einval)".

Signed-off-by: Petr Mladek <pmladek@suse.com>
---
 Documentation/core-api/printk-formats.rst | 1 +
 lib/vsprintf.c                            | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/core-api/printk-formats.rst b/Documentation/core-api/printk-formats.rst
index dc020087b12a..974af53e9b43 100644
--- a/Documentation/core-api/printk-formats.rst
+++ b/Documentation/core-api/printk-formats.rst
@@ -56,6 +56,7 @@ might be printed instead of the unreachable information::
 
 	(null)	 data on plain NULL address
 	(efault) data on invalid address
+	(einval) invalid data on a valid address
 
 Plain Pointers
 --------------
diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index 1a080a75a825..4fcd4ce91d32 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -1395,7 +1395,7 @@ char *ip_addr_string(char *buf, char *end, void *ptr, struct printf_spec spec,
 		case AF_INET6:
 			return ip6_addr_string_sa(buf, end, &sa->v6, spec, fmt);
 		default:
-			return __string(buf, end, "(invalid address)", spec);
+			return __string(buf, end, "(einval)", spec);
 		}}
 	}
 
-- 
2.13.6
