Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 498A4C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 11:48:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 056EF2082F
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 11:48:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="Y55ea04f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 056EF2082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727021AbeK3W4u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 17:56:50 -0500
Received: from mail-eopbgr60087.outbound.protection.outlook.com ([40.107.6.87]:40138
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726729AbeK3W4u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 17:56:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=341YQ18zB/lzRseWGnh5uwAJLLP4jMD+P2MpIHs1Kyw=;
 b=Y55ea04fwLvgtgRw6KnyujIO+iCMSQ6Zj6BCGcsp8FB14Nx9l9Tpsf8NSu/oawZlGxiVz5HrbC6vJRZ7bfWErHXajjQai6zWxohpI1UaUTS3ILiXfFm+sMSS48CjTeDrKUhQzWSfkrtP63trnJ+1qEryc5p/VHArHEFGPVrHA1k=
Received: from VI1PR0802MB2528.eurprd08.prod.outlook.com (10.175.20.142) by
 VI1PR0802MB2157.eurprd08.prod.outlook.com (10.172.12.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1382.18; Fri, 30 Nov 2018 11:47:40 +0000
Received: from VI1PR0802MB2528.eurprd08.prod.outlook.com
 ([fe80::3d5c:5229:b634:b1ac]) by VI1PR0802MB2528.eurprd08.prod.outlook.com
 ([fe80::3d5c:5229:b634:b1ac%11]) with mapi id 15.20.1382.020; Fri, 30 Nov
 2018 11:47:40 +0000
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
Subject: [PATCH 3/8] lib/lzo: enable 64-bit CTZ on Arm
Thread-Topic: [PATCH 3/8] lib/lzo: enable 64-bit CTZ on Arm
Thread-Index: AQHUiKJ//SgoqqZtAkqJm0Rw6d5fBw==
Date:   Fri, 30 Nov 2018 11:47:40 +0000
Message-ID: <20181130114715.27523-4-dave.rodgman@arm.com>
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
x-microsoft-exchange-diagnostics: 1;VI1PR0802MB2157;6:SIY3TovNSXiHliYsfcyhgdMBeGMV8JFdnXjEc1NF1/B2RXDLyf4lo3Dm0wxhHTIlVy+s1dmqdjSfBTwRT0E2iKDffW5qqKCtsbxRV+7cMrvIAR7gZwr5enNNcAmyITiiKYVD3ipHrE/Q4YuodezlnLzdwS3EbG0BxKR9Y9iLKw9ggboY+aMp+OSHH95c6Qe6jalV7f648uqms6vEeIIhkfzY9BLv4VRjulhZzjNnZu3IW18Yk7OXw69Ej+5pLFEdekMwbAIwg2shLBKe585ohtDy1Eo7eWk8MW6tTjKKahzzjPQ2/0N9KTWozoY09GNfMcQFNi8SevSqbzGj2ICQfJYL0DYdBKBNTNOuVC9o/OA1SmKcSfhL0xWqJ6IVw7gxTRo8v0/HXmc/h3UhktpYW20o4DqGT116AeKu/BOQsW/PnEhwyKuQt571gUJ5TILIjDQ0g1VnLFAv1B/taLqlkA==;5:ruDM/85J7U0L/2pUP7mhZJ6U/zuPhkP2cVzGwbntntQkcY5IpVudLV+9WU69r+9f/i0bCgIOFoqM66uFmzVonXxayIecSjMvx4t9kw0RU6bCny8y836yIOXgJlnF3wGGN2PfryhYgAkXK0JtBbjrHpgq8kGM7e/anbRRYlnAHqg=;7:jeJ8rUoYjQLd5CYKrxzw85gcbpXr4txckUp3g2n/0HIRy6tYuPCTr08kUoqQQMfHCmmvBNguYL9QuWboY9x9riOIzK9YVn2JkoW1VxwB1WXZagnKMnRt8kWINp3rFjo3S6QFtltu7aaKi12cB/gFFw==
x-ms-office365-filtering-correlation-id: 03d59cf0-79af-463d-258e-08d656b9a1f0
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR0802MB2157;
x-ms-traffictypediagnostic: VI1PR0802MB2157:
nodisclaimer: True
x-microsoft-antispam-prvs: <VI1PR0802MB21573CA0BA711B74CE885A5F8FD30@VI1PR0802MB2157.eurprd08.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231453)(999002)(944501466)(4982022)(52105112)(10201501046)(93006095)(93001095)(3002001)(6055026)(148016)(149066)(150057)(6041310)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:VI1PR0802MB2157;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0802MB2157;
x-forefront-prvs: 087223B4DA
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(396003)(346002)(136003)(376002)(199004)(189003)(50226002)(53936002)(26005)(6306002)(4326008)(186003)(305945005)(7736002)(97736004)(11346002)(54906003)(316002)(68736007)(6512007)(6436002)(14444005)(6486002)(386003)(6506007)(102836004)(81166006)(81156014)(256004)(76176011)(52116002)(8676002)(476003)(2616005)(71190400001)(446003)(71200400001)(486006)(575784001)(39060400002)(99286004)(86362001)(14454004)(44832011)(106356001)(966005)(478600001)(2906002)(25786009)(105586002)(66066001)(8936002)(7416002)(1076002)(110136005)(2501003)(5660300001)(36756003)(3846002)(6116002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0802MB2157;H:VI1PR0802MB2528.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: M+zzCyz2AOc0WfQOT8OuoxQZKA8u1DwywkUKEwFAg2kmfIuhR68Fm+t/9YbXbwo4f8f6hgPj0H2pE9LhPCvxg3v9MxlPlt2kU0n7XGzPPcajreR4ZiXy0H9abhWYko+7jJFOX2GyFpflAmLUy3vsvOXzB+s9nEGwSgT4cdqbr445YLgNdyV19Ey7Mz6w57Wz4UReNUXUC8gM2abhh63FssX4g4Zvdbtq5XCbQKgnWf2AQhKMTh+kYSZJDLt1yD4NLXbTFsdrGO0Ve/M/XXwSZr8ut4057kX2vxD08xJDZkbCOf0JnKaMB5YK8Nici7++r560lTZ02nXkC2dNZeJ+pVBNboq1ZBLQ1RZuxR7bmHM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03d59cf0-79af-463d-258e-08d656b9a1f0
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Nov 2018 11:47:40.8565
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0802MB2157
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

Link: http://lkml.kernel.org/r/20181127161913.23863-4-dave.rodgman@arm.com
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
 lib/lzo/lzodefs.h | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/lib/lzo/lzodefs.h b/lib/lzo/lzodefs.h
index e1b3cf6459a9..c0193f726db0 100644
--- a/lib/lzo/lzodefs.h
+++ b/lib/lzo/lzodefs.h
@@ -33,9 +33,14 @@
 #define LZO_USE_CTZ32	1
 #elif defined(CONFIG_X86) || defined(CONFIG_PPC)
 #define LZO_USE_CTZ32	1
-#elif defined(CONFIG_ARM) && (__LINUX_ARM_ARCH__ >=3D 5)
+#elif defined(CONFIG_ARM)
+#if (__LINUX_ARM_ARCH__ >=3D 5)
 #define LZO_USE_CTZ32	1
 #endif
+#if (__LINUX_ARM_ARCH__ >=3D 6) && defined(CONFIG_THUMB2_KERNEL)
+#define LZO_USE_CTZ64	1
+#endif
+#endif
=20
 #define M1_MAX_OFFSET	0x0400
 #define M2_MAX_OFFSET	0x0800
--=20
2.17.1

