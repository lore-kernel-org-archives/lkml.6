Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70A29C5AC81
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 18:27:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DAC620883
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 18:27:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="lCO6i0Qo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729106AbfARS1U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 13:27:20 -0500
Received: from mail-eopbgr700066.outbound.protection.outlook.com ([40.107.70.66]:43360
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728991AbfARS1N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 13:27:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a2CewgVRt31uTCyzt0iqEgteSJRr/+OYm30JAQlpkz4=;
 b=lCO6i0Qojgw9EcBPkbCJdGDka4zBl8YqYo/ZWsHQQlWm3Vffn6ncPM2J6jbrGs+618t5+j3nfdxCkq5h4VhqbSmcs8JwG0dwAiPChXc5PdiMej+7KYDUYCNQl/52r/Zneu3qjeQVUvXK3wuDIlQdRbUWTjSx3J3JHYrtqpS3pLY=
Received: from DM5PR12MB2471.namprd12.prod.outlook.com (52.132.141.138) by
 DM5PR12MB2376.namprd12.prod.outlook.com (52.132.141.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1537.24; Fri, 18 Jan 2019 18:27:07 +0000
Received: from DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::9dfd:2b7b:1999:aff2]) by DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::9dfd:2b7b:1999:aff2%2]) with mapi id 15.20.1537.018; Fri, 18 Jan 2019
 18:27:07 +0000
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
Subject: [PATCH v5 04/13] selftests/resctrl: Add callback to start a benchmark
Thread-Topic: [PATCH v5 04/13] selftests/resctrl: Add callback to start a
 benchmark
Thread-Index: AQHUr1tq4A0jWUdbA0ulzxlnni3GvQ==
Date:   Fri, 18 Jan 2019 18:27:06 +0000
Message-ID: <20190118182646.16594-5-babu.moger@amd.com>
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
x-microsoft-exchange-diagnostics: 1;DM5PR12MB2376;20:1FBAvpprXZPf3/AOvj8hsq7+w5hxoqbDd3P4DmZz8QoJHFzrC3Mdm9sC0AGSVVkX22LvIQaGqsBwYTrA48cyd/6+x1/EWjFZkn7UwjHp5Y4WFJBjnMqpIchA8eblQi9TpX2LVAA0vdCUaGgU09IHwX7bOcUHbKDlEyIRfI43o2MpFDsYrLQjIrSLS46kKVkWT2Nw5tXI2ch0J/gMwzjwSSdFWKiFjyfQid0Oj+Mg7iTkwdN3YLiakhXuoiFdqlz7
x-ms-office365-filtering-correlation-id: ab6a8584-5eb7-4195-2a0c-08d67d728cfe
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600109)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DM5PR12MB2376;
x-ms-traffictypediagnostic: DM5PR12MB2376:
x-microsoft-antispam-prvs: <DM5PR12MB2376D31624B1AAED82D0F839959C0@DM5PR12MB2376.namprd12.prod.outlook.com>
x-forefront-prvs: 0921D55E4F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(39860400002)(136003)(396003)(346002)(366004)(189003)(199004)(1076003)(25786009)(26005)(52116002)(4326008)(186003)(102836004)(2201001)(6506007)(76176011)(72206003)(86362001)(386003)(3846002)(71200400001)(71190400001)(256004)(14444005)(6486002)(54906003)(99286004)(305945005)(110136005)(6436002)(7736002)(486006)(6512007)(316002)(2616005)(446003)(2906002)(97736004)(476003)(11346002)(478600001)(7416002)(105586002)(53946003)(53936002)(106356001)(81166006)(8936002)(8676002)(5660300001)(36756003)(30864003)(68736007)(66066001)(6116002)(50226002)(14454004)(2501003)(81156014)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB2376;H:DM5PR12MB2471.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: BxwN6dfVoZ2y8skQMzd2DU4EUiORuxIp41znHCMGo/qkjQyHUQDCVJ9TOEHq066xioFCGhWuwIGKvnL/0+ea8ctuRPGoh28F1iF94a2H5D+ScbQ5Fju3QsMA95k37BYwu0DtKVvzggU+iIHACw5kc7qz2DhzMyZBMf3aFyPNS86AZFQGBKv0+v/mh7wKYECVjeNUJKZYVAU7TdP6aN+GS4C0WB07t53NLXoaHCpFjOSrhJPVbfZPl1IQQyDOp0OJlwnv0osd3ap2hM5gV+KFGXLd/gxejbQxMK7qR/8qlwMqmwVAHJffbLKUM+HuAVoLV2Jb9NLLFaICobeltgg0z7LQNuev6E8ilkwxvcvv0NGT50OkyPRlbdzEHPYk4oMg4Zdc/4P6aIQXR1qf1wPnxG5PA1fA0jO4leam5QYl1qU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab6a8584-5eb7-4195-2a0c-08d67d728cfe
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jan 2019 18:27:05.6745
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2376
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>

The callback starts a child process and puts the child pid in created
resctrl group with specified memory bandwidth in schemata. The child
starts running benchmark.

Signed-off-by: Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
Signed-off-by: Arshiya Hayatkhan Pathan <arshiya.hayatkhan.pathan@intel.com=
>
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Babu Moger <babu.moger@amd.com>
---
 tools/testing/selftests/resctrl/resctrl.h     |  27 ++
 tools/testing/selftests/resctrl/resctrl_val.c | 586 ++++++++++++++++++++++=
++++
 2 files changed, 613 insertions(+)

diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/self=
tests/resctrl/resctrl.h
index 17fcb5e..f30a2dc 100644
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
@@ -28,10 +29,35 @@
 		exit(EXIT_FAILURE);		\
 	} while (0)
=20
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
=20
 int remount_resctrlfs(bool mum_resctrlfs);
 int get_resource_id(int cpu_no, int *resource_id);
+int umount_resctrlfs(void);
 int validate_bw_report_request(char *bw_report);
 int validate_resctrl_feature_request(char *resctrl_val);
 int taskset_benchmark(pid_t bm_pid, int cpu_no);
@@ -43,5 +69,6 @@ int write_bm_pid_to_resctrl(pid_t bm_pid, char *ctrlgrp, =
char *mongrp,
 int perf_event_open(struct perf_event_attr *hw_event, pid_t pid, int cpu,
 		    int group_fd, unsigned long flags);
 int run_fill_buf(int span, int malloc_and_init_memory, int memflush, int o=
p);
+int membw_val(char **benchmark_cmd, struct resctrl_val_param *param);
=20
 #endif /* RESCTRL_H */
diff --git a/tools/testing/selftests/resctrl/resctrl_val.c b/tools/testing/=
selftests/resctrl/resctrl_val.c
index 12301ac..8b32595 100644
--- a/tools/testing/selftests/resctrl/resctrl_val.c
+++ b/tools/testing/selftests/resctrl/resctrl_val.c
@@ -11,6 +11,7 @@
  */
 #include "resctrl.h"
=20
+#define MB			(1024 * 1024)
 #define UNCORE_IMC		"uncore_imc"
 #define READ_FILE_NAME		"events/cas_count_read"
 #define WRITE_FILE_NAME		"events/cas_count_write"
@@ -47,6 +48,9 @@ struct imc_counter_config {
 	struct membw_read_format return_value;
 	int fd;
 };
+
+static char mbm_total_path[1024];
+static int imcs;
 static struct imc_counter_config imc_counters_config[MAX_IMCS][2];
=20
 void membw_initialize_perf_event_attr(int i, int j)
@@ -116,3 +120,585 @@ void get_event_and_umask(char *cas_count_cfg, int cou=
nt, bool op)
 	}
 }
=20
+static int open_perf_event(int i, int cpu_no, int j)
+{
+	imc_counters_config[i][j].fd =3D
+		perf_event_open(&imc_counters_config[i][j].pe, -1, cpu_no, -1,
+				PERF_FLAG_FD_CLOEXEC);
+
+	if (imc_counters_config[i][j].fd =3D=3D -1) {
+		fprintf(stderr, "Error opening leader %llx\n",
+			imc_counters_config[i][j].pe.config);
+
+		return -1;
+	}
+
+	return 0;
+}
+
+/* Get type and config (read and write) of an iMC counter */
+static int read_from_imc_dir(char *imc_dir, int count)
+{
+	char cas_count_cfg[1024], imc_counter_cfg[1024], imc_counter_type[1024];
+	FILE *fp;
+
+	/* Get type of iMC counter */
+	sprintf(imc_counter_type, "%s%s", imc_dir, "type");
+	fp =3D fopen(imc_counter_type, "r");
+	if (!fp) {
+		perror("Failed to open imc counter type file");
+
+		return -1;
+	}
+	if (fscanf(fp, "%u", &imc_counters_config[count][READ].type) <=3D 0) {
+		perror("Could not get imc type");
+		fclose(fp);
+
+		return -1;
+	}
+	fclose(fp);
+
+	imc_counters_config[count][WRITE].type =3D
+				imc_counters_config[count][READ].type;
+
+	/* Get read config */
+	sprintf(imc_counter_cfg, "%s%s", imc_dir, READ_FILE_NAME);
+	fp =3D fopen(imc_counter_cfg, "r");
+	if (!fp) {
+		perror("Failed to open imc config file");
+
+		return -1;
+	}
+	if (fscanf(fp, "%s", cas_count_cfg) <=3D 0) {
+		perror("Could not get imc cas count read");
+		fclose(fp);
+
+		return -1;
+	}
+	fclose(fp);
+
+	get_event_and_umask(cas_count_cfg, count, READ);
+
+	/* Get write config */
+	sprintf(imc_counter_cfg, "%s%s", imc_dir, WRITE_FILE_NAME);
+	fp =3D fopen(imc_counter_cfg, "r");
+	if (!fp) {
+		perror("Failed to open imc config file");
+
+		return -1;
+	}
+	if  (fscanf(fp, "%s", cas_count_cfg) <=3D 0) {
+		perror("Could not get imc cas count write");
+		fclose(fp);
+
+		return -1;
+	}
+	fclose(fp);
+
+	get_event_and_umask(cas_count_cfg, count, WRITE);
+
+	return 0;
+}
+
+/*
+ * A system can have 'n' number of iMC (Integrated Memory Controller)
+ * counters, get that 'n'. For each iMC counter get it's type and config.
+ * Also, each counter has two configs, one for read and the other for writ=
e.
+ * A config again has two parts, event and umask.
+ * Enumerate all these details into an array of structures.
+ *
+ * Return: >=3D 0 on success. < 0 on failure.
+ */
+static int num_of_imcs(void)
+{
+	unsigned int count =3D 0;
+	char imc_dir[1024];
+	struct dirent *ep;
+	int ret;
+	DIR *dp;
+
+	dp =3D opendir(DYN_PMU_PATH);
+	if (dp) {
+		while ((ep =3D readdir(dp))) {
+			if (strstr(ep->d_name, UNCORE_IMC)) {
+				sprintf(imc_dir, "%s/%s/", DYN_PMU_PATH,
+					ep->d_name);
+				ret =3D read_from_imc_dir(imc_dir, count);
+				if (ret) {
+					closedir(dp);
+
+					return ret;
+				}
+				count++;
+			}
+		}
+		closedir(dp);
+		if (count =3D=3D 0) {
+			perror("Unable find iMC counters!\n");
+
+			return -1;
+		}
+	} else {
+		perror("Unable to open PMU directory!\n");
+
+		return -1;
+	}
+
+	return count;
+}
+
+static int initialize_mem_bw_imc(void)
+{
+	int imc, j;
+
+	imcs =3D num_of_imcs();
+	if (imcs <=3D 0)
+		return imcs;
+
+	/* Initialize perf_event_attr structures for all iMC's */
+	for (imc =3D 0; imc < imcs; imc++) {
+		for (j =3D 0; j < 2; j++)
+			membw_initialize_perf_event_attr(imc, j);
+	}
+
+	return 0;
+}
+
+/*
+ * get_mem_bw_imc:	Memory band width as reported by iMC counters
+ * @cpu_no:		CPU number that the benchmark PID is binded to
+ * @bw_report:		Bandwidth report type (reads, writes)
+ *
+ * Memory B/W utilized by a process on a socket can be calculated using
+ * iMC counters. Perf events are used to read these counters.
+ *
+ * Return: >=3D 0 on success. < 0 on failure.
+ */
+static float get_mem_bw_imc(int cpu_no, char *bw_report)
+{
+	float reads, writes, of_mul_read, of_mul_write;
+	int imc, j, ret;
+
+	/* Start all iMC counters to log values (both read and write) */
+	reads =3D 0, writes =3D 0, of_mul_read =3D 1, of_mul_write =3D 1;
+	for (imc =3D 0; imc < imcs; imc++) {
+		for (j =3D 0; j < 2; j++) {
+			ret =3D open_perf_event(imc, cpu_no, j);
+			if (ret)
+				return -1;
+		}
+		for (j =3D 0; j < 2; j++)
+			membw_ioctl_perf_event_ioc_reset_enable(imc, j);
+	}
+
+	sleep(1);
+
+	/* Stop counters after a second to get results (both read and write) */
+	for (imc =3D 0; imc < imcs; imc++) {
+		for (j =3D 0; j < 2; j++)
+			membw_ioctl_perf_event_ioc_disable(imc, j);
+	}
+
+	/*
+	 * Get results which are stored in struct type imc_counter_config
+	 * Take over flow into consideration before calculating total b/w
+	 */
+	for (imc =3D 0; imc < imcs; imc++) {
+		struct imc_counter_config *r =3D
+			&imc_counters_config[imc][READ];
+		struct imc_counter_config *w =3D
+			&imc_counters_config[imc][WRITE];
+
+		if (read(r->fd, &r->return_value,
+			 sizeof(struct membw_read_format)) =3D=3D -1) {
+			perror("Couldn't get read b/w through iMC");
+
+			return -1;
+		}
+
+		if (read(w->fd, &w->return_value,
+			 sizeof(struct membw_read_format)) =3D=3D -1) {
+			perror("Couldn't get write bw through iMC");
+
+			return -1;
+		}
+
+		__u64 r_time_enabled =3D r->return_value.time_enabled;
+		__u64 r_time_running =3D r->return_value.time_running;
+
+		if (r_time_enabled !=3D r_time_running)
+			of_mul_read =3D (float)r_time_enabled /
+					(float)r_time_running;
+
+		__u64 w_time_enabled =3D w->return_value.time_enabled;
+		__u64 w_time_running =3D w->return_value.time_running;
+
+		if (w_time_enabled !=3D w_time_running)
+			of_mul_write =3D (float)w_time_enabled /
+					(float)w_time_running;
+		reads +=3D r->return_value.value * of_mul_read * SCALE;
+		writes +=3D w->return_value.value * of_mul_write * SCALE;
+	}
+
+	for (imc =3D 0; imc < imcs; imc++) {
+		close(imc_counters_config[imc][READ].fd);
+		close(imc_counters_config[imc][WRITE].fd);
+	}
+
+	if (strcmp(bw_report, "reads") =3D=3D 0)
+		return reads;
+
+	if (strcmp(bw_report, "writes") =3D=3D 0)
+		return writes;
+
+	return (reads + writes);
+}
+
+void set_mbm_path(const char *ctrlgrp, const char *mongrp, int resource_id=
)
+{
+	if (ctrlgrp && mongrp)
+		sprintf(mbm_total_path, CON_MON_MBM_LOCAL_BYTES_PATH,
+			RESCTRL_PATH, ctrlgrp, mongrp, resource_id);
+	else if (!ctrlgrp && mongrp)
+		sprintf(mbm_total_path, MON_MBM_LOCAL_BYTES_PATH, RESCTRL_PATH,
+			mongrp, resource_id);
+	else if (ctrlgrp && !mongrp)
+		sprintf(mbm_total_path, CON_MBM_LOCAL_BYTES_PATH, RESCTRL_PATH,
+			ctrlgrp, resource_id);
+	else if (!ctrlgrp && !mongrp)
+		sprintf(mbm_total_path, MBM_LOCAL_BYTES_PATH, RESCTRL_PATH,
+			resource_id);
+}
+
+/*
+ * initialize_mem_bw_resctrl:	Appropriately populate "mbm_total_path"
+ * @ctrlgrp:			Name of the control monitor group (con_mon grp)
+ * @mongrp:			Name of the monitor group (mon grp)
+ * @cpu_no:			CPU number that the benchmark PID is binded to
+ * @resctrl_val:		Resctrl feature (Eg: mbm, mba.. etc)
+ */
+static void initialize_mem_bw_resctrl(const char *ctrlgrp, const char *mon=
grp,
+				      int cpu_no, char *resctrl_val)
+{
+	int resource_id;
+
+	if (get_resource_id(cpu_no, &resource_id) < 0) {
+		perror("Could not get resource_id");
+		return;
+	}
+
+	if (strcmp(resctrl_val, "mbm") =3D=3D 0)
+		set_mbm_path(ctrlgrp, mongrp, resource_id);
+
+	if ((strcmp(resctrl_val, "mba") =3D=3D 0)) {
+		if (ctrlgrp)
+			sprintf(mbm_total_path, CON_MBM_LOCAL_BYTES_PATH,
+				RESCTRL_PATH, ctrlgrp, resource_id);
+		else
+			sprintf(mbm_total_path, MBM_LOCAL_BYTES_PATH,
+				RESCTRL_PATH, resource_id);
+	}
+}
+
+/*
+ * Get MBM Local bytes as reported by resctrl FS
+ * For MBM,
+ * 1. If con_mon grp and mon grp are given, then read from con_mon grp's m=
on grp
+ * 2. If only con_mon grp is given, then read from con_mon grp
+ * 3. If both are not given, then read from root con_mon grp
+ * For MBA,
+ * 1. If con_mon grp is given, then read from it
+ * 2. If con_mon grp is not given, then read from root con_mon grp
+ */
+static unsigned long get_mem_bw_resctrl(void)
+{
+	unsigned long mbm_total =3D 0;
+	FILE *fp;
+
+	fp =3D fopen(mbm_total_path, "r");
+	if (!fp) {
+		perror("Failed to open total bw file");
+
+		return -1;
+	}
+	if (fscanf(fp, "%lu", &mbm_total) <=3D 0) {
+		perror("Could not get mbm local bytes");
+		fclose(fp);
+
+		return -1;
+	}
+	fclose(fp);
+
+	return mbm_total;
+}
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
+	unsigned long diff =3D labs(bw_imc - bw_resc);
+	FILE *fp;
+
+	if (strcmp(filename, "stdio") =3D=3D 0 || strcmp(filename, "stderr") =3D=
=3D 0) {
+		printf("Pid: %d \t Mem_BW_iMC: %f \t ", bm_pid, bw_imc);
+		printf("Mem_BW_resc: %lu \t Difference: %lu\n", bw_resc, diff);
+	} else {
+		fp =3D fopen(filename, "a");
+		if (!fp) {
+			perror("Cannot open results file");
+
+			return errno;
+		}
+		if (fprintf(fp, "Pid: %d \t Mem_BW_iMC: %f \t Mem_BW_resc: %lu \t Differ=
ence: %lu\n",
+			    bm_pid, bw_imc, bw_resc, diff) <=3D 0) {
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
+measure_vals(struct resctrl_val_param *param, unsigned long *bw_resc_start=
)
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
+	bw_imc =3D get_mem_bw_imc(param->cpu_no, param->bw_report);
+	if (bw_imc <=3D 0)
+		return bw_imc;
+
+	bw_resc_end =3D get_mem_bw_resctrl();
+	if (bw_resc_end <=3D 0)
+		return bw_resc_end;
+
+	bw_resc =3D (bw_resc_end - *bw_resc_start) / MB;
+	ret =3D print_results_bw(param->filename, bm_pid, bw_imc, bw_resc);
+	if (ret)
+		return ret;
+
+	*bw_resc_start =3D bw_resc_end;
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
+	int ret =3D 0, pipefd[2], pipe_message =3D 0;
+	char *resctrl_val =3D param->resctrl_val;
+	unsigned long bw_resc_start =3D 0;
+	struct sigaction sigact;
+	union sigval value;
+	FILE *fp;
+
+	if (strcmp(param->filename, "") =3D=3D 0)
+		sprintf(param->filename, "stdio");
+
+	if (strcmp(param->bw_report, "") =3D=3D 0)
+		param->bw_report =3D "total";
+
+	ret =3D validate_resctrl_feature_request(resctrl_val);
+	if (ret)
+		return ret;
+
+	if ((strcmp(resctrl_val, "mba")) =3D=3D 0 ||
+	    (strcmp(resctrl_val, "mbm")) =3D=3D 0) {
+		ret =3D validate_bw_report_request(param->bw_report);
+		if (ret)
+			return ret;
+	}
+
+	ret =3D remount_resctrlfs(param->mum_resctrlfs);
+	if (ret)
+		return ret;
+
+	/*
+	 * If benchmark wasn't successfully started by child, then child should
+	 * kill parent, so save parent's pid
+	 */
+	ppid =3D getpid();
+
+	/* File based synchronization between parent and child */
+	fp =3D fopen("sig", "w");
+	if (!fp) {
+		perror("Failed to open sig file");
+
+		return -1;
+	}
+	if (fprintf(fp, "%d\n", 0) <=3D 0) {
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
+	bm_pid =3D fork();
+	if (bm_pid =3D=3D -1) {
+		perror("Unable to fork");
+
+		return -1;
+	}
+
+	if (bm_pid =3D=3D 0) {
+		/*
+		 * Mask all signals except SIGUSR1, parent uses SIGUSR1 to
+		 * start benchmark
+		 */
+		sigfillset(&sigact.sa_mask);
+		sigdelset(&sigact.sa_mask, SIGUSR1);
+
+		sigact.sa_sigaction =3D run_benchmark;
+		sigact.sa_flags =3D SA_SIGINFO;
+
+		/* Register for "SIGUSR1" signal from parent */
+		if (sigaction(SIGUSR1, &sigact, NULL))
+			PARENT_EXIT("Can't register child for signal");
+
+		/* Tell parent that child is ready */
+		close(pipefd[0]);
+		pipe_message =3D 1;
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
+	sigact.sa_sigaction =3D ctrlc_handler;
+	sigemptyset(&sigact.sa_mask);
+	sigact.sa_flags =3D SA_SIGINFO;
+	if (sigaction(SIGINT, &sigact, NULL) ||
+	    sigaction(SIGHUP, &sigact, NULL)) {
+		perror("Can't register parent for CTRL-C handler");
+		ret =3D errno;
+		goto out;
+	}
+
+	value.sival_ptr =3D benchmark_cmd;
+
+	/* Taskset benchmark to specified cpu */
+	ret =3D taskset_benchmark(bm_pid, param->cpu_no);
+	if (ret)
+		goto out;
+
+	/* Write benchmark to specified control&monitoring grp in resctrl FS */
+	ret =3D write_bm_pid_to_resctrl(bm_pid, param->ctrlgrp, param->mongrp,
+				      resctrl_val);
+	if (ret)
+		goto out;
+
+	if ((strcmp(resctrl_val, "mbm") =3D=3D 0) ||
+	    (strcmp(resctrl_val, "mba") =3D=3D 0)) {
+		ret =3D initialize_mem_bw_imc();
+		if (ret)
+			goto out;
+
+		initialize_mem_bw_resctrl(param->ctrlgrp, param->mongrp,
+					  param->cpu_no, resctrl_val);
+	}
+
+	/* Parent waits for child to be ready. */
+	close(pipefd[1]);
+	while (pipe_message !=3D 1)
+		read(pipefd[0], &pipe_message, sizeof(pipe_message));
+	close(pipefd[0]);
+
+	/* Signal child to start benchmark */
+	if (sigqueue(bm_pid, SIGUSR1, value) =3D=3D -1) {
+		perror("Unable to signal child to start execution");
+		ret =3D errno;
+		goto out;
+	}
+
+	/* Give benchmark enough time to fully run */
+	sleep(1);
+
+	/* Test runs until the callback setup() tells the test to stop. */
+	while (1) {
+		if (strcmp(resctrl_val, "mbm") =3D=3D 0) {
+			ret =3D param->setup(1, param);
+			if (ret) {
+				ret =3D 0;
+				break;
+			}
+
+			ret =3D measure_vals(param, &bw_resc_start);
+			if (ret)
+				break;
+		} else if ((strcmp(resctrl_val, "mba") =3D=3D 0)) {
+			ret =3D param->setup(1, param);
+			if (ret) {
+				ret =3D 0;
+				break;
+			}
+
+			ret =3D measure_vals(param, &bw_resc_start);
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
--=20
1.8.3.1

