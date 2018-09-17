Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D0E9ECE562
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:11:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFD7B20693
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:11:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="DWy5XnrJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFD7B20693
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731387AbeIQIgx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:36:53 -0400
Received: from mail-eopbgr690120.outbound.protection.outlook.com ([40.107.69.120]:6882
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731310AbeIQIcl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:32:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Myrhpn+lgO8JwJwGmr6Jzy9Qnx81P6Bfs4++2W8s5A=;
 b=DWy5XnrJ3MS/skxqpDkn7+cUOAYvvPcibfJHv7rlIpcJbNvRaBNM+HNDaWI/mhxfnDwQbb9YYyK8fz+Eb4YMTjCYRXhufJ53b8jG1CmC10L2hQGlW8Hs8U0ch2cr6OTNL5bItN/xnmKcHHL49mQ3oT7/2JfT6bZiSkLnzq90Qdg=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0166.namprd21.prod.outlook.com (10.173.192.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.12; Mon, 17 Sep 2018 03:07:05 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:07:05 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.4 12/43] media: exynos4-is: Prevent NULL pointer
 dereference in __isp_video_try_fmt()
Thread-Topic: [PATCH AUTOSEL 4.4 12/43] media: exynos4-is: Prevent NULL
 pointer dereference in __isp_video_try_fmt()
Thread-Index: AQHUTjM2+O9Df2ERz06ltmWgunSJqQ==
Date:   Mon, 17 Sep 2018 03:04:55 +0000
Message-ID: <20180917030445.484-12-alexander.levin@microsoft.com>
References: <20180917030445.484-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030445.484-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0166;6:2socYvdoOxK0EAFOx7leN/5XuCqH/E8ceQCN0N6h06eC0DclpLSROQiToKuof5zGzsmlgntDjoSgwIxFMi9NLNxSnHMoNiPZC+FGaSFiJ4+WxZYpv1bR/UEb41TK61mNJW3D5wI5VxTiUdIotZFPvX6WHPdvZYoSRH2wXxm/pxN88DkheE150nWuE0kja2L1Ok8Z94a5knzjv2kzwXYgO3qIfw/9qO5d9HEfRCjcu4+hAP6k2BMe8zTlqSWmc+iczDTHC+R3R8pHdOx7BR6BR7dBPJlXW5A9jmxcSzeYWODnaKVGLB1Nju1nax/rgAYARDr6xWf3eUPUjqmpjPgE+giT/FGISzpnhv98WsaSyODbnuP8MeSKNlC0ctyl3zNAzn3SV/aCqexoLJvvVwl8ozsxCt5k5s/t7rWFXFIt72O2zYOSnNyTM9+uBmoRO3DeFb7cHFl1J6RpV1bQvYlPlA==;5:L44SijZ1XptwyZsGHNtCCDJu3HDiwh1GmqlySPAK03OlqYsYdQWUj7FjpISfQb8RDwWENNkbvA9H+D09vlJ0GqRVSfRuPup05JCCZvpHXSneBWBueDoifh/yS6Uc4+ufsnPF34N8c32SxEiENYIadlZj+iklnHvS23egNtd36q4=;7:/HS+C0y6gwNqzTn35pJP3lYtRx8hdF+cluKf2vlG9ZKkqdT9eFshgy21B0rFbCPrcZOb5r1Qq7TA+gYihpijn119Fr5ctSCn+ua7Nvf7mxRSUZIQh+hcI4BAnUw+m2llP4lWWUz++9q7Gb8FaExBgTiOm1q+1PeTMpMZPd+pDHc2ivNJwhPLUwh3eQKj/EJVmHDtFabIxchmr6eW172ge7ANoXywJrgCSI9uW8YyhC9xsmqUWNf53lYpO/q/2PsX
x-ms-office365-filtering-correlation-id: 59d5c3b4-fb93-45eb-fbaf-08d61c4aa5b2
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0166;
x-ms-traffictypediagnostic: CY4PR21MB0166:
x-microsoft-antispam-prvs: <CY4PR21MB01660B255C7C559B62A984A2FB1E0@CY4PR21MB0166.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(17755550239193)(7411616537696)(146099531331640)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123558120)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0166;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0166;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(136003)(346002)(366004)(39860400002)(396003)(189003)(199004)(305945005)(256004)(14444005)(217873002)(486006)(186003)(86612001)(66066001)(7736002)(6486002)(102836004)(6512007)(2900100001)(25786009)(14454004)(6666003)(2616005)(476003)(1076002)(575784001)(97736004)(86362001)(6436002)(5660300001)(6346003)(316002)(2501003)(6116002)(76176011)(6506007)(105586002)(8676002)(478600001)(3846002)(106356001)(53936002)(68736007)(72206003)(446003)(22452003)(5250100002)(81156014)(8936002)(36756003)(10090500001)(107886003)(4326008)(110136005)(11346002)(99286004)(81166006)(2906002)(26005)(54906003)(10290500003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0166;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: IVsKhEAuEu9s9JdcDI+QPTiX4QJSuyRoDRKpMrS+n3LV43bkGYBeGWZVAqATIGhdwHMMAX+mWTZdNYrIQ7CDimGbZwyVpVCU/IgokkIb3e9FlyP0NyRDVSPLIHtzbNGxK7HXRkxxu15CvXjoOeSdpthZN4La8ht16psOyMLQcWRJE1WIckxIxs3ZzERGWOQYIZy/i5ByCf69dyx5Qd3GgVS/9gCvQQ8wBG8cbpTRHUkbYjviVonC7UwM7nzyAstAxQaWTXUg4+MOwsOMN4ZdOAgzAeKH+U7cRsaMinJTNctUzD4CwR6KpvWrpXNn4V1/0qo/djVG7J5jqtUaxf967g==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59d5c3b4-fb93-45eb-fbaf-08d61c4aa5b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:04:55.7736
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0166
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
index 6e6648446f00..667d3720154a 100644
--- a/drivers/media/platform/exynos4-is/fimc-isp-video.c
+++ b/drivers/media/platform/exynos4-is/fimc-isp-video.c
@@ -391,12 +391,17 @@ static void __isp_video_try_fmt(struct fimc_isp *isp,
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
