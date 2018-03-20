Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751978AbeCTGcf (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 02:32:35 -0400
Received: from terminus.zytor.com ([198.137.202.136]:35287 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751781AbeCTGcb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 02:32:31 -0400
Date: Mon, 19 Mar 2018 23:32:08 -0700
From: tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-a2015516c5c0be932a69e1d3405c2fb03b4eacf1@git.kernel.org>
Cc: eranian@google.com, alexander.shishkin@linux.intel.com,
        dsahern@gmail.com, acme@redhat.com, mingo@kernel.org,
        tglx@linutronix.de, hpa@zytor.com, linux-kernel@vger.kernel.org,
        jolsa@kernel.org, peterz@infradead.org, namhyung@kernel.org
Reply-To: peterz@infradead.org, namhyung@kernel.org, hpa@zytor.com,
        linux-kernel@vger.kernel.org, jolsa@kernel.org, tglx@linutronix.de,
        mingo@kernel.org, acme@redhat.com, dsahern@gmail.com,
        eranian@google.com, alexander.shishkin@linux.intel.com
In-Reply-To: <20180314092205.23291-1-jolsa@kernel.org>
References: <20180314092205.23291-1-jolsa@kernel.org>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf record: Synthesize features before events in
 pipe mode
Git-Commit-ID: a2015516c5c0be932a69e1d3405c2fb03b4eacf1
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  a2015516c5c0be932a69e1d3405c2fb03b4eacf1
Gitweb:     https://git.kernel.org/tip/a2015516c5c0be932a69e1d3405c2fb03b4eacf1
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Wed, 14 Mar 2018 10:22:04 +0100
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Fri, 16 Mar 2018 13:56:50 -0300

perf record: Synthesize features before events in pipe mode

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
