Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57380ECE564
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:20:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1393E214AB
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:20:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Lw7ekRef"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1393E214AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730744AbeIQIpe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:45:34 -0400
Received: from mail-eopbgr690110.outbound.protection.outlook.com ([40.107.69.110]:61545
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730454AbeIQIaX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:30:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5WFgY29U5T5TzZTjf4E4QP33Vaz0HUfqncEWS3IeBG8=;
 b=Lw7ekRefw7MMvBa+HvBXMqdJB5+pxMA4SSKJ81knj7tkzAyuO+LB+bhs1BwBGomf0BhHatuF3DofG47xcqICvr37GFYR02vNU5Pj6LCye9d4mj2DrMGRBV5J8sgX8wPF5EQ8OdSDgQCZdV2RRR889Gpo/yHe1K8S0KQ8u+9v8kA=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0120.namprd21.prod.outlook.com (10.173.189.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.4; Mon, 17 Sep 2018 03:05:05 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:05:05 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Matt Ranostay <matt.ranostay@konsulko.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.9 02/57] tsl2550: fix lux1_input error in low light
Thread-Topic: [PATCH AUTOSEL 4.9 02/57] tsl2550: fix lux1_input error in low
 light
Thread-Index: AQHUTjML59m7o6AjXEaI/lDvP9WspA==
Date:   Mon, 17 Sep 2018 03:03:45 +0000
Message-ID: <20180917030340.378-2-alexander.levin@microsoft.com>
References: <20180917030340.378-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030340.378-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0120;6:HEqCKDsBQt/KUmR2Rf45zLDkrv8VJ1Q6iPPAB7J6+FqaCeZ1TGB9j2G4Q2Wf/gwspzrPj/N8cH3i+vMjSQT14VJDZVKszrQgmtXefsgoMa4OGCBo2aHF3z5MuYXLeSc8MtatzLPGwifKMzJ3B3vIUgJB/nBZy1UHmO3ih7yitdhAnHJpKFQxTctiw3eiLE9wrM0YzOeeXsHiKwpdY2cQot1Sf0EnlkdTraK2xJZuXpHTO3CYTmyanAfnqUXD1Nsgi+nvfFk88NYpxjeoYqBjmy2tbmb78mmoKUVvMOV0txgwdXB4i/9iLvd/n6OJNjAjr0WgjBzbq0Ou8h+wGSOMjFIlL06/9Qv93NxYJSb1zHKueE6UOOUpH+XXlx9+WoU0cq20m2F2b5E3I3Okt4DGv2PTjZiZtkW6HAX+tmqermTIenXtTJDw+KktVQFJYtgxYjk6ifN1PaV2q0SahK2/7w==;5:X9A5jcU5w7X8n5FYmXxMwvMjT2G3BJkdc9VpnD6Su4hRDQw2OG6e48deVddpXFI6WfQ34vo8es23Fk+6RKXUpJa3DO2I9b7i2fjydEQd5lrE9zoU9KFpUubrLy6lKNrAoMLm8UaApgSBZENWVxCMmzcAMi45yVTbcuRd/yJfgwE=;7:zJm+cMbCvbdoyj4XJY2MXtxDni30hCzsD/Eik3rNmDRx3veJGFh/C5DV1xwOdHVcwo9YIuU8gCClezqVXrivQwZbjMWhjOhGp5BZ3LoUZj5fpMQkomUvyBaajEODsdMwjOROuK9GsnJ2y5ykir9vMfkitxRsZlmBvcTeFdD3RpFyxmerxaQY6qjiUXmwHnb9FU87klemVBX0zud+EsUAsZdk/atbtAhurz7vlY7nBTVGuFuQMbBbqUV6RWxBID3j
x-ms-office365-filtering-correlation-id: 9dde00b2-61fa-4de3-9d59-08d61c4a5e88
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0120;
x-ms-traffictypediagnostic: CY4PR21MB0120:
x-microsoft-antispam-prvs: <CY4PR21MB01200FC775F1DE00A0D07DACFB1E0@CY4PR21MB0120.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231355)(944501410)(52105095)(2018427008)(3002001)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0120;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0120;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(396003)(376002)(136003)(39860400002)(366004)(199004)(189003)(54906003)(26005)(110136005)(446003)(2906002)(6346003)(99286004)(316002)(86362001)(25786009)(102836004)(10090500001)(2616005)(2900100001)(76176011)(97736004)(36756003)(11346002)(72206003)(478600001)(10290500003)(3846002)(6116002)(1076002)(22452003)(107886003)(5250100002)(2501003)(86612001)(4326008)(217873002)(105586002)(106356001)(6486002)(14444005)(14454004)(256004)(6436002)(8676002)(305945005)(8936002)(6506007)(81156014)(81166006)(7736002)(476003)(486006)(68736007)(186003)(66066001)(6512007)(53936002)(5660300001)(6666003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0120;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: eBpThJaLKzlQIqYRN/3S86JhxuWkG2Ep2n3EVbkJi3hQd1+7LTlpSGq/NZGtUjjcBFzRLn35xLbZ+s02fboEV39Oade4TwZAx7zhXIoPcV1HGrjaTdTK7kz47ioEkzD9patjl0w2JxGgVcY7nFxdzGPvVq+UO8Zu7LHVYFQrZ5OsugQ7+uTtdXx21BruOOVvzNN24URjXVgCKHD/hGRjzYvjDjqN+i4LMKWAnr4tGVqrzGiBRIvSzBxRx5nmNlxZ+MeurOyWEXxATsJ/hZoGU1b2rahGzyqVBcRep2PVF+2rUb4KUeH0RGiMVi/ZBn/1JXjYbGZbg449zRnzVYcYKvQ6mE2iGnb84SZot6cgfU8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9dde00b2-61fa-4de3-9d59-08d61c4a5e88
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:03:45.1180
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0120
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matt Ranostay <matt.ranostay@konsulko.com>

[ Upstream commit ce054546cc2c26891cefa2f284d90d93b52205de ]

ADC channel 0 photodiode detects both infrared + visible light,
but ADC channel 1 just detects infrared. However, the latter is a bit
more sensitive in that range so complete darkness or low light causes
a error condition in which the chan0 - chan1 is negative that
results in a -EAGAIN.

This patch changes the resulting lux1_input sysfs attribute message from
"Resource temporarily unavailable" to a user-grokable lux value of 0.

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Matt Ranostay <matt.ranostay@konsulko.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/misc/tsl2550.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/tsl2550.c b/drivers/misc/tsl2550.c
index 87a13374fdc0..eb5761067310 100644
--- a/drivers/misc/tsl2550.c
+++ b/drivers/misc/tsl2550.c
@@ -177,7 +177,7 @@ static int tsl2550_calculate_lux(u8 ch0, u8 ch1)
 		} else
 			lux =3D 0;
 	else
-		return -EAGAIN;
+		return 0;
=20
 	/* LUX range check */
 	return lux > TSL2550_MAX_LUX ? TSL2550_MAX_LUX : lux;
--=20
2.17.1
