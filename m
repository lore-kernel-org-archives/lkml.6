Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACC03C5AC81
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 18:27:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70AC72087E
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 18:27:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="NP4xfuds"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728970AbfARS1N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 13:27:13 -0500
Received: from mail-eopbgr700066.outbound.protection.outlook.com ([40.107.70.66]:43360
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728956AbfARS1L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 13:27:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2tbpZJ3CcEwMF/P3Tx95AdtA5OI0LW6cm2lH6AoroVU=;
 b=NP4xfudsGoy1ZNZ85//xs3V2zJYcRr+jpYxUENE41QONa0QEiucjHRLmEsDCeR27nP8MB3ygZP88EB5C0PJqUlazggLSrnJ8vGgTw68SAt0gyIyIaykvUWD25ff93aJVTlbtMx0qPELullbUzmiCPquq2l9CQfXFwhtgyKoIRAY=
Received: from DM5PR12MB2471.namprd12.prod.outlook.com (52.132.141.138) by
 DM5PR12MB2376.namprd12.prod.outlook.com (52.132.141.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1537.24; Fri, 18 Jan 2019 18:27:05 +0000
Received: from DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::9dfd:2b7b:1999:aff2]) by DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::9dfd:2b7b:1999:aff2%2]) with mapi id 15.20.1537.018; Fri, 18 Jan 2019
 18:27:05 +0000
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
Subject: [PATCH v5 03/13] selftests/resctrl: Read memory bandwidth from perf
 IMC counter and from resctrl file system
Thread-Topic: [PATCH v5 03/13] selftests/resctrl: Read memory bandwidth from
 perf IMC counter and from resctrl file system
Thread-Index: AQHUr1tpjr0DJKuKKUKfYlfzuM+Zmw==
Date:   Fri, 18 Jan 2019 18:27:05 +0000
Message-ID: <20190118182646.16594-4-babu.moger@amd.com>
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
x-microsoft-exchange-diagnostics: 1;DM5PR12MB2376;20:ThBng5M6O31WP1uHQCG9dYCcds531VQN4DoXayuShdNkbIJv8lXJYFWHWWwCHTN+gZ+DT9i7q5amQk+vPfgHYzDsH6WEjQgHAujOOryPjnC5UQTZcH6DwZFfvEnazDorUatm4Nz2g7P/xK2qOIxDQq+PjD1bG96r6W4KpE4Jq7LNPFjTz28hea4EE//lgMU6WKrUVGsAg4YdrnfvQknJEkpfcdZ9Fo3dfx4rf2guSVB24DwKbEb2xM/6usi4Md+Q
x-ms-office365-filtering-correlation-id: 9fff7c5a-e01b-4291-f674-08d67d728c48
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600109)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DM5PR12MB2376;
x-ms-traffictypediagnostic: DM5PR12MB2376:
x-microsoft-antispam-prvs: <DM5PR12MB237631919AE1D45EF665F199959C0@DM5PR12MB2376.namprd12.prod.outlook.com>
x-forefront-prvs: 0921D55E4F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(39860400002)(136003)(396003)(346002)(366004)(189003)(199004)(1076003)(25786009)(26005)(52116002)(4326008)(186003)(102836004)(2201001)(6506007)(76176011)(72206003)(86362001)(386003)(3846002)(71200400001)(71190400001)(256004)(14444005)(6486002)(54906003)(99286004)(305945005)(110136005)(6436002)(7736002)(486006)(6512007)(316002)(2616005)(446003)(2906002)(97736004)(476003)(11346002)(478600001)(7416002)(105586002)(53936002)(106356001)(81166006)(8936002)(8676002)(5660300001)(36756003)(68736007)(66066001)(6116002)(50226002)(14454004)(2501003)(81156014)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB2376;H:DM5PR12MB2471.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: YIb54COCITFTpyfGx6FPtR0GZNM7iInMCH+4OhRq4cwytdSUhECjA8MtOnSRfei5EhUCloCl+XEhQX1Tz9W11J38mQKQfedOCkl2dWDR0IR0eEMXfrpC2oM8pU1ucq/UQRPsUbX1dEkwCEiySfABUzOgeYkr1IoXbZMyyWPmisgMSY5hcgRoHkoWIB/EM1Ra4VT1E+uzjv/OodFoYiCjtGIeza0iBKa7khMm9oH1UJ76o0iCAS/qapo4WkTiKU3dnFouP7qolmNITIoYRoP5fZP1sht0M8yS0f1CCcBDRUp1mn3xL8WHrXsJ7RIVyJiIeAHVbgGcEMoP8gWL0y5GmgGgZQohvaA4Qr23CwE2fKlaDVK9/3MQ1H+vLM1Fruvdhe1qRcss+QFfM1AuICQ58KKLAlazbz+qN8zdxLo/lf8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fff7c5a-e01b-4291-f674-08d67d728c48
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jan 2019 18:27:04.4714
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2376
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>

Total memory bandwidth can be monitored from perf IMC counter and from
resctrl file system. Later the two will be compared to verify the total
memory bandwidth read from resctrl is correct.

Signed-off-by: Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
Signed-off-by: Arshiya Hayatkhan Pathan <arshiya.hayatkhan.pathan@intel.com=
>
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Babu Moger <babu.moger@amd.com>
---
 tools/testing/selftests/resctrl/resctrl_val.c | 118 ++++++++++++++++++++++=
++++
 1 file changed, 118 insertions(+)
 create mode 100644 tools/testing/selftests/resctrl/resctrl_val.c

diff --git a/tools/testing/selftests/resctrl/resctrl_val.c b/tools/testing/=
selftests/resctrl/resctrl_val.c
new file mode 100644
index 0000000..12301ac
--- /dev/null
+++ b/tools/testing/selftests/resctrl/resctrl_val.c
@@ -0,0 +1,118 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Memory bandwidth monitoring and allocation library
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
+#define UNCORE_IMC		"uncore_imc"
+#define READ_FILE_NAME		"events/cas_count_read"
+#define WRITE_FILE_NAME		"events/cas_count_write"
+#define DYN_PMU_PATH		"/sys/bus/event_source/devices"
+#define SCALE			0.00006103515625
+#define MAX_IMCS		20
+#define MAX_TOKENS		5
+#define READ			0
+#define WRITE			1
+#define CON_MON_MBM_LOCAL_BYTES_PATH				\
+	"%s/%s/mon_groups/%s/mon_data/mon_L3_%02d/mbm_local_bytes"
+
+#define CON_MBM_LOCAL_BYTES_PATH		\
+	"%s/%s/mon_data/mon_L3_%02d/mbm_local_bytes"
+
+#define MON_MBM_LOCAL_BYTES_PATH		\
+	"%s/mon_groups/%s/mon_data/mon_L3_%02d/mbm_local_bytes"
+
+#define MBM_LOCAL_BYTES_PATH			\
+	"%s/mon_data/mon_L3_%02d/mbm_local_bytes"
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
+static struct imc_counter_config imc_counters_config[MAX_IMCS][2];
+
+void membw_initialize_perf_event_attr(int i, int j)
+{
+	memset(&imc_counters_config[i][j].pe, 0,
+	       sizeof(struct perf_event_attr));
+	imc_counters_config[i][j].pe.type =3D imc_counters_config[i][j].type;
+	imc_counters_config[i][j].pe.size =3D sizeof(struct perf_event_attr);
+	imc_counters_config[i][j].pe.disabled =3D 1;
+	imc_counters_config[i][j].pe.inherit =3D 1;
+	imc_counters_config[i][j].pe.exclude_guest =3D 1;
+	imc_counters_config[i][j].pe.config =3D
+		imc_counters_config[i][j].umask << 8 |
+		imc_counters_config[i][j].event;
+	imc_counters_config[i][j].pe.sample_type =3D PERF_SAMPLE_IDENTIFIER;
+	imc_counters_config[i][j].pe.read_format =3D
+		PERF_FORMAT_TOTAL_TIME_ENABLED | PERF_FORMAT_TOTAL_TIME_RUNNING;
+}
+
+void membw_ioctl_perf_event_ioc_reset_enable(int i, int j)
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
+	char *token[MAX_TOKENS];
+	int i =3D 0;
+
+	strcat(cas_count_cfg, ",");
+	token[0] =3D strtok(cas_count_cfg, "=3D,");
+
+	for (i =3D 1; i < MAX_TOKENS; i++)
+		token[i] =3D strtok(NULL, "=3D,");
+
+	for (i =3D 0; i < MAX_TOKENS; i++) {
+		if (!token[i])
+			break;
+		if (strcmp(token[i], "event") =3D=3D 0) {
+			if (op =3D=3D READ)
+				imc_counters_config[count][READ].event =3D
+				strtol(token[i + 1], NULL, 16);
+			else
+				imc_counters_config[count][WRITE].event =3D
+				strtol(token[i + 1], NULL, 16);
+		}
+		if (strcmp(token[i], "umask") =3D=3D 0) {
+			if (op =3D=3D READ)
+				imc_counters_config[count][READ].umask =3D
+				strtol(token[i + 1], NULL, 16);
+			else
+				imc_counters_config[count][WRITE].umask =3D
+				strtol(token[i + 1], NULL, 16);
+		}
+	}
+}
+
--=20
1.8.3.1

