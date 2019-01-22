Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ACCDC282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 10:24:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EA002084A
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 10:24:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728127AbfAVKYp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 05:24:45 -0500
Received: from terminus.zytor.com ([198.137.202.136]:60895 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726281AbfAVKYp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 05:24:45 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x0MAOaJ92909776
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 22 Jan 2019 02:24:36 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x0MAOao82909773;
        Tue, 22 Jan 2019 02:24:36 -0800
Date:   Tue, 22 Jan 2019 02:24:36 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-8qvu2ek26antm3a8jyl4ocbq@git.kernel.org>
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org,
        tmricht@linux.ibm.com, brueckner@linux.ibm.com,
        namhyung@kernel.org, adrian.hunter@intel.com, jolsa@kernel.org,
        tglx@linutronix.de, hpa@zytor.com, acme@redhat.com
Reply-To: jolsa@kernel.org, hpa@zytor.com, acme@redhat.com,
          tglx@linutronix.de, tmricht@linux.ibm.com,
          linux-kernel@vger.kernel.org, mingo@kernel.org,
          adrian.hunter@intel.com, namhyung@kernel.org,
          brueckner@linux.ibm.com
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf utils: Move perf_config using routines from
 color.c to separate object
Git-Commit-ID: 32e9136e37840a62c659259a394ed3735e3b3c84
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  32e9136e37840a62c659259a394ed3735e3b3c84
Gitweb:     https://git.kernel.org/tip/32e9136e37840a62c659259a394ed3735e3b3c84
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Mon, 21 Jan 2019 15:45:13 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 21 Jan 2019 17:38:56 -0300

perf utils: Move perf_config using routines from color.c to separate object

To untangle objects a bit more, avoiding rebuilding the color_fprintf
routines when changes are made to the perf config headers.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Hendrik Brueckner <brueckner@linux.ibm.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Thomas Richter <tmricht@linux.ibm.com>
Link: https://lkml.kernel.org/n/tip-8qvu2ek26antm3a8jyl4ocbq@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/Build          |  1 +
 tools/perf/util/color.c        | 39 -----------------------------------
 tools/perf/util/color_config.c | 47 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 48 insertions(+), 39 deletions(-)

diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index c359af408334..b69d6294c88c 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -35,6 +35,7 @@ libperf-y += dso.o
 libperf-y += symbol.o
 libperf-y += symbol_fprintf.o
 libperf-y += color.o
+libperf-y += color_config.o
 libperf-y += metricgroup.o
 libperf-y += header.o
 libperf-y += callchain.o
diff --git a/tools/perf/util/color.c b/tools/perf/util/color.c
index 39e628b8938e..39b8c4ec4e2e 100644
--- a/tools/perf/util/color.c
+++ b/tools/perf/util/color.c
@@ -1,7 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/kernel.h>
 #include "cache.h"
-#include "config.h"
 #include <stdlib.h>
 #include <stdio.h>
 #include "color.h"
@@ -10,44 +9,6 @@
 
 int perf_use_color_default = -1;
 
-int perf_config_colorbool(const char *var, const char *value, int stdout_is_tty)
-{
-	if (value) {
-		if (!strcasecmp(value, "never"))
-			return 0;
-		if (!strcasecmp(value, "always"))
-			return 1;
-		if (!strcasecmp(value, "auto"))
-			goto auto_color;
-	}
-
-	/* Missing or explicit false to turn off colorization */
-	if (!perf_config_bool(var, value))
-		return 0;
-
-	/* any normal truth value defaults to 'auto' */
- auto_color:
-	if (stdout_is_tty < 0)
-		stdout_is_tty = isatty(1);
-	if (stdout_is_tty || pager_in_use()) {
-		char *term = getenv("TERM");
-		if (term && strcmp(term, "dumb"))
-			return 1;
-	}
-	return 0;
-}
-
-int perf_color_default_config(const char *var, const char *value,
-			      void *cb __maybe_unused)
-{
-	if (!strcmp(var, "color.ui")) {
-		perf_use_color_default = perf_config_colorbool(var, value, -1);
-		return 0;
-	}
-
-	return 0;
-}
-
 static int __color_vsnprintf(char *bf, size_t size, const char *color,
 			     const char *fmt, va_list args, const char *trail)
 {
diff --git a/tools/perf/util/color_config.c b/tools/perf/util/color_config.c
new file mode 100644
index 000000000000..817dc56e7e95
--- /dev/null
+++ b/tools/perf/util/color_config.c
@@ -0,0 +1,47 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/kernel.h>
+#include "cache.h"
+#include "config.h"
+#include <stdlib.h>
+#include <stdio.h>
+#include "color.h"
+#include <math.h>
+#include <unistd.h>
+
+int perf_config_colorbool(const char *var, const char *value, int stdout_is_tty)
+{
+	if (value) {
+		if (!strcasecmp(value, "never"))
+			return 0;
+		if (!strcasecmp(value, "always"))
+			return 1;
+		if (!strcasecmp(value, "auto"))
+			goto auto_color;
+	}
+
+	/* Missing or explicit false to turn off colorization */
+	if (!perf_config_bool(var, value))
+		return 0;
+
+	/* any normal truth value defaults to 'auto' */
+ auto_color:
+	if (stdout_is_tty < 0)
+		stdout_is_tty = isatty(1);
+	if (stdout_is_tty || pager_in_use()) {
+		char *term = getenv("TERM");
+		if (term && strcmp(term, "dumb"))
+			return 1;
+	}
+	return 0;
+}
+
+int perf_color_default_config(const char *var, const char *value,
+			      void *cb __maybe_unused)
+{
+	if (!strcmp(var, "color.ui")) {
+		perf_use_color_default = perf_config_colorbool(var, value, -1);
+		return 0;
+	}
+
+	return 0;
+}
