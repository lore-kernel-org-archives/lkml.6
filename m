Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A05E4C5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 08:45:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 636A72083A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 08:45:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 636A72083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756459AbeFSIps (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 04:45:48 -0400
Received: from mga18.intel.com ([134.134.136.126]:50667 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756317AbeFSIpp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 04:45:45 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Jun 2018 01:45:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,242,1526367600"; 
   d="scan'208";a="209247724"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga004.jf.intel.com with ESMTP; 19 Jun 2018 01:45:44 -0700
Received: from [10.125.252.170] (abudanko-mobl.ccr.corp.intel.com [10.125.252.170])
        by linux.intel.com (Postfix) with ESMTP id 911895802AB;
        Tue, 19 Jun 2018 01:45:42 -0700 (PDT)
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Subject: [PATCH v1]: perf tests: check that complex event name is parsed
 correctly
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org
Message-ID: <ad30b774-219b-7b80-c610-4e9e298cf8a7@linux.intel.com>
Date:   Tue, 19 Jun 2018 11:45:40 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Extend regression testing to cover case of complex event names enabled 
by the patch "perf record: enable arbitrary event names thru name= modifier".

tools/perf/perf test
 1: vmlinux symtab matches kallsyms                       : Skip
 2: Detect openat syscall event                           : Ok
 3: Detect openat syscall event on all cpus               : Ok
 4: Read samples using the mmap interface                 : Ok
 5: Test data source output                               : Ok
 6: Parse event definition strings                        : Ok		<===!
 7: Simple expression parser                              : Ok
...

Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
---
 tools/perf/tests/parse-events.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/tools/perf/tests/parse-events.c b/tools/perf/tests/parse-events.c
index b9ebe15afb13..706b574f9747 100644
--- a/tools/perf/tests/parse-events.c
+++ b/tools/perf/tests/parse-events.c
@@ -1317,6 +1317,14 @@ static int test__intel_pt(struct perf_evlist *evlist)
 	return 0;
 }
 
+static int test__checkevent_complex_name(struct perf_evlist *evlist)
+{
+	struct perf_evsel *evsel = perf_evlist__first(evlist);
+
+	TEST_ASSERT_VAL("wrong complex name parsing", strcmp(evsel->name, "COMPLEX_CYCLES_NAME:orig=cycles,desc=chip-clock-ticks") == 0);
+	return 0;
+}
+
 static int count_tracepoints(void)
 {
 	struct dirent *events_ent;
@@ -1651,6 +1659,11 @@ static struct evlist_test test__events[] = {
 		.check = test__intel_pt,
 		.id    = 52,
 	},
+	{
+		.name  = "cycles/name='COMPLEX_CYCLES_NAME:orig=cycles,desc=chip-clock-ticks'/Duk",
+		.check = test__checkevent_complex_name,
+		.id    = 53
+	}
 };
 
 static struct evlist_test test__events_pmu[] = {
@@ -1669,6 +1682,11 @@ static struct evlist_test test__events_pmu[] = {
 		.check = test__checkevent_pmu_partial_time_callgraph,
 		.id    = 2,
 	},
+	{
+		.name  = "cpu/name='COMPLEX_CYCLES_NAME:orig=cycles,desc=chip-clock-ticks',period=0x1,event=0x2,umask=0x3/ukp",
+		.check = test__checkevent_complex_name,
+		.id    = 3,
+	}
 };
 
 struct terms_test {
