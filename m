Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5E41C43334
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:10:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96805205F4
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:10:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Qjs+n6bF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96805205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729627AbeIBR0I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:26:08 -0400
Received: from mail-bn3nam01on0091.outbound.protection.outlook.com ([104.47.33.91]:56192
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727876AbeIBRYr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:24:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NAkjcfewxpI2QlG19WEufUMyDX8xZOWLvvRwYidC080=;
 b=Qjs+n6bFssyuBcno3kbfEyAdprrbpM0cC+Ss5r2KxBV71LH/ZD2scaRGye6G2DUgwInZ8Q6btBb0t0XFvuY+ZEUx/ec6ll6uvdfMzl4mnduBGzTbhODLLUYXcsVAvK95EsfbACLVGsiBRZBM99DX/jc/rmF8KN5yq0IgBVsGHIg=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0469.namprd21.prod.outlook.com (10.172.121.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.2; Sun, 2 Sep 2018 13:08:52 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:08:52 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Paul Burton <paul.burton@imgtec.com>,
        Paul Burton <paul.burton@mips.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 87/89] MIPS: WARN_ON invalid DMA cache
 maintenance, not BUG_ON
Thread-Topic: [PATCH AUTOSEL 4.14 87/89] MIPS: WARN_ON invalid DMA cache
 maintenance, not BUG_ON
Thread-Index: AQHUQr37btZZ94ApKE6wyQXJVJIgaw==
Date:   Sun, 2 Sep 2018 13:08:03 +0000
Message-ID: <20180902064918.183387-87-alexander.levin@microsoft.com>
References: <20180902064918.183387-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902064918.183387-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0469;6:2Z2IJ6JTD1Ch3TuAvRZXytsYowNZkdbyQgZWNrF+v9SbQQYV5flscHCEeGJ4u90KyhrqrS0oKLeGoCvo8unAFd287VJbEIhqRDVlIxXZEbI02tlB7kxrVv+UvkxIkyhpDeFhh/fqKIUdsMsl1EfPZ8JoZ9PUC9jXHPUcQrwghrnEifa504k82UgFSDYP7ZK1jOhFCniEjz8FMDeIoWax0QqD8uaubeuxeFmTJbttbexaNUAdwCSYyAq22Sd5ky9V8kuY4fgJ5kNPnUBN2dGK+sruF+O9JxowJDZlfr2QTMltfkE+GQ/UE9Ne0+z0kGJbW60UuBlI/+WzCzuD/gLIEoWB4DEEfFK+7G4NOXTuSHgSdaJUOsYMHeIHHTpzPrskSAq+Hr8PkzA7ghxHLOSt4JnvhKQYxkzwQNyAdTARm3YfqyTIaV5lkEv8uw/mlhwiNiCUQXAmFHVSvd6YniC9Dw==;5:flQOWE/CAKE2SZw0EhnfWfwZZ6A4n2HI24uM8BN0r2wChxIFZ2doD1LVwhRAwSk5yvOWOguTA3b1fIlW14RQNnxLEyFkJsCygZghUxSKDkwJS7uiN+8v+rLkFr+CuUIXF79UxU4jbsvXSN+Lo3qnryH61ZzAOxPJPQYq2S9VmUs=;7:70S5GOT69BBhNEBeeo1cyAS+m4yMhVqoy1QecQgjqPmNY2LdsZxh6Ejyn1cEOIIpPU5cpiYRQgqKb3JO0237cPW53VpOJUchFWUIKJsWmW/3Uiku5l7Xdv8aLepMJ1RkYbczn7aMad5veAk6fy3eT+j1MEaVDQNFDOZEB8UuE4dsmK78B5UBQC/itjOklzm5MZWGQyxfANsKSE4K5m36ahbtUWs0QFH6Y0qHMZhglkH2REBZaaiGi761VdnkgoEq
x-ms-office365-filtering-correlation-id: 93deb4e1-e8f5-4f5b-33f0-08d610d53ad5
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0469;
x-ms-traffictypediagnostic: CY4PR21MB0469:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0469038223B3A0D6EB7AEE4DFB0D0@CY4PR21MB0469.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231340)(944501410)(52105095)(2018427008)(3002001)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0469;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0469;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(39860400002)(136003)(366004)(346002)(199004)(189003)(110136005)(68736007)(36756003)(966005)(316002)(72206003)(54906003)(2501003)(81166006)(81156014)(8936002)(14454004)(97736004)(10090500001)(25786009)(106356001)(7736002)(2900100001)(4326008)(2906002)(8676002)(105586002)(305945005)(5660300001)(53936002)(1076002)(6116002)(478600001)(5250100002)(6666003)(3846002)(107886003)(10290500003)(76176011)(11346002)(99286004)(6486002)(6512007)(6306002)(6436002)(2616005)(66066001)(6506007)(22452003)(446003)(26005)(186003)(86362001)(575784001)(217873002)(476003)(486006)(256004)(102836004)(86612001)(14444005);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0469;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: qZojJxV1HDmPAnlRUPyqvVsJ5KOX1pXMUZWGbbKKMCEfdF8M/PFrCd65hNHOghfznp71ov5pGjGebkyJLwo1epHTchZXCDJWepuLb1yC+qulqYkcTCDwirHC0mmbsp6/UHhZsV67lFdS4p4VIPzL1zFtt9WSyiBvlhd0v9F2zNdbN4gmkadgrUnHneosx6B9CxEdwhhPsoQn7nuXxXH3RNBbAym+UB2jZnNDYB6m4bUD9ViKvNakKS4zwKj7ENMJEkDX0H2dRYPU9wyDZY2HfPTBWgoQZ0tAWFtj35RGOq28aADQnz1qnAQeWqBIkZMYtj7RzpWZdbJ+qfpOU0cDjSFSvGsZmgit5qkIUkoqai4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93deb4e1-e8f5-4f5b-33f0-08d610d53ad5
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:08:03.6805
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0469
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paul Burton <paul.burton@imgtec.com>

[ Upstream commit d4da0e97baea8768b3d66ccef3967bebd50dfc3b ]

If a driver causes DMA cache maintenance with a zero length then we
currently BUG and kill the kernel. As this is a scenario that we may
well be able to recover from, WARN & return in the condition instead.

Signed-off-by: Paul Burton <paul.burton@mips.com>
Acked-by: Florian Fainelli <f.fainelli@gmail.com>
Patchwork: https://patchwork.linux-mips.org/patch/14623/
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/mips/mm/c-r4k.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/mips/mm/c-r4k.c b/arch/mips/mm/c-r4k.c
index e12dfa48b478..a5893b2cdc0e 100644
--- a/arch/mips/mm/c-r4k.c
+++ b/arch/mips/mm/c-r4k.c
@@ -835,7 +835,8 @@ static void r4k_flush_icache_user_range(unsigned long s=
tart, unsigned long end)
 static void r4k_dma_cache_wback_inv(unsigned long addr, unsigned long size=
)
 {
 	/* Catch bad driver code */
-	BUG_ON(size =3D=3D 0);
+	if (WARN_ON(size =3D=3D 0))
+		return;
=20
 	preempt_disable();
 	if (cpu_has_inclusive_pcaches) {
@@ -871,7 +872,8 @@ static void r4k_dma_cache_wback_inv(unsigned long addr,=
 unsigned long size)
 static void r4k_dma_cache_inv(unsigned long addr, unsigned long size)
 {
 	/* Catch bad driver code */
-	BUG_ON(size =3D=3D 0);
+	if (WARN_ON(size =3D=3D 0))
+		return;
=20
 	preempt_disable();
 	if (cpu_has_inclusive_pcaches) {
--=20
2.17.1
