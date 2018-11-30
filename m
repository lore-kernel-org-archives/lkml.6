Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D311C64EB4
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 14:26:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC7382082F
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 14:26:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="Rk6BgeVJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC7382082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727325AbeLABgK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 20:36:10 -0500
Received: from mail-eopbgr140078.outbound.protection.outlook.com ([40.107.14.78]:30574
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727208AbeLABgJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 20:36:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rGnRj8n7GjH45SBAmWTGfxkdhSaif/uRbTjfgn4LmFs=;
 b=Rk6BgeVJeYo0fjAbKiQFR3km6RvCt509XXf8QweqSPfVLtT2ZMyaGFh7mq166C9eYZZ/z1Pck7ttnfIOAxfn74gE0cjw0bfzBx2qAnUuY9GX40nDUJ2YCxUnOElmfV2L8kCPxJazBetHoqvhq+0IDufEmYNMHFG+f26b05FVgb8=
Received: from VI1PR0802MB2528.eurprd08.prod.outlook.com (10.175.20.142) by
 VI1PR0802MB2415.eurprd08.prod.outlook.com (10.175.25.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.19; Fri, 30 Nov 2018 14:26:32 +0000
Received: from VI1PR0802MB2528.eurprd08.prod.outlook.com
 ([fe80::3d5c:5229:b634:b1ac]) by VI1PR0802MB2528.eurprd08.prod.outlook.com
 ([fe80::3d5c:5229:b634:b1ac%11]) with mapi id 15.20.1382.020; Fri, 30 Nov
 2018 14:26:32 +0000
From:   Dave Rodgman <dave.rodgman@arm.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
CC:     "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "davem@davemloft.net" <davem@davemloft.net>,
        Matt Sealey <Matt.Sealey@arm.com>,
        "nitingupta910@gmail.com" <nitingupta910@gmail.com>,
        "markus@oberhumer.com" <markus@oberhumer.com>,
        "minchan@kernel.org" <minchan@kernel.org>,
        "sergey.senozhatsky.work@gmail.com" 
        <sergey.senozhatsky.work@gmail.com>,
        "sonnyrao@google.com" <sonnyrao@google.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        nd <nd@arm.com>, "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>
Subject: [PATCH 8/8] zram: default to lzo-rle instead of lzo
Thread-Topic: [PATCH 8/8] zram: default to lzo-rle instead of lzo
Thread-Index: AQHUiLiwou9uOoSQrUaDcnJzHf5fmQ==
Date:   Fri, 30 Nov 2018 14:26:31 +0000
Message-ID: <20181130142600.13782-9-dave.rodgman@arm.com>
References: <20181130142600.13782-1-dave.rodgman@arm.com>
In-Reply-To: <20181130142600.13782-1-dave.rodgman@arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.17.1
x-originating-ip: [217.140.106.53]
x-clientproxiedby: CWLP265CA0336.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:401:57::36) To VI1PR0802MB2528.eurprd08.prod.outlook.com
 (2603:10a6:800:b0::14)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dave.rodgman@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR0802MB2415;6:vxjllNmfuGXcFc2eHPeDoYTf8F3OP1pYk8Z6G7WBdnp15OAdqrLN5lTd5Pdt9wLRaHKdPLCwVvjkIQ551DfZVAeM3pYY9izDfd7UXRiaWG9l41Jx/+quXGlJgJLVKvBQIJjxbN9VgVcejhjBGKVEpxlyyyOwKAxIXWcKJzgH7npzocftr/sjP45Q06uDRaF1m5Ln2wPl2fzkdLbfsDIcahMX4kFxb7Y+U/YKeUOsxGHzKAB13yUM4zdlsX5153JoUx+3NKYPpo+hUGlYseCAgIflC3vJ1VH33wtxP+tIGiP6DZ6PJnOhZuHC5TivnZVGcHpSn67dgytDXkO+t7gLw5TIp8uYFP3QOIiVL0a8zWilds9On4PuLmK5k1tIrA/e4J9nFAoUOBmVBz5lL2qAH6prBH5vUv/QhHsfEx6hiVeBkSz72ioKu4twhrzwZZLQUNnSYhVGZ+RIUxQx8N621g==;5:yMmUBXjAQw1Uq4Y9rCr2k1M1Qg7iO9rMwfpv42uRNA4PN1M/dK4iNF5K3nDN1LuPI4ysowzFIQFscr+rKaK0CFedQbIz+Vb3UyAgAf50I0NfHJfadk4V6aQUZirqG2zB0Z9YJrzgxuSWv1mxki0OUC/nz/J+B3TSygs9MHlOz7Y=;7:3bR4kwPL29BREvv/d4AcDdF0L8fs9Q38ckNkzVVFP/VtULyS+0DLt6N9rHLL9NwSYc9v72JeWP6GpFSNuO5B3PSEaHeWdipqulFrRXjNT1jFmlj9Yc2IiaEzXMT2spcERXWLIpEGx+w1LRDixYRjSg==
x-ms-office365-filtering-correlation-id: d41b9591-c16b-4985-fd1d-08d656cfd2f7
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:VI1PR0802MB2415;
x-ms-traffictypediagnostic: VI1PR0802MB2415:
nodisclaimer: True
x-microsoft-antispam-prvs: <VI1PR0802MB2415FD440C9B0D417B673E238FD30@VI1PR0802MB2415.eurprd08.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231453)(999002)(944501466)(52105112)(3002001)(93006095)(93001095)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:VI1PR0802MB2415;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0802MB2415;
x-forefront-prvs: 087223B4DA
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(396003)(39860400002)(376002)(346002)(366004)(136003)(199004)(189003)(386003)(5660300001)(476003)(50226002)(11346002)(486006)(14444005)(8936002)(446003)(6486002)(7416002)(39060400002)(25786009)(6506007)(2616005)(44832011)(6436002)(4326008)(66066001)(102836004)(6512007)(110136005)(71190400001)(71200400001)(76176011)(81166006)(305945005)(81156014)(52116002)(99286004)(186003)(26005)(316002)(8676002)(54906003)(66574009)(14454004)(97736004)(68736007)(1076002)(256004)(7736002)(2906002)(478600001)(106356001)(105586002)(36756003)(6116002)(2501003)(86362001)(53936002)(3846002)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0802MB2415;H:VI1PR0802MB2528.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: FgmpwxSpcjDf7w8zidGbo9RdeIIXjsn2nW8fpbwFsHjtuDhvL0X+/g+ew92N3/tO8i2jea8/W+s8mUIJ+Gfiu5F+QEoE7ZwOe1fh+EHl9rTuzl5OnUXmRPvicjgsjudbFiBMH2ZUrk1ygEgZl4037M8tCm+18ch7kdZTa1sIgrLvGuEkruix1YoJsf4/750ybXJJHZYBbPD5nSTwg46DdRs2VdKouyjD8YD0Dq2SqiZuR4RPwL6EGOInqncC65gm2xUBiWY/sI+Tn/xx4hsb9LmikeAUrLQzFCdTvwjPDUMWgquFdE9Dku59NNoRrW5HJ9drBtBUqUN1uojz1DaVcTkzMtA2xnzs2cnoxJMUkjo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d41b9591-c16b-4985-fd1d-08d656cfd2f7
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Nov 2018 14:26:31.9692
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0802MB2415
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

lzo-rle gives higher performance and similar compression ratios to lzo.

Testing with 80 browser tabs showed a 27% reduction in total time spent
(de)compressing data during swapping.

Signed-off-by: Dave Rodgman <dave.rodgman@arm.com>
---
 drivers/block/zram/zram_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 58b025c5c83e..b8dc0976e385 100644
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

