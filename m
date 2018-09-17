Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89093ECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:09:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21E49214C2
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:09:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Yes7IuWK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21E49214C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731544AbeIQIdO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:33:14 -0400
Received: from mail-bl2nam02on0116.outbound.protection.outlook.com ([104.47.38.116]:52292
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731514AbeIQIdN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:33:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1jQx2sePjUFL2YSwi7MYsHcRJKMD0y7POmwjkB8XKDg=;
 b=Yes7IuWKBcxkMuGNTIpjpAz9+cYymJPWjkptigPdHUda/Xnt6xYKcYu6n6+j/Ch8RHrIOfsV/EXxrj4c+NdN1jPfFki3twFqZ4SH6rJzd2syTQnuDgwFUBYY4F9hMzI8TEgK5l9hldCpvQJ9/jP7E9F7/6zQcyP4LgnYnaXYdWk=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0839.namprd21.prod.outlook.com (10.173.192.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.11; Mon, 17 Sep 2018 03:07:49 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:07:49 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 3.18 06/29] media: exynos4-is: Prevent NULL pointer
 dereference in __isp_video_try_fmt()
Thread-Topic: [PATCH AUTOSEL 3.18 06/29] media: exynos4-is: Prevent NULL
 pointer dereference in __isp_video_try_fmt()
Thread-Index: AQHUTjNQs8A11woq70Oe6p0EWGGPjQ==
Date:   Mon, 17 Sep 2018 03:05:40 +0000
Message-ID: <20180917030533.592-6-alexander.levin@microsoft.com>
References: <20180917030533.592-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030533.592-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0839;6:LBsWxiw5P+Sdirx1HvSz+R4o8Srp2/twssvV3smCh3Ly27p2D3XLllZNOmiswiln14qaEbedjWmEITEm0E8m1vRzV90ojot079hAETJkJ25D2Vg+B4uss9pHmZjQvkFfjrK7ggISpPrT6wzZtPt229LczL/ZLQLYAHJ89gfB8tLbAU6t3CUFOLBspj4GOP/jf1lin2hPKd/6y5hh8qApUTMrTjjbIDdUH7BjdJoSLe3M/2WF6P/tUPRDWDNPOJyQKeD3cqkor5rc37NsGcqdWEcs6UNgDCdgMsQxduTeKhGyxGebg7RHCC0o4DtgcC1PV4OQfsBIaOH3SwSlszpCSSozoe854oab+6RLEWtK1ePp0QsIg7pIlJlrbTzluns1+wxeJqfyKMZi1b6GsHyGyArfUPTroSaaol2H9H/gG91aPBHGZAwmtu9mwaPUptNhu136lygt96bm+/R7rkxW7w==;5:k/9zsgcF58SOGWVUlKWg6M+/o9gK4vkWf+ybdyU+0eXfhPFkjl0SzcotGz7sm6exhKLgGi9PpK/kIZD6DPPZQcqr6aDcRArlXcoRLYHaktVukhZT7/pAfiK3qxNRan8+QiSkHIKEu5OShkNR/9uJ+o2BcxWWoIeA6ZpeBqob2Jc=;7:sba5FaWp2dnlBIRNudX7L26jx+W5LqHXdRw4chPvk0euD+0ag7eN8y0IIZmwqW7zC6GNxYJCPOgW3hnZ4zx7pN+d0Fr8rYgYRuqU4WPrPjXNmqQSeWsxY+M2J9Cp/IrlB/0Jpo1xpIQ/7rgx3eXivW6vjPn2yjwO1Va15xzXeHEjnY4bctdynLBhSAIzkliZ8Nq62FORCUlFlG3MD2AWTeaMzFPVdST3Or0L7OdzGhXulWYGydcB772U891w6z2y
x-ms-office365-filtering-correlation-id: aaad222b-018e-426f-08b9-08d61c4ac045
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0839;
x-ms-traffictypediagnostic: CY4PR21MB0839:
x-microsoft-antispam-prvs: <CY4PR21MB0839BABC4F29C97ECE5D5EFDFB1E0@CY4PR21MB0839.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(17755550239193)(7411616537696)(146099531331640)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231355)(944501410)(52105095)(2018427008)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0839;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0839;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(346002)(39860400002)(136003)(376002)(396003)(189003)(199004)(8936002)(6116002)(86612001)(3846002)(575784001)(53936002)(81166006)(25786009)(217873002)(5660300001)(68736007)(5250100002)(6666003)(107886003)(256004)(14444005)(305945005)(7736002)(2900100001)(1076002)(86362001)(2501003)(6506007)(4326008)(22452003)(10090500001)(6436002)(11346002)(446003)(76176011)(102836004)(6486002)(186003)(105586002)(6346003)(26005)(106356001)(54906003)(110136005)(316002)(478600001)(6512007)(2616005)(476003)(486006)(10290500003)(2906002)(81156014)(36756003)(66066001)(72206003)(8676002)(97736004)(99286004)(14454004);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0839;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: py5n86G9aOpbZveiel4LL+fy/damx9OMlY0kYLctZ1e3hXGtJYZpbnkCoBZoYyRKIvq3JCIremVuwWItYeRd/BzbZElRQsqBvZuMAeLuczPXbL6zX1/0eiT6mBLIbuCNFFLcdMxztvZTPKGEAL32fIFr7sSN5dF11S+Yit2cv034/QnP2PiZt20y78c3rA8sxuGMdoIrrWNO7xN0MQK+5ccLAWakS3rsKhqpaXhc4VPVKKWn0iyex7PaI6q3Bbdo5iABxNlT5F2SeA6Xshjzi8Z6XCyy5h2Oxya33oN0q9ysY7TDoC9k/C4SSifjKpNKkCv3WTeumt5t6Di/AdK2Nb5wp+5BqPg3rNGJ8zkIs78=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aaad222b-018e-426f-08b9-08d61c4ac045
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:05:40.2640
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0839
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
index 76b6b4d14616..322677f2cbb0 100644
--- a/drivers/media/platform/exynos4-is/fimc-isp-video.c
+++ b/drivers/media/platform/exynos4-is/fimc-isp-video.c
@@ -389,12 +389,17 @@ static void __isp_video_try_fmt(struct fimc_isp *isp,
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
