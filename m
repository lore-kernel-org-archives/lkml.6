Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40250ECE562
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 02:51:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B54F421521
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 02:51:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="eoKluE2M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B54F421521
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388144AbeITIcW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 04:32:22 -0400
Received: from mail-bl2nam02on0120.outbound.protection.outlook.com ([104.47.38.120]:37182
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387894AbeITIbE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 04:31:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=olFzsSmclz0lFgr3WgDe2BU76rHdfCVhXtJIr1z1bBg=;
 b=eoKluE2ME3D3OZwbuUbPW+XifNW36bjed9R1XWvc5Ew+znfTOt7wXuv3/aq43yFX+ntWXWi2IShsb65ChUFlmyrYUiWP32uDR/e85eciNaG0LEr1e4Y0Z9wN+B3p65uh+kOoH7u0x5TCrbflwBOPWmD8ymYlxctCuiE9AgVmOmE=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0469.namprd21.prod.outlook.com (10.172.121.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.9; Thu, 20 Sep 2018 02:49:56 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.010; Thu, 20 Sep 2018
 02:49:56 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Marc Zyngier <marc.zyngier@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.9 13/14] arm/arm64: smccc-1.1: Handle function
 result as parameters
Thread-Topic: [PATCH AUTOSEL 4.9 13/14] arm/arm64: smccc-1.1: Handle function
 result as parameters
Thread-Index: AQHUUIx1gTTNghVkwkeUD6WTyCvZFg==
Date:   Thu, 20 Sep 2018 02:48:50 +0000
Message-ID: <20180920024838.58666-13-alexander.levin@microsoft.com>
References: <20180920024838.58666-1-alexander.levin@microsoft.com>
In-Reply-To: <20180920024838.58666-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0469;6:WsWwS0N3b7nztrbPPM8lVAvAB4kjDQrYg9iEba4F0gBAlXkgHAgicIaJtwA13F4+X5BdyXHXyYAMJP1l5UBlmcD0zbT2/b2UPXdQ1k7LraoLnJkaiL4Ra8SSXnESOqHHTcRnQunTjvWfden0T+QWrf26o23IKeSVL/UY9AtOQChcWMQqFE8GshjlOs0HPbcrnnPBTypR834bbCP27PnkwFE5ZnhMW4p1VUyMfBcKcEhZfQ4j15klb9r902JqAj9hngewao6u06J2cfECCGPEuMt8Y9prAmFoP5gzLxQiUUu+1eKTpDqBF35W6/GfWXLepc3ZXS0qKoxF8TseBgBmo3nGwUEapPLLKoaD68mACPZVge56x9hlOcKhPBV7z4iPVtN+tUyhWGmmSHJkm/wW7pUmuVqFn43CjKLeqrnKvoAbgfmVOhacnbBZAbjwRo04Zsb/iNe2giXjwM1cXvwMQQ==;5:QJZLFWhBr9MP8HTwh7MfFlPVWFvRE5MC4VGdILT8mWLRYFOO14t7DEARhJ1ueIgiKge9aU6bt3A1h9bWpOq0JTiVysQ2EaSDdvSR3NfsU4aX7Hs/vZLpe9ntHu4iPHH2dC1YPHUFFHc45Q6RDwWalpbRP6MLPCaMOJSrMOc4BaE=;7:/vns1RLiYh8qE3KksMXvpnxB3FOzGHZ71PGL9H0napqHqXxZImx8rluXvjQOHRr1IyLt1tXejFd72JxqoOXRqxNMEyG6VTLRAlVSfj7+PvIX6vBkZjTTPvC+ho85r6Mlm9EaLreKuucBYb9DBdFAOGDX4NYPuEqJuyt/K3cRUIskyOPZvy2GLIyGXYR4DMNOyh8ktjz5p2igUN4jjJrUjOic8agkH0nd61T2t8q4KIr2B0XWXfA6VWsPbsmWY3A2
x-ms-office365-filtering-correlation-id: 4591fa8a-fe80-4b79-599f-08d61ea3bfa1
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0469;
x-ms-traffictypediagnostic: CY4PR21MB0469:
x-microsoft-antispam-prvs: <CY4PR21MB0469A9EDD90E1BEF3A81D22EFB130@CY4PR21MB0469.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(180628864354917)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231355)(944501410)(52105095)(2018427008)(3002001)(93006095)(93001095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0469;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0469;
x-forefront-prvs: 0801F2E62B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(376002)(136003)(39860400002)(346002)(199004)(189003)(6506007)(53936002)(2906002)(10290500003)(6512007)(478600001)(97736004)(8676002)(2501003)(68736007)(305945005)(99286004)(14454004)(81166006)(106356001)(7736002)(36756003)(76176011)(186003)(5250100002)(105586002)(476003)(8936002)(72206003)(486006)(2616005)(11346002)(6486002)(6436002)(446003)(6346003)(81156014)(26005)(102836004)(86362001)(54906003)(22452003)(86612001)(6666003)(3846002)(6116002)(25786009)(4326008)(5660300001)(316002)(10090500001)(107886003)(1076002)(66066001)(217873002)(2900100001)(256004)(110136005)(71190400001)(71200400001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0469;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: 4H387wrmMckt6AvD/OGhtA648vv+fEveOkirqJxEBZaR0bMDZUY0XYZJ2wOeAZrB1Z+IXLAetA3pqoEk3UF4yEqHFY4rB/FpfRe0Dnc1L3lRfd+awxGUiuR/CdcjfcKQkrKTCQSfUhDsRLbPtbrUf1pKwVV5e5WqdnFhoXBGf0CnBSu0lSVak8ai5v8O3byXMc+42TK+Xit0n5VFz6NYp6ttIRjKzFuPtH5KwhBlgSr8EjRoB87Biu7Mw80V20RRNOZH3JUL9AwYVMt3hQsJJgefg7WQdtXn4qO59n9bYXMXmVpjZHCQ443+3xCGXAMe3YLg4NtXpmGt93m6kF4bMyo9Cr0AzmSbCFoLiHBG3wo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4591fa8a-fe80-4b79-599f-08d61ea3bfa1
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2018 02:48:50.4599
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0469
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
