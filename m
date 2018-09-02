Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70CB3C433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:07:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FF3F204FD
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:07:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="g8ONuwDs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FF3F204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729311AbeIBRXX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:23:23 -0400
Received: from mail-eopbgr700118.outbound.protection.outlook.com ([40.107.70.118]:63159
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728494AbeIBRXW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:23:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oZvZRH0wjT3VZnaQhTxOBCKg1c7rFSmXT6CDnH5762M=;
 b=g8ONuwDsPDiMB4GdfMwXz0sPEVFkX4aWMM8zPqYUpv2/oBIdKm/3dtOOJPbu3yLIqtOIprETrlhWc82UMlx/c9hcanX3g1IJVffI0lfKZkwjpNbeIuHrAAyxIyyZRG/R8Zih6fF4bVyrx4hOoTSbkldRjmo6x+PIXw3pUZmCeRI=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0856.namprd21.prod.outlook.com (10.173.192.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.1; Sun, 2 Sep 2018 13:07:10 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:07:10 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Vladimir Kondratiev <vladimir.kondratiev@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 40/89] MIPS: Fix ISA virt/bus conversion for
 non-zero PHYS_OFFSET
Thread-Topic: [PATCH AUTOSEL 4.14 40/89] MIPS: Fix ISA virt/bus conversion for
 non-zero PHYS_OFFSET
Thread-Index: AQHUQr3TNCk3b5hk2kuy7epqLhr2wQ==
Date:   Sun, 2 Sep 2018 13:06:56 +0000
Message-ID: <20180902064918.183387-40-alexander.levin@microsoft.com>
References: <20180902064918.183387-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902064918.183387-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0856;6:erQtjNRij95+TyrnhaYnOrjgPMnyUDydlek0FdgMujuziv2F3ErO54aUgjT1OiBhh7HW9C7XKKhILyxwXpvA7iF2EvZMu7Y3WDEu86N1zbprA9U373KYBsgMvwjI9bm7beUz/IiIhdoi6XfI6aaWu5hzaKyQXBLXbHQBMDxmm8c2MoftreHIINsOggG1z/KdMMefaDzfaiN3tzXf+NitD4ZfWZCKVjAP5Kwa8MZ8j46k9Gf40lUpFgqpvKU8SWVSQdVlQf5Yd+LxzgvtfZ6EquCUY/MWV1oq9GlBhZ9a7zItR6Y7AiWJiqiTnaBIczN4ueyy9s96ylHCwqFXK/2+jWGqnbsIB4KNrC1zPvwFH9ULmMjV0atimCvmlVXEvNmBGtI1BUkAasZVmjXGUbqrPb+Jwg3pculuHt4s0mzSi+LJ7/23/Ef8+esESd1dsuzyw0ER/8Q/U8cMQ2ugtZCypA==;5:C6uWmfNreEg80kBNsFE35jxJdSSo0LREzcOTvARJLjHIGp5GAIiDH7FZFdP4mPG6JXzyq40hShmY5jvSP/bfgDEwS6DBEWhd4pWQWhrQv+CH8m8qQuooa+FUrW1n3SfMyRgbx8AzPQYdbjPa33cillMG84QIlgdfO0Ux5jOObXo=;7:NkFVmIhL2n0yra9skWOADZaWhVh/GN1/qBUJB0dWXTksgn2m9XssFXnQcFP+AAmtWSO/N7qNTpkeFfoyj/r+05zknkdxNL49C6/v+xxE3GTCxOeOVSlAmXzfOjKquKzP3Yw2bkUR/cZYUJJu4usEb67eHOgNWZ9wfSzpHe0DssOLpuo3aR4s6/xc8GoUqdJEQKdoAqu6ftAwR4V/UkuEEdueVfihsRhUKFgw+nuiIFsEJYS4w0aVYp/iLXqAzDEr
x-ms-office365-filtering-correlation-id: 44e56aae-77b5-450d-7572-08d610d4fe6b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0856;
x-ms-traffictypediagnostic: CY4PR21MB0856:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB08565C6C7303F005C8DEF019FB0D0@CY4PR21MB0856.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(228905959029699);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231340)(944501410)(52105095)(2018427008)(3002001)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0856;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0856;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(136003)(346002)(376002)(39860400002)(366004)(189003)(199004)(53936002)(81166006)(11346002)(81156014)(446003)(476003)(4326008)(5660300001)(25786009)(86612001)(8936002)(26005)(6506007)(6486002)(102836004)(2616005)(86362001)(6306002)(8676002)(6512007)(6436002)(107886003)(66066001)(256004)(10090500001)(217873002)(14454004)(3846002)(478600001)(1076002)(72206003)(6116002)(99286004)(305945005)(7736002)(22452003)(36756003)(76176011)(105586002)(486006)(106356001)(2900100001)(186003)(97736004)(68736007)(6666003)(316002)(966005)(10290500003)(2501003)(110136005)(54906003)(2906002)(5250100002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0856;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: GilI54WFIwW+RJXZBwa/l7A6c0e0zsyE/Txm7Us2qZoNrmT2hsPWW2ucrC0+OjuTRS09DZkmQHIO15Xp85b+8D3EpgMgNbSUbwnyLhbbkiIL1q0gISSP0/R+wpvi0OhZB+Xsc8BTkDz2edCLJGzPRgn7OCXBlYZeXMYiEuzFAnSw0izjGtLIV6SQznzmR/j/hmLBK4bb+lfs5oVJf1gLQI4NPXEIB434lLotOekpzZP03LdMotAmAUBteuwub48MU3KF+vL0EGmvKil6XBKY37DgY+7usvFJn31IwkBEWUD9jEw4Zq4RRKZiIhu1C43TvTxHn6FnPiNDJllClLDwkj6Rq50C0NZXvmo7jsK5I7Y=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44e56aae-77b5-450d-7572-08d610d4fe6b
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:06:56.0708
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0856
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
index cea8ad864b3f..57b34257be2b 100644
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
