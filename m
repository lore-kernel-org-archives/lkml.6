Return-Path: <SRS0=SmvU=O7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55961C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 00:27:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 157E52192C
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 00:27:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391906AbeLVA1f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 19:27:35 -0500
Received: from mga04.intel.com ([192.55.52.120]:48597 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404084AbeLVA1f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 19:27:35 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Dec 2018 16:26:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,383,1539673200"; 
   d="scan'208";a="128134562"
Received: from romley-ivt3.sc.intel.com ([172.25.110.60])
  by fmsmga002.fm.intel.com with ESMTP; 21 Dec 2018 16:26:29 -0800
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, "H Peter Anvin" <hpa@zytor.com>,
        "Tony Luck" <tony.luck@intel.com>,
        "Peter Zijlstra" <peterz@infradead.org>,
        "Reinette Chatre" <reinette.chatre@intel.com>,
        "Babu Moger" <babu.moger@amd.com>,
        "James Morse" <james.morse@arm.com>,
        "Xiaochen Shen" <xiaochen.shen@intel.com>,
        "Ravi V Shankar" <ravi.v.shankar@intel.com>,
        "Sai Praneeth Prakhya" <sai.praneeth.prakhya@intel.com>,
        "Arshiya Hayatkhan Pathan" <arshiya.hayatkhan.pathan@intel.com>
Cc:     "linux-kernel" <linux-kernel@vger.kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>
Subject: [PATCH v4 04/10] selftests/resctrl: Add callback to start a benchmark
Date:   Fri, 21 Dec 2018 16:20:32 -0800
Message-Id: <1545438038-75107-5-git-send-email-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1545438038-75107-1-git-send-email-fenghua.yu@intel.com>
References: <1545438038-75107-1-git-send-email-fenghua.yu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>

The callback starts a child process and puts the child pid in created
resctrl group with specified memory bandwidth in schemata. The child
starts running benchmark.

Signed-off-by: Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
Signed-off-by: Arshiya Hayatkhan Pathan <arshiya.hayatkhan.pathan@intel.com>
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
---
 tools/testing/selftests/resctrl/resctrl.h     |  27 ++
 tools/testing/selftests/resctrl/resctrl_val.c | 272 ++++++++++++++++++
 2 files changed, 299 insertions(+)

diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/selftests/resctrl/resctrl.h
index 01822f6258af..9820af253d4d 100644
--- a/tools/testing/selftests/resctrl/resctrl.h
+++ b/tools/testing/selftests/resctrl/resctrl.h
@@ -3,6 +3,7 @@
 #ifndef RESCTRL_H
 #define RESCTRL_H
 #include <stdio.h>
+#include <stdarg.h>
 #include <errno.h>
 #include <sched.h>
 #include <stdlib.h>
@@ -28,9 +29,34 @@
 		exit(EXIT_FAILURE);		\
 	} while (0)
 
+/*
+ * resctrl_val_param:	resctrl test parameters
+ * @resctrl_val:	Resctrl feature (Eg: mbm, mba.. etc)
+ * @ctrlgrp:		Name of the control monitor group (con_mon grp)
+ * @mongrp:		Name of the monitor group (mon grp)
+ * @cpu_no:		CPU number to which the benchmark would be binded
+ * @span:		Memory bytes accessed in each benchmark iteration
+ * @mum_resctrlfs:	Should the resctrl FS be remounted?
+ * @filename:		Name of file to which the o/p should be written
+ * @bw_report:		Bandwidth report type (reads vs writes)
+ * @setup:		Call back function to setup test environment
+ */
+struct resctrl_val_param {
+	char	*resctrl_val;
+	char	ctrlgrp[64];
+	char	mongrp[64];
+	int	cpu_no;
+	int	span;
+	int	mum_resctrlfs;
+	char	filename[64];
+	char	*bw_report;
+	int	(*setup)(int num, ...);
+};
+
 pid_t bm_pid, ppid;
 
 int remount_resctrlfs(bool mum_resctrlfs);
+int umount_resctrlfs(void);
 char get_sock_num(int cpu_no);
 int validate_bw_report_request(char *bw_report);
 int validate_resctrl_feature_request(char *resctrl_val);
@@ -43,5 +69,6 @@ int write_bm_pid_to_resctrl(pid_t bm_pid, char *ctrlgrp, char *mongrp,
 int perf_event_open(struct perf_event_attr *hw_event, pid_t pid, int cpu,
 		    int group_fd, unsigned long flags);
 int run_fill_buf(int span, int malloc_and_init_memory, int memflush, int op);
+int membw_val(char **benchmark_cmd, struct resctrl_val_param *param);
 
 #endif /* RESCTRL_H */
diff --git a/tools/testing/selftests/resctrl/resctrl_val.c b/tools/testing/selftests/resctrl/resctrl_val.c
index f381aafc0523..9a79bf669254 100644
--- a/tools/testing/selftests/resctrl/resctrl_val.c
+++ b/tools/testing/selftests/resctrl/resctrl_val.c
@@ -11,6 +11,7 @@
  */
 #include "resctrl.h"
 
+#define MB			(1024 * 1024)
 #define UNCORE_IMC		"uncore_imc"
 #define READ_FILE_NAME		"events/cas_count_read"
 #define WRITE_FILE_NAME		"events/cas_count_write"
@@ -429,3 +430,274 @@ static unsigned long get_mem_bw_resctrl(void)
 
 	return mbm_total;
 }
+
+pid_t bm_pid, ppid;
+
+static void ctrlc_handler(int signum, siginfo_t *info, void *ptr)
+{
+	kill(bm_pid, SIGKILL);
+	printf("Ending\n\n");
+
+	exit(EXIT_SUCCESS);
+}
+
+/*
+ * print_results_bw:	the memory bandwidth results are stored in a file
+ * @filename:		file that stores the results
+ * @bm_pid:		child pid that runs benchmark
+ * @bw_imc:		perf imc counter value
+ * @bw_resc:		memory bandwidth value
+ *
+ * Return:		0 on success. non-zero on failure.
+ */
+static int print_results_bw(char *filename,  int bm_pid, float bw_imc,
+			    unsigned long bw_resc)
+{
+	unsigned long diff = labs(bw_imc - bw_resc);
+	FILE *fp;
+
+	if (strcmp(filename, "stdio") == 0 || strcmp(filename, "stderr") == 0) {
+		printf("Pid: %d \t Mem_BW_iMC: %f \t ", bm_pid, bw_imc);
+		printf("Mem_BW_resc: %lu \t Difference: %lu\n", bw_resc, diff);
+	} else {
+		fp = fopen(filename, "a");
+		if (!fp) {
+			perror("Cannot open results file");
+
+			return errno;
+		}
+		if (fprintf(fp, "Pid: %d \t Mem_BW_iMC: %f \t Mem_BW_resc: %lu \t Difference: %lu\n",
+			    bm_pid, bw_imc, bw_resc, diff) <= 0) {
+			fclose(fp);
+			perror("Could not log results.");
+
+			return errno;
+		}
+		fclose(fp);
+	}
+
+	return 0;
+}
+
+static int
+measure_vals(struct resctrl_val_param *param, unsigned long *bw_resc_start)
+{
+	unsigned long bw_imc, bw_resc, bw_resc_end;
+	int ret;
+
+	/*
+	 * Measure memory bandwidth from resctrl and from
+	 * another source which is perf imc value or could
+	 * be something else if perf imc event is not available.
+	 * Compare the two values to validate resctrl value.
+	 * It takes 1sec to measure the data.
+	 */
+	bw_imc = get_mem_bw_imc(param->cpu_no, param->bw_report);
+	if (bw_imc <= 0)
+		return bw_imc;
+
+	bw_resc_end = get_mem_bw_resctrl();
+	if (bw_resc_end <= 0)
+		return bw_resc_end;
+
+	bw_resc = (bw_resc_end - *bw_resc_start) / MB;
+	ret = print_results_bw(param->filename, bm_pid, bw_imc, bw_resc);
+	if (ret)
+		return ret;
+
+	*bw_resc_start = bw_resc_end;
+
+	return 0;
+}
+
+/*
+ * membw_val:		execute benchmark and measure memory bandwidth on
+ *			the benchmark
+ * @benchmark_cmd:	benchmark command and its arguments
+ * @param:		parameters passed to membw_val()
+ *
+ * Return:		0 on success. non-zero on failure.
+ */
+int membw_val(char **benchmark_cmd, struct resctrl_val_param *param)
+{
+	int ret = 0, pipefd[2], pipe_message = 0;
+	char *resctrl_val = param->resctrl_val;
+	unsigned long bw_resc_start = 0;
+	struct sigaction sigact;
+	union sigval value;
+	FILE *fp;
+
+	if (strcmp(param->filename, "") == 0)
+		sprintf(param->filename, "stdio");
+
+	if (strcmp(param->bw_report, "") == 0)
+		param->bw_report = "total";
+
+	ret = validate_resctrl_feature_request(resctrl_val);
+	if (ret)
+		return ret;
+
+	if ((strcmp(resctrl_val, "mba")) == 0 ||
+	    (strcmp(resctrl_val, "mbm")) == 0) {
+		ret = validate_bw_report_request(param->bw_report);
+		if (ret)
+			return ret;
+	}
+
+	ret = remount_resctrlfs(param->mum_resctrlfs);
+	if (ret)
+		return ret;
+
+	/*
+	 * If benchmark wasn't successfully started by child, then child should
+	 * kill parent, so save parent's pid
+	 */
+	ppid = getpid();
+
+	/* File based synchronization between parent and child */
+	fp = fopen("sig", "w");
+	if (!fp) {
+		perror("Failed to open sig file");
+
+		return -1;
+	}
+	if (fprintf(fp, "%d\n", 0) <= 0) {
+		perror("Unable to establish sync bw parent & child");
+		fclose(fp);
+
+		return -1;
+	}
+	fclose(fp);
+
+	if (pipe(pipefd)) {
+		perror("Unable to create pipe");
+
+		return -1;
+	}
+
+	/*
+	 * Fork to start benchmark, save child's pid so that it can be killed
+	 * when needed
+	 */
+	bm_pid = fork();
+	if (bm_pid == -1) {
+		perror("Unable to fork");
+
+		return -1;
+	}
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
+		/* Tell parent that child is ready */
+		close(pipefd[0]);
+		pipe_message = 1;
+		write(pipefd[1], &pipe_message, sizeof(pipe_message));
+		close(pipefd[1]);
+
+		/* Suspend child until delivery of "SIGUSR1" from parent */
+		sigsuspend(&sigact.sa_mask);
+
+		PARENT_EXIT("Child is done");
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
+	    sigaction(SIGHUP, &sigact, NULL)) {
+		perror("Can't register parent for CTRL-C handler");
+		ret = errno;
+		goto out;
+	}
+
+	value.sival_ptr = benchmark_cmd;
+
+	/* Taskset benchmark to specified cpu */
+	ret = taskset_benchmark(bm_pid, param->cpu_no);
+	if (ret)
+		goto out;
+
+	/* Write benchmark to specified control&monitoring grp in resctrl FS */
+	ret = write_bm_pid_to_resctrl(bm_pid, param->ctrlgrp, param->mongrp,
+				      resctrl_val);
+	if (ret)
+		goto out;
+
+	if ((strcmp(resctrl_val, "mbm") == 0) ||
+	    (strcmp(resctrl_val, "mba") == 0)) {
+		ret = initialize_mem_bw_imc();
+		if (ret)
+			goto out;
+
+		initialize_mem_bw_resctrl(param->ctrlgrp, param->mongrp,
+					  param->cpu_no, resctrl_val);
+	}
+
+	/* Parent waits for child to be ready. */
+	close(pipefd[1]);
+	while (pipe_message != 1)
+		read(pipefd[0], &pipe_message, sizeof(pipe_message));
+	close(pipefd[0]);
+
+	/* Signal child to start benchmark */
+	if (sigqueue(bm_pid, SIGUSR1, value) == -1) {
+		perror("Unable to signal child to start execution");
+		ret = errno;
+		goto out;
+	}
+
+	/* Give benchmark enough time to fully run */
+	sleep(1);
+
+	/* Test runs until the callback setup() tells the test to stop. */
+	while (1) {
+		if (strcmp(resctrl_val, "mbm") == 0) {
+			ret = param->setup(1, param);
+			if (ret) {
+				ret = 0;
+				break;
+			}
+
+			ret = measure_vals(param, &bw_resc_start);
+			if (ret)
+				break;
+		} else if ((strcmp(resctrl_val, "mba") == 0)) {
+			ret = param->setup(1, param);
+			if (ret) {
+				ret = 0;
+				break;
+			}
+
+			ret = measure_vals(param, &bw_resc_start);
+			if (ret)
+				break;
+		} else {
+			break;
+		}
+	}
+
+out:
+	kill(bm_pid, SIGKILL);
+	umount_resctrlfs();
+
+	return ret;
+}
-- 
2.19.1

