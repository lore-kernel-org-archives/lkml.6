Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755224AbeDQQbl (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 12:31:41 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:38962 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755353AbeDQQIN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 12:08:13 -0400
X-Google-Smtp-Source: AIpwx4/Or3xJozt8N+sxXnS0RmkTzchNBr3CbfaVlbS0qTr66UpS0zw0wIA/F5sokZzFoxdDQrvXug==
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org, corbet@lwn.net
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        rdunlap@infradead.org, Ben.Gainey@arm.com
Subject: [PATCH v2 2/3] coresight: Add section for integration with the perf tools
Date: Tue, 17 Apr 2018 10:08:06 -0600
Message-Id: <1523981287-15370-3-git-send-email-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1523981287-15370-1-git-send-email-mathieu.poirier@linaro.org>
References: <1523981287-15370-1-git-send-email-mathieu.poirier@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding a section that document how to use the Coresight framework and
drivers from the perf tools.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 Documentation/trace/coresight.txt | 52 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 51 insertions(+), 1 deletion(-)

diff --git a/Documentation/trace/coresight.txt b/Documentation/trace/coresight.txt
index 710c75b6c73f..ab0d0f2d5cec 100644
--- a/Documentation/trace/coresight.txt
+++ b/Documentation/trace/coresight.txt
@@ -187,10 +187,19 @@ that can be performed on them (see "struct coresight_ops").  The
 specific to that component only.  "Implementation defined" customisations are
 expected to be accessed and controlled using those entries.
 
+
 How to use the tracer modules
 -----------------------------
 
-Before trace collection can start, a coresight sink needs to be identify.
+There are two ways to use the Coresight framework: 1) using the perf cmd line
+tools and 2) interacting directly with the Coresight devices using the sysFS
+interface.  Preference is given to the former as using the sysFS interface
+requires a deep understanding of the Coresight HW.  The following sections
+provide details on using both methods.
+
+1) Using the sysFS interface:
+
+Before trace collection can start, a coresight sink needs to be identified.
 There is no limit on the amount of sinks (nor sources) that can be enabled at
 any given moment.  As a generic operation, all device pertaining to the sink
 class will have an "active" entry in sysfs:
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
+amount of processor cores), the "cs_etm" PMU will be listed only once.
+
+A Coresight PMU works the same way as any other PMU, i.e the name of the PMU is
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
+tells the parser that a sink is about to be specified and that this is the sink
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
