Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71815ECDE46
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 21:07:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C4EF2080A
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 21:07:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C4EF2080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730253AbeKAGHF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 02:07:05 -0400
Received: from mga11.intel.com ([192.55.52.93]:6768 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730172AbeKAGHE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 02:07:04 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 31 Oct 2018 14:07:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,449,1534834800"; 
   d="scan'208";a="102369384"
Received: from romley-ivt3.sc.intel.com ([172.25.110.60])
  by fmsmga004.fm.intel.com with ESMTP; 31 Oct 2018 14:07:18 -0700
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, "H Peter Anvin" <hpa@zytor.com>,
        "Tony Luck" <tony.luck@intel.com>,
        "Peter Zijlstra" <peterz@infradead.org>,
        "Reinette Chatre" <reinette.chatre@intel.com>,
        "Babu Moger" <babu.moger@amd.com>,
        "James Morse" <james.morse@arm.com>,
        "Ravi V Shankar" <ravi.v.shankar@intel.com>,
        "Sai Praneeth Prakhya" <sai.praneeth.prakhya@intel.com>,
        "Arshiya Hayatkhan Pathan" <arshiya.hayatkhan.pathan@intel.com>
Cc:     "linux-kernel" <linux-kernel@vger.kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>
Subject: [PATCH v3 6/8] selftests/resctrl: Add MBM test
Date:   Wed, 31 Oct 2018 14:02:32 -0700
Message-Id: <1541019754-192204-7-git-send-email-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1541019754-192204-1-git-send-email-fenghua.yu@intel.com>
References: <1541019754-192204-1-git-send-email-fenghua.yu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arshiya Hayatkhan Pathan <arshiya.hayatkhan.pathan@intel.com>

MBM (Memory Bandwidth Monitoring) test is the first implemented selftest.
It starts a stressful memory bandwidth benchmark and assigns the
bandwidth pid in a resctrl monitoring group. Read and compare perf IMC
counter and MBM total bytes for the benchmark. The numbers should be
close enough to pass the test.

Default benchmark is built-in fill_buf. But users can specify their
own benchmark by option "-b".

We can add memory bandwidth monitoring for multiple processes in the
future.

Signed-off-by: Arshiya Hayatkhan Pathan <arshiya.hayatkhan.pathan@intel.com>
Signed-off-by: Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>,
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
---
 tools/testing/selftests/resctrl/Makefile        |   8 +-
 tools/testing/selftests/resctrl/mbm_test.c      | 145 ++++++++++++++++++++++++
 tools/testing/selftests/resctrl/membw.c         |   2 +
 tools/testing/selftests/resctrl/resctrl.h       |   3 +
 tools/testing/selftests/resctrl/resctrl_tests.c | 123 ++++++++++++++++++++
 5 files changed, 280 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/resctrl/mbm_test.c
 create mode 100644 tools/testing/selftests/resctrl/resctrl_tests.c

diff --git a/tools/testing/selftests/resctrl/Makefile b/tools/testing/selftests/resctrl/Makefile
index bd5c5418961e..51165f9f8a9d 100644
--- a/tools/testing/selftests/resctrl/Makefile
+++ b/tools/testing/selftests/resctrl/Makefile
@@ -1,10 +1,16 @@
 CC = gcc
 CFLAGS = -g -Wall
 
+all: resctrl_tests
+
 *.o: *.c
 	$(CC) $(CFLAGS) -c *.c
 
+resctrl_tests: *.o
+	$(CC) $(CFLAGS) -o resctrl_tests resctrl_tests.o resctrlfs.o \
+		 membw.o fill_buf.o mbm_test.o
+
 .PHONY: clean
 
 clean:
-	$(RM) *.o *~
+	$(RM) *.o *~ resctrl_tests
diff --git a/tools/testing/selftests/resctrl/mbm_test.c b/tools/testing/selftests/resctrl/mbm_test.c
new file mode 100644
index 000000000000..fc1b8bab1c71
--- /dev/null
+++ b/tools/testing/selftests/resctrl/mbm_test.c
@@ -0,0 +1,145 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Memory Bandwidth Monitoring (MBM) test
+ *
+ * Copyright (C) 2018 Intel Corporation
+ *
+ * Authors:
+ *    Arshiya Hayatkhan Pathan <arshiya.hayatkhan.pathan@intel.com>
+ *    Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>,
+ *    Fenghua Yu <fenghua.yu@intel.com>
+ */
+#include "resctrl.h"
+
+#define RESULT_FILE_NAME	"result_mbm"
+#define MAX_DIFF		300
+#define NUM_OF_RUNS		5
+
+static void
+show_bw_info(unsigned long *bw_imc, unsigned long *bw_resc, int span)
+{
+	unsigned long avg_bw_imc = 0, avg_bw_resc = 0;
+	unsigned long sum_bw_imc = 0, sum_bw_resc = 0;
+	long avg_diff = 0;
+	int runs;
+
+	/*
+	 * Discard the first value which is inaccurate due to monitoring setup
+	 * transition phase.
+	 */
+	for (runs = 1; runs < NUM_OF_RUNS ; runs++) {
+		sum_bw_imc += bw_imc[runs];
+		sum_bw_resc += bw_resc[runs];
+	}
+
+	avg_bw_imc = sum_bw_imc / 4;
+	avg_bw_resc = sum_bw_resc / 4;
+	avg_diff = avg_bw_resc - avg_bw_imc;
+
+	printf("\nSpan (MB): %d \t", span);
+	printf("avg_bw_imc: %lu\t", avg_bw_imc);
+	printf("avg_bw_resc: %lu\t", avg_bw_resc);
+	printf("avg_diff: %lu\t", labs(avg_diff));
+
+	if (labs(avg_diff) > MAX_DIFF)
+		printf(" failed\n");
+	else
+		printf(" passed\n");
+}
+
+static int check_results(int span)
+{
+	unsigned long bw_imc[NUM_OF_RUNS], bw_resc[NUM_OF_RUNS];
+	char temp[1024], *token_array[8];
+	char output[] = RESULT_FILE_NAME;
+	int runs;
+	FILE *fp;
+
+	printf("\nChecking for pass/fail\n");
+
+	fp = fopen(output, "r");
+	if (!fp) {
+		perror("Error in opening file\n");
+
+		return errno;
+	}
+
+	runs = 0;
+	while (fgets(temp, 1024, fp)) {
+		char *token = strtok(temp, ":\t");
+		int i = 0;
+
+		while (token) {
+			token_array[i++] = token;
+			token = strtok(NULL, ":\t");
+		}
+
+		bw_resc[runs] = atol(token_array[5]);
+		bw_imc[runs] = atol(token_array[3]);
+		runs++;
+	}
+
+	show_bw_info(bw_imc, bw_resc, span);
+
+	fclose(fp);
+
+	return 0;
+}
+
+static int mbm_setup(int num, ...)
+{
+	struct resctrl_val_param *p;
+	static int num_of_runs;
+	va_list param;
+	int ret = 0;
+
+	/* Run NUM_OF_RUNS times */
+	if (num_of_runs++ >= NUM_OF_RUNS)
+		return -1;
+
+	va_start(param, num);
+	p = va_arg(param, struct resctrl_val_param *);
+	va_end(param);
+
+	/* Set up shemata with 100% allocation on the first run. */
+	if (num_of_runs == 0)
+		ret = write_schemata(p->ctrlgrp, "100", p->cpu_no,
+				     p->resctrl_val);
+
+	return ret;
+}
+
+void mbm_test_cleanup(void)
+{
+	remove(RESULT_FILE_NAME);
+}
+
+int mbm_bw_change(int span, int core_id, char *bw_report, char **benchmark_cmd)
+{
+	struct resctrl_val_param param = {
+		.resctrl_val	= "mbm",
+		.ctrlgrp	= "c1",
+		.mongrp		= "m1",
+		.span		= span,
+		.cpu_no		= core_id,
+		.mum_resctrlfs	= 1,
+		.filename	= RESULT_FILE_NAME,
+		.bw_report	=  bw_report,
+		.setup		= mbm_setup
+	};
+	int ret;
+
+	remove(RESULT_FILE_NAME);
+
+	ret = membw_val(benchmark_cmd, &param);
+	if (ret)
+		return ret;
+
+	ret = check_results(span);
+	if (ret)
+		return ret;
+
+	mbm_test_cleanup();
+
+	return 0;
+}
diff --git a/tools/testing/selftests/resctrl/membw.c b/tools/testing/selftests/resctrl/membw.c
index 75a20de0ff71..607e764a7b7a 100644
--- a/tools/testing/selftests/resctrl/membw.c
+++ b/tools/testing/selftests/resctrl/membw.c
@@ -436,6 +436,8 @@ pid_t bm_pid, ppid;
 static void ctrlc_handler(int signum, siginfo_t *info, void *ptr)
 {
 	kill(bm_pid, SIGKILL);
+	umount_resctrlfs();
+	tests_cleanup();
 	printf("Ending\n\n");
 
 	exit(EXIT_SUCCESS);
diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/selftests/resctrl/resctrl.h
index 9820af253d4d..231c1eac54e0 100644
--- a/tools/testing/selftests/resctrl/resctrl.h
+++ b/tools/testing/selftests/resctrl/resctrl.h
@@ -70,5 +70,8 @@ int perf_event_open(struct perf_event_attr *hw_event, pid_t pid, int cpu,
 		    int group_fd, unsigned long flags);
 int run_fill_buf(int span, int malloc_and_init_memory, int memflush, int op);
 int membw_val(char **benchmark_cmd, struct resctrl_val_param *param);
+int mbm_bw_change(int span, int core_id, char *bw_report, char **benchmark_cmd);
+void tests_cleanup(void);
+void mbm_test_cleanup(void);
 
 #endif /* RESCTRL_H */
diff --git a/tools/testing/selftests/resctrl/resctrl_tests.c b/tools/testing/selftests/resctrl/resctrl_tests.c
new file mode 100644
index 000000000000..8a33809ee196
--- /dev/null
+++ b/tools/testing/selftests/resctrl/resctrl_tests.c
@@ -0,0 +1,123 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Resctrl tests
+ *
+ * Copyright (C) 2018 Intel Corporation
+ *
+ * Authors:
+ *    Arshiya Hayatkhan Pathan <arshiya.hayatkhan.pathan@intel.com>
+ *    Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>,
+ *    Fenghua Yu <fenghua.yu@intel.com>
+ */
+#include "resctrl.h"
+
+#define BENCHMARK_ARGS		64
+#define BENCHMARK_ARG_SIZE	64
+
+int ben_count;
+
+static void cmd_help(void)
+{
+	printf("usage: resctrl_tests [-h] [-b \"benchmark_cmd [options]\"] [-t test list]\n");
+	printf("\t-b benchmark_cmd [options]: run specified benchmark\n");
+	printf("\t default benchmark is builtin fill_buf\n");
+	printf("\t-t test list: run tests specified in the test list, ");
+	printf("e.g. -t mbm,mba\n");
+	printf("\t-h: help\n");
+}
+
+void tests_cleanup(void)
+{
+	mbm_test_cleanup();
+}
+
+int main(int argc, char **argv)
+{
+	char benchmark_cmd_area[BENCHMARK_ARGS][BENCHMARK_ARG_SIZE];
+	int res, c, core_id = 0, span = 250, argc_new = argc, i;
+	bool has_ben = false, mbm_test = true;
+	char *benchmark_cmd[BENCHMARK_ARGS];
+	char bw_report[64], bm_type[64];
+
+	while ((c = getopt(argc_new, argv, "ht:b:")) != -1) {
+		char *token;
+
+		switch (c) {
+		case 't':
+			token = strtok(optarg, ",");
+
+			mbm_test = false;
+			while (token) {
+				if (!strcmp(token, "mbm")) {
+					mbm_test = true;
+				} else {
+					printf("invalid argument\n");
+
+					return -1;
+				}
+				token = strtok(NULL, ":\t");
+			}
+			break;
+		case 'b':
+			/* Extract benchmark command from command line. */
+			token = strtok(optarg, " ");
+			i = 0;
+			while (token) {
+				benchmark_cmd[i] = benchmark_cmd_area[i];
+				strcpy(benchmark_cmd[i++], token);
+				if (i >= BENCHMARK_ARGS) {
+					printf("Too many benchmark args\n");
+
+					return -1;
+				}
+				token = strtok(NULL, " ");
+			}
+			benchmark_cmd[i] = NULL;
+			has_ben = true;
+			break;
+		case 'h':
+			cmd_help();
+
+			return 0;
+		default:
+			printf("invalid argument\n");
+
+			return -1;
+		}
+	}
+
+	/*
+	 * We need root privileges to run because
+	 * 1. We write to resctrl FS
+	 * 2. We execute perf commands
+	 */
+	if (geteuid() != 0) {
+		perror("Please run this program as root\n");
+
+		return errno;
+	}
+
+	if (!has_ben) {
+		/* If no benchmark is given by "-b" argument, use fill_buf. */
+		for (i = 0; i < 5; i++)
+			benchmark_cmd[i] = benchmark_cmd_area[i];
+		strcpy(benchmark_cmd[0], "fill_buf");
+		sprintf(benchmark_cmd[1], "%d", span);
+		strcpy(benchmark_cmd[2], "1");
+		strcpy(benchmark_cmd[3], "1");
+		strcpy(benchmark_cmd[4], "0");
+		benchmark_cmd[5] = NULL;
+	}
+
+	sprintf(bw_report, "reads");
+	sprintf(bm_type, "fill_buf");
+
+	if (mbm_test) {
+		printf("\nMBM BW Change Starting..\n");
+		res = mbm_bw_change(span, core_id, bw_report, benchmark_cmd);
+		if (res)
+			printf("Error in running tests for mbm bw change!\n");
+	}
+
+	return 0;
+}
-- 
2.5.0

