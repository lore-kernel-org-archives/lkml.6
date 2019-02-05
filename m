Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DB8DC282D7
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 15:07:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 193E821852
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 15:07:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549379248;
	bh=DPMuQxYJDsG5DwcJk3yjYAcLSO9wgVW0tnnR494xP/I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zj4DffcvutFpRywK74xCMIjedeoGF3C9uH2bnLUMX24yXtL3JL6w/O3ETEXJ9Xc5p
	 A5DdgCRA4j9tIOMbnObfpuBwMoTRnxFCO54BPyZxdakvNn1Ys+ZiJco8m88rP6ZwpL
	 Vs/uvDeFxHNmwKOO5IV59JSwM25bAQDlDD2ijBHc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729667AbfBEPH1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 10:07:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:42230 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726646AbfBEPHZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 10:07:25 -0500
Received: from quaco.ghostprotocols.net (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 14BD5217F9;
        Tue,  5 Feb 2019 15:07:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549379244;
        bh=DPMuQxYJDsG5DwcJk3yjYAcLSO9wgVW0tnnR494xP/I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=siss61x5ylqj0cqWKxbd/0H5dQ/LX5x9RBUseb5fmXfKS5BOYAhgihj1bu9izBRP2
         rcf9Z/dVCMu5H1dDwC2taXiBfoAX3Tj9TUjgVi2JyUmDS+V9TstG13mz3UPUORU5Cs
         H0797fe57v8e9ivkCHquobDA7/ITMhx4hygzn/7E=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Jiri Olsa <jolsa@kernel.org>, Dick Fowles <fowles@inreach.com>,
        Don Zickus <dzickus@redhat.com>, Joe Mario <jmario@redhat.com>,
        Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Namhyung Kim <namhyung@kernel.org>,
        linuxppc-dev@lists.ozlabs.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 2/8] perf mem/c2c: Fix perf_mem_events to support powerpc
Date:   Tue,  5 Feb 2019 12:07:02 -0300
Message-Id: <20190205150708.9012-3-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190205150708.9012-1-acme@kernel.org>
References: <20190205150708.9012-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ravi Bangoria <ravi.bangoria@linux.ibm.com>

PowerPC hardware does not have a builtin latency filter (--ldlat) for
the "mem-load" event and perf_mem_events by default includes
"/ldlat=30/" which is causing a failure on PowerPC. Refactor the code to
support "perf mem/c2c" on PowerPC.

This patch depends on kernel side changes done my Madhavan:
https://lists.ozlabs.org/pipermail/linuxppc-dev/2018-December/182596.html

Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: Dick Fowles <fowles@inreach.com>
Cc: Don Zickus <dzickus@redhat.com>
Cc: Joe Mario <jmario@redhat.com>
Cc: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: linuxppc-dev@lists.ozlabs.org
Link: http://lkml.kernel.org/r/20190129132412.771-1-ravi.bangoria@linux.ibm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-c2c.txt     | 16 ++++++++++++----
 tools/perf/Documentation/perf-mem.txt     |  2 +-
 tools/perf/arch/powerpc/util/Build        |  1 +
 tools/perf/arch/powerpc/util/mem-events.c | 11 +++++++++++
 tools/perf/util/mem-events.c              |  2 +-
 5 files changed, 26 insertions(+), 6 deletions(-)
 create mode 100644 tools/perf/arch/powerpc/util/mem-events.c

diff --git a/tools/perf/Documentation/perf-c2c.txt b/tools/perf/Documentation/perf-c2c.txt
index 095aebdc5bb7..e6150f21267d 100644
--- a/tools/perf/Documentation/perf-c2c.txt
+++ b/tools/perf/Documentation/perf-c2c.txt
@@ -19,8 +19,11 @@ C2C stands for Cache To Cache.
 The perf c2c tool provides means for Shared Data C2C/HITM analysis. It allows
 you to track down the cacheline contentions.
 
-The tool is based on x86's load latency and precise store facility events
-provided by Intel CPUs. These events provide:
+On x86, the tool is based on load latency and precise store facility events
+provided by Intel CPUs. On PowerPC, the tool uses random instruction sampling
+with thresholding feature.
+
+These events provide:
   - memory address of the access
   - type of the access (load and store details)
   - latency (in cycles) of the load access
@@ -46,7 +49,7 @@ RECORD OPTIONS
 
 -l::
 --ldlat::
-	Configure mem-loads latency.
+	Configure mem-loads latency. (x86 only)
 
 -k::
 --all-kernel::
@@ -119,11 +122,16 @@ Following perf record options are configured by default:
   -W,-d,--phys-data,--sample-cpu
 
 Unless specified otherwise with '-e' option, following events are monitored by
-default:
+default on x86:
 
   cpu/mem-loads,ldlat=30/P
   cpu/mem-stores/P
 
+and following on PowerPC:
+
+  cpu/mem-loads/
+  cpu/mem-stores/
+
 User can pass any 'perf record' option behind '--' mark, like (to enable
 callchains and system wide monitoring):
 
diff --git a/tools/perf/Documentation/perf-mem.txt b/tools/perf/Documentation/perf-mem.txt
index f8d2167cf3e7..199ea0f0a6c0 100644
--- a/tools/perf/Documentation/perf-mem.txt
+++ b/tools/perf/Documentation/perf-mem.txt
@@ -82,7 +82,7 @@ RECORD OPTIONS
 	Be more verbose (show counter open errors, etc)
 
 --ldlat <n>::
-	Specify desired latency for loads event.
+	Specify desired latency for loads event. (x86 only)
 
 In addition, for report all perf report options are valid, and for record
 all perf record options.
diff --git a/tools/perf/arch/powerpc/util/Build b/tools/perf/arch/powerpc/util/Build
index 2e6595310420..ba98bd006488 100644
--- a/tools/perf/arch/powerpc/util/Build
+++ b/tools/perf/arch/powerpc/util/Build
@@ -2,6 +2,7 @@ libperf-y += header.o
 libperf-y += sym-handling.o
 libperf-y += kvm-stat.o
 libperf-y += perf_regs.o
+libperf-y += mem-events.o
 
 libperf-$(CONFIG_DWARF) += dwarf-regs.o
 libperf-$(CONFIG_DWARF) += skip-callchain-idx.o
diff --git a/tools/perf/arch/powerpc/util/mem-events.c b/tools/perf/arch/powerpc/util/mem-events.c
new file mode 100644
index 000000000000..d08311f04e95
--- /dev/null
+++ b/tools/perf/arch/powerpc/util/mem-events.c
@@ -0,0 +1,11 @@
+// SPDX-License-Identifier: GPL-2.0
+#include "mem-events.h"
+
+/* PowerPC does not support 'ldlat' parameter. */
+char *perf_mem_events__name(int i)
+{
+	if (i == PERF_MEM_EVENTS__LOAD)
+		return (char *) "cpu/mem-loads/";
+
+	return (char *) "cpu/mem-stores/";
+}
diff --git a/tools/perf/util/mem-events.c b/tools/perf/util/mem-events.c
index 93f74d8d3cdd..42c3e5a229d2 100644
--- a/tools/perf/util/mem-events.c
+++ b/tools/perf/util/mem-events.c
@@ -28,7 +28,7 @@ struct perf_mem_event perf_mem_events[PERF_MEM_EVENTS__MAX] = {
 static char mem_loads_name[100];
 static bool mem_loads_name__init;
 
-char *perf_mem_events__name(int i)
+char * __weak perf_mem_events__name(int i)
 {
 	if (i == PERF_MEM_EVENTS__LOAD) {
 		if (!mem_loads_name__init) {
-- 
2.20.1

