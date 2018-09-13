Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60C05C04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 12:58:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 190F820854
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 12:58:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 190F820854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728106AbeIMSEl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 14:04:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60568 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727872AbeIMSEj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 14:04:39 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5871A65991;
        Thu, 13 Sep 2018 12:55:18 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.10])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7A92A600C6;
        Thu, 13 Sep 2018 12:55:16 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andi Kleen <andi@firstfloor.org>,
        Alexey Budankov <alexey.budankov@linux.intel.com>
Subject: [PATCH 11/48] perf tools: Handle indexed data file properly
Date:   Thu, 13 Sep 2018 14:54:13 +0200
Message-Id: <20180913125450.21342-12-jolsa@kernel.org>
In-Reply-To: <20180913125450.21342-1-jolsa@kernel.org>
References: <20180913125450.21342-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Thu, 13 Sep 2018 12:55:18 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Namhyung Kim <namhyung@kernel.org>

When perf detects data file has index table, process header part first
and then rest data files in a row.  Note that the indexed sample data is
recorded for each cpu/thread separately, it's already ordered with
respect to themselves so no need to use the ordered event queue
interface.

Link: http://lkml.kernel.org/n/tip-pqgpc6m32s2cwprxpom9871g@git.kernel.org
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/builtin-record.c |  2 ++
 tools/perf/perf.c           |  1 +
 tools/perf/perf.h           |  2 ++
 tools/perf/util/header.c    |  1 +
 tools/perf/util/session.c   | 52 ++++++++++++++++++++++++++++++-------
 5 files changed, 48 insertions(+), 10 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index b5deda2e890c..9690c1f3e666 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -53,6 +53,8 @@
 #include <sys/mman.h>
 #include <sys/wait.h>
 #include <linux/time64.h>
+#include <sys/types.h>
+#include <sys/stat.h>
 
 struct switch_output {
 	bool		 enabled;
diff --git a/tools/perf/perf.c b/tools/perf/perf.c
index a11cb006f968..989ea9799c88 100644
--- a/tools/perf/perf.c
+++ b/tools/perf/perf.c
@@ -38,6 +38,7 @@ const char perf_more_info_string[] =
 
 static int use_pager = -1;
 const char *input_name;
+bool perf_has_index;
 
 struct cmd_struct {
 	const char *cmd;
diff --git a/tools/perf/perf.h b/tools/perf/perf.h
index 21bf7f5a3cf5..fba61cc5291f 100644
--- a/tools/perf/perf.h
+++ b/tools/perf/perf.h
@@ -37,6 +37,8 @@ void pthread__unblock_sigwinch(void);
 
 #include "util/target.h"
 
+extern bool perf_has_index;
+
 struct record_opts {
 	struct target target;
 	bool	     group;
diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index b097bcc35d34..08ccd38e8eca 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -2603,6 +2603,7 @@ static int process_data_index(struct feat_fd *ff, void *data __maybe_unused)
 
 	ph->index = idx;
 	ph->nr_index = nr_idx;
+	perf_has_index = true;
 	return 0;
 }
 
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 7d2c8ce6cfad..15314052084d 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -1840,7 +1840,9 @@ static int __perf_session__process_events(struct perf_session *session,
 	mmap_size = MMAP_SIZE;
 	if (mmap_size > file_size) {
 		mmap_size = file_size;
-		session->one_mmap = true;
+
+		if (!perf_has_index)
+			session->one_mmap = true;
 	}
 
 	memset(mmaps, 0, sizeof(mmaps));
@@ -1918,8 +1920,6 @@ static int __perf_session__process_events(struct perf_session *session,
 	err = perf_session__flush_thread_stacks(session);
 out_err:
 	ui_progress__finish();
-	if (!tool->no_warn)
-		perf_session__warn_about_errors(session);
 	/*
 	 * We may switching perf.data output, make ordered_events
 	 * reusable.
@@ -1930,20 +1930,52 @@ static int __perf_session__process_events(struct perf_session *session,
 	return err;
 }
 
+static int __perf_session__process_indexed_events(struct perf_session *session)
+{
+	struct perf_tool *tool = session->tool;
+	int err = 0, i;
+
+	for (i = 0; i < (int)session->header.nr_index; i++) {
+		struct perf_file_section *idx = &session->header.index[i];
+
+		if (!idx->size)
+			continue;
+
+		err = __perf_session__process_events(session, idx->offset,
+						     idx->size,
+						     idx->offset + idx->size);
+		if (err < 0)
+			break;
+	}
+
+	if (!tool->no_warn)
+		perf_session__warn_about_errors(session);
+
+	return err;
+}
+
 int perf_session__process_events(struct perf_session *session)
 {
-	u64 size = perf_data__size(session->data);
+	struct perf_tool *tool = session->tool;
+	struct perf_data *data = session->data;
+	u64 size = perf_data__size(data);
 	int err;
 
 	if (perf_session__register_idle_thread(session) < 0)
 		return -ENOMEM;
 
-	if (!perf_data__is_pipe(session->data))
-		err = __perf_session__process_events(session,
-						     session->header.data_offset,
-						     session->header.data_size, size);
-	else
-		err = __perf_session__process_pipe_events(session);
+	if (perf_data__is_pipe(data))
+		return __perf_session__process_pipe_events(session);
+	if (perf_has_index)
+		return __perf_session__process_indexed_events(session);
+
+	err = __perf_session__process_events(session,
+					     session->header.data_offset,
+					     session->header.data_size,
+					     size);
+
+	if (!tool->no_warn)
+		perf_session__warn_about_errors(session);
 
 	return err;
 }
-- 
2.17.1

