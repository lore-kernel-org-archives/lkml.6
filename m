Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01386C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:48:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97CEC2083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:48:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="TfRYbYur"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97CEC2083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728022AbeIGF0y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 01:26:54 -0400
Received: from mail-bn3nam01on0093.outbound.protection.outlook.com ([104.47.33.93]:60384
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729305AbeIGFSz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 01:18:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jaqF3VPZ8nJCbdaR/Z6HjAoXlFb8Ss2k5hBgXIqknNQ=;
 b=TfRYbYurFYWpgwXH43EpAbKp3Edi5In6lwR7sppRiYnkGRIKgQeiBhpBV0TF3pMjdlHXoQGJauwe/dxs6z4N9nbw96i2KzV6fddMH3027E5CUs9o1XHvR3LyvRUYNO91YNc7LQ0iZ/dLkdbd4VKTpjz35zp/GUgibyGMNiiJmuk=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0855.namprd21.prod.outlook.com (10.173.192.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.1; Fri, 7 Sep 2018 00:40:44 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.008; Fri, 7 Sep 2018
 00:40:44 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Lars-Peter Clausen <lars@metafoo.de>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        "Stable@vger.kernel.org" <Stable@vger.kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.9 18/43] iio: ad9523: Fix displayed phase
Thread-Topic: [PATCH AUTOSEL 4.9 18/43] iio: ad9523: Fix displayed phase
Thread-Index: AQHURkMakK0WpUNihEe3t0sAeEmvVw==
Date:   Fri, 7 Sep 2018 00:38:31 +0000
Message-ID: <20180907003816.57852-18-alexander.levin@microsoft.com>
References: <20180907003816.57852-1-alexander.levin@microsoft.com>
In-Reply-To: <20180907003816.57852-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0855;6:tdghJm4lwFgBA0tU25/OgSznFDxK0/G/iGnuEVT5wn51Mr83u8ko1ThgT5oY8dG6ZXO9cCVf/tIqRBduwVIKy5KOqzXyrvPrwQoQbssSvFRXsR1MkGfpr3IHKYyipIb2hccTUxlJqcaWcHyE+o/Eqo/9xYpJETSexW3idtarxo1K8Di5Yy5mY85PqCvdlXHrSwM3O1tSOEv1NNAyA2Jcw6gH0P/dm/fpSB8zrBS91/UaotJwPU160ClG+LtysSvoHkC6aC5oUL9UxbdEndHmOlSdpm0Xt8bSa8HIlRAF1zERDThAqWbFISm1lSJDsG9hYm+JHKg75CW5gwtI5vAxA3edXb5ht816EFR3WdNvdaWJ0iBlpCDwt1k2/bRnxyjHk6qWyKRqizj80yKwkuALMVnMBa+1fbODzylZXpZOFb9mcUXk+nf9rVBUjPHFpux5lGCynq51xqZPKpB1d86KOw==;5:ha2v7643oG/I3akIShEom+PY03wQ6Sb8J9dc2TygmV5B8ISnx1zjqVwWFuHNlyPMQVIQr92+QSJ+ZpN+ip0jlI0cazUbCjtea+fYLN4yZzZJqpcCGnnYZKF8nMTUm20FBeLOuZfqAqtsCjJ5Sql0bkBRuKF0urk4t9FzNilB2BU=;7:+oKEvROnx7Up4tOd0AAV6Zt8HF8+JZ5BMMMvGwsnyriEAb4iUalv+TMPIV2GYl2ZNcsoFpKqKwas60rLKDouJgxWKtDPd29w9Qj86Qgq+pB7RSE9R5Zwl7FfRlsOGvXUr+aDCZG8fqf9DN324kA46K2NYG02vPY/dH/nGSBgAuN9GqO2zP9HbkxifDDMD9+v4geEJD0RxwfbeR8A8HalJVEMpWgUuTm+w7mUdwqqqD5gokys4oevotadqMP9unXF
x-ms-office365-filtering-correlation-id: 54df0d74-2ff7-4afd-9c42-08d6145a8ba7
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0855;
x-ms-traffictypediagnostic: CY4PR21MB0855:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB08552F254F640FABC599B336FB000@CY4PR21MB0855.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055)(232431446821674)(50582790962513);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231344)(944501410)(52105095)(2018427008)(93006095)(93001095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0855;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0855;
x-forefront-prvs: 07880C4932
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(346002)(136003)(396003)(366004)(376002)(39860400002)(189003)(199004)(53936002)(316002)(97736004)(2900100001)(86612001)(25786009)(86362001)(2906002)(6512007)(54906003)(107886003)(68736007)(110136005)(4326008)(81156014)(10290500003)(14454004)(8936002)(66066001)(81166006)(8676002)(3846002)(6116002)(478600001)(72206003)(7736002)(305945005)(1076002)(106356001)(105586002)(6506007)(76176011)(10090500001)(6486002)(99286004)(256004)(36756003)(2501003)(26005)(186003)(6666003)(5250100002)(14444005)(6436002)(5660300001)(102836004)(217873002)(476003)(2616005)(486006)(22452003)(11346002)(446003)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0855;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: hV2iHtClJcAtaB/Jc8VJxCM7PXOHn4UzymQUQ4dNZzwW2n/O/gbzRrFhzo3l2l6GffIozuvhcSKAG37G3kbW1J5nsOt1L2Lx3Eun6STCZVp5OvFc8lGKRSuATzaeJUXY6KHrwvw20mOwFaGYO4xf86DVILbaMmY86+HLXm2VqJUF8oddyFoi6xBXDbA3YCzlPmnEPvrvb3wMKW8X2m+bRyXDORmKLosiBABTTQTlCO1eOBccJ3dVGsQzxUOOxPDVPxdYZuiqogCy/vqzAoleVdKtdi5ekgKwBDvEOqIfe+B7jjSpoxZ4Y7xHx48JTgLBW5t6zm1aUqlF/4LgRJYeluVIgrUVtSZffkVTgKhbSLI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54df0d74-2ff7-4afd-9c42-08d6145a8ba7
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2018 00:38:31.7118
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0855
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
