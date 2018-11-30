Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 483F7C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 11:47:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06CA12082F
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 11:47:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="FkbOhhja"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06CA12082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726997AbeK3W4s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 17:56:48 -0500
Received: from mail-eopbgr70080.outbound.protection.outlook.com ([40.107.7.80]:25845
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726729AbeK3W4r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 17:56:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rPF4bhtqJ+JqysWU/N6G63wLNqMMCtuBE78n/TbjM1w=;
 b=FkbOhhjah/ht1/CqITbwxYi8DqCBrvVQMConQDfgm7Le8tUatwjpvxeX6f2NutvO7zPFH1BOD2Ya4NKPdcQyYGT00LklPcj8352EhpjVe/mNa1YIOgCzDP+N/ieYT9eqY4uDPulLjmvsLkTEXrKbkc0kZdDUFkmjWlAYFAN04vk=
Received: from VI1PR0802MB2528.eurprd08.prod.outlook.com (10.175.20.142) by
 VI1PR0802MB2623.eurprd08.prod.outlook.com (10.175.20.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.19; Fri, 30 Nov 2018 11:47:42 +0000
Received: from VI1PR0802MB2528.eurprd08.prod.outlook.com
 ([fe80::3d5c:5229:b634:b1ac]) by VI1PR0802MB2528.eurprd08.prod.outlook.com
 ([fe80::3d5c:5229:b634:b1ac%11]) with mapi id 15.20.1382.020; Fri, 30 Nov
 2018 11:47:42 +0000
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
        nd <nd@arm.com>
Subject: [PATCH 4/8] lib/lzo: 64-bit CTZ on arm64
Thread-Topic: [PATCH 4/8] lib/lzo: 64-bit CTZ on arm64
Thread-Index: AQHUiKKAw7LQXoAT+EebhxoBnJQmew==
Date:   Fri, 30 Nov 2018 11:47:42 +0000
Message-ID: <20181130114715.27523-5-dave.rodgman@arm.com>
References: <20181130114715.27523-1-dave.rodgman@arm.com>
In-Reply-To: <20181130114715.27523-1-dave.rodgman@arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.17.1
x-originating-ip: [217.140.106.53]
x-clientproxiedby: CWXP265CA0058.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:400:2c::22) To VI1PR0802MB2528.eurprd08.prod.outlook.com
 (2603:10a6:800:b0::14)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dave.rodgman@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR0802MB2623;6:y8gpc9wn8jjxg+W1uKu7h3lhjWj1ud0ftW8Qs+hplBZC5bwwSd+L7l+PaPMVeFWSi+5zws4A/SqqMNFFNhm42pTrmN0/rlUPb7zumOcULSMe7/o5XO9Ni31aZHR7Snrr2o/N/SXEEtxOhOegh+csTXdhUf1o4yrdFMJc6RF61ZcqCEZXpZJA/vK1gPPlU+eYPQeptW1kfdCcX2MOJV/JxKaOvN11LoRPPmtUas/UbOaEgb1caj2HECzDMfG4lv1aZbb5gH4cy2Rsllr6rV6+pyVAnXz2g7NoVSO1U+fOxbguSVBxelKUW644AW6bfaphNlvXVERV7LEkIiLOfX0l86ISSYpAcJBkX6BFthD9Xak1y+1HFAJQx/pPJnevIDFvD2GQF5lbiqMx4eS8OoyCTmskuQbtY3AOv449OGGXpovkwYsg46hIhbEYdtSZW8hn72D9X4ih5euB3GuU4jr8pg==;5:xkqgEVZYzVQaOO+y1ElM3w8e5iIwoYmtmhbvLKqDPw/n8WEe5HiKQ3uaXoFVyIDLgiwC90mmlgKzqKRYJX5pF9n3rJmh71mKWxpn0z5UjM5wuaRac6dSFjf4NVED9g0flltrCHEdSU0EeAYgqy/tab63cIFKCmAu5mhJpIBlg3A=;7:tdqz0dAsiskIB14IEVDl4H39+znbkZ/Vg7F+q79HbaniKYmgjAPm0TRJffLko60X0YT/HxcUK02TH9infw6kM0h4Vzr6RNVpgh7kER7RILinuG0ec+/Wt/yEdjq38LP5JqtzVCU/LbNy1ZMI93tsvw==
x-ms-office365-filtering-correlation-id: 01bc7c5e-5cd1-4b4a-83ef-08d656b9a2eb
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR0802MB2623;
x-ms-traffictypediagnostic: VI1PR0802MB2623:
nodisclaimer: True
x-microsoft-antispam-prvs: <VI1PR0802MB2623CA77D53D7377EC574E218FD30@VI1PR0802MB2623.eurprd08.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231453)(999002)(944501466)(4982022)(52105112)(6055026)(148016)(149066)(150057)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:VI1PR0802MB2623;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0802MB2623;
x-forefront-prvs: 087223B4DA
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(136003)(376002)(366004)(346002)(199004)(189003)(52116002)(256004)(76176011)(14444005)(2501003)(106356001)(478600001)(99286004)(39060400002)(105586002)(68736007)(476003)(2616005)(446003)(11346002)(5660300001)(966005)(36756003)(71200400001)(8936002)(25786009)(102836004)(186003)(26005)(486006)(50226002)(44832011)(8676002)(81166006)(81156014)(6506007)(86362001)(386003)(14454004)(316002)(7416002)(53936002)(305945005)(66066001)(6436002)(7736002)(110136005)(6486002)(71190400001)(54906003)(2906002)(1076002)(3846002)(6116002)(6306002)(6512007)(4326008)(97736004);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0802MB2623;H:VI1PR0802MB2528.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: H6+oawDPBJ+1ghEhtBhr3W/N0Yy7ll2NZV4UnXBx6JBpwRtO3i1fL8O4luqMXS0aC0adPpHUo2d9q20WgpVcR0sT1rZB0UCaVYAd2Ndf/rjn7H3DGBhev1NMnJ4JMVt+Ee+TQqeJ+kV2eLPts/FC1y2jXDTqvNMWQwGxtOjvmuQtNsfprxpS8kArM5ztjRl+Ol26cyxTrZWedazI8EhmNEg+5SbF7OUTv11SBH+7Z0RNrWN3xRc0DsRX3qVDBn2QnsyQujr4WQv4nEPHNhRZQEeeAi3KeSSukjhN0i7DdmT/pOljNP8UHJNbWWAZmUv3mv59K2efyViWzHtW6wBx09mVsMV5n6AuWLPBXBxvmJQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01bc7c5e-5cd1-4b4a-83ef-08d656b9a2eb
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Nov 2018 11:47:42.4198
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0802MB2623
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matt Sealey <matt.sealey@arm.com>

LZO leaves some performance on the table by not realising that arm64 can
optimize count-trailing-zeros bit operations.

Add CONFIG_ARM64 to the checked definitions alongside CONFIG_X86_64 to
enable the use of rbit/clz instructions on full 64-bit quantities.

Link: http://lkml.kernel.org/r/20181127161913.23863-5-dave.rodgman@arm.com
Signed-off-by: Matt Sealey <matt.sealey@arm.com>
Signed-off-by: Dave Rodgman <dave.rodgman@arm.com>
Cc: David S. Miller <davem@davemloft.net>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Markus F.X.J. Oberhumer <markus@oberhumer.com>
Cc: Minchan Kim <minchan@kernel.org>
Cc: Nitin Gupta <nitingupta910@gmail.com>
Cc: Richard Purdie <rpurdie@openedhand.com>
Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc: Sonny Rao <sonnyrao@google.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
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
2.17.1

