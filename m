Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753243AbeDZF5s (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 01:57:48 -0400
Received: from terminus.zytor.com ([198.137.202.136]:46085 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751984AbeDZF5q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 01:57:46 -0400
Date: Wed, 25 Apr 2018 22:57:19 -0700
From: tip-bot for Kan Liang <tipbot@zytor.com>
Message-ID: <tip-121f325f34caf9a7654ec8a50e20942ed9d6dafc@git.kernel.org>
Cc: peterz@infradead.org, tglx@linutronix.de, yao.jin@linux.intel.com,
        will.deacon@arm.com, kan.liang@linux.intel.com, ak@linux.intel.com,
        hpa@zytor.com, linux-kernel@vger.kernel.org, mingo@kernel.org,
        jolsa@redhat.com, acme@redhat.com, ganapatrao.kulkarni@cavium.com,
        agustinv@codeaurora.org, namhyung@kernel.org,
        zhangshaokun@hisilicon.com
Reply-To: will.deacon@arm.com, yao.jin@linux.intel.com,
        kan.liang@linux.intel.com, peterz@infradead.org, tglx@linutronix.de,
        ak@linux.intel.com, hpa@zytor.com, linux-kernel@vger.kernel.org,
        agustinv@codeaurora.org, zhangshaokun@hisilicon.com,
        namhyung@kernel.org, jolsa@redhat.com, mingo@kernel.org,
        acme@redhat.com, ganapatrao.kulkarni@cavium.com
In-Reply-To: <1524594014-79243-3-git-send-email-kan.liang@linux.intel.com>
References: <1524594014-79243-3-git-send-email-kan.liang@linux.intel.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf evsel: Only fall back group read for leader
Git-Commit-ID: 121f325f34caf9a7654ec8a50e20942ed9d6dafc
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

Commit-ID:  121f325f34caf9a7654ec8a50e20942ed9d6dafc
Gitweb:     https://git.kernel.org/tip/121f325f34caf9a7654ec8a50e20942ed9d6dafc
Author:     Kan Liang <kan.liang@linux.intel.com>
AuthorDate: Tue, 24 Apr 2018 11:20:12 -0700
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 24 Apr 2018 16:11:59 -0300

perf evsel: Only fall back group read for leader

Perf doesn't support mixed events from different PMUs (except software
event) in a group. The perf stat should output <not counted>/<not
supported> for all events, but it doesn't. For example,

  perf stat -e '{cycles,uncore_imc_5/umask=0xF,event=0x4/,instructions}'
       <not counted>      cycles
       <not supported>    uncore_imc_5/umask=0xF,event=0x4/
           1,024,300      instructions

If perf fails to open an event, it doesn't error out directly. It will
disable some features and retry, until the event is opened or all
features are disabled. The disabled features will not be re-enabled. The
group read is one of these features.

For the example as above, the IMC event and the leader event "cycles"
are from different PMUs. Opening the IMC event must fail. The group read
feature must be disabled for IMC event and the followed event
"instructions". The "instructions" event has the same PMU as the leader
"cycles". It can be opened successfully. Since the group read feature
has been disabled, the "instructions" event will be read as a single
event, which definitely has a value.

The group read fallback is still useful for the case which kernel
doesn't support group read. It is good enough to be handled only by the
leader.

For the fallback request from members, it must be caused by an error.
The fallback only breaks the semantics of group.  Limit the group read
fallback only for the leader.

Committer testing:

On a broadwell t450s notebook:

Before:

  # perf stat -e '{cycles,unc_cbo_cache_lookup.read_i,instructions}' sleep 1

  Performance counter stats for 'sleep 1':

     <not counted>      cycles
   <not supported>      unc_cbo_cache_lookup.read_i
           818,206      instructions

       1.003170887 seconds time elapsed

  Some events weren't counted. Try disabling the NMI watchdog:
	echo 0 > /proc/sys/kernel/nmi_watchdog
	perf stat ...
	echo 1 > /proc/sys/kernel/nmi_watchdog

After:

  # perf stat -e '{cycles,unc_cbo_cache_lookup.read_i,instructions}' sleep 1

  Performance counter stats for 'sleep 1':

     <not counted>      cycles
   <not supported>      unc_cbo_cache_lookup.read_i
     <not counted>      instructions

       1.001380511 seconds time elapsed

  Some events weren't counted. Try disabling the NMI watchdog:
	echo 0 > /proc/sys/kernel/nmi_watchdog
	perf stat ...
	echo 1 > /proc/sys/kernel/nmi_watchdog
  #

Reported-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Agustin Vega-Frias <agustinv@codeaurora.org>
Cc: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Shaokun Zhang <zhangshaokun@hisilicon.com>
Cc: Will Deacon <will.deacon@arm.com>
Fixes:  82bf311e15d2 ("perf stat: Use group read for event groups")
Link: http://lkml.kernel.org/r/1524594014-79243-3-git-send-email-kan.liang@linux.intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/evsel.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 26bdeecc0452..4cd2cf93f726 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1925,7 +1925,8 @@ try_fallback:
 		goto fallback_missing_features;
 	} else if (!perf_missing_features.group_read &&
 		    evsel->attr.inherit &&
-		   (evsel->attr.read_format & PERF_FORMAT_GROUP)) {
+		   (evsel->attr.read_format & PERF_FORMAT_GROUP) &&
+		   perf_evsel__is_group_leader(evsel)) {
 		perf_missing_features.group_read = true;
 		pr_debug2("switching off group read\n");
 		goto fallback_missing_features;
