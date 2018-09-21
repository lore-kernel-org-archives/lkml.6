Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BAC8ECE567
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 17:15:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FBE721547
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 17:15:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="N56EwIsu";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="Gk0wq2km"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FBE721547
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390976AbeIUXE1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 19:04:27 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:51504 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390742AbeIUXEZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 19:04:25 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8LHCFBv023216;
        Fri, 21 Sep 2018 10:14:16 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=NL7Vnp1gpPSTqWAAR8K7CsVTv0QC9SGXnI6DMH+FfCE=;
 b=N56EwIsucZF1fCFmYrAeMvEcTNS6qCl5DhDRK1XvOGSFZ2gmTTw78CLwTZUg+Kz1tnpj
 YBx0pclNNYuLCIytO1awxNvbrX7ViGBrjOPL15FEQ4v0clvDdraPe4g6I89W16x5YNUP
 5hksJBAywGZfAp9iVQh5gWNn5b6vCabe7JQ= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2mn2g88emk-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 21 Sep 2018 10:14:16 -0700
Received: from NAM05-BY2-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.15) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Fri, 21 Sep 2018 10:14:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NL7Vnp1gpPSTqWAAR8K7CsVTv0QC9SGXnI6DMH+FfCE=;
 b=Gk0wq2kmMuYmEeg3ktq/425AScRQZV++TaExRma+IB7/6rlZCsL+C/y9SA1Q6t6uEap1xUW28thNa5ZbMU63bYie01s3uQsCeAPspXPDnitAbnOBzCjHxfRdpdxHtfbIFtLO6JrbhbM9s0lCSREuRbzslqBoRC0mWi+1O8PDymU=
Received: from BY2PR15MB0167.namprd15.prod.outlook.com (10.163.64.141) by
 BY2PR15MB0327.namprd15.prod.outlook.com (10.163.65.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.14; Fri, 21 Sep 2018 17:14:14 +0000
Received: from BY2PR15MB0167.namprd15.prod.outlook.com
 ([fe80::5c5b:75ea:cae:1e68]) by BY2PR15MB0167.namprd15.prod.outlook.com
 ([fe80::5c5b:75ea:cae:1e68%2]) with mapi id 15.20.1143.017; Fri, 21 Sep 2018
 17:14:14 +0000
From:   Roman Gushchin <guro@fb.com>
To:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>, Roman Gushchin <guro@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>
Subject: [PATCH bpf-next 7/9] selftests/bpf: add verifier per-cpu cgroup
 storage tests
Thread-Topic: [PATCH bpf-next 7/9] selftests/bpf: add verifier per-cpu cgroup
 storage tests
Thread-Index: AQHUUc6FMM/vGxn/mk6IVU/0VYXOxw==
Date:   Fri, 21 Sep 2018 17:14:14 +0000
Message-ID: <20180921171353.11050-7-guro@fb.com>
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
x-microsoft-exchange-diagnostics: 1;BY2PR15MB0327;20:XreyYXM09CT29/IxrppFIWTXrm+7NyIzhBB8N7omnYBk6TS1fCJWoErQVxoCeVY5c9eZxTvqBm/AWBG5Uf5PQ6a4jerWeuo70a/hgsJGZBVFoOOKZPgTLxB8AgEYXo9clNsdfS3soKLnSBu9JimM6j0g1K8iKTm8EtWnKlhZSxU=
x-ms-office365-filtering-correlation-id: 15f2ba76-2f45-4f99-e52a-08d61fe5a755
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BY2PR15MB0327;
x-ms-traffictypediagnostic: BY2PR15MB0327:
x-microsoft-antispam-prvs: <BY2PR15MB0327096EABC68530C3391E56BE120@BY2PR15MB0327.namprd15.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(67672495146484);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231355)(11241501184)(944501410)(52105095)(10201501046)(93006095)(93001095)(149027)(150027)(6041310)(20161123562045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(201708071742011)(7699051)(76991041);SRVR:BY2PR15MB0327;BCL:0;PCL:0;RULEID:;SRVR:BY2PR15MB0327;
x-forefront-prvs: 0802ADD973
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(136003)(396003)(346002)(366004)(39860400002)(189003)(199004)(1730700003)(2616005)(446003)(186003)(36756003)(5250100002)(256004)(68736007)(54906003)(6486002)(53936002)(81166006)(5640700003)(81156014)(8676002)(6512007)(8936002)(305945005)(105586002)(386003)(6916009)(2501003)(106356001)(316002)(7736002)(1076002)(4326008)(99286004)(478600001)(46003)(6436002)(2351001)(6346003)(14444005)(2900100001)(11346002)(76176011)(52116002)(102836004)(25786009)(14454004)(2906002)(5660300001)(97736004)(6506007)(86362001)(486006)(476003)(6116002)(71190400001)(71200400001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:BY2PR15MB0327;H:BY2PR15MB0167.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: L6qPlmgGPU1JUC8jrXBUQrGstfivihPNRTyp8GohNu5nenNZatLfDK4zH20X1X7NctBezZkjuxkroVisA7im5AO+CQq5YOe+o+WC7uwotr6szDfk4ZX7y9K7Hl7poahKb1agA7GgJF26ENcRsmpi86UXgqvaBkpmMozsrIXJaq4xDSaiTn23NdrcyHJSpuvZSNA1RJvJ4tyQoTw5n2wKqOG3ATgwDSkV/W+3MMCkedO7s0GnLOLx9P2g3qlHzObZOEE88vUunns1H/macj75fup/n3jxPm5wfeK25+qhbpBd6N/TdMLLfj3KEtohIow6TIfrfq0tQhRkBGhfuF1zSTTaCL/x8bWGnf6Ub4KgZkw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 15f2ba76-2f45-4f99-e52a-08d61fe5a755
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2018 17:14:14.0681
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

This commits adds verifier tests covering per-cpu cgroup storage
functionality. There are 6 new tests, which are exactly the same
as for shared cgroup storage, but do use per-cpu cgroup storage
map.

Expected output:
  $ ./test_verifier
  #0/u add+sub+mul OK
  #0/p add+sub+mul OK
  ...
  #286/p invalid cgroup storage access 6 OK
  #287/p valid per-cpu cgroup storage access OK
  #288/p invalid per-cpu cgroup storage access 1 OK
  #289/p invalid per-cpu cgroup storage access 2 OK
  #290/p invalid per-cpu cgroup storage access 3 OK
  #291/p invalid per-cpu cgroup storage access 4 OK
  #292/p invalid per-cpu cgroup storage access 5 OK
  #293/p invalid per-cpu cgroup storage access 6 OK
  #294/p multiple registers share map_lookup_elem result OK
  ...
  #662/p mov64 src =3D=3D dst OK
  #663/p mov64 src !=3D dst OK
  Summary: 914 PASSED, 0 SKIPPED, 0 FAILED

Signed-off-by: Roman Gushchin <guro@fb.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Alexei Starovoitov <ast@kernel.org>
---
 tools/testing/selftests/bpf/test_verifier.c | 139 +++++++++++++++++++-
 1 file changed, 133 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_verifier.c b/tools/testing/se=
lftests/bpf/test_verifier.c
index 67c412d19c09..c7d25f23baf9 100644
--- a/tools/testing/selftests/bpf/test_verifier.c
+++ b/tools/testing/selftests/bpf/test_verifier.c
@@ -68,6 +68,7 @@ struct bpf_test {
 	int fixup_prog2[MAX_FIXUPS];
 	int fixup_map_in_map[MAX_FIXUPS];
 	int fixup_cgroup_storage[MAX_FIXUPS];
+	int fixup_percpu_cgroup_storage[MAX_FIXUPS];
 	const char *errstr;
 	const char *errstr_unpriv;
 	uint32_t retval;
@@ -4676,7 +4677,7 @@ static struct bpf_test tests[] =3D {
 		.prog_type =3D BPF_PROG_TYPE_CGROUP_SKB,
 	},
 	{
-		"invalid per-cgroup storage access 3",
+		"invalid cgroup storage access 3",
 		.insns =3D {
 			BPF_MOV64_IMM(BPF_REG_2, 0),
 			BPF_LD_MAP_FD(BPF_REG_1, 0),
@@ -4743,6 +4744,121 @@ static struct bpf_test tests[] =3D {
 		.errstr =3D "get_local_storage() doesn't support non-zero flags",
 		.prog_type =3D BPF_PROG_TYPE_CGROUP_SKB,
 	},
+	{
+		"valid per-cpu cgroup storage access",
+		.insns =3D {
+			BPF_MOV64_IMM(BPF_REG_2, 0),
+			BPF_LD_MAP_FD(BPF_REG_1, 0),
+			BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0,
+				     BPF_FUNC_get_local_storage),
+			BPF_LDX_MEM(BPF_W, BPF_REG_1, BPF_REG_0, 0),
+			BPF_MOV64_REG(BPF_REG_0, BPF_REG_1),
+			BPF_ALU64_IMM(BPF_AND, BPF_REG_0, 1),
+			BPF_EXIT_INSN(),
+		},
+		.fixup_percpu_cgroup_storage =3D { 1 },
+		.result =3D ACCEPT,
+		.prog_type =3D BPF_PROG_TYPE_CGROUP_SKB,
+	},
+	{
+		"invalid per-cpu cgroup storage access 1",
+		.insns =3D {
+			BPF_MOV64_IMM(BPF_REG_2, 0),
+			BPF_LD_MAP_FD(BPF_REG_1, 0),
+			BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0,
+				     BPF_FUNC_get_local_storage),
+			BPF_LDX_MEM(BPF_W, BPF_REG_1, BPF_REG_0, 0),
+			BPF_MOV64_REG(BPF_REG_0, BPF_REG_1),
+			BPF_ALU64_IMM(BPF_AND, BPF_REG_0, 1),
+			BPF_EXIT_INSN(),
+		},
+		.fixup_map1 =3D { 1 },
+		.result =3D REJECT,
+		.errstr =3D "cannot pass map_type 1 into func bpf_get_local_storage",
+		.prog_type =3D BPF_PROG_TYPE_CGROUP_SKB,
+	},
+	{
+		"invalid per-cpu cgroup storage access 2",
+		.insns =3D {
+			BPF_MOV64_IMM(BPF_REG_2, 0),
+			BPF_LD_MAP_FD(BPF_REG_1, 1),
+			BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0,
+				     BPF_FUNC_get_local_storage),
+			BPF_ALU64_IMM(BPF_AND, BPF_REG_0, 1),
+			BPF_EXIT_INSN(),
+		},
+		.result =3D REJECT,
+		.errstr =3D "fd 1 is not pointing to valid bpf_map",
+		.prog_type =3D BPF_PROG_TYPE_CGROUP_SKB,
+	},
+	{
+		"invalid per-cpu cgroup storage access 3",
+		.insns =3D {
+			BPF_MOV64_IMM(BPF_REG_2, 0),
+			BPF_LD_MAP_FD(BPF_REG_1, 0),
+			BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0,
+				     BPF_FUNC_get_local_storage),
+			BPF_LDX_MEM(BPF_W, BPF_REG_1, BPF_REG_0, 256),
+			BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 1),
+			BPF_MOV64_IMM(BPF_REG_0, 0),
+			BPF_EXIT_INSN(),
+		},
+		.fixup_percpu_cgroup_storage =3D { 1 },
+		.result =3D REJECT,
+		.errstr =3D "invalid access to map value, value_size=3D64 off=3D256 size=
=3D4",
+		.prog_type =3D BPF_PROG_TYPE_CGROUP_SKB,
+	},
+	{
+		"invalid per-cpu cgroup storage access 4",
+		.insns =3D {
+			BPF_MOV64_IMM(BPF_REG_2, 0),
+			BPF_LD_MAP_FD(BPF_REG_1, 0),
+			BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0,
+				     BPF_FUNC_get_local_storage),
+			BPF_LDX_MEM(BPF_W, BPF_REG_1, BPF_REG_0, -2),
+			BPF_MOV64_REG(BPF_REG_0, BPF_REG_1),
+			BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 1),
+			BPF_EXIT_INSN(),
+		},
+		.fixup_cgroup_storage =3D { 1 },
+		.result =3D REJECT,
+		.errstr =3D "invalid access to map value, value_size=3D64 off=3D-2 size=
=3D4",
+		.prog_type =3D BPF_PROG_TYPE_CGROUP_SKB,
+	},
+	{
+		"invalid per-cpu cgroup storage access 5",
+		.insns =3D {
+			BPF_MOV64_IMM(BPF_REG_2, 7),
+			BPF_LD_MAP_FD(BPF_REG_1, 0),
+			BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0,
+				     BPF_FUNC_get_local_storage),
+			BPF_LDX_MEM(BPF_W, BPF_REG_1, BPF_REG_0, 0),
+			BPF_MOV64_REG(BPF_REG_0, BPF_REG_1),
+			BPF_ALU64_IMM(BPF_AND, BPF_REG_0, 1),
+			BPF_EXIT_INSN(),
+		},
+		.fixup_percpu_cgroup_storage =3D { 1 },
+		.result =3D REJECT,
+		.errstr =3D "get_local_storage() doesn't support non-zero flags",
+		.prog_type =3D BPF_PROG_TYPE_CGROUP_SKB,
+	},
+	{
+		"invalid per-cpu cgroup storage access 6",
+		.insns =3D {
+			BPF_MOV64_REG(BPF_REG_2, BPF_REG_1),
+			BPF_LD_MAP_FD(BPF_REG_1, 0),
+			BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0,
+				     BPF_FUNC_get_local_storage),
+			BPF_LDX_MEM(BPF_W, BPF_REG_1, BPF_REG_0, 0),
+			BPF_MOV64_REG(BPF_REG_0, BPF_REG_1),
+			BPF_ALU64_IMM(BPF_AND, BPF_REG_0, 1),
+			BPF_EXIT_INSN(),
+		},
+		.fixup_percpu_cgroup_storage =3D { 1 },
+		.result =3D REJECT,
+		.errstr =3D "get_local_storage() doesn't support non-zero flags",
+		.prog_type =3D BPF_PROG_TYPE_CGROUP_SKB,
+	},
 	{
 		"multiple registers share map_lookup_elem result",
 		.insns =3D {
@@ -12615,15 +12731,17 @@ static int create_map_in_map(void)
 	return outer_map_fd;
 }
=20
-static int create_cgroup_storage(void)
+static int create_cgroup_storage(bool percpu)
 {
+	enum bpf_map_type type =3D percpu ? BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE :
+		BPF_MAP_TYPE_CGROUP_STORAGE;
 	int fd;
=20
-	fd =3D bpf_create_map(BPF_MAP_TYPE_CGROUP_STORAGE,
-			    sizeof(struct bpf_cgroup_storage_key),
+	fd =3D bpf_create_map(type, sizeof(struct bpf_cgroup_storage_key),
 			    TEST_DATA_LEN, 0, 0);
 	if (fd < 0)
-		printf("Failed to create array '%s'!\n", strerror(errno));
+		printf("Failed to create cgroup storage '%s'!\n",
+		       strerror(errno));
=20
 	return fd;
 }
@@ -12641,6 +12759,7 @@ static void do_test_fixup(struct bpf_test *test, st=
ruct bpf_insn *prog,
 	int *fixup_prog2 =3D test->fixup_prog2;
 	int *fixup_map_in_map =3D test->fixup_map_in_map;
 	int *fixup_cgroup_storage =3D test->fixup_cgroup_storage;
+	int *fixup_percpu_cgroup_storage =3D test->fixup_percpu_cgroup_storage;
=20
 	if (test->fill_helper)
 		test->fill_helper(test);
@@ -12710,12 +12829,20 @@ static void do_test_fixup(struct bpf_test *test, =
struct bpf_insn *prog,
 	}
=20
 	if (*fixup_cgroup_storage) {
-		map_fds[7] =3D create_cgroup_storage();
+		map_fds[7] =3D create_cgroup_storage(false);
 		do {
 			prog[*fixup_cgroup_storage].imm =3D map_fds[7];
 			fixup_cgroup_storage++;
 		} while (*fixup_cgroup_storage);
 	}
+
+	if (*fixup_percpu_cgroup_storage) {
+		map_fds[8] =3D create_cgroup_storage(true);
+		do {
+			prog[*fixup_percpu_cgroup_storage].imm =3D map_fds[8];
+			fixup_percpu_cgroup_storage++;
+		} while (*fixup_percpu_cgroup_storage);
+	}
 }
=20
 static void do_test_single(struct bpf_test *test, bool unpriv,
--=20
2.17.1

