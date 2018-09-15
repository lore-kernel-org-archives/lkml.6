Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B3C1ECE562
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:40:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2450220671
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:40:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="EhpoH9xh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2450220671
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729811AbeIOG5u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 02:57:50 -0400
Received: from mail-sn1nam01on0129.outbound.protection.outlook.com ([104.47.32.129]:50720
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729605AbeIOGvf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 02:51:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dPKlESEbbukYz3qXnqYFQ3IXnBVDSQaVKEOnIHLX1T8=;
 b=EhpoH9xhUA1DQBWJsfKc8HtUG511oisi3rkzzbqYGGjwLo6GkJa8YOryfwNtnFfXm1m3er35/5lTT390UFmChbO3U0CvM43RolGZEcqI6eZ5Ioh09IlMb5+Qg2lkWHz6m2Nx8wKIgMHDqUu0KJV2grGlZVMTfdSvba6sgr6iEWc=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0855.namprd21.prod.outlook.com (10.173.192.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.5; Sat, 15 Sep 2018 01:34:30 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd%9]) with mapi id 15.20.1164.008; Sat, 15 Sep 2018
 01:34:30 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Paul Burton <paul.burton@mips.com>,
        Huacai Chen <chenhc@lemote.com>,
        James Hogan <jhogan@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.9 07/34] MIPS: loongson64: cs5536: Fix
 PCI_OHCI_INT_REG reads
Thread-Topic: [PATCH AUTOSEL 4.9 07/34] MIPS: loongson64: cs5536: Fix
 PCI_OHCI_INT_REG reads
Thread-Index: AQHUTJQ/bg2DGOOGcECPH0ky+bYHtQ==
Date:   Sat, 15 Sep 2018 01:34:29 +0000
Message-ID: <20180915013422.180023-7-alexander.levin@microsoft.com>
References: <20180915013422.180023-1-alexander.levin@microsoft.com>
In-Reply-To: <20180915013422.180023-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0855;6:HOP5InYC7p35F8OqszDUkC2sgI2krMWeJUcy3KKyU6Jmyloorbxw+ObrwdlhKJqD3pIzJye32IWLGTRpE8yhUvfb4MhL6WMCtwYkgjjY4jAonZtzvO7cjQhR1VoY+Ejdtp7wPe8LiXui9ew1wI9mHnHYfah+jBvi9RORPjT7glRfbOZZjDOo/o1T7wHsWxQMTnoy07C1k2pf4CbCz+AJTlb5rjRctZ5NafNI0Dnrq/c4q4DKHtHCjaK1WGUzN10fWkXrNv/mHpIO//wHp8l9JTZE9tEv6R/OPI1fnVQLHIbXgu7sueX8ga9mHFWpEYPcCw4BDbsjUUXyFIsbTdxDt4dC9Cb3Ctno8AXEI6Ucw4TjoX9O6Dfhqn0tQP9jWeubyRJeeyXMdH9N8CRCsv5x15ShSpr+BJ4TYlohi0nIpqdgRdDJ8TaN9cH/5ROsQhQ1KT8LGBe7DI7xBDgVw5QAhg==;5:d2BislMgolG8u1yjRjVfkyeNTUDpDdbvm6/eq21F6LbRBmLBt/Y+su0OOFXvL3duWYXET502KkLAc/qxC5cAdPk8nNtcncT+dZjOiZXrnWbtm0DJXY/uVQFDf57BvmCB0Ul0CyhTLYRp7xrrmfRa4U5HrD3251ay5KDGfYCo/Ew=;7:yJ8I2KJ0mFpZYW3zPu4IVNi0x4ZPmvoT7o6RY+EByW1QdmQRy2QIvZ3lPYxpSRSGMAKUlky5iFVYDRMpPHMRaFoeYoi08ori7nyyxz/+9PgEuR1bch1ePMD++AYhN/dkwUMv4LUse1D1or6sBGDY6FPHs2XGxCx5kafnjiZ4O0XQvtcTi3yU9OG9Dv+MyMMNro45AsZmtRz1oRerq/6axKRIkepaV1gOtRaAo4ybyj+o7N7HhISJ2ZmxGyD2QrSG
x-ms-office365-filtering-correlation-id: aea1e31a-3577-402f-27c1-08d61aab61b3
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0855;
x-ms-traffictypediagnostic: CY4PR21MB0855:
x-microsoft-antispam-prvs: <CY4PR21MB0855B1D6F172D4F628557428FB180@CY4PR21MB0855.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231354)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(20161123562045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0855;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0855;
x-forefront-prvs: 0796EBEDE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(136003)(39860400002)(366004)(396003)(189003)(199004)(102836004)(6506007)(305945005)(7736002)(10090500001)(575784001)(86612001)(86362001)(106356001)(97736004)(107886003)(186003)(26005)(6346003)(14444005)(5660300001)(256004)(5250100002)(6486002)(105586002)(6512007)(2501003)(2900100001)(22452003)(6306002)(6436002)(99286004)(316002)(8676002)(76176011)(53936002)(54906003)(36756003)(110136005)(10290500003)(72206003)(478600001)(68736007)(66066001)(81166006)(81156014)(8936002)(486006)(1076002)(966005)(3846002)(446003)(14454004)(6116002)(476003)(11346002)(2616005)(217873002)(4326008)(2906002)(25786009);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0855;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: i24y3ops9xmZfSI8kaTJPTDemok/UDXMvJQXeCHzEkYSU/o/blHbzqa8yqDPxHLd9RfpFi0sGPQaLsPaMeDsXZ1rgx7gttCJk+DmR8aqoIycLUcfN4a981vIQfeh99mIQ30atsNqdjHJZZRmCD2zeqI6dQqTEuduPdP2JOC8Noz3oZq2vVnpK1YDcROUQgqpFCtaEgZrr2EIYRqfDIfwaumfV1Lcm9IjpHIFLHOBpg7hSthm7EzkhrG/VEH2lewHV8czG96lhVgBhAt322BZyYAiTHuQb6QrGEzgYWG2pcq7eZVduwWju6wMYTAfDqqFEC30nfbGkTT/+F1MLQQf0t0LFi+5dMnqPFRCXP1HYFA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aea1e31a-3577-402f-27c1-08d61aab61b3
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2018 01:34:29.9271
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0855
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paul Burton <paul.burton@mips.com>

[ Upstream commit cd87668d601f622e0ebcfea4f78d116d5f572f4d ]

The PCI_OHCI_INT_REG case in pci_ohci_read_reg() contains the following
if statement:

  if ((lo & 0x00000f00) =3D=3D CS5536_USB_INTR)

CS5536_USB_INTR expands to the constant 11, which gives us the following
condition which can never evaluate true:

  if ((lo & 0xf00) =3D=3D 11)

At least when using GCC 8.1.0 this falls foul of the tautoligcal-compare
warning, and since the code is built with the -Werror flag the build
fails.

Fix this by shifting lo right by 8 bits in order to match the
corresponding PCI_OHCI_INT_REG case in pci_ohci_write_reg().

Signed-off-by: Paul Burton <paul.burton@mips.com>
Patchwork: https://patchwork.linux-mips.org/patch/19861/
Cc: Huacai Chen <chenhc@lemote.com>
Cc: James Hogan <jhogan@kernel.org>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/mips/loongson64/common/cs5536/cs5536_ohci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/loongson64/common/cs5536/cs5536_ohci.c b/arch/mips/l=
oongson64/common/cs5536/cs5536_ohci.c
index f7c905e50dc4..92dc6bafc127 100644
--- a/arch/mips/loongson64/common/cs5536/cs5536_ohci.c
+++ b/arch/mips/loongson64/common/cs5536/cs5536_ohci.c
@@ -138,7 +138,7 @@ u32 pci_ohci_read_reg(int reg)
 		break;
 	case PCI_OHCI_INT_REG:
 		_rdmsr(DIVIL_MSR_REG(PIC_YSEL_LOW), &hi, &lo);
-		if ((lo & 0x00000f00) =3D=3D CS5536_USB_INTR)
+		if (((lo >> PIC_YSEL_LOW_USB_SHIFT) & 0xf) =3D=3D CS5536_USB_INTR)
 			conf_data =3D 1;
 		break;
 	default:
--=20
2.17.1
