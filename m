Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4287BC282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 10:17:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 125A22085A
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 10:17:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727882AbfAVKRL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 05:17:11 -0500
Received: from terminus.zytor.com ([198.137.202.136]:52685 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726345AbfAVKRK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 05:17:10 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x0MAGMHV2906971
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 22 Jan 2019 02:16:22 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x0MAGMts2906966;
        Tue, 22 Jan 2019 02:16:22 -0800
Date:   Tue, 22 Jan 2019 02:16:22 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Thomas Richter <tipbot@zytor.com>
Message-ID: <tip-3e4a1c536b2690cf461e930485b0ab0cdafba73b@git.kernel.org>
Cc:     tmricht@linux.ibm.com, hpa@zytor.com, heiko.carstens@de.ibm.com,
        mingo@kernel.org, linux-kernel@vger.kernel.org,
        brueckner@linux.ibm.com, tglx@linutronix.de,
        schwidefsky@de.ibm.com, acme@redhat.com
Reply-To: tmricht@linux.ibm.com, hpa@zytor.com, heiko.carstens@de.ibm.com,
          acme@redhat.com, tglx@linutronix.de, schwidefsky@de.ibm.com,
          linux-kernel@vger.kernel.org, mingo@kernel.org,
          brueckner@linux.ibm.com
In-Reply-To: <20190117093003.96287-3-tmricht@linux.ibm.com>
References: <20190117093003.96287-3-tmricht@linux.ibm.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf report: Display names in s390 diagnostic
 counter sets
Git-Commit-ID: 3e4a1c536b2690cf461e930485b0ab0cdafba73b
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

Commit-ID:  3e4a1c536b2690cf461e930485b0ab0cdafba73b
Gitweb:     https://git.kernel.org/tip/3e4a1c536b2690cf461e930485b0ab0cdafba73b
Author:     Thomas Richter <tmricht@linux.ibm.com>
AuthorDate: Thu, 17 Jan 2019 10:30:02 +0100
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 21 Jan 2019 17:00:56 -0300

perf report: Display names in s390 diagnostic counter sets

On s390 the CPU Measurement Facility diagnostic counter sets are
displayed by counter number and value. Add the logical counter name in
the output (if it is available). Otherwise "unknown" is shown.

Output before:

 [root@s35lp76 perf]# ./perf report -D --stdio
 [00000000] Counterset:0 Counters:6
   Counter:000 Value:0x000000000085ec36 Counter:001 Value:0x0000000000796c94
   Counter:002 Value:0x0000000000005ada Counter:003 Value:0x0000000000092460
   Counter:004 Value:0x0000000000006073 Counter:005 Value:0x00000000001a9a73
 [0x000038] Counterset:1 Counters:2
   Counter:000 Value:0x000000000007c59f Counter:001 Value:0x000000000002fad6
 [0x000050] Counterset:2 Counters:16
   Counter:000 Value:000000000000000000 Counter:001 Value:000000000000000000

Output after:

    [root@s35lp76 perf]# ./perf report -D --stdio

 [00000000] Counterset:0 Counters:6
     Counter:000 cpu_cycles Value:0x000000000085ec36
     Counter:001 instructions Value:0x0000000000796c94
     Counter:002 l1i_dir_writes Value:0x0000000000005ada
     Counter:003 l1i_penalty_cycles Value:0x0000000000092460
     Counter:004 l1d_dir_writes Value:0x0000000000006073
     Counter:005 l1d_penalty_cycles Value:0x00000000001a9a73
 [0x000038] Counterset:1 Counters:2
     Counter:000 problem_state_cpu_cycles Value:0x000000000007c59f
     Counter:001 problem_state_instructions Value:0x000000000002fad6
 [0x000050] Counterset:2 Counters:16
     Counter:000 prng_functions Value:000000000000000000

Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
Reviewed-by: Hendrik Brueckner <brueckner@linux.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Link: http://lkml.kernel.org/r/20190117093003.96287-3-tmricht@linux.ibm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/s390-sample-raw.c | 59 +++++++++++++++++++++++++++++++++++----
 1 file changed, 54 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/s390-sample-raw.c b/tools/perf/util/s390-sample-raw.c
index 1c5a4d63bc9d..6650f599ed9c 100644
--- a/tools/perf/util/s390-sample-raw.c
+++ b/tools/perf/util/s390-sample-raw.c
@@ -30,6 +30,7 @@
 #include "color.h"
 #include "sample-raw.h"
 #include "s390-cpumcf-kernel.h"
+#include "pmu-events/pmu-events.h"
 
 static size_t ctrset_size(struct cf_ctrset_entry *set)
 {
@@ -112,14 +113,61 @@ static void s390_cpumcfdg_dumptrail(const char *color, size_t offset,
 		      te.tod_base, te.mach_type);
 }
 
+/* Return starting number of a counter set */
+static int get_counterset_start(int setnr)
+{
+	switch (setnr) {
+	case CPUMF_CTR_SET_BASIC:		/* Basic counter set */
+		return 0;
+	case CPUMF_CTR_SET_USER:		/* Problem state counter set */
+		return 32;
+	case CPUMF_CTR_SET_CRYPTO:		/* Crypto counter set */
+		return 64;
+	case CPUMF_CTR_SET_EXT:			/* Extended counter set */
+		return 128;
+	case CPUMF_CTR_SET_MT_DIAG:		/* Diagnostic counter set */
+		return 448;
+	default:
+		return -1;
+	}
+}
+
+/* Scan the PMU table and extract the logical name of a counter from the
+ * PMU events table. Input is the counter set and counter number with in the
+ * set. Construct the event number and use this as key. If they match return
+ * the name of this counter.
+ * If no match is found a NULL pointer is returned.
+ */
+static const char *get_counter_name(int set, int nr, struct pmu_events_map *map)
+{
+	int rc, event_nr, wanted = get_counterset_start(set) + nr;
+
+	if (map) {
+		struct pmu_event *evp = map->table;
+
+		for (; evp->name || evp->event || evp->desc; ++evp) {
+			if (evp->name == NULL || evp->event == NULL)
+				continue;
+			rc = sscanf(evp->event, "event=%x", &event_nr);
+			if (rc == 1 && event_nr == wanted)
+				return evp->name;
+		}
+	}
+	return NULL;
+}
+
 static void s390_cpumcfdg_dump(struct perf_sample *sample)
 {
 	size_t i, len = sample->raw_size, offset = 0;
 	unsigned char *buf = sample->raw_data;
 	const char *color = PERF_COLOR_BLUE;
 	struct cf_ctrset_entry *cep, ce;
+	struct pmu_events_map *map;
+	struct perf_pmu pmu;
 	u64 *p;
 
+	memset(&pmu, 0, sizeof(pmu));
+	map = perf_pmu__find_map(&pmu);
 	while (offset < len) {
 		cep = (struct cf_ctrset_entry *)(buf + offset);
 
@@ -136,12 +184,13 @@ static void s390_cpumcfdg_dump(struct perf_sample *sample)
 
 		color_fprintf(stdout, color, "    [%#08zx] Counterset:%d"
 			      " Counters:%d\n", offset, ce.set, ce.ctr);
-		for (i = 0, p = (u64 *)(cep + 1); i < ce.ctr; i += 2, p += 2)
+		for (i = 0, p = (u64 *)(cep + 1); i < ce.ctr; ++i, ++p) {
+			const char *ev_name = get_counter_name(ce.set, i, map);
+
 			color_fprintf(stdout, color,
-				      "\tCounter:%03d Value:%#018lx"
-				      " Counter:%03d Value:%#018lx\n",
-				      i, be64_to_cpu(*p),
-				      i + 1, be64_to_cpu(*(p + 1)));
+				      "\tCounter:%03d %s Value:%#018lx\n", i,
+				      ev_name ?: "<unknown>", be64_to_cpu(*p));
+		}
 		offset += ctrset_size(&ce);
 	}
 }
