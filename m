Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02406ECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:01:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1424214D5
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:01:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="j55yeSPk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1424214D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728834AbeIQI0V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:26:21 -0400
Received: from mail-eopbgr730108.outbound.protection.outlook.com ([40.107.73.108]:57545
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728769AbeIQI0U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:26:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DFDmBugIiw7jmI9bgrSsSrhchAFpS60o6BM/33qD3Lc=;
 b=j55yeSPkw8nzoqqV7UEFSSx5VHQvQZ/LXEfJ7mG5PJNfFwQGOdKJ5o1SeqTuGOCEu6QmDF0tej6ggNk149pgi7ADfhVOzC0vMzwZq5CKyJviO855PTag9notxCwGwmZgnX2FYd2KgFNwZkXl0lHcW+wTgw4wM366ny7vXpPjEhU=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0629.namprd21.prod.outlook.com (10.175.115.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.13; Mon, 17 Sep 2018 03:01:02 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:01:02 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 034/136] media: exynos4-is: Prevent NULL pointer
 dereference in __isp_video_try_fmt()
Thread-Topic: [PATCH AUTOSEL 4.18 034/136] media: exynos4-is: Prevent NULL
 pointer dereference in __isp_video_try_fmt()
Thread-Index: AQHUTjKZznablbRqYEWlC9ezxF8D3w==
Date:   Mon, 17 Sep 2018 03:00:33 +0000
Message-ID: <20180917030006.245495-34-alexander.levin@microsoft.com>
References: <20180917030006.245495-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030006.245495-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0629;6:p4a/B2HrA+vaaKLWL/6BaiFYK4andXKsgZMNEKGtHgrn1syT4GbGf09BpXu+/+xfZyJLFkdHYVqh/Ob9fP82itqNT7H/EpWj0QDl3vDtSqCG7zBlrFiHze22bH/nbGrzFWG2u4A1DDRd1rHIR4Xrr6mWFvqApbaS9p8IZwSGkkcj59fRgsGiupStO8z+12f4tLfl+BCv5u+/KZjEhpaPxCH/NfkfFxiFcMMp1eIlG0dc+ULbZ3XDJ7ma0nU2wVsNMagPh7aojUMHX7iKO17E58C3vO4zVM5dYxDkRXZ/+gvOPNUk+G+/ejzXiDJejUNMLv8bncNZEeVHcRJsL5n9VLpwbXuc5ufvaKkQPlT57T0d6yl0e/Ch5sVE6p17nWLWKswYxzjnKPPvHWiTkQFsZVzDO7NBTP96FHA5o9QN+OcQRCiHWcEXnRhiP/QXhZm7Vsx5DKvH+6cuL4fC8lq+VA==;5:cZ+e8xsR1TVXexVrwAjQcC0bkKykO3jrQvZ1Gz3swEGrUzBCYDdxbifAgGUyZzaLtsf93yP9fF9XENzDNT/jf0tJeL6ya+gCt6aaO41RpuoGjKS+gJubCZiOKKpO5rxR4gq7ZB+Y/Q5MALJzDQfg+w+N2TUUf3ovt99YLQFyKAI=;7:fuIkjadTa8BDwxby9uEZ527sdEnOIVHpwoYWEg8BxrkzavfzLuzZbx9GCSZH5hFNuymbQth/2Ly9G/UGo+cCfHkQKH/alzmUQyYiRQvGTF81Xa2eV8qHVn/sTKRwjZwINey9vX96Ncj4htFZUALyhlYYEGSiHunGEWPSnnywFn7G4TAnJTQHqcuKqm885ZpX/dIkSiAtb4TNKXnF/s1jvsjsLSU8Rd4v2kciq8ByWleStletYwyiyesbscS8pCg7
x-ms-office365-filtering-correlation-id: ccc52888-561c-415a-1641-08d61c49cdbe
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0629;
x-ms-traffictypediagnostic: CY4PR21MB0629:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB06290B7172FB753CFA1A1566FB1E0@CY4PR21MB0629.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(17755550239193)(7411616537696)(146099531331640)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231355)(944501410)(52105095)(2018427008)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123558120)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0629;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0629;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(39860400002)(376002)(396003)(136003)(189003)(199004)(76176011)(1076002)(86612001)(105586002)(22452003)(5250100002)(6666003)(7736002)(68736007)(4326008)(86362001)(575784001)(2501003)(99286004)(6116002)(3846002)(36756003)(107886003)(72206003)(25786009)(106356001)(14454004)(6436002)(5660300001)(10290500003)(486006)(2616005)(446003)(6506007)(11346002)(97736004)(256004)(476003)(478600001)(305945005)(14444005)(217873002)(81166006)(102836004)(6512007)(8676002)(6486002)(2906002)(66066001)(2900100001)(186003)(26005)(54906003)(316002)(53936002)(8936002)(10090500001)(81156014)(110136005);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0629;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: OpTdf8yr9mL+PF7pPdh254tMBgEi7UQqvrWi55yC9AtzheaQovGnC7yGfqgCQxi1kQ6yBWn2/j0ZNBQeI7GHgLsr8+ASUGIi+RXSfgvkeD6y9jO6o75PUaez6vdnQ+36/Gwe7argTV/VMWLzYbvC3oxTQ+0AXE0grGJ1BnLzsGBKahveMPSX3svx24q9nSzBHxpv9LC6vBtl4IzlLTCV3CarA+SiUWBk0WZY/OXe8+Y8b6MoKjHHLBFypwclcP5MnwlR0lxmgz1FLMXgrXwcUFbuw9LJ98qWOaGLEAC70+8ko98oifpKl3okoYffn/dC+YB3xK2wXGcu5pcjG4p5AdTM5WZ0/wDfP2Pih52+AI8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ccc52888-561c-415a-1641-08d61c49cdbe
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:00:33.7609
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0629
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sylwester Nawrocki <s.nawrocki@samsung.com>

[ Upstream commit 7c1b9a5aeed91bef98988ac0fcf38c8c1f4f9a3a ]

This patch fixes potential NULL pointer dereference as indicated
by the following static checker warning:

drivers/media/platform/exynos4-is/fimc-isp-video.c:408 isp_video_try_fmt_mp=
lane()
error: NULL dereference inside function '__isp_video_try_fmt(isp, &f->fmt.p=
ix_mp, (0))()'.

Fixes: 34947b8aebe3: ("[media] exynos4-is: Add the FIMC-IS ISP capture DMA =
driver")

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/media/platform/exynos4-is/fimc-isp-video.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/media/platform/exynos4-is/fimc-isp-video.c b/drivers/m=
edia/platform/exynos4-is/fimc-isp-video.c
index 55ba696b8cf4..a920164f53f1 100644
--- a/drivers/media/platform/exynos4-is/fimc-isp-video.c
+++ b/drivers/media/platform/exynos4-is/fimc-isp-video.c
@@ -384,12 +384,17 @@ static void __isp_video_try_fmt(struct fimc_isp *isp,
 				struct v4l2_pix_format_mplane *pixm,
 				const struct fimc_fmt **fmt)
 {
-	*fmt =3D fimc_isp_find_format(&pixm->pixelformat, NULL, 2);
+	const struct fimc_fmt *__fmt;
+
+	__fmt =3D fimc_isp_find_format(&pixm->pixelformat, NULL, 2);
+
+	if (fmt)
+		*fmt =3D __fmt;
=20
 	pixm->colorspace =3D V4L2_COLORSPACE_SRGB;
 	pixm->field =3D V4L2_FIELD_NONE;
-	pixm->num_planes =3D (*fmt)->memplanes;
-	pixm->pixelformat =3D (*fmt)->fourcc;
+	pixm->num_planes =3D __fmt->memplanes;
+	pixm->pixelformat =3D __fmt->fourcc;
 	/*
 	 * TODO: double check with the docmentation these width/height
 	 * constraints are correct.
--=20
2.17.1
