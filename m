Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96255ECE562
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 02:54:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 475E621522
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 02:54:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="aReLsbQo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 475E621522
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388230AbeITIaX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 04:30:23 -0400
Received: from mail-eopbgr700120.outbound.protection.outlook.com ([40.107.70.120]:3328
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726379AbeITIaV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 04:30:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=olFzsSmclz0lFgr3WgDe2BU76rHdfCVhXtJIr1z1bBg=;
 b=aReLsbQoyX5vBhy87r27VI1ikyo973+aOBvZ6WIFCX6HLX2ufVL9rCrv7aeLpCTWbzaC0RsLJkZ0IdL4OyZein14Xry1V4i/Sl5tB1PtimWL2oNqn2e38nwjz6aBsxzbapdfRjkY0ahANskIR9HRkweneaJEHGfUIJq9uvmvMfA=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0119.namprd21.prod.outlook.com (10.173.189.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.4; Thu, 20 Sep 2018 02:48:34 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.010; Thu, 20 Sep 2018
 02:48:34 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Marc Zyngier <marc.zyngier@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 53/56] arm/arm64: smccc-1.1: Handle function
 result as parameters
Thread-Topic: [PATCH AUTOSEL 4.18 53/56] arm/arm64: smccc-1.1: Handle function
 result as parameters
Thread-Index: AQHUUIxaVd0jV/+AM0+NyNHeC1sJmQ==
Date:   Thu, 20 Sep 2018 02:48:05 +0000
Message-ID: <20180920024716.58490-53-alexander.levin@microsoft.com>
References: <20180920024716.58490-1-alexander.levin@microsoft.com>
In-Reply-To: <20180920024716.58490-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0119;6:n6VQJxBVQxB8q5e1AC06HfajhPXgbmtEr3G/Oym12BVy4PDJeK0BZ7t8OPLj01DxLqe1rdplrjzWHGNBrEMNxbq9SyDcpfuWY8fFOBmP0Vr17juRY/9Bs4SlsMEB+9kVDXc009b9sUWj3uW9pI/IINusA81LRas502o6+1tegIIARmWN/2RjMXjcTvWtFXdy3Udq/xksEPVdzwl1p6xBseHBbj5CiDbdMY94sp5Ob+8ofyPVG1drCiY+wg3cYOstLb68dISWqckKN2stjEUwPDS3PWXDrNJXx4efQ3R5qPOJsdFtq2JMQwmvqTeOdNgfRNFGMJFhchhiZGZtElXs+perSd9Y84F0Zkx/XyNrhUB80nUlp5sBfqIaus6KAZ6NzuLknu1IrJNSrN1gvexhFQFk3mAVw44biBdlJ1OGkRC8cB5s/0vODA3r6toJdVANlFN4kW/AnhbcabVUU1A3Ag==;5:oC3O5z8JLm24KKUeeY9/v6DxKN1s6h87NHug778DMqxA35AUWF5CtFikxJi1RoQKYU6Kf99M5pm2lUOir8SpafxcXm+k4Sq4g1J45Ne95fLx4QXcUFZbCeAojsFMdV9cgQpFIRuHB7lVlSF98SB9npXr8joDBSxWlh5Tx4Nq3Js=;7:9pK3EEbyKfB6wDEDE4+nZ/AHTIiyj/BGkpd7Fx8YdcnizbNHn7+/6aeHSuyqzZVTHzkjHlz83DSQSbWG19Mpc5/j5hI+AUz9a6mFoiyfJewMaTSP3UitM3Rx58H0lJt1gDEBnXwgwVIdki1XI0otBU89hCyPiCdpI9q+Qn1Pu9C6LAH9UiZlYlm7NBGgdmhPTGMUwYlaY++3bWgEXkmQ1Mr+cej59cMqEIBjziwWGEo05Cqo/Qr4P0pSptieF44S
x-ms-office365-filtering-correlation-id: eb7e1b64-d7e8-468f-4aeb-08d61ea38ec1
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0119;
x-ms-traffictypediagnostic: CY4PR21MB0119:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB011966CCE97F67C10C007322FB130@CY4PR21MB0119.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(180628864354917)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(2018427008)(93006095)(93001095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0119;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0119;
x-forefront-prvs: 0801F2E62B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(396003)(376002)(136003)(39860400002)(189003)(199004)(5660300001)(54906003)(1076002)(478600001)(10090500001)(72206003)(22452003)(107886003)(110136005)(316002)(68736007)(4326008)(76176011)(3846002)(6116002)(25786009)(14454004)(106356001)(99286004)(6666003)(105586002)(102836004)(6506007)(5250100002)(186003)(2501003)(26005)(6486002)(6436002)(53936002)(6512007)(66066001)(486006)(476003)(2616005)(10290500003)(11346002)(446003)(97736004)(36756003)(2900100001)(2906002)(8936002)(305945005)(217873002)(7736002)(86362001)(8676002)(86612001)(256004)(71200400001)(71190400001)(81156014)(81166006);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0119;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: x+i+qlhWY3BHt12YTDoRYUr9w1RIgqSDXJ+EgMi12BmfPJfwwn5dwzzCSlZB/8DVfLU8+GzoAQwSYm/cesWJdydtkVsjoM+X3TO2d/vXLWROPSRhXMECPtsZQCErz+FIVtb53wvdShkfqvRFlKXreOzX32DvABvOXGSxe+9+ItRswIklkAeArAvx4UUB7NJaFaZp+tzhhv+r5ArBxgtZ9OHxvUuwcvmB4VT8c/y6/R0DmoX6A7C9jhIRD78ot3Cc8WfB61SkDbHfsadEoltLFPvrJtOGTBjJxWhYvOuz+nT/zXYFGkFcp6R8lROV1qolmVEl3G7M+7a7QEcNVHGYWq922W6sdh/yN6Nts37jV3o=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb7e1b64-d7e8-468f-4aeb-08d61ea38ec1
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2018 02:48:05.0229
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0119
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
