Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751981AbeCNJWL (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 05:22:11 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49540 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751399AbeCNJWI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 05:22:08 -0400
From: Jiri Olsa <jolsa@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: lkml <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, David Ahern <dsahern@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Stephane Eranian <eranian@google.com>
Subject: [PATCH 1/2] perf record: Synthesize features before events in pipe mode
Date: Wed, 14 Mar 2018 10:22:04 +0100
Message-Id: <20180314092205.23291-1-jolsa@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We need to synthesize events first, because some
features works on top of them (on report side).

Link: http://lkml.kernel.org/n/tip-vz436m6fobfz8ykmuxo8phyy@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
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
2.13.6
