Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC4AAC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 17:15:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 716B520673
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 17:15:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="CYx6yNh2";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="jnu3uXTF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 716B520673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391146AbeIUXFG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 19:05:06 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:53692 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390869AbeIUXE0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 19:04:26 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8LH9hCR006465;
        Fri, 21 Sep 2018 10:14:18 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=irqI83Yurq4cElwuaXLqId83v0ZbRY/nsd14XqITKmY=;
 b=CYx6yNh2aDIILDiamQrrzz0aj7d9qel8l4+m5VMvUJQ5ZzXc4AUXNCP2CihDDUaufXbu
 DxNGyPTLbC9C29AFrY9NbeS5wtiC8H2XHu0RFdSkby6jq9t1AOkffBQCoEbC061XfR+T
 +qunGcPEIiquTdt3Ht5e1rHMwJ63CYUsNiU= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2mn1w3gkx4-2
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 21 Sep 2018 10:14:18 -0700
Received: from NAM05-BY2-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.31) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Fri, 21 Sep 2018 13:14:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=irqI83Yurq4cElwuaXLqId83v0ZbRY/nsd14XqITKmY=;
 b=jnu3uXTFA7GyPAdD2IhUZnVtTPd95vAkHbrtE77d/eSj8fC6XQwoY8FhdZCPA2ovfRKvlUbFS4qDkR8zVD1QFGBIf/jPKANMcFJcfshRJOfo8Mm39pgHSXqp5fUtuT0ByvicBGGmzZ+k6rgAlqv9uwhio+fneSMfZPPO2esgYZE=
Received: from BY2PR15MB0167.namprd15.prod.outlook.com (10.163.64.141) by
 BY2PR15MB0327.namprd15.prod.outlook.com (10.163.65.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.14; Fri, 21 Sep 2018 17:14:16 +0000
Received: from BY2PR15MB0167.namprd15.prod.outlook.com
 ([fe80::5c5b:75ea:cae:1e68]) by BY2PR15MB0167.namprd15.prod.outlook.com
 ([fe80::5c5b:75ea:cae:1e68%2]) with mapi id 15.20.1143.017; Fri, 21 Sep 2018
 17:14:16 +0000
From:   Roman Gushchin <guro@fb.com>
To:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>, Roman Gushchin <guro@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>
Subject: [PATCH bpf-next 9/9] samples/bpf: extend test_cgrp2_attach2 test to
 use per-cpu cgroup storage
Thread-Topic: [PATCH bpf-next 9/9] samples/bpf: extend test_cgrp2_attach2 test
 to use per-cpu cgroup storage
Thread-Index: AQHUUc6GRtW8ZJxFSECxqX91X8nQ7w==
Date:   Fri, 21 Sep 2018 17:14:16 +0000
Message-ID: <20180921171353.11050-9-guro@fb.com>
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
x-microsoft-exchange-diagnostics: 1;BY2PR15MB0327;20:XOceKNon4snrvlFEp0w654e1DaP2oqC0PA1M14zLMxQg+GKMQD+eb/lZVFZzxZx2aJ0+GEuvGdVKRj0rSsW4TpeY3EEXf19/cq2QzmLUEv4cyYYb5fD3DY3x0AzfyR11S5jYeaculD+C3IFSAlPvarbHlA3NKdJVQEVxrfcQ1iA=
x-ms-office365-filtering-correlation-id: fbc1b96b-50a4-4471-50f2-08d61fe5a8a1
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BY2PR15MB0327;
x-ms-traffictypediagnostic: BY2PR15MB0327:
x-microsoft-antispam-prvs: <BY2PR15MB032765C49C8827A46596796FBE120@BY2PR15MB0327.namprd15.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(67672495146484);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231355)(11241501184)(944501410)(52105095)(10201501046)(93006095)(93001095)(149027)(150027)(6041310)(20161123562045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(201708071742011)(7699051)(76991041);SRVR:BY2PR15MB0327;BCL:0;PCL:0;RULEID:;SRVR:BY2PR15MB0327;
x-forefront-prvs: 0802ADD973
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(136003)(396003)(346002)(366004)(39860400002)(189003)(199004)(1730700003)(2616005)(446003)(186003)(36756003)(5250100002)(256004)(68736007)(54906003)(6486002)(53936002)(5024004)(81166006)(5640700003)(81156014)(8676002)(6512007)(8936002)(15760500003)(305945005)(105586002)(386003)(6916009)(2501003)(106356001)(316002)(7736002)(1076002)(4326008)(99286004)(478600001)(46003)(6436002)(2351001)(6346003)(14444005)(2900100001)(11346002)(76176011)(52116002)(102836004)(25786009)(14454004)(2906002)(5660300001)(97736004)(6506007)(86362001)(486006)(476003)(6116002)(71190400001)(71200400001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:BY2PR15MB0327;H:BY2PR15MB0167.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: XD15+S/zMicA3Z9RBF4YKSyRq7ZKWVmDaaunadM1ctrv5GnYELDJbvUX7Y44s2A9Vl33zcicq6f/WiCXuItNGQdD+qWDwTZRiqumoNjwU6NBWc8Og0rd3zlIjTlzvzIReg0Dgk9C6rXNbMeI8Ji2hEUv2006F+7ufz4G5nBlE1D5YHcVmiqC46NQH7Ls+6QV57oRbOiTbeFAssycrfi7Udj3iM+VRw+F/vsegA127TJHG7d2Qj3o5SEM2fxvnS+2TBA8HZ/Dlp7GjqKPK8jzeKIndW59OgWTBdO5jrxN+f3LLNKeyOpE/0o+4wsZYO8YV5zJTM/HpaJGLn4UbwOS3YY2I1FzRyLF5xXTiFH054g=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: fbc1b96b-50a4-4471-50f2-08d61fe5a8a1
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2018 17:14:16.3964
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

This commit extends the test_cgrp2_attach2 test to cover per-cpu
cgroup storage. Bpf program will use shared and per-cpu cgroup
storages simultaneously, so a better coverage of corresponding
core code will be achieved.

Expected output:
  $ ./test_cgrp2_attach2
  Attached DROP prog. This ping in cgroup /foo should fail...
  ping: sendmsg: Operation not permitted
  Attached DROP prog. This ping in cgroup /foo/bar should fail...
  ping: sendmsg: Operation not permitted
  Attached PASS prog. This ping in cgroup /foo/bar should pass...
  Detached PASS from /foo/bar while DROP is attached to /foo.
  This ping in cgroup /foo/bar should fail...
  ping: sendmsg: Operation not permitted
  Attached PASS from /foo/bar and detached DROP from /foo.
  This ping in cgroup /foo/bar should pass...
  ### override:PASS
  ### multi:PASS

Signed-off-by: Roman Gushchin <guro@fb.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Alexei Starovoitov <ast@kernel.org>
---
 samples/bpf/test_cgrp2_attach2.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/samples/bpf/test_cgrp2_attach2.c b/samples/bpf/test_cgrp2_atta=
ch2.c
index 180f9d813bca..d7b68ef5ba79 100644
--- a/samples/bpf/test_cgrp2_attach2.c
+++ b/samples/bpf/test_cgrp2_attach2.c
@@ -209,7 +209,7 @@ static int map_fd =3D -1;
=20
 static int prog_load_cnt(int verdict, int val)
 {
-	int cgroup_storage_fd;
+	int cgroup_storage_fd, percpu_cgroup_storage_fd;
=20
 	if (map_fd < 0)
 		map_fd =3D bpf_create_map(BPF_MAP_TYPE_ARRAY, 4, 8, 1, 0);
@@ -225,6 +225,14 @@ static int prog_load_cnt(int verdict, int val)
 		return -1;
 	}
=20
+	percpu_cgroup_storage_fd =3D bpf_create_map(
+		BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE,
+		sizeof(struct bpf_cgroup_storage_key), 8, 0, 0);
+	if (percpu_cgroup_storage_fd < 0) {
+		printf("failed to create map '%s'\n", strerror(errno));
+		return -1;
+	}
+
 	struct bpf_insn prog[] =3D {
 		BPF_MOV32_IMM(BPF_REG_0, 0),
 		BPF_STX_MEM(BPF_W, BPF_REG_10, BPF_REG_0, -4), /* *(u32 *)(fp - 4) =3D r=
0 */
@@ -235,11 +243,20 @@ static int prog_load_cnt(int verdict, int val)
 		BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 2),
 		BPF_MOV64_IMM(BPF_REG_1, val), /* r1 =3D 1 */
 		BPF_RAW_INSN(BPF_STX | BPF_XADD | BPF_DW, BPF_REG_0, BPF_REG_1, 0, 0), /=
* xadd r0 +=3D r1 */
+
 		BPF_LD_MAP_FD(BPF_REG_1, cgroup_storage_fd),
 		BPF_MOV64_IMM(BPF_REG_2, 0),
 		BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_get_local_storage),
 		BPF_MOV64_IMM(BPF_REG_1, val),
 		BPF_RAW_INSN(BPF_STX | BPF_XADD | BPF_W, BPF_REG_0, BPF_REG_1, 0, 0),
+
+		BPF_LD_MAP_FD(BPF_REG_1, percpu_cgroup_storage_fd),
+		BPF_MOV64_IMM(BPF_REG_2, 0),
+		BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_get_local_storage),
+		BPF_LDX_MEM(BPF_W, BPF_REG_3, BPF_REG_0, 0),
+		BPF_ALU64_IMM(BPF_ADD, BPF_REG_3, 0x1),
+		BPF_STX_MEM(BPF_W, BPF_REG_0, BPF_REG_3, 0),
+
 		BPF_MOV64_IMM(BPF_REG_0, verdict), /* r0 =3D verdict */
 		BPF_EXIT_INSN(),
 	};
--=20
2.17.1

