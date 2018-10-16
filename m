Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00473C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:01:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4A16205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:01:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4A16205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727634AbeJQAwT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 20:52:19 -0400
Received: from mga17.intel.com ([192.55.52.151]:15647 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727160AbeJQAwS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 20:52:18 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Oct 2018 10:00:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,389,1534834800"; 
   d="scan'208";a="100736205"
Received: from romley-ivt3.sc.intel.com ([172.25.110.60])
  by orsmga002.jf.intel.com with ESMTP; 16 Oct 2018 10:00:57 -0700
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
Subject: [PATCH 6/7] selftests/resctrl: Add mba test
Date:   Tue, 16 Oct 2018 09:56:40 -0700
Message-Id: <1539709001-38018-7-git-send-email-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1539709001-38018-1-git-send-email-fenghua.yu@intel.com>
References: <1539709001-38018-1-git-send-email-fenghua.yu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arshiya Hayatkhan Pathan <arshiya.hayatkhan.pathan@intel.com>

mba test starts a stressful memory bandwidth benchmark and allocates
memory bandwidth from 100% down to 10% for the benchmark process. For
each allocation, compare perf IMC counter and mbm total bytes from
resctrl. The difference between the two values should be within a
threshold to pass the test.

Default benchmark is built-in fill_buf. But users can specify their
own benchmark by option "-ben".

We can add memory bandwidth allocation for multiple processes in the
future.

Signed-off-by: Arshiya Hayatkhan Pathan <arshiya.hayatkhan.pathan@intel.com>
Signed-off-by: Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>,
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
---
 tools/testing/selftests/resctrl/Makefile        |   2 +-
 tools/testing/selftests/resctrl/mba.c           | 144 ++++++++++++++++++++++++
 tools/testing/selftests/resctrl/resctrl.h       |   3 +
 tools/testing/selftests/resctrl/resctrl_tests.c |  10 ++
 4 files changed, 158 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/resctrl/mba.c

diff --git a/tools/testing/selftests/resctrl/Makefile b/tools/testing/selftests/resctrl/Makefile
index c5a69a2a5a6e..5ba73435b659 100644
--- a/tools/testing/selftests/resctrl/Makefile
+++ b/tools/testing/selftests/resctrl/Makefile
@@ -8,7 +8,7 @@ all: resctrl_tests
 
 resctrl_tests: *.o
 	$(CC) $(CFLAGS) -o resctrl_tests resctrl_tests.o resctrl.o \
-		 resctrl_val.o resctrl_membw.o fill_buf.o mbm.o
+		 resctrl_val.o resctrl_membw.o fill_buf.o mbm.o mba.o
 
 .PHONY: clean
 
diff --git a/tools/testing/selftests/resctrl/mba.c b/tools/testing/selftests/resctrl/mba.c
new file mode 100644
index 000000000000..4a3f8b156657
--- /dev/null
+++ b/tools/testing/selftests/resctrl/mba.c
@@ -0,0 +1,144 @@
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
+
+#include <stdio.h>
+#include <unistd.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/types.h>
+#include <sys/wait.h>
+
+#include "resctrl.h"
+
+int mba_schemata_change(char *resctrl_val_type, int core_id, int span,
+			char *bw_report, char *bm_type,
+			char **benchmark_cmd)
+{
+	char *token_array[8], output[] = "result", *allocation_str, temp[512];
+	unsigned long long bw_imc[1024], bw_resc[1024];
+	struct resctrl_val_param param = {
+		.resctrl_val = resctrl_val_type,
+		.ctrlgrp = "c1",
+		.mongrp = "m1",
+		.cpu_no = core_id,
+		.mum_resctrlfs = 1,
+		.num_of_runs = -1,
+		.filename = "result",
+		.bw_report =  bw_report,
+		.bm_type = bm_type
+	};
+	int allocation, x, failed, length;
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
+	printf("Bm_pid is : %d\n", bm_pid);
+
+	if (bm_pid == 0) {
+		resctrl_val(benchmark_cmd, &param);
+		PARENT_EXIT("Unable to run benchmark\n");
+	} else if (bm_pid < 0)
+		PERR_EXIT("Failed to fork\n");
+	else {
+		sleep(1);
+		/*
+		 * Change schemata percentage from 100 to 10%
+		 * Write schemata to specified con_mon grp, mon_grp in
+		 * resctrl FS
+		 */
+		for (int i = 0; i < 10; i++) {
+			allocation = 100 - 10*i;
+
+			if (strcmp(resctrl_val_type, "mba") == 0) {
+				length = snprintf(NULL, 0, "%d",
+						  allocation);
+				allocation_str = malloc(length + 1);
+				snprintf(allocation_str, length + 1,
+					 "%d", allocation);
+				write_schemata("c1", allocation_str,
+					       core_id, resctrl_val_type);
+				printf("changed schemata to : %d\n",
+					allocation);
+			}
+			sleep(5);
+		}
+		free(allocation_str);
+		kill(bm_pid, SIGINT);
+	}
+
+	printf("\nchecking for pass/fail\n");
+	fp = fopen(output, "r");
+	if (fp == NULL)
+		PERR_EXIT("Error in opening file\n");
+
+	x = 0;
+	while (fgets(temp, 1024, fp) != NULL) {
+		int i = 0;
+		char *token = strtok(temp, ":\t");
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
+	if (fclose(fp) == EOF)
+		PERR_EXIT("Error in closing file\n");
+
+	failed = 0;
+	/* Memory bandwidth from 100% down to 10% */
+	for (int i = 0; i < 10; i++) {
+		float avg_bw_imc = 0.0, avg_bw_resc = 0.0;
+		int sum_bw_imc = 0, sum_bw_resc = 0;
+		float avg_diff = 0.0;
+
+		for (int j = 5 * i + 1; j < 5*i+5 ; j++) {
+			sum_bw_imc += bw_imc[j];
+			sum_bw_resc += bw_resc[j];
+		}
+
+		avg_bw_imc = sum_bw_imc / 4.0;
+		avg_bw_resc = sum_bw_resc / 4.0;
+		avg_diff = avg_bw_resc - avg_bw_imc;
+
+		printf("\nschemata percentage: %d \t", 100 - 10 * i);
+		printf("avg_bw_imc: %.2f\t", avg_bw_imc);
+		printf("avg_bw_resc: %.2f\t", avg_bw_resc);
+		printf("avg_diff: %d \t", abs(avg_diff));
+		if (abs(avg_diff) > 300) {
+			printf("failed\n");
+			failed = 1;
+		} else
+			printf("passed\n");
+	}
+
+	if (failed) {
+		printf("\nTest for schemata change using MBA failed");
+		printf("as atleast one test failed!\n");
+	} else
+		printf("\nTests for changing schemata using MBA passed!\n\n");
+
+	if (remove(output))
+		printf("Unable to delete the file\n");
+
+	return 0;
+}
diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/selftests/resctrl/resctrl.h
index 349abf0502f5..41dc4b172672 100644
--- a/tools/testing/selftests/resctrl/resctrl.h
+++ b/tools/testing/selftests/resctrl/resctrl.h
@@ -100,5 +100,8 @@ void resctrl_val(char **benchmark_cmd, struct resctrl_val_param *param);
 
 int mbm_bw_change(char *resctrl_val_type, int core_id, int span,
 		  char *bw_report, char *bm_type, char **benchmark_cmd);
+int mba_schemata_change(char *resctrl_val_type, int core_id, int span,
+			char *bw_report, char *bm_type,
+			char **benchmark_cmd);
 
 #endif /* RESCTRL_H */
diff --git a/tools/testing/selftests/resctrl/resctrl_tests.c b/tools/testing/selftests/resctrl/resctrl_tests.c
index b9d1665bb101..93d25355cee4 100644
--- a/tools/testing/selftests/resctrl/resctrl_tests.c
+++ b/tools/testing/selftests/resctrl/resctrl_tests.c
@@ -90,5 +90,15 @@ int main(int argc, char **argv)
 	if (res)
 		printf("Error in running tests for mbm bw change!\n");
 
+	printf("\nTest 2: MBA Schemata Change Starting..\n");
+	if (!has_ben) {
+		span = 250;
+		sprintf(benchmark_cmd[1], "%d", span);
+	}
+	res = mba_schemata_change("mba", core_id, span, bw_report,
+				  bm_type, benchmark_cmd);
+	if (res)
+		printf("Error in running tests for mba-change-schemata!\n");
+
 	return 0;
 }
-- 
2.5.0

