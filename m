Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F2C3C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 02:53:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A1D521521
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 02:53:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="FtSam3ck"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A1D521521
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387902AbeITIeN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 04:34:13 -0400
Received: from mail-bl2nam02on0090.outbound.protection.outlook.com ([104.47.38.90]:36192
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388313AbeITIa3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 04:30:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B+mov5QcteXocqeBBvPRkegfg9f1xBXGdQHuqd1a5Sw=;
 b=FtSam3ckx/ouakIT4MQFVCdh4VHkJCKKxRkOHs9Bh3MAKv8dfYvuf5vW+26lGIXa0KoCa+9AhdXZ9KRn6ILOFZbIpZMl+t37sTXNDs6Ene9dohryJszui0bt4IStXHqohX00CRZNwcdMz3aTZYXShKOM474zZqAJy2XFrKdyI+Y=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0744.namprd21.prod.outlook.com (10.173.189.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.6; Thu, 20 Sep 2018 02:49:18 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.010; Thu, 20 Sep 2018
 02:49:18 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Marc Zyngier <marc.zyngier@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 22/25] arm/arm64: smccc-1.1: Make return values
 unsigned long
Thread-Topic: [PATCH AUTOSEL 4.14 22/25] arm/arm64: smccc-1.1: Make return
 values unsigned long
Thread-Index: AQHUUIxqJAnRJuGGn02pL/yQcrxpZQ==
Date:   Thu, 20 Sep 2018 02:48:31 +0000
Message-ID: <20180920024810.58594-22-alexander.levin@microsoft.com>
References: <20180920024810.58594-1-alexander.levin@microsoft.com>
In-Reply-To: <20180920024810.58594-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0744;6:Sy+Q/mMaS1B36kU4lDRQSx65Tk7mK1QjL0E3LgtCwV8WgVE7YMS0AzZoJ2yYYIrjVt6InyH7iMwCeS1bIUthXlHDKDKvKSH8BBr7t3Q2KUweubI1tkXN6RH+UsSvl195ERSdu3I1CTWvo8AHkbPmtN9g7md2z69YlZqaJOGgegQdX/20f3Juc0vAhudnsD3mglkONKlDPjPLZAidV86ZgKqu3YHrys2jMvnPVy5YNENBbv7UJ5lkB1ic5oublEkwxVlav0lJ3bpdqvH8RRg/e4xwm3l1Vdm8yl+yNoydeCdt2H3ZCCqXQVT6509FSiy5fsC4NPO5A78xciWlXcd0VlBtlf6MBuUstirwl5iOD8yHf3ZT0Rz5PY/56mIHAHYiAMsCgceoEwwA53h3NEU07QA2MMgBeXG54wXM6WNX6NQ/OpyYkc5UYrqBN47lchMRXXXvb0gRFeUn0qeuraLrZQ==;5:k0pR+2PXTvcSWFOPZ/WtW7I91yTndO9ZamXV7CD8b9T5hU6BFFMXq63LlfcNu7w3ItmPG6haps45fGNtKfrf2BBl0T4EfJ6AJ2FJv8K46YlkbhodI7ny4l8IOHOQzLb9gaBPx8zQPmnG4Baty1n47XaRl6fRgTm7WuuFcN5kVVc=;7:hK/8NWwY6UGjcFAO66bGYVDMiaaeEQOxukwotI/cNHSsrKVXZYgCcDUc/WDwG1fZuLiJ3D3j/qRMLw3p/DH0yfIJLLXSAqR5VBApiiSebDPwoXzKTBmoQ0qHyAMPS3faviZd2KBsQWJ7/jWApvp4rCXQPwwmULmujjHIhkz3/zrDa4bKdpnWg3bflldLOWaKh9RIebqW4UJ/ov4s3tLWJPKOJtufMDgURWYJdTqq5ZFUn1dGTn4VFZ3abJeHKJ52
x-ms-office365-filtering-correlation-id: 4952e654-9b06-4c3c-ad75-08d61ea3a955
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0744;
x-ms-traffictypediagnostic: CY4PR21MB0744:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB07447FBC946FB7DE83E4E4A5FB130@CY4PR21MB0744.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(180628864354917)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231355)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0744;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0744;
x-forefront-prvs: 0801F2E62B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(39860400002)(366004)(396003)(376002)(346002)(136003)(189003)(199004)(8936002)(6436002)(10090500001)(110136005)(217873002)(54906003)(6512007)(53936002)(68736007)(5660300001)(256004)(6666003)(71190400001)(6486002)(316002)(446003)(11346002)(105586002)(476003)(106356001)(478600001)(2616005)(2906002)(186003)(25786009)(10290500003)(486006)(71200400001)(72206003)(66066001)(4326008)(14454004)(22452003)(36756003)(102836004)(86612001)(97736004)(8676002)(305945005)(7736002)(1076002)(86362001)(575784001)(81156014)(26005)(76176011)(6506007)(5250100002)(107886003)(2900100001)(99286004)(3846002)(2501003)(81166006)(6116002)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0744;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: elOc9FsI0XAcn1QXWNwnq0iFIbwzTVjjMmooRVtkcntKuKq7ybkqFDezamhXQhI2I0z0hhWvq1ZDEkDYGAlqVlDBrxpyS2MOKBO0oN7TtxE2OHDGQafM2jMZMMCW3lrtnugnUf4muJCCT69cMzGsbw/Yr3yIPDtrmP1JxjH0d6m94EPUXRErip7ut0JykK7WlMvhSX0u23qkhT5xgMwMiWdzz4IRPC6DE862ktEwK1ZAo+ziuhbd29BllUVLumGEkJi2SA/LTLVdCRIV/Qv/8JrUqukhSCU+zKHk3DE032MI4F+sEQDmqUmlctkYg5KdOI6pQjffMZvdIEVkNRnzupdOCrK5noTvYHRfpGpDCi4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4952e654-9b06-4c3c-ad75-08d61ea3a955
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2018 02:48:31.3195
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0744
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marc Zyngier <marc.zyngier@arm.com>

[ Upstream commit 1d8f574708a3fb6f18c85486d0c5217df893c0cf ]

An unfortunate consequence of having a strong typing for the input
values to the SMC call is that it also affects the type of the
return values, limiting r0 to 32 bits and r{1,2,3} to whatever
was passed as an input.

Let's turn everything into "unsigned long", which satisfies the
requirements of both architectures, and allows for the full
range of return values.

Reported-by: Julien Grall <julien.grall@arm.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 include/linux/arm-smccc.h | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/include/linux/arm-smccc.h b/include/linux/arm-smccc.h
index ca1d2cc2cdfa..5a91ff33720b 100644
--- a/include/linux/arm-smccc.h
+++ b/include/linux/arm-smccc.h
@@ -199,31 +199,31 @@ asmlinkage void __arm_smccc_hvc(unsigned long a0, uns=
igned long a1,
=20
 #define __declare_arg_0(a0, res)					\
 	struct arm_smccc_res   *___res =3D res;				\
-	register u32           r0 asm("r0") =3D a0;			\
+	register unsigned long r0 asm("r0") =3D (u32)a0;			\
 	register unsigned long r1 asm("r1");				\
 	register unsigned long r2 asm("r2");				\
 	register unsigned long r3 asm("r3")
=20
 #define __declare_arg_1(a0, a1, res)					\
 	struct arm_smccc_res   *___res =3D res;				\
-	register u32           r0 asm("r0") =3D a0;			\
-	register typeof(a1)    r1 asm("r1") =3D a1;			\
+	register unsigned long r0 asm("r0") =3D (u32)a0;			\
+	register unsigned long r1 asm("r1") =3D a1;			\
 	register unsigned long r2 asm("r2");				\
 	register unsigned long r3 asm("r3")
=20
 #define __declare_arg_2(a0, a1, a2, res)				\
 	struct arm_smccc_res   *___res =3D res;				\
-	register u32           r0 asm("r0") =3D a0;			\
-	register typeof(a1)    r1 asm("r1") =3D a1;			\
-	register typeof(a2)    r2 asm("r2") =3D a2;			\
+	register unsigned long r0 asm("r0") =3D (u32)a0;			\
+	register unsigned long r1 asm("r1") =3D a1;			\
+	register unsigned long r2 asm("r2") =3D a2;			\
 	register unsigned long r3 asm("r3")
=20
 #define __declare_arg_3(a0, a1, a2, a3, res)				\
 	struct arm_smccc_res   *___res =3D res;				\
-	register u32           r0 asm("r0") =3D a0;			\
-	register typeof(a1)    r1 asm("r1") =3D a1;			\
-	register typeof(a2)    r2 asm("r2") =3D a2;			\
-	register typeof(a3)    r3 asm("r3") =3D a3
+	register unsigned long r0 asm("r0") =3D (u32)a0;			\
+	register unsigned long r1 asm("r1") =3D a1;			\
+	register unsigned long r2 asm("r2") =3D a2;			\
+	register unsigned long r3 asm("r3") =3D a3
=20
 #define __declare_arg_4(a0, a1, a2, a3, a4, res)			\
 	__declare_arg_3(a0, a1, a2, a3, res);				\
--=20
2.17.1
