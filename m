Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751979AbeFERur (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 13:50:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:45284 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751852AbeFERup (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 13:50:45 -0400
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
Subject: [PATCH 01/46] perf tools: Remove dead quote.[ch] code
Date: Tue,  5 Jun 2018 14:49:45 -0300
Message-Id: <20180605175030.32549-2-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180605175030.32549-1-acme@kernel.org>
References: <20180605175030.32549-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

In c68677014bac ("perf tools: Remove support for command aliases") we
removed the only remaining use of a function provided by these files, so
ditch it.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-mgnzqbi46gucs48d7bzfwr55@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/perf.c       |  1 -
 tools/perf/util/Build   |  1 -
 tools/perf/util/quote.c | 62 -------------------------------------------------
 tools/perf/util/quote.h | 31 -------------------------
 4 files changed, 95 deletions(-)
 delete mode 100644 tools/perf/util/quote.c
 delete mode 100644 tools/perf/util/quote.h

diff --git a/tools/perf/perf.c b/tools/perf/perf.c
index 51c81509a315..a11cb006f968 100644
--- a/tools/perf/perf.c
+++ b/tools/perf/perf.c
@@ -12,7 +12,6 @@
 #include "util/env.h"
 #include <subcmd/exec-cmd.h>
 #include "util/config.h"
-#include "util/quote.h"
 #include <subcmd/run-command.h>
 #include "util/parse-events.h"
 #include <subcmd/parse-options.h>
diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index 5d4c45b76895..b604ef334dc9 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -24,7 +24,6 @@ libperf-y += libstring.o
 libperf-y += bitmap.o
 libperf-y += hweight.o
 libperf-y += smt.o
-libperf-y += quote.o
 libperf-y += strbuf.o
 libperf-y += string.o
 libperf-y += strlist.o
diff --git a/tools/perf/util/quote.c b/tools/perf/util/quote.c
deleted file mode 100644
index 22eaa201aa27..000000000000
--- a/tools/perf/util/quote.c
+++ /dev/null
@@ -1,62 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-#include <errno.h>
-#include <stdlib.h>
-#include "strbuf.h"
-#include "quote.h"
-#include "util.h"
-
-/* Help to copy the thing properly quoted for the shell safety.
- * any single quote is replaced with '\'', any exclamation point
- * is replaced with '\!', and the whole thing is enclosed in a
- *
- * E.g.
- *  original     sq_quote     result
- *  name     ==> name      ==> 'name'
- *  a b      ==> a b       ==> 'a b'
- *  a'b      ==> a'\''b    ==> 'a'\''b'
- *  a!b      ==> a'\!'b    ==> 'a'\!'b'
- */
-static inline int need_bs_quote(char c)
-{
-	return (c == '\'' || c == '!');
-}
-
-static int sq_quote_buf(struct strbuf *dst, const char *src)
-{
-	char *to_free = NULL;
-	int ret;
-
-	if (dst->buf == src)
-		to_free = strbuf_detach(dst, NULL);
-
-	ret = strbuf_addch(dst, '\'');
-	while (!ret && *src) {
-		size_t len = strcspn(src, "'!");
-		ret = strbuf_add(dst, src, len);
-		src += len;
-		while (!ret && need_bs_quote(*src))
-			ret = strbuf_addf(dst, "'\\%c\'", *src++);
-	}
-	if (!ret)
-		ret = strbuf_addch(dst, '\'');
-	free(to_free);
-
-	return ret;
-}
-
-int sq_quote_argv(struct strbuf *dst, const char** argv, size_t maxlen)
-{
-	int i, ret;
-
-	/* Copy into destination buffer. */
-	ret = strbuf_grow(dst, 255);
-	for (i = 0; !ret && argv[i]; ++i) {
-		ret = strbuf_addch(dst, ' ');
-		if (ret)
-			break;
-		ret = sq_quote_buf(dst, argv[i]);
-		if (maxlen && dst->len > maxlen)
-			return -ENOSPC;
-	}
-	return ret;
-}
diff --git a/tools/perf/util/quote.h b/tools/perf/util/quote.h
deleted file mode 100644
index 274bf26d3511..000000000000
--- a/tools/perf/util/quote.h
+++ /dev/null
@@ -1,31 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef __PERF_QUOTE_H
-#define __PERF_QUOTE_H
-
-#include <stddef.h>
-
-/* Help to copy the thing properly quoted for the shell safety.
- * any single quote is replaced with '\'', any exclamation point
- * is replaced with '\!', and the whole thing is enclosed in a
- * single quote pair.
- *
- * For example, if you are passing the result to system() as an
- * argument:
- *
- * sprintf(cmd, "foobar %s %s", sq_quote(arg0), sq_quote(arg1))
- *
- * would be appropriate.  If the system() is going to call ssh to
- * run the command on the other side:
- *
- * sprintf(cmd, "git-diff-tree %s %s", sq_quote(arg0), sq_quote(arg1));
- * sprintf(rcmd, "ssh %s %s", sq_util/quote.host), sq_quote(cmd));
- *
- * Note that the above examples leak memory!  Remember to free result from
- * sq_quote() in a real application.
- */
-
-struct strbuf;
-
-int sq_quote_argv(struct strbuf *, const char **argv, size_t maxlen);
-
-#endif /* __PERF_QUOTE_H */
-- 
2.14.3
