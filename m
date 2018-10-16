Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00CFBC5ACC6
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:01:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C138C21471
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:01:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C138C21471
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727699AbeJQAwU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 20:52:20 -0400
Received: from mga17.intel.com ([192.55.52.151]:15647 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727601AbeJQAwR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 20:52:17 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Oct 2018 10:00:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,389,1534834800"; 
   d="scan'208";a="100736201"
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
Subject: [PATCH 5/7] selftests/resctrl: Add mbm test
Date:   Tue, 16 Oct 2018 09:56:39 -0700
Message-Id: <1539709001-38018-6-git-send-email-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1539709001-38018-1-git-send-email-fenghua.yu@intel.com>
References: <1539709001-38018-1-git-send-email-fenghua.yu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arshiya Hayatkhan Pathan <arshiya.hayatkhan.pathan@intel.com>

mbm test is the first implemented selftest. It starts a stressful
memory bandwidth benchmark and assigns the bandwidth pid in a
resctrl monitoring group. Read and compare perf IMC counter and mbm
total bytes for the benchmark. The numbers should be close enough
to pass the test.

Default benchmark is built-in fill_buf. But users can specify their
own benchmark by option "-ben".

We can add memory bandwidth monitoring for multiple processes in the
future.

Signed-off-by: Arshiya Hayatkhan Pathan <arshiya.hayatkhan.pathan@intel.com>
Signed-off-by: Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>,
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
---
 tools/testing/selftests/resctrl/Makefile        |   8 +-
 tools/testing/selftests/resctrl/mbm.c           | 113 ++++++++++++++++++++++++
 tools/testing/selftests/resctrl/resctrl.h       |   3 +
 tools/testing/selftests/resctrl/resctrl_tests.c |  94 ++++++++++++++++++++
 4 files changed, 217 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/resctrl/mbm.c
 create mode 100644 tools/testing/selftests/resctrl/resctrl_tests.c

diff --git a/tools/testing/selftests/resctrl/Makefile b/tools/testing/selftests/resctrl/Makefile
index bd5c5418961e..c5a69a2a5a6e 100644
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
+	$(CC) $(CFLAGS) -o resctrl_tests resctrl_tests.o resctrl.o \
+		 resctrl_val.o resctrl_membw.o fill_buf.o mbm.o
+
 .PHONY: clean
 
 clean:
-	$(RM) *.o *~
+	$(RM) *.o *~ resctrl_tests
diff --git a/tools/testing/selftests/resctrl/mbm.c b/tools/testing/selftests/resctrl/mbm.c
new file mode 100644
index 000000000000..9edf9bd58bf5
--- /dev/null
+++ b/tools/testing/selftests/resctrl/mbm.c
@@ -0,0 +1,113 @@
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
+
+#include <stdio.h>
+#include <unistd.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/types.h>
+#include <sys/wait.h>
+#include "resctrl.h"
+
+
+static void
+show_bw_info(unsigned long long *bw_imc, unsigned long long *bw_resc, int span)
+{
+	float avg_bw_imc = 0.0, avg_bw_resc = 0.0, avg_diff = 0.0;
+	int i, sum_bw_imc = 0, sum_bw_resc = 0;
+
+	for (i = 1; i < 5 ; i++) {
+		sum_bw_imc += bw_imc[i];
+		sum_bw_resc += bw_resc[i];
+	}
+
+	avg_bw_imc = sum_bw_imc/4.0;
+	avg_bw_resc = sum_bw_resc/4.0;
+	avg_diff = avg_bw_resc - avg_bw_imc;
+
+	printf("\n Span (MB): %d \t", span);
+	printf("avg_bw_imc: %.2f\t", avg_bw_imc);
+	printf("avg_bw_resc: %.2f\t", avg_bw_resc);
+	printf("avg_diff: %d \t", abs(avg_diff));
+
+	if (abs(avg_diff) > 300)
+		printf(" failed\n");
+	else
+		printf(" passed\n");
+}
+
+int mbm_bw_change(char *resctrl_val_type, int core_id, int span,
+		  char *bw_report, char *bm_type, char **benchmark_cmd)
+{
+	char temp[512], *token_array[8], *allocation_str;
+	unsigned long long bw_imc[1024], bw_resc[1024];
+	struct resctrl_val_param param = {
+		.resctrl_val = resctrl_val_type,
+		.ctrlgrp = "c1",
+		.mongrp = "m1",
+		.cpu_no = core_id,
+		.mum_resctrlfs = 1,
+		.num_of_runs = 5,
+		.filename = "result1",
+		.bw_report =  bw_report,
+		.bm_type = bm_type
+	};
+	int allocation, x, length, status;
+	char *output = "result1";
+	pid_t bm_pid;
+	FILE *fp;
+
+	allocation = 100;
+	length = snprintf(NULL, 0, "%d", allocation);
+	allocation_str = malloc(length + 1);
+	snprintf(allocation_str, length + 1, "%d", allocation);
+	param.schemata = allocation_str;
+
+	bm_pid = fork();
+
+	if (bm_pid == 0) {
+		resctrl_val(benchmark_cmd, &param);
+		PARENT_EXIT("Unable to run benchmark\n");
+	} else if (bm_pid < 0)
+		PERR_EXIT("Failed to fork\n");
+
+	waitpid(bm_pid, &status, 0);
+
+	printf("\n Checking for pass/fail\n");
+
+	fp = fopen(output, "r");
+	if (fp == NULL)
+		PERR_EXIT("Error in opening file\n");
+
+	x = 0;
+	while (fgets(temp, 1024, fp) != NULL) {
+		char *token = strtok(temp, ":\t");
+		int i = 0;
+
+		while (token != NULL) {
+			token_array[i++] = token;
+			token = strtok(NULL, ":\t");
+		}
+
+		bw_resc[x] = atoll(token_array[5]);
+		bw_imc[x] = atoll(token_array[3]);
+		x++;
+	}
+
+	show_bw_info(bw_imc, bw_resc, span);
+
+	fclose(fp);
+	if (remove(output))
+		printf("Unable to delete the file\n");
+
+	return 0;
+}
diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/selftests/resctrl/resctrl.h
index ab65bdd0a96f..349abf0502f5 100644
--- a/tools/testing/selftests/resctrl/resctrl.h
+++ b/tools/testing/selftests/resctrl/resctrl.h
@@ -98,4 +98,7 @@ int perf_event_open(struct perf_event_attr *hw_event, pid_t pid, int cpu,
 int run_fill_buf(int span, int malloc_and_init_memory, int memflush, int op);
 void resctrl_val(char **benchmark_cmd, struct resctrl_val_param *param);
 
+int mbm_bw_change(char *resctrl_val_type, int core_id, int span,
+		  char *bw_report, char *bm_type, char **benchmark_cmd);
+
 #endif /* RESCTRL_H */
diff --git a/tools/testing/selftests/resctrl/resctrl_tests.c b/tools/testing/selftests/resctrl/resctrl_tests.c
new file mode 100644
index 000000000000..b9d1665bb101
--- /dev/null
+++ b/tools/testing/selftests/resctrl/resctrl_tests.c
@@ -0,0 +1,94 @@
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
+int ben_count;
+
+int main(int argc, char **argv)
+{
+	int res, c, ben_ind, core_id, span, argc_new, has_ben;
+	char *bw_report = NULL, *bm_type = NULL;
+	char **benchmark_cmd = NULL;
+
+	ben_ind = 0, core_id = 0, span = 250, argc_new = argc;
+	has_ben = 0;
+
+	/*
+	 * We need root privileges to run because
+	 * 1. We write to resctrl FS
+	 * 2. We execute perf commands
+	 */
+	if (geteuid() != 0)
+		FPRINTF_EXIT("Please run this program as root\n");
+
+	/*
+	 * Extract benchmark command from command line.
+	 */
+	for (int i = 0; i < argc; i++) {
+		if (strcmp(argv[i], "-ben") == 0) {
+			ben_ind = i + 1;
+			printf("ben_id:%d\n", ben_ind);
+			ben_count = argc - ben_ind;
+			argc_new = ben_ind - 1;
+			has_ben = 1;
+			break;
+		}
+	}
+
+	while ((c = getopt(argc_new, argv, "p:s:")) != -1) {
+		switch (c) {
+		case 'p':
+			core_id = atoi(optarg);
+			break;
+		case 's':
+			span = atoi(optarg);
+			break;
+		}
+	}
+
+	benchmark_cmd = malloc(10 * sizeof(char *));
+	if (!benchmark_cmd)
+		return -1;
+
+	if (has_ben) {
+		for (int i = ben_ind; i < argc; i++) {
+			benchmark_cmd[i - ben_ind] = malloc(1024 *
+							sizeof(char));
+			if (benchmark_cmd[i - ben_ind] == NULL)
+				return -1;
+			sprintf(benchmark_cmd[i - ben_ind], "%s",
+				argv[i]);
+		}
+	} else {
+		for (int i = 0; i < 5; i++) {
+			benchmark_cmd[i] = malloc(1024 * sizeof(char));
+			if (benchmark_cmd[i] == NULL)
+				return -1;
+		}
+		strcpy(benchmark_cmd[0], "fill_buf");
+		sprintf(benchmark_cmd[1], "%d", span);
+		strcpy(benchmark_cmd[2], "1");
+		strcpy(benchmark_cmd[3], "1");
+		strcpy(benchmark_cmd[4], "0");
+	}
+
+	bw_report = "reads";
+	bm_type = "fill_buf";
+
+	printf("\nTest 1 : MBM BW Change Starting..\n");
+	res = mbm_bw_change("mbm", core_id, span, bw_report, bm_type,
+			    benchmark_cmd);
+	if (res)
+		printf("Error in running tests for mbm bw change!\n");
+
+	return 0;
+}
-- 
2.5.0

