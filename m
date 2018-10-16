Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF9BCC5ACC6
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:01:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B408A205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:01:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B408A205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727719AbeJQAwi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 20:52:38 -0400
Received: from mga17.intel.com ([192.55.52.151]:15627 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727516AbeJQAwP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 20:52:15 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Oct 2018 10:00:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,389,1534834800"; 
   d="scan'208";a="100736189"
Received: from romley-ivt3.sc.intel.com ([172.25.110.60])
  by orsmga002.jf.intel.com with ESMTP; 16 Oct 2018 10:00:56 -0700
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, "H Peter Anvin" <hpa@zytor.com>,
        "Tony Luck" <tony.luck@intel.com>,
        "Reinette Chatre" <reinette.chatre@intel.com>,
        "Peter Zijlstra" <peterz@infradead.org>,
        "Moger, Babu" <Babu.Moger@amd.com>,
        "James Morse" <james.morse@arm.com>,
        "Sai Praneeth Prakhya" <sai.praneeth.prakhya@intel.com>,
        "Arshiya Hayatkhan Pathan" <arshiya.hayatkhan.pathan@intel.com>,
        "Ravi V Shankar" <ravi.v.shankar@intel.com>
Cc:     "linux-kernel" <linux-kernel@vger.kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>
Subject: [PATCH 3/7] selftests/resctrl: Add callback to start a benchmark
Date:   Tue, 16 Oct 2018 09:56:37 -0700
Message-Id: <1539709001-38018-4-git-send-email-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1539709001-38018-1-git-send-email-fenghua.yu@intel.com>
References: <1539709001-38018-1-git-send-email-fenghua.yu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>

The callback starts a child and puts the child pid in created
resctrl group with specified memory bandwidth in schemata. The child
starts running benchmark. Later the callback will be used by tests
to start the benchmark.

Signed-off-by: Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
Signed-off-by: Arshiya Hayatkhan Pathan <arshiya.hayatkhan.pathan@intel.com>
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
---
 tools/testing/selftests/resctrl/resctrl.h     |  27 ++++
 tools/testing/selftests/resctrl/resctrl_val.c | 192 ++++++++++++++++++++++++++
 2 files changed, 219 insertions(+)
 create mode 100644 tools/testing/selftests/resctrl/resctrl_val.c

diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/selftests/resctrl/resctrl.h
index 1da8f871a01a..ab65bdd0a96f 100644
--- a/tools/testing/selftests/resctrl/resctrl.h
+++ b/tools/testing/selftests/resctrl/resctrl.h
@@ -51,6 +51,32 @@
 		exit(EXIT_FAILURE);		\
 	} while (0)
 
+/*
+ * resctrl_val:		Functional validation of resctrl features
+ * @resctrl_val:	Resctrl feature (Eg: mbm, mba.. etc)
+ * @ctrlgrp:		Name of the control monitor group (con_mon grp)
+ * @mongrp:		Name of the monitor group (mon grp)
+ * @schemata:		Schemata while validating allocation type features
+ * @cpu_no:		CPU number to which the benchmark would be binded
+ * @mum_resctrlfs:	Should the resctrl FS be remounted?
+ * @num_of_runs:	Number of runs before exiting
+ * @filename:		Name of file to which the o/p should be written
+ * @bw_report:		Bandwidth report type (reads vs writes)
+ */
+struct resctrl_val_param {
+	char *resctrl_val;
+	char ctrlgrp[64];
+	char mongrp[64];
+	char *schemata;
+	int cpu_no;
+	int span;
+	int mum_resctrlfs;
+	int num_of_runs;
+	char filename[64];
+	char *bw_report;
+	char *bm_type;
+};
+
 pid_t bm_pid, ppid;
 int ben_count;
 
@@ -70,5 +96,6 @@ void write_bm_pid_to_resctrl(pid_t bm_pid, char *ctrlgrp, char *mongrp,
 int perf_event_open(struct perf_event_attr *hw_event, pid_t pid, int cpu,
 		    int group_fd, unsigned long flags);
 int run_fill_buf(int span, int malloc_and_init_memory, int memflush, int op);
+void resctrl_val(char **benchmark_cmd, struct resctrl_val_param *param);
 
 #endif /* RESCTRL_H */
diff --git a/tools/testing/selftests/resctrl/resctrl_val.c b/tools/testing/selftests/resctrl/resctrl_val.c
new file mode 100644
index 000000000000..6d5f9e7f5421
--- /dev/null
+++ b/tools/testing/selftests/resctrl/resctrl_val.c
@@ -0,0 +1,192 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Core controller to start benchmark and memory bandwidth tests
+ *
+ * Copyright (C) 2018 Intel Corporation
+ *
+ * Authors:
+ *    Arshiya Hayatkhan Pathan <arshiya.hayatkhan.pathan@intel.com>
+ *    Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>,
+ *    Fenghua Yu <fenghua.yu@intel.com>
+ */
+#include "resctrl_membw.h"
+#include "resctrl.h"
+
+pid_t bm_pid, ppid;
+
+static void print_results_bw(char *filename,  int bm_pid, float bw_imc,
+			     unsigned long long bw_resc)
+{
+	int diff = abs(bw_imc - bw_resc);
+	FILE *fp;
+
+	if (strcmp(filename, "stdio") == 0 || strcmp(filename, "stderr") == 0) {
+		printf("Pid: %d \t Mem_BW_iMC: %f \t ", bm_pid, bw_imc);
+		printf("Mem_BW_resc: %llu \t Difference: %d\n", bw_resc, diff);
+	} else {
+		fp = fopen(filename, "a");
+		if (!fp)
+			CHILD_EXIT("Cannot open file 'a'");
+		if (fprintf(fp, "Pid: %d \t Mem_BW_iMC: %f \t ",
+			    bm_pid, bw_imc) <= 0 ||
+		    fprintf(fp, "Mem_BW_resc: %llu \t Difference: %d\n",
+			    bw_resc, diff) <= 0) {
+			fclose(fp);
+			CHILD_EXIT("Could not log results.");
+		}
+		fclose(fp);
+	}
+}
+
+void resctrl_val(char **benchmark_cmd, struct resctrl_val_param *param)
+{
+	unsigned long long bw_resc, bw_resc_start, bw_resc_end;
+	char *resctrl_val = param->resctrl_val;
+	int runs_flag, count_of_run, sig;
+	struct sigaction sigact;
+	union sigval value;
+	float bw_imc;
+	FILE *fp;
+
+	bw_resc_start = 0, count_of_run = 0, sig = 0;
+
+	if (strcmp(param->filename, "") == 0)
+		sprintf(param->filename, "stdio");
+
+	if (strcmp(param->bw_report, "") == 0)
+		param->bw_report = "total";
+
+	if (param->num_of_runs > 0)
+		runs_flag = 1;
+	else
+		runs_flag = 0;
+
+	validate_resctrl_feature_request(resctrl_val);
+
+	if ((strcmp(resctrl_val, "mba")) == 0 ||
+	    (strcmp(resctrl_val, "mbm")) == 0)
+		validate_bw_report_request(param->bw_report);
+
+	if ((runs_flag) && (param->num_of_runs <= 0))
+		FPRINTF_EXIT("Num of runs should be a real no > 0\n");
+
+	remount_resctrlfs(param->mum_resctrlfs);
+
+	/*
+	 * If benchmark wasn't successfully started by child, then child should
+	 * kill parent, so save parent's pid
+	 */
+	ppid = getpid();
+
+	/* File based synchronization between parent and child */
+	fp = fopen("sig", "w");
+	if (!fp || (fprintf(fp, "%d\n", 0) <= 0) || (fclose(fp) == EOF))
+		PERR_EXIT("Unable to establish sync bw parent & child");
+
+	/*
+	 * Fork to start benchmark, save child's pid so that it can be killed
+	 * when needed
+	 */
+	bm_pid = fork();
+	if (bm_pid == -1)
+		PERR_EXIT("Unable to fork");
+
+	if (bm_pid == 0) {
+		/*
+		 * Mask all signals except SIGUSR1, parent uses SIGUSR1 to
+		 * start benchmark
+		 */
+		sigfillset(&sigact.sa_mask);
+		sigdelset(&sigact.sa_mask, SIGUSR1);
+
+		sigact.sa_sigaction = run_benchmark;
+		sigact.sa_flags = SA_SIGINFO;
+
+		/* Register for "SIGUSR1" signal from parent */
+		if (sigaction(SIGUSR1, &sigact, NULL))
+			PARENT_EXIT("Can't register child for signal");
+
+		/* Signal parent that child is ready */
+		fp = fopen("sig", "w");
+		if ((fp == NULL) || (fprintf(fp, "%d\n", 1) <= 0) ||
+		    (fclose(fp) == EOF))
+			PARENT_EXIT("can't signal that child is ready");
+
+		/* Suspend child until delivery of "SIGUSR1" from parent */
+		sigsuspend(&sigact.sa_mask);
+	}
+
+	printf("Benchmark PID: %d\n", bm_pid);
+
+	/*
+	 * Register CTRL-C handler for parent, as it has to kill benchmark
+	 * before exiting
+	 */
+	sigact.sa_sigaction = ctrlc_handler;
+	sigemptyset(&sigact.sa_mask);
+	sigact.sa_flags = SA_SIGINFO;
+	if (sigaction(SIGINT, &sigact, NULL) ||
+	    sigaction(SIGHUP, &sigact, NULL))
+		CHILD_EXIT("Can't register parent for CTRL-C handler");
+
+	value.sival_ptr = benchmark_cmd;
+
+	/* Taskset benchmark to specified cpu */
+	taskset_benchmark(bm_pid, param->cpu_no);
+
+	/* Write benchmark to specified con_mon grp, mon_grp in resctrl FS*/
+	write_bm_pid_to_resctrl(bm_pid, param->ctrlgrp, param->mongrp,
+				resctrl_val);
+
+	/* Write schemata to specified con_mon grp, mon_grp in resctrl FS */
+	write_schemata(param->ctrlgrp, param->schemata, param->cpu_no,
+		       resctrl_val);
+
+	if ((strcmp(resctrl_val, "mbm") == 0) ||
+	    (strcmp(resctrl_val, "mba") == 0)) {
+		initialize_mem_bw_imc();
+		initialize_mem_bw_resctrl(param->ctrlgrp, param->mongrp,
+					  param->cpu_no, resctrl_val);
+	}
+
+	/*
+	 * Parent should signal child to start executing benchmark only upon
+	 * receiving a signal from child saying that it's ready
+	 */
+	while (sig == 0) {
+		fp = fopen("sig", "r");
+		if (!fp)
+			CHILD_EXIT("Unable to open 'sig' file");
+		fscanf(fp, "%d\n", &sig);
+		if (fclose(fp) == EOF)
+			CHILD_EXIT("Unable to close 'sig' file");
+	}
+	if (system(RM_SIG_FILE) != 0)
+		perror("Unable to remove 'sig' file");
+
+	/* Signal child to start benchmark */
+	if (sigqueue(bm_pid, SIGUSR1, value) == -1)
+		CHILD_EXIT("Unable to signal child to start execution");
+
+	while (1) {
+		if (param->num_of_runs != -1 &&
+		    count_of_run >= param->num_of_runs) {
+			ctrlc_handler(0, NULL, NULL);
+			break;
+		}
+
+		if ((strcmp(resctrl_val, "mbm") == 0) ||
+		    (strcmp(resctrl_val, "mba") == 0)) {
+			bw_imc = get_mem_bw_imc(param->cpu_no,
+						param->bw_report);
+			bw_resc_end = get_mem_bw_resctrl();
+			bw_resc = (bw_resc_end - bw_resc_start) / MB;
+			print_results_bw(param->filename, bm_pid, bw_imc,
+					 bw_resc);
+			bw_resc_start = bw_resc_end;
+		}
+		count_of_run++;
+	}
+
+	exit(EXIT_SUCCESS);
+}
-- 
2.5.0

