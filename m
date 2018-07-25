Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EF76C67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 20:40:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D64320671
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 20:40:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D64320671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731316AbeGYVyD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 17:54:03 -0400
Received: from terminus.zytor.com ([198.137.202.136]:59453 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730337AbeGYVyC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 17:54:02 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w6PKds0t498408
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 25 Jul 2018 13:39:54 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w6PKdsIC498405;
        Wed, 25 Jul 2018 13:39:54 -0700
Date:   Wed, 25 Jul 2018 13:39:54 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Alexey Budankov <tipbot@zytor.com>
Message-ID: <tip-06dc5bf21f3f90750fcc073fbc6ce2a0324df051@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, ak@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, mingo@kernel.org, peterz@infradead.org,
        alexey.budankov@linux.intel.com, acme@redhat.com, hpa@zytor.com,
        alexander.shishkin@linux.intel.com, tglx@linutronix.de
Reply-To: ak@linux.intel.com, jolsa@redhat.com, namhyung@kernel.org,
          linux-kernel@vger.kernel.org, peterz@infradead.org,
          alexey.budankov@linux.intel.com, acme@redhat.com, hpa@zytor.com,
          alexander.shishkin@linux.intel.com, tglx@linutronix.de,
          mingo@kernel.org
In-Reply-To: <ad30b774-219b-7b80-c610-4e9e298cf8a7@linux.intel.com>
References: <ad30b774-219b-7b80-c610-4e9e298cf8a7@linux.intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf tests: Check that complex event name is parsed
 correctly
Git-Commit-ID: 06dc5bf21f3f90750fcc073fbc6ce2a0324df051
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

Commit-ID:  06dc5bf21f3f90750fcc073fbc6ce2a0324df051
Gitweb:     https://git.kernel.org/tip/06dc5bf21f3f90750fcc073fbc6ce2a0324df051
Author:     Alexey Budankov <alexey.budankov@linux.intel.com>
AuthorDate: Tue, 19 Jun 2018 11:45:40 +0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 24 Jul 2018 14:37:11 -0300

perf tests: Check that complex event name is parsed correctly

Extend regression testing to cover case of complex event names enabled
by the cset f92da71280fb ("perf record: Enable arbitrary event names
thru name= modifier").

Testing it:

  # perf test
   1: vmlinux symtab matches kallsyms                       : Skip
   2: Detect openat syscall event                           : Ok
   3: Detect openat syscall event on all cpus               : Ok
   4: Read samples using the mmap interface                 : Ok
   5: Test data source output                               : Ok
   6: Parse event definition strings                        : Ok		<===!
   7: Simple expression parser                              : Ok
...

Committer testing:

  # perf test "event definition"
   6: Parse event definition strings                        : Ok
  # perf test -v 6 2> /tmp/before
  # perf test -v 6 2> /tmp/after
  # diff -u /tmp/before /tmp/after
  --- /tmp/before	2018-06-19 10:50:21.485572638 -0300
  +++ /tmp/after	2018-06-19 10:50:40.886572896 -0300
  @@ -1,6 +1,6 @@
    6: Parse event definition strings                        :
   --- start ---
  -test child forked, pid 24259
  +test child forked, pid 24904
   running test 0 'syscalls:sys_enter_openat'Using CPUID GenuineIntel-6-3D
   registering plugin: /root/.traceevent/plugins/plugin_kvm.so
   registering plugin: /root/.traceevent/plugins/plugin_hrtimer.so
  @@ -136,9 +136,11 @@
   running test 50 '4:0x6530160/name=numpmu/'
   running test 51 'L1-dcache-misses/name=cachepmu/'
   running test 52 'intel_pt//u'
  +running test 53 'cycles/name='COMPLEX_CYCLES_NAME:orig=cycles,desc=chip-clock-ticks'/Duk'
   running test 0 'cpu/config=10,config1,config2=3,period=1000/u'
   running test 1 'cpu/config=1,name=krava/u,cpu/config=2/u'
   running test 2 'cpu/config=1,call-graph=fp,time,period=100000/,cpu/config=2,call-graph=no,time=0,period=2000/'
  +running test 3 'cpu/name='COMPLEX_CYCLES_NAME:orig=cycles,desc=chip-clock-ticks',period=0x1,event=0x2,umask=0x3/ukp'
   el-capacity -> cpu/event=0x54,umask=0x2/
   el-conflict -> cpu/event=0x54,umask=0x1/
   el-start -> cpu/event=0xc8,umask=0x1/
  #

Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/ad30b774-219b-7b80-c610-4e9e298cf8a7@linux.intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/parse-events.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/tools/perf/tests/parse-events.c b/tools/perf/tests/parse-events.c
index 61211918bfba..a36313daec4e 100644
--- a/tools/perf/tests/parse-events.c
+++ b/tools/perf/tests/parse-events.c
@@ -1322,6 +1322,14 @@ static int test__intel_pt(struct perf_evlist *evlist)
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
@@ -1658,6 +1666,11 @@ static struct evlist_test test__events[] = {
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
@@ -1676,6 +1689,11 @@ static struct evlist_test test__events_pmu[] = {
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
