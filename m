Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9014BC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 02:47:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EBF121524
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 02:47:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="aGi8Ns8C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EBF121524
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733291AbeITI23 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 04:28:29 -0400
Received: from mail-by2nam01on0122.outbound.protection.outlook.com ([104.47.34.122]:34106
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1733225AbeITI22 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 04:28:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YVtdeD8aCs1is62NGL0lbbU5JLBMryEwLUvRTrSFYrE=;
 b=aGi8Ns8C9vUTc5qrc9APnwrYJObw2u1Gy11KxtDt15x+4fvifXG3qNJWBmWoOMHt76JSiDpoQZ0wr0I0emTZybHnRlVJBfdyXyhrim0oLi37J/5eqvrOR12+JnyRExhp5aE24kpTaI5gTFZ0peSjuahk3FvLRxZ53Y+GQT8TYOo=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0149.namprd21.prod.outlook.com (10.173.189.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.4; Thu, 20 Sep 2018 02:47:26 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.010; Thu, 20 Sep 2018
 02:47:26 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Tony Lindgren <tony@atomide.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 01/56] ARM: OMAP2+: Fix null hwmod for ti-sysc
 debug
Thread-Topic: [PATCH AUTOSEL 4.18 01/56] ARM: OMAP2+: Fix null hwmod for
 ti-sysc debug
Thread-Index: AQHUUIxD0jNfCYeG5kykQwGK2TJi3Q==
Date:   Thu, 20 Sep 2018 02:47:25 +0000
Message-ID: <20180920024716.58490-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0149;6:nfn03UpiaL0VyfhyyuYteUsX/4N+QOIfmH/sZkyPIzwv2Qr8qCQhmrkU69sV4Jo5EEbShcA9VzEh03RNf2HktSewIag2hYLn3llk+tO5fGfBuOSR5Etl7GO+wlo+899GmKgXvPbaL7ZIiVWofxZYow2DmULWt0M8T3y0ptkTZw+01u9rL3U0KcRSABXB2nARn2uYzfTN/PJ9ynGOwhOIkwwLLJdfyBP8BD/tTzqmpYe3d/ONhVrXihOOH2qk7F5p8NkBaNYrg8vn2GcDTU7zOkg63f5bqGt3W33eHKfoyQRRwuE3om9NNClmDP90yMjbkTEjX4Ru/tQgI1VChUvsRlZ8+l+SWuaeNjzGH9WoOC7zYcX6hNT/Al/tnosdHqsrUgNoTeoJAEzSpARtG6eN02dv1X+wV7jHR4dwL0OMp/gGDAYCeqG9PXK7SQPjXbLCHuTZDTJn4wAs7I9F/I+Pug==;5:JnhxZJkqPILf0MPV8NkOKMzN12DE+/n1U+sXI/Wvivz5IRc0jGWG5XCYJPprqpcFFXvNZFkfApCVs1Zo1cLOpmcDvPgflJAGvfE1wb7uaavgbawAt65zAh4roZ/lVpIVMC1OXvveb8jPq/azhDqeTt8uHD4sGPQBYLhKHTWiLAA=;7:3IzWqBEhyoxWUxuRsozU9yIq0dMZldT1s0FxUw20I6Ss+MnOgA3dQgXIBZJ0+DZRPHLgsHlgUZAnLXehfKY733nAYtkz806sM/DPPsCd38TIcR0yNdyoFQf/BVVpj0ijWtWD7qJJFJhuhfbse67IXyLPagrf4N2ARMJDhz2N0/Of9XGEfiJ4ztlMQUZ5m2qJuXOVxEBU/xq6hW0fNmFTmkIKbBdg49MubqbarIGBChJYJxer5VJII34VLOpG8NJ9
x-ms-office365-filtering-correlation-id: 845d6abf-81cd-47b9-fb9b-08d61ea36623
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0149;
x-ms-traffictypediagnostic: CY4PR21MB0149:
x-microsoft-antispam-prvs: <CY4PR21MB01491B8553585CF794BA7019FB130@CY4PR21MB0149.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(2018427008)(3002001)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123558120)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0149;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0149;
x-forefront-prvs: 0801F2E62B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(366004)(346002)(376002)(396003)(39860400002)(199004)(189003)(86612001)(7736002)(81156014)(305945005)(10090500001)(81166006)(8676002)(105586002)(106356001)(66066001)(2900100001)(6116002)(3846002)(1076002)(486006)(5660300001)(2616005)(476003)(14454004)(478600001)(72206003)(22452003)(6346003)(316002)(99286004)(26005)(186003)(6506007)(102836004)(54906003)(110136005)(4326008)(25786009)(107886003)(36756003)(6436002)(6486002)(86362001)(575784001)(2501003)(5250100002)(71200400001)(2906002)(71190400001)(68736007)(8936002)(10290500003)(6512007)(217873002)(97736004)(53936002)(14444005)(256004);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0149;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: sINcubcO/+YNAvX6q2Lve3IN+P45jsU+aacmoR7JrPjA5JPmztfKm9qJwTj4Pzi6A82gxmT0YVuG9a0B0IWh+0JW5AWOO/yAaqY2zj/z7L5VZIF+YlMV+rvwPQ3uvzeht8JUFq/wZEFO9tSNaIgPRWXb8OgTFMBSJlVJfDrtXEKD0+z2vs/eeYuD5cTn1GaZTXgW/U1/OQ2CH6BlgRUQbJ5MkixcxMKSyIORV7JQ01aYvTf3Ep03XIVqEazM4LVz431Yqfl+JLFzxpi0jeArY4gk2KKDhHeaDQHIWI9YwIHw91lN5WbZZv0LuZN6byh4R3x4l20wxKxkXzQHzxFC73hQ+wESymxFxHuVQWBY6/Q=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 845d6abf-81cd-47b9-fb9b-08d61ea36623
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2018 02:47:26.0078
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0149
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tony Lindgren <tony@atomide.com>

[ Upstream commit 4769c003e0fcff0ee001a9102e2605bdaa5880f0 ]

We may call omap_hwmod_parse_module_range() with no hwmod allocated yet
and may have debug enabled. Let's fix this by checking for hwmod before
trying to use it's name.

Fixes: 6c72b3550672 ("ARM: OMAP2+: Parse module IO range from dts for legac=
y
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/arm/mach-omap2/omap_hwmod.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hw=
mod.c
index 2ceffd85dd3d..7f759abcf49c 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -2220,7 +2220,7 @@ int omap_hwmod_parse_module_range(struct omap_hwmod *=
oh,
 	size =3D be32_to_cpup(ranges);
=20
 	pr_debug("omap_hwmod: %s %s at 0x%llx size 0x%llx\n",
-		 oh->name, np->name, base, size);
+		 oh ? oh->name : "", np->name, base, size);
=20
 	res->start =3D base;
 	res->end =3D base + size - 1;
--=20
2.17.1
