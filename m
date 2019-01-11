Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAB67C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 11:53:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC97D2064C
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 11:53:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731909AbfAKLxY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 06:53:24 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:37936 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731266AbfAKLxR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 06:53:17 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id x0BBmvpc000560
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jan 2019 06:53:16 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2pxr5d7mvy-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jan 2019 06:53:16 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <tmricht@linux.ibm.com>;
        Fri, 11 Jan 2019 11:53:14 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 11 Jan 2019 11:53:12 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x0BBrBbK7930350
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 11 Jan 2019 11:53:11 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6C4525204F;
        Fri, 11 Jan 2019 11:53:11 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 3178752051;
        Fri, 11 Jan 2019 11:53:11 +0000 (GMT)
From:   Thomas Richter <tmricht@linux.ibm.com>
To:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org
Cc:     brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, Thomas Richter <tmricht@linux.ibm.com>
Subject: [Patch 4/4] perf/report: s390 dump counter set data to file.
Date:   Fri, 11 Jan 2019 12:52:59 +0100
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190111115259.99438-1-tmricht@linux.ibm.com>
References: <20190111115259.99438-1-tmricht@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19011111-0020-0000-0000-00000304E73D
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19011111-0021-0000-0000-00002155EFA1
Message-Id: <20190111115259.99438-4-tmricht@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-11_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901110099
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the new s390 PMU device cpum_cf_diag to extract
the counter set diagnostic data. This data is available as event
raw data and can be created with this command:

  [root@s35lp76 perf]# ./perf record -R -e '{rbd000,rbc000}' --
                                 ~/mytests/facultaet 2500
  [ perf record: Woken up 1 times to write data ]
  [ perf record: Captured and wrote 0.009 MB perf.data ]
  [root@s35lp76 perf]#

The new event 0xbc000 generated this counter set diagnostic
trace data. The data can be extracted using command:

  [root@s35lp76 perf]# ./perf report --stdio --itrace=d
  #
  # Total Lost Samples: 0
  #
  # Samples: 21  of events 'anon group { rbd000, rbc000 }'
  # Event count (approx.): 21
  #
  #         Overhead  Command    Shared Object      Symbol
  # ................  .........  .................  ........................
  #
    80.95%   0.00%  facultaet  facultaet          [.] facultaet
     4.76%   0.00%  facultaet  [kernel.kallsyms]  [k] check_chain_key
     4.76%   0.00%  facultaet  [kernel.kallsyms]  [k] ftrace_likely_update
     4.76%   0.00%  facultaet  [kernel.kallsyms]  [k] lock_release
     4.76%   0.00%  facultaet  libc-2.26.so       [.] _dl_addr
  [root@s35lp76 perf]# ll aux*
  -rw-r--r-- 1 root root 3408 Oct 16 12:40 aux.ctr.02
  -rw-r--r-- 1 root root 4096 Oct 16 12:40 aux.smp.02
  [root@s35lp76 perf]#

The files named aux.ctr.## contain the counter set diagnstic
data and the files named aux.smp.## contain the sampling
diagnostic data. ## stand for the CPU number the data was
taken from.

Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
---
 tools/perf/arch/s390/util/trace_event.c |  2 +-
 tools/perf/util/s390-cpumcf-kernel.h    |  1 +
 tools/perf/util/s390-cpumsf.c           | 76 +++++++++++++++++++++++++++++++--
 3 files changed, 74 insertions(+), 5 deletions(-)

diff --git a/tools/perf/arch/s390/util/trace_event.c b/tools/perf/arch/s390/util/trace_event.c
index f7258d27a559..25a05e707da1 100644
--- a/tools/perf/arch/s390/util/trace_event.c
+++ b/tools/perf/arch/s390/util/trace_event.c
@@ -181,7 +181,7 @@ void arch__trace_event(struct perf_evlist *evlist, union perf_event *event,
 		return;
 
 	ev_bc000 = perf_evlist__event2evsel(evlist, event);
-	if (ev_bc000 == NULL || ev_bc000->attr.config != 0xbc000)
+	if (ev_bc000 == NULL || ev_bc000->attr.config != PERF_EVENT_CPUM_CF_DIAG)
 		return;
 
 	/* Display raw data on screen */
diff --git a/tools/perf/util/s390-cpumcf-kernel.h b/tools/perf/util/s390-cpumcf-kernel.h
index 6ae89f8a6efd..fe43c0beb545 100644
--- a/tools/perf/util/s390-cpumcf-kernel.h
+++ b/tools/perf/util/s390-cpumcf-kernel.h
@@ -10,6 +10,7 @@
 #define S390_CPUMCF_KERNEL_H
 
 #define	S390_CPUMCF_DIAG_DEF	0xfeef	/* Counter diagnostic entry ID */
+#define	PERF_EVENT_CPUM_CF_DIAG	0xBC000	/* Event: Counter sets */
 
 struct cf_ctrset_entry {	/* CPU-M CF counter set entry (8 byte) */
 	unsigned int def:16;	/* 0-15  Data Entry Format */
diff --git a/tools/perf/util/s390-cpumsf.c b/tools/perf/util/s390-cpumsf.c
index a2eeebbfb25f..69d7223bb333 100644
--- a/tools/perf/util/s390-cpumsf.c
+++ b/tools/perf/util/s390-cpumsf.c
@@ -162,6 +162,7 @@
 #include "auxtrace.h"
 #include "s390-cpumsf.h"
 #include "s390-cpumsf-kernel.h"
+#include "s390-cpumcf-kernel.h"
 #include "config.h"
 
 struct s390_cpumsf {
@@ -184,8 +185,58 @@ struct s390_cpumsf_queue {
 	struct auxtrace_buffer	*buffer;
 	int			cpu;
 	FILE			*logfile;
+	FILE			*logfile_ctr;
 };
 
+/* Check if the raw data should be dumped to file. If this is the case and
+ * the file to dump to has not been opened for writing, do so.
+ *
+ * Return 0 on success and greater zero on error so processing continues.
+ */
+static int s390_cpumcf_dumpctr(struct s390_cpumsf *sf,
+			       struct perf_sample *sample)
+{
+	struct s390_cpumsf_queue *sfq;
+	struct auxtrace_queue *q;
+	int rc = 0;
+
+	if (!sf->use_logfile || sf->queues.nr_queues <= sample->cpu)
+		return rc;
+
+	q = &sf->queues.queue_array[sample->cpu];
+	sfq = q->priv;
+	if (!sfq)		/* Queue not yet allocated */
+		return rc;
+
+	if (!sfq->logfile_ctr) {
+		char *name;
+
+		rc = (sf->logdir)
+			? asprintf(&name, "%s/aux.ctr.%02x",
+				 sf->logdir, sample->cpu)
+			: asprintf(&name, "aux.ctr.%02x", sample->cpu);
+		if (rc > 0)
+			sfq->logfile_ctr = fopen(name, "w");
+		if (sfq->logfile_ctr == NULL) {
+			pr_err("Failed to open counter set log file %s, "
+			       "continue...\n", name);
+			rc = 1;
+		}
+		free(name);
+	}
+
+	if (sfq->logfile_ctr) {
+		/* See comment above for -4 */
+		size_t n = fwrite(sample->raw_data, sample->raw_size - 4, 1,
+				  sfq->logfile_ctr);
+		if (n != 1) {
+			pr_err("Failed to write counter set data\n");
+			rc = 1;
+		}
+	}
+	return rc;
+}
+
 /* Display s390 CPU measurement facility basic-sampling data entry */
 static bool s390_cpumsf_basic_show(const char *color, size_t pos,
 				   struct hws_basic_entry *basic)
@@ -792,7 +843,7 @@ static int s390_cpumsf_lost(struct s390_cpumsf *sf, struct perf_sample *sample)
 }
 
 static int
-s390_cpumsf_process_event(struct perf_session *session __maybe_unused,
+s390_cpumsf_process_event(struct perf_session *session,
 			  union perf_event *event,
 			  struct perf_sample *sample,
 			  struct perf_tool *tool)
@@ -801,6 +852,7 @@ s390_cpumsf_process_event(struct perf_session *session __maybe_unused,
 					      struct s390_cpumsf,
 					      auxtrace);
 	u64 timestamp = sample->time;
+	struct perf_evsel *ev_bc000;
 	int err = 0;
 
 	if (dump_trace)
@@ -811,6 +863,16 @@ s390_cpumsf_process_event(struct perf_session *session __maybe_unused,
 		return -EINVAL;
 	}
 
+	if (event->header.type == PERF_RECORD_SAMPLE &&
+	    sample->raw_size) {
+		/* Handle event with raw data */
+		ev_bc000 = perf_evlist__event2evsel(session->evlist, event);
+		if (ev_bc000 &&
+		    ev_bc000->attr.config == PERF_EVENT_CPUM_CF_DIAG)
+			err = s390_cpumcf_dumpctr(sf, sample);
+		return err;
+	}
+
 	if (event->header.type == PERF_RECORD_AUX &&
 	    event->aux.flags & PERF_AUX_FLAG_TRUNCATED)
 		return s390_cpumsf_lost(sf, sample);
@@ -891,9 +953,15 @@ static void s390_cpumsf_free_queues(struct perf_session *session)
 		struct s390_cpumsf_queue *sfq = (struct s390_cpumsf_queue *)
 						queues->queue_array[i].priv;
 
-		if (sfq != NULL && sfq->logfile) {
-			fclose(sfq->logfile);
-			sfq->logfile = NULL;
+		if (sfq != NULL) {
+			if (sfq->logfile) {
+				fclose(sfq->logfile);
+				sfq->logfile = NULL;
+			}
+			if (sfq->logfile_ctr) {
+				fclose(sfq->logfile_ctr);
+				sfq->logfile_ctr = NULL;
+			}
 		}
 		zfree(&queues->queue_array[i].priv);
 	}
-- 
2.14.3

