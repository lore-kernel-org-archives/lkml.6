Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753216AbeCFGof (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 01:44:35 -0500
Received: from terminus.zytor.com ([198.137.202.136]:56297 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753164AbeCFGod (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 01:44:33 -0500
Date: Mon, 5 Mar 2018 22:44:22 -0800
From: tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-4y0tiuws62c64gp4cf0hme0m@git.kernel.org>
Cc: dsahern@gmail.com, tglx@linutronix.de, namhyung@kernel.org,
        hpa@zytor.com, linux-kernel@vger.kernel.org, mingo@kernel.org,
        jolsa@kernel.org, wangnan0@huawei.com, acme@redhat.com,
        adrian.hunter@intel.com
Reply-To: tglx@linutronix.de, dsahern@gmail.com, namhyung@kernel.org,
        hpa@zytor.com, mingo@kernel.org, linux-kernel@vger.kernel.org,
        jolsa@kernel.org, wangnan0@huawei.com, adrian.hunter@intel.com,
        acme@redhat.com
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf record: Allow asking for the maximum allowed
 sample rate
Git-Commit-ID: 67230479b2304be99e9451ee171aa288a112ea16
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

Commit-ID:  67230479b2304be99e9451ee171aa288a112ea16
Gitweb:     https://git.kernel.org/tip/67230479b2304be99e9451ee171aa288a112ea16
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Thu, 1 Mar 2018 13:46:23 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 5 Mar 2018 09:58:43 -0300

perf record: Allow asking for the maximum allowed sample rate

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
 
@@ -287,3 +288,25 @@ out_delete:
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
