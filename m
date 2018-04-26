Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753520AbeDZFx6 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 01:53:58 -0400
Received: from terminus.zytor.com ([198.137.202.136]:34761 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751647AbeDZFxx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 01:53:53 -0400
Date: Wed, 25 Apr 2018 22:53:31 -0700
From: tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-129193bb0c43d42f1c397c175346e3e0dba5a578@git.kernel.org>
Cc: acme@redhat.com, alexander.shishkin@linux.intel.com, dsahern@gmail.com,
        tglx@linutronix.de, linux-kernel@vger.kernel.org, mingo@kernel.org,
        hpa@zytor.com, jolsa@kernel.org, namhyung@kernel.org,
        peterz@infradead.org
Reply-To: namhyung@kernel.org, peterz@infradead.org, hpa@zytor.com,
        mingo@kernel.org, jolsa@kernel.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, acme@redhat.com, dsahern@gmail.com,
        alexander.shishkin@linux.intel.com
In-Reply-To: <20180423090823.32309-4-jolsa@kernel.org>
References: <20180423090823.32309-4-jolsa@kernel.org>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf stat: Keep the / modifier separator in
 fallback
Git-Commit-ID: 129193bb0c43d42f1c397c175346e3e0dba5a578
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

Commit-ID:  129193bb0c43d42f1c397c175346e3e0dba5a578
Gitweb:     https://git.kernel.org/tip/129193bb0c43d42f1c397c175346e3e0dba5a578
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Mon, 23 Apr 2018 11:08:17 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 23 Apr 2018 11:14:10 -0300

perf stat: Keep the / modifier separator in fallback

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
