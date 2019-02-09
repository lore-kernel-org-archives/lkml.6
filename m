Return-Path: <SRS0=1U6d=QQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D07F9C282C4
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 12:30:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A73AB218D2
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 12:30:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727049AbfBIMaM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Feb 2019 07:30:12 -0500
Received: from terminus.zytor.com ([198.137.202.136]:59911 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726724AbfBIMaL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Feb 2019 07:30:11 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x19CU2182627642
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 9 Feb 2019 04:30:02 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x19CU2Af2627614;
        Sat, 9 Feb 2019 04:30:02 -0800
Date:   Sat, 9 Feb 2019 04:30:02 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-7fjz4hvv1bpzqaeriku44fn4@git.kernel.org>
Cc:     acme@redhat.com, hpa@zytor.com, fweisbec@gmail.com,
        mingo@kernel.org, namhyung@kernel.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de,
        adrian.hunter@intel.com, jolsa@kernel.org
Reply-To: acme@redhat.com, hpa@zytor.com, fweisbec@gmail.com,
          mingo@kernel.org, namhyung@kernel.org,
          linux-kernel@vger.kernel.org, tglx@linutronix.de,
          adrian.hunter@intel.com, jolsa@kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf callchain: Uninline callchain_cursor_reset()
 to remove map.h dependency
Git-Commit-ID: 7b644f9ad18f74aeac42360bee9c4c1cf874f4c0
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

Commit-ID:  7b644f9ad18f74aeac42360bee9c4c1cf874f4c0
Gitweb:     https://git.kernel.org/tip/7b644f9ad18f74aeac42360bee9c4c1cf874f4c0
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Sun, 27 Jan 2019 11:55:39 +0100
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 6 Feb 2019 10:00:38 -0300

perf callchain: Uninline callchain_cursor_reset() to remove map.h dependency

That was the only thing that made including map.h in callchain.h a
requiriment, so uninline it and just add a 'struct map' forward
declaration.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Frederic Weisbecker <fweisbec@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-7fjz4hvv1bpzqaeriku44fn4@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/ui/gtk/annotate.c |  1 +
 tools/perf/ui/stdio/hist.c   |  1 +
 tools/perf/util/callchain.c  | 15 +++++++++++++++
 tools/perf/util/callchain.h  | 18 +++---------------
 4 files changed, 20 insertions(+), 15 deletions(-)

diff --git a/tools/perf/ui/gtk/annotate.c b/tools/perf/ui/gtk/annotate.c
index f22a7d142ada..f42666ee0672 100644
--- a/tools/perf/ui/gtk/annotate.c
+++ b/tools/perf/ui/gtk/annotate.c
@@ -4,6 +4,7 @@
 #include "util/debug.h"
 #include "util/annotate.h"
 #include "util/evsel.h"
+#include "util/map.h"
 #include "ui/helpline.h"
 #include <inttypes.h>
 #include <signal.h>
diff --git a/tools/perf/ui/stdio/hist.c b/tools/perf/ui/stdio/hist.c
index 2a9fa4dcbc2a..814abf5e9a5c 100644
--- a/tools/perf/ui/stdio/hist.c
+++ b/tools/perf/ui/stdio/hist.c
@@ -4,6 +4,7 @@
 
 #include "../../util/util.h"
 #include "../../util/hist.h"
+#include "../../util/map.h"
 #include "../../util/sort.h"
 #include "../../util/evsel.h"
 #include "../../util/srcline.h"
diff --git a/tools/perf/util/callchain.c b/tools/perf/util/callchain.c
index dc2212e12184..2974950039ac 100644
--- a/tools/perf/util/callchain.c
+++ b/tools/perf/util/callchain.c
@@ -1577,3 +1577,18 @@ int callchain_cursor__copy(struct callchain_cursor *dst,
 
 	return rc;
 }
+
+/*
+ * Initialize a cursor before adding entries inside, but keep
+ * the previously allocated entries as a cache.
+ */
+void callchain_cursor_reset(struct callchain_cursor *cursor)
+{
+	struct callchain_cursor_node *node;
+
+	cursor->nr = 0;
+	cursor->last = &cursor->first;
+
+	for (node = cursor->first; node != NULL; node = node->next)
+		map__zput(node->map);
+}
diff --git a/tools/perf/util/callchain.h b/tools/perf/util/callchain.h
index 8afe1622edf3..b6f18c2d4b14 100644
--- a/tools/perf/util/callchain.h
+++ b/tools/perf/util/callchain.h
@@ -5,10 +5,11 @@
 #include <linux/list.h>
 #include <linux/rbtree.h>
 #include "event.h"
-#include "map.h"
 #include "symbol.h"
 #include "branch.h"
 
+struct map;
+
 #define HELP_PAD "\t\t\t\t"
 
 #define CALLCHAIN_HELP "setup and enables call-graph (stack chain/backtrace):\n\n"
@@ -187,20 +188,7 @@ int callchain_append(struct callchain_root *root,
 int callchain_merge(struct callchain_cursor *cursor,
 		    struct callchain_root *dst, struct callchain_root *src);
 
-/*
- * Initialize a cursor before adding entries inside, but keep
- * the previously allocated entries as a cache.
- */
-static inline void callchain_cursor_reset(struct callchain_cursor *cursor)
-{
-	struct callchain_cursor_node *node;
-
-	cursor->nr = 0;
-	cursor->last = &cursor->first;
-
-	for (node = cursor->first; node != NULL; node = node->next)
-		map__zput(node->map);
-}
+void callchain_cursor_reset(struct callchain_cursor *cursor);
 
 int callchain_cursor_append(struct callchain_cursor *cursor, u64 ip,
 			    struct map *map, struct symbol *sym,
