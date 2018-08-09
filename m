Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47BECC46460
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 14:59:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E17FA21DEC
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 14:59:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="qQs3hwp+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E17FA21DEC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732673AbeHIRYf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 13:24:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:36334 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732295AbeHIRYe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 13:24:34 -0400
Received: from jouet.infradead.org (179-240-153-38.3g.claro.net.br [179.240.153.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 25B9E21D62;
        Thu,  9 Aug 2018 14:59:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1533826757;
        bh=nRv1yjK5XR4fLOsNqTVXEWzvcvoO2LDPNulqB5uiF90=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qQs3hwp+a0RGDkJqW8PJUVHoV9Szfv3rMEPd4wAmwAje0NrYjwRu2g0Y7+qZD3s5H
         lDI8j/Qi67Y7VJmPVUkZHnYWnrpgvp6/Bl7ZiA1by7+1dQ37Qz4Gzqsg/ENchiq0zH
         yV3CA7PDH+VdikEr2G0b7kKOXCA8Dut2TbQSURbE=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Thomas Richter <tmricht@linux.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 07/44] perf auxtrace: Support for perf report -D for s390
Date:   Thu,  9 Aug 2018 11:57:45 -0300
Message-Id: <20180809145822.21391-8-acme@kernel.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180809145822.21391-1-acme@kernel.org>
References: <20180809145822.21391-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Richter <tmricht@linux.ibm.com>

Add initial support for s390 auxiliary traces using the CPU-Measurement
Sampling Facility.

Support and ignore PERF_REPORT_AUXTRACE_INFO records in the perf data
file. Later patches will show the contents of the auxiliary traces.

Setup the auxtrace queues and data structures for s390.  A raw dump of
the perf.data file now does not show an error when an auxtrace event is
encountered.

Output before:

  [root@s35lp76 perf]# ./perf report -D -i perf.data.auxtrace
  0x128 [0x10]: failed to process type: 70
  Error:
  failed to process sample

  0x128 [0x10]: event: 70
  .
  . ... raw event: size 16 bytes
  .  0000:  00 00 00 46 00 00 00 10 00 00 00 00 00 00 00 00  ...F............

  0x128 [0x10]: PERF_RECORD_AUXTRACE_INFO type: 0
  [root@s35lp76 perf]#

Output after:

   # ./perf report -D -i perf.data.auxtrace |fgrep PERF_RECORD_AUXTRACE
  0 0 0x128 [0x10]: PERF_RECORD_AUXTRACE_INFO type: 5
  0 0 0x25a66 [0x30]: PERF_RECORD_AUXTRACE size: 0x40000
	   offset: 0  ref: 0  idx: 4  tid: -1  cpu: 4
  ....

Additional notes about the underlying hardware and software
implementation, provided by Hendrik Brueckner (see Link: below).

=============================================================================

The CPU-Measurement Facility (CPU-MF) provides a set of functions to obtain
performance information on the mainframe.  Basically, it was introduced
with System z10 years ago for the z/Architecture, that means, 64-bit.
For Linux, there are two facilities of interest, counter facility and sampling
facility.  The counter facility provides hardware counters for instructions,
cycles, crypto-activities, and many more.

The sampling facility is a hardware sampler that when started will write
samples at a particular interval into a sampling buffer.  At some point,
for example, if a sample block is full, it generates an interrupt to collect
samples (while the sampler continues to run).

Few years ago, I started to provide the a perf PMU to use the counter
and sampling facilities.  Recently, the device driver was updated to also
"export" the sampling buffer into the AUX area.  Thomas now completed the
related perf work to interpret and process these AUX data.

If people are more interested in the sampling facility, they can have a
look into:

- The Load-Program-Parameter and the CPU-Measurement Facilities, SA23-2260-05
  http://www-01.ibm.com/support/docview.wss?uid=isg26fcd1cc32246f4c8852574ce0044734a

and to learn how-to use it for Linux on Z, have look at chapter 54,
"Using the CPU-measurement facilities" in the:

- Device Drivers, Features, and Commands, SC33-8411-34
  http://public.dhe.ibm.com/software/dw/linux390/docu/l416dd34.pdf

=============================================================================

Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
Reviewed-by: Hendrik Brueckner <brueckner@linux.ibm.com>
Link: http://lkml.kernel.org/r/20180803100758.GA28475@linux.ibm.com
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Link: http://lkml.kernel.org/r/20180802074622.13641-2-tmricht@linux.ibm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/arch/s390/util/auxtrace.c |   1 +
 tools/perf/util/Build                |   1 +
 tools/perf/util/auxtrace.c           |   3 +
 tools/perf/util/auxtrace.h           |   1 +
 tools/perf/util/s390-cpumsf.c        | 123 +++++++++++++++++++++++++++++++++++
 tools/perf/util/s390-cpumsf.h        |  21 ++++++
 6 files changed, 150 insertions(+)
 create mode 100644 tools/perf/util/s390-cpumsf.c
 create mode 100644 tools/perf/util/s390-cpumsf.h

diff --git a/tools/perf/arch/s390/util/auxtrace.c b/tools/perf/arch/s390/util/auxtrace.c
index 3afe8256eff2..44c857388897 100644
--- a/tools/perf/arch/s390/util/auxtrace.c
+++ b/tools/perf/arch/s390/util/auxtrace.c
@@ -30,6 +30,7 @@ cpumsf_info_fill(struct auxtrace_record *itr __maybe_unused,
 		 struct auxtrace_info_event *auxtrace_info __maybe_unused,
 		 size_t priv_size __maybe_unused)
 {
+	auxtrace_info->type = PERF_AUXTRACE_S390_CPUMSF;
 	return 0;
 }
 
diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index b604ef334dc9..7efe15b9618d 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -87,6 +87,7 @@ libperf-$(CONFIG_AUXTRACE) += intel-pt.o
 libperf-$(CONFIG_AUXTRACE) += intel-bts.o
 libperf-$(CONFIG_AUXTRACE) += arm-spe.o
 libperf-$(CONFIG_AUXTRACE) += arm-spe-pkt-decoder.o
+libperf-$(CONFIG_AUXTRACE) += s390-cpumsf.o
 
 ifdef CONFIG_LIBOPENCSD
 libperf-$(CONFIG_AUXTRACE) += cs-etm.o
diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
index d056447520a2..ae8c37b219c9 100644
--- a/tools/perf/util/auxtrace.c
+++ b/tools/perf/util/auxtrace.c
@@ -56,6 +56,7 @@
 #include "intel-pt.h"
 #include "intel-bts.h"
 #include "arm-spe.h"
+#include "s390-cpumsf.h"
 
 #include "sane_ctype.h"
 #include "symbol/kallsyms.h"
@@ -920,6 +921,8 @@ int perf_event__process_auxtrace_info(struct perf_tool *tool __maybe_unused,
 		return arm_spe_process_auxtrace_info(event, session);
 	case PERF_AUXTRACE_CS_ETM:
 		return cs_etm__process_auxtrace_info(event, session);
+	case PERF_AUXTRACE_S390_CPUMSF:
+		return s390_cpumsf_process_auxtrace_info(event, session);
 	case PERF_AUXTRACE_UNKNOWN:
 	default:
 		return -EINVAL;
diff --git a/tools/perf/util/auxtrace.h b/tools/perf/util/auxtrace.h
index e731f55da072..71fc3bd74299 100644
--- a/tools/perf/util/auxtrace.h
+++ b/tools/perf/util/auxtrace.h
@@ -44,6 +44,7 @@ enum auxtrace_type {
 	PERF_AUXTRACE_INTEL_BTS,
 	PERF_AUXTRACE_CS_ETM,
 	PERF_AUXTRACE_ARM_SPE,
+	PERF_AUXTRACE_S390_CPUMSF,
 };
 
 enum itrace_period_type {
diff --git a/tools/perf/util/s390-cpumsf.c b/tools/perf/util/s390-cpumsf.c
new file mode 100644
index 000000000000..e9a5ea21dbbf
--- /dev/null
+++ b/tools/perf/util/s390-cpumsf.c
@@ -0,0 +1,123 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright IBM Corp. 2018
+ * Auxtrace support for s390 CPU-Measurement Sampling Facility
+ *
+ * Author(s):  Thomas Richter <tmricht@linux.ibm.com>
+ */
+
+#include <endian.h>
+#include <errno.h>
+#include <byteswap.h>
+#include <inttypes.h>
+#include <linux/kernel.h>
+#include <linux/types.h>
+#include <linux/bitops.h>
+#include <linux/log2.h>
+
+#include "cpumap.h"
+#include "color.h"
+#include "evsel.h"
+#include "evlist.h"
+#include "machine.h"
+#include "session.h"
+#include "util.h"
+#include "thread.h"
+#include "debug.h"
+#include "auxtrace.h"
+#include "s390-cpumsf.h"
+
+struct s390_cpumsf {
+	struct auxtrace		auxtrace;
+	struct auxtrace_queues	queues;
+	struct auxtrace_heap	heap;
+	struct perf_session	*session;
+	struct machine		*machine;
+	u32			auxtrace_type;
+	u32			pmu_type;
+};
+
+static int
+s390_cpumsf_process_event(struct perf_session *session __maybe_unused,
+			  union perf_event *event __maybe_unused,
+			  struct perf_sample *sample __maybe_unused,
+			  struct perf_tool *tool __maybe_unused)
+{
+	return 0;
+}
+
+static int
+s390_cpumsf_process_auxtrace_event(struct perf_session *session __maybe_unused,
+				   union perf_event *event __maybe_unused,
+				   struct perf_tool *tool __maybe_unused)
+{
+	return 0;
+}
+
+static int s390_cpumsf_flush(struct perf_session *session __maybe_unused,
+			     struct perf_tool *tool __maybe_unused)
+{
+	return 0;
+}
+
+static void s390_cpumsf_free_events(struct perf_session *session)
+{
+	struct s390_cpumsf *sf = container_of(session->auxtrace,
+					      struct s390_cpumsf,
+					       auxtrace);
+	struct auxtrace_queues *queues = &sf->queues;
+	unsigned int i;
+
+	for (i = 0; i < queues->nr_queues; i++)
+		zfree(&queues->queue_array[i].priv);
+	auxtrace_queues__free(queues);
+}
+
+static void s390_cpumsf_free(struct perf_session *session)
+{
+	struct s390_cpumsf *sf = container_of(session->auxtrace,
+					      struct s390_cpumsf,
+					      auxtrace);
+
+	auxtrace_heap__free(&sf->heap);
+	s390_cpumsf_free_events(session);
+	session->auxtrace = NULL;
+	free(sf);
+}
+
+int s390_cpumsf_process_auxtrace_info(union perf_event *event,
+				      struct perf_session *session)
+{
+	struct auxtrace_info_event *auxtrace_info = &event->auxtrace_info;
+	struct s390_cpumsf *sf;
+	int err;
+
+	if (auxtrace_info->header.size < sizeof(struct auxtrace_info_event))
+		return -EINVAL;
+
+	sf = zalloc(sizeof(struct s390_cpumsf));
+	if (sf == NULL)
+		return -ENOMEM;
+
+	err = auxtrace_queues__init(&sf->queues);
+	if (err)
+		goto err_free;
+
+	sf->session = session;
+	sf->machine = &session->machines.host; /* No kvm support */
+	sf->auxtrace_type = auxtrace_info->type;
+	sf->pmu_type = PERF_TYPE_RAW;
+
+	sf->auxtrace.process_event = s390_cpumsf_process_event;
+	sf->auxtrace.process_auxtrace_event = s390_cpumsf_process_auxtrace_event;
+	sf->auxtrace.flush_events = s390_cpumsf_flush;
+	sf->auxtrace.free_events = s390_cpumsf_free_events;
+	sf->auxtrace.free = s390_cpumsf_free;
+	session->auxtrace = &sf->auxtrace;
+
+	return 0;
+
+err_free:
+	free(sf);
+	return err;
+}
diff --git a/tools/perf/util/s390-cpumsf.h b/tools/perf/util/s390-cpumsf.h
new file mode 100644
index 000000000000..fb64d100555c
--- /dev/null
+++ b/tools/perf/util/s390-cpumsf.h
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright IBM Corp. 2018
+ * Auxtrace support for s390 CPU-Measurement Sampling Facility
+ *
+ * Author(s):  Thomas Richter <tmricht@linux.ibm.com>
+ */
+
+#ifndef INCLUDE__PERF_S390_CPUMSF_H
+#define INCLUDE__PERF_S390_CPUMSF_H
+
+union perf_event;
+struct perf_session;
+struct perf_pmu;
+
+struct auxtrace_record *
+s390_cpumsf_recording_init(int *err, struct perf_pmu *s390_cpumsf_pmu);
+
+int s390_cpumsf_process_auxtrace_info(union perf_event *event,
+				      struct perf_session *session);
+#endif
-- 
2.14.4

