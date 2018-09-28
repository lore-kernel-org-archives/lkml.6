Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30B2AC43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 14:47:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBEC420666
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 14:47:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="fOIqeADG";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="NMdQeWBo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBEC420666
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729566AbeI1VKl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 17:10:41 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:52606 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729517AbeI1VKl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 17:10:41 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8SEhb6a016859;
        Fri, 28 Sep 2018 07:46:12 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=8Y5plI1n6bn+3ezEACPbquDqgVNiVazUZ77vBb/Q9go=;
 b=fOIqeADGFTeitOZ2rG5+g1xb7OsARpIUOU9kyp4jm7qJZzlIzvtqYYcGnPuif13iEoc0
 EKsv8lMIGw0Cg1mT2flpH9SHfWErFTl15wqcbhvfZ6mBigPdnv+s5xiVRuf8YFeUNDKN
 1cWhZyF4JM1Vs6dI1KQ2UQEjj9EMSZhY45I= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2msj270u92-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 28 Sep 2018 07:46:12 -0700
Received: from PRN-CHUB02.TheFacebook.com (2620:10d:c081:35::11) by
 PRN-CHUB06.TheFacebook.com (2620:10d:c081:35::15) with Microsoft SMTP Server
 (TLS) id 14.3.361.1; Fri, 28 Sep 2018 07:46:11 -0700
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.12) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Fri, 28 Sep 2018 07:46:11 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Y5plI1n6bn+3ezEACPbquDqgVNiVazUZ77vBb/Q9go=;
 b=NMdQeWBo9iTigVS5kMmzuOTWOoZOYVOsJe+0bzxAuJNpxto/+20hoh3raNpDt529f3pEDtSOlgl+6X6qQmHod1Wvag1uAAz44TQGEmzPqDUpddkRhu3OWAy1uAq0t4vzJ7Ni2fxALyi0MoepR9qpcPoavFNBq7nHhWpY+6svYNo=
Received: from BY2PR15MB0167.namprd15.prod.outlook.com (10.163.64.141) by
 BY2PR15MB0453.namprd15.prod.outlook.com (10.163.110.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.22; Fri, 28 Sep 2018 14:45:53 +0000
Received: from BY2PR15MB0167.namprd15.prod.outlook.com
 ([fe80::5c5b:75ea:cae:1e68]) by BY2PR15MB0167.namprd15.prod.outlook.com
 ([fe80::5c5b:75ea:cae:1e68%2]) with mapi id 15.20.1164.027; Fri, 28 Sep 2018
 14:45:53 +0000
From:   Roman Gushchin <guro@fb.com>
To:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>, Roman Gushchin <guro@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>
Subject: [PATCH v4 bpf-next 07/10] selftests/bpf: add verifier per-cpu cgroup
 storage tests
Thread-Topic: [PATCH v4 bpf-next 07/10] selftests/bpf: add verifier per-cpu
 cgroup storage tests
Thread-Index: AQHUVzn0sUiY6C4fa0i7Bcw4vD5Tzg==
Date:   Fri, 28 Sep 2018 14:45:53 +0000
Message-ID: <20180928144452.5284-8-guro@fb.com>
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
x-microsoft-exchange-diagnostics: 1;BY2PR15MB0453;20:96CZ6krD7A5Dt8bPqQG0R+fE/WWsZQREtKBv7M0ZXuS/aheTNa1Zk1G7BAgwFjH3XWI666fL/8wzUUHG9U0JF2b0/8EYrN8eR/GoV/H/KDxwecg548uQQKZs33U6W1mAWQbrJcKGsXzhpl5BAkPRXdRJD8thDoyZxDpUWSyD7Cg=
x-ms-office365-filtering-correlation-id: 4ef7e481-3362-47d2-7053-08d625511723
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BY2PR15MB0453;
x-ms-traffictypediagnostic: BY2PR15MB0453:
x-microsoft-antispam-prvs: <BY2PR15MB0453B94DA05E02FD434985A5BEEC0@BY2PR15MB0453.namprd15.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(67672495146484);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231355)(11241501184)(944501410)(52105095)(10201501046)(93006095)(93001095)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123560045)(20161123558120)(201708071742011)(7699051)(76991041);SRVR:BY2PR15MB0453;BCL:0;PCL:0;RULEID:;SRVR:BY2PR15MB0453;
x-forefront-prvs: 0809C12563
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(346002)(366004)(136003)(39860400002)(199004)(189003)(478600001)(34290500001)(1076002)(476003)(7736002)(4326008)(25786009)(5250100002)(36756003)(6116002)(68736007)(305945005)(446003)(2501003)(46003)(5660300001)(14454004)(54906003)(486006)(99286004)(86362001)(316002)(53936002)(52116002)(6436002)(105586002)(2900100001)(6486002)(76176011)(14444005)(256004)(6916009)(1730700003)(102836004)(8936002)(71190400001)(106356001)(6512007)(97736004)(2616005)(2351001)(81166006)(11346002)(81156014)(2906002)(71200400001)(5640700003)(8676002)(186003)(6506007)(386003)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:BY2PR15MB0453;H:BY2PR15MB0167.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: r9ZmD9X0ZWhn6hSEJ5a0YEuW/Nqhy/HvDxhlf+fLJ9GPaS1fswuH70nGDKDMmEkaUrFmuNVNgwKYEdprYF597euqPEWGndAb7mRGG1FVB+ME4qPJOYwxOc3MRQcvb44rQN/b1GnrG2wC4NQ6xyUcdLrcDPu4YOJIm1/DSRsfWD7yIk6Cg0agHjzr1KIvLaaYV6ibGUiq/z3/2gYEyJGjnjd+zQD+LO/7lCYHYhGPPeLZR8Pj1fzuccEbVPwKag3lTCxbIWaXfqmM3dZgzosaZPdXAHXvQbNgwiVOhSXhlngsosgzN65pQDsoiqX4ZnsUCSUzwjiq/6sOzqTRnSl1uhEaq+LeRAO/319wzZ6qyVc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ef7e481-3362-47d2-7053-08d625511723
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2018 14:45:53.5035
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
Acked-by: Song Liu <songliubraving@fb.com>
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

