Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81CC8C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 18:06:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DF77218E0
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 18:06:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388588AbeLTSGo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 13:06:44 -0500
Received: from terminus.zytor.com ([198.137.202.136]:52403 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388561AbeLTSGm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 13:06:42 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wBKI6a3m3681269
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 20 Dec 2018 10:06:36 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wBKI6aSN3681266;
        Thu, 20 Dec 2018 10:06:36 -0800
Date:   Thu, 20 Dec 2018 10:06:36 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-343ashae97e5bq6vizusyfno@git.kernel.org>
Cc:     namhyung@kernel.org, acme@redhat.com, linux-kernel@vger.kernel.org,
        mingo@kernel.org, hpa@zytor.com, tglx@linutronix.de,
        adrian.hunter@intel.com, jolsa@kernel.org
Reply-To: tglx@linutronix.de, hpa@zytor.com, jolsa@kernel.org,
          adrian.hunter@intel.com, acme@redhat.com,
          linux-kernel@vger.kernel.org, namhyung@kernel.org,
          mingo@kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf tools: Add missing open_memstream() prototype
 for systems lacking it
Git-Commit-ID: d7a8c4a6a055097a67ccfa3ca7c9ff1b64603a70
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

Commit-ID:  d7a8c4a6a055097a67ccfa3ca7c9ff1b64603a70
Gitweb:     https://git.kernel.org/tip/d7a8c4a6a055097a67ccfa3ca7c9ff1b64603a70
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Tue, 11 Dec 2018 16:31:19 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 18 Dec 2018 12:23:57 -0300

perf tools: Add missing open_memstream() prototype for systems lacking it

There are systems such as the Android NDK API level 24 has the
open_memstream() function but doesn't provide a prototype, adding noise
to the build:

  builtin-timechart.c: In function 'cat_backtrace':
  builtin-timechart.c:486:2: warning: implicit declaration of function 'open_memstream' [-Wimplicit-function-declaration]
    FILE *f = open_memstream(&p, &p_len);
    ^
  builtin-timechart.c:486:2: warning: nested extern declaration of 'open_memstream' [-Wnested-externs]
  builtin-timechart.c:486:12: warning: initialization makes pointer from integer without a cast
    FILE *f = open_memstream(&p, &p_len);
              ^

Define a LACKS_OPEN_MEMSTREAM_PROTOTYPE define so that code needing that
can get a prototype.

Checked in the bionic git repo to be available since level 23:

https://android.googlesource.com/platform/bionic/+/master/libc/include/stdio.h#241

  FILE* open_memstream(char** __ptr, size_t* __size_ptr) __INTRODUCED_IN(23);

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-343ashae97e5bq6vizusyfno@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Makefile.config     | 1 +
 tools/perf/builtin-timechart.c | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 265a9225e5fc..07c1857c3d7a 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -295,6 +295,7 @@ ifndef NO_BIONIC
   ifeq ($(feature-bionic), 1)
     BIONIC := 1
     CFLAGS += -DLACKS_SIGQUEUE_PROTOTYPE
+    CFLAGS += -DLACKS_OPEN_MEMSTREAM_PROTOTYPE
     EXTLIBS := $(filter-out -lrt,$(EXTLIBS))
     EXTLIBS := $(filter-out -lpthread,$(EXTLIBS))
   endif
diff --git a/tools/perf/builtin-timechart.c b/tools/perf/builtin-timechart.c
index a827919c6263..775b99833e51 100644
--- a/tools/perf/builtin-timechart.c
+++ b/tools/perf/builtin-timechart.c
@@ -43,6 +43,10 @@
 #include "util/data.h"
 #include "util/debug.h"
 
+#ifdef LACKS_OPEN_MEMSTREAM_PROTOTYPE
+FILE *open_memstream(char **ptr, size_t *sizeloc);
+#endif
+
 #define SUPPORT_OLD_POWER_EVENTS 1
 #define PWR_EVENT_EXIT -1
 
