Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DD6BC282C2
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 00:09:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAF9F21907
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 00:09:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727119AbfBHAJF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 19:09:05 -0500
Received: from mga14.intel.com ([192.55.52.115]:14980 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726962AbfBHAI5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 19:08:57 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Feb 2019 16:08:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,346,1544515200"; 
   d="scan'208";a="122851412"
Received: from romley-ivt3.sc.intel.com ([172.25.110.60])
  by fmsmga008.fm.intel.com with ESMTP; 07 Feb 2019 16:08:54 -0800
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
        "H Peter Anvin" <hpa@zytor.com>, "Tony Luck" <tony.luck@intel.com>,
        "Reinette Chatre" <reinette.chatre@intel.com>,
        "Ravi V Shankar" <ravi.v.shankar@intel.com>,
        "Xiaochen Shen" <xiaochen.shen@intel.com>,
        "Arshiya Hayatkhan Pathan" <arshiya.hayatkhan.pathan@intel.com>,
        "Sai Praneeth Prakhya" <sai.praneeth.prakhya@intel.com>,
        "Babu Moger" <babu.moger@amd.com>
Cc:     "linux-kernel" <linux-kernel@vger.kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>
Subject: [PATCH v6 09/13] selftests/resctrl: Add Cache Allocation Technology (CAT) selftest
Date:   Thu,  7 Feb 2019 16:01:37 -0800
Message-Id: <1549584101-85811-10-git-send-email-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1549584101-85811-1-git-send-email-fenghua.yu@intel.com>
References: <1549584101-85811-1-git-send-email-fenghua.yu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arshiya Hayatkhan Pathan <arshiya.hayatkhan.pathan@intel.com>

Cache Allocation Technology (CAT) selftest allocates a portion of
last level cache and starts a benchmark to read each cache
line in this portion of cache. Measure the cache misses in perf and
the misses should be equal to the number of cache lines in this
portion of cache.

We don't use CQM to calculate cache usage because some CAT enabled
platforms don't have CQM.

Signed-off-by: Arshiya Hayatkhan Pathan <arshiya.hayatkhan.pathan@intel.com>
Signed-off-by: Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Babu Moger <babu.moger@amd.com>
---
 tools/testing/selftests/resctrl/Makefile        |   2 +-
 tools/testing/selftests/resctrl/cache.c         | 175 ++++++++++++++++-
 tools/testing/selftests/resctrl/cat_test.c      | 242 ++++++++++++++++++++++++
 tools/testing/selftests/resctrl/fill_buf.c      |  10 +-
 tools/testing/selftests/resctrl/resctrl.h       |   3 +
 tools/testing/selftests/resctrl/resctrl_tests.c |  14 +-
 tools/testing/selftests/resctrl/resctrlfs.c     |  10 +-
 7 files changed, 448 insertions(+), 8 deletions(-)
 create mode 100644 tools/testing/selftests/resctrl/cat_test.c

diff --git a/tools/testing/selftests/resctrl/Makefile b/tools/testing/selftests/resctrl/Makefile
index 664561cd76e6..0282222b4c22 100644
--- a/tools/testing/selftests/resctrl/Makefile
+++ b/tools/testing/selftests/resctrl/Makefile
@@ -8,7 +8,7 @@ all: resctrl_tests
 
 resctrl_tests: *.o
 	$(CC) $(CFLAGS) -o resctrl_tests resctrl_tests.o resctrlfs.o \
-		 resctrl_val.o fill_buf.o mbm_test.o mba_test.o cache.o cqm_test.o
+		 resctrl_val.o fill_buf.o mbm_test.o mba_test.o cache.o cqm_test.o cat_test.o
 
 .PHONY: clean
 
diff --git a/tools/testing/selftests/resctrl/cache.c b/tools/testing/selftests/resctrl/cache.c
index 876dc647b3ca..04b7aafdb409 100644
--- a/tools/testing/selftests/resctrl/cache.c
+++ b/tools/testing/selftests/resctrl/cache.c
@@ -10,10 +10,107 @@ struct read_format {
 	} values[2];
 };
 
+static struct perf_event_attr pea_llc_miss;
+static struct read_format rf_cqm;
+static int fd_lm;
 char cbm_mask[256];
 unsigned long long_mask;
 char llc_occup_path[1024];
 
+static void initialize_perf_event_attr(void)
+{
+	pea_llc_miss.type = PERF_TYPE_HARDWARE;
+	pea_llc_miss.size = sizeof(struct perf_event_attr);
+	pea_llc_miss.read_format = PERF_FORMAT_GROUP;
+	pea_llc_miss.exclude_kernel = 1;
+	pea_llc_miss.exclude_hv = 1;
+	pea_llc_miss.exclude_idle = 1;
+	pea_llc_miss.exclude_callchain_kernel = 1;
+	pea_llc_miss.inherit = 1;
+	pea_llc_miss.exclude_guest = 1;
+	pea_llc_miss.disabled = 1;
+}
+
+static void ioctl_perf_event_ioc_reset_enable(void)
+{
+	ioctl(fd_lm, PERF_EVENT_IOC_RESET, 0);
+	ioctl(fd_lm, PERF_EVENT_IOC_ENABLE, 0);
+}
+
+static int perf_event_open_llc_miss(pid_t pid, int cpu_no)
+{
+	fd_lm = perf_event_open(&pea_llc_miss, pid, cpu_no, -1,
+				PERF_FLAG_FD_CLOEXEC);
+	if (fd_lm == -1) {
+		perror("Error opening leader");
+		ctrlc_handler(0, NULL, NULL);
+		return -1;
+	}
+
+	return 0;
+}
+
+static int initialize_llc_perf(void)
+{
+	memset(&pea_llc_miss, 0, sizeof(struct perf_event_attr));
+	memset(&rf_cqm, 0, sizeof(struct read_format));
+
+	/* Initialize perf_event_attr structures for HW_CACHE_MISSES */
+	initialize_perf_event_attr();
+
+	pea_llc_miss.config = PERF_COUNT_HW_CACHE_MISSES;
+
+	rf_cqm.nr = 1;
+
+	return 0;
+}
+
+static int reset_enable_llc_perf(pid_t pid, int cpu_no)
+{
+	int ret = 0;
+
+	ret = perf_event_open_llc_miss(pid, cpu_no);
+	if (ret < 0)
+		return ret;
+
+	/* Start counters to log values */
+	ioctl_perf_event_ioc_reset_enable();
+
+	return 0;
+}
+
+/*
+ * get_llc_perf:	llc cache miss through perf events
+ * @cpu_no:		CPU number that the benchmark PID is binded to
+ *
+ * Perf events like HW_CACHE_MISSES could be used to validate number of
+ * cache lines allocated.
+ *
+ * Return: =0 on success.  <0 on failure.
+ */
+static int get_llc_perf(unsigned long *llc_perf_miss)
+{
+	__u64 total_misses;
+
+	/* Stop counters after one span to get miss rate */
+
+	ioctl(fd_lm, PERF_EVENT_IOC_DISABLE, 0);
+
+	if (read(fd_lm, &rf_cqm, sizeof(struct read_format)) == -1) {
+		perror("Could not get llc misses through perf");
+
+		return -1;
+	}
+
+	total_misses = rf_cqm.values[0].value;
+
+	close(fd_lm);
+
+	*llc_perf_miss = total_misses;
+
+	return 0;
+}
+
 /*
  * Get LLC Occupancy as reported by RESCTRL FS
  * For CQM,
@@ -81,10 +178,20 @@ static int print_results_cache(char *filename, int bm_pid,
 
 int measure_cache_vals(struct resctrl_val_param *param, int bm_pid)
 {
-	unsigned long llc_occu_resc = 0, llc_value = 0;
+	unsigned long llc_perf_miss = 0, llc_occu_resc = 0, llc_value = 0;
 	int ret;
 
 	/*
+	 * Measure cache miss from perf.
+	 */
+	if (!strcmp(param->resctrl_val, "cat")) {
+		ret = get_llc_perf(&llc_perf_miss);
+		if (ret < 0)
+			return ret;
+		llc_value = llc_perf_miss;
+	}
+
+	/*
 	 * Measure llc occupancy from resctrl.
 	 */
 	if (!strcmp(param->resctrl_val, "cqm")) {
@@ -99,3 +206,69 @@ int measure_cache_vals(struct resctrl_val_param *param, int bm_pid)
 
 	return 0;
 }
+
+/*
+ * cache_val:		execute benchmark and measure LLC occupancy resctrl
+ * and perf cache miss for the benchmark
+ * @param:		parameters passed to cache_val()
+ *
+ * Return:		0 on success. non-zero on failure.
+ */
+int cat_val(struct resctrl_val_param *param)
+{
+	int malloc_and_init_memory = 1, memflush = 1, operation = 0, ret = 0;
+	char *resctrl_val = param->resctrl_val;
+	pid_t bm_pid;
+
+	if (strcmp(param->filename, "") == 0)
+		sprintf(param->filename, "stdio");
+
+	bm_pid = getpid();
+
+	/* Taskset benchmark to specified cpu */
+	ret = taskset_benchmark(bm_pid, param->cpu_no);
+	if (ret)
+		return ret;
+
+	/* Write benchmark to specified con_mon grp, mon_grp in resctrl FS*/
+	ret = write_bm_pid_to_resctrl(bm_pid, param->ctrlgrp, param->mongrp,
+				      resctrl_val);
+	if (ret)
+		return ret;
+
+	if ((strcmp(resctrl_val, "cat") == 0)) {
+		ret = initialize_llc_perf();
+		if (ret)
+			return ret;
+	}
+
+	/* Test runs until the callback setup() tells the test to stop. */
+	while (1) {
+		if (strcmp(resctrl_val, "cat") == 0) {
+			ret = param->setup(1, param);
+			if (ret) {
+				ret = 0;
+				break;
+			}
+			ret = reset_enable_llc_perf(bm_pid, param->cpu_no);
+			if (ret)
+				break;
+
+			if (run_fill_buf(param->span, malloc_and_init_memory,
+					 memflush, operation, resctrl_val)) {
+				fprintf(stderr, "Error-running fill buffer\n");
+				ret = -1;
+				break;
+			}
+
+			sleep(1);
+			ret = measure_cache_vals(param, bm_pid);
+			if (ret)
+				break;
+		} else {
+			break;
+		}
+	}
+
+	return ret;
+}
diff --git a/tools/testing/selftests/resctrl/cat_test.c b/tools/testing/selftests/resctrl/cat_test.c
new file mode 100644
index 000000000000..264bf2325f9e
--- /dev/null
+++ b/tools/testing/selftests/resctrl/cat_test.c
@@ -0,0 +1,242 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Cache Allocation Technology (CAT) test
+ *
+ * Copyright (C) 2018 Intel Corporation
+ *
+ * Authors:
+ *    Arshiya Hayatkhan Pathan <arshiya.hayatkhan.pathan@intel.com>
+ *    Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>,
+ *    Fenghua Yu <fenghua.yu@intel.com>
+ */
+#include "resctrl.h"
+#include <unistd.h>
+
+#define RESULT_FILE_NAME1	"result_cat1"
+#define RESULT_FILE_NAME2	"result_cat2"
+#define NUM_OF_RUNS		5
+#define MAX_DIFF_PERCENT	4
+#define MAX_DIFF		1000000
+
+int count_of_bits;
+char cbm_mask[256];
+unsigned long long_mask;
+unsigned long cache_size;
+
+/*
+ * Change schemata. Write schemata to specified
+ * con_mon grp, mon_grp in resctrl FS.
+ * Run 5 times in order to get average values.
+ */
+static int cat_setup(int num, ...)
+{
+	struct resctrl_val_param *p;
+	char schemata[64];
+	va_list param;
+	int ret = 0;
+
+	va_start(param, num);
+	p = va_arg(param, struct resctrl_val_param *);
+	va_end(param);
+
+	/* Run NUM_OF_RUNS times */
+	if (p->num_of_runs >= NUM_OF_RUNS)
+		return -1;
+
+	if (p->num_of_runs == 0) {
+		sprintf(schemata, "%lx", p->mask);
+		ret = write_schemata(p->ctrlgrp, schemata, p->cpu_no,
+				     p->resctrl_val);
+	}
+	p->num_of_runs++;
+
+	return ret;
+}
+
+static void show_cache_info(unsigned long sum_llc_perf_miss, int no_of_bits,
+			    unsigned long span)
+{
+	unsigned long allocated_cache_lines = span / 64;
+	unsigned long avg_llc_perf_miss = 0;
+	float diff_percent;
+
+	avg_llc_perf_miss = sum_llc_perf_miss / (NUM_OF_RUNS - 1);
+	diff_percent = ((float)allocated_cache_lines - avg_llc_perf_miss) /
+				allocated_cache_lines * 100;
+	printf("Results are displayed in (Bytes)\n");
+	printf("\nNumber of bits: %d \t", no_of_bits);
+	printf("Avg_llc_perf_miss: %lu \t", avg_llc_perf_miss);
+	printf("Allocated cache lines: %lu \t", allocated_cache_lines);
+	printf("Percent diff=%d \t", abs((int)diff_percent));
+
+	if (genuine_intel && (abs((int)diff_percent) > MAX_DIFF_PERCENT))
+		printf("Failed\n");
+	else
+		printf("Passed\n");
+}
+
+static int check_results(struct resctrl_val_param *param)
+{
+	char *token_array[8], temp[512];
+	unsigned long sum_llc_perf_miss = 0;
+	int runs = 0, no_of_bits = 0;
+	FILE *fp;
+
+	printf("\nChecking for pass/fail\n");
+	fp = fopen(param->filename, "r");
+	if (!fp) {
+		perror("Error in opening file\n");
+
+		return errno;
+	}
+
+	while (fgets(temp, 1024, fp)) {
+		char *token = strtok(temp, ":\t");
+		int fields = 0;
+
+		while (token) {
+			token_array[fields++] = token;
+			token = strtok(NULL, ":\t");
+		}
+		/*
+		 * Discard the first value which is inaccurate due to monitoring
+		 * setup transition phase.
+		 */
+		if (runs > 0)
+			sum_llc_perf_miss += strtoul(token_array[3], NULL, 0);
+		runs++;
+	}
+
+	fclose(fp);
+	no_of_bits = count_bits(param->mask);
+
+	show_cache_info(sum_llc_perf_miss, no_of_bits, param->span);
+
+	return 0;
+}
+
+void cat_test_cleanup(void)
+{
+	remove(RESULT_FILE_NAME1);
+	remove(RESULT_FILE_NAME2);
+}
+
+int cat_perf_miss_val(int cpu_no, int n, char *cache_type)
+{
+	unsigned long l_mask, l_mask_1;
+	int ret, pipefd[2], pipe_message, mum_resctrlfs, sibling_cpu_no;
+	pid_t bm_pid;
+
+	cache_size = 0;
+	mum_resctrlfs = 1;
+
+	ret = remount_resctrlfs(mum_resctrlfs);
+	if (ret)
+		return ret;
+
+	ret = validate_resctrl_feature_request("cat");
+	if (ret)
+		return ret;
+
+	/* Get default cbm mask for L3/L2 cache */
+	ret = get_cbm_mask(cache_type);
+	if (ret)
+		return ret;
+
+	long_mask = strtoul(cbm_mask, NULL, 16);
+
+	/* Get L3/L2 cache size */
+	ret = get_cache_size(cpu_no, cache_type, &cache_size);
+	if (ret)
+		return ret;
+	printf("cache size :%lu\n", cache_size);
+
+	/* Get max number of bits from default-cabm mask */
+	count_of_bits = count_bits(long_mask);
+
+	if (n < 1 || n > count_of_bits - 1) {
+		printf("Invalid input value for no_of_bits n!\n");
+		printf("Please Enter value in range 1 to %d\n",
+		       count_of_bits - 1);
+		return -1;
+	}
+
+	/* Get core id from same socket for running another thread */
+	sibling_cpu_no = get_core_sibling(cpu_no);
+	if (sibling_cpu_no < 0)
+		return -1;
+
+	struct resctrl_val_param param = {
+		.resctrl_val	= "cat",
+		.cpu_no		= cpu_no,
+		.mum_resctrlfs	= 0,
+		.setup		= cat_setup,
+	};
+
+	l_mask = long_mask >> n;
+	l_mask_1 = ~l_mask & long_mask;
+
+	/* Set param values for parent thread which will be allocated bitmask
+	 * with (max_bits - n) bits
+	 */
+	param.span = cache_size * (count_of_bits - n) / count_of_bits;
+	strcpy(param.ctrlgrp, "c2");
+	strcpy(param.mongrp, "m2");
+	strcpy(param.filename, RESULT_FILE_NAME2);
+	param.mask = l_mask;
+	param.num_of_runs = 0;
+
+	if (pipe(pipefd)) {
+		perror("Unable to create pipe");
+		return -1;
+	}
+
+	bm_pid = fork();
+
+	/* Set param values for child thread which will be allocated bitmask
+	 * with n bits
+	 */
+	if (bm_pid == 0) {
+		param.mask = l_mask_1;
+		strcpy(param.ctrlgrp, "c1");
+		strcpy(param.mongrp, "m1");
+		param.span = cache_size * n / count_of_bits;
+		strcpy(param.filename, RESULT_FILE_NAME1);
+		param.num_of_runs = 0;
+		param.cpu_no = sibling_cpu_no;
+	}
+
+	remove(param.filename);
+
+	ret = cat_val(&param);
+	if (ret)
+		return ret;
+
+	ret = check_results(&param);
+	if (ret)
+		return ret;
+
+	if (bm_pid == 0) {
+		/* Tell parent that child is ready */
+		close(pipefd[0]);
+		pipe_message = 1;
+		write(pipefd[1], &pipe_message, sizeof(pipe_message));
+		close(pipefd[1]);
+		while (1)
+			;
+	} else {
+		/* Parent waits for child to be ready. */
+		close(pipefd[1]);
+		pipe_message = 0;
+		while (pipe_message != 1)
+			read(pipefd[0], &pipe_message, sizeof(pipe_message));
+		close(pipefd[0]);
+		kill(bm_pid, SIGKILL);
+	}
+
+	cat_test_cleanup();
+	if (bm_pid)
+		umount_resctrlfs();
+
+	return 0;
+}
diff --git a/tools/testing/selftests/resctrl/fill_buf.c b/tools/testing/selftests/resctrl/fill_buf.c
index 792a5c40a32a..3244620d3676 100644
--- a/tools/testing/selftests/resctrl/fill_buf.c
+++ b/tools/testing/selftests/resctrl/fill_buf.c
@@ -110,8 +110,11 @@ static int fill_cache_read(unsigned char *start_ptr, unsigned char *end_ptr,
 	int ret = 0;
 	FILE *fp;
 
-	while (1)
+	while (1) {
 		ret = fill_one_span_read(start_ptr, end_ptr);
+		if (!strcmp(resctrl_val, "cat"))
+			break;
+	}
 
 	/* Consume read result so that reading memory is not optimized out. */
 	fp = fopen("/dev/null", "w");
@@ -126,8 +129,11 @@ static int fill_cache_read(unsigned char *start_ptr, unsigned char *end_ptr,
 static int fill_cache_write(unsigned char *start_ptr, unsigned char *end_ptr,
 			    char *resctrl_val)
 {
-	while (1)
+	while (1) {
 		fill_one_span_write(start_ptr, end_ptr);
+		if (!strcmp(resctrl_val, "cat"))
+			break;
+	}
 
 	return 0;
 }
diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/selftests/resctrl/resctrl.h
index 2097b02a356d..dadbb3d0cad8 100644
--- a/tools/testing/selftests/resctrl/resctrl.h
+++ b/tools/testing/selftests/resctrl/resctrl.h
@@ -92,6 +92,9 @@ void mba_test_cleanup(void);
 int get_cbm_mask(char *cache_type);
 int get_cache_size(int cpu_no, char *cache_type, unsigned long *cache_size);
 void ctrlc_handler(int signum, siginfo_t *info, void *ptr);
+int cat_val(struct resctrl_val_param *param);
+void cat_test_cleanup(void);
+int cat_perf_miss_val(int cpu_no, int no_of_bits, char *cache_type);
 int cqm_resctrl_val(int cpu_no, int n, char **benchmark_cmd);
 unsigned int count_bits(unsigned long n);
 void cqm_test_cleanup(void);
diff --git a/tools/testing/selftests/resctrl/resctrl_tests.c b/tools/testing/selftests/resctrl/resctrl_tests.c
index ae93ee136863..724a86a0e5c5 100644
--- a/tools/testing/selftests/resctrl/resctrl_tests.c
+++ b/tools/testing/selftests/resctrl/resctrl_tests.c
@@ -20,7 +20,7 @@ static void cmd_help(void)
 	printf("\t-b benchmark_cmd [options]: run specified benchmark for MBM, MBA and CQM");
 	printf("\t default benchmark is builtin fill_buf\n");
 	printf("\t-t test list: run tests specified in the test list, ");
-	printf("e.g. -t mbm, mba, cqm\n");
+	printf("e.g. -t mbm, mba, cqm, cat\n");
 	printf("\t-n no_of_bits: run cache tests using specified no of bits in cache bit mask\n");
 	printf("\t-p cpu_no: specify CPU number to run the test. 1 is default\n");
 	printf("\t-h: help\n");
@@ -31,6 +31,7 @@ void tests_cleanup(void)
 	mbm_test_cleanup();
 	mba_test_cleanup();
 	cqm_test_cleanup();
+	cat_test_cleanup();
 }
 
 int main(int argc, char **argv)
@@ -39,6 +40,7 @@ int main(int argc, char **argv)
 	int res, c, cpu_no = 1, span = 250, argc_new = argc, i, no_of_bits = 5;
 	int ben_count, ben_ind;
 	bool has_ben = false, mbm_test = true, mba_test = true, cqm_test = true;
+	bool cat_test = true;
 	char *benchmark_cmd[BENCHMARK_ARGS];
 	char bw_report[64], bm_type[64];
 
@@ -62,6 +64,7 @@ int main(int argc, char **argv)
 			mbm_test = false;
 			mba_test = false;
 			cqm_test = false;
+			cat_test = false;
 			while (token) {
 				if (!strcmp(token, "mbm")) {
 					mbm_test = true;
@@ -69,6 +72,8 @@ int main(int argc, char **argv)
 					mba_test = true;
 				} else if (!strcmp(token, "cqm")) {
 					cqm_test = true;
+				} else if (!strcmp(token, "cat")) {
+					cat_test = true;
 				} else {
 					printf("invalid argument\n");
 
@@ -158,6 +163,13 @@ int main(int argc, char **argv)
 			printf("Error in CQM test!\n");
 		cqm_test_cleanup();
 	}
+	if (cat_test) {
+		printf("\nCAT Test Starting..\n");
+		res = cat_perf_miss_val(cpu_no, no_of_bits, "L3");
+		if (res)
+			printf("Error in CAT test!\n");
+		cat_test_cleanup();
+	}
 
 	return 0;
 }
diff --git a/tools/testing/selftests/resctrl/resctrlfs.c b/tools/testing/selftests/resctrl/resctrlfs.c
index 5ac7bdc5dbf0..e4568e23cff8 100644
--- a/tools/testing/selftests/resctrl/resctrlfs.c
+++ b/tools/testing/selftests/resctrl/resctrlfs.c
@@ -14,12 +14,14 @@
 #define RESCTRL_MBM		"L3 monitoring detected"
 #define RESCTRL_MBA		"MB allocation detected"
 #define RESCTRL_CQM		"L3 monitoring detected"
+#define RESCTRL_L3_CAT		"L3 allocation detected"
 #define CORE_SIBLINGS_PATH	"/sys/bus/cpu/devices/cpu"
 
 enum {
 	RESCTRL_FEATURE_MBM,
 	RESCTRL_FEATURE_MBA,
 	RESCTRL_FEATURE_CQM,
+	RESCTRL_FEATURE_L3_CAT,
 	MAX_RESCTRL_FEATURES
 };
 
@@ -490,6 +492,7 @@ int write_schemata(char *ctrlgrp, char *schemata, int cpu_no, char *resctrl_val)
 	FILE *fp;
 
 	if ((strcmp(resctrl_val, "mba") == 0) ||
+	    (strcmp(resctrl_val, "cat") == 0) ||
 	    (strcmp(resctrl_val, "cqm") == 0)) {
 		if (!schemata) {
 			printf("Schemata empty, so not updating\n");
@@ -507,7 +510,7 @@ int write_schemata(char *ctrlgrp, char *schemata, int cpu_no, char *resctrl_val)
 		else
 			sprintf(controlgroup, "%s/schemata", RESCTRL_PATH);
 
-		if (!strcmp(resctrl_val, "cqm"))
+		if (!strcmp(resctrl_val, "cat") || !strcmp(resctrl_val, "cqm"))
 			sprintf(schema, "%s%d%c%s", "L3:", resource_id, '=',
 				schemata);
 		if (strcmp(resctrl_val, "mba") == 0)
@@ -545,7 +548,7 @@ int validate_resctrl_feature_request(char *resctrl_val)
 {
 	int resctrl_features_supported[MAX_RESCTRL_FEATURES] = {0, 0, 0, 0};
 	const char *resctrl_features_list[MAX_RESCTRL_FEATURES] = {
-			"mbm", "mba", "cqm"};
+			"mbm", "mba", "cat", "cqm"};
 	int i, valid_resctrl_feature = -1;
 	char line[1024];
 	FILE *fp;
@@ -588,7 +591,8 @@ int validate_resctrl_feature_request(char *resctrl_val)
 			resctrl_features_supported[RESCTRL_FEATURE_MBA] = 1;
 		if ((strstr(line, RESCTRL_CQM)) != NULL)
 			resctrl_features_supported[RESCTRL_FEATURE_CQM] = 1;
-
+		if ((strstr(line, RESCTRL_L3_CAT)) != NULL)
+			resctrl_features_supported[RESCTRL_FEATURE_L3_CAT] = 1;
 	}
 	fclose(fp);
 
-- 
2.7.4

