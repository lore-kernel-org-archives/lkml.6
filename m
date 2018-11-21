Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7756C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 11:59:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7140021479
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 11:59:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="MKp2pPy0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7140021479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730113AbeKUWeE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 17:34:04 -0500
Received: from mail-eopbgr60069.outbound.protection.outlook.com ([40.107.6.69]:2801
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727874AbeKUWeD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 17:34:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0p8lrIZBmri3znAoSdvbPjGmjxqjVnPr8vq/G3AbNC4=;
 b=MKp2pPy09dilwQoPy/BJvYofK7EBFfNxwEfmRLldAj3YtcUQDRWbEPhMTFK+SEeFqeXOiyJJejHG2LCLUAFHd/gO1lUYFCJLhz9R5MU79jHbPh3kwdt8EY/Lla/eI1hB+qSpfnjvQs+P0UTUszS3xd5E3jusMzGfdzfopukyXVc=
Received: from VI1PR0802MB2528.eurprd08.prod.outlook.com (10.175.20.142) by
 VI1PR0802MB2461.eurprd08.prod.outlook.com (10.175.26.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.15; Wed, 21 Nov 2018 11:59:33 +0000
Received: from VI1PR0802MB2528.eurprd08.prod.outlook.com
 ([fe80::3d5c:5229:b634:b1ac]) by VI1PR0802MB2528.eurprd08.prod.outlook.com
 ([fe80::3d5c:5229:b634:b1ac%9]) with mapi id 15.20.1339.027; Wed, 21 Nov 2018
 11:59:33 +0000
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
Subject: [PATCH 3/6] lib/lzo: 64-bit CTZ on Arm aarch64
Thread-Topic: [PATCH 3/6] lib/lzo: 64-bit CTZ on Arm aarch64
Thread-Index: AQHUgZGqWJS7jvNfMkSUY9S4JQk9GQ==
Date:   Wed, 21 Nov 2018 11:59:33 +0000
Message-ID: <20181121115922.22864-4-dave.rodgman@arm.com>
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
x-microsoft-exchange-diagnostics: 1;VI1PR0802MB2461;6:ovA91Hn4i565m/IsIoaW1nEQc/XbgM82R2CWoZJbk0bOCc6nXWo79LKsY7Tm58uoZQ7cx2JTo8C+v89H0QhXeQYPX3hCyin7n0MUAjJwViyAdbiiUyMDKBX/cZUgTix+ZuSDONxAGB9YLMAtXMEvQMTxJ7W9EbN9h+M/9hDxBTKyZ4dHI+gPWrqfL7y8hTpxNgbFtfJm/VOGVT6pWksLVw1Bk/k8pWQwefHa5wsWmpRnL/3MnSAbQfxN2FvtZVq2sdtg7LEJYJqx0BG9kcBV/FoHU8uGIV4sUAbVu8Ix7g3a70yVUPlcbLe5X+6IjsvYO7crvbNRwaVfnIzYDtQBHthNqZ/mZrFml+swHrap4q1ZN94+90NNqdOClvVuUGrpRBOsEi38AO7EC7xZOtHmeOvQj84z1sk5GUWc+MPpCx8NoXF3CaIVAyuYmIzKmv3D4tHa8S+tXoyooYlBSR7MyA==;5:nXIdRTtnry8v1z3pjlzjOMOvAZ7jdQDkCK7O3yMtRNoPBPH+XDQoIOvxuNd2B8BuXWb/2A+LGyT0jc8oyx4/W3zyTN+Y9VV0gQtUJ0p2fUIK4ZN5liugr0cv3PJRABfd4A+OeVumql+Id6e4fzcJd7m4WvkpQu24kj8GeFZrRR8=;7:kxdQv/WZWczb3VDpe0vEGC+zVSMY0KB+qseWJ3ZnCQZ2bs3SKQtzRN2OzYl5MPvwA/AkWXmhXedJ+leSG4LMuum5UgrmrwSlX8RvWyG42M+9DDsJ6Mb5Sl/d1/wjtxdWYyVe8hMmjPovWqt1VSSk9Q==
x-ms-office365-filtering-correlation-id: 0ad71a01-e857-4d75-6adb-08d64fa8cccd
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:VI1PR0802MB2461;
x-ms-traffictypediagnostic: VI1PR0802MB2461:
nodisclaimer: True
x-microsoft-antispam-prvs: <VI1PR0802MB246106AFAE2B9B702FCACAEF8FDA0@VI1PR0802MB2461.eurprd08.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231442)(944501410)(52105112)(3002001)(10201501046)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:VI1PR0802MB2461;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0802MB2461;
x-forefront-prvs: 08635C03D4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(39860400002)(376002)(346002)(396003)(366004)(199004)(189003)(6486002)(68736007)(2501003)(316002)(97736004)(186003)(8936002)(478600001)(54906003)(7736002)(39060400002)(305945005)(5660300001)(2900100001)(8676002)(2351001)(99286004)(106356001)(36756003)(102836004)(26005)(25786009)(6916009)(4326008)(6436002)(52116002)(105586002)(81166006)(6506007)(81156014)(76176011)(486006)(2616005)(66066001)(476003)(86362001)(386003)(3846002)(50226002)(14454004)(44832011)(5640700003)(53936002)(6116002)(71200400001)(1076002)(2906002)(256004)(6512007)(14444005)(446003)(71190400001)(11346002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0802MB2461;H:VI1PR0802MB2528.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: Ut35OgW+NIXvTvPUQB7JuNiqxxV9zxSu7fnS2Ams6jAMFeJ78Q2ONUq1QuEYRZesOKPeKKDG0KRXDdRtGkSunNCIheMPdN9TQvVMZCL0UUmP0uWiMRx7BGh1grkwIDEDUp3e8db6/u+zO5zFsFaeb4AspCXWtLt+HjYErbyNNbMYmeRTdBvn10MpBBYesDjI2RRRohss4ejU0ilTIOUcpRJvJio1050tLgY29BVQ+62056I8zltMRUWDcjEjTXWTOUHTt0tChKmBP2ANF9dSq9UCe1MuNtvwCo5Lg4NN+IB2Se4NmejI7IkdkAea5I7YUOQ5ZGt4KPOO/SJqFA3FY55jWzednZ79+sH3RubR3Ww=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ad71a01-e857-4d75-6adb-08d64fa8cccd
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2018 11:59:33.1430
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0802MB2461
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matt Sealey <matt.sealey@arm.com>

LZO leaves some performance on the table by not realising that AArch64 can
optimize count-trailing-zeros bit operations.

Add __aarch64__ to the checked definitions alongside __x86_64__ to enable
the use of rbit/clz instructions on full 64-bit quantities.

Signed-off-by: Matt Sealey <matt.sealey@arm.com>
Signed-off-by: Dave Rodgman <dave.rodgman@arm.com>
---
 lib/lzo/lzodefs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/lzo/lzodefs.h b/lib/lzo/lzodefs.h
index a9927bbce21f..d167f8fc6795 100644
--- a/lib/lzo/lzodefs.h
+++ b/lib/lzo/lzodefs.h
@@ -28,7 +28,7 @@
=20
 #if defined(__BIG_ENDIAN) && defined(__LITTLE_ENDIAN)
 #error "conflicting endian definitions"
-#elif defined(__x86_64__)
+#elif defined(__x86_64__) || defined(__aarch64__)
 #define LZO_USE_CTZ64	1
 #define LZO_USE_CTZ32	1
 #elif defined(__i386__) || defined(__powerpc__)
--=20
2.16.4

