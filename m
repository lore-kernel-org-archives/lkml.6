Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CB54C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:01:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D533A205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:01:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D533A205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727531AbeJQAwP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 20:52:15 -0400
Received: from mga17.intel.com ([192.55.52.151]:15627 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727159AbeJQAwP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 20:52:15 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Oct 2018 10:00:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,389,1534834800"; 
   d="scan'208";a="100736185"
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
Subject: [PATCH 2/7] selftests/resctrl: Read memory bandwidth from perf IMC counter and from resctrl file system
Date:   Tue, 16 Oct 2018 09:56:36 -0700
Message-Id: <1539709001-38018-3-git-send-email-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1539709001-38018-1-git-send-email-fenghua.yu@intel.com>
References: <1539709001-38018-1-git-send-email-fenghua.yu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>

Total memory bandwidth can be monitored from perf IMC counter and from
resctrl file system. Later the two will be compared to verify the total
memory bandwidth read from resctrl is correct.

Signed-off-by: Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
Signed-off-by: Arshiya Hayatkhan Pathan <arshiya.hayatkhan.pathan@intel.com>
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
---
 tools/testing/selftests/resctrl/resctrl_membw.c | 328 ++++++++++++++++++++++++
 tools/testing/selftests/resctrl/resctrl_membw.h |  49 ++++
 2 files changed, 377 insertions(+)
 create mode 100644 tools/testing/selftests/resctrl/resctrl_membw.c
 create mode 100644 tools/testing/selftests/resctrl/resctrl_membw.h

diff --git a/tools/testing/selftests/resctrl/resctrl_membw.c b/tools/testing/selftests/resctrl/resctrl_membw.c
new file mode 100644
index 000000000000..b0480834994c
--- /dev/null
+++ b/tools/testing/selftests/resctrl/resctrl_membw.c
@@ -0,0 +1,328 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Memory bandwidth monitoring library
+ *
+ * Copyright (C) 2018 Intel Corporation
+ *
+ * Authors:
+ *    Arshiya Hayatkhan Pathan <arshiya.hayatkhan.pathan@intel.com>
+ *    Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>,
+ *    Fenghua Yu <fenghua.yu@intel.com>
+ */
+#include "resctrl_membw.h"
+
+static struct imc_counter_config imc_counters_config[MAX_IMCs][2];
+static char mbm_total_path[1024];
+static int imcs;
+
+void membw_initialize_perf_event_attr(int i, int j)
+{
+	memset(&imc_counters_config[i][j].pe, 0,
+	       sizeof(struct perf_event_attr));
+	imc_counters_config[i][j].pe.type = imc_counters_config[i][j].type;
+	imc_counters_config[i][j].pe.size = sizeof(struct perf_event_attr);
+	imc_counters_config[i][j].pe.disabled = 1;
+	imc_counters_config[i][j].pe.inherit = 1;
+	imc_counters_config[i][j].pe.exclude_guest = 1;
+	imc_counters_config[i][j].pe.config =
+		imc_counters_config[i][j].umask << 8 |
+		imc_counters_config[i][j].event;
+	imc_counters_config[i][j].pe.sample_type = PERF_SAMPLE_IDENTIFIER;
+	imc_counters_config[i][j].pe.read_format =
+		PERF_FORMAT_TOTAL_TIME_ENABLED|PERF_FORMAT_TOTAL_TIME_RUNNING;
+}
+
+void open_perf_event(int i, int cpu_no, int j)
+{
+	imc_counters_config[i][j].fd =
+		perf_event_open(&imc_counters_config[i][j].pe, -1, cpu_no, -1,
+				PERF_FLAG_FD_CLOEXEC);
+
+	if (imc_counters_config[i][j].fd == -1) {
+		fprintf(stderr, "Error opening leader %llx\n",
+			imc_counters_config[i][j].pe.config);
+		ctrlc_handler(0, NULL, NULL);
+
+		exit(EXIT_FAILURE);
+	}
+}
+
+void membw_ioctl_perf_event_ioc_resest_enable(int i, int j)
+{
+	ioctl(imc_counters_config[i][j].fd, PERF_EVENT_IOC_RESET, 0);
+	ioctl(imc_counters_config[i][j].fd, PERF_EVENT_IOC_ENABLE, 0);
+}
+
+void membw_ioctl_perf_event_ioc_disable(int i, int j)
+{
+	ioctl(imc_counters_config[i][j].fd, PERF_EVENT_IOC_DISABLE, 0);
+}
+
+/*
+ * get_event_and_umask:	Parse config into event and umask
+ * @cas_count_cfg:	Config
+ * @count:		iMC number
+ * @op:			Operation (read/write)
+ */
+void get_event_and_umask(char *cas_count_cfg, int count, bool op)
+{
+	char **token = malloc(MAX_TOKENS * sizeof(char *));
+	int i = 0;
+
+	strcat(cas_count_cfg, ",");
+	token[0] = malloc(10 * sizeof(char));
+	token[0] = strtok(cas_count_cfg, "=,");
+
+	for (i = 1; i < MAX_TOKENS; i++) {
+		token[i] = malloc(10 * sizeof(char));
+		token[i] = strtok(NULL, "=,");
+		if (token[i] == NULL)
+			break;
+	}
+
+	for (i = 0; i < MAX_TOKENS; i++) {
+		if (token[i] == NULL)
+			break;
+		if (strcmp(token[i], "event") == 0) {
+			if (op == READ)
+				imc_counters_config[count][READ].event =
+				strtol(token[i+1], NULL, 16);
+			else
+				imc_counters_config[count][WRITE].event =
+				strtol(token[i+1], NULL, 16);
+		}
+		if (strcmp(token[i], "umask") == 0) {
+			if (op == READ)
+				imc_counters_config[count][READ].umask =
+				strtol(token[i+1], NULL, 16);
+			else
+				imc_counters_config[count][WRITE].umask =
+				strtol(token[i+1], NULL, 16);
+		}
+	}
+}
+
+/* Get type and config (read and write) of an iMC counter */
+void read_from_imc_dir(char *imc_dir, int count)
+{
+	char cas_count_cfg[1024], imc_counter_cfg[1024], imc_counter_type[1024];
+	FILE *fp;
+
+	/* Get type of iMC counter */
+	sprintf(imc_counter_type, "%s%s", imc_dir, "type");
+	fp = fopen(imc_counter_type, "r");
+	if (!fp || fscanf(fp, "%u",
+	    &imc_counters_config[count][READ].type) <= 0 || fclose(fp) == EOF)
+		CHILD_EXIT("Could not get imc type");
+
+	imc_counters_config[count][WRITE].type =
+				imc_counters_config[count][READ].type;
+
+	/* Get read config */
+	sprintf(imc_counter_cfg, "%s%s", imc_dir, READ_FILE_NAME);
+	fp = fopen(imc_counter_cfg, "r");
+	if (!fp || fscanf(fp, "%s", cas_count_cfg) <= 0 || fclose(fp) == EOF)
+		CHILD_EXIT("Could not get imc cas count read");
+
+	get_event_and_umask(cas_count_cfg, count, READ);
+
+	/* Get write config */
+	sprintf(imc_counter_cfg, "%s%s", imc_dir, WRITE_FILE_NAME);
+	fp = fopen(imc_counter_cfg, "r");
+	if (!fp || fscanf(fp, "%s", cas_count_cfg) <= 0 || fclose(fp) == EOF)
+		CHILD_EXIT("Could not get imc cas count write");
+
+	get_event_and_umask(cas_count_cfg, count, WRITE);
+}
+
+/*
+ * A system can have 'n' number of iMC (Integrated Memory Controller)
+ * counters, get that 'n'. For each iMC counter get it's type and config.
+ * Also, each counter has two configs, one for read and the other for write.
+ * A config again has two parts, event and umask.
+ * Enumerate all these details into an array of structures.
+ */
+static int num_of_imcs(void)
+{
+	char imc_dir[1024];
+	struct dirent *ep;
+	unsigned int count = 0;
+	DIR *dp;
+
+	dp = opendir(DYN_PMU_PATH);
+	if (dp != NULL) {
+		while ((ep = readdir(dp)) != NULL) {
+			if (strstr(ep->d_name, UNCORE_IMC) != NULL) {
+				sprintf(imc_dir, "%s/%s/", DYN_PMU_PATH,
+					ep->d_name);
+				read_from_imc_dir(imc_dir, count);
+				count++;
+			}
+		}
+		closedir(dp);
+		if (count == 0)
+			CHILD_EXIT("Unable find iMC counters!\n");
+	} else {
+		CHILD_EXIT("Unable to open PMU directory!\n");
+	}
+
+	return count;
+}
+
+void initialize_mem_bw_imc(void)
+{
+	int imc;
+
+	imcs = num_of_imcs();
+
+	/* Initialize perf_event_attr structures for all iMC's */
+	for (imc = 0; imc < imcs; imc++) {
+		for (int j = 0; j < 2; j++)
+			membw_initialize_perf_event_attr(imc, j);
+	}
+}
+
+/*
+ * get_mem_bw_imc:	Memory band width as reported by iMC counters
+ * @cpu_no:		CPU number that the benchmark PID is binded to
+ * @bw_report:		Bandwidth report type (reads, writes)
+ *
+ * Memory B/W utilized by a process on a socket can be calculated using
+ * iMC counters. Perf events are used to read these counters.
+ */
+float get_mem_bw_imc(int cpu_no, char *bw_report)
+{
+	float reads, writes, of_mul_read, of_mul_write;
+	int imc;
+
+	/* Start all iMC counters to log values (both read and write) */
+	reads = 0, writes = 0, of_mul_read = 1, of_mul_write = 1;
+	for (imc = 0; imc < imcs; imc++) {
+		for (int j = 0; j < 2; j++)
+			open_perf_event(imc, cpu_no, j);
+		for (int j = 0; j < 2; j++)
+			membw_ioctl_perf_event_ioc_resest_enable(imc, j);
+	}
+
+	sleep(1);
+
+	/* Stop counters after a second to get results (both read and write) */
+	for (imc = 0; imc < imcs; imc++) {
+		for (int j = 0; j < 2; j++)
+			membw_ioctl_perf_event_ioc_disable(imc, j);
+	}
+
+	/*
+	 * Get results which are stored in struct type imc_counter_config
+	 * Take over flow into consideration before calculating total b/w
+	 */
+	for (imc = 0; imc < imcs; imc++) {
+		struct imc_counter_config *r =
+			&imc_counters_config[imc][READ];
+		struct imc_counter_config *w =
+			&imc_counters_config[imc][WRITE];
+
+		if (read(r->fd, &r->return_value,
+			 sizeof(struct membw_read_format)) == -1)
+			CHILD_EXIT("Couldn't get read b/w through iMC");
+
+		if (read(w->fd, &w->return_value,
+			 sizeof(struct membw_read_format)) == -1)
+			CHILD_EXIT("Couldn't get write bw through iMC");
+
+		__u64 r_time_enabled = r->return_value.time_enabled;
+		__u64 r_time_running = r->return_value.time_running;
+
+		if (r_time_enabled != r_time_running)
+			of_mul_read = (float)r_time_enabled /
+					(float)r_time_running;
+
+		__u64 w_time_enabled = w->return_value.time_enabled;
+		__u64 w_time_running = w->return_value.time_running;
+
+		if (w_time_enabled != w_time_running)
+			of_mul_write = (float) w_time_enabled /
+					(float) w_time_running;
+		reads += r->return_value.value * of_mul_read * SCALE;
+		writes += w->return_value.value * of_mul_write * SCALE;
+	}
+
+	for (imc = 0; imc < imcs; imc++) {
+		close(imc_counters_config[imc][READ].fd);
+		close(imc_counters_config[imc][WRITE].fd);
+	}
+
+	if (strcmp(bw_report, "reads") == 0)
+		return reads;
+
+	if (strcmp(bw_report, "writes") == 0)
+		return writes;
+
+	return (reads + writes);
+}
+
+void set_mbm_path(const char *ctrlgrp, const char *mongrp, char sock_num)
+{
+	if (ctrlgrp && mongrp)
+		sprintf(mbm_total_path, CON_MON_MBM_LOCAL_BYTES_PATH,
+			RESCTRL_PATH, ctrlgrp, mongrp, sock_num);
+	else if (!ctrlgrp && mongrp)
+		sprintf(mbm_total_path, MON_MBM_LOCAL_BYTES_PATH, RESCTRL_PATH,
+			mongrp, sock_num);
+	else if (ctrlgrp && !mongrp)
+		sprintf(mbm_total_path, CON_MBM_LOCAL_BYTES_PATH, RESCTRL_PATH,
+			ctrlgrp, sock_num);
+	else if (!ctrlgrp && !mongrp)
+		sprintf(mbm_total_path, MBM_LOCAL_BYTES_PATH, RESCTRL_PATH,
+			sock_num);
+
+}
+
+/*
+ * initialize_mem_bw_resctrl:	Appropriately populate "mbm_total_path"
+ * @ctrlgrp:			Name of the control monitor group (con_mon grp)
+ * @mongrp:			Name of the monitor group (mon grp)
+ * @cpu_no:			CPU number that the benchmark PID is binded to
+ * @resctrl_val:		Resctrl feature (Eg: mbm, mba.. etc)
+ */
+void initialize_mem_bw_resctrl(const char *ctrlgrp, const char *mongrp,
+			       int cpu_no, char *resctrl_val)
+{
+	char sock_num;
+
+	sock_num = get_sock_num(cpu_no);
+
+	if (strcmp(resctrl_val, "mbm") == 0)
+		set_mbm_path(ctrlgrp, mongrp, sock_num);
+
+	if ((strcmp(resctrl_val, "mba") == 0)) {
+		if (ctrlgrp)
+			sprintf(mbm_total_path, CON_MBM_LOCAL_BYTES_PATH,
+				RESCTRL_PATH, ctrlgrp, sock_num);
+		else
+			sprintf(mbm_total_path, MBM_LOCAL_BYTES_PATH,
+				RESCTRL_PATH, sock_num);
+	}
+}
+
+/*
+ * Get MBM Local bytes as reported by resctrl FS
+ * For MBM,
+ * 1. If con_mon grp and mon grp are given, then read from con_mon grp's mon grp
+ * 2. If only con_mon grp is given, then read from con_mon grp
+ * 3. If both are not given, then read from root con_mon grp
+ * For MBA,
+ * 1. If con_mon grp is given, then read from it
+ * 2. If con_mon grp is not given, then read from root con_mon grp
+ */
+unsigned long long get_mem_bw_resctrl(void)
+{
+	unsigned long long mbm_total = 0;
+	FILE *fp;
+
+	fp = fopen(mbm_total_path, "r");
+	if (!fp || fscanf(fp, "%llu", &mbm_total) <= 0 || fclose(fp) == EOF)
+		CHILD_EXIT("Could not get mbm local bytes");
+
+	return mbm_total;
+}
diff --git a/tools/testing/selftests/resctrl/resctrl_membw.h b/tools/testing/selftests/resctrl/resctrl_membw.h
new file mode 100644
index 000000000000..87ec585b8dd4
--- /dev/null
+++ b/tools/testing/selftests/resctrl/resctrl_membw.h
@@ -0,0 +1,49 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef RESCTRL_MEMBW_H
+#define RESCTRL_MEMBW_H
+#include "resctrl.h"
+
+#define UNCORE_IMC		"uncore_imc"
+#define READ_FILE_NAME		"events/cas_count_read"
+#define WRITE_FILE_NAME		"events/cas_count_write"
+#define DYN_PMU_PATH		"/sys/bus/event_source/devices"
+#define SCALE			0.00006103515625
+#define MAX_IMCs		20
+#define MAX_TOKENS		5
+#define READ			0
+#define WRITE			1
+#define CON_MON_MBM_LOCAL_BYTES_PATH				\
+	"%s/%s/mon_groups/%s/mon_data/mon_L3_0%c/mbm_local_bytes"
+
+#define CON_MBM_LOCAL_BYTES_PATH		\
+	"%s/%s/mon_data/mon_L3_0%c/mbm_local_bytes"
+
+#define MON_MBM_LOCAL_BYTES_PATH		\
+	"%s/mon_groups/%s/mon_data/mon_L3_0%c/mbm_local_bytes"
+
+#define MBM_LOCAL_BYTES_PATH			\
+	"%s/mon_data/mon_L3_0%c/mbm_local_bytes"
+
+
+struct membw_read_format {
+	__u64 value;         /* The value of the event */
+	__u64 time_enabled;  /* if PERF_FORMAT_TOTAL_TIME_ENABLED */
+	__u64 time_running;  /* if PERF_FORMAT_TOTAL_TIME_RUNNING */
+	__u64 id;            /* if PERF_FORMAT_ID */
+};
+
+struct imc_counter_config {
+	__u32 type;
+	__u64 event;
+	__u64 umask;
+	struct perf_event_attr pe;
+	struct membw_read_format return_value;
+	int fd;
+};
+
+void initialize_mem_bw_resctrl(const char *ctrlgrp, const char *mongrp,
+			       int cpu_no, char *resctrl_val);
+float get_mem_bw_imc(int cpu_no, char *bw_report);
+unsigned long long get_mem_bw_resctrl(void);
+void initialize_mem_bw_imc(void);
+#endif /* RESCTRL_MEMBW_H */
-- 
2.5.0

