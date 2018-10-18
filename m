Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF9EBC5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 06:17:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B35B321477
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 06:17:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B35B321477
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727537AbeJRORS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 10:17:18 -0400
Received: from terminus.zytor.com ([198.137.202.136]:53561 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727331AbeJRORS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 10:17:18 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w9I6HXxl707592
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 17 Oct 2018 23:17:33 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w9I6HXVG707589;
        Wed, 17 Oct 2018 23:17:33 -0700
Date:   Wed, 17 Oct 2018 23:17:33 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-94aafb74cee0002e2f2eb6dc5376f54d5951ab4d@git.kernel.org>
Cc:     mpetlan@redhat.com, jolsa@kernel.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, acme@redhat.com,
        kan.liang@linux.intel.com, peterz@infradead.org, jolsa@redhat.com,
        mingo@kernel.org, ak@linux.intel.com, namhyung@kernel.org,
        alexander.shishkin@linux.intel.com, hpa@zytor.com
Reply-To: hpa@zytor.com, alexander.shishkin@linux.intel.com,
          namhyung@kernel.org, ak@linux.intel.com, mingo@kernel.org,
          jolsa@redhat.com, peterz@infradead.org,
          kan.liang@linux.intel.com, acme@redhat.com,
          linux-kernel@vger.kernel.org, tglx@linutronix.de,
          jolsa@kernel.org, mpetlan@redhat.com
In-Reply-To: <20181010080339.GB15790@krava>
References: <20181010080339.GB15790@krava>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf vendor events intel: Fix wrong filter_band*
 values for uncore events
Git-Commit-ID: 94aafb74cee0002e2f2eb6dc5376f54d5951ab4d
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  94aafb74cee0002e2f2eb6dc5376f54d5951ab4d
Gitweb:     https://git.kernel.org/tip/94aafb74cee0002e2f2eb6dc5376f54d5951ab4d
Author:     Jiri Olsa <jolsa@redhat.com>
AuthorDate: Wed, 10 Oct 2018 10:03:39 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 11 Oct 2018 11:13:23 -0300

perf vendor events intel: Fix wrong filter_band* values for uncore events

Michael reported that he could not stat following event:

  $ perf stat -e unc_p_freq_ge_1200mhz_cycles -a -- ls
  event syntax error: '..e_1200mhz_cycles'
                                    \___ value too big for format, maximum is 255
  Run 'perf list' for a list of valid events

The event is unwrapped into:

  uncore_pcu/event=0xb,filter_band0=1200/

where filter_band0 format says it's one byte only:

  # cat uncore_pcu/format/filter_band0
  config1:0-7

while JSON files specifies bigger number:

  "Filter": "filter_band0=1200",

all the filter_band* formats show 1 byte width:

  # cat uncore_pcu/format/filter_band1
  config1:8-15
  # cat uncore_pcu/format/filter_band2
  config1:16-23
  # cat uncore_pcu/format/filter_band3
  config1:24-31

The reason of the issue is that filter_band* values are supposed to be
in 100Mhz units.. it's stated in the JSON help for the events, like:

  filter_band3=XXX, with XXX in 100Mhz units

This patch divides the filter_band* values by 100, plus there's couple
of changes that actually change the number completely, like:

  -        "Filter": "edge=1,filter_band2=4000",
  +        "Filter": "edge=1,filter_band2=30",

Reported-by: Michael Petlan <mpetlan@redhat.com>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Acked-by: Andi Kleen <ak@linux.intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20181010080339.GB15790@krava
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/pmu-events/arch/x86/ivytown/uncore-power.json | 16 ++++++++--------
 .../perf/pmu-events/arch/x86/jaketown/uncore-power.json  | 16 ++++++++--------
 2 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/ivytown/uncore-power.json b/tools/perf/pmu-events/arch/x86/ivytown/uncore-power.json
index d40498f2cb1e..635c09fda1d9 100644
--- a/tools/perf/pmu-events/arch/x86/ivytown/uncore-power.json
+++ b/tools/perf/pmu-events/arch/x86/ivytown/uncore-power.json
@@ -188,7 +188,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0xb",
         "EventName": "UNC_P_FREQ_GE_1200MHZ_CYCLES",
-        "Filter": "filter_band0=1200",
+        "Filter": "filter_band0=12",
         "MetricExpr": "(UNC_P_FREQ_GE_1200MHZ_CYCLES / UNC_P_CLOCKTICKS) * 100.",
         "MetricName": "freq_ge_1200mhz_cycles %",
         "PerPkg": "1",
@@ -199,7 +199,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0xc",
         "EventName": "UNC_P_FREQ_GE_2000MHZ_CYCLES",
-        "Filter": "filter_band1=2000",
+        "Filter": "filter_band1=20",
         "MetricExpr": "(UNC_P_FREQ_GE_2000MHZ_CYCLES / UNC_P_CLOCKTICKS) * 100.",
         "MetricName": "freq_ge_2000mhz_cycles %",
         "PerPkg": "1",
@@ -210,7 +210,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0xd",
         "EventName": "UNC_P_FREQ_GE_3000MHZ_CYCLES",
-        "Filter": "filter_band2=3000",
+        "Filter": "filter_band2=30",
         "MetricExpr": "(UNC_P_FREQ_GE_3000MHZ_CYCLES / UNC_P_CLOCKTICKS) * 100.",
         "MetricName": "freq_ge_3000mhz_cycles %",
         "PerPkg": "1",
@@ -221,7 +221,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0xe",
         "EventName": "UNC_P_FREQ_GE_4000MHZ_CYCLES",
-        "Filter": "filter_band3=4000",
+        "Filter": "filter_band3=40",
         "MetricExpr": "(UNC_P_FREQ_GE_4000MHZ_CYCLES / UNC_P_CLOCKTICKS) * 100.",
         "MetricName": "freq_ge_4000mhz_cycles %",
         "PerPkg": "1",
@@ -232,7 +232,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0xb",
         "EventName": "UNC_P_FREQ_GE_1200MHZ_TRANSITIONS",
-        "Filter": "edge=1,filter_band0=1200",
+        "Filter": "edge=1,filter_band0=12",
         "MetricExpr": "(UNC_P_FREQ_GE_1200MHZ_CYCLES / UNC_P_CLOCKTICKS) * 100.",
         "MetricName": "freq_ge_1200mhz_cycles %",
         "PerPkg": "1",
@@ -243,7 +243,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0xc",
         "EventName": "UNC_P_FREQ_GE_2000MHZ_TRANSITIONS",
-        "Filter": "edge=1,filter_band1=2000",
+        "Filter": "edge=1,filter_band1=20",
         "MetricExpr": "(UNC_P_FREQ_GE_2000MHZ_CYCLES / UNC_P_CLOCKTICKS) * 100.",
         "MetricName": "freq_ge_2000mhz_cycles %",
         "PerPkg": "1",
@@ -254,7 +254,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0xd",
         "EventName": "UNC_P_FREQ_GE_3000MHZ_TRANSITIONS",
-        "Filter": "edge=1,filter_band2=4000",
+        "Filter": "edge=1,filter_band2=30",
         "MetricExpr": "(UNC_P_FREQ_GE_3000MHZ_CYCLES / UNC_P_CLOCKTICKS) * 100.",
         "MetricName": "freq_ge_3000mhz_cycles %",
         "PerPkg": "1",
@@ -265,7 +265,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0xe",
         "EventName": "UNC_P_FREQ_GE_4000MHZ_TRANSITIONS",
-        "Filter": "edge=1,filter_band3=4000",
+        "Filter": "edge=1,filter_band3=40",
         "MetricExpr": "(UNC_P_FREQ_GE_4000MHZ_CYCLES / UNC_P_CLOCKTICKS) * 100.",
         "MetricName": "freq_ge_4000mhz_cycles %",
         "PerPkg": "1",
diff --git a/tools/perf/pmu-events/arch/x86/jaketown/uncore-power.json b/tools/perf/pmu-events/arch/x86/jaketown/uncore-power.json
index 16034bfd06dd..8755693d86c6 100644
--- a/tools/perf/pmu-events/arch/x86/jaketown/uncore-power.json
+++ b/tools/perf/pmu-events/arch/x86/jaketown/uncore-power.json
@@ -187,7 +187,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0xb",
         "EventName": "UNC_P_FREQ_GE_1200MHZ_CYCLES",
-        "Filter": "filter_band0=1200",
+        "Filter": "filter_band0=12",
         "MetricExpr": "(UNC_P_FREQ_GE_1200MHZ_CYCLES / UNC_P_CLOCKTICKS) * 100.",
         "MetricName": "freq_ge_1200mhz_cycles %",
         "PerPkg": "1",
@@ -198,7 +198,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0xc",
         "EventName": "UNC_P_FREQ_GE_2000MHZ_CYCLES",
-        "Filter": "filter_band1=2000",
+        "Filter": "filter_band1=20",
         "MetricExpr": "(UNC_P_FREQ_GE_2000MHZ_CYCLES / UNC_P_CLOCKTICKS) * 100.",
         "MetricName": "freq_ge_2000mhz_cycles %",
         "PerPkg": "1",
@@ -209,7 +209,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0xd",
         "EventName": "UNC_P_FREQ_GE_3000MHZ_CYCLES",
-        "Filter": "filter_band2=3000",
+        "Filter": "filter_band2=30",
         "MetricExpr": "(UNC_P_FREQ_GE_3000MHZ_CYCLES / UNC_P_CLOCKTICKS) * 100.",
         "MetricName": "freq_ge_3000mhz_cycles %",
         "PerPkg": "1",
@@ -220,7 +220,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0xe",
         "EventName": "UNC_P_FREQ_GE_4000MHZ_CYCLES",
-        "Filter": "filter_band3=4000",
+        "Filter": "filter_band3=40",
         "MetricExpr": "(UNC_P_FREQ_GE_4000MHZ_CYCLES / UNC_P_CLOCKTICKS) * 100.",
         "MetricName": "freq_ge_4000mhz_cycles %",
         "PerPkg": "1",
@@ -231,7 +231,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0xb",
         "EventName": "UNC_P_FREQ_GE_1200MHZ_TRANSITIONS",
-        "Filter": "edge=1,filter_band0=1200",
+        "Filter": "edge=1,filter_band0=12",
         "MetricExpr": "(UNC_P_FREQ_GE_1200MHZ_CYCLES / UNC_P_CLOCKTICKS) * 100.",
         "MetricName": "freq_ge_1200mhz_cycles %",
         "PerPkg": "1",
@@ -242,7 +242,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0xc",
         "EventName": "UNC_P_FREQ_GE_2000MHZ_TRANSITIONS",
-        "Filter": "edge=1,filter_band1=2000",
+        "Filter": "edge=1,filter_band1=20",
         "MetricExpr": "(UNC_P_FREQ_GE_2000MHZ_CYCLES / UNC_P_CLOCKTICKS) * 100.",
         "MetricName": "freq_ge_2000mhz_cycles %",
         "PerPkg": "1",
@@ -253,7 +253,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0xd",
         "EventName": "UNC_P_FREQ_GE_3000MHZ_TRANSITIONS",
-        "Filter": "edge=1,filter_band2=4000",
+        "Filter": "edge=1,filter_band2=30",
         "MetricExpr": "(UNC_P_FREQ_GE_3000MHZ_CYCLES / UNC_P_CLOCKTICKS) * 100.",
         "MetricName": "freq_ge_3000mhz_cycles %",
         "PerPkg": "1",
@@ -264,7 +264,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0xe",
         "EventName": "UNC_P_FREQ_GE_4000MHZ_TRANSITIONS",
-        "Filter": "edge=1,filter_band3=4000",
+        "Filter": "edge=1,filter_band3=40",
         "MetricExpr": "(UNC_P_FREQ_GE_4000MHZ_CYCLES / UNC_P_CLOCKTICKS) * 100.",
         "MetricName": "freq_ge_4000mhz_cycles %",
         "PerPkg": "1",
