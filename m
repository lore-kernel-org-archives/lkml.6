Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80017C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 14:46:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3010F20666
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 14:46:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="gEX7O9Tn";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="NECak69x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3010F20666
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729608AbeI1VKo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 17:10:44 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:37816 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729517AbeI1VKn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 17:10:43 -0400
Received: from pps.filterd (m0001255.ppops.net [127.0.0.1])
        by mx0b-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8SEbK9d025845;
        Fri, 28 Sep 2018 07:46:14 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=GJ+rX9Qk1lm32z4yOGVZ5TwzOdeBco+4kSciaqtUxBg=;
 b=gEX7O9TnfYxYAwT6q34Czo1++4SRtMwVBLyPGNa0A1m/SriOP91Bj7U3w2xLxPjd55kZ
 duASSxjCg+iKiMm900ScsfEwLpdm4AmLzBjZprl8NzpEWzSQK5HMkWRsiSN9RdnyncE9
 Qyuq/4dLZ9zUhVvuaeS9Bc1iq+nPBxqRwlg= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0b-00082601.pphosted.com with ESMTP id 2msjtermrg-3
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 28 Sep 2018 07:46:14 -0700
Received: from PRN-CHUB02.TheFacebook.com (2620:10d:c081:35::11) by
 PRN-CHUB04.TheFacebook.com (2620:10d:c081:35::13) with Microsoft SMTP Server
 (TLS) id 14.3.361.1; Fri, 28 Sep 2018 07:46:12 -0700
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.12) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Fri, 28 Sep 2018 07:46:12 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GJ+rX9Qk1lm32z4yOGVZ5TwzOdeBco+4kSciaqtUxBg=;
 b=NECak69xyIDQDQVzHE4uS8qqlSqyn8ii2GdDcwS9C8oyC5c6qH1UBFue+eCvOrIo/ZX/iREJymmVCKyFmVKEEBpbHSTrLKhGN8Uoz7Hu1vs5t2Z1c7Iyflu4A+h6VeJ3osapkBW5drLL8MlJObAnJmA48tktMCZS5zddMkuWvd4=
Received: from BY2PR15MB0167.namprd15.prod.outlook.com (10.163.64.141) by
 BY2PR15MB0453.namprd15.prod.outlook.com (10.163.110.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.22; Fri, 28 Sep 2018 14:45:56 +0000
Received: from BY2PR15MB0167.namprd15.prod.outlook.com
 ([fe80::5c5b:75ea:cae:1e68]) by BY2PR15MB0167.namprd15.prod.outlook.com
 ([fe80::5c5b:75ea:cae:1e68%2]) with mapi id 15.20.1164.027; Fri, 28 Sep 2018
 14:45:56 +0000
From:   Roman Gushchin <guro@fb.com>
To:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>, Roman Gushchin <guro@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>
Subject: [PATCH v4 bpf-next 08/10] selftests/bpf: extend the storage test to
 test per-cpu cgroup storage
Thread-Topic: [PATCH v4 bpf-next 08/10] selftests/bpf: extend the storage test
 to test per-cpu cgroup storage
Thread-Index: AQHUVzn24RhrfidBh0m/sTHzzh9HAw==
Date:   Fri, 28 Sep 2018 14:45:55 +0000
Message-ID: <20180928144452.5284-9-guro@fb.com>
References: <20180928144452.5284-1-guro@fb.com>
In-Reply-To: <20180928144452.5284-1-guro@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM6PR0402CA0022.eurprd04.prod.outlook.com
 (2603:10a6:209::35) To BY2PR15MB0167.namprd15.prod.outlook.com
 (2a01:111:e400:58e0::13)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c092:180::1:8a29]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BY2PR15MB0453;20:sZdFfW7GmdvPwZnWqeIklJb3CLPhG1n7xO88mTJ9HU78/OnFehX0L5etrecRWmWpHJV3gnNnXMz/tl6qJHVSMpXME2hVexJF4unALPUNrkd5Ar5P7pdNeHtcYV7ofWJsv60buzZjmiXtFWd9dkdYI1UwUrZcFweVsp4GyFy8iQU=
x-ms-office365-filtering-correlation-id: 3586aace-8428-4deb-54e9-08d62551189e
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BY2PR15MB0453;
x-ms-traffictypediagnostic: BY2PR15MB0453:
x-microsoft-antispam-prvs: <BY2PR15MB0453549D5949E91926441BA7BEEC0@BY2PR15MB0453.namprd15.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(67672495146484);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231355)(11241501184)(944501410)(52105095)(10201501046)(93006095)(93001095)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123560045)(20161123558120)(201708071742011)(7699051)(76991041);SRVR:BY2PR15MB0453;BCL:0;PCL:0;RULEID:;SRVR:BY2PR15MB0453;
x-forefront-prvs: 0809C12563
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(346002)(366004)(136003)(39860400002)(199004)(189003)(478600001)(34290500001)(1076002)(476003)(7736002)(4326008)(25786009)(5250100002)(36756003)(6116002)(551984002)(68736007)(305945005)(446003)(2501003)(46003)(5660300001)(14454004)(54906003)(486006)(99286004)(86362001)(316002)(53936002)(52116002)(6436002)(105586002)(2900100001)(6486002)(76176011)(14444005)(256004)(6916009)(1730700003)(102836004)(8936002)(71190400001)(106356001)(6512007)(97736004)(2616005)(2351001)(81166006)(11346002)(81156014)(2906002)(71200400001)(5640700003)(8676002)(186003)(6506007)(386003)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:BY2PR15MB0453;H:BY2PR15MB0167.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: kzXL6NGC7fnDm8qj+//1A3B9FQUus1lSWL7YJcOmeVZ9UhTUUOx7a0E6E30f7g6DnioTAlvdcLt+gqneZgdGFSJeXVuhy8IXBD4pLwoliPZnjvimE8QOLQbFqE7Ojrsd5oVtXJy8iLeboGi2TnIVyId1gAJopUyPIpazRsly0168tmOelrloF2dDUBr/ZjFupVYBvA50qW5YtC7WhF8w8VrGO8b++oUbepqRYNs8m9cW3+EB6vUpFhjL0jXekz/YMhsaKqk89hBygZ4zsc2aIAimN+MQHZwnV2deA3wSuiAhCLwgN+Pjmn/U5+MpX43/SqAwYpKmgWWxh92r3AnUzBF++lcVmIca4X54+b040uQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 3586aace-8428-4deb-54e9-08d62551189e
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2018 14:45:56.0716
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR15MB0453
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-28_06:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This test extends the cgroup storage test to use per-cpu flavor
of the cgroup storage as well.

The test initializes a per-cpu cgroup storage to some non-zero initial
value (1000), and then simple bumps a per-cpu counter each time
the shared counter is atomically incremented. Then it reads all
per-cpu areas from the userspace side, and checks that the sum
of values adds to the expected sum.

Expected output:
  $ ./test_cgroup_storage
  test_cgroup_storage:PASS

Signed-off-by: Roman Gushchin <guro@fb.com>
Acked-by: Song Liu <songliubraving@fb.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Alexei Starovoitov <ast@kernel.org>
---
 .../selftests/bpf/test_cgroup_storage.c       | 60 ++++++++++++++++++-
 1 file changed, 57 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_cgroup_storage.c b/tools/test=
ing/selftests/bpf/test_cgroup_storage.c
index 4e196e3bfecf..f44834155f25 100644
--- a/tools/testing/selftests/bpf/test_cgroup_storage.c
+++ b/tools/testing/selftests/bpf/test_cgroup_storage.c
@@ -4,6 +4,7 @@
 #include <linux/filter.h>
 #include <stdio.h>
 #include <stdlib.h>
+#include <sys/sysinfo.h>
=20
 #include "bpf_rlimit.h"
 #include "cgroup_helpers.h"
@@ -15,6 +16,14 @@ char bpf_log_buf[BPF_LOG_BUF_SIZE];
 int main(int argc, char **argv)
 {
 	struct bpf_insn prog[] =3D {
+		BPF_LD_MAP_FD(BPF_REG_1, 0), /* percpu map fd */
+		BPF_MOV64_IMM(BPF_REG_2, 0), /* flags, not used */
+		BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0,
+			     BPF_FUNC_get_local_storage),
+		BPF_LDX_MEM(BPF_W, BPF_REG_3, BPF_REG_0, 0),
+		BPF_ALU64_IMM(BPF_ADD, BPF_REG_3, 0x1),
+		BPF_STX_MEM(BPF_W, BPF_REG_0, BPF_REG_3, 0),
+
 		BPF_LD_MAP_FD(BPF_REG_1, 0), /* map fd */
 		BPF_MOV64_IMM(BPF_REG_2, 0), /* flags, not used */
 		BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0,
@@ -28,9 +37,18 @@ int main(int argc, char **argv)
 	};
 	size_t insns_cnt =3D sizeof(prog) / sizeof(struct bpf_insn);
 	int error =3D EXIT_FAILURE;
-	int map_fd, prog_fd, cgroup_fd;
+	int map_fd, percpu_map_fd, prog_fd, cgroup_fd;
 	struct bpf_cgroup_storage_key key;
 	unsigned long long value;
+	unsigned long long *percpu_value;
+	int cpu, nproc;
+
+	nproc =3D get_nprocs_conf();
+	percpu_value =3D malloc(sizeof(*percpu_value) * nproc);
+	if (!percpu_value) {
+		printf("Not enough memory for per-cpu area (%d cpus)\n", nproc);
+		goto err;
+	}
=20
 	map_fd =3D bpf_create_map(BPF_MAP_TYPE_CGROUP_STORAGE, sizeof(key),
 				sizeof(value), 0, 0);
@@ -39,7 +57,15 @@ int main(int argc, char **argv)
 		goto out;
 	}
=20
-	prog[0].imm =3D map_fd;
+	percpu_map_fd =3D bpf_create_map(BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE,
+				       sizeof(key), sizeof(value), 0, 0);
+	if (percpu_map_fd < 0) {
+		printf("Failed to create map: %s\n", strerror(errno));
+		goto out;
+	}
+
+	prog[0].imm =3D percpu_map_fd;
+	prog[7].imm =3D map_fd;
 	prog_fd =3D bpf_load_program(BPF_PROG_TYPE_CGROUP_SKB,
 				   prog, insns_cnt, "GPL", 0,
 				   bpf_log_buf, BPF_LOG_BUF_SIZE);
@@ -77,7 +103,15 @@ int main(int argc, char **argv)
 	}
=20
 	if (bpf_map_lookup_elem(map_fd, &key, &value)) {
-		printf("Failed to lookup cgroup storage\n");
+		printf("Failed to lookup cgroup storage 0\n");
+		goto err;
+	}
+
+	for (cpu =3D 0; cpu < nproc; cpu++)
+		percpu_value[cpu] =3D 1000;
+
+	if (bpf_map_update_elem(percpu_map_fd, &key, percpu_value, 0)) {
+		printf("Failed to update the data in the cgroup storage\n");
 		goto err;
 	}
=20
@@ -120,11 +154,31 @@ int main(int argc, char **argv)
 		goto err;
 	}
=20
+	/* Check the final value of the counter in the percpu local storage */
+
+	for (cpu =3D 0; cpu < nproc; cpu++)
+		percpu_value[cpu] =3D 0;
+
+	if (bpf_map_lookup_elem(percpu_map_fd, &key, percpu_value)) {
+		printf("Failed to lookup the per-cpu cgroup storage\n");
+		goto err;
+	}
+
+	value =3D 0;
+	for (cpu =3D 0; cpu < nproc; cpu++)
+		value +=3D percpu_value[cpu];
+
+	if (value !=3D nproc * 1000 + 6) {
+		printf("Unexpected data in the per-cpu cgroup storage\n");
+		goto err;
+	}
+
 	error =3D 0;
 	printf("test_cgroup_storage:PASS\n");
=20
 err:
 	cleanup_cgroup_environment();
+	free(percpu_value);
=20
 out:
 	return error;
--=20
2.17.1

