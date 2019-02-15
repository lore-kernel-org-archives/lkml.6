Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 937CCC10F02
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 20:14:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58AF4222A1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 20:14:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="MkIvVyp+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390922AbfBOUOU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 15:14:20 -0500
Received: from mail-eopbgr700091.outbound.protection.outlook.com ([40.107.70.91]:40096
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726317AbfBOUOT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 15:14:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rjHFBc2hzhSQnUBNbmFr9Y1oTt1CX+dU/cSyNASEng4=;
 b=MkIvVyp+SNkULW67gtDNawBkrGR+ETpXecl7wGdGfn9WJxPYhXbBlyqeIbXqUy20kWyJBqtw4Fm7CIvxtOZnq+yCnmsTsgCoahXJahl9WxvCelafyaWgAgffqwoMNnzV2C8nzkAg6xv7yY/wmHNI368CGtaJRwDgTkyyMA4C5gI=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
 MWHPR2201MB1582.namprd22.prod.outlook.com (10.174.167.31) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.16; Fri, 15 Feb 2019 20:14:15 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::7d5e:f3b0:4a5:4636]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::7d5e:f3b0:4a5:4636%9]) with mapi id 15.20.1601.023; Fri, 15 Feb 2019
 20:14:15 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jiong Wang <jiong.wang@netronome.com>,
        Paul Burton <pburton@wavecomp.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: [PATCH 1/2] MIPS: eBPF: Always return sign extended 32b values
Thread-Topic: [PATCH 1/2] MIPS: eBPF: Always return sign extended 32b values
Thread-Index: AQHUxWsFAaDSuQE4g0KueZPNLuu8Cg==
Date:   Fri, 15 Feb 2019 20:14:15 +0000
Message-ID: <20190215201321.15725-1-paul.burton@mips.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR07CA0036.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::49) To MWHPR2201MB1277.namprd22.prod.outlook.com
 (2603:10b6:301:24::17)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.20.1
x-originating-ip: [67.207.99.198]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3349ca96-d610-4e11-c451-08d693822844
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:MWHPR2201MB1582;
x-ms-traffictypediagnostic: MWHPR2201MB1582:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;MWHPR2201MB1582;23:FtSurcM6FU1QDqlkIFwTqueMLDSgAyDJzPrmu?=
 =?iso-8859-1?Q?2xKrQUttEn5ab8iS6UQB6wpDuhAowVOUJk0eE2N3iP0ovLK2ZLK/lCH+u1?=
 =?iso-8859-1?Q?bZ8LVwgwKXTrAq6+wYW9lUohOpVl6pg2gbhwreZ5twNya1baLWIaGQYO1L?=
 =?iso-8859-1?Q?UUQiQmZVkkrSsdnwA4WEf3YgfJSDiORLE0bZCjmPecZIoz4J8oeM+imkf6?=
 =?iso-8859-1?Q?P4/SpIsUzwNHue3qMlEBJgt8crmByT8pkrY2RpBEGyN6lHjzcdgwuAk+i4?=
 =?iso-8859-1?Q?4LcOUxWvdt0u3NFFdHmNBdKZH8JZsoZQ+W3vTZtkFjICoiEbFxmewIeHXy?=
 =?iso-8859-1?Q?3ROPMJ+sVawkTDfbYuAUOLrnI1CJImbJot7e6dWjcrJ/VtDuOVIRs/JUCg?=
 =?iso-8859-1?Q?VVo/Su0yhWdcuhiRsyNbGCJL389SxsBHedDt4XjBb07xPLr8fgljJlaQIJ?=
 =?iso-8859-1?Q?JNgLUGvWxLX6qljpaj24+06bzr5e9hoK9mJ14Z+FfnWCSkkOhgg89rAqvK?=
 =?iso-8859-1?Q?6jH108NW/QAsupu9L+J6417XWDwUVVD5UW6Fk0PSVsDUxijf2zvNKEaScd?=
 =?iso-8859-1?Q?/vy84qUSktfytcTNmy9KB4zbV/5W9p6ae6LUHwnqhZT0oicfBHbkdIXrTD?=
 =?iso-8859-1?Q?2Kdi1Eu4UA5Is8IRwa5AAnZgmFZTT1icJ6HCxMUX57hpm+GikFdhiaTy3f?=
 =?iso-8859-1?Q?fIiu7tIn2BYIEy43NhohF0qdSnLRF4GlH8qVgUOK0i8bLQezVvxN7w+BFT?=
 =?iso-8859-1?Q?c0jSRnB32ntIu8q82F47c+D50iV1khbJo+qyr6DWnS7rPZpeDXii4sshlx?=
 =?iso-8859-1?Q?BNqFCesOiKMpYc8BVEyThl2ypwJ70JjuO6LTrIRHeXj7V9RyoCsZGPRhOx?=
 =?iso-8859-1?Q?U0CagZiVPsAM/CO/O3jB97ar42ZjkDdV5BX1fFzB11mh0p/G2t9ZuMubVZ?=
 =?iso-8859-1?Q?w6sdj+2BWbTRLwropwYQJHVcLHqzfb8YIgsZ0T63lFDJbTvJFFXiGiaJBl?=
 =?iso-8859-1?Q?+gueUCLAX3q4xKzR3dnGm0R7k3zmnUnljMwRtxoYWswJhUwMWLt9jFXo0v?=
 =?iso-8859-1?Q?0MDSBaDmuSoSnM0OR2H8CUSvAQG//GDuuSS7WXFNMxqLGloZK/dnPV3Seq?=
 =?iso-8859-1?Q?uqpDMGlbuO2ONEBwD4/LjovTq/fMeLzVde4C3+kjcIfaYhWNB+M/BlUNmK?=
 =?iso-8859-1?Q?rIJ7MDsXq9megoiKuuomDNPHjoscDmmlKyEzrBdq1EK54DFYtLtX2XMQGB?=
 =?iso-8859-1?Q?bCxbECk3uJy5ntOqopP?=
x-microsoft-antispam-prvs: <MWHPR2201MB1582219C9518BF56ADF4E332C1600@MWHPR2201MB1582.namprd22.prod.outlook.com>
x-forefront-prvs: 09497C15EB
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(346002)(376002)(39850400004)(396003)(366004)(199004)(189003)(71190400001)(256004)(186003)(66066001)(68736007)(50226002)(36756003)(486006)(102836004)(71200400001)(7416002)(386003)(6506007)(7736002)(305945005)(4326008)(316002)(1076003)(6116002)(3846002)(25786009)(44832011)(478600001)(2501003)(105586002)(97736004)(52116002)(42882007)(2906002)(476003)(53936002)(26005)(2616005)(110136005)(14444005)(8676002)(81156014)(99286004)(8936002)(6512007)(14454004)(54906003)(6436002)(106356001)(6486002)(81166006);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1582;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: BuiknC6m2558JmXBua/ANhh/TWg6bUr7TX4ISY9Wk93SsPBmQts9Ce+4FaO6PLbA+Si2zjmReYqB+zjdHUhJTJgPay+hDKULWg+0DQk6J3VzmGepn0VXm+14IEGdZO8vaZOEDLw0v/TXe4+DeOOqNVWeENnftPgUhbV8JAiliRIE5nO0qQi5a/+sy1OYSa6cMNzXBc6mv8o2XkegoOvwTpTSvejiCDHwCxdWa1esPLP0IRxrDbOBcYKaYSA5PBpRTsXb0UQ/yFmL5utQmasVwaiAqq2/3vN1YRzkTrCaSbDKwEGun52vEEDy7Y0FQMydP3YHeNMfs2eCehuk9EjVS7aO8Cdb6J985g9yVCbXHvVe0LF65ec44pJQVnQ+FCmam3q3b8I2RUoZ2yv3wGIr0ppDGC65IBcCqTjecDcZNTc=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3349ca96-d610-4e11-c451-08d693822844
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2019 20:14:14.6567
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1582
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function prototype used to call JITed eBPF code (ie. the type of the
struct bpf_prog bpf_func field) returns an unsigned int. The MIPS n64
ABI that MIPS64 kernels target defines that 32 bit integers should
always be sign extended when passed in registers as either arguments or
return values.

This means that when returning any value which may not already be sign
extended (ie. of type REG_64BIT or REG_32BIT_ZERO_EX) we need to perform
that sign extension in order to comply with the n64 ABI. Without this we
see strange looking test failures from test_bpf.ko, such as:

  test_bpf: #65 ALU64_MOV_X:
    dst =3D 4294967295 jited:1 ret -1 !=3D -1 FAIL (1 times)

Although the return value printed matches the expected value, this is
only because printf is only examining the least significant 32 bits of
the 64 bit register value we returned. The register holding the expected
value is sign extended whilst the v0 register was set to a zero extended
value by our JITed code, so when compared by a conditional branch
instruction the values are not equal.

We already handle this when the return value register is of type
REG_32BIT_ZERO_EX, so simply extend this to also cover REG_64BIT.

Signed-off-by: Paul Burton <paul.burton@mips.com>
Fixes: b6bd53f9c4e8 ("MIPS: Add missing file for eBPF JIT.")
Cc: stable@vger.kernel.org # v4.13+
---

 arch/mips/net/ebpf_jit.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/mips/net/ebpf_jit.c b/arch/mips/net/ebpf_jit.c
index b16710a8a9e7..715415fa2345 100644
--- a/arch/mips/net/ebpf_jit.c
+++ b/arch/mips/net/ebpf_jit.c
@@ -343,12 +343,15 @@ static int build_int_epilogue(struct jit_ctx *ctx, in=
t dest_reg)
 	const struct bpf_prog *prog =3D ctx->skf;
 	int stack_adjust =3D ctx->stack_size;
 	int store_offset =3D stack_adjust - 8;
+	enum reg_val_type td;
 	int r0 =3D MIPS_R_V0;
=20
-	if (dest_reg =3D=3D MIPS_R_RA &&
-	    get_reg_val_type(ctx, prog->len, BPF_REG_0) =3D=3D REG_32BIT_ZERO_EX)
+	if (dest_reg =3D=3D MIPS_R_RA) {
 		/* Don't let zero extended value escape. */
-		emit_instr(ctx, sll, r0, r0, 0);
+		td =3D get_reg_val_type(ctx, prog->len, BPF_REG_0);
+		if (td =3D=3D REG_64BIT || td =3D=3D REG_32BIT_ZERO_EX)
+			emit_instr(ctx, sll, r0, r0, 0);
+	}
=20
 	if (ctx->flags & EBPF_SAVE_RA) {
 		emit_instr(ctx, ld, MIPS_R_RA, store_offset, MIPS_R_SP);
--=20
2.20.1

