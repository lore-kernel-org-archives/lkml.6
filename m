Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEB25C04AB8
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 17:14:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6681421547
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 17:14:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="E7zMCJau";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="RT4i4Do7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6681421547
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391059AbeIUXEa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 19:04:30 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:53718 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390742AbeIUXE3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 19:04:29 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8LH9hCQ006465;
        Fri, 21 Sep 2018 10:14:18 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=65nDd265B3og0ySkpewzO/5yPZAevFnyPDvt38uRYOQ=;
 b=E7zMCJauovn7VpKiwdW5dMq/3q227yQc1dwXGvU0E4gUgwPMycfJ6emMF5InjamtBwdi
 x/byipdPiaiV71ktJW48UzPtORyQ288UFJfubIFybH1hSWy979uwxwNemvMgEAD7sLgy
 yukQ8dm+/RFt5Qjwi1S2av/f8JwvnUc7riY= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2mn1w3gkx4-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 21 Sep 2018 10:14:18 -0700
Received: from NAM05-BY2-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.31) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Fri, 21 Sep 2018 13:14:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=65nDd265B3og0ySkpewzO/5yPZAevFnyPDvt38uRYOQ=;
 b=RT4i4Do7yEaOY5bk9n+z1zgjDQF7SOuWoxcMkTKnYdopUTcy3eiTzy2BiHiA4umYX+FO8x2afA6Dgk+JZ3MV3O/IJH7zdAx5xPgoJ7Qi5Jvo/+CaFoEwLLAvAk5Fh7LYPGBMjCeybJj/Mj5OQlusX9NAU1WIZC5+dqq1k1Ib5w0=
Received: from BY2PR15MB0167.namprd15.prod.outlook.com (10.163.64.141) by
 BY2PR15MB0327.namprd15.prod.outlook.com (10.163.65.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.14; Fri, 21 Sep 2018 17:14:15 +0000
Received: from BY2PR15MB0167.namprd15.prod.outlook.com
 ([fe80::5c5b:75ea:cae:1e68]) by BY2PR15MB0167.namprd15.prod.outlook.com
 ([fe80::5c5b:75ea:cae:1e68%2]) with mapi id 15.20.1143.017; Fri, 21 Sep 2018
 17:14:15 +0000
From:   Roman Gushchin <guro@fb.com>
To:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>, Roman Gushchin <guro@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>
Subject: [PATCH bpf-next 8/9] selftests/bpf: extend the storage test to test
 per-cpu cgroup storage
Thread-Topic: [PATCH bpf-next 8/9] selftests/bpf: extend the storage test to
 test per-cpu cgroup storage
Thread-Index: AQHUUc6FR/466CXwcEyrmeNcCbDYsw==
Date:   Fri, 21 Sep 2018 17:14:15 +0000
Message-ID: <20180921171353.11050-8-guro@fb.com>
References: <20180921171353.11050-1-guro@fb.com>
In-Reply-To: <20180921171353.11050-1-guro@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR10CA0052.namprd10.prod.outlook.com
 (2603:10b6:300:2c::14) To BY2PR15MB0167.namprd15.prod.outlook.com
 (2a01:111:e400:58e0::13)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::7:15ea]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BY2PR15MB0327;20:rwMmsTVBgQzpdZthphVlN47tIR7/82AvxcrgX2yqgJvotxZZfwAmE4vaiWN7nHFQgiFM2w/7v73qJuW1EZqbQ+pUw4I3BcKVkjmHSJNYHRBtMaAXt+NTuP1/qITbju8ahm3TeEAOfFyXFCAD6wO2+/DHlTRdPcTYi1gDpdTWF2U=
x-ms-office365-filtering-correlation-id: 1b12a2a7-59e0-43f5-69d9-08d61fe5a7fa
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BY2PR15MB0327;
x-ms-traffictypediagnostic: BY2PR15MB0327:
x-microsoft-antispam-prvs: <BY2PR15MB0327350B6C4BE974FC02FCAABE120@BY2PR15MB0327.namprd15.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(67672495146484);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231355)(11241501184)(944501410)(52105095)(10201501046)(93006095)(93001095)(149027)(150027)(6041310)(20161123562045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(201708071742011)(7699051)(76991041);SRVR:BY2PR15MB0327;BCL:0;PCL:0;RULEID:;SRVR:BY2PR15MB0327;
x-forefront-prvs: 0802ADD973
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(136003)(396003)(346002)(366004)(39860400002)(189003)(199004)(1730700003)(2616005)(446003)(186003)(36756003)(5250100002)(551984002)(256004)(68736007)(54906003)(6486002)(53936002)(81166006)(5640700003)(81156014)(8676002)(6512007)(8936002)(305945005)(105586002)(386003)(6916009)(2501003)(106356001)(316002)(7736002)(1076002)(4326008)(99286004)(478600001)(46003)(6436002)(2351001)(6346003)(14444005)(2900100001)(11346002)(76176011)(52116002)(102836004)(25786009)(14454004)(2906002)(5660300001)(97736004)(6506007)(86362001)(486006)(476003)(6116002)(71190400001)(71200400001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:BY2PR15MB0327;H:BY2PR15MB0167.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: DOUXPkYNhHd1UiIN2jfF/sBpfWNfHci6H/KAnSiVcqj4Yqj+fm7wyJSE33hkx+Vl+QNPDQ9GuthTVyLfpVJBLJOaCK90lb2shAb/FhAcBjFXFF9t7cYMTZpSAaSnuiFV5upizJn8KnjIf3wxXHs8x1QEd0dMzo6OQ5telGOjlyL2yjgfAKWeKbH1PLeJlrhCIkNYiuJgLOF8X/nKE4M0zPVN5De+h/7G7tXWqnQHlom86FZrOcRirxleKlA5wLqn/wcHGaHS4/0fiW2GxeZCXIfFzuFzMXtjz0U2g/IJqFoNNZoyePWLm+cce3VsAAJsvJLrzL66sxP86/YKONj323z6W7wbFwpUZC8jYUJy0cU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b12a2a7-59e0-43f5-69d9-08d61fe5a7fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2018 17:14:15.1463
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR15MB0327
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-21_07:,,
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
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Alexei Starovoitov <ast@kernel.org>
---
 .../selftests/bpf/test_cgroup_storage.c       | 59 ++++++++++++++++++-
 1 file changed, 56 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_cgroup_storage.c b/tools/test=
ing/selftests/bpf/test_cgroup_storage.c
index 4e196e3bfecf..3dfc3773c790 100644
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
@@ -120,6 +154,25 @@ int main(int argc, char **argv)
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
--=20
2.17.1

