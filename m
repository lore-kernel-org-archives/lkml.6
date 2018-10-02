Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50A6CC64EBC
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 21:55:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D81D9206B2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 21:55:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D81D9206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728356AbeJCElK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 00:41:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:56806 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725767AbeJCElJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 00:41:09 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 88F3A206B2;
        Tue,  2 Oct 2018 21:55:40 +0000 (UTC)
Date:   Tue, 2 Oct 2018 17:55:39 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, Jiri Olsa <jolsa@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Tzvetomir Stoyanov <tz.stoyanov@gmail.com>,
        Linux Trace Devel <linux-trace-devel@vger.kernel.org>,
        Colin Patrick McCabe <cmccabe@alumni.cmu.edu>
Subject: [PATCH v3] tools/lib/traceevent: Replace str_error_r() with an open
 coded implementation
Message-ID: <20181002175539.2ac894c7@gandalf.local.home>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

While working on having PowerTop use libtracevent as a shared object
library, Tzvetomir hit "str_error_r not defined". This was added by commit
c3cec9e68f12d ("tools lib traceevent: Use str_error_r()") because
strerror_r() has two definitions, where one is GNU specific, and the other
is XSI complient. The strerror_r() is in a wrapper str_error_r() to keep the
code from having to worry about which compiler is being used.

The problem is that str_error_r() is external to libtraceevent, and not part
of the library. If it is used as a shared object then the tools using it
will need to define that function. I do not want that function defined in
libtraceevent itself, as it is out of scope for that library.

As there's only a single instance of this call, I replaced it with an open
coded algorithm that uses sys_nerr and sys_errlist error array with
strncpy() to place the error message in the given buffer. We don't need to
worry about the errors that strerror_r() returns. If the buffer isn't big
enough, we simply truncate it.

The sys_nerr and sys_errlist idea was found here:

  http://www.club.cc.cmu.edu/~cmccabe/blog_strerror.html

Cc: Colin Patrick McCabe <cmccabe@alumni.cmu.edu>
Reported-by: Tzvetomir Stoyanov <tstoyanov@vmware.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
Changes since v2:

  Use sys_nerr and sys_errlist idea.

 tools/lib/traceevent/event-parse.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/tools/lib/traceevent/event-parse.c b/tools/lib/traceevent/event-parse.c
index 7980fc6c3bac..d23d10bc5314 100644
--- a/tools/lib/traceevent/event-parse.c
+++ b/tools/lib/traceevent/event-parse.c
@@ -18,7 +18,6 @@
 #include <errno.h>
 #include <stdint.h>
 #include <limits.h>
-#include <linux/string.h>
 #include <linux/time64.h>
 
 #include <netinet/in.h>
@@ -6215,7 +6214,13 @@ int tep_strerror(struct tep_handle *pevent __maybe_unused,
 	const char *msg;
 
 	if (errnum >= 0) {
-		str_error_r(errnum, buf, buflen);
+		if (buflen > 0) {
+			if (errnum < sys_nerr)
+				strncpy(buf, sys_errlist[errnum], buflen);
+			else
+				snprintf(buf, buflen, "Unknown error %d", errnum);
+			buf[buflen - 1] = 0;
+		}
 		return 0;
 	}
 
-- 
2.13.6

