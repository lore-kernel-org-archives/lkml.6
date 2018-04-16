Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753654AbeDPTgF (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 15:36:05 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:42741 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753398AbeDPTfd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 15:35:33 -0400
X-Google-Smtp-Source: AIpwx49WTe7SAbAoU9z6CafaMWW7fI52EodmT9yTH4oVmOA4nYIl6xj8dEWo4wQDQIAQvwrpdKKtBQ==
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org, corbet@lwn.net
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ben.Gainey@arm.com
Subject: [PATCH 2/3] coresight: Add section for integration with the perf tools
Date: Mon, 16 Apr 2018 13:35:26 -0600
Message-Id: <1523907327-20979-3-git-send-email-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1523907327-20979-1-git-send-email-mathieu.poirier@linaro.org>
References: <1523907327-20979-1-git-send-email-mathieu.poirier@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding a section that document how to use the Coresight framework and
drivers from the perf tools.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 Documentation/trace/coresight.txt | 50 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/Documentation/trace/coresight.txt b/Documentation/trace/coresight.txt
index 710c75b6c73f..8caae8050a60 100644
--- a/Documentation/trace/coresight.txt
+++ b/Documentation/trace/coresight.txt
@@ -187,9 +187,18 @@ that can be performed on them (see "struct coresight_ops").  The
 specific to that component only.  "Implementation defined" customisations are
 expected to be accessed and controlled using those entries.
 
+
 How to use the tracer modules
 -----------------------------
 
+There is two ways to use the Coresight framework: 1) using the perf cmd line
+tools and 2) interacting directly with the Coresight devices using the sysFS
+interface.  Preference is given to the former as using the sysFS interface
+requires a deep understanding of the Coresight HW.  The following sections
+provide details on using both methods.
+
+1) Using the sysFS interface:
+
 Before trace collection can start, a coresight sink needs to be identify.
 There is no limit on the amount of sinks (nor sources) that can be enabled at
 any given moment.  As a generic operation, all device pertaining to the sink
@@ -295,6 +304,47 @@ Instruction     13570831        0x8026B584      E28DD00C        false   ADD
 Instruction     0       0x8026B588      E8BD8000        true    LDM      sp!,{pc}
 Timestamp                                       Timestamp: 17107041535
 
+2) Using perf framework:
+
+Coresight tracers are represented using the Perf framework's Performance
+Monitoring Unit (PMU) abstraction.  As such the perf framework takes charge of
+controlling when tracing gets enabled based on when the process of interest is
+scheduled.  When configured in a system, Coresight PMUs will be listed when
+queried by the perf command line tool:
+
+	linaro@linaro-nano:~$ ./perf list pmu
+
+		List of pre-defined events (to be used in -e):
+
+		cs_etm//                                    [Kernel PMU event]
+
+	linaro@linaro-nano:~$
+
+Regardless of the number of tracers available in a system (usually equal to the
+amount of processor core), the "cs_etm" PMU will be listed only once.
+
+A Coresight PMU works the same way as any other PMUs, i.e the name of the PMU is
+listed along with configuration options within forward slashes '/'.  Since a
+Coresight system will typically have more than one sink, the name of the sink to
+work with needs to be specified as an event option.  Names for sink to choose
+from are listed in sysFS under ($SYSFS)/bus/coresight/devices:
+
+	root@linaro-nano:~# ls /sys/bus/coresight/devices/
+		20010000.etf   20040000.funnel  20100000.stm  22040000.etm
+		22140000.etm  230c0000.funnel  23240000.etm 20030000.tpiu
+		20070000.etr     20120000.replicator  220c0000.funnel
+		23040000.etm  23140000.etm     23340000.etm
+
+	root@linaro-nano:~# perf record -e cs_etm/@20070000.etr/u --per-thread program
+
+The syntax within the forward slashes '/' is important.  The '@' character
+tells the parser that a sink is about to be specified and that this is the IP
+to use for the trace session.
+
+More information on the above and other example on how to use Coresight with
+the perf tools can be found in the "HOWTO.md" file of the openCSD gitHub
+repository [3].
+
 How to use the STM module
 -------------------------
 
-- 
2.7.4
