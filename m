Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4BF0C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 01:01:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91BFA2083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 01:01:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="OPIhwXOH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91BFA2083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729427AbeIGFkH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 01:40:07 -0400
Received: from mail-eopbgr710107.outbound.protection.outlook.com ([40.107.71.107]:21288
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727650AbeIGFOR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 01:14:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TQjoXOY//6prDp8ynRZ/elrDrrSp8BCInT5ge7AkeZI=;
 b=OPIhwXOHa1k+JVjelNZ5AxOY9CW69KmI49PkEf61qlJiMSb6KhAMhO0dWr8Pp3isFbGV/Fqn8ojAz3oQp3x+cz4BHF8nrolkJ10/CKjuDZ2akH5AObrsymLziYQjvYs6msPFYYwfzxgspgoREf0dJGCjfWrN+cyhz2oCyEUVAmU=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0824.namprd21.prod.outlook.com (10.173.192.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.8; Fri, 7 Sep 2018 00:36:09 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.008; Fri, 7 Sep 2018
 00:36:09 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Krzysztof Ha?asa <khalasa@piap.pl>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 24/88] media: tw686x: Fix oops on buffer alloc
 failure
Thread-Topic: [PATCH AUTOSEL 4.18 24/88] media: tw686x: Fix oops on buffer
 alloc failure
Thread-Index: AQHURkLF3qTYnaPZUUqbIuTf6ishsw==
Date:   Fri, 7 Sep 2018 00:36:09 +0000
Message-ID: <20180907003547.57567-24-alexander.levin@microsoft.com>
References: <20180907003547.57567-1-alexander.levin@microsoft.com>
In-Reply-To: <20180907003547.57567-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0824;6:ZtoKGf4OqLBPFmBtbq6x1NEUYBRSUU8qkjczbvdI8fxaVKJg5yi55r4HIt6pYPLCi0IwgOOfs8QusrTasDl34RSgP6hGAp8q/BKimdLV/sevhjQLNspiDzwZFt2nHDkBo1ll0G6rrlwXhVaVau4AKWUuwLI8j4MFC66pJn6npZR+rfsJg5fbleQC1sxbIVRSdKaydjYnm5/TABZQbmPnVaGNYDDBFfjO3Lj0iA6uYrRNRWYqx30gslpSGR3viSdkCsPG3RooGuBL7juZmdTZ24f6/qEHssMtOVat/zYMOdIqTpTANFRGBhpvA9fEtrIBYccHmCidbQfwpV1a1Q0pk9ucc4Uj4vtwOa4Nfpkt+tVJkw7W0hUGQ6buDg1OWr1+ixnR8h3lvZFYRStGQsdnT5LrVQPc4MeAlHBBiiMki1XmsBiVhlT++1wizShzW3Dg8D3lMIXpjalSxUkMGoL0hw==;5:dEU8nrtH0RkrFnBMIvgma9NGc8GqX/azliPQBZFgaLhviQgUGg1NFzluc5285U+wFOi8BE01b+PYCLhu+gwRpIN3Y6XcncBMVIDkoECfP5LLJBHfvEeSzrxA2L8i9nbjA+b7hvfMFekL2PLmR7EKyp7q9DxSnjUMwcz0i8rvGsI=;7:UovOc4NWeMAeeXhpjl8yEsSfi1m5Zzyr2bW/ICcU4I3EXLbx4NBZ+qu3zLayzh/rqADIwpTqjseccAjzV4rNaise9HasIGElcoU6o2QXR9Q/nH2D3i9n1Qlm4tBKht1POBT+kW++Wr5GkNMADelykJuB+5Ivh4xIFeOH5DoQFwh2vdXfoKywd5DZu11JnzBECzQkvhhRcA7QQuf8SO4/7J/X1tWvZ3yTmWxzsOkMbhvD6y7QDmyqfRgnkM1yzyXt
x-ms-office365-filtering-correlation-id: a88624b5-ea95-4e3f-7303-08d61459e7d4
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0824;
x-ms-traffictypediagnostic: CY4PR21MB0824:
x-microsoft-antispam-prvs: <CY4PR21MB08248F10FCB5A9407C65997AFB000@CY4PR21MB0824.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(95692535739014);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231344)(944501410)(52105095)(2018427008)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0824;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0824;
x-forefront-prvs: 07880C4932
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(39860400002)(376002)(346002)(136003)(199004)(189003)(22452003)(14444005)(256004)(102836004)(6506007)(217873002)(10290500003)(186003)(26005)(5660300001)(4326008)(6346003)(81156014)(81166006)(110136005)(54906003)(72206003)(316002)(575784001)(1076002)(6116002)(3846002)(8936002)(107886003)(14454004)(86612001)(2900100001)(105586002)(106356001)(5250100002)(86362001)(76176011)(2501003)(53936002)(10090500001)(68736007)(66066001)(36756003)(6436002)(99286004)(6512007)(486006)(25786009)(2906002)(6486002)(478600001)(7736002)(305945005)(2616005)(476003)(11346002)(97736004)(8676002)(446003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0824;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: hi/leaWMlsifeBm1uI2B0Igc/9ps8NRlelpuz9db58dTbbyvOvM1ZiiHx/xgSWGuVYG0Hb456ROBAT7tY2hn9MC04kR+CgPAkbit6nSTRwaUm6WihwRxB9EjUNmPAUyawj9VYeMP/ZcBxA5K1K5RUq5UwjJ6MrUY5jsmUYevxWTUn1MPEBqgkbo1AuKxaXXHmwp1SETsgMMTJHIevipThhWngRMfkcHETDLvkWksFc1N7hrIT5bhICprNIdJwZ4MELnaOKIEpXh7DjeWvVnH2OF1iYKLa0gFcmaV3N3U34o7GVYXEFj6xmJGmxenslTShjEXtP/1Ng7GREDtrB1qRQlJ55cGOb/W2ANhpkeSrbQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a88624b5-ea95-4e3f-7303-08d61459e7d4
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2018 00:36:09.2077
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0824
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
