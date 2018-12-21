Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 175A4C43444
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 17:57:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7E46218E0
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 17:57:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391222AbeLUR5Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 12:57:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:55970 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391167AbeLUR5A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 12:57:00 -0500
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3269C2197F;
        Fri, 21 Dec 2018 17:57:00 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.91)
        (envelope-from <rostedt@goodmis.org>)
        id 1gaP2h-0002Si-A3; Fri, 21 Dec 2018 12:56:59 -0500
Message-Id: <20181221175659.208858193@goodmis.org>
User-Agent: quilt/0.65
Date:   Fri, 21 Dec 2018 12:56:41 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Joe Perches <joe@perches.com>,
        Tom Zanussi <zanussi@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [for-next][PATCH 23/24] string.h: Add strncmp_prefix() helper macro
References: <20181221175618.968519903@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Steven Rostedt <rostedt@goodmis.org>

A discussion came up in the trace triggers thread about converting a
bunch of:

 strncmp(str, "const", sizeof("const") - 1)

use cases into a helper macro. It started with:

	strncmp(str, const, sizeof(const) - 1)

But then Joe Perches mentioned that if a const is not used, the
sizeof() will be the size of a pointer, which can be bad. And that
gcc will optimize strlen("const") into "sizeof("const") - 1".

Thinking about this more, a quick grep in the kernel tree found several
(thousands!) of cases that use this construct. A quick grep also
revealed that there's probably several bugs in that use case. Some are
that people forgot the "- 1" (which I found) and others could be that
the constant for the sizeof is different than the constant (although, I
haven't found any of those, but I also didn't look hard).

I figured the best thing to do is to create a helper macro and place it
into include/linux/string.h. And go around and fix all the open coded
versions of it later.

I plan on only applying this patch and updating the tracing hooks for
this merge window. And perhaps use it to fix some of the bugs that were
found.

I was going to just use:

	strncmp(str, prefix, strlen(prefix))

but then realized that "prefix" is used twice, and will break if
someone does something like:

	strncmp_prefix(str, ptr++);

So instead I check with __builtin_constant_p() to see if the second
parameter is truly a constant, which I use sizeof() anyway (why bother
gcc to optimize it, if we already know it's a constant), and copy the
parameter into a local variable and use that local variable for the non
constant part (with strlen).

Link: http://lkml.kernel.org/r/e3e754f2bd18e56eaa8baf79bee619316ebf4cfc.1545161087.git.tom.zanussi@linux.intel.com
Link: http://lkml.kernel.org/r/20181219211615.2298e781@gandalf.local.home

Cc: Joe Perches <joe@perches.com>
Cc: Tom Zanussi <zanussi@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 include/linux/string.h | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/include/linux/string.h b/include/linux/string.h
index 27d0482e5e05..a998a53333ef 100644
--- a/include/linux/string.h
+++ b/include/linux/string.h
@@ -14,6 +14,28 @@ extern void *memdup_user(const void __user *, size_t);
 extern void *vmemdup_user(const void __user *, size_t);
 extern void *memdup_user_nul(const void __user *, size_t);
 
+/*
+ * A common way to test a prefix of a string is to do:
+ *  strncmp(str, prefix, sizeof(prefix) - 1)
+ *
+ * But this can lead to bugs due to typos, or if prefix is a pointer
+ * and not a constant. Instead use strncmp_prefix().
+ */
+#define strncmp_prefix(str, prefix)					\
+	({								\
+		int ____strcmp_prefix_ret____;				\
+		if (__builtin_constant_p(&prefix)) {			\
+			____strcmp_prefix_ret____ =			\
+				strncmp(str, prefix, sizeof(prefix) - 1); \
+		} else {						\
+			typeof(prefix) ____strcmp_prefix____ = prefix;	\
+			____strcmp_prefix_ret____ =			\
+				strncmp(str, ____strcmp_prefix____,	\
+					strlen(____strcmp_prefix____));	\
+		}							\
+		____strcmp_prefix_ret____;				\
+	})
+
 /*
  * Include machine specific inline routines
  */
-- 
2.19.2


