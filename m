Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751948AbeBAIiW (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 03:38:22 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39176 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751910AbeBAIiU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 03:38:20 -0500
From: Jiri Olsa <jolsa@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: lkml <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, David Ahern <dsahern@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Stephane Eranian <eranian@google.com>
Subject: [PATCH 1/3] perf tools: Fix period/freq terms setup
Date: Thu,  1 Feb 2018 09:38:10 +0100
Message-Id: <20180201083812.11359-2-jolsa@kernel.org>
In-Reply-To: <20180201083812.11359-1-jolsa@kernel.org>
References: <20180201083812.11359-1-jolsa@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Stephane reported that we don't set properly PERIOD
sample type for events with period term defined.

Before:
  $ perf record -e cpu/cpu-cycles,period=1000/u ls
  $ perf evlist -v
  cpu/cpu-cycles,period=1000/u: ... sample_type: IP|TID|TIME|PERIOD, ...

After:
  $ perf record -e cpu/cpu-cycles,period=1000/u ls
  $ perf evlist -v
  cpu/cpu-cycles,period=1000/u: ... sample_type: IP|TID|TIME, ...

Setting PERIOD sample type based on period term setup.

Reported-by: Stephane Eranian <eranian@google.com>
Link: http://lkml.kernel.org/n/tip-anrtntkwfto5rqulegfwitn5@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
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
2.13.6
