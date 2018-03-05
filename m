Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752726AbeCEOaz (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 09:30:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:53016 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751400AbeCEOan (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 09:30:43 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A6A921770
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
Subject: [PATCH 12/28] perf record: Throttle user defined frequencies to the maximum allowed
Date: Mon,  5 Mar 2018 11:29:16 -0300
Message-Id: <20180305142932.16921-13-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180305142932.16921-1-acme@kernel.org>
References: <20180305142932.16921-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

  # perf record -F 200000 sleep 1
  warning: Maximum frequency rate (15,000 Hz) exceeded, throttling from 200,000 Hz to 15,000 Hz.
           The limit can be raised via /proc/sys/kernel/perf_event_max_sample_rate.
           The kernel will lower it when perf's interrupts take too long.
	   Use --strict-freq to disable this throttling, refusing to record.
  [ perf record: Woken up 1 times to write data ]
  [ perf record: Captured and wrote 0.019 MB perf.data (15 samples) ]
  # perf evlist -v
  cycles:ppp: size: 112, { sample_period, sample_freq }: 15000, sample_type: IP|TID|TIME|PERIOD, disabled: 1, inherit: 1, mmap: 1, comm: 1, freq: 1, enable_on_exec: 1, task: 1, precise_ip: 3, sample_id_all: 1, exclude_guest: 1, mmap2: 1, comm_exec: 1

For those wanting that it fails if the desired frequency can't be used:

  # perf record --strict-freq -F 200000 sleep 1
  error: Maximum frequency rate (15,000 Hz) exceeded.
         Please use -F freq option with a lower value or consider
         tweaking /proc/sys/kernel/perf_event_max_sample_rate.
  #

Suggested-by: Ingo Molnar <mingo@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-oyebruc44nlja499nqkr1nzn@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-record.txt |  7 ++++++-
 tools/perf/builtin-record.c              |  2 ++
 tools/perf/perf.h                        |  1 +
 tools/perf/util/record.c                 | 20 +++++++++++++++-----
 4 files changed, 24 insertions(+), 6 deletions(-)

diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
index 94f2faebc7f0..cc37b3a4be76 100644
--- a/tools/perf/Documentation/perf-record.txt
+++ b/tools/perf/Documentation/perf-record.txt
@@ -191,11 +191,16 @@ OPTIONS
 -i::
 --no-inherit::
 	Child tasks do not inherit counters.
+
 -F::
 --freq=::
 	Profile at this frequency. Use 'max' to use the currently maximum
 	allowed frequency, i.e. the value in the kernel.perf_event_max_sample_rate
-	sysctl.
+	sysctl. Will throttle down to the currently maximum allowed frequency.
+	See --strict-freq.
+
+--strict-freq::
+	Fail if the specified frequency can't be used.
 
 -m::
 --mmap-pages=::
diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index e1821eea14ef..62387942a1d5 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -1543,6 +1543,8 @@ static struct option __record_options[] = {
 	OPT_BOOLEAN(0, "tail-synthesize", &record.opts.tail_synthesize,
 		    "synthesize non-sample events at the end of output"),
 	OPT_BOOLEAN(0, "overwrite", &record.opts.overwrite, "use overwrite mode"),
+	OPT_BOOLEAN(0, "strict-freq", &record.opts.strict_freq,
+		    "Fail if the specified frequency can't be used"),
 	OPT_CALLBACK('F', "freq", &record.opts, "freq or 'max'",
 		     "profile at this frequency",
 		      record__parse_freq),
diff --git a/tools/perf/perf.h b/tools/perf/perf.h
index a5df8bf73a68..007e0dfd5ce3 100644
--- a/tools/perf/perf.h
+++ b/tools/perf/perf.h
@@ -61,6 +61,7 @@ struct record_opts {
 	bool	     tail_synthesize;
 	bool	     overwrite;
 	bool	     ignore_missing_thread;
+	bool	     strict_freq;
 	unsigned int freq;
 	unsigned int mmap_pages;
 	unsigned int auxtrace_mmap_pages;
diff --git a/tools/perf/util/record.c b/tools/perf/util/record.c
index acabf54ceccb..4f1a82e76d39 100644
--- a/tools/perf/util/record.c
+++ b/tools/perf/util/record.c
@@ -216,11 +216,21 @@ static int record_opts__config_freq(struct record_opts *opts)
 	 * User specified frequency is over current maximum.
 	 */
 	if (user_freq && (max_rate < opts->freq)) {
-		pr_err("Maximum frequency rate (%u) reached.\n"
-		   "Please use -F freq option with lower value or consider\n"
-		   "tweaking /proc/sys/kernel/perf_event_max_sample_rate.\n",
-		   max_rate);
-		return -1;
+		if (opts->strict_freq) {
+			pr_err("error: Maximum frequency rate (%'u Hz) exceeded.\n"
+			       "       Please use -F freq option with a lower value or consider\n"
+			       "       tweaking /proc/sys/kernel/perf_event_max_sample_rate.\n",
+			       max_rate);
+			return -1;
+		} else {
+			pr_warning("warning: Maximum frequency rate (%'u Hz) exceeded, throttling from %'u Hz to %'u Hz.\n"
+				   "         The limit can be raised via /proc/sys/kernel/perf_event_max_sample_rate.\n"
+				   "         The kernel will lower it when perf's interrupts take too long.\n"
+				   "         Use --strict-freq to disable this throttling, refusing to record.\n",
+				   max_rate, opts->freq, max_rate);
+
+			opts->freq = max_rate;
+		}
 	}
 
 	/*
-- 
2.14.3
