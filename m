Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88B05C5ACC8
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:00:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F366205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:00:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F366205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727565AbeJQAwP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 20:52:15 -0400
Received: from mga17.intel.com ([192.55.52.151]:15627 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727180AbeJQAwP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 20:52:15 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Oct 2018 10:00:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,389,1534834800"; 
   d="scan'208";a="100736181"
Received: from romley-ivt3.sc.intel.com ([172.25.110.60])
  by orsmga002.jf.intel.com with ESMTP; 16 Oct 2018 10:00:55 -0700
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
Subject: [PATCH 1/7] selftests/resctrl: Add basic resctrl file system operations and data
Date:   Tue, 16 Oct 2018 09:56:35 -0700
Message-Id: <1539709001-38018-2-git-send-email-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1539709001-38018-1-git-send-email-fenghua.yu@intel.com>
References: <1539709001-38018-1-git-send-email-fenghua.yu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>

The basic resctrl file system operations and data are added for future
usage by resctrl selftest tool.

Signed-off-by: Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
Signed-off-by: Arshiya Hayatkhan Pathan <arshiya.hayatkhan.pathan@intel.com>
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
---
 tools/testing/selftests/resctrl/Makefile  |  10 +
 tools/testing/selftests/resctrl/resctrl.c | 367 ++++++++++++++++++++++++++++++
 tools/testing/selftests/resctrl/resctrl.h |  74 ++++++
 3 files changed, 451 insertions(+)
 create mode 100644 tools/testing/selftests/resctrl/Makefile
 create mode 100644 tools/testing/selftests/resctrl/resctrl.c
 create mode 100644 tools/testing/selftests/resctrl/resctrl.h

diff --git a/tools/testing/selftests/resctrl/Makefile b/tools/testing/selftests/resctrl/Makefile
new file mode 100644
index 000000000000..bd5c5418961e
--- /dev/null
+++ b/tools/testing/selftests/resctrl/Makefile
@@ -0,0 +1,10 @@
+CC = gcc
+CFLAGS = -g -Wall
+
+*.o: *.c
+	$(CC) $(CFLAGS) -c *.c
+
+.PHONY: clean
+
+clean:
+	$(RM) *.o *~
diff --git a/tools/testing/selftests/resctrl/resctrl.c b/tools/testing/selftests/resctrl/resctrl.c
new file mode 100644
index 000000000000..61014228ea24
--- /dev/null
+++ b/tools/testing/selftests/resctrl/resctrl.c
@@ -0,0 +1,367 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Basic resctrl file system operations
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
+/*
+ * remount_resctrlfs:	Remount resctrl FS at /sys/fs/resctrl
+ * @mum_resctrlfs:	Should the resctrl FS be remounted?
+ * If not mounted, mount it.
+ * If mounted and mum_resctrlfs then remount resctrl FS.
+ * If mounted and !mum_resctrlfs then noop
+ */
+void remount_resctrlfs(bool mum_resctrlfs)
+{
+	DIR *dp;
+	struct dirent *ep;
+	unsigned int count = 0;
+
+	/*
+	 * If kernel is built with CONFIG_RESCTRL, then /sys/fs/resctrl should
+	 * be present by default
+	 */
+	dp = opendir(RESCTRL_PATH);
+	if (dp != NULL) {
+		while ((ep = readdir(dp)) != NULL)
+			count++;
+		closedir(dp);
+	} else {
+		PERR_EXIT("Unable to read /sys/fs/resctrl");
+	}
+
+	/*
+	 * If resctrl FS has more than two entries, it means that resctrl FS has
+	 * already been mounted. The two default entries are "." and "..", these
+	 * are present even when resctrl FS is not mounted
+	 */
+	if (count > 2) {
+		if (mum_resctrlfs) {
+			if (umount(RESCTRL_PATH) != 0)
+				PERR_EXIT("Unable to umount resctrl");
+			printf("Remount: done!\n");
+		} else {
+			printf("Not remounting!\n");
+			return;
+		}
+	}
+
+	if (mount("resctrl", RESCTRL_PATH, "resctrl", 0, NULL) != 0)
+		PERR_EXIT("Unable to mount resctrl FS at /sys/fs/resctrl");
+}
+
+char get_sock_num(int cpu_no)
+{
+	char sock_num, phys_pkg_path[1024];
+	FILE *fp;
+
+	sprintf(phys_pkg_path, "%s%d/topology/physical_package_id",
+		PHYS_ID_PATH, cpu_no);
+	fp = fopen(phys_pkg_path, "r");
+	if (!fp || fscanf(fp, "%c", &sock_num) <= 0 || fclose(fp) == EOF)
+		CHILD_EXIT("Could not get socket number");
+
+	return sock_num;
+}
+
+/*
+ * taskset_benchmark:	Taskset PID (i.e. benchmark) to a specified cpu
+ * @bm_pid:		PID that should be binded
+ * @cpu_no:		CPU number at which the PID would be binded
+ */
+void taskset_benchmark(pid_t bm_pid, int cpu_no)
+{
+	cpu_set_t my_set;
+
+	CPU_ZERO(&my_set);
+	CPU_SET(cpu_no, &my_set);
+
+	if (sched_setaffinity(bm_pid, sizeof(cpu_set_t), &my_set))
+		CHILD_EXIT("Unable to taskset benchmark");
+
+	printf("Taskset benchmark: done!\n");
+}
+
+/*
+ * Run a specified benchmark or fill buffer (default benchmark) by directing
+ * benchmark stdio to /dev/null
+ */
+void run_benchmark(int signum, siginfo_t *info, void *ucontext)
+{
+	char **benchmark_cmd = info->si_ptr;
+	int span, operation;
+
+	/*
+	 * Direct stdio of child to /dev/null, so that only parent writes to
+	 * stdio (console)
+	 */
+	if (freopen("/dev/null", "w", stdout) == NULL)
+		PARENT_EXIT("Unable to direct BM op to /dev/null");
+
+	if (strcmp(benchmark_cmd[0], "fill_buf") == 0) {
+		span = atoi(benchmark_cmd[1]);
+		operation = atoi(benchmark_cmd[4]);
+		if (run_fill_buf(span, 1, 1, operation))
+			printf("Error in running fill buffer\n");
+	} else {
+		benchmark_cmd[ben_count] = malloc(1024 * sizeof(char));
+		sprintf(benchmark_cmd[ben_count], "%s", "NULL");
+		/* Replace child with specified benchmark */
+		execvp(benchmark_cmd[0], benchmark_cmd);
+	}
+
+	PARENT_EXIT("Unable to run specified benchmark");
+}
+
+/*
+ * create_con_mon_grp:	Create a con_mon group *only* if one doesn't exist
+ * @ctrlgrp:		Name of the con_mon group
+ * @controlgroup:	Path at which it should be created
+ */
+void create_con_mon_grp(const char *ctrlgrp, const char *controlgroup)
+{
+	int found_ctrl_grp = 0;
+	struct dirent *ep;
+	DIR *dp;
+
+	/*
+	 * At this point, we are guaranteed to have resctrl FS mounted and if
+	 * ctrlgrp == NULL, it means, user wants to use root con_mon grp, so do
+	 * nothing
+	 */
+	if (!ctrlgrp)
+		return;
+
+	/* Check if requested con_mon grp exists or not */
+	dp = opendir(RESCTRL_PATH);
+	if (dp != NULL) {
+		while ((ep = readdir(dp)) != NULL) {
+			if (strcmp(ep->d_name, ctrlgrp) == 0)
+				found_ctrl_grp = 1;
+		}
+		closedir(dp);
+	} else {
+		CHILD_EXIT("Unable to open resctrlfs for con_mon grp");
+	}
+
+	/* Requested con_mon grp doesn't exist, hence create it */
+	if (found_ctrl_grp == 0) {
+		if (mkdir(controlgroup, 0) == -1)
+			CHILD_EXIT("Unable to create con_mon group");
+	}
+}
+
+/*
+ * create_mon_grp:	Create a monitor group *only* if one doesn't exist
+ * @mongrp:		Name of the monitor group
+ * @controlgroup:	Path of con_mon grp at which the mon grp will be created
+ */
+void create_mon_grp(const char *mongrp, const char *controlgroup)
+{
+	char monitorgroup[1024];
+	int found_mon_grp = 0;
+	struct dirent *ep;
+	DIR *dp;
+
+	/* Check if requested mon grp exists or not */
+	sprintf(monitorgroup, "%s/mon_groups", controlgroup);
+	dp = opendir(monitorgroup);
+	if (dp != NULL) {
+		while ((ep = readdir(dp)) != NULL) {
+			if (strcmp(ep->d_name, mongrp) == 0)
+				found_mon_grp = 1;
+		}
+		closedir(dp);
+	} else {
+		CHILD_EXIT("Unable to open resctrl FS for mon group");
+	}
+
+	/* Requested mon grp doesn't exist, hence create it */
+	sprintf(monitorgroup, "%s/mon_groups/%s", controlgroup, mongrp);
+	if (found_mon_grp == 0) {
+		if (mkdir(monitorgroup, 0) == -1)
+			CHILD_EXIT("Unable to create mon group");
+	}
+}
+
+/*
+ * write_bm_pid_to_resctrl:	Write a PID (i.e. benchmark) to resctrl FS
+ * @bm_pid:			PID that should be written
+ * @ctrlgrp:			Name of the control monitor group (con_mon grp)
+ * @mongrp:			Name of the monitor group (mon grp)
+ * @resctrl_val:		Resctrl feature (Eg: mbm, mba.. etc)
+ *
+ * If a con_mon grp is requested, create it and write pid to it, otherwise
+ * write pid to root con_mon grp.
+ * If a mon grp is requested, create it and write pid to it, otherwise
+ * pid is not written, this means that pid is in con_mon grp and hence
+ * should consult con_mon grp's mon_data directory for results.
+ */
+void write_bm_pid_to_resctrl(pid_t bm_pid, char *ctrlgrp, char *mongrp,
+			     char *resctrl_val)
+{
+	char controlgroup[1024], monitorgroup[1024];
+	FILE *fp;
+
+	if (ctrlgrp)
+		sprintf(controlgroup, "%s/%s", RESCTRL_PATH, ctrlgrp);
+	else
+		sprintf(controlgroup, "%s", RESCTRL_PATH);
+
+	create_con_mon_grp(ctrlgrp, controlgroup);
+
+	/* Create mon grp, only for monitoring features like "mbm" */
+	if ((strcmp(resctrl_val, "mbm") == 0)) {
+		if (mongrp) {
+			create_mon_grp(mongrp, controlgroup);
+			sprintf(monitorgroup, "%s/mon_groups/%s/tasks",
+				controlgroup, mongrp);
+		}
+	}
+
+	strcat(controlgroup, "/tasks");
+
+	/* Write child pid to con_mon grp */
+	fp = fopen(controlgroup, "w");
+	if (!fp || fprintf(fp, "%d\n", bm_pid) <= 0 || fclose(fp) == EOF)
+		CHILD_EXIT("Failed to write child to con_mon grp");
+
+	/* Write child pid to mon grp, only for "mbm" */
+	if ((strcmp(resctrl_val, "mbm") == 0)) {
+		if (mongrp) {
+			fp = fopen(monitorgroup, "w");
+			if (!fp || fprintf(fp, "%d\n", bm_pid) <= 0 ||
+			    fclose(fp) == EOF)
+				CHILD_EXIT("Failed to write child to mon grp");
+		}
+	}
+	printf("Write benchmark to resctrl FS: done!\n");
+}
+
+/*
+ * write_schemata:	Update schemata of a con_mon grp
+ * @ctrlgrp:		Name of the con_mon grp
+ * @schemata:		Schemata that should be updated to
+ * @cpu_no:		CPU number that the benchmark PID is binded to
+ * @resctrl_val:	Resctrl feature (Eg: mbm, mba.. etc)
+ *
+ * Update schemata of a con_mon grp *only* if requested resctrl feature is
+ * allocation type
+ */
+void write_schemata(char *ctrlgrp, char *schemata, int cpu_no,
+		    char *resctrl_val)
+{
+	char sock_num, controlgroup[1024], schema[1024];
+	FILE *fp;
+
+	if (strcmp(resctrl_val, "mba") == 0) {
+
+		if (!schemata) {
+			fprintf(stderr, "Schemata empty, so not updating\n");
+			return;
+		}
+		sock_num = get_sock_num(cpu_no);
+		if (ctrlgrp)
+			sprintf(controlgroup, "%s/%s/schemata", RESCTRL_PATH,
+				ctrlgrp);
+		else
+			sprintf(controlgroup, "%s/schemata", RESCTRL_PATH);
+		sprintf(schema, "%s%c%c%s", "MB:", sock_num, '=', schemata);
+
+		fp = fopen(controlgroup, "w");
+		if (!fp || fprintf(fp, "%s\n", schema) <= 0 ||
+		    fclose(fp) == EOF)
+			CHILD_EXIT("Unable to write schemata to con_mon grp");
+		printf("Write schemata to resctrl FS: done!\n");
+	}
+}
+
+/*
+ * Check if the requested feature is a valid resctrl feature or not.
+ * If yes, check if it's supported by this platform or not.
+ */
+void validate_resctrl_feature_request(char *resctrl_val)
+{
+	const char *resctrl_features_list[MAX_RESCTRL_FEATURES] = {
+			"mbm", "mba"};
+	int resctrl_features_supported[MAX_RESCTRL_FEATURES] = {0, 0};
+	int i, valid_resctrl_feature = -1;
+	char line[1024];
+	FILE *fp;
+
+	if (!resctrl_val)
+		FPRINTF_EXIT("resctrl feature cannot be NULL\n");
+
+	/* Is the resctrl feature request valid? */
+	for (i = 0; i < MAX_RESCTRL_FEATURES; i++) {
+		if (strcmp(resctrl_features_list[i], resctrl_val) == 0)
+			valid_resctrl_feature = i;
+	}
+	if (valid_resctrl_feature == -1)
+		FPRINTF_EXIT("Not a valid resctrl feature request\n");
+
+	/* Enumerate resctrl features supported by this platform */
+	if (system("dmesg > dmesg") != 0)
+		PERR_EXIT("Could not create custom dmesg file");
+
+	fp = fopen("dmesg", "r");
+	if (!fp)
+		PERR_EXIT("Could not read custom created dmesg");
+
+	while (fgets(line, 1024, fp) != NULL) {
+		if ((strstr(line, RESCTRL_MBM)) != NULL)
+			resctrl_features_supported[0] = 1;
+		if ((strstr(line, RESCTRL_MBA)) != NULL)
+			resctrl_features_supported[1] = 1;
+	}
+	if (fclose(fp) == EOF)
+		PERR_EXIT("Error in closing file");
+
+	if (system("rm -rf dmesg") != 0)
+		perror("Unable to remove 'dmesg' file");
+
+	/* Is the resctrl feature request supported? */
+	if (!resctrl_features_supported[valid_resctrl_feature])
+		FPRINTF_EXIT("resctrl feature not supported!");
+}
+
+void validate_bw_report_request(char *bw_report)
+{
+	if (strcmp(bw_report, "reads") == 0)
+		return;
+	if (strcmp(bw_report, "writes") == 0)
+		return;
+	if (strcmp(bw_report, "nt-writes") == 0) {
+		strcpy(bw_report, "writes");
+		return;
+	}
+	if (strcmp(bw_report, "total") == 0)
+		return;
+
+	FPRINTF_EXIT("Requested iMC B/W report type unavailable\n");
+}
+
+int perf_event_open(struct perf_event_attr *hw_event, pid_t pid, int cpu,
+		    int group_fd, unsigned long flags)
+{
+	int ret;
+
+	ret = syscall(__NR_perf_event_open, hw_event, pid, cpu,
+		      group_fd, flags);
+	return ret;
+}
+
+void ctrlc_handler(int signum, siginfo_t *info, void *ptr)
+{
+	kill(bm_pid, SIGKILL);
+	printf("Ending\n\n");
+
+	exit(EXIT_SUCCESS);
+}
diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/selftests/resctrl/resctrl.h
new file mode 100644
index 000000000000..1da8f871a01a
--- /dev/null
+++ b/tools/testing/selftests/resctrl/resctrl.h
@@ -0,0 +1,74 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#define _GNU_SOURCE
+#ifndef RESCTRL_H
+#define RESCTRL_H
+#include <stdio.h>
+#include <errno.h>
+#include <sched.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <string.h>
+#include <signal.h>
+#include <dirent.h>
+#include <stdbool.h>
+#include <sys/stat.h>
+#include <sys/ioctl.h>
+#include <sys/mount.h>
+#include <sys/types.h>
+#include <asm/unistd.h>
+#include <linux/perf_event.h>
+
+#define MB			(1024 * 1024)
+#define RESCTRL_PATH		"/sys/fs/resctrl"
+#define PHYS_ID_PATH		"/sys/devices/system/cpu/cpu"
+#define RESCTRL_MBM		"L3 monitoring detected"
+#define RESCTRL_MBA		"MB allocation detected"
+#define MAX_RESCTRL_FEATURES	2
+#define RM_SIG_FILE		"rm -rf sig"
+
+#define CHILD_EXIT(err_msg)			\
+	do {					\
+		perror(err_msg);		\
+		ctrlc_handler(0, NULL, NULL);	\
+	} while (0)
+
+#define PARENT_EXIT(err_msg)			\
+	do {					\
+		perror(err_msg);		\
+		kill(ppid, SIGKILL);		\
+		exit(EXIT_FAILURE);		\
+	} while (0)
+
+#define PERR_EXIT(err_msg)			\
+	do {					\
+		perror(err_msg);		\
+		exit(EXIT_FAILURE);		\
+	} while (0)
+
+#define FPRINTF_EXIT(err_msg)			\
+	do {					\
+		fprintf(stderr, err_msg);	\
+		exit(EXIT_FAILURE);		\
+	} while (0)
+
+pid_t bm_pid, ppid;
+int ben_count;
+
+void remount_resctrlfs(bool mum_resctrlfs);
+char get_sock_num(int cpu_no);
+void validate_bw_report_request(char *bw_report);
+void validate_resctrl_feature_request(char *resctrl_val);
+void taskset_benchmark(pid_t bm_pid, int cpu_no);
+void ctrlc_handler(int signum, siginfo_t *info, void *ptr);
+void run_benchmark(int signum, siginfo_t *info, void *ucontext);
+void create_mon_grp(const char *mongrp, const char *controlgroup);
+void create_con_mon_grp(const char *ctrlgrp, const char *controlgroup);
+void write_schemata(char *ctrlgrp, char *schemata, int cpu_no,
+		    char *resctrl_val);
+void write_bm_pid_to_resctrl(pid_t bm_pid, char *ctrlgrp, char *mongrp,
+			     char *resctrl_val);
+int perf_event_open(struct perf_event_attr *hw_event, pid_t pid, int cpu,
+		    int group_fd, unsigned long flags);
+int run_fill_buf(int span, int malloc_and_init_memory, int memflush, int op);
+
+#endif /* RESCTRL_H */
-- 
2.5.0

