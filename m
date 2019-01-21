Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B493C37120
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 23:58:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30A3720870
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 23:58:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548115098;
	bh=zaJviQmw+t2RKuaZTLZ2QTVz50DYrP61kY+Poo5iBQk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bhqOgGhV+i8SvitIZIjB67tyB90EGlMLQGLJXpmlNFM5wAhe739NGpr9FIeI6qiGN
	 YPuUOunUJ93brsNuochH4fxHYlUrkkZ42cjHh4u8bSr5OykkWWfCSoMnYBJ5/pDxoj
	 LpsaMMdi0yRmEcM6w5EvPVHVH58vLXx50x0+5HnU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726893AbfAUX6Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 18:58:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:58610 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725948AbfAUX6P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 18:58:15 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1CF8E217D6;
        Mon, 21 Jan 2019 23:58:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548115094;
        bh=zaJviQmw+t2RKuaZTLZ2QTVz50DYrP61kY+Poo5iBQk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jODpJJjTmdHptWZpVByhMhyaoWUbCMIFBeyRc4GKNpVwn9Y0BbnwktIGpqF737U4n
         v5GEkxPgfUcic7yAVupyflbP8jS2P4kvyiVoi9yLcbPzcrYsIFkAo6wynoRWtuiA7T
         bPZaRH7Sr7aC+qhnj9Jg/JFI7T04TaK1zg7OpjTU=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Thomas Richter <tmricht@linux.ibm.com>,
        Hendrik Brueckner <brueckner@linux.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 10/24] perf report: Display arch specific diagnostic counter sets, starting with s390
Date:   Mon, 21 Jan 2019 20:56:52 -0300
Message-Id: <20190121235706.20005-11-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190121235706.20005-1-acme@kernel.org>
References: <20190121235706.20005-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Richter <tmricht@linux.ibm.com>

On s390 the event bc000 (also named CF_DIAG) extracts the CPU
Measurement Facility diagnostic counter sets and displays them as
counter number and counter value pairs sorted by counter set number.

Output:
 [root@s35lp76 perf]# ./perf report -D --stdio

 [00000000] Counterset:0 Counters:6
   Counter:000 Value:0x000000000085ec36 Counter:001 Value:0x0000000000796c94
   Counter:002 Value:0x0000000000005ada Counter:003 Value:0x0000000000092460
   Counter:004 Value:0x0000000000006073 Counter:005 Value:0x00000000001a9a73
 [0x000038] Counterset:1 Counters:2
   Counter:000 Value:0x000000000007c59f Counter:001 Value:0x000000000002fad6
 [0x000050] Counterset:2 Counters:16
   Counter:000 Value:000000000000000000 Counter:001 Value:000000000000000000
   Counter:002 Value:000000000000000000 Counter:003 Value:000000000000000000
   Counter:004 Value:000000000000000000 Counter:005 Value:000000000000000000
   Counter:006 Value:000000000000000000 Counter:007 Value:000000000000000000
   Counter:008 Value:000000000000000000 Counter:009 Value:000000000000000000
   Counter:010 Value:000000000000000000 Counter:011 Value:000000000000000000
   Counter:012 Value:000000000000000000 Counter:013 Value:000000000000000000
   Counter:014 Value:000000000000000000 Counter:015 Value:000000000000000000
 [0x0000d8] Counterset:3 Counters:128
   Counter:000 Value:0x000000000000020f Counter:001 Value:0x00000000000001d8
   Counter:002 Value:0x000000000000d7fa Counter:003 Value:0x000000000000008b
   ...

The number in brackets is the offset into the raw data field of the
sample.

New functions trace_event_sample_raw__init() and s390_sample_raw() are
introduced in the code path to enable interpretation on non s390
platforms. This event bc000 attached raw data is generated only on s390
platform. Correct display on other platforms requires correct endianness
handling.

Committer notes:

Added a init function that sets up a evlist function pointer to avoid
repeated tests on evlist->env and calls to perf_env__name() that
involves normalizing, etc, for each PERF_RECORD_SAMPLE.

Removed needless __maybe_unused from the trace_event_raw()
prototype in session.h, move it to be an static function in evlist.

Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
Reviewed-by: Hendrik Brueckner <brueckner@linux.ibm.com>
Link: https://lkml.kernel.org/r/9c856ac0-ef23-72b5-901d-a1f815508976@linux.ibm.com
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Link: https://lkml.kernel.org/n/tip-fezal8svianlwv93rfacvtmi@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/Build                |   2 +
 tools/perf/util/evlist.h             |   4 +-
 tools/perf/util/s390-cpumcf-kernel.h |  62 ++++++++++
 tools/perf/util/s390-sample-raw.c    | 173 +++++++++++++++++++++++++++
 tools/perf/util/sample-raw.c         |  18 +++
 tools/perf/util/sample-raw.h         |  14 +++
 tools/perf/util/session.c            |   5 +
 7 files changed, 277 insertions(+), 1 deletion(-)
 create mode 100644 tools/perf/util/s390-cpumcf-kernel.h
 create mode 100644 tools/perf/util/s390-sample-raw.c
 create mode 100644 tools/perf/util/sample-raw.c
 create mode 100644 tools/perf/util/sample-raw.h

diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index af72be7f5b3b..3ad6a800948d 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -44,6 +44,8 @@ libperf-y += machine.o
 libperf-y += map.o
 libperf-y += pstack.o
 libperf-y += session.o
+libperf-y += sample-raw.o
+libperf-y += s390-sample-raw.o
 libperf-$(CONFIG_TRACE) += syscalltbl.o
 libperf-y += ordered-events.o
 libperf-y += namespaces.o
diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
index 868294491194..00ab43c6dd15 100644
--- a/tools/perf/util/evlist.h
+++ b/tools/perf/util/evlist.h
@@ -49,6 +49,9 @@ struct perf_evlist {
 	struct perf_evsel *selected;
 	struct events_stats stats;
 	struct perf_env	*env;
+	void (*trace_event_sample_raw)(struct perf_evlist *evlist,
+				       union perf_event *event,
+				       struct perf_sample *sample);
 	u64		first_sample_time;
 	u64		last_sample_time;
 };
@@ -314,5 +317,4 @@ void perf_evlist__force_leader(struct perf_evlist *evlist);
 
 struct perf_evsel *perf_evlist__reset_weak_group(struct perf_evlist *evlist,
 						 struct perf_evsel *evsel);
-
 #endif /* __PERF_EVLIST_H */
diff --git a/tools/perf/util/s390-cpumcf-kernel.h b/tools/perf/util/s390-cpumcf-kernel.h
new file mode 100644
index 000000000000..d4356030b504
--- /dev/null
+++ b/tools/perf/util/s390-cpumcf-kernel.h
@@ -0,0 +1,62 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Support for s390 CPU measurement counter set diagnostic facility
+ *
+ * Copyright IBM Corp. 2019
+   Author(s): Hendrik Brueckner <brueckner@linux.ibm.com>
+ *		Thomas Richter <tmricht@linux.ibm.com>
+ */
+#ifndef S390_CPUMCF_KERNEL_H
+#define S390_CPUMCF_KERNEL_H
+
+#define	S390_CPUMCF_DIAG_DEF	0xfeef	/* Counter diagnostic entry ID */
+#define	PERF_EVENT_CPUM_CF_DIAG	0xBC000	/* Event: Counter sets */
+
+struct cf_ctrset_entry {	/* CPU-M CF counter set entry (8 byte) */
+	unsigned int def:16;	/* 0-15  Data Entry Format */
+	unsigned int set:16;	/* 16-23 Counter set identifier */
+	unsigned int ctr:16;	/* 24-39 Number of stored counters */
+	unsigned int res1:16;	/* 40-63 Reserved */
+};
+
+struct cf_trailer_entry {	/* CPU-M CF trailer for raw traces (64 byte) */
+	/* 0 - 7 */
+	union {
+		struct {
+			unsigned int clock_base:1;	/* TOD clock base */
+			unsigned int speed:1;		/* CPU speed */
+			/* Measurement alerts */
+			unsigned int mtda:1;	/* Loss of MT ctr. data alert */
+			unsigned int caca:1;	/* Counter auth. change alert */
+			unsigned int lcda:1;	/* Loss of counter data alert */
+		};
+		unsigned long flags;		/* 0-63    All indicators */
+	};
+	/* 8 - 15 */
+	unsigned int cfvn:16;			/* 64-79   Ctr First Version */
+	unsigned int csvn:16;			/* 80-95   Ctr Second Version */
+	unsigned int cpu_speed:32;		/* 96-127  CPU speed */
+	/* 16 - 23 */
+	unsigned long timestamp;		/* 128-191 Timestamp (TOD) */
+	/* 24 - 55 */
+	union {
+		struct {
+			unsigned long progusage1;
+			unsigned long progusage2;
+			unsigned long progusage3;
+			unsigned long tod_base;
+		};
+		unsigned long progusage[4];
+	};
+	/* 56 - 63 */
+	unsigned int mach_type:16;		/* Machine type */
+	unsigned int res1:16;			/* Reserved */
+	unsigned int res2:32;			/* Reserved */
+};
+
+#define	CPUMF_CTR_SET_BASIC	0	/* Basic Counter Set */
+#define	CPUMF_CTR_SET_USER	1	/* Problem-State Counter Set */
+#define	CPUMF_CTR_SET_CRYPTO	2	/* Crypto-Activity Counter Set */
+#define	CPUMF_CTR_SET_EXT	3	/* Extended Counter Set */
+#define	CPUMF_CTR_SET_MT_DIAG	4	/* MT-diagnostic Counter Set */
+#endif
diff --git a/tools/perf/util/s390-sample-raw.c b/tools/perf/util/s390-sample-raw.c
new file mode 100644
index 000000000000..7b4879625f01
--- /dev/null
+++ b/tools/perf/util/s390-sample-raw.c
@@ -0,0 +1,173 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright IBM Corp. 2019
+ * Author(s): Thomas Richter <tmricht@linux.ibm.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License (version 2 only)
+ * as published by the Free Software Foundation.
+ *
+ * Architecture specific trace_event function. Save event's bc000 raw data
+ * to file. File name is aux.ctr.## where ## stands for the CPU number the
+ * sample was taken from.
+ */
+
+#include <unistd.h>
+#include <stdio.h>
+#include <string.h>
+#include <inttypes.h>
+
+#include <sys/stat.h>
+#include <asm/byteorder.h>
+
+#include "debug.h"
+#include "util.h"
+#include "auxtrace.h"
+#include "session.h"
+#include "evlist.h"
+#include "config.h"
+#include "color.h"
+#include "sample-raw.h"
+#include "s390-cpumcf-kernel.h"
+
+static size_t ctrset_size(struct cf_ctrset_entry *set)
+{
+	return sizeof(*set) + set->ctr * sizeof(u64);
+}
+
+static bool ctrset_valid(struct cf_ctrset_entry *set)
+{
+	return set->def == S390_CPUMCF_DIAG_DEF;
+}
+
+/* CPU Measurement Counter Facility raw data is a byte stream. It is 8 byte
+ * aligned and might have trailing padding bytes.
+ * Display the raw data on screen.
+ */
+static bool s390_cpumcfdg_testctr(struct perf_sample *sample)
+{
+	size_t len = sample->raw_size, offset = 0;
+	unsigned char *buf = sample->raw_data;
+	struct cf_trailer_entry *te;
+	struct cf_ctrset_entry *cep, ce;
+
+	if (!len)
+		return false;
+	while (offset < len) {
+		cep = (struct cf_ctrset_entry *)(buf + offset);
+		ce.def = be16_to_cpu(cep->def);
+		ce.set = be16_to_cpu(cep->set);
+		ce.ctr = be16_to_cpu(cep->ctr);
+		ce.res1 = be16_to_cpu(cep->res1);
+
+		if (!ctrset_valid(&ce) || offset + ctrset_size(&ce) > len) {
+			/* Raw data for counter sets are always multiple of 8
+			 * bytes. Prepending a 4 bytes size field to the
+			 * raw data block in the sample causes the perf tool
+			 * to append 4 padding bytes to make the raw data part
+			 * of the sample a multiple of eight bytes again.
+			 *
+			 * If the last entry (trailer) is 4 bytes off the raw
+			 * area data end, all is good.
+			 */
+			if (len - offset - sizeof(*te) == 4)
+				break;
+			pr_err("Invalid counter set entry at %#"  PRIx64 "\n",
+			       offset);
+			return false;
+		}
+		offset += ctrset_size(&ce);
+	}
+	return true;
+}
+
+/* Dump event bc000 on screen, already tested on correctness. */
+static void s390_cpumcfdg_dumptrail(const char *color, size_t offset,
+				    struct cf_trailer_entry *tep)
+{
+	struct cf_trailer_entry  te;
+
+	te.flags = be64_to_cpu(tep->flags);
+	te.cfvn = be16_to_cpu(tep->cfvn);
+	te.csvn = be16_to_cpu(tep->csvn);
+	te.cpu_speed = be32_to_cpu(tep->cpu_speed);
+	te.timestamp = be64_to_cpu(tep->timestamp);
+	te.progusage1 = be64_to_cpu(tep->progusage1);
+	te.progusage2 = be64_to_cpu(tep->progusage2);
+	te.progusage3 = be64_to_cpu(tep->progusage3);
+	te.tod_base = be64_to_cpu(tep->tod_base);
+	te.mach_type = be16_to_cpu(tep->mach_type);
+	te.res1 = be16_to_cpu(tep->res1);
+	te.res2 = be32_to_cpu(tep->res2);
+
+	color_fprintf(stdout, color, "    [%#08zx] Trailer:%c%c%c%c%c"
+		      " Cfvn:%d Csvn:%d Speed:%d TOD:%#llx\n",
+		      offset, te.clock_base ? 'T' : ' ',
+		      te.speed ? 'S' : ' ', te.mtda ? 'M' : ' ',
+		      te.caca ? 'C' : ' ', te.lcda ? 'L' : ' ',
+		      te.cfvn, te.csvn, te.cpu_speed, te.timestamp);
+	color_fprintf(stdout, color, "\t\t1:%lx 2:%lx 3:%lx TOD-Base:%#llx"
+		      " Type:%x\n\n",
+		      te.progusage1, te.progusage2, te.progusage3,
+		      te.tod_base, te.mach_type);
+}
+
+static void s390_cpumcfdg_dump(struct perf_sample *sample)
+{
+	size_t i, len = sample->raw_size, offset = 0;
+	unsigned char *buf = sample->raw_data;
+	const char *color = PERF_COLOR_BLUE;
+	struct cf_ctrset_entry *cep, ce;
+	u64 *p;
+
+	while (offset < len) {
+		cep = (struct cf_ctrset_entry *)(buf + offset);
+
+		ce.def = be16_to_cpu(cep->def);
+		ce.set = be16_to_cpu(cep->set);
+		ce.ctr = be16_to_cpu(cep->ctr);
+		ce.res1 = be16_to_cpu(cep->res1);
+
+		if (!ctrset_valid(&ce)) {	/* Print trailer */
+			s390_cpumcfdg_dumptrail(color, offset,
+						(struct cf_trailer_entry *)cep);
+			return;
+		}
+
+		color_fprintf(stdout, color, "    [%#08zx] Counterset:%d"
+			      " Counters:%d\n", offset, ce.set, ce.ctr);
+		for (i = 0, p = (u64 *)(cep + 1); i < ce.ctr; i += 2, p += 2)
+			color_fprintf(stdout, color,
+				      "\tCounter:%03d Value:%#018lx"
+				      " Counter:%03d Value:%#018lx\n",
+				      i, be64_to_cpu(*p),
+				      i + 1, be64_to_cpu(*(p + 1)));
+		offset += ctrset_size(&ce);
+	}
+}
+
+/* S390 specific trace event function. Check for PERF_RECORD_SAMPLE events
+ * and if the event was triggered by a counter set diagnostic event display
+ * its raw data.
+ * The function is only invoked when the dump flag -D is set.
+ */
+void perf_evlist__s390_sample_raw(struct perf_evlist *evlist, union perf_event *event,
+				  struct perf_sample *sample)
+{
+	struct perf_evsel *ev_bc000;
+
+	if (event->header.type != PERF_RECORD_SAMPLE)
+		return;
+
+	ev_bc000 = perf_evlist__event2evsel(evlist, event);
+	if (ev_bc000 == NULL ||
+	    ev_bc000->attr.config != PERF_EVENT_CPUM_CF_DIAG)
+		return;
+
+	/* Display raw data on screen */
+	if (!s390_cpumcfdg_testctr(sample)) {
+		pr_err("Invalid counter set data encountered\n");
+		return;
+	}
+	s390_cpumcfdg_dump(sample);
+}
diff --git a/tools/perf/util/sample-raw.c b/tools/perf/util/sample-raw.c
new file mode 100644
index 000000000000..c21e1311fb0f
--- /dev/null
+++ b/tools/perf/util/sample-raw.c
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#include <string.h>
+#include "evlist.h"
+#include "env.h"
+#include "sample-raw.h"
+
+/*
+ * Check platform the perf data file was created on and perform platform
+ * specific interpretation.
+ */
+void perf_evlist__init_trace_event_sample_raw(struct perf_evlist *evlist)
+{
+	const char *arch_pf = perf_env__arch(evlist->env);
+
+	if (arch_pf && !strcmp("s390", arch_pf))
+		evlist->trace_event_sample_raw = perf_evlist__s390_sample_raw;
+}
diff --git a/tools/perf/util/sample-raw.h b/tools/perf/util/sample-raw.h
new file mode 100644
index 000000000000..95d445c87e93
--- /dev/null
+++ b/tools/perf/util/sample-raw.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __SAMPLE_RAW_H
+#define __SAMPLE_RAW_H 1
+
+struct perf_evlist;
+union perf_event;
+struct perf_sample;
+
+void perf_evlist__s390_sample_raw(struct perf_evlist *evlist,
+				  union perf_event *event,
+				  struct perf_sample *sample);
+
+void perf_evlist__init_trace_event_sample_raw(struct perf_evlist *evlist);
+#endif /* __PERF_EVLIST_H */
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index d6f41611f504..b26bc9c54200 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -23,6 +23,7 @@
 #include "auxtrace.h"
 #include "thread.h"
 #include "thread-stack.h"
+#include "sample-raw.h"
 #include "stat.h"
 #include "arch/common.h"
 
@@ -147,6 +148,8 @@ struct perf_session *perf_session__new(struct perf_data *data,
 				perf_session__set_id_hdr_size(session);
 				perf_session__set_comm_exec(session);
 			}
+
+			perf_evlist__init_trace_event_sample_raw(session->evlist);
 		}
 	} else  {
 		session->machines.host.env = &perf_env;
@@ -1065,6 +1068,8 @@ static void dump_event(struct perf_evlist *evlist, union perf_event *event,
 	       file_offset, event->header.size, event->header.type);
 
 	trace_event(event);
+	if (event->header.type == PERF_RECORD_SAMPLE && evlist->trace_event_sample_raw)
+		evlist->trace_event_sample_raw(evlist, event, sample);
 
 	if (sample)
 		perf_evlist__print_tstamp(evlist, event, sample);
-- 
2.20.1

