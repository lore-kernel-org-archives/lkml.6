Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DE39C43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 13:17:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8C8320857
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 13:17:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8C8320857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729162AbeIFRwy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 13:52:54 -0400
Received: from terminus.zytor.com ([198.137.202.136]:52083 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727708AbeIFRwy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 13:52:54 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w86DHFCD305129
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 6 Sep 2018 06:17:15 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w86DHF6q305126;
        Thu, 6 Sep 2018 06:17:15 -0700
Date:   Thu, 6 Sep 2018 06:17:15 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Thomas Richter <tipbot@zytor.com>
Message-ID: <tip-766e0618e49490bf67a35542880bcecbcee2e5fa@git.kernel.org>
Cc:     brueckner@linux.ibm.com, tglx@linutronix.de,
        heiko.carstens@de.ibm.com, tmricht@linux.ibm.com, acme@redhat.com,
        linux-kernel@vger.kernel.org, mingo@kernel.org,
        schwidefsky@de.ibm.com, hpa@zytor.com
Reply-To: brueckner@linux.ibm.com, tglx@linutronix.de,
          heiko.carstens@de.ibm.com, acme@redhat.com,
          tmricht@linux.ibm.com, linux-kernel@vger.kernel.org,
          mingo@kernel.org, schwidefsky@de.ibm.com, hpa@zytor.com
In-Reply-To: <20180809045650.89197-1-tmricht@linux.ibm.com>
References: <20180809045650.89197-1-tmricht@linux.ibm.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf report: Create auxiliary trace data files for
 s390
Git-Commit-ID: 766e0618e49490bf67a35542880bcecbcee2e5fa
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

Commit-ID:  766e0618e49490bf67a35542880bcecbcee2e5fa
Gitweb:     https://git.kernel.org/tip/766e0618e49490bf67a35542880bcecbcee2e5fa
Author:     Thomas Richter <tmricht@linux.ibm.com>
AuthorDate: Thu, 9 Aug 2018 06:56:50 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 30 Aug 2018 15:52:20 -0300

perf report: Create auxiliary trace data files for s390

Create auxiliary trace data log files when invoked with option
--itrace=d as in:

  [root@s35lp76 perf] perf report -i perf.data.aux1 --stdio --itrace=d

perf report creates several data files in the current directory named
aux.smp.## where ## is a 2 digit hex number with leading zeros
representing the CPU number this trace data was recorded from. The file
contents is binary and contains the CPU-Measurement Sampling Data Blocks
(SDBs).

The directory to save the auxiliary trace buffer can be changed using
the perf config file and command. Specify section 'auxtrace' keyword
'dumpdir' and assign it a valid directory name. If the directory does
not exist or has the wrong file type, the current directory is used.

  [root@p23lp27 perf]# perf config auxtrace.dumpdir=/tmp
  [root@p23lp27 perf]# perf config --user -l auxtrace.dumpdir=/tmp
  [root@p23lp27 perf]# perf report ...
  [root@p23lp27 perf]# ll /tmp/aux.smp.00
  -rw-r--r-- 1 root root 204800 Aug  2 13:48 /tmp/aux.smp.00
  [root@p23lp27 perf]#

Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
Reviewed-by: Hendrik Brueckner <brueckner@linux.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Link: http://lkml.kernel.org/r/20180809045650.89197-1-tmricht@linux.ibm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/s390-cpumsf.c | 94 +++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 91 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/s390-cpumsf.c b/tools/perf/util/s390-cpumsf.c
index d2c78ffd9fee..a2eeebbfb25f 100644
--- a/tools/perf/util/s390-cpumsf.c
+++ b/tools/perf/util/s390-cpumsf.c
@@ -147,6 +147,9 @@
 #include <linux/bitops.h>
 #include <linux/log2.h>
 
+#include <sys/stat.h>
+#include <sys/types.h>
+
 #include "cpumap.h"
 #include "color.h"
 #include "evsel.h"
@@ -159,6 +162,7 @@
 #include "auxtrace.h"
 #include "s390-cpumsf.h"
 #include "s390-cpumsf-kernel.h"
+#include "config.h"
 
 struct s390_cpumsf {
 	struct auxtrace		auxtrace;
@@ -170,6 +174,8 @@ struct s390_cpumsf {
 	u32			pmu_type;
 	u16			machine_type;
 	bool			data_queued;
+	bool			use_logfile;
+	char			*logdir;
 };
 
 struct s390_cpumsf_queue {
@@ -177,6 +183,7 @@ struct s390_cpumsf_queue {
 	unsigned int		queue_nr;
 	struct auxtrace_buffer	*buffer;
 	int			cpu;
+	FILE			*logfile;
 };
 
 /* Display s390 CPU measurement facility basic-sampling data entry */
@@ -595,6 +602,12 @@ static int s390_cpumsf_run_decoder(struct s390_cpumsf_queue *sfq,
 			buffer->use_size = buffer->size;
 			buffer->use_data = buffer->data;
 		}
+		if (sfq->logfile) {	/* Write into log file */
+			size_t rc = fwrite(buffer->data, buffer->size, 1,
+					   sfq->logfile);
+			if (rc != 1)
+				pr_err("Failed to write auxiliary data\n");
+		}
 	} else
 		buffer = sfq->buffer;
 
@@ -606,6 +619,13 @@ static int s390_cpumsf_run_decoder(struct s390_cpumsf_queue *sfq,
 			return -ENOMEM;
 		buffer->use_size = buffer->size;
 		buffer->use_data = buffer->data;
+
+		if (sfq->logfile) {	/* Write into log file */
+			size_t rc = fwrite(buffer->data, buffer->size, 1,
+					   sfq->logfile);
+			if (rc != 1)
+				pr_err("Failed to write auxiliary data\n");
+		}
 	}
 	pr_debug4("%s queue_nr:%d buffer:%" PRId64 " offset:%#" PRIx64 " size:%#zx rest:%#zx\n",
 		  __func__, sfq->queue_nr, buffer->buffer_nr, buffer->offset,
@@ -640,6 +660,23 @@ s390_cpumsf_alloc_queue(struct s390_cpumsf *sf, unsigned int queue_nr)
 	sfq->sf = sf;
 	sfq->queue_nr = queue_nr;
 	sfq->cpu = -1;
+	if (sf->use_logfile) {
+		char *name;
+		int rc;
+
+		rc = (sf->logdir)
+			? asprintf(&name, "%s/aux.smp.%02x",
+				 sf->logdir, queue_nr)
+			: asprintf(&name, "aux.smp.%02x", queue_nr);
+		if (rc > 0)
+			sfq->logfile = fopen(name, "w");
+		if (sfq->logfile == NULL) {
+			pr_err("Failed to open auxiliary log file %s,"
+			       "continue...\n", name);
+			sf->use_logfile = false;
+		}
+		free(name);
+	}
 	return sfq;
 }
 
@@ -850,8 +887,16 @@ static void s390_cpumsf_free_queues(struct perf_session *session)
 	struct auxtrace_queues *queues = &sf->queues;
 	unsigned int i;
 
-	for (i = 0; i < queues->nr_queues; i++)
+	for (i = 0; i < queues->nr_queues; i++) {
+		struct s390_cpumsf_queue *sfq = (struct s390_cpumsf_queue *)
+						queues->queue_array[i].priv;
+
+		if (sfq != NULL && sfq->logfile) {
+			fclose(sfq->logfile);
+			sfq->logfile = NULL;
+		}
 		zfree(&queues->queue_array[i].priv);
+	}
 	auxtrace_queues__free(queues);
 }
 
@@ -864,6 +909,7 @@ static void s390_cpumsf_free(struct perf_session *session)
 	auxtrace_heap__free(&sf->heap);
 	s390_cpumsf_free_queues(session);
 	session->auxtrace = NULL;
+	free(sf->logdir);
 	free(sf);
 }
 
@@ -877,17 +923,55 @@ static int s390_cpumsf_get_type(const char *cpuid)
 
 /* Check itrace options set on perf report command.
  * Return true, if none are set or all options specified can be
- * handled on s390.
+ * handled on s390 (currently only option 'd' for logging.
  * Return false otherwise.
  */
 static bool check_auxtrace_itrace(struct itrace_synth_opts *itops)
 {
+	bool ison = false;
+
 	if (!itops || !itops->set)
 		return true;
-	pr_err("No --itrace options supported\n");
+	ison = itops->inject || itops->instructions || itops->branches ||
+		itops->transactions || itops->ptwrites ||
+		itops->pwr_events || itops->errors ||
+		itops->dont_decode || itops->calls || itops->returns ||
+		itops->callchain || itops->thread_stack ||
+		itops->last_branch;
+	if (!ison)
+		return true;
+	pr_err("Unsupported --itrace options specified\n");
 	return false;
 }
 
+/* Check for AUXTRACE dump directory if it is needed.
+ * On failure print an error message but continue.
+ * Return 0 on wrong keyword in config file and 1 otherwise.
+ */
+static int s390_cpumsf__config(const char *var, const char *value, void *cb)
+{
+	struct s390_cpumsf *sf = cb;
+	struct stat stbuf;
+	int rc;
+
+	if (strcmp(var, "auxtrace.dumpdir"))
+		return 0;
+	sf->logdir = strdup(value);
+	if (sf->logdir == NULL) {
+		pr_err("Failed to find auxtrace log directory %s,"
+		       " continue with current directory...\n", value);
+		return 1;
+	}
+	rc = stat(sf->logdir, &stbuf);
+	if (rc == -1 || !S_ISDIR(stbuf.st_mode)) {
+		pr_err("Missing auxtrace log directory %s,"
+		       " continue with current directory...\n", value);
+		free(sf->logdir);
+		sf->logdir = NULL;
+	}
+	return 1;
+}
+
 int s390_cpumsf_process_auxtrace_info(union perf_event *event,
 				      struct perf_session *session)
 {
@@ -906,6 +990,9 @@ int s390_cpumsf_process_auxtrace_info(union perf_event *event,
 		err = -EINVAL;
 		goto err_free;
 	}
+	sf->use_logfile = session->itrace_synth_opts->log;
+	if (sf->use_logfile)
+		perf_config(s390_cpumsf__config, sf);
 
 	err = auxtrace_queues__init(&sf->queues);
 	if (err)
@@ -940,6 +1027,7 @@ err_free_queues:
 	auxtrace_queues__free(&sf->queues);
 	session->auxtrace = NULL;
 err_free:
+	free(sf->logdir);
 	free(sf);
 	return err;
 }
