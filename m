Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80F48ECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:26:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E1FF214AB
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:26:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Yp/USyBw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E1FF214AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729848AbeIQI2v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:28:51 -0400
Received: from mail-by2nam03on0130.outbound.protection.outlook.com ([104.47.42.130]:60384
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729758AbeIQI2u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:28:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U6FR3i6pHwBQQo7D9kl/41Srqz1JBYtIkecoADKZJxM=;
 b=Yp/USyBwKysrvAiS73GXETpwVXK1mnXqYac1SIwrah7eCFRiPAVeq7S25JlhMHMIU3q6bc8TyzBliE0bn52qPGaAV04LqGdz/GOvV5GoFHVqoGDRNpy8ajwDQIJA1lKRiDbFslU22jaID2x7PkgV5Du45bYi0w1+GoipLbEAmCs=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0855.namprd21.prod.outlook.com (10.173.192.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.4; Mon, 17 Sep 2018 03:03:31 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:03:31 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Hans de Goede <hdegoede@redhat.com>,
        Sebastian Reichel <sebastian.reichel@collabora.co.uk>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 07/87] power: supply: axp288_charger: Fix initial
 constant_charge_current value
Thread-Topic: [PATCH AUTOSEL 4.14 07/87] power: supply: axp288_charger: Fix
 initial constant_charge_current value
Thread-Index: AQHUTjLe++Z/gvP2B0mm3/KcHWzt0g==
Date:   Mon, 17 Sep 2018 03:02:28 +0000
Message-ID: <20180917030220.245686-7-alexander.levin@microsoft.com>
References: <20180917030220.245686-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030220.245686-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0855;6:UvTz2o73TNe6RSmG6f7Fo08LeJAvtzofvkjCcFGmvg6LiVGXE7JpqTxWcx52eana9IyRSEW1UHauyEqgUfvMHQya1iljn2CmRdvYargZUqzU+b7SKt/na7lvw+ISiN6SRdKkkY3QXVDuYZoenUTd+k2+UsND9yU+7fGfGcEwt5b8Xy2pOIVR5ZdyUqUnzflvh0lftVKp5q7WgVDWUnaRvNkUW5DmTxXzFVoOD/+YeGR7IWps0GML1UX1pTy9IXKwxQ+Xq8vaoVZcXPLk/11sL28n8uTSTEzNHRCnhYbQ9/GUXzRAhYF+VXF04UEIef86iOuxtrNmDJE5fUBaVUkLYa9Wj+hgjD0CqjMRP/kkT+SQjiXLMQFCE8Z9QG2LEGbRt4Ohw65dSa3xk3AX3KKemkHzd0iWy8AcYsqcRDvo576fn4aKPJEWizMKlQZRPugVI9qMDHi96nkee/4v8PVniA==;5:2DwasaI4FNeHf+pss8ola8s+XEbOVFp/AlCcvOO6I4nBprHUztbwUMHr3WaIzZlkSveATssVfs6ZNEpKXr7XtpHa5icSirHlutFXtIs+6nEkFcAMJJ8D/DJxa5hqG9BHIVYCrDQqQi+B0emyEJ4qx7smXNT/C72MpWGyBeGsNF8=;7:8buqr952UDw8HXJMK6xswyVbv8JTwiNgHqRhOol4fyemeiS7qRJ/tDc9Xg1lrCgm/tqI7r00OYSqYXk8nHJJ69uPTUBOYpkq/Rh9sS80ql//1+dWkbsa0OzrOFElNoA/l7dHrlXIdsXF+KWOW0aXvieGIMU3lxN3V4a3nND24RCiIuHaq+/kZkIMGoKjZsdt+X/JMO8p139jZdMtag26YQ2KpQg/rVRo+0v4u/KXdfSUK+kVtAEefuBrN9cUXbRe
x-ms-office365-filtering-correlation-id: 2629620d-cbee-4e4d-6f3d-08d61c4a2611
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0855;
x-ms-traffictypediagnostic: CY4PR21MB0855:
x-microsoft-antispam-prvs: <CY4PR21MB0855FFCA5926FE3817DE3023FB1E0@CY4PR21MB0855.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231355)(944501410)(52105095)(2018427008)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0855;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0855;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(376002)(396003)(136003)(366004)(199004)(189003)(6436002)(99286004)(7736002)(110136005)(54906003)(97736004)(5660300001)(66066001)(446003)(72206003)(76176011)(86362001)(86612001)(81166006)(81156014)(2906002)(478600001)(305945005)(68736007)(105586002)(2616005)(106356001)(476003)(11346002)(22452003)(575784001)(6486002)(10090500001)(10290500003)(8676002)(36756003)(6346003)(6116002)(6506007)(3846002)(102836004)(107886003)(6666003)(6512007)(1076002)(25786009)(217873002)(4326008)(14454004)(26005)(256004)(14444005)(486006)(186003)(316002)(2900100001)(8936002)(53936002)(5250100002)(2501003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0855;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: COB9JEa4NaQmU2gglnMJ5aBsWCMgvcVK85wTQkTOdBnYMji41//hOe1M+mj248w1kky3+4k/kBk9nMiZHpxUBQJpYmu5qpUvDf64ZplJqAaV5EIEuyDX+ipe33BFh9o5ESeSuwysCLDDzRF3uMRGHE6laqh80RFDjBKycISqfhHMDl0FFwHK6YwcB+RifKZ58fsejj829rc7b3Y23+AqbaP7hno0jC1NgIg/AKnFGUkl76ViDDmt3t43dJpwIHVTkBUGAWq5BOXgFzHO7Fc39qE5PLMEiuQSAUjxD8Rj4f9sDD8pVI67x0EmXgG9oEUiLFDVrHzuUmE1Nqs+3+Lsh5JG0ZpLvVez9szOTcMf3UM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2629620d-cbee-4e4d-6f3d-08d61c4a2611
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:02:28.9626
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0855
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hans de Goede <hdegoede@redhat.com>

[ Upstream commit f2a42595f0865886a2d40524b0e9d15600848670 ]

We should look at val which contains the value read from the register,
not ret which is always 0 on a successful read.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Fixes: eac53b3664f59 ("power: supply: axp288_charger: Drop platform_data de=
pendency")
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/power/supply/axp288_charger.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/axp288_charger.c b/drivers/power/supply/a=
xp288_charger.c
index 9dc7590e07cb..4d016fbc3527 100644
--- a/drivers/power/supply/axp288_charger.c
+++ b/drivers/power/supply/axp288_charger.c
@@ -771,7 +771,7 @@ static int charger_init_hw_regs(struct axp288_chrg_info=
 *info)
 	}
=20
 	/* Determine charge current limit */
-	cc =3D (ret & CHRG_CCCV_CC_MASK) >> CHRG_CCCV_CC_BIT_POS;
+	cc =3D (val & CHRG_CCCV_CC_MASK) >> CHRG_CCCV_CC_BIT_POS;
 	cc =3D (cc * CHRG_CCCV_CC_LSB_RES) + CHRG_CCCV_CC_OFFSET;
 	info->cc =3D cc;
=20
--=20
2.17.1
