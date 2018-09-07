Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8144C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:44:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96DB020869
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:44:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="NFCCpHND"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96DB020869
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731269AbeIGFU1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 01:20:27 -0400
Received: from mail-sn1nam01on0102.outbound.protection.outlook.com ([104.47.32.102]:56221
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731198AbeIGFUW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 01:20:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/BPqrAowVAyVLfcCByhpOfArXeH3kBQiNhQO62INuuI=;
 b=NFCCpHND7Jt1xk6Tix3Il3/wRiR/yQ4d3V2M7Qf0utNrQ1gqCgdO6iOn6dO6YvoOqsXG3g8j7hdd8ZnHD5UeDiRP+8N5ervK/eKogkxTe2bmcKNMh4ul6OptpobyNN/bRma9xYHVu/6SYa50bnvbxfNksugz00zUlQDmUEQFG4w=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0469.namprd21.prod.outlook.com (10.172.121.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.6; Fri, 7 Sep 2018 00:42:12 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.008; Fri, 7 Sep 2018
 00:42:12 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Lars-Peter Clausen <lars@metafoo.de>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        "Stable@vger.kernel.org" <Stable@vger.kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 3.18 08/19] iio: ad9523: Fix displayed phase
Thread-Topic: [PATCH AUTOSEL 3.18 08/19] iio: ad9523: Fix displayed phase
Thread-Index: AQHURkM9mjV/sjARlEutwv8zus/HQg==
Date:   Fri, 7 Sep 2018 00:39:31 +0000
Message-ID: <20180907003923.58019-8-alexander.levin@microsoft.com>
References: <20180907003923.58019-1-alexander.levin@microsoft.com>
In-Reply-To: <20180907003923.58019-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0469;6:adNAU0IaCqzPDfY+OfFCdVGOs1UxUXeF+6+oFlVnC4liGkxpIiiR4rEAFhLG648r2wWSnhMMMSXu65++FdBW+/UKrpAOKuIJyVizU7qcKktU2cfmJHfvba9Qxx3U+/GnsoQ7skHlBCaFD8HTeQdGoUzPOISkaGfn6z4WNoGputqcR3HGJX7kHXfOlrXSiQkHt4Yy+rg6U62+zuCxNDsM8WUo0fpv+hDa7jUnbwU+8x7dypOb0CzubvyP36q0up93QobQptNAJ3drjSnjB6WDPGy6MJJuXFx5LhOusTsS2Qk3/AoGOzF0c5+RSxZ9cqclf3OnhoZzb+OtRTk/mgP31WN6xxpzdZl5664bmZAQSl2CySzDhOXIJqIEaQdBQLqB4kKNH/4ciwYPSwrSbPuLsoR3JpZWUL46U5fWIAM1dkPn6lYbU0nd3AbO2cutna/9LHNhxrAZteF6eG+LIaVR3Q==;5:vWYfNgApg0oXpXX3gWxez++WxCLjHLKHTf+J4X/V4/jsPziGEsQJUeW7iiMOeMbTwDBRkVyrJ462STlmQJJW/+7ChxHWKO9Xj+qqfLi/oi2ACYeZp6ccVBmgAmh7ts6L/CTVIcXfezfPb6RGaTf3NdEe9EuRd6lCA0bEr+JAFOM=;7:5WRAgeXsmAmut26C46R9U2IAQiRgeiMPKFXTu4wzjvzVZPrCwsckOJeEyN0Crt9p/KOG7f0RoOgJvC/YIBUj2xtRDxuEnf7lqITjvZCQvUYFguDrSXDLxBI8DZeVfmj4cUsvUWeJaDWpAtzlz8SkZ7RW8rrYq5lP2oZqwOeP4Yj9v8DRZgeKwAUF9+xbUm+VSjhorDNicXS+qjmSArr4bTLp/RSCc/le1/Jpkyd1STl347HyTwePw6h5t+etPOr0
x-ms-office365-filtering-correlation-id: 6b7b8d8f-d521-47cd-dddf-08d6145ac023
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0469;
x-ms-traffictypediagnostic: CY4PR21MB0469:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0469EF7E02EDF7DE464998C1FB000@CY4PR21MB0469.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055)(232431446821674)(50582790962513);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231344)(944501410)(52105095)(2018427008)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0469;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0469;
x-forefront-prvs: 07880C4932
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(366004)(396003)(39860400002)(346002)(136003)(376002)(199004)(189003)(25786009)(446003)(316002)(86612001)(54906003)(76176011)(86362001)(110136005)(256004)(6486002)(10090500001)(14444005)(26005)(2900100001)(476003)(2616005)(102836004)(5250100002)(22452003)(186003)(6506007)(11346002)(53936002)(217873002)(66066001)(4326008)(486006)(6512007)(107886003)(2906002)(8676002)(105586002)(72206003)(99286004)(1076002)(6666003)(68736007)(2501003)(7736002)(10290500003)(106356001)(305945005)(14454004)(6116002)(3846002)(5660300001)(36756003)(478600001)(81166006)(6436002)(97736004)(81156014)(8936002)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0469;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: xRYrYASiuLnmccGJ3aEL6g+ngkrVRM+gmKu/AcUL+arnE0MDvhin91TmVR4XcFiGXkrDUQSwg7+z1VAlumBkaIWsnq3SGkRIKtCmbIMOVhewjXvWfTGpYSbRp6dvja8lI0sEOwZsC0s3+3zujttJe2kUpQ9K6F+agtD8hfguHIBz8Hj2s6HA0Q9WlLW7JiQTzdUfHUE3G5eeBG5/LEHnVFqPK239T6vnCd7aW8lf0g4INwwuoE/lUrE72j3I/KlPK4RjtL2aJf1e2KQQKRt4lKbdo7xoLKx4u/f+GYehWC5YEtifmCP3mRjPBb2GT4VVSuNTj2HmCN51WDvpbHgyPpM1sM2f0/BX771Ae8MHfNM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b7b8d8f-d521-47cd-dddf-08d6145ac023
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2018 00:39:31.6860
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0469
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
index 7c5245d9f99c..abc21d913ef0 100644
--- a/drivers/iio/frequency/ad9523.c
+++ b/drivers/iio/frequency/ad9523.c
@@ -641,7 +641,7 @@ static int ad9523_read_raw(struct iio_dev *indio_dev,
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
