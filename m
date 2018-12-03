Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3C90C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 09:48:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AE0D2145D
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 09:48:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nokia.onmicrosoft.com header.i=@nokia.onmicrosoft.com header.b="WyXQYatc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AE0D2145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nokia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726120AbeLCJtP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 04:49:15 -0500
Received: from mail-eopbgr80100.outbound.protection.outlook.com ([40.107.8.100]:33952
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726028AbeLCJtP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 04:49:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c+XJNvIS9hNzHRZmIhwnFFErXy/WZxiKywxTXaam4HY=;
 b=WyXQYatc6aiaCghd9FxlG2UfX2y2hFASAwexc5+KJHuALRSv5CYHq2oHQt/Qk90BI6lKIlQdUHAhejscTUBjgk/J9rCTR9LWfUW9LUbEQIdMVFIt8yhcgUoZm5kvoDG5Lve/XhMg6KYqmrJ/k8xk7FfQYhporE1EHDeS8CNVl5w=
Received: from HE1PR0701MB2729.eurprd07.prod.outlook.com (10.168.188.135) by
 HE1PR0701MB2890.eurprd07.prod.outlook.com (10.168.92.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.8; Mon, 3 Dec 2018 09:48:53 +0000
Received: from HE1PR0701MB2729.eurprd07.prod.outlook.com
 ([fe80::35b1:90ba:fa:3c77]) by HE1PR0701MB2729.eurprd07.prod.outlook.com
 ([fe80::35b1:90ba:fa:3c77%9]) with mapi id 15.20.1404.016; Mon, 3 Dec 2018
 09:48:53 +0000
From:   "Sverdlin, Alexander (Nokia - DE/Ulm)" <alexander.sverdlin@nokia.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "Sverdlin, Alexander (Nokia - DE/Ulm)" <alexander.sverdlin@nokia.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: [PATCH] ARM: ftrace/recordmcount: filter relocation types
Thread-Topic: [PATCH] ARM: ftrace/recordmcount: filter relocation types
Thread-Index: AQHUiu1metDmHdisl0uh39AjKwn2oA==
Date:   Mon, 3 Dec 2018 09:48:52 +0000
Message-ID: <20181203094815.7859-1-alexander.sverdlin@nokia.com>
References: <DM5PR2101MB1032EF6B16414765AA0BAB19FBBE0@DM5PR2101MB1032.namprd21.prod.outlook.com>
In-Reply-To: <DM5PR2101MB1032EF6B16414765AA0BAB19FBBE0@DM5PR2101MB1032.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [131.228.32.165]
x-mailer: git-send-email 2.19.2
x-clientproxiedby: HE1PR0402CA0041.eurprd04.prod.outlook.com
 (2603:10a6:7:7c::30) To HE1PR0701MB2729.eurprd07.prod.outlook.com
 (2603:10a6:3:99::7)
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;HE1PR0701MB2890;6:8wccQtqnDVtj/70tm48fjk3yyxv/8JkoAoHq6zUVMvWPXT7WYb61SKd9hf3yPR1st54rrv33+JX0gNYH+L4Kg+UGqTcDD/vAzxko4MQedkJvJECBMD+cBzGfJkHN6SNiGSMDFsiCollgdC2vROIe0dEhsrkD4eNQYxATZlb2OSsmCG5RQ2s0q94upF3Oj0J3KNQh2Jx18QAG20pLVlD/2IhTH2EuBScYzIGWAWT2QwhvQmgUpaMiW9eA7/pOoyK/Nv9oBi9ExO0Z840Au3e+gymxLzxD8e6ZIXX9Xu/3dmZ0TAu8DiWEYFMMv0a1UbWzxB1dZ9dGpcFjFAcez0/XcDeaeNSDv5BuuHRk9Ypv5tk/mzHYsA2jsJ67/Al3ccJ0u1Uzt9yRNV86EJrjvgHTr/6C/mbKZxsZEVI8EKFRbVlhfaRpmPKNcWyf3udeXlZx1s8hhXOMtYkoq3k6llWCqQ==;5:2yHSQCIXjP+llcFtJnKRXTTVBkYlXVAfBfMIb/QfwiY0JtaTQdSfvGqSJVGdJZf70HE6wHB8MQp5AnWpeODXr5oD8AHGIlvaFgf6AUE7oRl6HbsBgeefQNRZy6plbwK7bqgLRbfF/h5BiVYZuB47j2PiMV/jV9chDNlxOoSzkk4=;7:dm+wAv5GllihmAIyCmtx+Q+Uhjl0rJCZABCXm0PCcSgI87DthW7Ox1O91z00yAQXINEVfuTO5J7B7nke5picB2hd7t0a+CK3266gHQM9qnW0RBsszlDciKXOX5boqXlmESp/xz3wlyxW5OV3sQw5XA==
x-ms-office365-filtering-correlation-id: 442aff19-02c6-4ccf-c231-08d6590487f4
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:HE1PR0701MB2890;
x-ms-traffictypediagnostic: HE1PR0701MB2890:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=alexander.sverdlin@nokia.com; 
x-microsoft-antispam-prvs: <HE1PR0701MB28908438B82A24A2B75EB71C88AE0@HE1PR0701MB2890.eurprd07.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(3231455)(999002)(11241501185)(806100)(944501493)(4982022)(52105112)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:HE1PR0701MB2890;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0701MB2890;
x-forefront-prvs: 08756AC3C8
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(376002)(136003)(396003)(39860400002)(346002)(189003)(199004)(486006)(11346002)(446003)(476003)(25786009)(2616005)(86362001)(68736007)(316002)(50226002)(54906003)(8936002)(186003)(99286004)(52116002)(26005)(36756003)(102836004)(386003)(6506007)(97736004)(4326008)(7736002)(53936002)(305945005)(6306002)(6512007)(5640700003)(76176011)(2501003)(575784001)(66066001)(256004)(14444005)(106356001)(105586002)(1076002)(6916009)(6116002)(3846002)(71190400001)(71200400001)(966005)(14454004)(6436002)(2906002)(8676002)(5660300001)(478600001)(81156014)(81166006)(2351001)(6486002);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0701MB2890;H:HE1PR0701MB2729.eurprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nokia.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: C99ILHFKm24T/BmyfcQMy0x0WA75Elc9cJeWY3lFVT7vOyE66Tmm2F3K+TBu1dCgaVD9qUUAT5glYuDKJxtW24tictC9gRjZguWQnd72SwzDiFRkQ6HGtXGMonI/9C3y7qYFCeHge9t34NKbKslALRYVmjdM+N22BfO3iUcP+s+oX0n2xJYPQS6asFdXt7qcwndsljgqcqWcumj9MhdV3WpcYUdaSk9Kxb+yQxEw7PZomxOUe1HgltGzZENujwjp6idf7PMDsQkx6TYJluJ7aUzyzCnBk4IVzqGjnraYsldFnzU5hj/8P036VnO0Qoq+SEi3dHZ5uKJjADHA48nklKC3DNMntuXiDy0YjU1nlSQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 442aff19-02c6-4ccf-c231-08d6590487f4
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2018 09:48:52.8460
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0701MB2890
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Scenario 1, ARMv7:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

If code in arch/arm/kernel/ftrace.c would operate on mcount() pointer
the following may be generated:

00000230 <prealloc_fixed_plts>:
 230:   b5f8            push    {r3, r4, r5, r6, r7, lr}
 232:   b500            push    {lr}
 234:   f7ff fffe       bl      0 <__gnu_mcount_nc>
                        234: R_ARM_THM_CALL     __gnu_mcount_nc
 238:   f240 0600       movw    r6, #0
                        238: R_ARM_THM_MOVW_ABS_NC      __gnu_mcount_nc
 23c:   f8d0 1180       ldr.w   r1, [r0, #384]  ; 0x180

FTRACE currently is not able to deal with it:

WARNING: CPU: 0 PID: 0 at .../kernel/trace/ftrace.c:1979 ftrace_bug+0x1ad/0=
x230()
...
CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.4.116-... #1
...
[<c0314e3d>] (unwind_backtrace) from [<c03115e9>] (show_stack+0x11/0x14)
[<c03115e9>] (show_stack) from [<c051a7f1>] (dump_stack+0x81/0xa8)
[<c051a7f1>] (dump_stack) from [<c0321c5d>] (warn_slowpath_common+0x69/0x90=
)
[<c0321c5d>] (warn_slowpath_common) from [<c0321cf3>] (warn_slowpath_null+0=
x17/0x1c)
[<c0321cf3>] (warn_slowpath_null) from [<c038ee9d>] (ftrace_bug+0x1ad/0x230=
)
[<c038ee9d>] (ftrace_bug) from [<c038f1f9>] (ftrace_process_locs+0x27d/0x44=
4)
[<c038f1f9>] (ftrace_process_locs) from [<c08915bd>] (ftrace_init+0x91/0xe8=
)
[<c08915bd>] (ftrace_init) from [<c0885a67>] (start_kernel+0x34b/0x358)
[<c0885a67>] (start_kernel) from [<00308095>] (0x308095)
---[ end trace cb88537fdc8fa200 ]---
ftrace failed to modify [<c031266c>] prealloc_fixed_plts+0x8/0x60
 actual: 44:f2:e1:36
ftrace record flags: 0
 (0)   expected tramp: c03143e9

Scenario 2, ARMv4T:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

ftrace: allocating 14435 entries in 43 pages
------------[ cut here ]------------
WARNING: CPU: 0 PID: 0 at kernel/trace/ftrace.c:2029 ftrace_bug+0x204/0x310
CPU: 0 PID: 0 Comm: swapper Not tainted 4.19.5 #1
Hardware name: Cirrus Logic EDB9302 Evaluation Board
[<c0010a24>] (unwind_backtrace) from [<c000ecb0>] (show_stack+0x20/0x2c)
[<c000ecb0>] (show_stack) from [<c03c72e8>] (dump_stack+0x20/0x30)
[<c03c72e8>] (dump_stack) from [<c0021c18>] (__warn+0xdc/0x104)
[<c0021c18>] (__warn) from [<c0021d7c>] (warn_slowpath_null+0x4c/0x5c)
[<c0021d7c>] (warn_slowpath_null) from [<c0095360>] (ftrace_bug+0x204/0x310=
)
[<c0095360>] (ftrace_bug) from [<c04dabac>] (ftrace_init+0x3b4/0x4d4)
[<c04dabac>] (ftrace_init) from [<c04cef4c>] (start_kernel+0x20c/0x410)
[<c04cef4c>] (start_kernel) from [<00000000>] (  (null))
---[ end trace 0506a2f5dae6b341 ]---
ftrace failed to modify
[<c000c350>] perf_trace_sys_exit+0x5c/0xe8
 actual:   1e:ff:2f:e1
Initializing ftrace call sites
ftrace record flags: 0
 (0)
 expected tramp: c000fb24

The analysis for this problem has been already performed previously,
refer to the link below.

Fix the above problems by allowing only selected reloc types in
__mcount_loc. The list itself comes from the legacy recordmcount.pl
script.

Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/lkml/56961010.6000806@pengutronix.de/
Fixes: ed60453fa8 ("ARM: 6511/1: ftrace: add ARM support for C version of r=
ecordmcount")
Signed-off-by: Alexander Sverdlin <alexander.sverdlin@nokia.com>
---
 scripts/recordmcount.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/scripts/recordmcount.c b/scripts/recordmcount.c
index 895c40e8679f..3b0dcf38fd8b 100644
--- a/scripts/recordmcount.c
+++ b/scripts/recordmcount.c
@@ -39,6 +39,10 @@
 #define R_AARCH64_ABS64	257
 #endif
=20
+#define R_ARM_PC24		1
+#define R_ARM_THM_CALL		10
+#define R_ARM_CALL		28
+
 static int fd_map;	/* File descriptor for file being modified. */
 static int mmap_failed; /* Boolean flag. */
 static char gpfx;	/* prefix for global symbol name (sometimes '_') */
@@ -414,6 +418,18 @@ is_mcounted_section_name(char const *const txtname)
 #define RECORD_MCOUNT_64
 #include "recordmcount.h"
=20
+static int arm_is_fake_mcount(Elf32_Rel const *rp)
+{
+	switch (ELF32_R_TYPE(w(rp->r_info))) {
+	case R_ARM_THM_CALL:
+	case R_ARM_CALL:
+	case R_ARM_PC24:
+		return 0;
+	}
+
+	return 1;
+}
+
 /* 64-bit EM_MIPS has weird ELF64_Rela.r_info.
  * http://techpubs.sgi.com/library/manuals/4000/007-4658-001/pdf/007-4658-=
001.pdf
  * We interpret Table 29 Relocation Operation (Elf64_Rel, Elf64_Rela) [p.4=
0]
@@ -515,6 +531,7 @@ do_file(char const *const fname)
 			 altmcount =3D "__gnu_mcount_nc";
 			 make_nop =3D make_nop_arm;
 			 rel_type_nop =3D R_ARM_NONE;
+			 is_fake_mcount32 =3D arm_is_fake_mcount;
 			 break;
 	case EM_AARCH64:
 			reltype =3D R_AARCH64_ABS64;
--=20
2.19.2

