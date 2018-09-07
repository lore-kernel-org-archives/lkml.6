Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 664FDC4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:59:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03DA22083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:59:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="J/wNU9On"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03DA22083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729082AbeIGFPC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 01:15:02 -0400
Received: from mail-eopbgr690129.outbound.protection.outlook.com ([40.107.69.129]:53565
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725926AbeIGFPB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 01:15:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=52z3ZfgFnz/GCCy0ilBSGcfDRzgGQ/EgKH3GMyfkOLM=;
 b=J/wNU9OnkLkZgyqm2AHEDaT2hMuk8IIKtTCHfmBzbiCvH6xkp2wUHb9ksmUpLeM0qqmruOiRnGN+kub4zcre6VdRk1hMMiqCNMBymnDXpsPH6IOa3fq8vzNJFGBK99xPzfQo4t5ct0LlHOcrPOp1EiNEPlFNYXgNeWMNj6h9+mo=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0773.namprd21.prod.outlook.com (10.173.192.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.1; Fri, 7 Sep 2018 00:36:47 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.008; Fri, 7 Sep 2018
 00:36:47 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Lars-Peter Clausen <lars@metafoo.de>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        "Stable@vger.kernel.org" <Stable@vger.kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 37/88] iio: ad9523: Fix displayed phase
Thread-Topic: [PATCH AUTOSEL 4.18 37/88] iio: ad9523: Fix displayed phase
Thread-Index: AQHURkLLv3lYX/1rGEOsX6xH7ahtlQ==
Date:   Fri, 7 Sep 2018 00:36:19 +0000
Message-ID: <20180907003547.57567-37-alexander.levin@microsoft.com>
References: <20180907003547.57567-1-alexander.levin@microsoft.com>
In-Reply-To: <20180907003547.57567-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0773;6:k7eIDyXT5zhy8GW5J4oGDZBkm8v/gXpu2WzdO+ZH0Y/8z5um073wIoyRLhvyHrqB59vrIPw9VrUPRDfwWw7CC1wSAPv4c2x6x2ZxqTJgVP1zcDAJLB/3cpQe8xXootcQIGEo+QjJChEWXXYFnqOdiRSCVa5p8sM/UL1CzXVcNTmhRgHlA58Hg7/uwOPRVhbpig8DrSh+yhXdJAXylRvei4QDPaEmdvk1+v+Fk95F/d1pfU8YMab5octOd9MelujefsUhbPJWwxBvQRnOjTkGMCt9vG2VGKI8ZFjR7L/wI4i3+0/s9iTxZ5qNAwRUAt2s+bL0jaj3feEyIfkOCapjn/uXvuHfi1rYiEkaQy8fkJTw15H5jH6J2Iq5lIK2Wc+/OKIH/aiLNjlnm2zteMhCv3pcYjpg5NjH95+Y7+zX6qhxfZsr7RMUodx0Y1PVYHFGhvdFQRrKSYz++kwMm2oOoA==;5:0dMn6muDVphXLtGjsVv4kj7RmFkvFiWVhL/9ddrGSupReDPmn49bX9cboLdG6UHI70JBL+NqPre4G4/bZ4+VgUoH2xbarEHdN6oaYVWe6tWabXTZePug1NhmMY+bUxIdbyDTGbc2Q3nIj7cw5c5t09H/4CV/ISKLBNvW1I/oIeg=;7:J+/KwA+V9tmdP8F/lgbltvZQNLCF4gZlqx+ieutePYV+P110bCdIaJTEpY8yp6cYn/nvXzuTykYB0GeB3COdubFncUSSXqiWvq/Hpdm7H7AnaZHAPK7IjPZjArbKmNT9URy91a8k2z2uMmj260Hq6Ry44PjWmaFziXA2KTwvMD73HLO2FRoN8OCIh8MpiZKe3zA/r5yEIYfGiu9MwMzFLfybJfioDIPb4c4kV7iRhzc+aJH55e/ok/rbOv2fdx02
x-ms-office365-filtering-correlation-id: 1a4833ee-026a-432b-4d9c-08d61459febd
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0773;
x-ms-traffictypediagnostic: CY4PR21MB0773:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB07736DA771E51A64922D5E5BFB000@CY4PR21MB0773.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055)(232431446821674)(50582790962513);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231344)(944501410)(52105095)(2018427008)(93006095)(93001095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0773;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0773;
x-forefront-prvs: 07880C4932
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(39860400002)(346002)(376002)(396003)(189003)(199004)(8676002)(5660300001)(106356001)(6436002)(25786009)(110136005)(54906003)(6506007)(105586002)(2906002)(486006)(53936002)(446003)(2616005)(476003)(4326008)(6666003)(11346002)(5250100002)(107886003)(2501003)(86612001)(97736004)(6512007)(478600001)(3846002)(72206003)(6116002)(10290500003)(76176011)(68736007)(14454004)(1076002)(66066001)(26005)(6486002)(99286004)(8936002)(36756003)(81166006)(86362001)(14444005)(256004)(102836004)(81156014)(305945005)(186003)(22452003)(2900100001)(7736002)(10090500001)(316002)(217873002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0773;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 0YzrJsz5FVj1jLTkqEwW4PAMQKfVu1ZzFwZsHBxDScCmAgwg9PFfhs7UduSSoLw7Xwjc9F0OSV/ztq5eUBC5UgHq/4/iDW0xE3SfWknXISBdEduchvIvb7raUFRhepz+9bnDl9SW9yLFYXL5bh7DCb0soocxx6T7cfmwKOfUNgLE21kYis18sZQnllOEA0B4WBsrQUY31mmyHXGJestF6suc59NqffkTYksCZy14OW9XkioVz9izPJdlppbwc3JMfDjBO87F4W+kqB04m/so9Uh+aXd1LzWISIpE11rCjjKpkD658o3KA9J31EZksgB61vNj+8iC5C/fSVM29g4xobyo/6GLmhxQ615sngJiHyQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a4833ee-026a-432b-4d9c-08d61459febd
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2018 00:36:19.6514
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0773
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
index ddb6a334ae68..d5b2c231a661 100644
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
