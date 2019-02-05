Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC161C282CC
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 16:00:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8030A2080F
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 16:00:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="iBc7V8CV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730179AbfBEQAS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 11:00:18 -0500
Received: from mail-eopbgr10068.outbound.protection.outlook.com ([40.107.1.68]:19680
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730122AbfBEQAN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 11:00:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/ZxF6mDQyFxAGkI6vxA1w+/7tnWyf4Ka6luatslCm2U=;
 b=iBc7V8CVx498bOHmuadQbVgpxz65qjYO43BMLZEmLCbhxP3vIBNAPM90ZINBJ+bYAhMpDoAv9g2qjPmCfRSVzr0pRFwZF0vM0upt1JlxxIb6M8EUXOlwZZ3Mt37HZF81v9s8jTcsxQtxUvGnNiXO7s7ZzRYBlzt+r9AOgufcB4o=
Received: from VI1PR0802MB2528.eurprd08.prod.outlook.com (10.175.20.142) by
 VI1PR0802MB2447.eurprd08.prod.outlook.com (10.175.26.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.20; Tue, 5 Feb 2019 16:00:05 +0000
Received: from VI1PR0802MB2528.eurprd08.prod.outlook.com
 ([fe80::7446:fa53:3f15:c96c]) by VI1PR0802MB2528.eurprd08.prod.outlook.com
 ([fe80::7446:fa53:3f15:c96c%4]) with mapi id 15.20.1580.019; Tue, 5 Feb 2019
 16:00:05 +0000
From:   Dave Rodgman <dave.rodgman@arm.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Matt Sealey <Matt.Sealey@arm.com>,
        Dave Rodgman <dave.rodgman@arm.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "markus@oberhumer.com" <markus@oberhumer.com>,
        "minchan@kernel.org" <minchan@kernel.org>,
        "nitingupta910@gmail.com" <nitingupta910@gmail.com>,
        "rpurdie@openedhand.com" <rpurdie@openedhand.com>,
        "sergey.senozhatsky.work@gmail.com" 
        <sergey.senozhatsky.work@gmail.com>,
        "sonnyrao@google.com" <sonnyrao@google.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>
CC:     nd <nd@arm.com>
Subject: [PATCH v5 3/3] zram: default to lzo-rle instead of lzo
Thread-Topic: [PATCH v5 3/3] zram: default to lzo-rle instead of lzo
Thread-Index: AQHUvWvczRhyg1vx8ECRwg9AUnHX/A==
Date:   Tue, 5 Feb 2019 16:00:05 +0000
Message-ID: <20190205155944.16007-4-dave.rodgman@arm.com>
References: <20190205155944.16007-1-dave.rodgman@arm.com>
In-Reply-To: <20190205155944.16007-1-dave.rodgman@arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.17.1
x-originating-ip: [217.140.106.52]
x-clientproxiedby: CWXP265CA0011.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:400:2e::23) To VI1PR0802MB2528.eurprd08.prod.outlook.com
 (2603:10a6:800:b0::14)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dave.rodgman@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-arm-no-footer: FoSSMail
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR0802MB2447;6:7zXDSIpLSrat4MDsd4aJhs0y8CHXUgc4Tkyr9c1yHDgiKoxTlqB5snFpjv+32QxxKrTtl4DA8ciCnDVQnS1EbVMVe7b9YQuIzRzk6XPdofrPedZskO6ZdhYUvrajrG/BCE7xfSn82Pvck9h8/tDruLTSpFskSAI1q9LTviELlmWU/su8rm6AZn786KBzx2vLe1fTrxDUknHWqVJO2CYzf6PbCQUcetLQSauQpj8w6DljE8U0klVFfI+GcIckgN/irRwTTSuWNtax0sL0L2CqJzhz2zw3cH4LQ7w1yyLY0R+wc39+7cdTXu4oyiBneSSW5WG68R26ZuMl0Jem0QNNrorV82n7qG1SeBGaBGSmnLAvch/5nbER0HU048WZlYTmiPlmX/E7t21/8HfehPs4nOTP5RSzDFReucOgDpV5cQfZ2QneNM6Ewdi38/jZ8obpxstdDsEpHkV6x23fna6afg==;5:6Kfgorh6ua3JMFqVk+nrsvJJJBqEHBAJWeYhOInzJxuKZy+N/1z2jE2TCQ2GFDsBqbY88ux/9K7a5havQnUDzrpKNlPtSGJJrOrRGtCJtupwx0wxCllqGUgyNAQWDepRo/8S3aiBy3kpauQsEJAR5n5aC4fZgYt4OZA0qrSzs7zTMbBMN1867WeSku4LHHVP6NA1qZRaNkmHsxCoMX3p7g==;7:iBz+ahiUCHH20LTJp22DYxV3ID+bCwBUW0l4By8M9KjkDJG7SorkFRCBU3+xZh10Z0vT1B4TDZAiZ4YJpsFj4hOcgmAmS3bg8C/9IBTbAbbEl7XskzgajYiHUdOWctU+719ZKB9jlHZCD+l/dUeWlA==
x-ms-office365-filtering-correlation-id: 60b2cab0-97cf-4811-f051-08d68b82fe71
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR0802MB2447;
x-ms-traffictypediagnostic: VI1PR0802MB2447:
nodisclaimer: True
x-microsoft-antispam-prvs: <VI1PR0802MB2447E0059AC79C0B5091A9EC8F6E0@VI1PR0802MB2447.eurprd08.prod.outlook.com>
x-forefront-prvs: 0939529DE2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(136003)(346002)(376002)(366004)(39860400002)(199004)(189003)(102836004)(6436002)(6486002)(68736007)(7416002)(386003)(6506007)(26005)(2201001)(97736004)(7736002)(8676002)(50226002)(86362001)(14454004)(36756003)(6116002)(81156014)(305945005)(2906002)(478600001)(8936002)(81166006)(316002)(256004)(14444005)(4744005)(44832011)(53936002)(106356001)(110136005)(2501003)(186003)(66066001)(6512007)(3846002)(11346002)(486006)(446003)(2616005)(71190400001)(4326008)(25786009)(71200400001)(1076003)(99286004)(52116002)(476003)(76176011)(105586002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0802MB2447;H:VI1PR0802MB2528.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: I7Tw6Ft0O/Z4+cFoeUwNICTWdYuNHitEPEaZWeko9yo2fA+HeCQAEVqQRRt50OYMOFiDSTN7YfYTvBd1ajgvT7sGtWpbW+Go92DXnbU8ijc7Z+SXYlwA2YPuBuqB7wRJtN65TGt4JKKRL+siZNjwFvB7/TDAGBmkHXXb+1r46xnxOYjlbrn1n5usB33mDpkSiplZHtgUqrMLCB8es/tVMsszopL6Mur6YDh3LQZ2mG/NAwqSHZivlvbIAvvl7/q8IIHUtnc2Cy8uQQDZtgOME1ZJLBW4nAjL6oTHe3wQdFWMFUYL/fzA8vkIahUPtdCrPVHcrqFGazViIi1b6Gt35mdd8Hp36PV05aLFv21aa44o9IwCeq+/YSKBlHjTblxSVDGAWfId7U5yKQn02x/Q6aJ65CrhNWSsikHneHmLa8s=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60b2cab0-97cf-4811-f051-08d68b82fe71
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Feb 2019 16:00:04.4708
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0802MB2447
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

lzo-rle gives higher performance and similar compression ratios to lzo.

Signed-off-by: Dave Rodgman <dave.rodgman@arm.com>
---
 drivers/block/zram/zram_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 04ca65912638..e7a5f1d1c314 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -41,7 +41,7 @@ static DEFINE_IDR(zram_index_idr);
 static DEFINE_MUTEX(zram_index_mutex);
=20
 static int zram_major;
-static const char *default_compressor =3D "lzo";
+static const char *default_compressor =3D "lzo-rle";
=20
 /* Module params (documentation at end) */
 static unsigned int num_devices =3D 1;
--=20
2.17.1

