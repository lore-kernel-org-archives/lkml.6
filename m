Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750951AbeBPVHV (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 16:07:21 -0500
Received: from mga05.intel.com ([192.55.52.43]:50074 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750734AbeBPVHQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 16:07:16 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,520,1511856000";
   d="scan'208";a="18315367"
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "Tobin C . Harding" <me@tobin.cc>, linux@rasmusvillemoes.dk,
        Petr Mladek <pmladek@suse.com>, Joe Perches <joe@perches.com>,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 4/9] lib/vsprintf: Make flag_spec global
Date: Fri, 16 Feb 2018 23:07:06 +0200
Message-Id: <20180216210711.79901-4-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180216210711.79901-1-andriy.shevchenko@linux.intel.com>
References: <20180216210711.79901-1-andriy.shevchenko@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are places where default specification to print flags as number
is in use.

Make it global and convert existing users.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 lib/vsprintf.c | 21 ++++++++-------------
 1 file changed, 8 insertions(+), 13 deletions(-)

diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index 0c23b006b495..c789d265311b 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -698,6 +698,12 @@ static const struct printf_spec default_str_spec = {
 	.precision = -1,
 };
 
+static const struct printf_spec default_flag_spec = {
+	.base = 16,
+	.precision = -1,
+	.flags = SPECIAL | SMALL,
+};
+
 static const struct printf_spec default_dec_spec = {
 	.base = 10,
 	.precision = -1,
@@ -737,11 +743,6 @@ char *resource_string(char *buf, char *end, struct resource *res,
 		.precision = 10,
 		.flags = LEFT,
 	};
-	static const struct printf_spec flag_spec = {
-		.base = 16,
-		.precision = -1,
-		.flags = SPECIAL | SMALL,
-	};
 
 	/* 32-bit res (sizeof==4): 10 chars in dec, 10 in hex ("0x" + 8)
 	 * 64-bit res (sizeof==8): 20 chars in dec, 18 in hex ("0x" + 16) */
@@ -798,7 +799,7 @@ char *resource_string(char *buf, char *end, struct resource *res,
 			p = string(p, pend, " disabled", str_spec);
 	} else {
 		p = string(p, pend, " flags ", str_spec);
-		p = number(p, pend, res->flags, flag_spec);
+		p = number(p, pend, res->flags, default_flag_spec);
 	}
 	*p++ = ']';
 	*p = '\0';
@@ -1466,12 +1467,6 @@ char *format_flags(char *buf, char *end, unsigned long flags,
 					const struct trace_print_flags *names)
 {
 	unsigned long mask;
-	const struct printf_spec numspec = {
-		.flags = SPECIAL|SMALL,
-		.field_width = -1,
-		.precision = -1,
-		.base = 16,
-	};
 
 	for ( ; flags && names->name; names++) {
 		mask = names->mask;
@@ -1489,7 +1484,7 @@ char *format_flags(char *buf, char *end, unsigned long flags,
 	}
 
 	if (flags)
-		buf = number(buf, end, flags, numspec);
+		buf = number(buf, end, flags, default_flag_spec);
 
 	return buf;
 }
-- 
2.15.1
