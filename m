Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44B07C43334
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:17:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6DA020652
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:17:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="lZxsd/wo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6DA020652
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730440AbeIBRc7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:32:59 -0400
Received: from mail-sn1nam01on0111.outbound.protection.outlook.com ([104.47.32.111]:9515
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729243AbeIBRc7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:32:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WBvlyOLCcy7D+Vpf4C1GReY5O54R7hm8KnUsjQaFGe0=;
 b=lZxsd/wozxlCXXZI659nBXLt/uOAkcpkS7CW3xayi9YnYBPN3x4rDOle1k+H+lDNIkAu0fGeqRl2VMWZezNpYCvyjPrx3yrcchXfs/+z1phJCkZ7HEhElP2QaLDbBEv1gvSqb9BGCVMv3czD+VjOOqTIfE0el+NMyoj7XQWNmHw=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0167.namprd21.prod.outlook.com (10.173.192.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.2; Sun, 2 Sep 2018 13:17:03 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:17:03 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Paul Burton <paul.burton@imgtec.com>,
        Paul Burton <paul.burton@mips.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.4 45/47] MIPS: WARN_ON invalid DMA cache
 maintenance, not BUG_ON
Thread-Topic: [PATCH AUTOSEL 4.4 45/47] MIPS: WARN_ON invalid DMA cache
 maintenance, not BUG_ON
Thread-Index: AQHUQr8qsOr6YmFPaUmIYcE7QL10dg==
Date:   Sun, 2 Sep 2018 13:16:32 +0000
Message-ID: <20180902131533.184092-45-alexander.levin@microsoft.com>
References: <20180902131533.184092-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902131533.184092-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0167;6:NAcJNCayNor9dycczAEVxayrsbVxy6ry3rexMnSYHvw7aqhVhdH3jnUGO8Ecw3/3BxcNYCKY/J8dmnHgFX4a1nQpjEhv1vwrSt89nQE321i1p6nzkjHMFj/Yn45rr9gX4mk+HwE682ON67oEAV/pU1c8JO6akuqkRr9/tZGNTznXCbL1A4kEEiHHnnH+xIOU0mMkh5mt44OCJHU16iljePDLd+clXWagbz2y3Ahp3qvd5t5xMy6WOd6dr6nFJ3OpH5wM7MmLWqrSqaWxh/ORpcXbhXYsmff1tLOFJipmupYPo6RSQmiaGiOcxS7ddTt4Wj4P8bg7C+dYsD/RtBO79XlLr6vMDRujjOuXllWd5qc+CDT16cYE08eNlsAKUrxkj3foXtps6y6Y+/thzvvqF5H19QXR4gBYPCnmo9f2w6Pc4jm+k9FUGqj5alULpqGoO51+STFfDHv5i41NPPSlmQ==;5:iaiHuQZZSCjqnh2MjxocUtwGDKO2GkkL7qRETTuhPN8JV0p6E/wZ1/myUYIIhzZJ/F1jD2awKOK/2kIQmkc1KNpItNCAMOY3CtNHp9eHfbpxxK3wH5bGUcDMaXGX5+uhJodm6+3evF1aADux4EqPBcOWXUIWJ1pU7JAIDED/kKA=;7:1RK7s4DD83FyQliUVlbV+4BUv+g1JC6iCWfsJ55pkdSyWl1wDPOwTXbWwYTGiLZuYqwn5sI02dI+DRoGXRnOmwaUgpE8uSYuCMjqFpnFKaZR7lZdH1n/I76GuGYjy8E7LOvz6ywgwYKwINGX1KdUwRAoZQum8BAVUWWpBB1sudaoDk8HBKaNVxaK/8liHh7mmtL4UTtFVD0EvpewXO/xwhdUb+CaFcjzhgFWkW0xbNvVW9pmy7jg3f/LDT1ruF7n
x-ms-office365-filtering-correlation-id: 028c8dab-a72e-473a-e588-08d610d65fcb
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0167;
x-ms-traffictypediagnostic: CY4PR21MB0167:
x-microsoft-antispam-prvs: <CY4PR21MB016792D4A7581E6D34402F26FB0D0@CY4PR21MB0167.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231340)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0167;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0167;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(39860400002)(376002)(346002)(366004)(396003)(199004)(189003)(305945005)(6436002)(7736002)(6486002)(106356001)(105586002)(6512007)(6306002)(53936002)(8676002)(36756003)(6666003)(6346003)(186003)(476003)(486006)(26005)(2616005)(11346002)(446003)(5660300001)(2501003)(5250100002)(10090500001)(102836004)(97736004)(6506007)(2900100001)(81156014)(316002)(81166006)(66066001)(22452003)(217873002)(2906002)(99286004)(54906003)(1076002)(8936002)(76176011)(68736007)(110136005)(3846002)(10290500003)(4326008)(25786009)(478600001)(6116002)(86612001)(575784001)(86362001)(107886003)(72206003)(966005)(14454004)(14444005)(256004);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0167;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: PTKIRa/5V5plvSHodFb4Y0VqKTCMwHmgPzd5FrE7JGWTI7MuxWiM94WKlioCmgoYo1IlWS23wf2b1K5aW30z/1z1WCxXKcR/ThfirfzJaeciqEG9zQPlZrupESXEzoIEGoNt64M2jxQ63uJvFySrMmMxseUEz2rTS+5T4qfozoNPjYAGti3R3abUk6e8MyLRbEFmfleMKbQ4XwuVvcz0Q6cMOufv+YArMfP9pJckc1nGvf2hH6Z3vC05/VBm+GV1SREwKTdSVFHJ3BQYUVcY87O0n+hcbtUgAgQDcILlwFICwo7SMLdbfdCwhrOI++RrmZkf+i7KLw4tI2UfdvVoXz47B3KeRyK0cToqj5rTw2Q=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 028c8dab-a72e-473a-e588-08d610d65fcb
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:16:32.3830
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0167
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
index 5d3a25e1cfae..52e8c2026853 100644
--- a/arch/mips/mm/c-r4k.c
+++ b/arch/mips/mm/c-r4k.c
@@ -712,7 +712,8 @@ static void r4k_flush_icache_range(unsigned long start,=
 unsigned long end)
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
@@ -745,7 +746,8 @@ static void r4k_dma_cache_wback_inv(unsigned long addr,=
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
