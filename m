Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751026AbeBPTcv (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 14:32:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:56692 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753795AbeBPTTj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 14:19:39 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2787217C8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Robert Walker <robert.walker@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 29/41] coresight: Update documentation for perf usage
Date: Fri, 16 Feb 2018 16:17:34 -0300
Message-Id: <20180216191746.11095-30-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180216191746.11095-1-acme@kernel.org>
References: <20180216191746.11095-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Robert Walker <robert.walker@arm.com>

Add notes on using perf to collect and analyze CoreSight trace

Signed-off-by: Robert Walker <robert.walker@arm.com>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: coresight@lists.linaro.org
Cc: linux-arm-kernel@lists.infradead.org
Link: http://lkml.kernel.org/r/1518607481-4059-4-git-send-email-robert.walker@arm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 Documentation/trace/coresight.txt | 51 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/Documentation/trace/coresight.txt b/Documentation/trace/coresight.txt
index a33c88cd5d1d..6f0120c3a4f1 100644
--- a/Documentation/trace/coresight.txt
+++ b/Documentation/trace/coresight.txt
@@ -330,3 +330,54 @@ Details on how to use the generic STM API can be found here [2].
 
 [1]. Documentation/ABI/testing/sysfs-bus-coresight-devices-stm
 [2]. Documentation/trace/stm.txt
+
+
+Using perf tools
+----------------
+
+perf can be used to record and analyze trace of programs.
+
+Execution can be recorded using 'perf record' with the cs_etm event,
+specifying the name of the sink to record to, e.g:
+
+    perf record -e cs_etm/@20070000.etr/u --per-thread
+
+The 'perf report' and 'perf script' commands can be used to analyze execution,
+synthesizing instruction and branch events from the instruction trace.
+'perf inject' can be used to replace the trace data with the synthesized events.
+The --itrace option controls the type and frequency of synthesized events
+(see perf documentation).
+
+Note that only 64-bit programs are currently supported - further work is
+required to support instruction decode of 32-bit Arm programs.
+
+
+Generating coverage files for Feedback Directed Optimization: AutoFDO
+---------------------------------------------------------------------
+
+'perf inject' accepts the --itrace option in which case tracing data is
+removed and replaced with the synthesized events. e.g.
+
+	perf inject --itrace --strip -i perf.data -o perf.data.new
+
+Below is an example of using ARM ETM for autoFDO.  It requires autofdo
+(https://github.com/google/autofdo) and gcc version 5.  The bubble
+sort example is from the AutoFDO tutorial (https://gcc.gnu.org/wiki/AutoFDO/Tutorial).
+
+	$ gcc-5 -O3 sort.c -o sort
+	$ taskset -c 2 ./sort
+	Bubble sorting array of 30000 elements
+	5910 ms
+
+	$ perf record -e cs_etm/@20070000.etr/u --per-thread taskset -c 2 ./sort
+	Bubble sorting array of 30000 elements
+	12543 ms
+	[ perf record: Woken up 35 times to write data ]
+	[ perf record: Captured and wrote 69.640 MB perf.data ]
+
+	$ perf inject -i perf.data -o inj.data --itrace=il64 --strip
+	$ create_gcov --binary=./sort --profile=inj.data --gcov=sort.gcov -gcov_version=1
+	$ gcc-5 -O3 -fauto-profile=sort.gcov sort.c -o sort_autofdo
+	$ taskset -c 2 ./sort_autofdo
+	Bubble sorting array of 30000 elements
+	5806 ms
-- 
2.14.3
