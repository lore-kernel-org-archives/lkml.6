Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D066C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:40:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B7FB20869
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:40:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="MH5dtz15"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B7FB20869
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730667AbeIGFSw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 01:18:52 -0400
Received: from mail-eopbgr700105.outbound.protection.outlook.com ([40.107.70.105]:7696
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727677AbeIGFSv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 01:18:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TQjoXOY//6prDp8ynRZ/elrDrrSp8BCInT5ge7AkeZI=;
 b=MH5dtz15jMyWnRPpF/TuxSj564oTs08JQqTtHcyBtTkVvbrXI/ccFKrn7F/2sz6R1Ttz2ZMiSg5Xzin5zSEnWJ5THKt0I3VGsoSfJ2lM7+0BOysAOTWq8DNkWeu3QRs0eHsuNonx3NVrFlryaI5bUkksHJrMHT8nZ7SGqLFtPdc=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0149.namprd21.prod.outlook.com (10.173.189.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.7; Fri, 7 Sep 2018 00:40:40 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.008; Fri, 7 Sep 2018
 00:40:40 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Krzysztof Ha?asa <khalasa@piap.pl>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.9 10/43] media: tw686x: Fix oops on buffer alloc
 failure
Thread-Topic: [PATCH AUTOSEL 4.9 10/43] media: tw686x: Fix oops on buffer
 alloc failure
Thread-Index: AQHURkMWIG65fCLgCEiKikUsM6oMfA==
Date:   Fri, 7 Sep 2018 00:38:25 +0000
Message-ID: <20180907003816.57852-10-alexander.levin@microsoft.com>
References: <20180907003816.57852-1-alexander.levin@microsoft.com>
In-Reply-To: <20180907003816.57852-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0149;6:wHEf/grWul+Q8Qg4k7pxRT8TS0wATX9wQMtXETgZ45rUlKeJvdqFFwpnYlnehvarcF+meJ1hTZpJYvUVnqKE1fSUzYaCcQP2h9enZEHCkvvoFSAhNsuruGBw/IwEP2V3a41kG2gEYdU+2+R7yLFLSRxJglPOB6U74mrah5OQ9/3GuUUVNUr2HIQ98/PuCXasvSco5w7rjOlWKoEdZ8cc2AnKDpuCprfOZ6ymc7RbPnuqTjzsGeeLars17Hwde+w1GdX4jutEfFnx6LaJtIAu01//L3cdXNXs8Lkup12rBZfN1rYxUeAkyTJAy9mbLfr2/D4MFSUfK+K72nzjmuBDKm1yZ79mSZ0PG5A3lykNMr4uyIGeHqjNGqFsBjTni/HSiIUTQQ2fSQsZLeg76HP+JqBbsqVfno0qKepQBraiOPoqVsyQLMYSkF3zjyUAMiy43vcSTXa2ZTHdA0PdELHmRA==;5:1NHGXZwoTyxQIe7M6zgeeMoHUoIzubgMMC/4S9K39mXihC0PRExwurZk4m49l/bUKbLknmhRw+oEZT+8Syv06CRpkFiPnvHCRhdTLIMQlJ6aSmihxzdmih+x76NWyFyTkJpVtlO1399j28AEtLxg93yjXT7QSjxIfiBbXUMPIJo=;7:4ei44U4Sri3nFYxg9SXaD/9HV3mQAtgD124SOVPMn8Yqs8wveg0zjcD48ZRaknRy/od8sFvnwNHTqOcSXmiPMR/jfsvnYFrRSt8WGTBNAfHL+K6PFdax3Kk0OsItUZ8fm5H/+Cv+G+9c/mnujtNVgZdL+ZhP4t+AhqWxJg65pTPq649bz1HaUjZAQskGUvXrtr1r+smieiv5GolZPhPusUKVQlkaWKK5h893+6RNFlctqRuILGuY0MdhSvF1VW2m
x-ms-office365-filtering-correlation-id: 6ab2b038-d2ca-49c5-b5d0-08d6145a897f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0149;
x-ms-traffictypediagnostic: CY4PR21MB0149:
x-microsoft-antispam-prvs: <CY4PR21MB014961C17AA3A218816A2F56FB000@CY4PR21MB0149.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(95692535739014);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231344)(944501410)(52105095)(2018427008)(93006095)(93001095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123558120)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0149;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0149;
x-forefront-prvs: 07880C4932
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(346002)(376002)(39860400002)(396003)(136003)(189003)(199004)(476003)(2616005)(105586002)(76176011)(446003)(486006)(14444005)(6666003)(2900100001)(256004)(217873002)(66066001)(22452003)(1076002)(6346003)(316002)(575784001)(86362001)(25786009)(4326008)(26005)(110136005)(102836004)(54906003)(86612001)(107886003)(6116002)(11346002)(5660300001)(6506007)(2501003)(6486002)(5250100002)(14454004)(7736002)(8936002)(68736007)(3846002)(53936002)(97736004)(6436002)(10090500001)(6512007)(305945005)(478600001)(99286004)(106356001)(81156014)(2906002)(10290500003)(36756003)(81166006)(186003)(8676002)(72206003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0149;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: J+y6Wj00qHG6X2KjxuV5Chu3hAIWG6N2IOF5yM8gjWC2Jxlh9/EYHcEkuL9ZPFPeBo2AzQnpilhN3AVhI/dJ/9G6+D+gDhCW7pgLyK4QofWSK3bBscp9hNr25VC9JtDBtlOrbgHSI9IKYngSQDoeSNNjDH3gmxgBCW9jGqU+m4YiAozqaJSWX0pGAsalE97lGhzOzAWcETszr0uDD5kdKYsJGKAg+VE/XhXoWwlCatcR9u6ny16V6kPwh1to/F9ge5ZwH+8Ha2EoEArImSN0w/zksUelzSa8i68SgMa4hBUbPsDxeYZ1S7YLTiSXE6tPTfZal17/RZjDhGkGy/Lqu6SHsZEgYroU+swetzkv1Ro=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ab2b038-d2ca-49c5-b5d0-08d6145a897f
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2018 00:38:25.6271
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0149
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Krzysztof Ha?asa <khalasa@piap.pl>

[ Upstream commit 5a1a2f63d840dc2631505b607e11ff65ac1b7d3c ]

The error path currently calls tw686x_video_free() which requires
vc->dev to be initialized, causing a NULL dereference on uninitizalized
channels.

Fix this by setting the vc->dev fields for all the channels first.

Fixes: f8afaa8dbc0d ("[media] tw686x: Introduce an interface to support mul=
tiple DMA modes")

Signed-off-by: Krzysztof Ha?asa <khalasa@piap.pl>
Signed-off-by: Hans Verkuil <hans.verkuil@cisco.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/media/pci/tw686x/tw686x-video.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/media/pci/tw686x/tw686x-video.c b/drivers/media/pci/tw=
686x/tw686x-video.c
index 0ea8dd44026c..3a06c000f97b 100644
--- a/drivers/media/pci/tw686x/tw686x-video.c
+++ b/drivers/media/pci/tw686x/tw686x-video.c
@@ -1190,6 +1190,14 @@ int tw686x_video_init(struct tw686x_dev *dev)
 			return err;
 	}
=20
+	/* Initialize vc->dev and vc->ch for the error path */
+	for (ch =3D 0; ch < max_channels(dev); ch++) {
+		struct tw686x_video_channel *vc =3D &dev->video_channels[ch];
+
+		vc->dev =3D dev;
+		vc->ch =3D ch;
+	}
+
 	for (ch =3D 0; ch < max_channels(dev); ch++) {
 		struct tw686x_video_channel *vc =3D &dev->video_channels[ch];
 		struct video_device *vdev;
@@ -1198,9 +1206,6 @@ int tw686x_video_init(struct tw686x_dev *dev)
 		spin_lock_init(&vc->qlock);
 		INIT_LIST_HEAD(&vc->vidq_queued);
=20
-		vc->dev =3D dev;
-		vc->ch =3D ch;
-
 		/* default settings */
 		err =3D tw686x_set_standard(vc, V4L2_STD_NTSC);
 		if (err)
--=20
2.17.1
