Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86A9AC5AC81
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 18:27:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4006720883
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 18:27:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="cj8acWLN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729201AbfARS12 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 13:27:28 -0500
Received: from mail-eopbgr700066.outbound.protection.outlook.com ([40.107.70.66]:43360
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729089AbfARS1Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 13:27:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1KX1C6YmJlpwjj8W8GTxcZPo4WqoaKL66XbTBz0nuH8=;
 b=cj8acWLNdx5PC9GSortBm5pkKgZWM/CbAhjeq6h1VSzKMbM0UcfrYx554sNstsGKYraoefMjvAiRrR8Zeimydy7y2EAvsYqpFefJXO/Y0ZmtRxkaYAT+AK66TjuVHPKh/64yOh/wXx0XC8AbM1VsOocaSJ1karFchsEsMCQ0PPY=
Received: from DM5PR12MB2471.namprd12.prod.outlook.com (52.132.141.138) by
 DM5PR12MB2376.namprd12.prod.outlook.com (52.132.141.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1537.24; Fri, 18 Jan 2019 18:27:10 +0000
Received: from DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::9dfd:2b7b:1999:aff2]) by DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::9dfd:2b7b:1999:aff2%2]) with mapi id 15.20.1537.018; Fri, 18 Jan 2019
 18:27:10 +0000
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
Subject: [PATCH v5 07/13] selftests/resctrl: Add MBA test
Thread-Topic: [PATCH v5 07/13] selftests/resctrl: Add MBA test
Thread-Index: AQHUr1ts8ZJ2ptqirkuWPe/Cdr5bPA==
Date:   Fri, 18 Jan 2019 18:27:10 +0000
Message-ID: <20190118182646.16594-8-babu.moger@amd.com>
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
x-microsoft-exchange-diagnostics: 1;DM5PR12MB2376;20:HzxuwIdjrzYF/sfzX1xVpQI5O9YeX11WgeXlEiIKPW+912xWhu6wyp8pNqLvOmNx4IDNW3HAeZb95OufvlD1U4RrMqk9xOksDSLwDf1ZUWBnEa3VS6v+X7No4SkxWUHhnDQtvt6PYM4UjVQ3d5abcsWUuwk7XiEqtxCtm3TE0wSm+cgC5yGbaAJg78pW7z8U2Z+O98KO8KRcfutTCa+EqDZ7dVRsOxwSWDWYsRMmQu3H5a1apSbbXbTrYBdOuxwT
x-ms-office365-filtering-correlation-id: 3182eeb2-5a6a-4ea4-12f8-08d67d728f2c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600109)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DM5PR12MB2376;
x-ms-traffictypediagnostic: DM5PR12MB2376:
x-microsoft-antispam-prvs: <DM5PR12MB2376B795D276BE1436BD31EB959C0@DM5PR12MB2376.namprd12.prod.outlook.com>
x-forefront-prvs: 0921D55E4F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(39860400002)(136003)(396003)(346002)(366004)(189003)(199004)(1076003)(25786009)(26005)(52116002)(4326008)(186003)(102836004)(2201001)(6506007)(76176011)(72206003)(86362001)(386003)(3846002)(71200400001)(71190400001)(256004)(14444005)(6486002)(54906003)(99286004)(305945005)(110136005)(6436002)(7736002)(486006)(6512007)(316002)(2616005)(446003)(2906002)(97736004)(476003)(11346002)(478600001)(7416002)(105586002)(53936002)(106356001)(81166006)(8936002)(8676002)(5660300001)(36756003)(68736007)(66066001)(6116002)(50226002)(14454004)(2501003)(81156014)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB2376;H:DM5PR12MB2471.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: BUHK5s1hXm87jM35oWgJSw1KxQKTaoFXCSxDOKazOmh1veNUi2waBHTO7aNhqy8tly7zNxpP2wxQ3qu/H8ulxVB/0VZpGJIv6SjYf6825j8aJ1sinAS8ICfT81xgR2JMXBQMaZuRj+ZgFinwT/ydrolzTgDgFuXKWrMW3b/kO0W+6pXtBvPT5ghZnc8ATrTnCRXfAfZ9YqNuMQjytzrHLok9UXqcGrM2Ne5jY1Y3XeIXhP7B+Kh6qi7fj4Qyi/TSsQR/9ZITDszYs6e3bsMhqZ1fg3ABFTHcdCZRSsTTtYar0/Yy79TzHlW9h18Dbx8a+Q5et9CSQjJq0WD1qjCF5yrCzUtonnHLbk+BNP0g1NlXD3tk6+W7L5wpP5CkfSpeJXuFnw8rNPdFu543tl4Y70XHwQLTf97BY3/ZQ733k0I=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3182eeb2-5a6a-4ea4-12f8-08d67d728f2c
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jan 2019 18:27:09.3152
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2376
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

Signed-off-by: Arshiya Hayatkhan Pathan <arshiya.hayatkhan.pathan@intel.com=
>
Signed-off-by: Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>,
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Babu Moger <babu.moger@amd.com>
---
 tools/testing/selftests/resctrl/Makefile        |   2 +-
 tools/testing/selftests/resctrl/mba_test.c      | 173 ++++++++++++++++++++=
++++
 tools/testing/selftests/resctrl/resctrl.h       |   2 +
 tools/testing/selftests/resctrl/resctrl_tests.c |  15 +-
 4 files changed, 190 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/resctrl/mba_test.c

diff --git a/tools/testing/selftests/resctrl/Makefile b/tools/testing/selft=
ests/resctrl/Makefile
index eaa8b45..141cbdb 100644
--- a/tools/testing/selftests/resctrl/Makefile
+++ b/tools/testing/selftests/resctrl/Makefile
@@ -8,7 +8,7 @@ all: resctrl_tests
=20
 resctrl_tests: *.o
 	$(CC) $(CFLAGS) -o resctrl_tests resctrl_tests.o resctrlfs.o \
-		 resctrl_val.o fill_buf.o mbm_test.o
+		 resctrl_val.o fill_buf.o mbm_test.o mba_test.o
=20
 .PHONY: clean
=20
diff --git a/tools/testing/selftests/resctrl/mba_test.c b/tools/testing/sel=
ftests/resctrl/mba_test.c
new file mode 100644
index 0000000..7a5d869
--- /dev/null
+++ b/tools/testing/selftests/resctrl/mba_test.c
@@ -0,0 +1,173 @@
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
+	static int runs_per_allocation, allocation =3D 100;
+	struct resctrl_val_param *p;
+	char allocation_str[64];
+	va_list param;
+
+	va_start(param, num);
+	p =3D va_arg(param, struct resctrl_val_param *);
+	va_end(param);
+
+	if (runs_per_allocation >=3D NUM_OF_RUNS)
+		runs_per_allocation =3D 0;
+
+	/* Only set up schemata once every NUM_OF_RUNS of allocations */
+	if (runs_per_allocation++ !=3D 0)
+		return 0;
+
+	if (allocation < ALLOCATION_MIN || allocation > ALLOCATION_MAX)
+		return -1;
+
+	sprintf(allocation_str, "%d", allocation);
+
+	write_schemata(p->ctrlgrp, allocation_str, p->cpu_no, p->resctrl_val);
+	printf("changed schemata to : %d\n", allocation);
+	allocation -=3D ALLOCATION_STEP;
+
+	return 0;
+}
+
+static void show_mba_info(unsigned long *bw_imc, unsigned long *bw_resc)
+{
+	int allocation, failed =3D 0, runs;
+
+	/* Memory bandwidth from 100% down to 10% */
+	for (allocation =3D 0; allocation < ALLOCATION_MAX / ALLOCATION_STEP;
+	     allocation++) {
+		unsigned long avg_bw_imc =3D 0, avg_bw_resc =3D 0;
+		unsigned long sum_bw_imc =3D 0, sum_bw_resc =3D 0;
+		long  avg_diff =3D 0;
+
+		/*
+		 * The first run is discarded due to inaccurate value from
+		 * phase transition.
+		 */
+		for (runs =3D NUM_OF_RUNS * allocation + 1;
+		     runs < NUM_OF_RUNS * allocation + NUM_OF_RUNS ; runs++) {
+			sum_bw_imc +=3D bw_imc[runs];
+			sum_bw_resc +=3D bw_resc[runs];
+		}
+
+		avg_bw_imc =3D sum_bw_imc / (NUM_OF_RUNS - 1);
+		avg_bw_resc =3D sum_bw_resc / (NUM_OF_RUNS - 1);
+		avg_diff =3D avg_bw_resc - avg_bw_imc;
+
+		printf("\nschemata percentage: %d \t",
+		       ALLOCATION_MAX - ALLOCATION_STEP * allocation);
+		printf("avg_bw_imc: %lu\t", avg_bw_imc);
+		printf("avg_bw_resc: %lu\t", avg_bw_resc);
+		printf("avg_diff: %lu\t", labs(avg_diff));
+		if (labs(avg_diff) > MAX_DIFF) {
+			printf("failed\n");
+			failed =3D 1;
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
+	char *token_array[8], output[] =3D RESULT_FILE_NAME, temp[512];
+	unsigned long bw_imc[1024], bw_resc[1024];
+	int runs;
+	FILE *fp;
+
+	printf("\nchecking for pass/fail\n");
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
+		int fields =3D 0;
+
+		while (token) {
+			token_array[fields++] =3D token;
+			token =3D strtok(NULL, ":\t");
+		}
+
+		/* Field 3 is perf imc value */
+		bw_imc[runs] =3D atol(token_array[3]);
+		/* Field 5 is resctrl value */
+		bw_resc[runs] =3D atol(token_array[5]);
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
+int mba_schemata_change(int core_id, char *bw_report, char **benchmark_cmd=
)
+{
+	struct resctrl_val_param param =3D {
+		.resctrl_val	=3D "mba",
+		.ctrlgrp	=3D "c1",
+		.mongrp		=3D "m1",
+		.cpu_no		=3D core_id,
+		.mum_resctrlfs	=3D 1,
+		.filename	=3D RESULT_FILE_NAME,
+		.bw_report	=3D bw_report,
+		.setup		=3D mba_setup
+	};
+	int ret;
+
+	remove(RESULT_FILE_NAME);
+
+	ret =3D membw_val(benchmark_cmd, &param);
+	if (ret)
+		return ret;
+
+	ret =3D check_results();
+	if (ret)
+		return ret;
+
+	mba_test_cleanup();
+
+	return 0;
+}
diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/self=
tests/resctrl/resctrl.h
index 90d1fd1..f54a034 100644
--- a/tools/testing/selftests/resctrl/resctrl.h
+++ b/tools/testing/selftests/resctrl/resctrl.h
@@ -73,5 +73,7 @@ int perf_event_open(struct perf_event_attr *hw_event, pid=
_t pid, int cpu,
 int mbm_bw_change(int span, int core_id, char *bw_report, char **benchmark=
_cmd);
 void tests_cleanup(void);
 void mbm_test_cleanup(void);
+int mba_schemata_change(int core_id, char *bw_report, char **benchmark_cmd=
);
+void mba_test_cleanup(void);
=20
 #endif /* RESCTRL_H */
diff --git a/tools/testing/selftests/resctrl/resctrl_tests.c b/tools/testin=
g/selftests/resctrl/resctrl_tests.c
index 8a33809..e4d00fb 100644
--- a/tools/testing/selftests/resctrl/resctrl_tests.c
+++ b/tools/testing/selftests/resctrl/resctrl_tests.c
@@ -29,13 +29,14 @@ static void cmd_help(void)
 void tests_cleanup(void)
 {
 	mbm_test_cleanup();
+	mba_test_cleanup();
 }
=20
 int main(int argc, char **argv)
 {
 	char benchmark_cmd_area[BENCHMARK_ARGS][BENCHMARK_ARG_SIZE];
 	int res, c, core_id =3D 0, span =3D 250, argc_new =3D argc, i;
-	bool has_ben =3D false, mbm_test =3D true;
+	bool has_ben =3D false, mbm_test =3D true, mba_test =3D true;
 	char *benchmark_cmd[BENCHMARK_ARGS];
 	char bw_report[64], bm_type[64];
=20
@@ -47,9 +48,12 @@ int main(int argc, char **argv)
 			token =3D strtok(optarg, ",");
=20
 			mbm_test =3D false;
+			mba_test =3D false;
 			while (token) {
 				if (!strcmp(token, "mbm")) {
 					mbm_test =3D true;
+				} else if (!strcmp(token, "mba")) {
+					mba_test =3D true;
 				} else {
 					printf("invalid argument\n");
=20
@@ -119,5 +123,14 @@ int main(int argc, char **argv)
 			printf("Error in running tests for mbm bw change!\n");
 	}
=20
+	if (mba_test) {
+		printf("\nMBA Schemata Change Starting..\n");
+		if (!has_ben)
+			sprintf(benchmark_cmd[1], "%d", span);
+		res =3D mba_schemata_change(core_id, bw_report, benchmark_cmd);
+		if (res)
+			printf("Error in tests for mba-change-schemata!\n");
+	}
+
 	return 0;
 }
--=20
1.8.3.1

