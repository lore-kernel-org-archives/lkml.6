Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751835AbeBPT3Q (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 14:29:16 -0500
Received: from mga17.intel.com ([192.55.52.151]:32804 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751380AbeBPT2N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 14:28:13 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,520,1511856000";
   d="scan'208";a="201741329"
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "Tobin C. Harding" <me@tobin.cc>, linux@rasmusvillemoes.dk,
        Petr Mladek <pmladek@suse.com>, Joe Perches <joe@perches.com>,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 6/7] lib/vsprintf: Make strspec global
Date: Fri, 16 Feb 2018 21:28:05 +0200
Message-Id: <20180216192806.68914-6-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180216192806.68914-1-andriy.shevchenko@linux.intel.com>
References: <20180216192806.68914-1-andriy.shevchenko@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is at least one new user is coming where default specification to print
strings is in use.

Make it global.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 lib/vsprintf.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index 3a02fcaf8ac8..20c0ab9faba5 100644
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
@@ -1453,10 +1458,6 @@ char *format_flags(char *buf, char *end, unsigned long flags,
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
@@ -1469,7 +1470,7 @@ char *format_flags(char *buf, char *end, unsigned long flags,
 		if ((flags & mask) != mask)
 			continue;
 
-		buf = string(buf, end, names->name, strspec);
+		buf = string(buf, end, names->name, default_str_spec);
 
 		flags &= ~mask;
 		if (flags) {
-- 
2.15.1
