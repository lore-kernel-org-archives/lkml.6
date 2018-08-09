Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 281F6C46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 04:57:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C737E21C2B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 04:57:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C737E21C2B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728192AbeHIHT5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 03:19:57 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:50916 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727724AbeHIHT5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 03:19:57 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w794rsKT017879
        for <linux-kernel@vger.kernel.org>; Thu, 9 Aug 2018 00:57:01 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2krc3b58d6-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 09 Aug 2018 00:57:00 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <tmricht@linux.ibm.com>;
        Thu, 9 Aug 2018 05:56:58 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 9 Aug 2018 05:56:56 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w794utFN35717198
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 9 Aug 2018 04:56:55 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8BB8BAE053;
        Thu,  9 Aug 2018 07:56:47 +0100 (BST)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 46FB9AE045;
        Thu,  9 Aug 2018 07:56:47 +0100 (BST)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  9 Aug 2018 07:56:47 +0100 (BST)
From:   Thomas Richter <tmricht@linux.ibm.com>
To:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org
Cc:     brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, Thomas Richter <tmricht@linux.ibm.com>
Subject: [PATCH v3] perf report: Create auxiliary trace data files for s390
Date:   Thu,  9 Aug 2018 06:56:50 +0200
X-Mailer: git-send-email 2.16.4
X-TM-AS-GCONF: 00
x-cbid: 18080904-0016-0000-0000-000001F435F0
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18080904-0017-0000-0000-0000324A46C5
Message-Id: <20180809045650.89197-1-tmricht@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-09_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808090051
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Create auxiliary trace data log files when invoked with option
 --itrace=d as in

[root@s35lp76 perf] ./perf report -i perf.data.aux1 --stdio --itrace=d

perf report creates several data files in the current directory
named aux.smp.## where ## is a 2 digit hex number with
leading zeros representing the CPU number this trace data
was recorded from. The file contents is binary and contains
the CPU-Measurement Sampling Data Blocks (SDBs).

The directory to save the auxiliary trace buffer can be
changed using the perf config file and command. Specify
section 'auxtrace' keyword 'dumpdir' and assign it a valid
directory name. If the directory does not exist or has the
wrong file type, the current directory is used.

[root@p23lp27 perf]# ./perf config auxtrace.dumpdir=/tmp
[root@p23lp27 perf]# ./perf config --user -l
auxtrace.dumpdir=/tmp
[root@p23lp27 perf]# ./perf report ...
[root@p23lp27 perf]# ll /tmp/aux.smp.00
-rw-r--r-- 1 root root 204800 Aug  2 13:48 /tmp/aux.smp.00
[root@p23lp27 perf]#

Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
Reviewed-by: Hendrik Brueckner <brueckner@linux.ibm.com>
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
@@ -940,6 +1027,7 @@ int s390_cpumsf_process_auxtrace_info(union perf_event *event,
 	auxtrace_queues__free(&sf->queues);
 	session->auxtrace = NULL;
 err_free:
+	free(sf->logdir);
 	free(sf);
 	return err;
 }
-- 
2.14.3

