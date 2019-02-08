Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 517D9C282C2
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 00:09:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 189A221916
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 00:09:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727247AbfBHAJo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 19:09:44 -0500
Received: from mga07.intel.com ([134.134.136.100]:65459 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726969AbfBHAI5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 19:08:57 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Feb 2019 16:08:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,346,1544515200"; 
   d="scan'208";a="122851404"
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
Subject: [PATCH v6 07/13] selftests/resctrl: Add MBA test
Date:   Thu,  7 Feb 2019 16:01:35 -0800
Message-Id: <1549584101-85811-8-git-send-email-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1549584101-85811-1-git-send-email-fenghua.yu@intel.com>
References: <1549584101-85811-1-git-send-email-fenghua.yu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arshiya Hayatkhan Pathan <arshiya.hayatkhan.pathan@intel.com>

MBA (Memory Bandwidth Allocation) test starts a stressful memory
bandwidth benchmark and allocates memory bandwidth from 100% down
to 10% for the benchmark process. For each allocation, compare
perf IMC counter and mbm total bytes from resctrl. The difference
between the two values should be within a threshold to pass the test.

Default benchmark is built-in fill_buf. But users can specify their
own benchmark by option "-b".

We can add memory bandwidth allocation for multiple processes in the
future.

Signed-off-by: Arshiya Hayatkhan Pathan <arshiya.hayatkhan.pathan@intel.com>
Signed-off-by: Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>,
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Babu Moger <babu.moger@amd.com>
---
 tools/testing/selftests/resctrl/Makefile        |   2 +-
 tools/testing/selftests/resctrl/mba_test.c      | 177 ++++++++++++++++++++++++
 tools/testing/selftests/resctrl/resctrl.h       |   2 +
 tools/testing/selftests/resctrl/resctrl_tests.c |  15 +-
 4 files changed, 194 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/resctrl/mba_test.c

diff --git a/tools/testing/selftests/resctrl/Makefile b/tools/testing/selftests/resctrl/Makefile
index eaa8b45de10d..141cbdb619af 100644
--- a/tools/testing/selftests/resctrl/Makefile
+++ b/tools/testing/selftests/resctrl/Makefile
@@ -8,7 +8,7 @@ all: resctrl_tests
 
 resctrl_tests: *.o
 	$(CC) $(CFLAGS) -o resctrl_tests resctrl_tests.o resctrlfs.o \
-		 resctrl_val.o fill_buf.o mbm_test.o
+		 resctrl_val.o fill_buf.o mbm_test.o mba_test.o
 
 .PHONY: clean
 
diff --git a/tools/testing/selftests/resctrl/mba_test.c b/tools/testing/selftests/resctrl/mba_test.c
new file mode 100644
index 000000000000..71d8feb93ac8
--- /dev/null
+++ b/tools/testing/selftests/resctrl/mba_test.c
@@ -0,0 +1,177 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Memory Bandwidth Allocation (MBA) test
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
+#define RESULT_FILE_NAME	"result_mba"
+#define NUM_OF_RUNS		5
+#define MAX_DIFF		300
+#define ALLOCATION_MAX		100
+#define ALLOCATION_MIN		10
+#define ALLOCATION_STEP		10
+
+/*
+ * Change schemata percentage from 100 to 10%. Write schemata to specified
+ * con_mon grp, mon_grp in resctrl FS.
+ * For each allocation, run 5 times in order to get average values.
+ */
+static int mba_setup(int num, ...)
+{
+	static int runs_per_allocation, allocation = 100;
+	struct resctrl_val_param *p;
+	char allocation_str[64];
+	va_list param;
+
+	va_start(param, num);
+	p = va_arg(param, struct resctrl_val_param *);
+	va_end(param);
+
+	if (runs_per_allocation >= NUM_OF_RUNS)
+		runs_per_allocation = 0;
+
+	/* Only set up schemata once every NUM_OF_RUNS of allocations */
+	if (runs_per_allocation++ != 0)
+		return 0;
+
+	if (allocation < ALLOCATION_MIN || allocation > ALLOCATION_MAX)
+		return -1;
+
+	sprintf(allocation_str, "%d", allocation);
+
+	write_schemata(p->ctrlgrp, allocation_str, p->cpu_no, p->resctrl_val);
+	printf("changed schemata to : %d\n", allocation);
+	allocation -= ALLOCATION_STEP;
+
+	return 0;
+}
+
+static void show_mba_info(unsigned long *bw_imc, unsigned long *bw_resc)
+{
+	int allocation, failed = 0, runs;
+
+	/* Memory bandwidth from 100% down to 10% */
+	for (allocation = 0; allocation < ALLOCATION_MAX / ALLOCATION_STEP;
+	     allocation++) {
+		unsigned long avg_bw_imc = 0, avg_bw_resc = 0;
+		unsigned long sum_bw_imc = 0, sum_bw_resc = 0;
+		long  avg_diff = 0;
+
+		/*
+		 * The first run is discarded due to inaccurate value from
+		 * phase transition.
+		 */
+		for (runs = NUM_OF_RUNS * allocation + 1;
+		     runs < NUM_OF_RUNS * allocation + NUM_OF_RUNS ; runs++) {
+			sum_bw_imc += bw_imc[runs];
+			sum_bw_resc += bw_resc[runs];
+		}
+
+		avg_bw_imc = sum_bw_imc / (NUM_OF_RUNS - 1);
+		avg_bw_resc = sum_bw_resc / (NUM_OF_RUNS - 1);
+		avg_diff = avg_bw_resc - avg_bw_imc;
+
+		printf("\nschemata percentage: %d \t",
+		       ALLOCATION_MAX - ALLOCATION_STEP * allocation);
+		printf("avg_bw_imc: %lu\t", avg_bw_imc);
+		printf("avg_bw_resc: %lu\t", avg_bw_resc);
+		printf("avg_diff: %lu\t", labs(avg_diff));
+		if (labs(avg_diff) > MAX_DIFF) {
+			printf("failed\n");
+			failed = 1;
+		} else {
+			printf("passed\n");
+		}
+	}
+
+	if (failed) {
+		printf("\nTest for schemata change using MBA failed");
+		printf("as atleast one test failed!\n");
+	} else {
+		printf("\nTests for changing schemata using MBA passed!\n\n");
+	}
+}
+
+static int check_results(void)
+{
+	char *token_array[8], output[] = RESULT_FILE_NAME, temp[512];
+	unsigned long bw_imc[1024], bw_resc[1024];
+	int runs;
+	FILE *fp;
+
+	printf("\nchecking for pass/fail\n");
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
+		int fields = 0;
+
+		while (token) {
+			token_array[fields++] = token;
+			token = strtok(NULL, ":\t");
+		}
+
+		/* Field 3 is perf imc value */
+		bw_imc[runs] = strtoul(token_array[3], NULL, 0);
+		/* Field 5 is resctrl value */
+		bw_resc[runs] = strtoul(token_array[5], NULL, 0);
+		runs++;
+	}
+
+	fclose(fp);
+
+	show_mba_info(bw_imc, bw_resc);
+
+	return 0;
+}
+
+void mba_test_cleanup(void)
+{
+	remove(RESULT_FILE_NAME);
+}
+
+int mba_schemata_change(int cpu_no, char *bw_report, char **benchmark_cmd)
+{
+	struct resctrl_val_param param = {
+		.resctrl_val	= "mba",
+		.ctrlgrp	= "c1",
+		.mongrp		= "m1",
+		.cpu_no		= cpu_no,
+		.mum_resctrlfs	= 1,
+		.filename	= RESULT_FILE_NAME,
+		.bw_report	= bw_report,
+		.setup		= mba_setup
+	};
+	int ret;
+
+	remove(RESULT_FILE_NAME);
+
+	ret = validate_resctrl_feature_request("mba");
+	if (ret)
+		return ret;
+
+	ret = resctrl_val(benchmark_cmd, &param);
+	if (ret)
+		return ret;
+
+	ret = check_results();
+	if (ret)
+		return ret;
+
+	mba_test_cleanup();
+
+	return 0;
+}
diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/selftests/resctrl/resctrl.h
index 7f7ea180478c..92e5f2930c68 100644
--- a/tools/testing/selftests/resctrl/resctrl.h
+++ b/tools/testing/selftests/resctrl/resctrl.h
@@ -74,5 +74,7 @@ int resctrl_val(char **benchmark_cmd, struct resctrl_val_param *param);
 int mbm_bw_change(int span, int cpu_no, char *bw_report, char **benchmark_cmd);
 void tests_cleanup(void);
 void mbm_test_cleanup(void);
+int mba_schemata_change(int cpu_no, char *bw_report, char **benchmark_cmd);
+void mba_test_cleanup(void);
 
 #endif /* RESCTRL_H */
diff --git a/tools/testing/selftests/resctrl/resctrl_tests.c b/tools/testing/selftests/resctrl/resctrl_tests.c
index 9b6037dbd25e..2eb74cbc8d3d 100644
--- a/tools/testing/selftests/resctrl/resctrl_tests.c
+++ b/tools/testing/selftests/resctrl/resctrl_tests.c
@@ -27,6 +27,7 @@ static void cmd_help(void)
 void tests_cleanup(void)
 {
 	mbm_test_cleanup();
+	mba_test_cleanup();
 }
 
 int main(int argc, char **argv)
@@ -34,7 +35,7 @@ int main(int argc, char **argv)
 	char benchmark_cmd_area[BENCHMARK_ARGS][BENCHMARK_ARG_SIZE];
 	int res, c, cpu_no = 1, span = 250, argc_new = argc, i;
 	int ben_count, ben_ind;
-	bool has_ben = false, mbm_test = true;
+	bool has_ben = false, mbm_test = true, mba_test = true;
 	char *benchmark_cmd[BENCHMARK_ARGS];
 	char bw_report[64], bm_type[64];
 
@@ -56,9 +57,12 @@ int main(int argc, char **argv)
 			token = strtok(optarg, ",");
 
 			mbm_test = false;
+			mba_test = false;
 			while (token) {
 				if (!strcmp(token, "mbm")) {
 					mbm_test = true;
+				} else if (!strcmp(token, "mba")) {
+					mba_test = true;
 				} else {
 					printf("invalid argument\n");
 
@@ -111,5 +115,14 @@ int main(int argc, char **argv)
 			printf("Error in running tests for mbm bw change!\n");
 	}
 
+	if (mba_test) {
+		printf("\nMBA Schemata Change Starting..\n");
+		if (!has_ben)
+			sprintf(benchmark_cmd[1], "%d", span);
+		res = mba_schemata_change(cpu_no, bw_report, benchmark_cmd);
+		if (res)
+			printf("Error in tests for mba-change-schemata!\n");
+	}
+
 	return 0;
 }
-- 
2.7.4

