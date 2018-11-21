Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE7F1C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 05:49:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8777721104
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 05:49:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ccQmcCS+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8777721104
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727728AbeKUQWp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 11:22:45 -0500
Received: from mail-eopbgr130050.outbound.protection.outlook.com ([40.107.13.50]:9946
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727489AbeKUQWo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 11:22:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sEIlG+G9TYxEGgVWlfraKyTYijC2/R+P12nvQEfS4X0=;
 b=ccQmcCS+M0oU4sUcJXyixBQBKFVi29FY3wg2kCypDyyTLv5OkD4mpQu7023zs6CMUeE0Jy5wfz6e5rxMsicNxhRdT29cQLjmbMst+b+kprE4TvCZP5ZzMHqNx7ngOynvQSquBKCLyGAHo+DzHP4Lsku95O6fU9CSGF0uv2mWMHc=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3785.eurprd04.prod.outlook.com (52.134.71.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1339.25; Wed, 21 Nov 2018 05:49:40 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::e992:8455:42e:7a0b]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::e992:8455:42e:7a0b%2]) with mapi id 15.20.1294.048; Wed, 21 Nov 2018
 05:49:40 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "rui.zhang@intel.com" <rui.zhang@intel.com>,
        "edubezval@gmail.com" <edubezval@gmail.com>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH V5 2/2] thermal: imx: save one condition block for normal case
 of nvmem initialization
Thread-Topic: [PATCH V5 2/2] thermal: imx: save one condition block for normal
 case of nvmem initialization
Thread-Index: AQHUgV3+A7hSKOLYR06aazyOdDuFNw==
Date:   Wed, 21 Nov 2018 05:49:40 +0000
Message-ID: <1542779052-29536-2-git-send-email-Anson.Huang@nxp.com>
References: <1542779052-29536-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1542779052-29536-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR02CA0200.apcprd02.prod.outlook.com
 (2603:1096:201:20::12) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB3PR0402MB3785;6:eDgxysML9aRm/cY96pbqCw1Iyv64wmcdcJfQiITzgbI2SjaxZbaQaS+4Osjju0ewl7l5+Lqiz3vTrd58bLE7MwIj27DDlhrFzPAIa9+Ewhg7WG9pdfnnI2YHBHNR1p0Beqmf4KllANzPMGAM/OJq2T2GfGPQqNJ48TX0xrUcA0Tyb96wL3XgVkC2SXj5yLh2KX0RXEKROn7vIux9n/VRIc8u9GRSVdEnl9XQcQeJ3IZyLBInv5HcsRB0MmlBJcqq0yZXYlokT0tclsHM3Ep977P1NOUgvdrkfZtl65dZ0xPeBzSTQqIGJOF11cb4Qj6+7phRoijnuCGFXy70xeZvlm+obToBeY2ehzyUYVydce6cCCd/21n9cdAq1ZLOj2FftW54zRb+w+GUGU75Uzz9DFXvoYUU7XQTv+Cab8dcqNSXo4AO4SZcfTv/ZEnX89DijNQdwFSGZ9U6cYX2PeMh6g==;5:aWTcLrSKe43yhKpSNW88tEa0rJFScOxF4Lxlb7v2byD1qoFuo7TeFLWcKrTqetTIO/r+N0zKsL4Z6lmav5KaPGVnb55ybVXdgNMdRzqN+VB5ZCLjIN2HesTgtfbeEk1BZ5gLjvkXaRPoA6vC6dtLYeQ0OvM2fuqOYmJBlTSct4w=;7:v15KJ+ftpjYX/j3o4SP+XC3ivZG6GT6hBB7fFp/+9gflHxTrWKQiSVhZYfJ8hBqgss8h6ur5wgHHcoDAkoIFA5Hb03e5W17p6ACKm2baESFlmx0jatJxKBvkkO2YzxwleBp1mAUJk+cutkCNoQrO+Q==
x-ms-office365-filtering-correlation-id: 31e77ae1-b876-4ef9-284a-08d64f7520a4
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3785;
x-ms-traffictypediagnostic: DB3PR0402MB3785:
x-microsoft-antispam-prvs: <DB3PR0402MB37855C7926223FFDC851E015F5DA0@DB3PR0402MB3785.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3231442)(944501410)(52105112)(3002001)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:DB3PR0402MB3785;BCL:0;PCL:0;RULEID:;SRVR:DB3PR0402MB3785;
x-forefront-prvs: 08635C03D4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(366004)(396003)(346002)(376002)(39860400002)(199004)(189003)(71200400001)(102836004)(486006)(4326008)(256004)(5660300001)(66066001)(8676002)(106356001)(71190400001)(11346002)(6506007)(6436002)(76176011)(110136005)(6116002)(446003)(316002)(3846002)(26005)(86362001)(386003)(2906002)(476003)(2900100001)(478600001)(2201001)(2616005)(53936002)(81156014)(50226002)(52116002)(39060400002)(99286004)(8936002)(25786009)(81166006)(305945005)(7736002)(2501003)(97736004)(186003)(6486002)(105586002)(14454004)(36756003)(68736007)(6512007);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3785;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: uOh0z24v7P1wv6zW1Zev5GRQFCPCIvP5+9cEUBqB/P2fF7XSFSWLhIsvarsNZfpBro2v2HDmGv9fF0bkr7nUKN+CGR7ozAbVrd9LbV+5rfgLG7JJ7t3WUP4k7CI0YpKzu1PPEMbZRsZJiGepsZjuUZ/6E3f5MjnYls6H47RvzOSZ5dDd+QannL+GT6u3JLLCyGr7na/vasdgpPop9SmlJjntE/eKqp2nRXJb3alIq4wXbD80mqVYlJZetu1fseUmL1O43vOeYSgKfbJN+0tCD92F3Awn5QwSJsjcUUVwWupHJFafmvPxMBpZodlMKyxKEncoMBslp8Aw9ldIzVkmFqMnNfvE41XvIS6SLzINcfI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31e77ae1-b876-4ef9-284a-08d64f7520a4
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2018 05:49:40.1023
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3785
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Put return value checks of calling imx_init_from_nvmem_cells()
into one block to save one condition block for normal case.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 drivers/thermal/imx_thermal.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/imx_thermal.c b/drivers/thermal/imx_thermal.c
index c924396..bb6754a 100644
--- a/drivers/thermal/imx_thermal.c
+++ b/drivers/thermal/imx_thermal.c
@@ -742,9 +742,10 @@ static int imx_thermal_probe(struct platform_device *p=
dev)
=20
 	if (of_find_property(pdev->dev.of_node, "nvmem-cells", NULL)) {
 		ret =3D imx_init_from_nvmem_cells(pdev);
-		if (ret =3D=3D -EPROBE_DEFER)
-			return ret;
 		if (ret) {
+			if (ret =3D=3D -EPROBE_DEFER)
+				return ret;
+
 			dev_err(&pdev->dev, "failed to init from nvmem: %d\n",
 				ret);
 			return ret;
--=20
2.7.4

