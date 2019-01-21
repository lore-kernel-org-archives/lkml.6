Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB511C37122
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 23:58:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86D87217D6
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 23:58:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548115105;
	bh=KUeZNqVOT6G1XfMNFlavJNbhiPmitbOPRoI6V2Dy5HI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vAhwMYM4kZfOJNHs6v5ajIqo807GZ/gshcSGfJZ9FW+PbM39m+mX4CdAXAaR3ko+V
	 vPErR9e1heFco2kb7dzX1Lip1AR5lAxJUgiESREE79nimDVQS+cTb5fsqn3HCauSIH
	 FgNunQrGHiE0lDrjjuEMmnCwbQUyuF+R1C1cLDzc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726948AbfAUX6Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 18:58:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:58746 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725948AbfAUX6W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 18:58:22 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8281320870;
        Mon, 21 Jan 2019 23:58:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548115101;
        bh=KUeZNqVOT6G1XfMNFlavJNbhiPmitbOPRoI6V2Dy5HI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PDufkQfd1NxsztzN7S7s4HgMwT3KJw0tt7ZO3QBc/BbCEgTuBwwQOrrcoSLCzUU4q
         ly/NNYF7rcS1jcUKroWpjskpzuUdAuc+4Ebc7xDTKTtM3e7duBfDv8FFDjYDX2GzUZ
         ItkXvPr15mANQSes55REmSNG0qZ+tjeOQiHgR3e4=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Thomas Richter <tmricht@linux.ibm.com>,
        Hendrik Brueckner <brueckner@linux.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 12/24] perf report: Dump s390 counter set data to file
Date:   Mon, 21 Jan 2019 20:56:54 -0300
Message-Id: <20190121235706.20005-13-acme@kernel.org>
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

Add support for the new s390 PMU device cpum_cf_diag to extract the
counter set diagnostic data. This data is available as event raw data
and can be created with this command:

  [root@s35lp76 perf]# ./perf record -R -e '{rbd000,rbc000}' --
                                 ~/mytests/facultaet 2500
  [ perf record: Woken up 1 times to write data ]
  [ perf record: Captured and wrote 0.009 MB perf.data ]
  [root@s35lp76 perf]#

The new event 0xbc000 generated this counter set diagnostic trace data.
The data can be extracted using command:

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

The files named aux.ctr.## contain the counter set diagnostic data and
the files named aux.smp.## contain the sampling diagnostic data. ##
stand for the CPU number the data was taken from.

Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
Reviewed-by: Hendrik Brueckner <brueckner@linux.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Link: http://lkml.kernel.org/r/20190117093003.96287-4-tmricht@linux.ibm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/s390-cpumsf.c | 77 +++++++++++++++++++++++++++++++++--
 1 file changed, 73 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/s390-cpumsf.c b/tools/perf/util/s390-cpumsf.c
index 68b2570304ec..835249c77f56 100644
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
@@ -801,6 +852,8 @@ s390_cpumsf_process_event(struct perf_session *session __maybe_unused,
 					      struct s390_cpumsf,
 					      auxtrace);
 	u64 timestamp = sample->time;
+	struct perf_evsel *ev_bc000;
+
 	int err = 0;
 
 	if (dump_trace)
@@ -811,6 +864,16 @@ s390_cpumsf_process_event(struct perf_session *session __maybe_unused,
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
@@ -891,9 +954,15 @@ static void s390_cpumsf_free_queues(struct perf_session *session)
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
2.20.1

