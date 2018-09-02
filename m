Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08241C43334
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:20:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5C3A20856
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:20:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="YaQNOS/P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5C3A20856
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730111AbeIBRbj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:31:39 -0400
Received: from mail-cys01nam02on0104.outbound.protection.outlook.com ([104.47.37.104]:45376
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728700AbeIBRbh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:31:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VhM4mY4JD5dBLr03tJK/jvrBn/Co/8kfJi0/4kQCJjo=;
 b=YaQNOS/PD7xUaB5/ZvfQVV8n5553t0vppg5OjynuxaPTyAJHHCxIUMJ7fT6kd2nJu5050d0/amD0K7xHsuOU238Qnsm71O1mAcqAmjcC16RXw4Wd+0D8NObbrr1nHyMTXTcBd61JRaIGpPnd7fVatsU4vujJIg1o+1LD1O6yGqI=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0184.namprd21.prod.outlook.com (10.173.193.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.2; Sun, 2 Sep 2018 13:15:34 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:15:34 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Paul Burton <paul.burton@imgtec.com>,
        Paul Burton <paul.burton@mips.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.9 60/62] MIPS: WARN_ON invalid DMA cache
 maintenance, not BUG_ON
Thread-Topic: [PATCH AUTOSEL 4.9 60/62] MIPS: WARN_ON invalid DMA cache
 maintenance, not BUG_ON
Thread-Index: AQHUQr78eEZN8TJrBESdtiPGHf/i7A==
Date:   Sun, 2 Sep 2018 13:15:15 +0000
Message-ID: <20180902131411.183978-50-alexander.levin@microsoft.com>
References: <20180902131411.183978-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902131411.183978-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0184;6:62sezdhziTt2ZAxCHiT05XBXhcx5tIkGXuoFjkZV0GaJYe56Y8y5gnCeLOe+lAQqw5+8JewU8E0gXJQWbW1hjVofZZ/lqVlc6+wie+v7IR5Sy/dlW5p5b+Z908B0otqDmot9XDlPzAc4VcO1qb70C/ElnOb+QIo8czCbXSUh9FUi50y0nhZtp+Yuy7O26gP3BWJsmmD+N0suif0tZTFLfNKHSwVehhekGmpnND22R9R5LhQo7H5qUaFkicboLRp0CRuxYTFWOWy+0QEvnEfUX9k4j1APOw4cV9OwheU4ndJg4K2Dexc5BX9fTbPF0bQr5O7IS8vBDxGv69eN0Nhk8BZ5K34zKt4sIZ38nU/y5wkvIMxfejWIo4WMEcg1J8gIrTxxbRh3kWEnqk0aKV54Uql3vcQM239ezFaRe7pPdf9+IJU3gr4IONq29q//u5h8KMeiwCE1+rlUNR2be3m6yA==;5:udidU0fYSsmv5PeSaYDR7r0g9XVs/yXBZYWm2BnQ4Dsyyzvko/GuwY2/1JGqvkgJkvckz54yUOuvvO0H4uDdxLQh7g9v2dhkT6AIm+wLvrCjJxmIMdgxJS8BWr4LJL0hGvurdJSVASw0uHgbMdHA6NkdmPcUfW9ZmvOFUDrofDA=;7:/BYjaQSuza6m9lLMLdnU0/I2YDnDM7v0JqZiA+ON5+FmMrfyAsD7vuayw7jGy8dZpjzRFEJULvpQCRfxRF8jQaR8O3gAXUnIoEHuEsfb9gSaJ/PQuVuopACNnCgpetQrTX09r5TsbmspyXwXlnkjHsGsmwstPy8BGL8Qzhocq3ft9ccRPLaS2X96Hf4j7DW7i5Lszf2bP90T3WxzdNja8+kw/rQ5jfAr4D4ct7dmVwHL6TkwOkdElFhzLa5zc55b
x-ms-office365-filtering-correlation-id: 0edd2851-bea9-487b-e9bc-08d610d62a9f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0184;
x-ms-traffictypediagnostic: CY4PR21MB0184:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0184F0529A1E917278D422B3FB0D0@CY4PR21MB0184.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231340)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0184;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0184;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(396003)(366004)(136003)(39860400002)(199004)(189003)(2616005)(10290500003)(68736007)(476003)(81166006)(11346002)(2906002)(8936002)(76176011)(3846002)(6506007)(5660300001)(81156014)(1076002)(8676002)(99286004)(102836004)(575784001)(14454004)(446003)(2900100001)(86612001)(478600001)(186003)(305945005)(7736002)(72206003)(217873002)(966005)(86362001)(486006)(6666003)(4326008)(97736004)(6436002)(6512007)(6306002)(53936002)(107886003)(22452003)(25786009)(105586002)(106356001)(36756003)(66066001)(14444005)(5250100002)(316002)(10090500001)(256004)(6116002)(26005)(2501003)(6486002)(54906003)(110136005);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0184;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: mrb+sO0/im2ybP08r3JebJM3frpsLHumqkTHLOebOrOwpZUZp2t7QQjip7x2MGH9Gb0sA0vIvYkFpkJFhunyO++4n133fuMkC6ISyqcsQcLuwl/u3lmaVCPNMY72sExDoS0OyMu4GHZsxlE75/s4C7xz1Eyv2OUv8OVIikSwUJYtGi9396E15pqmdp6fNbau4NFwPrWUJmdM+vleP0NqRFhDGFBtZap+weTu68nyQFYML0cUEeSWd1whGVGkq9AElnKji7wNDhd1GF3XtJYtSEUDOEsRilOIOaDeL05bEKukqZKBQCHsmxqVynbsyEXAsgB3Ykex1Ma6Ge0pEjbYT+WcfLluE+HnC5M3MRCNnNo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0edd2851-bea9-487b-e9bc-08d610d62a9f
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:15:15.5037
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0184
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
index 43fa682e55da..0ff379f0cc4a 100644
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
