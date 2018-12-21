Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AACFEC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 23:13:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 837CD2190A
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 23:13:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392202AbeLUXNU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 18:13:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:57466 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388956AbeLUXNU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 18:13:20 -0500
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 055DD2190A;
        Fri, 21 Dec 2018 23:13:17 +0000 (UTC)
Date:   Fri, 21 Dec 2018 18:13:16 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joe Perches <joe@perches.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>
Subject: [PATCH v3] string.h: Add str_has_prefix() helper
Message-ID: <20181221181316.6d32bdc8@gandalf.local.home>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

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

Note, gcc appears to optimize this when we make it into an always_inline
static function, which removes a lot of issues that a macro produces.

Link: http://lkml.kernel.org/r/e3e754f2bd18e56eaa8baf79bee619316ebf4cfc.1545161087.git.tom.zanussi@linux.intel.com
Link: http://lkml.kernel.org/r/20181219211615.2298e781@gandalf.local.home
Link: http://lkml.kernel.org/r/CAHk-=wg_sR-UEC1ggmkZpypOUYanL5CMX4R7ceuaV4QMf5jBtg@mail.gmail.com

Cc: Tom Zanussi <zanussi@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Suggestions-by: Linus Torvalds <torvalds@linux-foundation.org>
Suggestions-by: Joe Perches <joe@perches.com>
Suggestions-by: Andreas Schwab <schwab@linux-m68k.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---

Changes since v2:

 - Rename the helper function to str_has_prefix()
    (Linus Torvalds and Joe Perches)

 - Use a static inline, as that appears to still optimize correctly
    (Andreas Schwab)

 include/linux/string.h | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/include/linux/string.h b/include/linux/string.h
index 27d0482e5e05..a37859d91b57 100644
--- a/include/linux/string.h
+++ b/include/linux/string.h
@@ -456,4 +456,24 @@ static inline void memcpy_and_pad(void *dest, size_t dest_len,
 		memcpy(dest, src, dest_len);
 }
 
+/**
+ * str_has_prefix - Test if a string has a given prefix
+ * @str: The string to test
+ * @prefix: The string to see if @str starts with
+ *
+ * A common way to test a prefix of a string is to do:
+ *  strncmp(str, prefix, sizeof(prefix) - 1)
+ *
+ * But this can lead to bugs due to typos, or if prefix is a pointer
+ * and not a constant. Instead use str_has_prefix().
+ *
+ * Returns: 0 if @str does not start with @prefix
+         strlen(@prefix) if @str does start with @prefix
+ */
+static __always_inline int str_has_prefix(const char *str, const char *prefix)
+{
+	int len = strlen(prefix);
+	return strncmp(str, prefix, len) == 0 ? len : 0;
+}
+
 #endif /* _LINUX_STRING_H_ */
-- 
2.19.1


