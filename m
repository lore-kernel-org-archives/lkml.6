Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754651AbeDWJJy (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 05:09:54 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36660 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754404AbeDWJIe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 05:08:34 -0400
From: Jiri Olsa <jolsa@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Kan Liang <kan.liang@intel.com>, lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        David Ahern <dsahern@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: [PATCH 5/9] perf tools: Disable write_backward for leader sampling group events
Date: Mon, 23 Apr 2018 11:08:19 +0200
Message-Id: <20180423090823.32309-6-jolsa@kernel.org>
In-Reply-To: <20180423090823.32309-1-jolsa@kernel.org>
References: <20180423090823.32309-1-jolsa@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

.. and other related fields that do not need to be enabled
for events that have sampling leader.

It fixes the perf top usage Ingo reported broken:

  # perf top -e '{cycles,msr/aperf/}:S'

The msr/aperf/ is configured for write_back sampling, which
is not allowed by msr pmu, so it fails to create the event.

Adjusting related attr test.

Reported-by: Ingo Molnar <mingo@kernel.org>
Cc: Kan Liang <kan.liang@intel.com>
Link: http://lkml.kernel.org/n/tip-bh7wxrci19km6iwbv4qg555o@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/tests/attr/test-record-group-sampling | 3 +++
 tools/perf/util/evsel.c                          | 7 +++++--
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/tools/perf/tests/attr/test-record-group-sampling b/tools/perf/tests/attr/test-record-group-sampling
index f906b793196f..8a33ca4f9e1f 100644
--- a/tools/perf/tests/attr/test-record-group-sampling
+++ b/tools/perf/tests/attr/test-record-group-sampling
@@ -35,3 +35,6 @@ inherit=0
 # sampling disabled
 sample_freq=0
 sample_period=0
+freq=0
+write_backward=0
+sample_id_all=0
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 7472f876cd70..81b7f1cdc956 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -930,8 +930,11 @@ void perf_evsel__config(struct perf_evsel *evsel, struct record_opts *opts,
 	 * than leader in case leader 'leads' the sampling.
 	 */
 	if ((leader != evsel) && leader->sample_read) {
-		attr->sample_freq   = 0;
-		attr->sample_period = 0;
+		attr->freq           = 0;
+		attr->sample_freq    = 0;
+		attr->sample_period  = 0;
+		attr->write_backward = 0;
+		attr->sample_id_all  = 0;
 	}
 
 	if (opts->no_samples)
-- 
2.13.6
