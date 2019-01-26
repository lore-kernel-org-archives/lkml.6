Return-Path: <SRS0=RQnK=QC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E566C282C7
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 09:58:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67ACB218B0
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 09:58:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729634AbfAZJ6O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Jan 2019 04:58:14 -0500
Received: from terminus.zytor.com ([198.137.202.136]:47075 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726143AbfAZJ6O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Jan 2019 04:58:14 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x0Q9w73q510363
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 26 Jan 2019 01:58:07 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x0Q9w7Y1510360;
        Sat, 26 Jan 2019 01:58:07 -0800
Date:   Sat, 26 Jan 2019 01:58:07 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-n2gcrfmh480rm44p7fra13vv@git.kernel.org>
Cc:     namhyung@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
        mingo@kernel.org, tglx@linutronix.de, acme@redhat.com,
        hpa@zytor.com, linux-kernel@vger.kernel.org
Reply-To: acme@redhat.com, hpa@zytor.com, linux-kernel@vger.kernel.org,
          namhyung@kernel.org, adrian.hunter@intel.com, jolsa@kernel.org,
          tglx@linutronix.de, mingo@kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf symbols: Remove include map.h from dso.h
Git-Commit-ID: d328e305ea1fe78f569a4ea2cacca7fa5beec06e
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

Commit-ID:  d328e305ea1fe78f569a4ea2cacca7fa5beec06e
Gitweb:     https://git.kernel.org/tip/d328e305ea1fe78f569a4ea2cacca7fa5beec06e
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Tue, 22 Jan 2019 11:10:59 -0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Fri, 25 Jan 2019 15:12:09 +0100

perf symbols: Remove include map.h from dso.h

Disentangling the dependency tree, to reduce build time.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-n2gcrfmh480rm44p7fra13vv@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/ui/browsers/map.c     | 1 +
 tools/perf/util/dso.h            | 4 +++-
 tools/perf/util/symbol_fprintf.c | 1 +
 3 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/perf/ui/browsers/map.c b/tools/perf/ui/browsers/map.c
index 5b8b8c637686..c70d9337405b 100644
--- a/tools/perf/ui/browsers/map.c
+++ b/tools/perf/ui/browsers/map.c
@@ -6,6 +6,7 @@
 #include <linux/bitops.h>
 #include "../../util/util.h"
 #include "../../util/debug.h"
+#include "../../util/map.h"
 #include "../../util/symbol.h"
 #include "../browser.h"
 #include "../helpline.h"
diff --git a/tools/perf/util/dso.h b/tools/perf/util/dso.h
index af2eda29660f..56001b82d448 100644
--- a/tools/perf/util/dso.h
+++ b/tools/perf/util/dso.h
@@ -7,12 +7,14 @@
 #include <linux/rbtree.h>
 #include <sys/types.h>
 #include <stdbool.h>
+#include <stdio.h>
 #include "rwsem.h"
 #include <linux/bitops.h>
-#include "map.h"
 #include "namespaces.h"
 #include "build-id.h"
 
+struct map;
+
 enum dso_binary_type {
 	DSO_BINARY_TYPE__KALLSYMS = 0,
 	DSO_BINARY_TYPE__GUEST_KALLSYMS,
diff --git a/tools/perf/util/symbol_fprintf.c b/tools/perf/util/symbol_fprintf.c
index ed0205cc7942..50472c75da59 100644
--- a/tools/perf/util/symbol_fprintf.c
+++ b/tools/perf/util/symbol_fprintf.c
@@ -3,6 +3,7 @@
 #include <inttypes.h>
 #include <stdio.h>
 
+#include "map.h"
 #include "symbol.h"
 
 size_t symbol__fprintf(struct symbol *sym, FILE *fp)
