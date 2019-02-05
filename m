Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E337AC282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 14:20:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A832B217D6
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 14:20:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="j0WMEVvz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728836AbfBEOUF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 09:20:05 -0500
Received: from mail-eopbgr20050.outbound.protection.outlook.com ([40.107.2.50]:6512
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727302AbfBEOUF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 09:20:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F20MCgjjHRtLWTShM2zDf2afczf1rb3Udrpz3yzjPRI=;
 b=j0WMEVvzEOMGqALU+NMw5ZxgnGeNUtPwY5JbpJyBUWYMSjkS9q6423AK8mfNMVH6Z1oeJztl++7dTYfIJdph5FPCTG/vRLaYuXvR4U1QajIz8SVR6wceE5+uZtW/bw4flrLhuhbE7SVhQeynWcQ6Yh1/59BF8LP9DPibjL3o7Ik=
Received: from VI1PR0802MB2528.eurprd08.prod.outlook.com (10.175.20.142) by
 VI1PR0802MB2158.eurprd08.prod.outlook.com (10.172.12.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.17; Tue, 5 Feb 2019 14:20:00 +0000
Received: from VI1PR0802MB2528.eurprd08.prod.outlook.com
 ([fe80::7446:fa53:3f15:c96c]) by VI1PR0802MB2528.eurprd08.prod.outlook.com
 ([fe80::7446:fa53:3f15:c96c%4]) with mapi id 15.20.1580.019; Tue, 5 Feb 2019
 14:20:00 +0000
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
Subject: [PATCH v5 0/3] lib/lzo: performance improvements
Thread-Topic: [PATCH v5 0/3] lib/lzo: performance improvements
Thread-Index: AQHUvV3harB5xiqPdU+EAv2Kl70Iaw==
Date:   Tue, 5 Feb 2019 14:20:00 +0000
Message-ID: <20190205141950.9058-1-dave.rodgman@arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.17.1
x-originating-ip: [217.140.106.52]
x-clientproxiedby: LNXP265CA0081.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:76::21) To VI1PR0802MB2528.eurprd08.prod.outlook.com
 (2603:10a6:800:b0::14)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dave.rodgman@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR0802MB2158;6:GqpGMHAdQy5W2ubFIB37PguiWwE0tP85U1OAeo29IDVlonoLmNrzEgye9vhAVev7xyx9vaEhGal9TZBI6zTux9tkeQHZNmY1mPR9tM10nQKh6PON9TxmSRlGTx3ef0nF5JYcaUU5x6p5jAFEgRsiMRUOjvYWptXZfKv6sqszAI2PGDJ6uKIhRJhBKNGwQObsTgq2yVXW4gRw+fYqRmm0+oDseUbBN96imy9kOjF5e8xZrtAUrya4HY79MVo8k5+XH9MojKApx/7QBM8BHEwnAvsEyHInpGj/VybHAOlixMjvySShk33NWJbbk59TvYLpkId2BUb3zwRYDwkOt55h8X1yEDub0rUP3xWuZsnm5R+8rQY5FPGmK+KzqY4n+F+8mWXDPdz9pPgy7dNcdwcBMTqlRgrMMeYgauMIShZGvbwA2JX+WOldeRqLNgO22PAzgg1caECVA5T6RJHSIKU1Og==;5:jIezLxdB0+bCX8WHQEddifIr7pzzeNPS4KvfTdpfyo4zu/CQYbPJSsfb7UqhFpIZbf2H2h1t/G2OJuMRNsXbJaRgy7NyfryO2YABbF/cc5IPy9v4uVzdmGfvp3jeHhu9vwT99W/dYEMDAnafNsyyRTOY3Vz6qQpDqpyLb16GsH5/rvVVQqr/sCn8V18ZT1WpV0dfVwcKywDo1wL5iv9itQ==;7:j1ioYALIE3WIcBy3VI+Y/dyNFCVmfSkdjy2pCh6DKhzhKHVJUFEawYhuqMjytyt2ZH6YLl/ejkEYC6D7nJqseu6uT8D6Mu4WoBuYnbtsYnqq6DokeGW58R1wktER5IxfVGlmxj3dEmmNR6fzapooGA==
x-ms-office365-filtering-correlation-id: 87744e36-a338-457b-1f88-08d68b750352
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR0802MB2158;
x-ms-traffictypediagnostic: VI1PR0802MB2158:
nodisclaimer: True
x-microsoft-antispam-prvs: <VI1PR0802MB2158C654862A639DBE92ADF38F6E0@VI1PR0802MB2158.eurprd08.prod.outlook.com>
x-forefront-prvs: 0939529DE2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(396003)(136003)(346002)(376002)(39860400002)(189003)(199004)(476003)(486006)(8676002)(2616005)(1076003)(25786009)(68736007)(44832011)(71200400001)(53936002)(71190400001)(52116002)(316002)(2906002)(478600001)(26005)(6512007)(110136005)(102836004)(106356001)(4326008)(105586002)(86362001)(50226002)(36756003)(2201001)(6306002)(186003)(386003)(81156014)(81166006)(66066001)(7416002)(6506007)(4744005)(256004)(6116002)(3846002)(7736002)(966005)(14454004)(8936002)(2501003)(6486002)(99286004)(6436002)(305945005)(97736004)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0802MB2158;H:VI1PR0802MB2528.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: y1RPy6VnpNwEvJurnwkGM9rrKisBLHZobj/qBVVze55dAIZc5MszPKs3+VNRsjGbmTSyOv+F00eu6MeFvt4rdK6S6WbCOyRGeql9wOtT3LEXyDEGL4Bt1AvwbbD/fjCdkSQTBWKF3gtC6YaTC2neezTYSvPXxvOBqqwuMI8PH1d2SM6RFoPqEHFlxgvToGSJhW5Escp7kURx/HHJsK7rnExkqPhX4s4spACO3ZbYyNY/mG+HUHRU3gZ6yGTp+rImOahpkikyJ/eXSdYxsYasM79cmL/1SrYaLYWrGL8Kq0y1fYwW9gDPJFCOGixs46rK2xZ+f/TMSvUL2bO+chIOj/EzQMWrPCxoaA/309cWOc/prJbhJYDW2WM0vDZ+gPiBiUxtfYTKMvO9SekpbSfaXuo/jwmDA2MIvndOiejJWs4=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87744e36-a338-457b-1f88-08d68b750352
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Feb 2019 14:19:59.7677
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0802MB2158
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Following on from the previous lzo-rle patchset:

https://lkml.org/lkml/2018/11/30/972

This patchset contains only the patches which were ack'd by Markus (i.e., n=
ot
the RLE patches). I believe Markus was happy to land these (please shout if
that's not the case).

Regarding the RLE patches, I've done some additional benchmarking and will
follow up with these as a separate patchset.

Dave


