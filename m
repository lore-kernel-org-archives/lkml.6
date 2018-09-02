Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1B68C43334
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:30:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FCF72077B
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:30:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="cudFJ2Lr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FCF72077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729047AbeIBRpv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:45:51 -0400
Received: from mail-eopbgr710112.outbound.protection.outlook.com ([40.107.71.112]:8317
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728579AbeIBRVZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:21:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NqlZYEmBnpo58c1VzIcRTgzqedEbStZZf8kKrs1gQdQ=;
 b=cudFJ2LroCZmOYBwljgs73tG44CEWX5s2g4ekju3Hel2So8QZMULMKx0xP2Z6v+loNhhBKcPSI/yWxJsrcyUUKqRnD5S+Imh7xVp2Ov5THFI9CqjGPQuAEPCAli3SjM/V2ir4QAsrq2PTjceJ19vAPePk1qzQtE9hsoaUHq6mck=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0184.namprd21.prod.outlook.com (10.173.193.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.2; Sun, 2 Sep 2018 13:05:35 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:05:35 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Brad Love <brad@nextdimension.cc>,
        Michael Ira Krufky <mkrufky@gmail.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 102/131] media: em28xx: Fix dual transport stream
 operation
Thread-Topic: [PATCH AUTOSEL 4.18 102/131] media: em28xx: Fix dual transport
 stream operation
Thread-Index: AQHUQr2UVNrg6rhCFUGutu9u4ujnIA==
Date:   Sun, 2 Sep 2018 13:05:11 +0000
Message-ID: <20180902064601.183036-102-alexander.levin@microsoft.com>
References: <20180902064601.183036-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902064601.183036-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0184;6:kq7udxuqVOAx+/UWm8jCgH66wb0bVfwJZvgeWa0vYoZ6FfcbyJML9EwejSps6CVq3mUIktp8m09Yl20GXx2J3P0zZio16BajtK12fW0FGXR2AXsrCZA9b7cIlYlqOU2QIXqCkKnneTYj00p+/RX/mrLiV4M2l9bZUrxo2SF6v7r71iTO5Ym8skcSC1+vWuhCKCWwEXBOtFPt6LA+epUjJddTL64lBIIitiMDviR4bHs9woQZyXsaiiXoNt8QrhA9Favf7Dz7IFFVoFCpAUk3GSwd2oOWLIUzR3j35QbplI5OWXiMo0eLwaJmSANgfYe1oQOuCdwdTbVNlbEYCfAzF6U2qZtrQrygsdPuQxvtLSYu4AMDT1zLyhIIJzZ7of/M4Sj13HC7GxusFtN5AFDVPrKDVXw6oREtdYXLyVTTp2zlrJ8i6FeuEQPX9lwXJ8WUNlKebIaqWr+iR8EaqtvgRw==;5:MzYmolb+HnUvxKZAWBs8/SQxt4BhVRYst5JUMcIU4AjXB2A4hjmgYNmQmSgfy4svMG0fBr5IpHmYio7PGsLStzZ0tdLinM6D5Dh/UvK0XyKJEur3oLKxTYxxTYEnm7lvkczIy+1CwQtEU7px3yQujdWnrSIwvTdaUdENQSk4hKo=;7:EcJp6AnO5TBCaT2ArTs2KCiVW48Sfw+H/gXajAriCvTr6G/bdYsIkug+zlEFXbAidhc79uBggHT+O6+tRhAA905S1hasPwSG3TFHxmXiY3szsXLMoQupVMZwVKbnZVEDAsLG5gbhxR8I1ShP4Y0/VGEyzXiXD9wN2/hs/djSuVBoc7lNZsfm7n9/CRtbiQvVtV3/JzefAipyp9yFBcrA2XUdkmEmTjuNxq8nFQZp00iwSNxDEG9V4/3ga4tSWrty
x-ms-office365-filtering-correlation-id: 7b3d2166-3e62-4074-7b69-08d610d4c5be
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0184;
x-ms-traffictypediagnostic: CY4PR21MB0184:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB018497CAEE02E2AFFE60A5C5FB0D0@CY4PR21MB0184.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231340)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0184;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0184;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(136003)(396003)(376002)(346002)(189003)(199004)(6512007)(53936002)(6436002)(97736004)(105586002)(22452003)(25786009)(106356001)(107886003)(39060400002)(4326008)(6486002)(110136005)(54906003)(316002)(10090500001)(14444005)(5250100002)(256004)(66066001)(36756003)(6116002)(2501003)(26005)(6506007)(5660300001)(3846002)(81156014)(76176011)(99286004)(102836004)(1076002)(8676002)(81166006)(10290500003)(2616005)(68736007)(476003)(2906002)(8936002)(11346002)(72206003)(186003)(305945005)(7736002)(486006)(6666003)(217873002)(86362001)(2900100001)(86612001)(446003)(14454004)(478600001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0184;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: MyhRfYNAbNr6vndFKHbsrh3VIYRMSHvoY4+JT1bOmJsQ1VaBjiGHBdY6dZQm3H/oQdakQmUQGxQG19t1XIuVd2OCqS7WG1tQ691FR83ftYCUm7UfljB7GycZObu98cCHvKKOk4B0RWn1a2By/OZ/Tacp+v7/Dn2iJnDOHQ8E50hcoE3VJjujVnQXyLNPtrPG4oEInmeU9k0IWltWmJaMZuwXakjJlMG7UubFS1EKBJniSp/D/pg4XctKB9cF79A9lZAUyWI8hfRZ8t9CTdziCSvltiiyj78h0z5GUU3ASvezjcXiwCJKFPI6NSaZoL7ZV1FggTjQce5KZ4hWpHtfYEuo1WejoG3heqQmGzRKX1o=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b3d2166-3e62-4074-7b69-08d610d4c5be
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:05:11.5780
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0184
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Brad Love <brad@nextdimension.cc>

[ Upstream commit a7853c257a3ea0907467a1750ff45de4d9ba1915 ]

Addresses the following, which introduced a regression itself:

Commit 509f89652f83 ("media: em28xx: fix a regression with HVR-950")

The regression fix breaks dual transport stream support. Currently,
when a tuner starts streaming it sets alt mode on the USB interface.
The problem is, in a dual tuner model, both tuners share the same
USB interface, so when the second tuner becomes active and sets alt
mode on the interface it kills streaming on the other port.

This patch addresses the regression by only setting alt mode
on the USB interface during em28xx_start_streaming, if the
device is not a dual tuner model. This allows all older and
single tuner devices to explicitly set alt mode during stream
startup. Testers report both isoc and bulk DualHD models work
correctly with the alt mode set only once, in em28xx_dvb_init.

Fixes: 509f89652f83 ("media: em28xx: fix a regression with HVR-950")
Signed-off-by: Brad Love <brad@nextdimension.cc>
Signed-off-by: Michael Ira Krufky <mkrufky@gmail.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/media/usb/em28xx/em28xx-dvb.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/media/usb/em28xx/em28xx-dvb.c b/drivers/media/usb/em28=
xx/em28xx-dvb.c
index b778d8a1983e..a73faf12f7e4 100644
--- a/drivers/media/usb/em28xx/em28xx-dvb.c
+++ b/drivers/media/usb/em28xx/em28xx-dvb.c
@@ -218,7 +218,9 @@ static int em28xx_start_streaming(struct em28xx_dvb *dv=
b)
 		dvb_alt =3D dev->dvb_alt_isoc;
 	}
=20
-	usb_set_interface(udev, dev->ifnum, dvb_alt);
+	if (!dev->board.has_dual_ts)
+		usb_set_interface(udev, dev->ifnum, dvb_alt);
+
 	rc =3D em28xx_set_mode(dev, EM28XX_DIGITAL_MODE);
 	if (rc < 0)
 		return rc;
--=20
2.17.1
