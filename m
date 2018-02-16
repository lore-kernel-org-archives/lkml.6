Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750880AbeBPVHS (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 16:07:18 -0500
Received: from mga12.intel.com ([192.55.52.136]:28372 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750727AbeBPVHQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 16:07:16 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,520,1511856000";
   d="scan'208";a="35372227"
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "Tobin C . Harding" <me@tobin.cc>, linux@rasmusvillemoes.dk,
        Petr Mladek <pmladek@suse.com>, Joe Perches <joe@perches.com>,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 3/9] lib/vsprintf: Make strspec global
Date: Fri, 16 Feb 2018 23:07:05 +0200
Message-Id: <20180216210711.79901-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180216210711.79901-1-andriy.shevchenko@linux.intel.com>
References: <20180216210711.79901-1-andriy.shevchenko@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are places where default specification to print strings
is in use.

Make it global and convert existing users.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 lib/vsprintf.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index 8f29af063d8a..0c23b006b495 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -693,6 +693,11 @@ char *symbol_string(char *buf, char *end, void *ptr,
 #endif
 }
 
+static const struct printf_spec default_str_spec = {
+	.field_width = -1,
+	.precision = -1,
+};
+
 static const struct printf_spec default_dec_spec = {
 	.base = 10,
 	.precision = -1,
@@ -1461,10 +1466,6 @@ char *format_flags(char *buf, char *end, unsigned long flags,
 					const struct trace_print_flags *names)
 {
 	unsigned long mask;
-	const struct printf_spec strspec = {
-		.field_width = -1,
-		.precision = -1,
-	};
 	const struct printf_spec numspec = {
 		.flags = SPECIAL|SMALL,
 		.field_width = -1,
@@ -1477,7 +1478,7 @@ char *format_flags(char *buf, char *end, unsigned long flags,
 		if ((flags & mask) != mask)
 			continue;
 
-		buf = string(buf, end, names->name, strspec);
+		buf = string(buf, end, names->name, default_str_spec);
 
 		flags &= ~mask;
 		if (flags) {
@@ -1535,22 +1536,18 @@ char *device_node_gen_full_name(const struct device_node *np, char *buf, char *e
 {
 	int depth;
 	const struct device_node *parent = np->parent;
-	static const struct printf_spec strspec = {
-		.field_width = -1,
-		.precision = -1,
-	};
 
 	/* special case for root node */
 	if (!parent)
-		return string(buf, end, "/", strspec);
+		return string(buf, end, "/", default_str_spec);
 
 	for (depth = 0; parent->parent; depth++)
 		parent = parent->parent;
 
 	for ( ; depth >= 0; depth--) {
-		buf = string(buf, end, "/", strspec);
+		buf = string(buf, end, "/", default_str_spec);
 		buf = string(buf, end, device_node_name_for_depth(np, depth),
-			     strspec);
+			     default_str_spec);
 	}
 	return buf;
 }
-- 
2.15.1
