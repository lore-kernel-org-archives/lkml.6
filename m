Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752246AbeBET6s (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 14:58:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:56382 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751788AbeBET4w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 14:56:52 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B59F214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>, David Ahern <dsahern@gmail.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 06/10] perf evsel: Fix period/freq terms setup
Date: Mon,  5 Feb 2018 16:56:16 -0300
Message-Id: <20180205195620.9010-7-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180205195620.9010-1-acme@kernel.org>
References: <20180205195620.9010-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Stephane reported that we don't set properly PERIOD sample type for
events with period term defined.

Before:
  $ perf record -e cpu/cpu-cycles,period=1000/u ls
  $ perf evlist -v
  cpu/cpu-cycles,period=1000/u: ... sample_type: IP|TID|TIME|PERIOD, ...

After:
  $ perf record -e cpu/cpu-cycles,period=1000/u ls
  $ perf evlist -v
  cpu/cpu-cycles,period=1000/u: ... sample_type: IP|TID|TIME, ...

Setting PERIOD sample type based on period term setup.

Committer note:

When we use -c or a period=N term in the event definition, then we don't
need to ask the kernel, for this event, via perf_event_attr.sample_type
|= PERF_SAMPLE_PERIOD, to put the event period in each sample for this
event, as we know it already, it is in perf_event_attr.sample_period.

Reported-by: Stephane Eranian <eranian@google.com>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Tested-by: Stephane Eranian <eranian@google.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180201083812.11359-2-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/evsel.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 66fa45198a11..f2f2eaafde6d 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -745,12 +745,14 @@ static void apply_config_terms(struct perf_evsel *evsel,
 			if (!(term->weak && opts->user_interval != ULLONG_MAX)) {
 				attr->sample_period = term->val.period;
 				attr->freq = 0;
+				perf_evsel__reset_sample_bit(evsel, PERIOD);
 			}
 			break;
 		case PERF_EVSEL__CONFIG_TERM_FREQ:
 			if (!(term->weak && opts->user_freq != UINT_MAX)) {
 				attr->sample_freq = term->val.freq;
 				attr->freq = 1;
+				perf_evsel__set_sample_bit(evsel, PERIOD);
 			}
 			break;
 		case PERF_EVSEL__CONFIG_TERM_TIME:
-- 
2.14.3
