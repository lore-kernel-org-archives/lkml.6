Return-Path: <SRS0=Se0q=LB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58527C4321D
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 11:22:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06D4021878
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 11:22:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06D4021878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726667AbeHROaF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Aug 2018 10:30:05 -0400
Received: from terminus.zytor.com ([198.137.202.136]:39141 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726266AbeHROaE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Aug 2018 10:30:04 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w7IBMcME1283805
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 18 Aug 2018 04:22:38 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w7IBMbAQ1283802;
        Sat, 18 Aug 2018 04:22:37 -0700
Date:   Sat, 18 Aug 2018 04:22:37 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Thomas Richter <tipbot@zytor.com>
Message-ID: <tip-b96e6615cd197022017808a9fe82f1737e307875@git.kernel.org>
Cc:     acme@redhat.com, hpa@zytor.com, brueckner@linux.ibm.com,
        schwidefsky@de.ibm.com, tglx@linutronix.de,
        heiko.carstens@de.ibm.com, tmricht@linux.ibm.com,
        linux-kernel@vger.kernel.org, mingo@kernel.org
Reply-To: tmricht@linux.ibm.com, tglx@linutronix.de,
          heiko.carstens@de.ibm.com, mingo@kernel.org,
          linux-kernel@vger.kernel.org, hpa@zytor.com, acme@redhat.com,
          brueckner@linux.ibm.com, schwidefsky@de.ibm.com
In-Reply-To: <20180802074622.13641-2-tmricht@linux.ibm.com>
References: <20180803100758.GA28475@linux.ibm.com>
        <20180802074622.13641-2-tmricht@linux.ibm.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf auxtrace: Support for perf report -D for
 s390
Git-Commit-ID: b96e6615cd197022017808a9fe82f1737e307875
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

Commit-ID:  b96e6615cd197022017808a9fe82f1737e307875
Gitweb:     https://git.kernel.org/tip/b96e6615cd197022017808a9fe82f1737e307875
Author:     Thomas Richter <tmricht@linux.ibm.com>
AuthorDate: Thu, 2 Aug 2018 09:46:20 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Fri, 3 Aug 2018 10:34:18 -0300

perf auxtrace: Support for perf report -D for s390

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
