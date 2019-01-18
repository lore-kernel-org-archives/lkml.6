Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C393C5AC81
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 18:27:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8CD82087E
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 18:27:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="F1rEXP7I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729129AbfARS1Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 13:27:24 -0500
Received: from mail-eopbgr700066.outbound.protection.outlook.com ([40.107.70.66]:43360
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728900AbfARS1T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 13:27:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oE91zWFA8bU77usMkHTAROAgWUtVlINyk3/kU5RIwbo=;
 b=F1rEXP7IvdFASqjVhRmM5XjaKKCfSwuXEzg7N4FvyXsYw6McjPw0GwObjd7Z57rjTIG9qoPwhKbxP5HcVPtora9Dz4V1wI4mbDVQRrrU+mi84MFhq7sOwmiXgqqdjNSu74RlP2E2emsBo38xoepvvJYqWsgM+xqin84YWPahWhE=
Received: from DM5PR12MB2471.namprd12.prod.outlook.com (52.132.141.138) by
 DM5PR12MB2376.namprd12.prod.outlook.com (52.132.141.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1537.24; Fri, 18 Jan 2019 18:27:09 +0000
Received: from DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::9dfd:2b7b:1999:aff2]) by DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::9dfd:2b7b:1999:aff2%2]) with mapi id 15.20.1537.018; Fri, 18 Jan 2019
 18:27:09 +0000
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
Subject: [PATCH v5 06/13] selftests/resctrl: Add MBM test
Thread-Topic: [PATCH v5 06/13] selftests/resctrl: Add MBM test
Thread-Index: AQHUr1tsA07g9caREkehNOLr8hN7VA==
Date:   Fri, 18 Jan 2019 18:27:09 +0000
Message-ID: <20190118182646.16594-7-babu.moger@amd.com>
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
x-microsoft-exchange-diagnostics: 1;DM5PR12MB2376;20:LhOZkt34iJcHFBfKFbb4p05G05ypMwjPi3YFVMbu7Pu3ouzzUFp3SW9vhcfPMttteLKrLYqQEhCRfbb2jMSBKckv8X/cTGSYIGBvjzcF8QDsSQ1dkdCuZtgydBJup661XjnN3OVFPrM+aPAVtEdfZIK3K975Zizjr0uNpI4XvdkyA3Cj68R5kxMSUoVdQNQHfhpZXRlL9h45K9QkmrG4JuRS5giMlBbYy5gTN7ZYv/6g7XoeNtY75Cf90nTGPJZ5
x-ms-office365-filtering-correlation-id: 404c334e-6166-4761-df64-08d67d728e76
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600109)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DM5PR12MB2376;
x-ms-traffictypediagnostic: DM5PR12MB2376:
x-microsoft-antispam-prvs: <DM5PR12MB2376F84DE02350F355BE8F1C959C0@DM5PR12MB2376.namprd12.prod.outlook.com>
x-forefront-prvs: 0921D55E4F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(39860400002)(136003)(396003)(346002)(366004)(189003)(199004)(1076003)(25786009)(26005)(52116002)(4326008)(186003)(102836004)(2201001)(6506007)(76176011)(72206003)(86362001)(386003)(3846002)(71200400001)(71190400001)(256004)(14444005)(6486002)(54906003)(99286004)(305945005)(110136005)(6436002)(7736002)(486006)(6512007)(316002)(2616005)(446003)(2906002)(97736004)(476003)(11346002)(478600001)(7416002)(105586002)(53936002)(106356001)(81166006)(8936002)(8676002)(5660300001)(36756003)(68736007)(66066001)(6116002)(50226002)(14454004)(2501003)(81156014)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB2376;H:DM5PR12MB2471.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: lluZGtBPL4iqbi/layl+eZsbmUguNBeF4qGnpGxvtu5OajZRAT/wrahCUIiki+Jt8Y1NUHdB/UWTP2t7yO4NxFOHon86xMGT0BM4hgMki7H3p+OO1rqP7JTnJ+x4boLsqy0mKagluJz2NQfq38XvYww8SnALLjglOAWMqIpoDyanNpaOEYPnombgb2b5C0etLDTr2V3LhqarERDemdC+SJ5bf5wF/tsKI1Cv53pRIEq6L3ljuwjl0VoyvqQiM7nv2Lg+p0e/2QFHyBHp7BqEwKAgiFoAGg7QO7zXGcyWQARYgJarFkv1IqqcisY5anaBWs77S/5PkvLrfRvKncypAXqlA0AzY+ZgFZFViTVeFIwzzCF4O6XB4mdW9HBu9JoZHleA4nmIob25evHSmFj43yEbzGgQC1p3qZ3rqID4UOY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 404c334e-6166-4761-df64-08d67d728e76
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jan 2019 18:27:08.1277
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2376
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

Signed-off-by: Arshiya Hayatkhan Pathan <arshiya.hayatkhan.pathan@intel.com=
>
Signed-off-by: Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>,
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Babu Moger <babu.moger@amd.com>
---
 tools/testing/selftests/resctrl/Makefile        |   8 +-
 tools/testing/selftests/resctrl/mbm_test.c      | 145 ++++++++++++++++++++=
++++
 tools/testing/selftests/resctrl/resctrl.h       |   3 +
 tools/testing/selftests/resctrl/resctrl_tests.c | 123 ++++++++++++++++++++
 tools/testing/selftests/resctrl/resctrl_val.c   |   2 +
 5 files changed, 280 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/resctrl/mbm_test.c
 create mode 100644 tools/testing/selftests/resctrl/resctrl_tests.c

diff --git a/tools/testing/selftests/resctrl/Makefile b/tools/testing/selft=
ests/resctrl/Makefile
index bd5c541..eaa8b45 100644
--- a/tools/testing/selftests/resctrl/Makefile
+++ b/tools/testing/selftests/resctrl/Makefile
@@ -1,10 +1,16 @@
 CC =3D gcc
 CFLAGS =3D -g -Wall
=20
+all: resctrl_tests
+
 *.o: *.c
 	$(CC) $(CFLAGS) -c *.c
=20
+resctrl_tests: *.o
+	$(CC) $(CFLAGS) -o resctrl_tests resctrl_tests.o resctrlfs.o \
+		 resctrl_val.o fill_buf.o mbm_test.o
+
 .PHONY: clean
=20
 clean:
-	$(RM) *.o *~
+	$(RM) *.o *~ resctrl_tests
diff --git a/tools/testing/selftests/resctrl/mbm_test.c b/tools/testing/sel=
ftests/resctrl/mbm_test.c
new file mode 100644
index 0000000..fc1b8ba
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
+	unsigned long avg_bw_imc =3D 0, avg_bw_resc =3D 0;
+	unsigned long sum_bw_imc =3D 0, sum_bw_resc =3D 0;
+	long avg_diff =3D 0;
+	int runs;
+
+	/*
+	 * Discard the first value which is inaccurate due to monitoring setup
+	 * transition phase.
+	 */
+	for (runs =3D 1; runs < NUM_OF_RUNS ; runs++) {
+		sum_bw_imc +=3D bw_imc[runs];
+		sum_bw_resc +=3D bw_resc[runs];
+	}
+
+	avg_bw_imc =3D sum_bw_imc / 4;
+	avg_bw_resc =3D sum_bw_resc / 4;
+	avg_diff =3D avg_bw_resc - avg_bw_imc;
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
+	char output[] =3D RESULT_FILE_NAME;
+	int runs;
+	FILE *fp;
+
+	printf("\nChecking for pass/fail\n");
+
+	fp =3D fopen(output, "r");
+	if (!fp) {
+		perror("Error in opening file\n");
+
+		return errno;
+	}
+
+	runs =3D 0;
+	while (fgets(temp, 1024, fp)) {
+		char *token =3D strtok(temp, ":\t");
+		int i =3D 0;
+
+		while (token) {
+			token_array[i++] =3D token;
+			token =3D strtok(NULL, ":\t");
+		}
+
+		bw_resc[runs] =3D atol(token_array[5]);
+		bw_imc[runs] =3D atol(token_array[3]);
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
+	int ret =3D 0;
+
+	/* Run NUM_OF_RUNS times */
+	if (num_of_runs++ >=3D NUM_OF_RUNS)
+		return -1;
+
+	va_start(param, num);
+	p =3D va_arg(param, struct resctrl_val_param *);
+	va_end(param);
+
+	/* Set up shemata with 100% allocation on the first run. */
+	if (num_of_runs =3D=3D 0)
+		ret =3D write_schemata(p->ctrlgrp, "100", p->cpu_no,
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
+int mbm_bw_change(int span, int core_id, char *bw_report, char **benchmark=
_cmd)
+{
+	struct resctrl_val_param param =3D {
+		.resctrl_val	=3D "mbm",
+		.ctrlgrp	=3D "c1",
+		.mongrp		=3D "m1",
+		.span		=3D span,
+		.cpu_no		=3D core_id,
+		.mum_resctrlfs	=3D 1,
+		.filename	=3D RESULT_FILE_NAME,
+		.bw_report	=3D  bw_report,
+		.setup		=3D mbm_setup
+	};
+	int ret;
+
+	remove(RESULT_FILE_NAME);
+
+	ret =3D membw_val(benchmark_cmd, &param);
+	if (ret)
+		return ret;
+
+	ret =3D check_results(span);
+	if (ret)
+		return ret;
+
+	mbm_test_cleanup();
+
+	return 0;
+}
diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/self=
tests/resctrl/resctrl.h
index f30a2dc..90d1fd1 100644
--- a/tools/testing/selftests/resctrl/resctrl.h
+++ b/tools/testing/selftests/resctrl/resctrl.h
@@ -70,5 +70,8 @@ int perf_event_open(struct perf_event_attr *hw_event, pid=
_t pid, int cpu,
 		    int group_fd, unsigned long flags);
 int run_fill_buf(int span, int malloc_and_init_memory, int memflush, int o=
p);
 int membw_val(char **benchmark_cmd, struct resctrl_val_param *param);
+int mbm_bw_change(int span, int core_id, char *bw_report, char **benchmark=
_cmd);
+void tests_cleanup(void);
+void mbm_test_cleanup(void);
=20
 #endif /* RESCTRL_H */
diff --git a/tools/testing/selftests/resctrl/resctrl_tests.c b/tools/testin=
g/selftests/resctrl/resctrl_tests.c
new file mode 100644
index 0000000..8a33809
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
+	printf("usage: resctrl_tests [-h] [-b \"benchmark_cmd [options]\"] [-t te=
st list]\n");
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
+	int res, c, core_id =3D 0, span =3D 250, argc_new =3D argc, i;
+	bool has_ben =3D false, mbm_test =3D true;
+	char *benchmark_cmd[BENCHMARK_ARGS];
+	char bw_report[64], bm_type[64];
+
+	while ((c =3D getopt(argc_new, argv, "ht:b:")) !=3D -1) {
+		char *token;
+
+		switch (c) {
+		case 't':
+			token =3D strtok(optarg, ",");
+
+			mbm_test =3D false;
+			while (token) {
+				if (!strcmp(token, "mbm")) {
+					mbm_test =3D true;
+				} else {
+					printf("invalid argument\n");
+
+					return -1;
+				}
+				token =3D strtok(NULL, ":\t");
+			}
+			break;
+		case 'b':
+			/* Extract benchmark command from command line. */
+			token =3D strtok(optarg, " ");
+			i =3D 0;
+			while (token) {
+				benchmark_cmd[i] =3D benchmark_cmd_area[i];
+				strcpy(benchmark_cmd[i++], token);
+				if (i >=3D BENCHMARK_ARGS) {
+					printf("Too many benchmark args\n");
+
+					return -1;
+				}
+				token =3D strtok(NULL, " ");
+			}
+			benchmark_cmd[i] =3D NULL;
+			has_ben =3D true;
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
+	if (geteuid() !=3D 0) {
+		perror("Please run this program as root\n");
+
+		return errno;
+	}
+
+	if (!has_ben) {
+		/* If no benchmark is given by "-b" argument, use fill_buf. */
+		for (i =3D 0; i < 5; i++)
+			benchmark_cmd[i] =3D benchmark_cmd_area[i];
+		strcpy(benchmark_cmd[0], "fill_buf");
+		sprintf(benchmark_cmd[1], "%d", span);
+		strcpy(benchmark_cmd[2], "1");
+		strcpy(benchmark_cmd[3], "1");
+		strcpy(benchmark_cmd[4], "0");
+		benchmark_cmd[5] =3D NULL;
+	}
+
+	sprintf(bw_report, "reads");
+	sprintf(bm_type, "fill_buf");
+
+	if (mbm_test) {
+		printf("\nMBM BW Change Starting..\n");
+		res =3D mbm_bw_change(span, core_id, bw_report, benchmark_cmd);
+		if (res)
+			printf("Error in running tests for mbm bw change!\n");
+	}
+
+	return 0;
+}
diff --git a/tools/testing/selftests/resctrl/resctrl_val.c b/tools/testing/=
selftests/resctrl/resctrl_val.c
index 8b32595..86a513e 100644
--- a/tools/testing/selftests/resctrl/resctrl_val.c
+++ b/tools/testing/selftests/resctrl/resctrl_val.c
@@ -437,6 +437,8 @@ static unsigned long get_mem_bw_resctrl(void)
 static void ctrlc_handler(int signum, siginfo_t *info, void *ptr)
 {
 	kill(bm_pid, SIGKILL);
+	umount_resctrlfs();
+	tests_cleanup();
 	printf("Ending\n\n");
=20
 	exit(EXIT_SUCCESS);
--=20
1.8.3.1

