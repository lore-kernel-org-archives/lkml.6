Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752561AbeCEOg4 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 09:36:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:52920 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752571AbeCEOag (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 09:30:36 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25CD021770
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
Subject: [PATCH 09/28] perf record: Allow asking for the maximum allowed sample rate
Date: Mon,  5 Mar 2018 11:29:13 -0300
Message-Id: <20180305142932.16921-10-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180305142932.16921-1-acme@kernel.org>
References: <20180305142932.16921-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Add the handy '-F max' shortcut to reading and using the
kernel.perf_event_max_sample_rate value as the user supplied
sampling frequency:

  # perf record -F max sleep 1
  info: Using a maximum frequency rate of 15,000 Hz
  [ perf record: Woken up 1 times to write data ]
  [ perf record: Captured and wrote 0.019 MB perf.data (14 samples) ]
  # sysctl kernel.perf_event_max_sample_rate
  kernel.perf_event_max_sample_rate = 15000
  # perf evlist -v
  cycles:ppp: size: 112, { sample_period, sample_freq }: 15000, sample_type: IP|TID|TIME|PERIOD, disabled: 1, inherit: 1, mmap: 1, comm: 1, freq: 1, enable_on_exec: 1, task: 1, precise_ip: 3, sample_id_all: 1, exclude_guest: 1, mmap2: 1, comm_exec: 1

  # perf record -F 10 sleep 1
  [ perf record: Woken up 1 times to write data ]
  [ perf record: Captured and wrote 0.019 MB perf.data (4 samples) ]
  # perf evlist -v
  cycles:ppp: size: 112, { sample_period, sample_freq }: 10, sample_type: IP|TID|TIME|PERIOD, disabled: 1, inherit: 1, mmap: 1, comm: 1, freq: 1, enable_on_exec: 1, task: 1, precise_ip: 3, sample_id_all: 1, exclude_guest: 1, mmap2: 1, comm_exec: 1
  #

Suggested-by: Ingo Molnar <mingo@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-4y0tiuws62c64gp4cf0hme0m@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-record.txt |  4 +++-
 tools/perf/builtin-record.c              |  7 ++++++-
 tools/perf/perf.h                        |  2 ++
 tools/perf/util/record.c                 | 23 +++++++++++++++++++++++
 4 files changed, 34 insertions(+), 2 deletions(-)

diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
index 76bc2181d214..94f2faebc7f0 100644
--- a/tools/perf/Documentation/perf-record.txt
+++ b/tools/perf/Documentation/perf-record.txt
@@ -193,7 +193,9 @@ OPTIONS
 	Child tasks do not inherit counters.
 -F::
 --freq=::
-	Profile at this frequency.
+	Profile at this frequency. Use 'max' to use the currently maximum
+	allowed frequency, i.e. the value in the kernel.perf_event_max_sample_rate
+	sysctl.
 
 -m::
 --mmap-pages=::
diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 907267206973..e1821eea14ef 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -45,6 +45,7 @@
 
 #include <errno.h>
 #include <inttypes.h>
+#include <locale.h>
 #include <poll.h>
 #include <unistd.h>
 #include <sched.h>
@@ -1542,7 +1543,9 @@ static struct option __record_options[] = {
 	OPT_BOOLEAN(0, "tail-synthesize", &record.opts.tail_synthesize,
 		    "synthesize non-sample events at the end of output"),
 	OPT_BOOLEAN(0, "overwrite", &record.opts.overwrite, "use overwrite mode"),
-	OPT_UINTEGER('F', "freq", &record.opts.user_freq, "profile at this frequency"),
+	OPT_CALLBACK('F', "freq", &record.opts, "freq or 'max'",
+		     "profile at this frequency",
+		      record__parse_freq),
 	OPT_CALLBACK('m', "mmap-pages", &record.opts, "pages[,pages]",
 		     "number of mmap data pages and AUX area tracing mmap pages",
 		     record__parse_mmap_pages),
@@ -1651,6 +1654,8 @@ int cmd_record(int argc, const char **argv)
 	struct record *rec = &record;
 	char errbuf[BUFSIZ];
 
+	setlocale(LC_ALL, "");
+
 #ifndef HAVE_LIBBPF_SUPPORT
 # define set_nobuild(s, l, c) set_option_nobuild(record_options, s, l, "NO_LIBBPF=1", c)
 	set_nobuild('\0', "clang-path", true);
diff --git a/tools/perf/perf.h b/tools/perf/perf.h
index cfe46236a5e5..a5df8bf73a68 100644
--- a/tools/perf/perf.h
+++ b/tools/perf/perf.h
@@ -82,4 +82,6 @@ struct record_opts {
 struct option;
 extern const char * const *record_usage;
 extern struct option *record_options;
+
+int record__parse_freq(const struct option *opt, const char *str, int unset);
 #endif
diff --git a/tools/perf/util/record.c b/tools/perf/util/record.c
index 1e97937b03a9..acabf54ceccb 100644
--- a/tools/perf/util/record.c
+++ b/tools/perf/util/record.c
@@ -5,6 +5,7 @@
 #include "parse-events.h"
 #include <errno.h>
 #include <api/fs/fs.h>
+#include <subcmd/parse-options.h>
 #include "util.h"
 #include "cloexec.h"
 
@@ -287,3 +288,25 @@ bool perf_evlist__can_select_event(struct perf_evlist *evlist, const char *str)
 	perf_evlist__delete(temp_evlist);
 	return ret;
 }
+
+int record__parse_freq(const struct option *opt, const char *str, int unset __maybe_unused)
+{
+	unsigned int freq;
+	struct record_opts *opts = opt->value;
+
+	if (!str)
+		return -EINVAL;
+
+	if (strcasecmp(str, "max") == 0) {
+		if (get_max_rate(&freq)) {
+			pr_err("couldn't read /proc/sys/kernel/perf_event_max_sample_rate\n");
+			return -1;
+		}
+		pr_info("info: Using a maximum frequency rate of %'d Hz\n", freq);
+	} else {
+		freq = atoi(str);
+	}
+
+	opts->user_freq = freq;
+	return 0;
+}
-- 
2.14.3
