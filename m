Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753780AbeDZF4D (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 01:56:03 -0400
Received: from terminus.zytor.com ([198.137.202.136]:51669 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753547AbeDZFz5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 01:55:57 -0400
Date: Wed, 25 Apr 2018 22:54:37 -0700
From: tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-e9add8bac6c69edb4bf391e537faa659b2ed70d2@git.kernel.org>
Cc: peterz@infradead.org, kan.liang@linux.intel.com, dsahern@gmail.com,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org, hpa@zytor.com,
        namhyung@kernel.org, mingo@kernel.org, acme@redhat.com
Reply-To: peterz@infradead.org, kan.liang@linux.intel.com, dsahern@gmail.com,
        tglx@linutronix.de, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, linux-kernel@vger.kernel.org, namhyung@kernel.org,
        mingo@kernel.org, hpa@zytor.com, acme@redhat.com
In-Reply-To: <20180423090823.32309-6-jolsa@kernel.org>
References: <20180423090823.32309-6-jolsa@kernel.org>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf evsel: Disable write_backward for leader
 sampling group events
Git-Commit-ID: e9add8bac6c69edb4bf391e537faa659b2ed70d2
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

Commit-ID:  e9add8bac6c69edb4bf391e537faa659b2ed70d2
Gitweb:     https://git.kernel.org/tip/e9add8bac6c69edb4bf391e537faa659b2ed70d2
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Mon, 23 Apr 2018 11:08:19 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 23 Apr 2018 11:21:56 -0300

perf evsel: Disable write_backward for leader sampling group events

.. and other related fields that do not need to be enabled
for events that have sampling leader.

It fixes the perf top usage Ingo reported broken:

  # perf top -e '{cycles,msr/aperf/}:S'

The 'msr/aperf/' event is configured for write_back sampling, which is
not allowed by the MSR PMU, so it fails to create the event.

Adjusting related attr test.

Reported-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180423090823.32309-6-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
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
index 7eb1e9850abf..26bdeecc0452 100644
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
