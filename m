Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D06CFC169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 18:49:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A12E2083B
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 18:49:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549478973;
	bh=RmRKVco90fsgBFwRyigPjHoSjVTP6s1re3TBTDlLSXg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ORRBJwXFk4c835sCxPYATxuoaOOpevn4TAYtvIz8EuCtl8alm9wIkE8kiZTEKvMrk
	 D3TMt07G+XSUzodo9ifSwx7gVv6IUS/QyPyv6O+K0bQl2zmdIFfuVOebEAmiwYr1PZ
	 367XNLbYSadrXf4abITU4nhBlMqMMJSPGdjPcfyE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727073AbfBFStb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 13:49:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:43802 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727000AbfBFSt3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 13:49:29 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.41.93])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DAFA9218C3;
        Wed,  6 Feb 2019 18:49:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549478968;
        bh=RmRKVco90fsgBFwRyigPjHoSjVTP6s1re3TBTDlLSXg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hTnQH5gIcvwO2NR06m25YA0IlRQ7IZzchop4U7zpxJsVK+ehDBhWa8A5pqttkUZW6
         jCJK8kiK8Sl6RjeMws8AlNkR4oGJ5Ib/U6MTOcVxifdh9btmy3wo8MKDUUnMCh6UY+
         azkwNfrYAWWfeAMLBHhLpyZjxKWBDSsXznvPoVY0=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Frederic Weisbecker <fweisbec@gmail.com>
Subject: [PATCH 04/53] perf callchain: Uninline callchain_cursor_reset() to remove map.h dependency
Date:   Wed,  6 Feb 2019 15:48:14 -0300
Message-Id: <20190206184903.24054-5-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190206184903.24054-1-acme@kernel.org>
References: <20190206184903.24054-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

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
-- 
2.20.1

