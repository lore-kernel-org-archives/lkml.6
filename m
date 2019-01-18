Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CCC1C07EBF
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 18:28:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D73FB2087E
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 18:28:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="QMxFkPuS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729261AbfARS2G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 13:28:06 -0500
Received: from mail-eopbgr790057.outbound.protection.outlook.com ([40.107.79.57]:56814
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728952AbfARS1S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 13:27:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J+eQyu6Z4w26JP7RHp+Wt9WHf8gCIbAu9D5lHWBxGQY=;
 b=QMxFkPuSxWu1y0H6F7Y2hVXNm6Rf4daQYLPzCzcjFt77Uj7v0nZ92PSgcj+5a0fnAJflwKnxo5xCCNj3JCZUEIq/ItCxOHuW4V9QZnkGjT4ArTjRXr22+UAkreG0xnbzWe3iwPjiBFVw8NUl6o5CfkMpFAu21xuUBnkAgyaVYJ4=
Received: from DM5PR12MB2471.namprd12.prod.outlook.com (52.132.141.138) by
 DM5PR12MB1737.namprd12.prod.outlook.com (10.175.89.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1516.18; Fri, 18 Jan 2019 18:27:13 +0000
Received: from DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::9dfd:2b7b:1999:aff2]) by DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::9dfd:2b7b:1999:aff2%2]) with mapi id 15.20.1537.018; Fri, 18 Jan 2019
 18:27:13 +0000
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
Subject: [PATCH v5 09/13] selftests/resctrl: Add Cache Allocation Technology
 (CAT) selftest
Thread-Topic: [PATCH v5 09/13] selftests/resctrl: Add Cache Allocation
 Technology (CAT) selftest
Thread-Index: AQHUr1tuMAuUihI1BEqVk1MGnCW0+A==
Date:   Fri, 18 Jan 2019 18:27:12 +0000
Message-ID: <20190118182646.16594-10-babu.moger@amd.com>
References: <20190118182646.16594-1-babu.moger@amd.com>
In-Reply-To: <20190118182646.16594-1-babu.moger@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN4PR0401CA0014.namprd04.prod.outlook.com
 (2603:10b6:803:21::24) To DM5PR12MB2471.namprd12.prod.outlook.com
 (2603:10b6:4:b5::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [165.204.78.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR12MB1737;20:W1jWZmpQD3xZ9QN+XKbblIwOhteH6ZYNgZf4OLuHohAUZ5klXSTB9xydDKdDVpqQ4NnjU7kKzirTvR7aA1lwa7ekDe6KFKvYJ9SWPzxva6Zp9XjR6oRev1Y7fZeXkqBhcTFkB/UGexCYLXU3ry2BVA+oFd79tbCApujaF9jCExdX/gtTwA5b8H1jgnQqVMABNiZWqZmVgU+s+uZGND96Dx7xReIwIb9PVezxMO0+STXSmWO2mxA/ziBQJo/VECbX
x-ms-office365-filtering-correlation-id: 37058dde-9abf-44ed-51c1-08d67d7290ae
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DM5PR12MB1737;
x-ms-traffictypediagnostic: DM5PR12MB1737:
x-microsoft-antispam-prvs: <DM5PR12MB1737B1D17825928273CFB546959C0@DM5PR12MB1737.namprd12.prod.outlook.com>
x-forefront-prvs: 0921D55E4F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(346002)(376002)(39860400002)(366004)(136003)(189003)(199004)(54906003)(50226002)(6512007)(8676002)(6436002)(99286004)(1076003)(110136005)(53936002)(6486002)(7416002)(25786009)(8936002)(36756003)(26005)(4326008)(53946003)(186003)(81156014)(316002)(6116002)(81166006)(3846002)(6346003)(476003)(71200400001)(105586002)(2616005)(68736007)(2906002)(71190400001)(14454004)(106356001)(486006)(2201001)(14444005)(6506007)(5660300001)(97736004)(102836004)(72206003)(256004)(11346002)(2501003)(30864003)(7736002)(86362001)(52116002)(66066001)(478600001)(305945005)(76176011)(386003)(446003)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB1737;H:DM5PR12MB2471.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Babu.Moger@amd.com; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: A9ubRcMuBm+BIf2OmKSNePccxihuZ18blDgzKfsv5wEgGh6t95w+PQctutGWx1ONQWt1JNrp2V3sdatdr/bsoTgthiilRzDpI0ZFd0RNiKI2t485VysxwQljRoKV0nzEWyQ3l1mo3X03gGl7l2wQoyNkelUWiqcJjDXT+fkUg6IrgHMaKAaxEd36///dfV20kqugaycirST8PZM3yhq51JIU6fWuiJAX9wU+kkDc3/7xIpen2doYjmHb6T4UQLb9RBtdU4RxGiTl3bfFv27+M8jPyTAPiR9OiDcKO2s/CiUxsALr/3MhRigFx60gqlGA+jU923bAYp7+akU+AO7N2Z0Kylme5qgtjrgOqQ9gPwPtitW19SE6R6UY97m9aUQNQDu6eN0iXHp6YMpYs43Zfygi8Sg7zHYYzuc4e5Q7VVo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37058dde-9abf-44ed-51c1-08d67d7290ae
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jan 2019 18:27:11.8309
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1737
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

Signed-off-by: Arshiya Hayatkhan Pathan <arshiya.hayatkhan.pathan@intel.com=
>
Signed-off-by: Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Babu Moger <babu.moger@amd.com>
---
 tools/testing/selftests/resctrl/Makefile        |   2 +-
 tools/testing/selftests/resctrl/cache.c         | 175 ++++++++++++++++-
 tools/testing/selftests/resctrl/cat_test.c      | 243 ++++++++++++++++++++=
++++
 tools/testing/selftests/resctrl/fill_buf.c      |  10 +-
 tools/testing/selftests/resctrl/resctrl.h       |   3 +
 tools/testing/selftests/resctrl/resctrl_tests.c |  15 +-
 tools/testing/selftests/resctrl/resctrlfs.c     |   8 +-
 7 files changed, 448 insertions(+), 8 deletions(-)
 create mode 100644 tools/testing/selftests/resctrl/cat_test.c

diff --git a/tools/testing/selftests/resctrl/Makefile b/tools/testing/selft=
ests/resctrl/Makefile
index 664561c..0282222 100644
--- a/tools/testing/selftests/resctrl/Makefile
+++ b/tools/testing/selftests/resctrl/Makefile
@@ -8,7 +8,7 @@ all: resctrl_tests
=20
 resctrl_tests: *.o
 	$(CC) $(CFLAGS) -o resctrl_tests resctrl_tests.o resctrlfs.o \
-		 resctrl_val.o fill_buf.o mbm_test.o mba_test.o cache.o cqm_test.o
+		 resctrl_val.o fill_buf.o mbm_test.o mba_test.o cache.o cqm_test.o cat_t=
est.o
=20
 .PHONY: clean
=20
diff --git a/tools/testing/selftests/resctrl/cache.c b/tools/testing/selfte=
sts/resctrl/cache.c
index 1256590..c98b7bc 100644
--- a/tools/testing/selftests/resctrl/cache.c
+++ b/tools/testing/selftests/resctrl/cache.c
@@ -10,10 +10,107 @@ struct read_format {
 	} values[2];
 };
=20
+static struct perf_event_attr pea_llc_miss;
+static struct read_format rf_cqm;
+static int fd_lm;
 char cbm_mask[256];
 unsigned long long_mask;
 char llc_occup_path[1024];
=20
+static void initialize_perf_event_attr(void)
+{
+	pea_llc_miss.type =3D PERF_TYPE_HARDWARE;
+	pea_llc_miss.size =3D sizeof(struct perf_event_attr);
+	pea_llc_miss.read_format =3D PERF_FORMAT_GROUP;
+	pea_llc_miss.exclude_kernel =3D 1;
+	pea_llc_miss.exclude_hv =3D 1;
+	pea_llc_miss.exclude_idle =3D 1;
+	pea_llc_miss.exclude_callchain_kernel =3D 1;
+	pea_llc_miss.inherit =3D 1;
+	pea_llc_miss.exclude_guest =3D 1;
+	pea_llc_miss.disabled =3D 1;
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
+	fd_lm =3D perf_event_open(&pea_llc_miss, pid, cpu_no, -1,
+				PERF_FLAG_FD_CLOEXEC);
+	if (fd_lm =3D=3D -1) {
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
+	pea_llc_miss.config =3D PERF_COUNT_HW_CACHE_MISSES;
+
+	rf_cqm.nr =3D 1;
+
+	return 0;
+}
+
+static int reset_enable_llc_perf(pid_t pid, int cpu_no)
+{
+	int ret =3D 0;
+
+	ret =3D perf_event_open_llc_miss(pid, cpu_no);
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
+ * Return: =3D0 on success.  <0 on failure.
+ */
+static int get_llc_perf(unsigned long *llc_perf_miss)
+{
+	__u64 total_misses;
+
+	/* Stop counters after one span to get miss rate */
+
+	ioctl(fd_lm, PERF_EVENT_IOC_DISABLE, 0);
+
+	if (read(fd_lm, &rf_cqm, sizeof(struct read_format)) =3D=3D -1) {
+		perror("Could not get llc misses through perf");
+
+		return -1;
+	}
+
+	total_misses =3D rf_cqm.values[0].value;
+
+	close(fd_lm);
+
+	*llc_perf_miss =3D total_misses;
+
+	return 0;
+}
+
 /*
  * Get LLC Occupancy as reported by RESCTRL FS
  * For CQM,
@@ -82,10 +179,20 @@ static int print_results_cache(char *filename, int bm_=
pid,
=20
 int measure_cache_vals(struct resctrl_val_param *param, int bm_pid)
 {
-	unsigned long llc_occu_resc =3D 0, llc_value =3D 0;
+	unsigned long llc_perf_miss =3D 0, llc_occu_resc =3D 0, llc_value =3D 0;
 	int ret;
=20
 	/*
+	 * Measure cache miss from perf.
+	 */
+	if (!strcmp(param->resctrl_val, "cat")) {
+		ret =3D get_llc_perf(&llc_perf_miss);
+		if (ret < 0)
+			return ret;
+		llc_value =3D llc_perf_miss;
+	}
+
+	/*
 	 * Measure llc occupancy from resctrl.
 	 */
 	if (!strcmp(param->resctrl_val, "cqm")) {
@@ -100,3 +207,69 @@ int measure_cache_vals(struct resctrl_val_param *param=
, int bm_pid)
=20
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
+	int malloc_and_init_memory =3D 1, memflush =3D 1, opeartion =3D 1, ret =
=3D 0;
+	char *resctrl_val =3D param->resctrl_val;
+	pid_t bm_pid;
+
+	if (strcmp(param->filename, "") =3D=3D 0)
+		sprintf(param->filename, "stdio");
+
+	bm_pid =3D getpid();
+
+	/* Taskset benchmark to specified cpu */
+	ret =3D taskset_benchmark(bm_pid, param->cpu_no);
+	if (ret)
+		return ret;
+
+	/* Write benchmark to specified con_mon grp, mon_grp in resctrl FS*/
+	ret =3D write_bm_pid_to_resctrl(bm_pid, param->ctrlgrp, param->mongrp,
+				      resctrl_val);
+	if (ret)
+		return ret;
+
+	if ((strcmp(resctrl_val, "cat") =3D=3D 0)) {
+		ret =3D initialize_llc_perf();
+		if (ret)
+			return ret;
+	}
+
+	/* Test runs until the callback setup() tells the test to stop. */
+	while (1) {
+		if (strcmp(resctrl_val, "cat") =3D=3D 0) {
+			ret =3D param->setup(1, param);
+			if (ret) {
+				ret =3D 0;
+				break;
+			}
+			ret =3D reset_enable_llc_perf(bm_pid, param->cpu_no);
+			if (ret)
+				break;
+
+			if (run_fill_buf(param->span, malloc_and_init_memory,
+					 memflush, opeartion, resctrl_val)) {
+				fprintf(stderr, "Error-running fill buffer\n");
+				ret =3D -1;
+				break;
+			}
+
+			sleep(1);
+			ret =3D measure_cache_vals(param, bm_pid);
+			if (ret)
+				break;
+		} else {
+			break;
+		}
+	}
+
+	return ret;
+}
diff --git a/tools/testing/selftests/resctrl/cat_test.c b/tools/testing/sel=
ftests/resctrl/cat_test.c
new file mode 100644
index 0000000..57d501d
--- /dev/null
+++ b/tools/testing/selftests/resctrl/cat_test.c
@@ -0,0 +1,243 @@
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
+	int ret =3D 0;
+
+	va_start(param, num);
+	p =3D va_arg(param, struct resctrl_val_param *);
+	va_end(param);
+
+	/* Run NUM_OF_RUNS times */
+	if (p->num_of_runs >=3D NUM_OF_RUNS)
+		return -1;
+
+	if (p->num_of_runs =3D=3D 0) {
+		sprintf(schemata, "%lx", p->mask);
+		ret =3D write_schemata(p->ctrlgrp, schemata, p->cpu_no,
+				     p->resctrl_val);
+	}
+	p->num_of_runs++;
+
+	return ret;
+}
+
+static void show_cache_info(unsigned long sum_llc_perf_miss, int no_of_bit=
s,
+			    unsigned long span)
+{
+	unsigned long allocated_cache_lines =3D span / 64;
+	unsigned long avg_llc_perf_miss =3D 0;
+	float diff_percent;
+
+	avg_llc_perf_miss =3D sum_llc_perf_miss / (NUM_OF_RUNS - 1);
+	diff_percent =3D ((float)allocated_cache_lines - avg_llc_perf_miss) /
+				allocated_cache_lines * 100;
+	printf("Results are displayed in (Bytes)\n");
+	printf("\nNumber of bits: %d \t", no_of_bits);
+	printf("Avg_llc_perf_miss: %lu \t", avg_llc_perf_miss);
+	printf("Allocated cache lines: %lu \t", allocated_cache_lines);
+	printf("Percent diff=3D%d \t", abs((int)diff_percent));
+
+	if (abs((int)diff_percent) > MAX_DIFF_PERCENT)
+		printf("Failed\n");
+	else
+		printf("Passed\n");
+}
+
+static int check_results(struct resctrl_val_param *param)
+{
+	char *token_array[8], temp[512];
+	unsigned long sum_llc_perf_miss =3D 0;
+	int runs =3D 0, no_of_bits =3D 0;
+	FILE *fp;
+
+	printf("\nChecking for pass/fail\n");
+	fp =3D fopen(param->filename, "r");
+	if (!fp) {
+		perror("Error in opening file\n");
+
+		return errno;
+	}
+
+	while (fgets(temp, 1024, fp)) {
+		char *token =3D strtok(temp, ":\t");
+		int fields =3D 0;
+
+		while (token) {
+			token_array[fields++] =3D token;
+			token =3D strtok(NULL, ":\t");
+		}
+		/*
+		 * Discard the first value which is inaccurate due to monitoring
+		 * setup transition phase.
+		 */
+		if (runs > 0)
+			sum_llc_perf_miss +=3D atol(token_array[3]);
+		runs++;
+	}
+
+	fclose(fp);
+	no_of_bits =3D count_bits(param->mask);
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
+int cat_perf_miss_val(int core_id, int n)
+{
+	unsigned long l_mask, l_mask_1;
+	int ret, pipefd[2], pipe_message, mum_resctrlfs, sibling_core_id;
+	pid_t bm_pid;
+
+	cache_size =3D 0;
+	mum_resctrlfs =3D 1;
+
+	ret =3D remount_resctrlfs(mum_resctrlfs);
+	if (ret)
+		return ret;
+
+	ret =3D validate_resctrl_feature_request("cat");
+	if (ret)
+		return ret;
+
+	/* Get default cbm mask for L3 cache */
+	ret =3D get_cbm_mask("L3");
+	if (ret)
+		return ret;
+
+	long_mask =3D strtoul(cbm_mask, NULL, 16);
+
+	/* Get L3 cache size */
+	ret =3D get_cache_size(core_id, 3, &cache_size);
+	if (ret)
+		return ret;
+
+	/* Get max number of bits from default-cabm mask */
+	count_of_bits =3D count_bits(long_mask);
+
+	if (n < 1 || n > count_of_bits - 1) {
+		printf("Invalid input value for no_of_bits n!\n");
+		printf("Please Enter value in range 1 to %d\n",
+		       count_of_bits - 1);
+		return -1;
+	}
+
+	/* Get core id from same socket for running another thread */
+	sibling_core_id =3D get_core_sibling(core_id);
+	if (sibling_core_id < 0)
+		return -1;
+
+	struct resctrl_val_param param =3D {
+		.resctrl_val	=3D "cat",
+		.cpu_no		=3D core_id,
+		.mum_resctrlfs	=3D 0,
+		.setup		=3D cat_setup,
+	};
+
+	l_mask =3D long_mask >> n;
+	l_mask_1 =3D ~l_mask & long_mask;
+
+	/* Set param values for parent thread which will be allocated bitmask
+	 * with (max_bits - n) bits
+	 */
+	param.span =3D cache_size * (count_of_bits - n) / count_of_bits;
+	strcpy(param.ctrlgrp, "c2");
+	strcpy(param.mongrp, "m2");
+	strcpy(param.filename, RESULT_FILE_NAME1);
+	param.mask =3D l_mask;
+	param.num_of_runs =3D 0;
+
+	if (pipe(pipefd)) {
+		perror("Unable to create pipe");
+		return -1;
+	}
+	ret =3D remount_resctrlfs(mum_resctrlfs);
+	if (ret)
+		return ret;
+
+	bm_pid =3D fork();
+
+	/* Set param values for child thread which will be allocated bitmask
+	 * with n bits
+	 */
+	if (bm_pid =3D=3D 0) {
+		param.mask =3D l_mask_1;
+		strcpy(param.ctrlgrp, "c1");
+		strcpy(param.mongrp, "m1");
+		param.span =3D cache_size * n / count_of_bits;
+		strcpy(param.filename, RESULT_FILE_NAME2);
+		param.num_of_runs =3D 0;
+		param.cpu_no =3D sibling_core_id;
+	}
+
+	remove(param.filename);
+
+	ret =3D cat_val(&param);
+	if (ret)
+		return ret;
+
+	ret =3D check_results(&param);
+	if (ret)
+		return ret;
+
+	if (bm_pid =3D=3D 0) {
+		/* Tell parent that child is ready */
+		close(pipefd[0]);
+		pipe_message =3D 1;
+		write(pipefd[1], &pipe_message, sizeof(pipe_message));
+		close(pipefd[1]);
+		while (1);
+	} else {
+		/* Parent waits for child to be ready. */
+		close(pipefd[1]);
+		pipe_message =3D 0;
+		while (pipe_message !=3D 1)
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
diff --git a/tools/testing/selftests/resctrl/fill_buf.c b/tools/testing/sel=
ftests/resctrl/fill_buf.c
index 7c3579a..671d801 100644
--- a/tools/testing/selftests/resctrl/fill_buf.c
+++ b/tools/testing/selftests/resctrl/fill_buf.c
@@ -105,8 +105,11 @@ void fill_one_span_write(unsigned char *start_ptr, uns=
igned char *end_ptr)
 static int fill_cache_read(unsigned char *start_ptr, unsigned char *end_pt=
r,
 			   char *resctrl_val)
 {
-	while (1)
+	while (1) {
 		fill_one_span_read(start_ptr, end_ptr);
+		if (!strcmp(resctrl_val, "cat"))
+			break;
+	}
=20
 	return 0;
 }
@@ -114,8 +117,11 @@ static int fill_cache_read(unsigned char *start_ptr, u=
nsigned char *end_ptr,
 static int fill_cache_write(unsigned char *start_ptr, unsigned char *end_p=
tr,
 			    char *resctrl_val)
 {
-	while (1)
+	while (1) {
 		fill_one_span_write(start_ptr, end_ptr);
+		if (!strcmp(resctrl_val, "cat"))
+			break;
+	}
=20
 	return 0;
 }
diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/self=
tests/resctrl/resctrl.h
index a4f8040..3da2afe 100644
--- a/tools/testing/selftests/resctrl/resctrl.h
+++ b/tools/testing/selftests/resctrl/resctrl.h
@@ -91,7 +91,10 @@ int run_fill_buf(unsigned long long span, int malloc_and=
_init_memory,
 void mba_test_cleanup(void);
 int get_cbm_mask(char *cache_type);
 int get_cache_size(int cpu_no, int cache_num, unsigned long *cache_size);
+int cat_val(struct resctrl_val_param *param);
+void cat_test_cleanup(void);
 void ctrlc_handler(int signum, siginfo_t *info, void *ptr);
+int cat_perf_miss_val(int core_id, int no_of_bits);
 int cqm_resctrl_val(int core_id, int n, char **benchmark_cmd);
 unsigned int count_bits(unsigned long n);
 void cqm_test_cleanup(void);
diff --git a/tools/testing/selftests/resctrl/resctrl_tests.c b/tools/testin=
g/selftests/resctrl/resctrl_tests.c
index 6d4a1cf..2397c3b 100644
--- a/tools/testing/selftests/resctrl/resctrl_tests.c
+++ b/tools/testing/selftests/resctrl/resctrl_tests.c
@@ -20,7 +20,7 @@ static void cmd_help(void)
 	printf("\t-b benchmark_cmd [options]: run specified benchmark for MBM, MB=
A and CQM");
 	printf("\t default benchmark is builtin fill_buf\n");
 	printf("\t-t test list: run tests specified in the test list, ");
-	printf("e.g. -t mbm, mba, cqm\n");
+	printf("e.g. -t mbm, mba, cqm, cat\n");
 	printf("\t-n no_of_bits: run cache tests using specified no of bits in ca=
che bit mask\n");
 	printf("\t-h: help\n");
 }
@@ -30,6 +30,7 @@ void tests_cleanup(void)
 	mbm_test_cleanup();
 	mba_test_cleanup();
 	cqm_test_cleanup();
+	cat_test_cleanup();
 }
=20
 int main(int argc, char **argv)
@@ -38,7 +39,7 @@ int main(int argc, char **argv)
 	int res, c, core_id =3D 1, span =3D 250, argc_new =3D argc, i, no_of_bits=
 =3D 5;
 	int ben_count, ben_ind;
 	bool has_ben =3D false, mbm_test =3D true, mba_test =3D true;
-	bool cqm_test =3D true;
+	bool cqm_test =3D true, cat_test =3D true;
 	char *benchmark_cmd[BENCHMARK_ARGS];
 	char bw_report[64], bm_type[64];
=20
@@ -62,6 +63,7 @@ int main(int argc, char **argv)
 			mbm_test =3D false;
 			mba_test =3D false;
 			cqm_test =3D false;
+			cat_test =3D false;
 			while (token) {
 				if (!strcmp(token, "mbm")) {
 					mbm_test =3D true;
@@ -69,6 +71,8 @@ int main(int argc, char **argv)
 					mba_test =3D true;
 				} else if (!strcmp(token, "cqm")) {
 					cqm_test =3D true;
+				} else if (!strcmp(token, "cat")) {
+					cat_test =3D true;
 				} else {
 					printf("invalid argument\n");
=20
@@ -159,6 +163,13 @@ int main(int argc, char **argv)
 			printf("Error in CQM test!\n");
 		cqm_test_cleanup();
 	}
+	if (cat_test) {
+		printf("\nCAT Test Starting..\n");
+		res =3D cat_perf_miss_val(core_id, no_of_bits);
+		if (res)
+			printf("Error in CAT test!\n");
+		cat_test_cleanup();
+	}
=20
 	return 0;
 }
diff --git a/tools/testing/selftests/resctrl/resctrlfs.c b/tools/testing/se=
lftests/resctrl/resctrlfs.c
index 3c88afa..146a10e 100644
--- a/tools/testing/selftests/resctrl/resctrlfs.c
+++ b/tools/testing/selftests/resctrl/resctrlfs.c
@@ -14,6 +14,7 @@
 #define RESCTRL_MBM		"L3 monitoring detected"
 #define RESCTRL_MBA		"MB allocation detected"
 #define RESCTRL_CQM		"L3 monitoring detected"
+#define RESCTRL_L3_CAT		"L3 allocation detected"
 #define MAX_RESCTRL_FEATURES	4
 #define CORE_SIBLINGS_PATH	"/sys/bus/cpu/devices/cpu"
=20
@@ -475,6 +476,7 @@ int write_schemata(char *ctrlgrp, char *schemata, int c=
pu_no, char *resctrl_val)
 	FILE *fp;
=20
 	if ((strcmp(resctrl_val, "mba") =3D=3D 0) ||
+	    (strcmp(resctrl_val, "cat") =3D=3D 0) ||
 	    (strcmp(resctrl_val, "cqm") =3D=3D 0)) {
 		if (!schemata) {
 			printf("Schemata empty, so not updating\n");
@@ -492,7 +494,7 @@ int write_schemata(char *ctrlgrp, char *schemata, int c=
pu_no, char *resctrl_val)
 		else
 			sprintf(controlgroup, "%s/schemata", RESCTRL_PATH);
=20
-		if (!strcmp(resctrl_val, "cqm"))
+		if (!strcmp(resctrl_val, "cat") || !strcmp(resctrl_val, "cqm"))
 			sprintf(schema, "%s%d%c%s", "L3:", resource_id, '=3D',
 				schemata);
 		if (strcmp(resctrl_val, "mba") =3D=3D 0)
@@ -530,7 +532,7 @@ int validate_resctrl_feature_request(char *resctrl_val)
 {
 	int resctrl_features_supported[MAX_RESCTRL_FEATURES] =3D {0, 0, 0, 0};
 	const char *resctrl_features_list[MAX_RESCTRL_FEATURES] =3D {
-			"mbm", "mba", "cqm"};
+			"mbm", "mba", "cat", "cqm"};
 	int i, valid_resctrl_feature =3D -1;
 	char line[1024];
 	FILE *fp;
@@ -571,6 +573,8 @@ int validate_resctrl_feature_request(char *resctrl_val)
 			resctrl_features_supported[0] =3D 1;
 		if ((strstr(line, RESCTRL_MBA)) !=3D NULL)
 			resctrl_features_supported[1] =3D 1;
+		if ((strstr(line, RESCTRL_L3_CAT)) !=3D NULL)
+			resctrl_features_supported[2] =3D 1;
 		if ((strstr(line, RESCTRL_CQM)) !=3D NULL)
 			resctrl_features_supported[3] =3D 1;
 	}
--=20
1.8.3.1

