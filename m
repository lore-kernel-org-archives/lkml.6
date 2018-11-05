Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A6FBC46475
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 11:14:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2677D20869
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 11:14:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="C2bfItYj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2677D20869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729525AbeKEUdn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 15:33:43 -0500
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:24124 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729496AbeKEUdm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 15:33:42 -0500
X-IronPort-AV: E=Sophos;i="5.54,467,1534834800"; 
   d="scan'208";a="22824217"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 05 Nov 2018 04:14:30 -0700
Received: from NAM01-BY2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.108) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Mon, 5 Nov 2018 04:14:30 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oh/okI0n2t8fOleOgIm1xdXggcUktWVVRB6LkZufSsc=;
 b=C2bfItYjVPYj2JaobrzzGXP06I+fbeSWi3P88oCUK4Gpuyvjzvg82VUY3u7IQ6hkyYrOmPwhM+96J0+L8d+E/kj7n9zaYp3axNIB0m9akS3gJz1LxY4T6GBnPMJKm53E/uYBEAGpmJjk7sRFVoPRoDNfX6bN0xSQ5pOKqORH9K8=
Received: from BY2PR11MB0744.namprd11.prod.outlook.com (10.163.112.142) by
 BY2PR11MB0647.namprd11.prod.outlook.com (10.163.159.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.26; Mon, 5 Nov 2018 11:14:29 +0000
Received: from BY2PR11MB0744.namprd11.prod.outlook.com
 ([fe80::d0a5:29e0:506a:76a8]) by BY2PR11MB0744.namprd11.prod.outlook.com
 ([fe80::d0a5:29e0:506a:76a8%7]) with mapi id 15.20.1294.032; Mon, 5 Nov 2018
 11:14:29 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <sre@kernel.org>, <Nicolas.Ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>
CC:     <linux-pm@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <Claudiu.Beznea@microchip.com>
Subject: [PATCH 3/4] power: reset: at91-poweroff: check shdwc data structure
 at the beginning of probe
Thread-Topic: [PATCH 3/4] power: reset: at91-poweroff: check shdwc data
 structure at the beginning of probe
Thread-Index: AQHUdPi4+s+ozNW3FEOixfyfnTwbtw==
Date:   Mon, 5 Nov 2018 11:14:28 +0000
Message-ID: <1541416443-4321-4-git-send-email-claudiu.beznea@microchip.com>
References: <1541416443-4321-1-git-send-email-claudiu.beznea@microchip.com>
In-Reply-To: <1541416443-4321-1-git-send-email-claudiu.beznea@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR04CA0064.eurprd04.prod.outlook.com
 (2603:10a6:802:2::35) To BY2PR11MB0744.namprd11.prod.outlook.com
 (2a01:111:e400:52de::14)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Claudiu.Beznea@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BY2PR11MB0647;6:NdNpTJ2AES7ZbvwkGDKNRTJ2y4xvRD/HvGspvgrFl9ClJkQ8bQ3at1aBVtyBxCwesl0uDnujTkr6rhIibixgXV2CsLdX416+rIf+yc4mhln0WOTtoTKoknXZA2XqmBTE2hKg9LfkNmw0qItrgFHTqL+HAooJ/HU1ZwKV9KlcwqztNQLecpKa5JaKHijzFxTJmfd+9g0eq4S3wd/agHXwHEC17tMEKH3/AyZG88K++JwRRX7AX0Bie3NcJZeHFdsftbm504qbNXhMXeE+mDosXfFvnvFKfQW0TY173r834JEnLRRcfFCVjBizUx4AAkIqdFd92SMAmo4GDLBimbD8c3C/illHhIsnzDrvlXcZ1KcZBs8MKDA7vV0sfcxPK9fmrkErvWSIUcA0a0RIZmYpR+Pqi5VYZR1XwECNL21etE5w0rLEoys1V10fzYOS7UsgQLRVG4iLpuiKgahSdteJTQ==;5:60R3tMbzoXiJAS1VrevY332nZUT6u9XuofGyzhgKBLjXPD3vPYdmOP8T67l9k5eV1yo9r+agTULui1+jc1qv9UME69QeMz3Sz8VIxp7W4p+Kmo6E+StTuLc8K1sTMPthGWAwR6+0vIKGNYSsld3E8dws/5PIW8dsbRTNRGShN6w=;7:gCkIJS8TzYE5VX/ip5BHpaX2D8L9b3x6lXPPpOSGCEKhy5pOw/WpHV8TcIkppdE8awSUWMmS405eaL4/y0jeur7gjrWtTt94L6fZK7+RvFb7g35yK8/Oe/z4jf/KYG2o6ZJPGIEird0adZSpWyx5NA==
x-ms-office365-filtering-correlation-id: 983f6ac8-7593-4a4a-5490-08d6430fda42
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BY2PR11MB0647;
x-ms-traffictypediagnostic: BY2PR11MB0647:
x-microsoft-antispam-prvs: <BY2PR11MB0647C805EAF1B99D2472E4B187CA0@BY2PR11MB0647.namprd11.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231382)(944501410)(52105095)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:BY2PR11MB0647;BCL:0;PCL:0;RULEID:;SRVR:BY2PR11MB0647;
x-forefront-prvs: 08476BC6EF
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(39850400004)(396003)(136003)(366004)(189003)(199004)(54906003)(6486002)(72206003)(316002)(97736004)(110136005)(99286004)(2501003)(575784001)(86362001)(478600001)(6436002)(5660300001)(36756003)(8936002)(4326008)(66066001)(186003)(81156014)(106356001)(81166006)(8676002)(105586002)(305945005)(2906002)(25786009)(7736002)(68736007)(6116002)(11346002)(3846002)(76176011)(53936002)(26005)(102836004)(6506007)(386003)(486006)(2900100001)(6512007)(446003)(14454004)(2616005)(256004)(476003)(71200400001)(71190400001)(107886003)(52116002);DIR:OUT;SFP:1101;SCL:1;SRVR:BY2PR11MB0647;H:BY2PR11MB0744.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: TfSvzhP7uuyViaNsw+6tn1jtsAdDuPiWwD6D2i6BoxkUtZyamTNJ1ZJ/JQp7ZgIDRV9YovCf0yXwZUb7JD2FGg7P9RGxwpp+7mCI2h498M6M3SLQ6elf0EjNnDSm26iLHK6kqmYDXWfZK6WaD361mzwRz78L+GXEU98Z0knp2fueo9sCYAwm7Xmu5NZtIp/cv7fksisfVLJcSW3/hKDXb+3pHQ7pmi1l/vi4f+TBd1/H8tj1oV0zLsGPcS9ggk1LTwilQkwjJSIymRCkCmUYOdeZNZv8Hewfm5pMZ5LrQzn+mP9Ble8nrd4ajh7dZhMogsa8zxBTdu1iCjJgsX63s7nUXMul2ZRAWd36dKdP3QE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 983f6ac8-7593-4a4a-5490-08d6430fda42
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2018 11:14:28.9118
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR11MB0647
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Check at91_shdwc before continuing with probe since we want only one instan=
ce of
this driver. Inspired from commit 9f1e44774be5 ("power: reset: at91-powerof=
f:
do not procede if at91_shdwc is allocated").

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/power/reset/at91-poweroff.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/power/reset/at91-poweroff.c b/drivers/power/reset/at91=
-poweroff.c
index 48661e04a3de..e75d8f0f0526 100644
--- a/drivers/power/reset/at91-poweroff.c
+++ b/drivers/power/reset/at91-poweroff.c
@@ -160,6 +160,9 @@ static int __init at91_poweroff_probe(struct platform_d=
evice *pdev)
 	u32 ddr_type;
 	int ret;
=20
+	if (at91_shdwc)
+		return -EBUSY;
+
 	at91_shdwc =3D devm_kzalloc(&pdev->dev, sizeof(*at91_shdwc), GFP_KERNEL);
 	if (!at91_shdwc)
 		return -ENOMEM;
--=20
2.7.4

