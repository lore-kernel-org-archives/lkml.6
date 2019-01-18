Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 877E7C5AC81
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 18:28:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34BB52087E
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 18:28:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="wkI/+NVD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729087AbfARS1T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 13:27:19 -0500
Received: from mail-eopbgr680080.outbound.protection.outlook.com ([40.107.68.80]:40721
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728995AbfARS1N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 13:27:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6QCT8mQ/pG3581XHKWVxgCcrwsmSSzQ2CF14iZVhamk=;
 b=wkI/+NVD/stRCXVpJrzxm00mLjNhqWdBVIt0Phpbkq7F0Q9MPgunAdA3dJhiHKMugjqdgAhaeRK7odG5ZApCvXyELWu7wQf9M1JyD8YruVkAZyt5F8X7Nx7WAVfWfhfeQ7ve5gB0XOjbp/H6vtv7XVD7KKHTW/iljHWFikdWrCM=
Received: from DM5PR12MB2471.namprd12.prod.outlook.com (52.132.141.138) by
 DM5PR12MB1276.namprd12.prod.outlook.com (10.168.237.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1516.18; Fri, 18 Jan 2019 18:27:04 +0000
Received: from DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::9dfd:2b7b:1999:aff2]) by DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::9dfd:2b7b:1999:aff2%2]) with mapi id 15.20.1537.018; Fri, 18 Jan 2019
 18:27:04 +0000
From:   "Moger, Babu" <Babu.Moger@amd.com>
To:     "fenghua.yu@intel.com" <fenghua.yu@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "reinette.chatre@intel.com" <reinette.chatre@intel.com>,
        "Moger, Babu" <Babu.Moger@amd.com>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "xiaochen.shen@intel.com" <xiaochen.shen@intel.com>,
        "ravi.v.shankar@intel.com" <ravi.v.shankar@intel.com>,
        "sai.praneeth.prakhya@intel.com" <sai.praneeth.prakhya@intel.com>,
        "arshiya.hayatkhan.pathan@intel.com" 
        <arshiya.hayatkhan.pathan@intel.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
Subject: [PATCH v5 02/13] selftests/resctrl: Add basic resctrl file system
 operations and data
Thread-Topic: [PATCH v5 02/13] selftests/resctrl: Add basic resctrl file
 system operations and data
Thread-Index: AQHUr1tp4GFqh9pgNEm5+mAHGqQGYQ==
Date:   Fri, 18 Jan 2019 18:27:04 +0000
Message-ID: <20190118182646.16594-3-babu.moger@amd.com>
References: <20190118182646.16594-1-babu.moger@amd.com>
In-Reply-To: <20190118182646.16594-1-babu.moger@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN4PR0401CA0014.namprd04.prod.outlook.com
 (2603:10b6:803:21::24) To DM5PR12MB2471.namprd12.prod.outlook.com
 (2603:10b6:4:b5::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Babu.Moger@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [165.204.78.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR12MB1276;20:sSje81M1smUcVg/G8UekDdQ7x1kmSdAA7CHl7h3i3NgXM0uYFj6Eo3cWr5ufrQmRs9HoRsssracF7kQmqs/rtdY1I891m2g9p3w/13S3TtWbcRcHhIGhZrT6lARCr6juWGD3fth5BOZ3q9sz9548QrN25SJmqnPFLqj/DffrrKbHGh6yJk6ViYffnvR4q9GtWkicrhCiPMgcdvWttW+9wYlIZZU4pJHYy3TX+BaN+pl4HwZWzy2eqnlhn+hVRdoF
x-ms-office365-filtering-correlation-id: aacb0496-fea4-46fa-14e3-08d67d728b45
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600109)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DM5PR12MB1276;
x-ms-traffictypediagnostic: DM5PR12MB1276:
x-microsoft-antispam-prvs: <DM5PR12MB1276B8922EC2753EB1141EE0959C0@DM5PR12MB1276.namprd12.prod.outlook.com>
x-forefront-prvs: 0921D55E4F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(376002)(346002)(366004)(396003)(39860400002)(199004)(189003)(30864003)(14444005)(305945005)(3846002)(53936002)(6512007)(54906003)(110136005)(4326008)(99286004)(102836004)(6486002)(8676002)(25786009)(476003)(7736002)(316002)(6436002)(2616005)(446003)(11346002)(106356001)(486006)(386003)(68736007)(186003)(2906002)(50226002)(76176011)(81156014)(81166006)(52116002)(26005)(71200400001)(6506007)(97736004)(478600001)(8936002)(2501003)(71190400001)(72206003)(1076003)(256004)(66066001)(7416002)(2201001)(105586002)(36756003)(86362001)(6116002)(14454004)(5660300001)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB1276;H:DM5PR12MB2471.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 3V2I/vXhhsr1Llkvw//AxUMGAkfYxlWI2UcA63UW1odLZGHujzgwcqRW9MutbORAw691cO/gXPOe4kvB6Xd/f+gKvM8Q0JK/N0THsxr7/ulq5ioaZbvU7D7KbN0tMaqYeCrJnI1lYXbe96fL8dOkTwLv8/wB1RPl48pFYYtQ5LrlfUXxZUVpFKHL1K+0977GRAnr3ig/6UiZ2iXklapeaOA/fyS+Z+ASdXufuDCT12PJHC5vIeYuI7X/mUQ8WcrU+7wgVIRvjgH1VhuwvPPc39NUGaXPvFXDxCQ+q2XO+vaRYUrfAMNVY41utfJgN5OqErpUKSwX83kIzJRDBXAr7vHu39gntpuFAN94Erz+1uH8BPHKQGERjf3BKXZxehYY/9/gbeYMd2JK9emghEcjvwahfF51dUmLKfoQqsAwzJ8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aacb0496-fea4-46fa-14e3-08d67d728b45
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jan 2019 18:27:02.7526
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1276
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>

The basic resctrl file system operations and data are added for future
usage by resctrl selftest tool.

Signed-off-by: Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
Signed-off-by: Arshiya Hayatkhan Pathan <arshiya.hayatkhan.pathan@intel.com=
>
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Babu Moger <babu.moger@amd.com>
---
 tools/testing/selftests/resctrl/Makefile    |  10 +
 tools/testing/selftests/resctrl/resctrl.h   |  47 +++
 tools/testing/selftests/resctrl/resctrlfs.c | 457 ++++++++++++++++++++++++=
++++
 3 files changed, 514 insertions(+)
 create mode 100644 tools/testing/selftests/resctrl/Makefile
 create mode 100644 tools/testing/selftests/resctrl/resctrl.h
 create mode 100644 tools/testing/selftests/resctrl/resctrlfs.c

diff --git a/tools/testing/selftests/resctrl/Makefile b/tools/testing/selft=
ests/resctrl/Makefile
new file mode 100644
index 0000000..bd5c541
--- /dev/null
+++ b/tools/testing/selftests/resctrl/Makefile
@@ -0,0 +1,10 @@
+CC =3D gcc
+CFLAGS =3D -g -Wall
+
+*.o: *.c
+	$(CC) $(CFLAGS) -c *.c
+
+.PHONY: clean
+
+clean:
+	$(RM) *.o *~
diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/self=
tests/resctrl/resctrl.h
new file mode 100644
index 0000000..17fcb5e
--- /dev/null
+++ b/tools/testing/selftests/resctrl/resctrl.h
@@ -0,0 +1,47 @@
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
+#define RESCTRL_PATH		"/sys/fs/resctrl"
+#define PHYS_ID_PATH		"/sys/devices/system/cpu/cpu"
+
+#define PARENT_EXIT(err_msg)			\
+	do {					\
+		perror(err_msg);		\
+		kill(ppid, SIGKILL);		\
+		exit(EXIT_FAILURE);		\
+	} while (0)
+
+pid_t bm_pid, ppid;
+
+int remount_resctrlfs(bool mum_resctrlfs);
+int get_resource_id(int cpu_no, int *resource_id);
+int validate_bw_report_request(char *bw_report);
+int validate_resctrl_feature_request(char *resctrl_val);
+int taskset_benchmark(pid_t bm_pid, int cpu_no);
+void run_benchmark(int signum, siginfo_t *info, void *ucontext);
+int write_schemata(char *ctrlgrp, char *schemata, int cpu_no,
+		   char *resctrl_val);
+int write_bm_pid_to_resctrl(pid_t bm_pid, char *ctrlgrp, char *mongrp,
+			    char *resctrl_val);
+int perf_event_open(struct perf_event_attr *hw_event, pid_t pid, int cpu,
+		    int group_fd, unsigned long flags);
+int run_fill_buf(int span, int malloc_and_init_memory, int memflush, int o=
p);
+
+#endif /* RESCTRL_H */
diff --git a/tools/testing/selftests/resctrl/resctrlfs.c b/tools/testing/se=
lftests/resctrl/resctrlfs.c
new file mode 100644
index 0000000..3e5e88a
--- /dev/null
+++ b/tools/testing/selftests/resctrl/resctrlfs.c
@@ -0,0 +1,457 @@
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
+#define RESCTRL_MBM		"L3 monitoring detected"
+#define RESCTRL_MBA		"MB allocation detected"
+#define MAX_RESCTRL_FEATURES	2
+
+/*
+ * remount_resctrlfs - Remount resctrl FS at /sys/fs/resctrl
+ * @mum_resctrlfs:	Should the resctrl FS be remounted?
+ *
+ * If not mounted, mount it.
+ * If mounted and mum_resctrlfs then remount resctrl FS.
+ * If mounted and !mum_resctrlfs then noop
+ *
+ * Return: 0 on success, non-zero on failure
+ */
+int remount_resctrlfs(bool mum_resctrlfs)
+{
+	DIR *dp;
+	struct dirent *ep;
+	unsigned int count =3D 0;
+
+	/*
+	 * If kernel is built with CONFIG_RESCTRL, then /sys/fs/resctrl should
+	 * be present by default
+	 */
+	dp =3D opendir(RESCTRL_PATH);
+	if (dp) {
+		while ((ep =3D readdir(dp)) !=3D NULL)
+			count++;
+		closedir(dp);
+	} else {
+		perror("Unable to read /sys/fs/resctrl");
+
+		return -1;
+	}
+
+	/*
+	 * If resctrl FS has more than two entries, it means that resctrl FS has
+	 * already been mounted. The two default entries are "." and "..", these
+	 * are present even when resctrl FS is not mounted
+	 */
+	if (count > 2) {
+		if (mum_resctrlfs) {
+			if (umount(RESCTRL_PATH) !=3D 0) {
+				perror("Unable to umount resctrl");
+
+				return errno;
+			}
+			printf("Remount: done!\n");
+		} else {
+			printf("Mounted already. Not remounting!\n");
+
+			return 0;
+		}
+	}
+
+	if (mount("resctrl", RESCTRL_PATH, "resctrl", 0, NULL) !=3D 0) {
+		perror("Unable to mount resctrl FS at /sys/fs/resctrl");
+
+		return errno;
+	}
+
+	return 0;
+}
+
+int umount_resctrlfs(void)
+{
+	if (umount(RESCTRL_PATH)) {
+		perror("Unable to umount resctrl");
+
+		return errno;
+	}
+
+	return 0;
+}
+
+/*
+ * get_resource_id - Get socket number/l3 id for a specified CPU
+ * @cpu_no:	CPU number
+ * @resource_id: Socket number or l3_id
+ *
+ * Return: >=3D 0 on success, < 0 on failure.
+ */
+int get_resource_id(int cpu_no, int *resource_id)
+{
+	char phys_pkg_path[1024];
+	FILE *fp;
+
+	sprintf(phys_pkg_path, "%s%d/topology/physical_package_id",
+		PHYS_ID_PATH, cpu_no);
+	fp =3D fopen(phys_pkg_path, "r");
+	if (!fp) {
+		perror("Failed to open physical_package_id");
+
+		return -1;
+	}
+	if (fscanf(fp, "%d", resource_id) <=3D 0) {
+		perror("Could not get socket number or l3 id");
+		fclose(fp);
+
+		return -1;
+	}
+	fclose(fp);
+
+	return 0;
+}
+
+/*
+ * taskset_benchmark - Taskset PID (i.e. benchmark) to a specified cpu
+ * @bm_pid:	PID that should be binded
+ * @cpu_no:	CPU number at which the PID would be binded
+ *
+ * Return: 0 on success, non-zero on failure
+ */
+int taskset_benchmark(pid_t bm_pid, int cpu_no)
+{
+	cpu_set_t my_set;
+
+	CPU_ZERO(&my_set);
+	CPU_SET(cpu_no, &my_set);
+
+	if (sched_setaffinity(bm_pid, sizeof(cpu_set_t), &my_set)) {
+		perror("Unable to taskset benchmark");
+
+		return -1;
+	}
+
+	printf("Taskset benchmark: done!\n");
+
+	return 0;
+}
+
+/*
+ * run_benchmark - Run a specified benchmark or fill_buf (default benchmar=
k)
+ *		   in specified signal. Direct benchmark stdio to /dev/null.
+ * @signum:	signal number
+ * @info:	signal info
+ * @ucontext:	user context in signal handling
+ *
+ * Return: void
+ */
+void run_benchmark(int signum, siginfo_t *info, void *ucontext)
+{
+	int span, operation, ret;
+	char **benchmark_cmd;
+	FILE *fp;
+
+	benchmark_cmd =3D info->si_ptr;
+
+	/*
+	 * Direct stdio of child to /dev/null, so that only parent writes to
+	 * stdio (console)
+	 */
+	fp =3D freopen("/dev/null", "w", stdout);
+	if (!fp)
+		PARENT_EXIT("Unable to direct benchmark status to /dev/null");
+
+	if (strcmp(benchmark_cmd[0], "fill_buf") =3D=3D 0) {
+		/* Execute default fill_buf benchmark */
+		span =3D atoi(benchmark_cmd[1]);
+		operation =3D atoi(benchmark_cmd[4]);
+		if (run_fill_buf(span, 1, 1, operation))
+			fprintf(stderr, "Error in running fill buffer\n");
+	} else {
+		/* Execute specified benchmark */
+		ret =3D execvp(benchmark_cmd[0], benchmark_cmd);
+		if (ret)
+			perror("wrong\n");
+	}
+
+	fclose(stdout);
+	PARENT_EXIT("Unable to run specified benchmark");
+}
+
+/*
+ * create_grp - Create a group only if one doesn't exist
+ * @grp_name:	Name of the group
+ * @grp:	Full path and name of the group
+ * @parent_grp:	Full path and name of the parent group
+ *
+ * Return: 0 on success, non-zero on failure
+ */
+static int create_grp(const char *grp_name, char *grp, const char *parent_=
grp)
+{
+	int found_grp =3D 0;
+	struct dirent *ep;
+	DIR *dp;
+
+	/* Check if requested grp exists or not */
+	dp =3D opendir(parent_grp);
+	if (dp) {
+		while ((ep =3D readdir(dp)) !=3D NULL) {
+			if (strcmp(ep->d_name, grp_name) =3D=3D 0)
+				found_grp =3D 1;
+		}
+		closedir(dp);
+	} else {
+		perror("Unable to open resctrl for group");
+
+		return -1;
+	}
+
+	/* Requested grp doesn't exist, hence create it */
+	if (found_grp =3D=3D 0) {
+		if (mkdir(grp, 0) =3D=3D -1) {
+			perror("Unable to create group");
+
+			return -1;
+		}
+	}
+
+	return 0;
+}
+
+static int write_pid_to_tasks(char *tasks, pid_t pid)
+{
+	FILE *fp;
+
+	fp =3D fopen(tasks, "w");
+	if (!fp) {
+		perror("Failed to open tasks file");
+
+		return -1;
+	}
+	if (fprintf(fp, "%d\n", pid) < 0) {
+		perror("Failed to wr pid to tasks file");
+		fclose(fp);
+
+		return -1;
+
+	}
+	fclose(fp);
+
+	return 0;
+}
+
+/*
+ * write_bm_pid_to_resctrl - Write a PID (i.e. benchmark) to resctrl FS
+ * @bm_pid:		PID that should be written
+ * @ctrlgrp:		Name of the control monitor group (con_mon grp)
+ * @mongrp:		Name of the monitor group (mon grp)
+ * @resctrl_val:	Resctrl feature (Eg: mbm, mba.. etc)
+ *
+ * If a con_mon grp is requested, create it and write pid to it, otherwise
+ * write pid to root con_mon grp.
+ * If a mon grp is requested, create it and write pid to it, otherwise
+ * pid is not written, this means that pid is in con_mon grp and hence
+ * should consult con_mon grp's mon_data directory for results.
+ *
+ * Return: 0 on success, non-zero on failure
+ */
+int write_bm_pid_to_resctrl(pid_t bm_pid, char *ctrlgrp, char *mongrp,
+			    char *resctrl_val)
+{
+	char controlgroup[256], monitorgroup[256], monitorgroup_p[256];
+	char tasks[256];
+	int ret;
+
+	if (ctrlgrp)
+		sprintf(controlgroup, "%s/%s", RESCTRL_PATH, ctrlgrp);
+	else
+		sprintf(controlgroup, "%s", RESCTRL_PATH);
+
+	/* Create control and monitoring group and write pid into it */
+	ret =3D create_grp(ctrlgrp, controlgroup, RESCTRL_PATH);
+	if (ret)
+		return ret;
+	sprintf(tasks, "%s/tasks", controlgroup);
+	ret =3D write_pid_to_tasks(tasks, bm_pid);
+	if (ret)
+		return ret;
+
+	/* Create mon grp and write pid into it for "mbm" test */
+	if ((strcmp(resctrl_val, "mbm") =3D=3D 0)) {
+		if (mongrp) {
+			sprintf(monitorgroup_p, "%s/mon_groups", controlgroup);
+			sprintf(monitorgroup, "%s/%s", monitorgroup_p, mongrp);
+			ret =3D create_grp(mongrp, monitorgroup, monitorgroup_p);
+			if (ret)
+				return ret;
+
+			sprintf(tasks, "%s/mon_groups/%s/tasks",
+				controlgroup, mongrp);
+			ret =3D write_pid_to_tasks(tasks, bm_pid);
+			if (ret)
+				return ret;
+		}
+	}
+
+	printf("Write benchmark to resctrl FS: done!\n");
+
+	return 0;
+}
+
+/*
+ * write_schemata - Update schemata of a con_mon grp
+ * @ctrlgrp:		Name of the con_mon grp
+ * @schemata:		Schemata that should be updated to
+ * @cpu_no:		CPU number that the benchmark PID is binded to
+ * @resctrl_val:	Resctrl feature (Eg: mbm, mba.. etc)
+ *
+ * Update schemata of a con_mon grp *only* if requested resctrl feature is
+ * allocation type
+ *
+ * Return: 0 on success, non-zero on failure
+ */
+int write_schemata(char *ctrlgrp, char *schemata, int cpu_no, char *resctr=
l_val)
+{
+	char controlgroup[1024], schema[1024];
+	int resource_id;
+	FILE *fp;
+
+	if (strcmp(resctrl_val, "mba") =3D=3D 0) {
+		if (!schemata) {
+			printf("Schemata empty, so not updating\n");
+
+			return 0;
+		}
+		if (get_resource_id(cpu_no, &resource_id) < 0) {
+			perror("Failed to get resource id");
+			return -1;
+		}
+
+		if (ctrlgrp)
+			sprintf(controlgroup, "%s/%s/schemata", RESCTRL_PATH,
+				ctrlgrp);
+		else
+			sprintf(controlgroup, "%s/schemata", RESCTRL_PATH);
+		sprintf(schema, "%s%d%c%s", "MB:", resource_id, '=3D', schemata);
+
+		fp =3D fopen(controlgroup, "w");
+		if (!fp) {
+			perror("Failed to open control group");
+
+			return -1;
+		}
+
+		if (fprintf(fp, "%s\n", schema) < 0) {
+			perror("Failed to write schemata in control group");
+			fclose(fp);
+
+			return -1;
+		}
+		fclose(fp);
+
+		printf("Write schemata to resctrl FS: done!\n");
+	}
+
+	return 0;
+}
+
+/*
+ * validate_resctrl_feature_request - Check if requested feature is valid.
+ * @resctrl_val:	Requested feature
+ *
+ * Return: 0 on success, non-zero on failure
+ */
+int validate_resctrl_feature_request(char *resctrl_val)
+{
+	int resctrl_features_supported[MAX_RESCTRL_FEATURES] =3D {0, 0};
+	const char *resctrl_features_list[MAX_RESCTRL_FEATURES] =3D {
+			"mbm", "mba"};
+	int i, valid_resctrl_feature =3D -1;
+	char line[1024];
+	FILE *fp;
+
+	if (!resctrl_val) {
+		fprintf(stderr, "resctrl feature cannot be NULL\n");
+
+		return -1;
+	}
+
+	/* Is the resctrl feature request valid? */
+	for (i =3D 0; i < MAX_RESCTRL_FEATURES; i++) {
+		if (strcmp(resctrl_features_list[i], resctrl_val) =3D=3D 0)
+			valid_resctrl_feature =3D i;
+	}
+	if (valid_resctrl_feature =3D=3D -1) {
+		fprintf(stderr, "Not a valid resctrl feature request\n");
+
+		return -1;
+	}
+
+	/* Enumerate resctrl features supported by this platform */
+	if (system("dmesg > dmesg") !=3D 0) {
+		perror("Could not create custom dmesg file");
+
+		return -1;
+	}
+
+	fp =3D fopen("dmesg", "r");
+	if (!fp) {
+		perror("Could not read custom created dmesg");
+
+		return -1;
+	}
+
+	while (fgets(line, 1024, fp)) {
+		if ((strstr(line, RESCTRL_MBM)) !=3D NULL)
+			resctrl_features_supported[0] =3D 1;
+		if ((strstr(line, RESCTRL_MBA)) !=3D NULL)
+			resctrl_features_supported[1] =3D 1;
+	}
+	fclose(fp);
+
+	if (system("rm -rf dmesg") !=3D 0)
+		perror("Unable to remove 'dmesg' file");
+
+	/* Is the resctrl feature request supported? */
+	if (!resctrl_features_supported[valid_resctrl_feature]) {
+		fprintf(stderr, "resctrl feature not supported!");
+
+		return -1;
+	}
+
+	return 0;
+}
+
+int validate_bw_report_request(char *bw_report)
+{
+	if (strcmp(bw_report, "reads") =3D=3D 0)
+		return 0;
+	if (strcmp(bw_report, "writes") =3D=3D 0)
+		return 0;
+	if (strcmp(bw_report, "nt-writes") =3D=3D 0) {
+		strcpy(bw_report, "writes");
+		return 0;
+	}
+	if (strcmp(bw_report, "total") =3D=3D 0)
+		return 0;
+
+	fprintf(stderr, "Requested iMC B/W report type unavailable\n");
+
+	return -1;
+}
+
+int perf_event_open(struct perf_event_attr *hw_event, pid_t pid, int cpu,
+		    int group_fd, unsigned long flags)
+{
+	int ret;
+
+	ret =3D syscall(__NR_perf_event_open, hw_event, pid, cpu,
+		      group_fd, flags);
+	return ret;
+}
--=20
1.8.3.1

