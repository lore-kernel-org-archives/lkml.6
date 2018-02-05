Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752587AbeBEVlP (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 16:41:15 -0500
Received: from terminus.zytor.com ([65.50.211.136]:35917 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752117AbeBEVkZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 16:40:25 -0500
Date: Mon, 5 Feb 2018 13:35:59 -0800
From: tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-49c0ae80eb32426fa133246200628e529067c595@git.kernel.org>
Cc: mingo@kernel.org, namhyung@kernel.org, linux-kernel@vger.kernel.org,
        alexander.shishkin@linux.intel.com, peterz@infradead.org,
        dsahern@gmail.com, hpa@zytor.com, jolsa@kernel.org, eranian@google.com,
        acme@redhat.com, ak@linux.intel.com, tglx@linutronix.de
Reply-To: peterz@infradead.org, dsahern@gmail.com,
        alexander.shishkin@linux.intel.com, mingo@kernel.org,
        linux-kernel@vger.kernel.org, namhyung@kernel.org, tglx@linutronix.de,
        ak@linux.intel.com, eranian@google.com, acme@redhat.com, hpa@zytor.com,
        jolsa@kernel.org
In-Reply-To: <20180201083812.11359-2-jolsa@kernel.org>
References: <20180201083812.11359-2-jolsa@kernel.org>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf evsel: Fix period/freq terms setup
Git-Commit-ID: 49c0ae80eb32426fa133246200628e529067c595
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

Commit-ID:  49c0ae80eb32426fa133246200628e529067c595
Gitweb:     https://git.kernel.org/tip/49c0ae80eb32426fa133246200628e529067c595
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Thu, 1 Feb 2018 09:38:10 +0100
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 5 Feb 2018 12:11:58 -0300

perf evsel: Fix period/freq terms setup

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
index 66fa451..f2f2eaa 100644
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
