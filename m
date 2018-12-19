Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3A89C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 21:40:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94AEE2080D
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 21:40:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728734AbeLSVkX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 16:40:23 -0500
Received: from cdptpa-outbound-snat.email.rr.com ([107.14.166.228]:31608 "EHLO
        cdptpa-cmomta01.email.rr.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727079AbeLSVkW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 16:40:22 -0500
X-Greylist: delayed 487 seconds by postgrey-1.27 at vger.kernel.org; Wed, 19 Dec 2018 16:40:20 EST
Received: from gandalf.local.home ([66.24.56.78])
        by cmsmtp with SMTP
        id ZjRogOsxLHYTyZjRqg2D5Z; Wed, 19 Dec 2018 21:32:11 +0000
Date:   Wed, 19 Dec 2018 16:32:07 -0500
From:   Bryana Rostedt <bryana@home.goodmis.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>,
        Joe Perches <joe@perches.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: [RFC][PATCH] string.h: Add strncmp_prefix() helper macro
Message-ID: <20181219163207.792e0f97@gandalf.local.home>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfEoqkHlt4uDKjLU087jz1UFocYU9fXjXGsuGnZKrBlF1xaUpXFU80PbcLWul6DVrPZP4yZivESCm/mk7gY6+PxosD6S7lusLuMXJxKTNW4R6V5kFKW9b
 rSTUDH0TApIFCb2Qb6j/PgINBvOXO1ApJ3a/IU11cRUUiyJ6/ON1oqZZ3IVm4H0HcNfKU9O7UqlBJ6WzlVBppGwWA8LW+wDaW3zCIay94vGTT4QwFUsTT3Vz
 X1tSed46SmmzgoWPuN6khbiDeW3/ABZj0+QQEOArFO0zhDsrgdpeXxhrbJDjDy4mZBKmASlrm35+bZKF0oh3ghoc/llzdxDP73Ao/vnMF7FeLiCHQygxg25S
 tTNK5jM3XJDHTxr6XxuQIZ1J8TtOsAUvNTxrD4t/rUBy27y0dCW6GHM7Mjp30yjryM3Q+V7mJ5Y+naEgr+2EBieMCuxqthJyPuYn0scYKXVdbOd1drsCETrH
 ibc7uDTajGsNbic/j35rCEI1ZY28jSXmcvT/MWGB1A6+t/YSrIGwk3d6g1zkx25JMAedvsMfTJEIbISz
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A discussion came up in the trace triggers thread about converting a
bunch of:

 strncmp(str, "const", sizeof("const") - 1)

use cases into a helper macro. It started with:

#define strncmp_const(str, const) \
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

#define strncmp_prefix(str, prefix) \
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

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
diff --git a/include/linux/string.h b/include/linux/string.h
index 27d0482e5e05..3dc743e3a0ba 100644
--- a/include/linux/string.h
+++ b/include/linux/string.h
@@ -14,6 +14,27 @@ extern void *memdup_user(const void __user *, size_t);
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
+		char *____strcmp_prefix____ = prefix;			\
+		if (__builtin_constant_p(&prefix))			\
+			____strcmp_prefix_ret____ =			\
+				strncmp(str, prefix, sizeof(prefix) - 1); \
+		else							\
+			____strcmp_prefix_ret____ =			\
+				strncmp(str, ____strcmp_prefix____,	\
+					strlen(____strcmp_prefix____));	\
+		____strcmp_prefix_ret____;				\
+	})
+
 /*
  * Include machine specific inline routines
  */
