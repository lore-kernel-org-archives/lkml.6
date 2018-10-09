Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AA16C67879
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 00:55:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F2812087D
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 00:55:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="eeabPRqS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F2812087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727178AbeJIIJu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 04:09:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:42414 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726946AbeJIIJu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 04:09:50 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1B3A02087D;
        Tue,  9 Oct 2018 00:55:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539046528;
        bh=K7F8i83AaiJMr6wgbJbCz4PW7x8xSlVVM0NGth7dfM4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eeabPRqSaDa08YFqJAcHKfKihsmuh3pBziLWFClRShkYlYMWBmTGuvZesuE618NCn
         UojTpOyHkHVVyaO4q7+080OB17EAJVFbYfRlKMcyOA8QE1Av+Uf5UW8M9QYcuHIlZS
         rR3HNUs+EKHU+Kq08RDcWf3NwXoKCP55K8kCdYUs=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Tzvetomir Stoyanov <tz.stoyanov@gmail.com>,
        linux trace devel <linux-trace-devel@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 11/12] tools lib traceevent: Separate out tep_strerror() for strerror_r() issues
Date:   Mon,  8 Oct 2018 21:54:26 -0300
Message-Id: <20181009005427.6607-12-acme@kernel.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20181009005427.6607-1-acme@kernel.org>
References: <20181009005427.6607-1-acme@kernel.org>
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

As there's only a single instance of this call, and its in the traceevent
library's own tep_strerror() function, we can copy what was done in perf,
and create yet another external file that undefs _GNU_SOURCE to use the more
portable version of the function. We don't need to worry about the errors
that strerror_r() returns. If the buffer isn't big enough, we simply
truncate it.

Reported-by: Tzvetomir Stoyanov <tstoyanov@vmware.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Tzvetomir Stoyanov (VMware) <tz.stoyanov@gmail.com>
Cc: linux trace devel <linux-trace-devel@vger.kernel.org>
Link: http://lkml.kernel.org/r/20181005121816.484e654f@gandalf.local.home
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/lib/traceevent/Build          |  1 +
 tools/lib/traceevent/event-parse.c  | 30 ---------------------
 tools/lib/traceevent/tep_strerror.c | 53 +++++++++++++++++++++++++++++++++++++
 3 files changed, 54 insertions(+), 30 deletions(-)
 create mode 100644 tools/lib/traceevent/tep_strerror.c

diff --git a/tools/lib/traceevent/Build b/tools/lib/traceevent/Build
index c681d0575d16..0050c145d806 100644
--- a/tools/lib/traceevent/Build
+++ b/tools/lib/traceevent/Build
@@ -4,6 +4,7 @@ libtraceevent-y += trace-seq.o
 libtraceevent-y += parse-filter.o
 libtraceevent-y += parse-utils.o
 libtraceevent-y += kbuffer-parse.o
+libtraceevent-y += tep_strerror.o
 
 plugin_jbd2-y         += plugin_jbd2.o
 plugin_hrtimer-y      += plugin_hrtimer.o
diff --git a/tools/lib/traceevent/event-parse.c b/tools/lib/traceevent/event-parse.c
index 7980fc6c3bac..233179a712d6 100644
--- a/tools/lib/traceevent/event-parse.c
+++ b/tools/lib/traceevent/event-parse.c
@@ -18,7 +18,6 @@
 #include <errno.h>
 #include <stdint.h>
 #include <limits.h>
-#include <linux/string.h>
 #include <linux/time64.h>
 
 #include <netinet/in.h>
@@ -6201,35 +6200,6 @@ enum tep_errno tep_parse_event(struct tep_handle *pevent, const char *buf,
 	return __parse_event(pevent, &event, buf, size, sys);
 }
 
-#undef _PE
-#define _PE(code, str) str
-static const char * const tep_error_str[] = {
-	TEP_ERRORS
-};
-#undef _PE
-
-int tep_strerror(struct tep_handle *pevent __maybe_unused,
-		 enum tep_errno errnum, char *buf, size_t buflen)
-{
-	int idx;
-	const char *msg;
-
-	if (errnum >= 0) {
-		str_error_r(errnum, buf, buflen);
-		return 0;
-	}
-
-	if (errnum <= __TEP_ERRNO__START ||
-	    errnum >= __TEP_ERRNO__END)
-		return -1;
-
-	idx = errnum - __TEP_ERRNO__START - 1;
-	msg = tep_error_str[idx];
-	snprintf(buf, buflen, "%s", msg);
-
-	return 0;
-}
-
 int get_field_val(struct trace_seq *s, struct tep_format_field *field,
 		  const char *name, struct tep_record *record,
 		  unsigned long long *val, int err)
diff --git a/tools/lib/traceevent/tep_strerror.c b/tools/lib/traceevent/tep_strerror.c
new file mode 100644
index 000000000000..4ac26445b2f6
--- /dev/null
+++ b/tools/lib/traceevent/tep_strerror.c
@@ -0,0 +1,53 @@
+// SPDX-License-Identifier: LGPL-2.1
+#undef _GNU_SOURCE
+#include <string.h>
+#include <stdio.h>
+
+#include "event-parse.h"
+
+#undef _PE
+#define _PE(code, str) str
+static const char * const tep_error_str[] = {
+	TEP_ERRORS
+};
+#undef _PE
+
+/*
+ * The tools so far have been using the strerror_r() GNU variant, that returns
+ * a string, be it the buffer passed or something else.
+ *
+ * But that, besides being tricky in cases where we expect that the function
+ * using strerror_r() returns the error formatted in a provided buffer (we have
+ * to check if it returned something else and copy that instead), breaks the
+ * build on systems not using glibc, like Alpine Linux, where musl libc is
+ * used.
+ *
+ * So, introduce yet another wrapper, str_error_r(), that has the GNU
+ * interface, but uses the portable XSI variant of strerror_r(), so that users
+ * rest asured that the provided buffer is used and it is what is returned.
+ */
+int tep_strerror(struct tep_handle *tep __maybe_unused,
+		 enum tep_errno errnum, char *buf, size_t buflen)
+{
+	const char *msg;
+	int idx;
+
+	if (!buflen)
+		return 0;
+
+	if (errnum >= 0) {
+		int err = strerror_r(errnum, buf, buflen);
+		buf[buflen - 1] = 0;
+		return err;
+	}
+
+	if (errnum <= __TEP_ERRNO__START ||
+	    errnum >= __TEP_ERRNO__END)
+		return -1;
+
+	idx = errnum - __TEP_ERRNO__START - 1;
+	msg = tep_error_str[idx];
+	snprintf(buf, buflen, "%s", msg);
+
+	return 0;
+}
-- 
2.14.4

