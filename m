Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB0BFC43334
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:14:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5836420856
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:14:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="WYNL/1En"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5836420856
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729782AbeIBRa0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:30:26 -0400
Received: from mail-co1nam03on0128.outbound.protection.outlook.com ([104.47.40.128]:55583
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728460AbeIBRaZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:30:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d13S8VPu6XUkd7FETJ2ADnFTbPW/vQjb1CegKJs6NoQ=;
 b=WYNL/1EnrKXHKERJs69xWY1fc2BzgbODAGjLSz5KtLeJ5+QGujVmQWQO/a7+ifQWrCsYMyS67qSrYUqi5w8PLMAiA3mvgqJrhs40dRniTQ9aXrBZ1RauH6wD2RJGGONPdQvfuaAxNHYcdRpXOxCKLOcOv12zBfvIZYRSOS6pzz4=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0120.namprd21.prod.outlook.com (10.173.189.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.2; Sun, 2 Sep 2018 13:14:28 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:14:28 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Vladimir Kondratiev <vladimir.kondratiev@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.9 22/62] MIPS: Fix ISA virt/bus conversion for
 non-zero PHYS_OFFSET
Thread-Topic: [PATCH AUTOSEL 4.9 22/62] MIPS: Fix ISA virt/bus conversion for
 non-zero PHYS_OFFSET
Thread-Index: AQHUQr7gHyU5UJdoIE+Rx6Md3cnc6Q==
Date:   Sun, 2 Sep 2018 13:14:28 +0000
Message-ID: <20180902131411.183978-12-alexander.levin@microsoft.com>
References: <20180902131411.183978-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902131411.183978-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0120;6:7TPTUjGu5WZSMYcQb2nhePgrQYU06wJhJFxOjBJS190/DiSc3CxPZqZygu6g1R0u4sBN/l9Mk1FYV/IPrEoq75f0CoJ6BdqfTAkQE8ot7byc6WEsDzRxLSdQn0KGtx/Zt4R2IxvlVeYTZ01AiDuhmVzdQWBuPTs9FYdh0V/CUQvmbpCOmw6RuMGtz9vDSfg0nsnfr9eRkHymJtzQr+QcdpmE4MkE46SzgF2rW0zi7pByjVyTWcsUwyYrTIgc8AMhn7MnwK7KLUKmx4VjPYVxHtTgKi9x2aBT/J8+7rPzQjqo4EbH6odCpr1rPsXTjpPiY4DMNwdqO7ZKbwl9MbDfNnebZc0V+JXB927fk3XqDjXYoaFFOj1JrgMNeTig/C4UlvH5O0eDIkHb1HWI7myxZEdzJqiDDXHdIAqlkqmNlf2cyy4gfU0+DJauqaQv25iO35cnZzWvVxYz4eY7kxKF2g==;5:4l3NXB3D3Ge6OXUcnxtSu3sr76Cye8mCYSdaNCm5+8z+hw2YAhqeqqZm/+PaNYOJgY+zgB7lyIgV8L7y8qVaNqiP59DyIWWvFevdWdv9ONdCLvoYekxzWwDBXzsWXly8V9zBKQWX2Nbpgu/ojHzFIjAvijh9xaZ4vodWXX8AZv8=;7:+qROScjEtEMJlAEzPjjB14h4zx/DNz5z+WhWeoeqZMZO9hL9cAyhYzyzF9/hNtRdQ+eTat1nNuldaRfM/L6kx/LojNIQAB9qoD+F82Rr01Hvmi6o/ZcP5hibkPJdVZUVRFna8XmRzOyQSykSjmg7fSX/bQxJP8GvPlnF5/b1IkPuDJtKvI2WRkF/s9sTMR+5e40fEdyLN3zemnNrHNAA6YDdhW4ljfNuMib2siIN97hI9+O56kVSPQ9qgLmo8UKv
x-ms-office365-filtering-correlation-id: c16787b8-4d64-4ccd-b740-08d610d60338
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0120;
x-ms-traffictypediagnostic: CY4PR21MB0120:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0120BF7D0F220C3582DCAA8FFB0D0@CY4PR21MB0120.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(228905959029699);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231340)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0120;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0120;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(346002)(136003)(376002)(396003)(366004)(189003)(199004)(106356001)(53936002)(72206003)(966005)(5250100002)(22452003)(97736004)(6306002)(6512007)(10090500001)(2616005)(2501003)(446003)(11346002)(478600001)(10290500003)(476003)(14454004)(81166006)(186003)(486006)(25786009)(4326008)(36756003)(102836004)(8676002)(81156014)(105586002)(8936002)(2900100001)(99286004)(66066001)(68736007)(110136005)(26005)(107886003)(6506007)(5660300001)(76176011)(54906003)(316002)(1076002)(86612001)(3846002)(6116002)(256004)(7736002)(6486002)(86362001)(6436002)(305945005)(217873002)(2906002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0120;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 35TBCwINyQS7p84CoS9TV3raY55CqG4l7Zb30ZaZexKNBtARPTTXqlapHlxmpLj59P8o25FXolE3Ze3pp/Vj3hZUQZt6LO/3nJxKtmWmkiy2a+wcPq+ar28Jy8BsZykd8IyrUjHA8GSl0/kr0RcIf+j8gCMjJYH4RIsAldRcL8o1X8oeU3z38Pz7hhvggx/QCVbW6N0MHX85JHU7Q6emopOE9L24SgyGiuSbAVA/EkYEgBd/OE67H9+9Y/5NxLGDPKBixzkj2zJJNwwazuP/8R72c3ZYD1GH1UPPi3L4ZciKSxQbbImvabMdIOT8fJ0VPqEabiFYjM3NvhdZHXxgmB1QjpdsN84m8qYFotVzV7s=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c16787b8-4d64-4ccd-b740-08d610d60338
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:14:28.0706
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0120
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paul Burton <paul.burton@mips.com>

[ Upstream commit 0494d7ffdcebc6935410ea0719b24ab626675351 ]

isa_virt_to_bus() & isa_bus_to_virt() claim to treat ISA bus addresses
as being identical to physical addresses, but they fail to do so in the
presence of a non-zero PHYS_OFFSET.

Correct this by having them use virt_to_phys() & phys_to_virt(), which
consolidates the calculations to one place & ensures that ISA bus
addresses do indeed match physical addresses.

Signed-off-by: Paul Burton <paul.burton@mips.com>
Patchwork: https://patchwork.linux-mips.org/patch/20047/
Cc: James Hogan <jhogan@kernel.org>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: Vladimir Kondratiev <vladimir.kondratiev@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/mips/include/asm/io.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/mips/include/asm/io.h b/arch/mips/include/asm/io.h
index 853b2f4954fa..06049b6b3ddd 100644
--- a/arch/mips/include/asm/io.h
+++ b/arch/mips/include/asm/io.h
@@ -141,14 +141,14 @@ static inline void * phys_to_virt(unsigned long addre=
ss)
 /*
  * ISA I/O bus memory addresses are 1:1 with the physical address.
  */
-static inline unsigned long isa_virt_to_bus(volatile void * address)
+static inline unsigned long isa_virt_to_bus(volatile void *address)
 {
-	return (unsigned long)address - PAGE_OFFSET;
+	return virt_to_phys(address);
 }
=20
-static inline void * isa_bus_to_virt(unsigned long address)
+static inline void *isa_bus_to_virt(unsigned long address)
 {
-	return (void *)(address + PAGE_OFFSET);
+	return phys_to_virt(address);
 }
=20
 #define isa_page_to_bus page_to_phys
--=20
2.17.1
