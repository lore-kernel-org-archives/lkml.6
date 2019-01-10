Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AB42C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 15:10:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC2E8214DA
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 15:10:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="dEVabNWP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729495AbfAJPKo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 10:10:44 -0500
Received: from mail-eopbgr80099.outbound.protection.outlook.com ([40.107.8.99]:48079
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727753AbfAJPKm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 10:10:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c3NQshP9lIPHHAPMrelZKkEChYzI3ptRTj3F2NAeNDc=;
 b=dEVabNWPaZHqKvwOwFtLweor2XQTsUGV1p0c7nm4VQiOjdCZXRt3xN6QesFY/VO6xCAAeUXCNE/0Pjh8UTygUEr5dq0/l5HnzQDmYi/AeeBeTFQMELnNqonCIcoiAEae8MDxhUOpkJrX7DHb+6N2G67Thf6cvWxeCk8b6le5q+o=
Received: from AM6PR02MB4470.eurprd02.prod.outlook.com (20.177.191.218) by
 AM6PR02MB4037.eurprd02.prod.outlook.com (20.177.112.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1516.14; Thu, 10 Jan 2019 15:10:39 +0000
Received: from AM6PR02MB4470.eurprd02.prod.outlook.com
 ([fe80::e5f3:a239:2ec4:4453]) by AM6PR02MB4470.eurprd02.prod.outlook.com
 ([fe80::e5f3:a239:2ec4:4453%6]) with mapi id 15.20.1516.015; Thu, 10 Jan 2019
 15:10:39 +0000
From:   Peter Rosin <peda@axentia.se>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Peter Rosin <peda@axentia.se>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        David Airlie <airlied@linux.ie>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 2/4] drm/atmel-hlcdc: do not swap w/h of the crtc when a plane
 is rotated
Thread-Topic: [PATCH 2/4] drm/atmel-hlcdc: do not swap w/h of the crtc when a
 plane is rotated
Thread-Index: AQHUqPal2z9iTYzgb0+a4YlOuMR4jQ==
Date:   Thu, 10 Jan 2019 15:10:39 +0000
Message-ID: <20190110151020.30468-3-peda@axentia.se>
References: <20190110151020.30468-1-peda@axentia.se>
In-Reply-To: <20190110151020.30468-1-peda@axentia.se>
Accept-Language: en-US, sv-SE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.11.0
x-originating-ip: [85.226.244.23]
x-clientproxiedby: HE1PR05CA0257.eurprd05.prod.outlook.com
 (2603:10a6:3:fb::33) To AM6PR02MB4470.eurprd02.prod.outlook.com
 (2603:10a6:20b:60::26)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM6PR02MB4037;6:arwSSsVJDO4D30SFKsbe2Y9ZC4sW5T5+T4JgSsKt+v0Abo+baQ4T3oP57UWSPaXlJ8/rfiieUdDMGrrZRMJSATMck94+/VMa/dSXBa89o8jVc70Q68Hvj6RQLnk5mWbsVmt/VOhivaq9PX5jBLmW0ItPDWQ2MZPNWgDp4kP0kNvkFCvEoAPcbrunE6Fia39CMC33ZHzQ3CNyvIWJ530JpW/Tqk3w3aJFV5LO5q8NrXUrKPm32U45T0JDsfktYWTc8qN30KST9m77VL92boxBuV5CO7jU6rTrp1mBSAQcBD/6a0zXkUlBQ0j+vmmqe8Gyeo3ZgAEzTfUQQgwUgktq+yNzl1q9pxTFPRmPtt+B8+Cx8EBmsKl7hJ2M9gaOsXSyzfoxIXPNtBa48elWU2bgg5Pmd5QUWVrx/yTaA1HogLsKkjbZpkuSeuHjgXssvAweXx9m9baCm/HYKdKPK7015A==;5:yB9RRPl/+WJ8VpUNMdf8DwLWMA41wC/hdpK6N9WNayTJtH5N89D+0Twm7NMBkFn3zfqN1KAZ72HkdfNb/vDJZqGsaiFzoLOdFHn6p0euQCajMfOB9nn0MVOOb5AHaL73h6DKBCpCH4Pc5BcApVYM9uUpUat/FkuvuDoniSiaacZy/Q/bsRrAFs+4Bx0vf2TfqNtKZCxvebv7LbK26EDvLA==;7:lQG8cfzOIuoXgTpEzF7iOGVttWsQZfzNHMGLJxpH/PVCxIzsQsDwaufhlk8Q6Sfy5NJggeE335auAy+DUGLAMDyfomULWOIOHe6ZduBvPpQ8ND7cu4J7YwzbOr4kogYSRC/YE+PcKeWJ1V04lCqb2A==
x-ms-office365-filtering-correlation-id: f6ad3eb1-575e-400b-208d-08d6770dc7ae
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(5600109)(711020)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(2017052603328)(7153060)(7193020);SRVR:AM6PR02MB4037;
x-ms-traffictypediagnostic: AM6PR02MB4037:
x-microsoft-antispam-prvs: <AM6PR02MB403782F5A08A417100BC50FFBC840@AM6PR02MB4037.eurprd02.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(3230021)(908002)(999002)(5005026)(6040522)(8220060)(2401047)(8121501046)(3231475)(944501520)(52105112)(93006095)(93001095)(10201501046)(3002001)(6041310)(20161123558120)(2016111802025)(20161123562045)(20161123560045)(20161123564045)(6043046)(201708071742011)(7699051)(76991095);SRVR:AM6PR02MB4037;BCL:0;PCL:0;RULEID:;SRVR:AM6PR02MB4037;
x-forefront-prvs: 0913EA1D60
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39830400003)(136003)(366004)(396003)(346002)(376002)(199004)(189003)(53936002)(316002)(36756003)(6512007)(97736004)(50226002)(5660300001)(66066001)(186003)(386003)(4326008)(6506007)(446003)(25786009)(26005)(256004)(11346002)(2501003)(476003)(102836004)(2616005)(6916009)(14454004)(71190400001)(71200400001)(106356001)(105586002)(2906002)(68736007)(7736002)(486006)(5640700003)(4744005)(1076003)(6436002)(6486002)(508600001)(2351001)(81156014)(99286004)(81166006)(3846002)(8936002)(305945005)(575784001)(6116002)(8676002)(86362001)(54906003)(74482002)(76176011)(52116002);DIR:OUT;SFP:1102;SCL:1;SRVR:AM6PR02MB4037;H:AM6PR02MB4470.eurprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: e6MbwdfETt/ygnp79dhOdG7HmbTYYF5zr4ejqJbHC/0d+7JQM7H9jeh+3vGqMXCUzF2n41HRmjyjw8rt1rO+3NSJw9szKG1yfch3IztRFz6w5cDKKnIVr0/JfmKlDepvlaWUGZSdtwqxtkkbVvwm8r4lMAc47hZvKQmhAJYX8LEhdoixvc75A1BhqGQDdkQS8ba6+lWUn04aXR7DG9vKsDHZCWVwYDq4i7FGFRLtct9/Tnss9PwvjHpCovjVsDdvLkEMSJVhO+ot1v7m5gUDHZbx5veeiKt8jyC10hdZaN8BNiYiRb9HW9ipSINs8KjD
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: f6ad3eb1-575e-400b-208d-08d6770dc7ae
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jan 2019 15:10:38.2808
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR02MB4037
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The destination crtc rectangle is independent of source plane rotation.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c b/drivers/gpu/=
drm/atmel-hlcdc/atmel_hlcdc_plane.c
index ea8fc0deb814..d6f93f029020 100644
--- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c
+++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c
@@ -642,9 +642,6 @@ static int atmel_hlcdc_plane_atomic_check(struct drm_pl=
ane *p,
 	 * Swap width and size in case of 90 or 270 degrees rotation
 	 */
 	if (drm_rotation_90_or_270(state->base.rotation)) {
-		tmp =3D state->crtc_w;
-		state->crtc_w =3D state->crtc_h;
-		state->crtc_h =3D tmp;
 		tmp =3D state->src_w;
 		state->src_w =3D state->src_h;
 		state->src_h =3D tmp;
--=20
2.11.0

