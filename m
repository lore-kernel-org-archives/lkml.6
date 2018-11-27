Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56D7DC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 16:19:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 151E820660
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 16:19:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="OYodd667"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 151E820660
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730877AbeK1DSK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 22:18:10 -0500
Received: from mail-eopbgr80079.outbound.protection.outlook.com ([40.107.8.79]:11920
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730663AbeK1DSI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 22:18:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BGJWXK4zoU9TgoHpOXUZYze2VTo48OeLHj5lzwa4ldo=;
 b=OYodd667Hm9X9TbU5s1NTAmxdQOh/UZb6+ko+6/Nc10GVeaBtOaaLEl4LbByFpuG5Y8H0B3yeUqmr4CCp59lrc3W9P5t6BSr5YgfU8PDO3YLXhP6AXoNwVPn/MCRrn6K+xwAhPue5sM6c5/I+hcbvKeUvJE5y+RqMmWv9PQ0YJo=
Received: from VI1PR0802MB2528.eurprd08.prod.outlook.com (10.175.20.142) by
 VI1PR0802MB2256.eurprd08.prod.outlook.com (10.172.13.135) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.19; Tue, 27 Nov 2018 16:19:33 +0000
Received: from VI1PR0802MB2528.eurprd08.prod.outlook.com
 ([fe80::3d5c:5229:b634:b1ac]) by VI1PR0802MB2528.eurprd08.prod.outlook.com
 ([fe80::3d5c:5229:b634:b1ac%11]) with mapi id 15.20.1361.019; Tue, 27 Nov
 2018 16:19:33 +0000
From:   Dave Rodgman <dave.rodgman@arm.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     nd <nd@arm.com>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "davem@davemloft.net" <davem@davemloft.net>,
        Matt Sealey <Matt.Sealey@arm.com>,
        "nitingupta910@gmail.com" <nitingupta910@gmail.com>,
        "rpurdie@openedhand.com" <rpurdie@openedhand.com>,
        "markus@oberhumer.com" <markus@oberhumer.com>,
        "minchan@kernel.org" <minchan@kernel.org>,
        "sergey.senozhatsky.work@gmail.com" 
        <sergey.senozhatsky.work@gmail.com>,
        "sonnyrao@google.com" <sonnyrao@google.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
Subject: [PATCH 4/7] lib/lzo: 64-bit CTZ on arm64
Thread-Topic: [PATCH 4/7] lib/lzo: 64-bit CTZ on arm64
Thread-Index: AQHUhmz7NhQTQFWpAkKa/DN5+6ly9A==
Date:   Tue, 27 Nov 2018 16:19:33 +0000
Message-ID: <20181127161913.23863-5-dave.rodgman@arm.com>
References: <20181127161913.23863-1-dave.rodgman@arm.com>
In-Reply-To: <20181127161913.23863-1-dave.rodgman@arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.16.4
x-originating-ip: [217.140.106.53]
x-clientproxiedby: LO2P265CA0203.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9e::23) To VI1PR0802MB2528.eurprd08.prod.outlook.com
 (2603:10a6:800:b0::14)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dave.rodgman@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR0802MB2256;6:2sluLxddBizVCnSTztDFGreaM0WQpgIku6JDW53yGujUER28zEzb6oV30D4ptp7LqYqVF51ODI/pNCSZyYvpbpdV0eNXYVC83Z/lIeXLESHyUbG2eyKYU4k547+0tkZLs6i7N84+Y8rTFkhtkXBlw5GQG5qB1JLxqX7H2SoCE6/G4pJyHOOC0i33RMngfP1qaeeVZ3pyYH+SkiEiZ+jmS2lBFucLWTSqJk8JhX5u7oIBDbmXsqOjgr7qPH4feBAHD5xw7i71ucr9Ag1pXdTNMXUw908kyBItapiivZUX6kBm29AfzJZHboQ4k5XFsyhomlvtUqsdv7EcIFiopMvzBjryXMYUTIhM1lUa7RxBByYa13YrB+kYWFcFjzQ6c/s0AaGr8W/xaa4BYliYaRgf5IA0KUC94NqkXbSLR2e/iUfOFdsDdQ0QZVQw+YZyNG1/xoET4cakGZ6vmt4Xf2nzNA==;5:LfEnbWoa1tSJJZGM2HDKEda8Fei5nl/eX5tF9qD7aIt1RQ3XTRrSYRE3aQGwsMdnIa8SDX9sjxxEAnWP9XSogi9rdbODN1MlV/4Mydol+MK071KZ+2KwAyevbu5bnnTs5RWUd6r1s9GFogNDWtvexnzjfrOKOz8cK6RyRITSmGw=;7:S/0L+gRmLhO1dAefm9beHEbNO6ocfYlTOfqXKTSNc4FkTSE8Pexmj0/qHuIiuuoWGm6sJ7cYeOSrAgxjgLLg/BCCu1O7MyI33oJBtfgO/r9lYs7Zoi4OwekYCvcc7sO/Wnzsz68C/TooEHYgEuovSQ==
x-ms-office365-filtering-correlation-id: 7a3df203-2f95-43c7-0635-08d654841da4
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:VI1PR0802MB2256;
x-ms-traffictypediagnostic: VI1PR0802MB2256:
nodisclaimer: True
x-microsoft-antispam-prvs: <VI1PR0802MB225662592B2140DDDC916DEF8FD00@VI1PR0802MB2256.eurprd08.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(3231443)(944501410)(52105112)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123562045)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:VI1PR0802MB2256;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0802MB2256;
x-forefront-prvs: 086943A159
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(136003)(39860400002)(346002)(396003)(376002)(199004)(189003)(2906002)(106356001)(14444005)(105586002)(2351001)(256004)(6486002)(52116002)(53936002)(99286004)(6512007)(5660300001)(54906003)(7416002)(7736002)(6116002)(305945005)(1076002)(5640700003)(6916009)(446003)(486006)(3846002)(39060400002)(11346002)(76176011)(6436002)(316002)(476003)(2616005)(44832011)(68736007)(4326008)(102836004)(386003)(66066001)(71200400001)(36756003)(478600001)(25786009)(50226002)(26005)(6506007)(186003)(8936002)(8676002)(81156014)(81166006)(2501003)(97736004)(86362001)(71190400001)(14454004);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0802MB2256;H:VI1PR0802MB2528.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: APHzJAILuXGeJbv/MwOecUCkL+RAW5jO35yFthDjUsRB464J5a7yMFLGvkY0UXaqOQiGLtJPOYFKCDNrqtUs0S/bqMiAY3VXRxRCeEp8/B+CdL/MuxSDa9tyeRSeB9zuL4cebsw21cVANLI14nSRhuvwSX3cczBveWS9BujKKVEwZapiQcFfr8UhCD7xSkjoj6lSXDXmKOkNvKqBj1vO5YDn8muZzfCjJZiabIjuIgEsLKBSFA3+l6kn1ozKkrLNQnNynwL8Vhh/BuCCreyRiuicrF/7FcyTZYZqZVHGv9JckXyw6/WMTtUKSj4eEqHJ8VonoyarEIjJd/II0a5AKZyknihNwe089prI4mnTwgw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a3df203-2f95-43c7-0635-08d654841da4
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Nov 2018 16:19:33.1891
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0802MB2256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matt Sealey <matt.sealey@arm.com>

LZO leaves some performance on the table by not realising that arm64 can
optimize count-trailing-zeros bit operations.

Add CONFIG_ARM64 to the checked definitions alongside CONFIG_X86_64 to
enable the use of rbit/clz instructions on full 64-bit quantities.

Signed-off-by: Matt Sealey <matt.sealey@arm.com>
Signed-off-by: Dave Rodgman <dave.rodgman@arm.com>
---
 lib/lzo/lzodefs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/lzo/lzodefs.h b/lib/lzo/lzodefs.h
index c0193f726db0..c8965dc181df 100644
--- a/lib/lzo/lzodefs.h
+++ b/lib/lzo/lzodefs.h
@@ -28,7 +28,7 @@
=20
 #if defined(__BIG_ENDIAN) && defined(__LITTLE_ENDIAN)
 #error "conflicting endian definitions"
-#elif defined(CONFIG_X86_64)
+#elif defined(CONFIG_X86_64) || defined(CONFIG_ARM64)
 #define LZO_USE_CTZ64	1
 #define LZO_USE_CTZ32	1
 #elif defined(CONFIG_X86) || defined(CONFIG_PPC)
--=20
2.16.4

