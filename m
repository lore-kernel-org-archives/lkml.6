Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AA4DECE560
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 18:53:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0BBF21567
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 18:53:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0BBF21567
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391323AbeIVAnY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 20:43:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:51436 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390726AbeIVAnY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 20:43:24 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F066B2146E;
        Fri, 21 Sep 2018 18:53:12 +0000 (UTC)
Date:   Fri, 21 Sep 2018 14:53:04 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Tzvetomir Stoyanov <tz.stoyanov@gmail.com>
Subject: [PATCH] tools/lib/traceevent: Replace str_error_r() with an open
 coded implementation
Message-ID: <20180921145304.587795a1@gandalf.local.home>
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
coded algorithm that just uses strerror() and strncpy() to place the error
message in the given buffer. We don't need to worry about the errors that
strerror_r() returns. If the buffer isn't big enough, we simply truncate it.

Reported-by: Tzvetomir Stoyanov <tstoyanov@vmware.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 tools/lib/traceevent/event-parse.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/lib/traceevent/event-parse.c b/tools/lib/traceevent/event-parse.c
index 7980fc6c3bac..5d05f16ae129 100644
--- a/tools/lib/traceevent/event-parse.c
+++ b/tools/lib/traceevent/event-parse.c
@@ -18,7 +18,6 @@
 #include <errno.h>
 #include <stdint.h>
 #include <limits.h>
-#include <linux/string.h>
 #include <linux/time64.h>
 
 #include <netinet/in.h>
@@ -6215,7 +6214,10 @@ int tep_strerror(struct tep_handle *pevent __maybe_unused,
 	const char *msg;
 
 	if (errnum >= 0) {
-		str_error_r(errnum, buf, buflen);
+		const char *error_str = strerror(errnum);
+
+		strncpy(buf, error_str, buflen);
+		buf[buflen - 1] = 0;
 		return 0;
 	}
 
-- 
2.13.6

