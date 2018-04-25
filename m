Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755532AbeDYQDQ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 12:03:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:46936 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755186AbeDYQAa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 12:00:30 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAB0E217DF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        David Ahern <dsahern@gmail.com>, Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 04/12] perf stat: Keep the / modifier separator in fallback
Date: Wed, 25 Apr 2018 13:00:00 -0300
Message-Id: <20180425160008.3407-5-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180425160008.3407-1-acme@kernel.org>
References: <20180425160008.3407-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

The 'perf stat' fallback for EACCES error sets the exclude_kernel
perf_event_attr and tries perf_event_open() again with it. In addition,
it also changes the name of the event to reflect that change by adding
the 'u' modifier.

But it does not take into account the '/' separator, so the event name
can end up mangled, like: (note the '/:' characters)

  $ perf stat -e cpu/cpu-cycles/ kill
  ...
             386,832      cpu/cpu-cycles/:u

Adding the code to check on the '/' separator and set the following
correct event name:

  $ perf stat -e cpu/cpu-cycles/ kill
  ...
             388,548      cpu/cpu-cycles/u

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180423090823.32309-4-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/evsel.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 3e87486c28fe..7eb1e9850abf 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -2754,8 +2754,14 @@ bool perf_evsel__fallback(struct perf_evsel *evsel, int err,
 		   (paranoid = perf_event_paranoid()) > 1) {
 		const char *name = perf_evsel__name(evsel);
 		char *new_name;
+		const char *sep = ":";
 
-		if (asprintf(&new_name, "%s%su", name, strchr(name, ':') ? "" : ":") < 0)
+		/* Is there already the separator in the name. */
+		if (strchr(name, '/') ||
+		    strchr(name, ':'))
+			sep = "";
+
+		if (asprintf(&new_name, "%s%su", name, sep) < 0)
 			return false;
 
 		if (evsel->name)
-- 
2.14.3
