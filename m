Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21231C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 02:49:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE5E321521
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 02:49:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Kfsz047e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE5E321521
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388374AbeITIac (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 04:30:32 -0400
Received: from mail-bl2nam02on0106.outbound.protection.outlook.com ([104.47.38.106]:44649
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388232AbeITIaa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 04:30:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=olFzsSmclz0lFgr3WgDe2BU76rHdfCVhXtJIr1z1bBg=;
 b=Kfsz047eQfcJrfBViyjlL6KUTvTi+95MgbJdT8RpZxMn74Xy6dW49QW5+ZgZ1ikELe0yCKwt6o7o6My8yFwmHxpC79xbuSLHhnDRgD+Bv0k88dMRzl23f6joIQOnz7rSM3UU23xWkaETP0dvweKnltao6ALrVG32tcegZ4QN6hk=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0744.namprd21.prod.outlook.com (10.173.189.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.6; Thu, 20 Sep 2018 02:49:19 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.010; Thu, 20 Sep 2018
 02:49:19 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Marc Zyngier <marc.zyngier@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 23/25] arm/arm64: smccc-1.1: Handle function
 result as parameters
Thread-Topic: [PATCH AUTOSEL 4.14 23/25] arm/arm64: smccc-1.1: Handle function
 result as parameters
Thread-Index: AQHUUIxqr3Bkucv2YU+akUZIfzj85Q==
Date:   Thu, 20 Sep 2018 02:48:32 +0000
Message-ID: <20180920024810.58594-23-alexander.levin@microsoft.com>
References: <20180920024810.58594-1-alexander.levin@microsoft.com>
In-Reply-To: <20180920024810.58594-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0744;6:w44PAFmZw6WekZn8feiu8P4UV0xUMDR+Ig/pZpStfmIO/r1NJhEJuUF+5WjryhZfqarMw7I/JT3l5U2uBkUVN/1f6ldj1FD7+axV4tKtP1e66SuzTxSe8YySKtwq8y/gURRVmxtqRiDxVs7qmmxUFWXWBhklXYPmdUBTLawY5TOj5FVucCPpas1F1wHVnWT1D8DFrJYf4DZoMDOe8ESntBzM7kLHaKZART/NB5Mq0NgjNSBGkHB8T3pwNo16pJJJ8e4u5rd514ZB6Z3WRpW9DKA/FY6Avv2LmgP/Obgwy1gyA2XYJDDz4SeVz6uKRVdRciSPE4850UYPtXFQxArkhX5bdAkscN0jpGDbyZPACTT2Y2Foq9tE8WoKPl9jUOa+hDCnyFb/OrP19uy4ICZASN5vYMyweDQazRj9uCzwVZnyHARaw0fXNlg4XqoGzfKE0I77T+dwJ5QYRiqLmbQOMA==;5:apUdqvJ64Eo/VG9JMgyMcI5pUkQpXwd++b31R06y0uOs+200x2Qp12dzuMZhjgiW9sknfvt706UHJEUNntVkAb7W4kiwVBKQAEsKcDECZOvprH+Srcp1PI4ecJUoHIm9+1fZs9VK1u8SCfDQlauk1Xr45uwggdI2JY6bpxHtdiM=;7:gLtKneVRp8/z3zltD62lZo13kr7RgvWdamgUs7I+Zk1vFI+PHo1N0stPFUG03I67OEJNUVqDkt7dSQSqCiiGxpwpYtG6U+aA6ya3mxY0ZDd8tOOatxDdV1hH/tk01Czr4tYhXVIMd6/8Q71TLqhbyI6y0b70ar0IOngPcFVfWSaRyC73hS4z9khMVRY1nWDrZuqjvsDz2Tu1dVz7hGujUYRLJHFnC0G2x0hWg1SX1UXSb0TxmYs3PK4AUfFclJBm
x-ms-office365-filtering-correlation-id: d8c908cd-4462-4c4f-6f15-08d61ea3a998
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0744;
x-ms-traffictypediagnostic: CY4PR21MB0744:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0744993869338215FEA673C4FB130@CY4PR21MB0744.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(180628864354917)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231355)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0744;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0744;
x-forefront-prvs: 0801F2E62B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(396003)(376002)(346002)(136003)(189003)(199004)(8936002)(6436002)(10090500001)(110136005)(217873002)(54906003)(6512007)(53936002)(68736007)(5660300001)(256004)(6666003)(71190400001)(6486002)(316002)(446003)(11346002)(105586002)(476003)(106356001)(478600001)(2616005)(2906002)(186003)(25786009)(10290500003)(486006)(71200400001)(72206003)(66066001)(4326008)(14454004)(22452003)(36756003)(102836004)(86612001)(97736004)(8676002)(305945005)(7736002)(1076002)(86362001)(81156014)(26005)(76176011)(6506007)(5250100002)(107886003)(2900100001)(99286004)(3846002)(2501003)(81166006)(6116002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0744;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: Red6AdRx9ivtRu4cJOeJ9uwu3uhBcJs+KBPXIMVUCPqJr0n3HhoQ1xV2m3qdtnYFzaXa5kKHtTDA74xj+kP4QAnJidFVM+aGEp0uBNrFSaW1zxNVD/pglaXt828MuQODgV2khBka3bWjD8fz4hKn1Bz+MDGl1ojA9XI3Zl7slFujbT8JdGoVbyYjMosl/LP5tiQK8SDd53JG+BToJuS7no9ZJ/q5iU6pW8MMEdaggmLch0xr9Z7GvMLs/cf1I82Z4S4NziYnrXTHgvN3HcAdM8DlcDeOY+5itoNhr38YualYWb+fAEGCpHi5FGTnYOKkzbi9IIZ1/UR8LnZdkL3sKs2jZ5Xn/R/D/JjkJDMpZaE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8c908cd-4462-4c4f-6f15-08d61ea3a998
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2018 02:48:32.1632
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0744
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marc Zyngier <marc.zyngier@arm.com>

[ Upstream commit 755a8bf5579d22eb5636685c516d8dede799e27b ]

If someone has the silly idea to write something along those lines:

	extern u64 foo(void);

	void bar(struct arm_smccc_res *res)
	{
		arm_smccc_1_1_smc(0xbad, foo(), res);
	}

they are in for a surprise, as this gets compiled as:

	0000000000000588 <bar>:
	 588:   a9be7bfd        stp     x29, x30, [sp, #-32]!
	 58c:   910003fd        mov     x29, sp
	 590:   f9000bf3        str     x19, [sp, #16]
	 594:   aa0003f3        mov     x19, x0
	 598:   aa1e03e0        mov     x0, x30
	 59c:   94000000        bl      0 <_mcount>
	 5a0:   94000000        bl      0 <foo>
	 5a4:   aa0003e1        mov     x1, x0
	 5a8:   d4000003        smc     #0x0
	 5ac:   b4000073        cbz     x19, 5b8 <bar+0x30>
	 5b0:   a9000660        stp     x0, x1, [x19]
	 5b4:   a9010e62        stp     x2, x3, [x19, #16]
	 5b8:   f9400bf3        ldr     x19, [sp, #16]
	 5bc:   a8c27bfd        ldp     x29, x30, [sp], #32
	 5c0:   d65f03c0        ret
	 5c4:   d503201f        nop

The call to foo "overwrites" the x0 register for the return value,
and we end up calling the wrong secure service.

A solution is to evaluate all the parameters before assigning
anything to specific registers, leading to the expected result:

	0000000000000588 <bar>:
	 588:   a9be7bfd        stp     x29, x30, [sp, #-32]!
	 58c:   910003fd        mov     x29, sp
	 590:   f9000bf3        str     x19, [sp, #16]
	 594:   aa0003f3        mov     x19, x0
	 598:   aa1e03e0        mov     x0, x30
	 59c:   94000000        bl      0 <_mcount>
	 5a0:   94000000        bl      0 <foo>
	 5a4:   aa0003e1        mov     x1, x0
	 5a8:   d28175a0        mov     x0, #0xbad
	 5ac:   d4000003        smc     #0x0
	 5b0:   b4000073        cbz     x19, 5bc <bar+0x34>
	 5b4:   a9000660        stp     x0, x1, [x19]
	 5b8:   a9010e62        stp     x2, x3, [x19, #16]
	 5bc:   f9400bf3        ldr     x19, [sp, #16]
	 5c0:   a8c27bfd        ldp     x29, x30, [sp], #32
	 5c4:   d65f03c0        ret

Reported-by: Julien Grall <julien.grall@arm.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 include/linux/arm-smccc.h | 30 ++++++++++++++++++++----------
 1 file changed, 20 insertions(+), 10 deletions(-)

diff --git a/include/linux/arm-smccc.h b/include/linux/arm-smccc.h
index 5a91ff33720b..18863d56273c 100644
--- a/include/linux/arm-smccc.h
+++ b/include/linux/arm-smccc.h
@@ -205,41 +205,51 @@ asmlinkage void __arm_smccc_hvc(unsigned long a0, uns=
igned long a1,
 	register unsigned long r3 asm("r3")
=20
 #define __declare_arg_1(a0, a1, res)					\
+	typeof(a1) __a1 =3D a1;						\
 	struct arm_smccc_res   *___res =3D res;				\
 	register unsigned long r0 asm("r0") =3D (u32)a0;			\
-	register unsigned long r1 asm("r1") =3D a1;			\
+	register unsigned long r1 asm("r1") =3D __a1;			\
 	register unsigned long r2 asm("r2");				\
 	register unsigned long r3 asm("r3")
=20
 #define __declare_arg_2(a0, a1, a2, res)				\
+	typeof(a1) __a1 =3D a1;						\
+	typeof(a2) __a2 =3D a2;						\
 	struct arm_smccc_res   *___res =3D res;				\
 	register unsigned long r0 asm("r0") =3D (u32)a0;			\
-	register unsigned long r1 asm("r1") =3D a1;			\
-	register unsigned long r2 asm("r2") =3D a2;			\
+	register unsigned long r1 asm("r1") =3D __a1;			\
+	register unsigned long r2 asm("r2") =3D __a2;			\
 	register unsigned long r3 asm("r3")
=20
 #define __declare_arg_3(a0, a1, a2, a3, res)				\
+	typeof(a1) __a1 =3D a1;						\
+	typeof(a2) __a2 =3D a2;						\
+	typeof(a3) __a3 =3D a3;						\
 	struct arm_smccc_res   *___res =3D res;				\
 	register unsigned long r0 asm("r0") =3D (u32)a0;			\
-	register unsigned long r1 asm("r1") =3D a1;			\
-	register unsigned long r2 asm("r2") =3D a2;			\
-	register unsigned long r3 asm("r3") =3D a3
+	register unsigned long r1 asm("r1") =3D __a1;			\
+	register unsigned long r2 asm("r2") =3D __a2;			\
+	register unsigned long r3 asm("r3") =3D __a3
=20
 #define __declare_arg_4(a0, a1, a2, a3, a4, res)			\
+	typeof(a4) __a4 =3D a4;						\
 	__declare_arg_3(a0, a1, a2, a3, res);				\
-	register typeof(a4) r4 asm("r4") =3D a4
+	register unsigned long r4 asm("r4") =3D __a4
=20
 #define __declare_arg_5(a0, a1, a2, a3, a4, a5, res)			\
+	typeof(a5) __a5 =3D a5;						\
 	__declare_arg_4(a0, a1, a2, a3, a4, res);			\
-	register typeof(a5) r5 asm("r5") =3D a5
+	register unsigned long r5 asm("r5") =3D __a5
=20
 #define __declare_arg_6(a0, a1, a2, a3, a4, a5, a6, res)		\
+	typeof(a6) __a6 =3D a6;						\
 	__declare_arg_5(a0, a1, a2, a3, a4, a5, res);			\
-	register typeof(a6) r6 asm("r6") =3D a6
+	register unsigned long r6 asm("r6") =3D __a6
=20
 #define __declare_arg_7(a0, a1, a2, a3, a4, a5, a6, a7, res)		\
+	typeof(a7) __a7 =3D a7;						\
 	__declare_arg_6(a0, a1, a2, a3, a4, a5, a6, res);		\
-	register typeof(a7) r7 asm("r7") =3D a7
+	register unsigned long r7 asm("r7") =3D __a7
=20
 #define ___declare_args(count, ...) __declare_arg_ ## count(__VA_ARGS__)
 #define __declare_args(count, ...)  ___declare_args(count, __VA_ARGS__)
--=20
2.17.1
