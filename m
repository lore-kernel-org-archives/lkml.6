Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F749C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:45:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E3A220844
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:45:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="UdFmgEFS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E3A220844
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728288AbeIGFYC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 01:24:02 -0400
Received: from mail-eopbgr700133.outbound.protection.outlook.com ([40.107.70.133]:49024
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729393AbeIGFUJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 01:20:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ul+ZtNjlSKF/O0s2SA0CJreSPYX1eVpIwlIwBwMb+fI=;
 b=UdFmgEFScyuV+cgMPQtKtl7ZaCIOcvCEqLWk8/gPd21oSJgGdFC28Hh0JFVfKbkZ6/3795KItv8JupsDmwZiyFIpNwtX5oANImxIAfEg4SD+d1aUmx+SRn6BB4JYomloHdDILLrXzQXFWwXawWT/Da1uFzQUpxKepK5Sb/02ykU=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.1; Fri, 7 Sep 2018 00:42:00 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.008; Fri, 7 Sep 2018
 00:42:00 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Lars-Peter Clausen <lars@metafoo.de>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        "Stable@vger.kernel.org" <Stable@vger.kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.4 14/30] iio: ad9523: Fix displayed phase
Thread-Topic: [PATCH AUTOSEL 4.4 14/30] iio: ad9523: Fix displayed phase
Thread-Index: AQHURkMumxleSb1CU0qdYGIygekLLA==
Date:   Fri, 7 Sep 2018 00:39:05 +0000
Message-ID: <20180907003853.57942-14-alexander.levin@microsoft.com>
References: <20180907003853.57942-1-alexander.levin@microsoft.com>
In-Reply-To: <20180907003853.57942-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0776;6:fi/M6ZVN8i5UkisS1+qmQ97eQl/6XFFjD+j7V1lwMubBVc/nqGplhxwZNWjhJtqPVqreltgqblBSecoOEsKyu6CYHtLE4z9yqarC43KFAnjc34iRQnGTB+ssCuFGZk6Nr1e3u2ad7m8fmHlRA5FpE/R31My0hQORdBrzpkYqMWVfF4H0O4rcVR9Bgv75kV87fVr3GXOSKDiSzIFtvSe5/Nprw8UwRoTXDSLveNLI7qhUfg5maoQ9238C48mFRcnsTPJHCeT+jgPmVKhowyFH0n7nCxEgSaG5Cv7GsM63K2fUozJwv++/QNQ2HnBMwVr1QtQ4CSHiuAWdJFuSz371wsNa/YxQ6SXCyBRbIJECxG7/CRWZCnt6f8omFaeDmO3GuQqHQuhrCloOD4QPkuJZ68J1XnobU5leQ4fXhRQPPFdm/zRPIL39xfd1soi+CaB7iuEyMbcO3eCf/Q6DsXedvQ==;5:mjrEHkGQD2IUJfpkKRzpVGBW1Ij4e6EERhgjeaJ76OLyce3bD8JcdpSKGK4mOzRW/al+elxILrPG40J3P11Iy/QCIv1WdJLBIhoXUbLiBTAvgdVvToKlHHRVZ0EYZEJgqYCjtweOPD0rIgzglPevJrCwNVYUqnLFF/9H+nmDijU=;7:pDsXS8HwcxeHFMdpl1N0QLznqASoxv06DFW9nb6liVwZHLMArMa/xrNgXSxEfhDglR3xJPeqt8MkzhR16tv+l3qmjMKZH7JHTjxBd4bMkTFR7Sbrzoqko50hOXL9eL32rlDhbtPc+GC9gXDepxWffWQoCfKhzdDvTXJp2f7fi6bxGIU3TpSeIPDDiILTV91bu/v5PE85U3bDkgTkbKIYXDFBI2cMvTBuweQ1pgjpECwkYvaZR61lZYRyZ8cucrwp
x-ms-office365-filtering-correlation-id: 9d8f01b9-ce6b-4617-aaf6-08d6145ab966
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0776;
x-ms-traffictypediagnostic: CY4PR21MB0776:
x-microsoft-antispam-prvs: <CY4PR21MB0776F06135D98C59B8614A68FB000@CY4PR21MB0776.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055)(232431446821674)(50582790962513);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231344)(944501410)(52105095)(2018427008)(3002001)(93006095)(93001095)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0776;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0776;
x-forefront-prvs: 07880C4932
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(396003)(376002)(346002)(136003)(199004)(189003)(6436002)(99286004)(2900100001)(76176011)(6486002)(105586002)(54906003)(110136005)(316002)(106356001)(81156014)(81166006)(8676002)(217873002)(256004)(14444005)(305945005)(7736002)(66066001)(2906002)(6506007)(3846002)(107886003)(14454004)(10090500001)(5250100002)(2501003)(6346003)(6116002)(102836004)(1076002)(186003)(26005)(478600001)(72206003)(4326008)(25786009)(10290500003)(36756003)(5660300001)(6512007)(22452003)(53936002)(97736004)(476003)(446003)(486006)(8936002)(86362001)(68736007)(2616005)(11346002)(86612001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0776;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: fGMN5pU292IGBSHeyPWIjxk5jH8amuNUI6/JMuhupcU0ORFcv5Zwe4bQGqNxIAMuCt9yizIvKxc8HCqwepN1Bj5q2rZidyEapvJQA+bAVOZ1zFAmrJ2KGgiC+7a53V7HoPAME6pbE3rTjQFGTmPi0nBtE0PvEkzV4ECoeRcWS3CMOcJcJycp0u50IdP7SZffNr5qEppT6SQH84aZ2iXuTVUlOSiDZ7cKGICm7jTueQlAxlT6NwbIkIJruySLUrpweDuMhoseml9tdPbHMDUg8Wie2aaeqgHNh9s5E44/iaaIvd8AUvjNv02HzKZi2xXZajdpU1tYHCvWDmHJ/JhzSYnEsm7awe3FBWlWFw/UUZM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d8f01b9-ce6b-4617-aaf6-08d6145ab966
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2018 00:39:05.7634
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0776
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
index 44a30f286de1..adc86aa30409 100644
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
