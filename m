Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751226AbeBQLer (ORCPT <rfc822;w@1wt.eu>);
        Sat, 17 Feb 2018 06:34:47 -0500
Received: from terminus.zytor.com ([198.137.202.136]:39393 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751099AbeBQLep (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Feb 2018 06:34:45 -0500
Date: Sat, 17 Feb 2018 03:33:25 -0800
From: tip-bot for Robert Walker <tipbot@zytor.com>
Message-ID: <tip-6673016f874adee171690f95540ead5efddb5351@git.kernel.org>
Cc: hpa@zytor.com, mingo@kernel.org, linux-kernel@vger.kernel.org,
        acme@redhat.com, mathieu.poirier@linaro.org, robert.walker@arm.com,
        tglx@linutronix.de
Reply-To: acme@redhat.com, robert.walker@arm.com, tglx@linutronix.de,
        mathieu.poirier@linaro.org, mingo@kernel.org, hpa@zytor.com,
        linux-kernel@vger.kernel.org
In-Reply-To: <1518607481-4059-4-git-send-email-robert.walker@arm.com>
References: <1518607481-4059-4-git-send-email-robert.walker@arm.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] coresight: Update documentation for perf usage
Git-Commit-ID: 6673016f874adee171690f95540ead5efddb5351
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

Commit-ID:  6673016f874adee171690f95540ead5efddb5351
Gitweb:     https://git.kernel.org/tip/6673016f874adee171690f95540ead5efddb5351
Author:     Robert Walker <robert.walker@arm.com>
AuthorDate: Wed, 14 Feb 2018 11:24:41 +0000
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Fri, 16 Feb 2018 14:55:46 -0300

coresight: Update documentation for perf usage

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
index a33c88c..6f0120c 100644
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
