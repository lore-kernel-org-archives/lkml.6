Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 076FDC6786F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 13:28:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A53DA20827
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 13:28:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="OQGFZMG+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A53DA20827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728737AbeJ3WWL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 18:22:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:53066 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727530AbeJ3WWL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 18:22:11 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 851ED2084A;
        Tue, 30 Oct 2018 13:28:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540906122;
        bh=VeN+nm3FwSedrAqTdQeibDANMxxRpBWrEwbz/dIoXqc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OQGFZMG+Pbbq4/9VhWlAGAZZwJlH/0xwf1BjSwqad69m4z6/9gPzp4WfT4MZw00ae
         1QYAoHtaZuuOv0w5Oe3JRUMdraP7xg1slqptGh3b8U4YvQ3grHFNADjf9dEoBYl6Of
         OmhS8AzjYAAWWL9SjR+7ocTrHvRx+sYiltTvl7yg=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jiri Olsa <jolsa@redhat.com>, Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.14 05/19] perf vendor events intel: Fix wrong filter_band* values for uncore events
Date:   Tue, 30 Oct 2018 09:28:10 -0400
Message-Id: <20181030132824.218056-5-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181030132824.218056-1-sashal@kernel.org>
References: <20181030132824.218056-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@redhat.com>

[ Upstream commit 94aafb74cee0002e2f2eb6dc5376f54d5951ab4d ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../arch/x86/ivytown/uncore-power.json           | 16 ++++++++--------
 .../arch/x86/jaketown/uncore-power.json          | 16 ++++++++--------
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
-- 
2.17.1

