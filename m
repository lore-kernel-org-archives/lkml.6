Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754331AbeDYLOG (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 07:14:06 -0400
Received: from mx2.suse.de ([195.135.220.15]:56968 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754130AbeDYLNy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 07:13:54 -0400
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
Subject: [PATCH v5 11/11] vsprintf: Avoid confusion between invalid address and value
Date: Wed, 25 Apr 2018 13:12:51 +0200
Message-Id: <20180425111251.13246-12-pmladek@suse.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180425111251.13246-1-pmladek@suse.com>
References: <20180425111251.13246-1-pmladek@suse.com>
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
 lib/vsprintf.c                            | 3 +--
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/core-api/printk-formats.rst b/Documentation/core-api/printk-formats.rst
index 3b25adde1ec7..e1a0ef2179f0 100644
--- a/Documentation/core-api/printk-formats.rst
+++ b/Documentation/core-api/printk-formats.rst
@@ -56,6 +56,7 @@ might be printed instead of the unreachable information::
 
 	(null)	 data on plain NULL address
 	(efault) data on invalid address
+	(einval) invalid data on a valid address
 
 Also a WARN_ON() is triggered when non-NULL address is not reachable
 and panic_on_warn is disabled.
diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index 46e3e7c71229..79ee96afd538 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -1473,8 +1473,7 @@ char *ip_addr_string(char *buf, char *end, void *ptr, struct printf_spec spec,
 		case AF_INET6:
 			return ip6_addr_string_sa(buf, end, &sa->v6, spec, fmt);
 		default:
-			return valid_string(buf, end, "(invalid address)",
-					    spec);
+			return valid_string(buf, end, "(einval)", spec);
 		}}
 	}
 
-- 
2.13.6
