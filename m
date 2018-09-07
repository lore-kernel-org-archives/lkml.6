Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2440C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:38:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CE032083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:38:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Kys0t1Wd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CE032083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730088AbeIGFQz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 01:16:55 -0400
Received: from mail-bl2nam02on0139.outbound.protection.outlook.com ([104.47.38.139]:49760
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726307AbeIGFQy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 01:16:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jaqF3VPZ8nJCbdaR/Z6HjAoXlFb8Ss2k5hBgXIqknNQ=;
 b=Kys0t1WdC0yJwRDWqQG0080IS4N0YjEeUZbI96eZPS4dXhQTzoGUcYfwpfcCYda9XT19AHAxkaRrvUuSPJTB59JpHMg0YitxZ2sM85bYsrHUaGFvgbGXMLj8yr+W3qNR4rtzhyrUDxSCyF4pI9n3mUTtbPyYRK03l7cWuPEDCNY=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0757.namprd21.prod.outlook.com (10.173.192.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.1143.1; Fri, 7 Sep 2018 00:38:24 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.008; Fri, 7 Sep 2018
 00:38:24 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Lars-Peter Clausen <lars@metafoo.de>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        "Stable@vger.kernel.org" <Stable@vger.kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 29/67] iio: ad9523: Fix displayed phase
Thread-Topic: [PATCH AUTOSEL 4.14 29/67] iio: ad9523: Fix displayed phase
Thread-Index: AQHURkL7+kFoLb3IP0eO8FYW3CkLiA==
Date:   Fri, 7 Sep 2018 00:37:40 +0000
Message-ID: <20180907003716.57737-29-alexander.levin@microsoft.com>
References: <20180907003716.57737-1-alexander.levin@microsoft.com>
In-Reply-To: <20180907003716.57737-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0757;6:RiMNlWqMRkOEeb2MdP3A/yuR38DBfSOQhwvyo4ko8kBwCI7E7gFuSq74dwT7BhXfxlE5q33pkx7RWd/TGkbN2eok/JO22N7zbiWPXuz/YAE6hDuHEDMi20VYf2PlbFJf9zJSanu5t3TIt2I+ozb/UHLthcLjsMqMlRX+RiS48fSks/0CugUp3myvH9nvjgXTYF9kADRHXfhXLoFWTMpL1kEYEoVFNCW5G/yjJRpIV84Vvk9CODYMDgn0Lcf7Bj4a7MZkSD+lAzcKeczhhEv0QvApBB0M3WK3Cq/gq1RVJUwRKifqk64L7ke0yTH+vdogiiekwCxdBZ6E+kojeUSCetaErWOjKHTRtH+V56HcWbugMvaOjWc6jM9uz04D7If4pFGVz45vbIxDG1BliIMSSZ3uvt8TqMKdbrybR5qXtBSPkog1fHCcJrwiDf68NH9MTZzR+TyeHKW2C0W0ESqX9g==;5:/KamJgtZnFB5w1TqEQC7JIif2kozJqLIEQ8oMxevrHHi7V8/jeHPLQ+aaN7oZRp+uzdSA/u9yLE8L29MjkwJlDfqCJbkGOiUdbxC8u8SAXrpjuSTrcyXqdWKGtluPRiB6szmeA92h1r4uXPIYjIVp7zZ3KzWuCpr4d7oaSd6ePI=;7:RbVyvENuyJI3olr79NnzZyJb1lj/oSfmKSYKonCWSzd9uEwudZuzuOzCxVWvt/LmXTFyyCmywRv6h5xAUQD/bIlbH5RcAMHCap56XlrSNFTXrA91p213CP4KoCD90yo61dXAopHGu5DrWpgjr4k4flnI4oRQPioR1TYheI7Mll+mY/2KEZN7ITrmCnVF5OFXs2HCG9KkbvRQaRFSh9Akff4n1hQAILLZBlcKGwlXW0omum/P6AkRTDIFCTZXcCJb
x-ms-office365-filtering-correlation-id: fb4a76ef-31b0-452b-fdcc-08d6145a381a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0757;
x-ms-traffictypediagnostic: CY4PR21MB0757:
x-microsoft-antispam-prvs: <CY4PR21MB0757DC41F41B5105CFDD5A7CFB000@CY4PR21MB0757.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055)(232431446821674)(50582790962513);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231344)(944501410)(52105095)(2018427008)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0757;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0757;
x-forefront-prvs: 07880C4932
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(396003)(136003)(346002)(376002)(199004)(189003)(8936002)(3846002)(81166006)(86612001)(6666003)(5250100002)(81156014)(486006)(99286004)(6486002)(106356001)(10290500003)(107886003)(256004)(14444005)(26005)(11346002)(14454004)(446003)(76176011)(6346003)(5660300001)(10090500001)(110136005)(2616005)(66066001)(186003)(476003)(72206003)(2501003)(54906003)(316002)(6436002)(86362001)(97736004)(53936002)(22452003)(6506007)(102836004)(8676002)(6512007)(2900100001)(68736007)(305945005)(7736002)(217873002)(6116002)(1076002)(25786009)(2906002)(36756003)(4326008)(105586002)(478600001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0757;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: t9ejdupJCGJ3H4EDQ7JHQ/LV5XU0i1kT4WXLwHb18kDOS44HsoqY5rKrAh2EHEfBXRKV5GIaMWjzjlYSBaLROfpK8dp7QwYGBvMZS4XjJS/B7LbXtUrkayvoFYEmjzooHIkicz62y1n6ssYuHr0GwIfJS+wWW+mD0FEZl95mocEpqs4SPBtpYMyQ5TrWtPpGwgnTY1oNvq8yxXGmQanm20PJieZNBoBSgW4IFLxB7gOFxLg/72hSzI8LPFK8RPSgLFv6Z8j3yk42RJ9yc4A2DQVLj8Ov64HjXUGzaYFSHpUiljZM4sSwmuK1PftNOlf9CUhRe98IGhG+1O16ozhY3y3euBFU7xAqOYuP2mUiLWc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb4a76ef-31b0-452b-fdcc-08d6145a381a
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2018 00:37:40.9140
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0757
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lars-Peter Clausen <lars@metafoo.de>

[ Upstream commit 5a4e33c1c53ae7d4425f7d94e60e4458a37b349e ]

Fix the displayed phase for the ad9523 driver. Currently the most
significant decimal place is dropped and all other digits are shifted one
to the left. This is due to a multiplication by 10, which is not necessary,
so remove it.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
Fixes: cd1678f9632 ("iio: frequency: New driver for AD9523 SPI Low Jitter C=
lock Generator")
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/iio/frequency/ad9523.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/frequency/ad9523.c b/drivers/iio/frequency/ad9523.=
c
index 99eba524f6dd..cb45fa314a92 100644
--- a/drivers/iio/frequency/ad9523.c
+++ b/drivers/iio/frequency/ad9523.c
@@ -642,7 +642,7 @@ static int ad9523_read_raw(struct iio_dev *indio_dev,
 		code =3D (AD9523_CLK_DIST_DIV_PHASE_REV(ret) * 3141592) /
 			AD9523_CLK_DIST_DIV_REV(ret);
 		*val =3D code / 1000000;
-		*val2 =3D (code % 1000000) * 10;
+		*val2 =3D code % 1000000;
 		return IIO_VAL_INT_PLUS_MICRO;
 	default:
 		return -EINVAL;
--=20
2.17.1
