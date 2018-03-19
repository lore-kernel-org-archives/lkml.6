Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S970792AbeCSTFw (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 15:05:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:41544 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S970594AbeCSTB4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 15:01:56 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10706217D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        David Ahern <dsahern@gmail.com>, Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 03/14] perf record: Synthesize features before events in pipe mode
Date: Mon, 19 Mar 2018 16:01:25 -0300
Message-Id: <20180319190136.7441-4-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180319190136.7441-1-acme@kernel.org>
References: <20180319190136.7441-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

We need to synthesize events first, because some features works on top
of them (on report side).

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Tested-by: Stephane Eranian <eranian@google.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180314092205.23291-1-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-record.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index d33103291b02..22ebeb92ac51 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -754,13 +754,10 @@ static int record__synthesize(struct record *rec, bool tail)
 		return 0;
 
 	if (data->is_pipe) {
-		err = perf_event__synthesize_features(
-			tool, session, rec->evlist, process_synthesized_event);
-		if (err < 0) {
-			pr_err("Couldn't synthesize features.\n");
-			return err;
-		}
-
+		/*
+		 * We need to synthesize events first, because some
+		 * features works on top of them (on report side).
+		 */
 		err = perf_event__synthesize_attrs(tool, session,
 						   process_synthesized_event);
 		if (err < 0) {
@@ -768,6 +765,13 @@ static int record__synthesize(struct record *rec, bool tail)
 			goto out;
 		}
 
+		err = perf_event__synthesize_features(tool, session, rec->evlist,
+						      process_synthesized_event);
+		if (err < 0) {
+			pr_err("Couldn't synthesize features.\n");
+			return err;
+		}
+
 		if (have_tracepoints(&rec->evlist->entries)) {
 			/*
 			 * FIXME err <= 0 here actually means that
-- 
2.14.3
