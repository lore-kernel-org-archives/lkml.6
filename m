Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F796C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 15:24:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D15852146E
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 15:24:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728107AbfBHPY2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 10:24:28 -0500
Received: from mx2.suse.de ([195.135.220.15]:59994 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727717AbfBHPY0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 10:24:26 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 4E650B141;
        Fri,  8 Feb 2019 15:24:25 +0000 (UTC)
From:   Petr Mladek <pmladek@suse.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "Tobin C . Harding" <me@tobin.cc>, Joe Perches <joe@perches.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.cz>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-kernel@vger.kernel.org, Petr Mladek <pmladek@suse.com>
Subject: [PATCH v6 5/9] vsprintf: Factor out %pV handler as va_format()
Date:   Fri,  8 Feb 2019 16:23:06 +0100
Message-Id: <20190208152310.29531-6-pmladek@suse.com>
X-Mailer: git-send-email 2.13.7
In-Reply-To: <20190208152310.29531-1-pmladek@suse.com>
References: <20190208152310.29531-1-pmladek@suse.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the code from the long pointer() function. We are going to improve
error handling that will make it more complicated.

This patch does not change the existing behavior.

Signed-off-by: Petr Mladek <pmladek@suse.com>
---
 lib/vsprintf.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index d8bc3bb8ce18..9621b76f6c60 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -1519,6 +1519,17 @@ char *escaped_string(char *buf, char *end, u8 *addr, struct printf_spec spec,
 	return buf;
 }
 
+static char *va_format(char *buf, char *end, struct va_format *va_fmt)
+{
+	va_list va;
+
+	va_copy(va, *va_fmt->va);
+	buf += vsnprintf(buf, end > buf ? end - buf : 0, va_fmt->fmt, va);
+	va_end(va);
+
+	return buf;
+}
+
 static noinline_for_stack
 char *uuid_string(char *buf, char *end, const u8 *addr,
 		  struct printf_spec spec, const char *fmt)
@@ -2046,15 +2057,7 @@ char *pointer(const char *fmt, char *buf, char *end, void *ptr,
 	case 'U':
 		return uuid_string(buf, end, ptr, spec, fmt);
 	case 'V':
-		{
-			va_list va;
-
-			va_copy(va, *((struct va_format *)ptr)->va);
-			buf += vsnprintf(buf, end > buf ? end - buf : 0,
-					 ((struct va_format *)ptr)->fmt, va);
-			va_end(va);
-			return buf;
-		}
+		return va_format(buf, end, ptr);
 	case 'K':
 		return restricted_pointer(buf, end, ptr, spec);
 	case 'N':
-- 
2.13.7

