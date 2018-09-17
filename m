Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24540ECE562
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:16:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C74A2208AE
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:16:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="fFMpl0CR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C74A2208AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731192AbeIQImG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:42:06 -0400
Received: from mail-eopbgr690134.outbound.protection.outlook.com ([40.107.69.134]:52946
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730114AbeIQIbK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:31:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9PqEDB/mwsh8OQ3i1P0wfKmgW9TbookyV+vcomZ189Q=;
 b=fFMpl0CRRzltYMdL/t1tzq8NEAF5wOXpunuNjJKQDb337QORo5tfqkIoHNVLr9aVk2LqMT5Ql9aS7RzUdsfbCl5p5V97FbiVhC8wqIgAd5pCYl+AhpRR7rorX9UHphdlSq+b2Eqo7DUGKzdmj5b5M1XrkSZAHEWRvqZqr3wCrs8=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0120.namprd21.prod.outlook.com (10.173.189.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.4; Mon, 17 Sep 2018 03:05:41 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:05:41 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.9 17/57] media: exynos4-is: Prevent NULL pointer
 dereference in __isp_video_try_fmt()
Thread-Topic: [PATCH AUTOSEL 4.9 17/57] media: exynos4-is: Prevent NULL
 pointer dereference in __isp_video_try_fmt()
Thread-Index: AQHUTjMRdzbLkDn0pkqdffSSFUqhbg==
Date:   Mon, 17 Sep 2018 03:03:53 +0000
Message-ID: <20180917030340.378-17-alexander.levin@microsoft.com>
References: <20180917030340.378-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030340.378-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0120;6:sEC7DoDr09OSej/kPTPBOy1gARpEEi91u2tfl/5VesoqYsOXprZAu3/DNVx+WVyDQFK5cL+Dj0KnCuAEX8O2cFWcrwa8SFiopQZwTk9MI2wsKWsRDsb8QmCnca4Mr/SEIpgvevqsCLkU7NaJLu736mT9ZVhp6h2cCzQd76A7t3xMcnWMTCNmh1bBpzDnqIdWKogeCkL1EBIHm4hvpZjaOR+vHI3zqVg7RQiE5dtePyG2BWOnGO3BTa2Ug12YsStt/7dDUc30zcF4FCUETjbEWTAcXAPLbz3rHp063XLfGsn/zp3YQcYaq+qCHlZg+zak8Kq//WySQXkr1bBpe4hTaqpZbVZabF/N/XDSqE3yf/EU2PSmGYhcqQxa/qyfAMm4geDYyf/gv7Nepa9HO85ku+iGtUZZmtzV4dFjW4RfIBcvONc/X1JrjNrDdYuyXGlD;5:q7TXsGK408w1zLwuH1jnu/853YHPysbnRCuemg6+diEHeqKg4eXgOw9ygB+uwdavi0FqPZ8DgNGCz1UeBDpXTC/Yp68B59bC9yMiX7k60Q9JIZtmDzRTcs8Ta7SvJcl/7tMuRvgWdMctOEdztwdCpIGsk5L6nip3g25mL0brbWc=;7:8NLWjtVfaPuwV4c9BgfAULJMa2b28rpgYWndEwH71jl8x/6/4/kJGfLsYVAbTxA1VxLtvw7R/Ntt9pnxxYHPz2m/9v6LcJTUhUezXCMxOgMu30ioIM+vQpcPnfiUe4Ejxf680iPA72izRicJUiELDhOoFX63VzZNGeUkDUhzlFaZJTTVAzNaA2PIh5FwZhucRbsYJGxvEl1xCKor69t/u1ikgO+lJdZWL29TzFcgJ7V/GtW6LglTc90Q7I4ocGCm
x-ms-office365-filtering-correlation-id: 14999eb6-25c1-4034-cdaa-08d61c4a73b4
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0120;
x-ms-traffictypediagnostic: CY4PR21MB0120:
x-microsoft-antispam-prvs: <CY4PR21MB012030ABAEB62A9F4299EA04FB1E0@CY4PR21MB0120.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(17755550239193)(7411616537696)(146099531331640)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231355)(944501410)(52105095)(2018427008)(3002001)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0120;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0120;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(396003)(376002)(136003)(39860400002)(366004)(199004)(189003)(54906003)(26005)(110136005)(446003)(2906002)(6346003)(99286004)(316002)(575784001)(86362001)(25786009)(102836004)(10090500001)(2616005)(2900100001)(76176011)(97736004)(36756003)(11346002)(72206003)(478600001)(10290500003)(3846002)(6116002)(1076002)(22452003)(107886003)(5250100002)(2501003)(86612001)(4326008)(217873002)(105586002)(106356001)(6486002)(14444005)(14454004)(256004)(6436002)(8676002)(305945005)(8936002)(6506007)(81156014)(81166006)(7736002)(476003)(486006)(68736007)(186003)(66066001)(6512007)(53936002)(5660300001)(6666003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0120;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: BzEFpoVCMUi1/qafM6kO4PUYCPEIiuP3d/XEyIrQI8clQN/dsXytyCDNPHbex2Ue9JSy/p3POB7iLfH+hwihpXBscgfPxCW6wCBwhqbgw/2vSJSAxAbWgN+rb0IZ5GdEI0eFCvFJGRKoxcXR/iJfqJ1Yy5EE/c3VaY58yubVYfct7jJSqawq3Fo6l57YowmC9RYeD+ChSJ2elCZHnjwYpOp3uMCJGJGxc37VYAx0T/v8BohWe3JEEMK7wUrGxN7MMfdPht3XV1mtZHDY1x6yhXnXrVUc2Md80V22qh/gPUxo0GOj2g7E9fIc6TQat2+QNzuOPlKXlTVz7Xm2QCEjXw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14999eb6-25c1-4034-cdaa-08d61c4a73b4
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:03:53.8835
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0120
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
index 400ce0cb0c0d..e00fa03ddc3e 100644
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
