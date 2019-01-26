Return-Path: <SRS0=RQnK=QC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 224FAC282C7
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 09:57:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF0F1214C6
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 09:57:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729592AbfAZJ47 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Jan 2019 04:56:59 -0500
Received: from terminus.zytor.com ([198.137.202.136]:59033 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726143AbfAZJ46 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Jan 2019 04:56:58 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x0Q9upRs510045
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 26 Jan 2019 01:56:51 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x0Q9upWQ510042;
        Sat, 26 Jan 2019 01:56:51 -0800
Date:   Sat, 26 Jan 2019 01:56:51 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-pnbkqo8jxbi49d4f3yd3b5w3@git.kernel.org>
Cc:     mingo@kernel.org, adrian.hunter@intel.com, hpa@zytor.com,
        acme@redhat.com, linux-kernel@vger.kernel.org, namhyung@kernel.org,
        tglx@linutronix.de, jolsa@kernel.org
Reply-To: jolsa@kernel.org, tglx@linutronix.de, namhyung@kernel.org,
          acme@redhat.com, hpa@zytor.com, linux-kernel@vger.kernel.org,
          adrian.hunter@intel.com, mingo@kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf tools: Move branch structs to branch.h
Git-Commit-ID: f1a397f33743bbb7346cb01e41cc70ca318426e8
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

Commit-ID:  f1a397f33743bbb7346cb01e41cc70ca318426e8
Gitweb:     https://git.kernel.org/tip/f1a397f33743bbb7346cb01e41cc70ca318426e8
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Tue, 22 Jan 2019 10:58:22 -0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Fri, 25 Jan 2019 15:12:08 +0100

perf tools: Move branch structs to branch.h

We already have it, move those there from events.h so that we untangle
the header dependencies a bit more.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-pnbkqo8jxbi49d4f3yd3b5w3@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/branch.h | 27 ++++++++++++++++++++++++---
 tools/perf/util/event.h  | 21 +--------------------
 tools/perf/util/symbol.h |  1 +
 3 files changed, 26 insertions(+), 23 deletions(-)

diff --git a/tools/perf/util/branch.h b/tools/perf/util/branch.h
index 1e3c7c5cdc63..64f96b79f1d7 100644
--- a/tools/perf/util/branch.h
+++ b/tools/perf/util/branch.h
@@ -1,8 +1,31 @@
 #ifndef _PERF_BRANCH_H
 #define _PERF_BRANCH_H 1
 
+#include <stdio.h>
 #include <stdint.h>
-#include "../perf.h"
+#include <linux/perf_event.h>
+#include <linux/types.h>
+
+struct branch_flags {
+	u64 mispred:1;
+	u64 predicted:1;
+	u64 in_tx:1;
+	u64 abort:1;
+	u64 cycles:16;
+	u64 type:4;
+	u64 reserved:40;
+};
+
+struct branch_entry {
+	u64			from;
+	u64			to;
+	struct branch_flags	flags;
+};
+
+struct branch_stack {
+	u64			nr;
+	struct branch_entry	entries[0];
+};
 
 struct branch_type_stat {
 	bool	branch_to;
@@ -13,8 +36,6 @@ struct branch_type_stat {
 	u64	cross_2m;
 };
 
-struct branch_flags;
-
 void branch_type_count(struct branch_type_stat *st, struct branch_flags *flags,
 		       u64 from, u64 to);
 
diff --git a/tools/perf/util/event.h b/tools/perf/util/event.h
index dad32b81fe71..feba1aa819b4 100644
--- a/tools/perf/util/event.h
+++ b/tools/perf/util/event.h
@@ -161,26 +161,7 @@ struct ip_callchain {
 	u64 ips[0];
 };
 
-struct branch_flags {
-	u64 mispred:1;
-	u64 predicted:1;
-	u64 in_tx:1;
-	u64 abort:1;
-	u64 cycles:16;
-	u64 type:4;
-	u64 reserved:40;
-};
-
-struct branch_entry {
-	u64			from;
-	u64			to;
-	struct branch_flags	flags;
-};
-
-struct branch_stack {
-	u64			nr;
-	struct branch_entry	entries[0];
-};
+struct branch_stack;
 
 enum {
 	PERF_IP_FLAG_BRANCH		= 1ULL << 0,
diff --git a/tools/perf/util/symbol.h b/tools/perf/util/symbol.h
index 277841e3dbd1..956d9916e364 100644
--- a/tools/perf/util/symbol.h
+++ b/tools/perf/util/symbol.h
@@ -12,6 +12,7 @@
 #include <stdio.h>
 #include <byteswap.h>
 #include <libgen.h>
+#include "branch.h"
 #include "build-id.h"
 #include "event.h"
 #include "path.h"
