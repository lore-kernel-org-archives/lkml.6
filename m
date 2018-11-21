Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDA35C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 11:59:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BF8F2147D
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 11:59:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="U7BcT3xG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BF8F2147D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729935AbeKUWdt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 17:33:49 -0500
Received: from mail-eopbgr60069.outbound.protection.outlook.com ([40.107.6.69]:2801
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728460AbeKUWds (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 17:33:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1LPMTg98OYc8+kR88NOfqmclVm5WN9qMCfaHT3fI2wI=;
 b=U7BcT3xGua312x1kgAeGFJ89qxegQTvRFnwsWskE38PIag/w+sujEt84Ims1zptlslo1H8s3WutBJe+WOua0g8nWMAn7ur8do3EEz39ufz9x/4EIW+zePhPYdjRFVhqjfiUiM1e/IDwTGf54zw4nYlBsn2OvbkvcETFetZ+UhRI=
Received: from VI1PR0802MB2528.eurprd08.prod.outlook.com (10.175.20.142) by
 VI1PR0802MB2461.eurprd08.prod.outlook.com (10.175.26.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.15; Wed, 21 Nov 2018 11:59:32 +0000
Received: from VI1PR0802MB2528.eurprd08.prod.outlook.com
 ([fe80::3d5c:5229:b634:b1ac]) by VI1PR0802MB2528.eurprd08.prod.outlook.com
 ([fe80::3d5c:5229:b634:b1ac%9]) with mapi id 15.20.1339.027; Wed, 21 Nov 2018
 11:59:32 +0000
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
        <sergey.senozhatsky.work@gmail.com>
Subject: [PATCH 2/6] lib/lzo: enable 64-bit CTZ on Arm
Thread-Topic: [PATCH 2/6] lib/lzo: enable 64-bit CTZ on Arm
Thread-Index: AQHUgZGqN6pzoQP0L0WMU+nhfE9TCQ==
Date:   Wed, 21 Nov 2018 11:59:32 +0000
Message-ID: <20181121115922.22864-3-dave.rodgman@arm.com>
References: <20181121115922.22864-2-dave.rodgman@arm.com>
In-Reply-To: <20181121115922.22864-2-dave.rodgman@arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.16.4
x-originating-ip: [217.140.106.53]
x-clientproxiedby: LO2P265CA0301.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a5::25) To VI1PR0802MB2528.eurprd08.prod.outlook.com
 (2603:10a6:800:b0::14)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dave.rodgman@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR0802MB2461;6:swFFN/2ROv5i96DV5CHrg51NQZcnwOtvlnUSrMKVbim6PdXzZkGLG1tufpRKToB0pWCCOU72YTYudnbAG9ZAXorFLw22Tl+gSoRTol9CoqRoFcNvsHaziNSEGLrIdk3LqtLkrDcKUgZSS+nKMmSxTFbexRenTAqojjSrbGorUbwuGUAlGPnzvgweuT+7aGqcokUZSSm3FrLDnSQPO6Wc1ACZrLtwiVcZl6dJ2vpJqJ99p5fEKN6BTOKJKS7st6WmHVUUR9uM9U99K/xj76F/ZuRvgFQopU/Z9b+L7PHohGQ7iNfHZ3YlMU2MBoIyfD+mhej8lVqta0LPmAZKch20g5b46Qlk38b8pfimAon8JP+W83tRJMTWD7BogJV12DpicGT6QMQF4DzJo/J4FsbJBxkqu5StR+IMrla86JRRpKv4yehKYlLkNFMzr+gZ9ULlzvx5hqzVh99kAasIN+mZ9g==;5:tYMKwAz2l3q7Z0Y2uagXFEtVoLR4pBNzJEM6HVkg/427tMe3QXfmxl1cUasCMjuIXJyxytKoHC9SvZ7RpRiQRlF6+0cuhbfiST8BrUEQVyX4oq16uvcMa3tY2rirjmaLRrXK2bHXicwZAt1n6EGs68ljIsvgCFusC+7tOmy6R5o=;7:xJK7a3Va2Cy9FUjv+AG4RXmXHxbq1GYMIQ108ImlfWVbE69sfGWo4akXwMhoEl8qkwYSQUZb4YfrhfCAi1W1GQz2PQs2gQZdi2EByJ+PG3boyR3g4FoaOFv4uPf/hyANOh6nkceLUpVMumR9Ii3L2g==
x-ms-office365-filtering-correlation-id: 9ed872d4-b700-4563-5ca6-08d64fa8cc5d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:VI1PR0802MB2461;
x-ms-traffictypediagnostic: VI1PR0802MB2461:
nodisclaimer: True
x-microsoft-antispam-prvs: <VI1PR0802MB2461FD04AFEB48889F2F61B88FDA0@VI1PR0802MB2461.eurprd08.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231442)(944501410)(52105112)(3002001)(10201501046)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:VI1PR0802MB2461;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0802MB2461;
x-forefront-prvs: 08635C03D4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(39860400002)(376002)(346002)(396003)(366004)(199004)(189003)(6486002)(68736007)(2501003)(316002)(97736004)(186003)(8936002)(478600001)(54906003)(7736002)(39060400002)(305945005)(5660300001)(2900100001)(8676002)(2351001)(99286004)(106356001)(36756003)(102836004)(26005)(25786009)(6916009)(4326008)(6436002)(52116002)(105586002)(81166006)(6506007)(81156014)(76176011)(486006)(2616005)(66066001)(476003)(86362001)(575784001)(386003)(3846002)(50226002)(14454004)(44832011)(5640700003)(53936002)(6116002)(71200400001)(1076002)(2906002)(256004)(6512007)(14444005)(446003)(71190400001)(11346002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0802MB2461;H:VI1PR0802MB2528.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: F4h230L2YDdfrp3HT2XKVczddYCjFwcV+54UYMeac93FUMlrmprWiE40FhZd2ohwm11JhHxaOrFtFVwmn/APTR6Z77YQBsBmjaUpGc5ptXnMneBNKEwguF0R2R4AcEgZkHK/edLvu+gFBz85oi0Pqi2cSk2ZD8YQvsRsAqBfEwgAh89RLNSQpCyQrYRJ/8fgpPmJVRb9b6BfgedozcKl21YR86HOAzff2WtT73iEHcOKgl4F5Cx0l3NAnYDA+4EFf8nlCGj/WJJQL8ZcDsmG8U++8BcnW8o1KJ6QyMKTS2Gv+ajBMwPnPj6GayTdYoWvlpc5WkjoL5j2ivpPy4gXgVLB0wgC7+/bUTbUl4JB1WA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ed872d4-b700-4563-5ca6-08d64fa8cc5d
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2018 11:59:32.4555
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0802MB2461
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matt Sealey <matt.sealey@arm.com>

ARMv6 Thumb state introduced an RBIT instruction which, combined with CLZ
as present in ARMv5, introduces an extremely fast path for counting
trailing zeroes.

Enable the use of the GCC builtin for this on ARMv6+ with
CONFIG_THUMB2_KERNEL to ensure we get the 'new' instruction usage.

We do not bother enabling LZO_USE_CTZ64 support for ARMv5 as the builtin
code path does the same thing as the LZO_USE_CTZ32 code, only with more
register pressure.

Signed-off-by: Matt Sealey <matt.sealey@arm.com>
---
 lib/lzo/lzodefs.h | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/lib/lzo/lzodefs.h b/lib/lzo/lzodefs.h
index 9f167eaabb28..a9927bbce21f 100644
--- a/lib/lzo/lzodefs.h
+++ b/lib/lzo/lzodefs.h
@@ -33,9 +33,14 @@
 #define LZO_USE_CTZ32	1
 #elif defined(__i386__) || defined(__powerpc__)
 #define LZO_USE_CTZ32	1
-#elif defined(__arm__) && (__LINUX_ARM_ARCH__ >=3D 5)
+#elif defined(__arm__)
+#if (__LINUX_ARM_ARCH__ >=3D 5)
 #define LZO_USE_CTZ32	1
 #endif
+#if (__LINUX_ARM_ARCH__ >=3D 6) && (CONFIG_THUMB2_KERNEL)
+#define LZO_USE_CTZ64	1
+#endif
+#endif
=20
 #define M1_MAX_OFFSET	0x0400
 #define M2_MAX_OFFSET	0x0800
--=20
2.16.4

