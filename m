Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33F4BC64EB4
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 11:47:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2BC32082F
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 11:47:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="HTKO96N9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2BC32082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727077AbeK3W4x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 17:56:53 -0500
Received: from mail-eopbgr60087.outbound.protection.outlook.com ([40.107.6.87]:40138
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727023AbeK3W4w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 17:56:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xinkmu8nfADRJ6EbJf24/wgImMJ4QJd4gDTUp31CIdE=;
 b=HTKO96N9eEYgp2tkoBGeJRuyuV3wyEgn6ssETEQXTB0WYzFV7z4S3Fo9/X9xaRq+Wu3OfpmMOZcR+1FCh2eJPonnkV5mGo16t72KOm98StvKyA2+0wL5XOUokJH0b5aM/PgIe49X1mTiRxarqEclnWCAe458bkqKayHtPxVCKdY=
Received: from VI1PR0802MB2528.eurprd08.prod.outlook.com (10.175.20.142) by
 VI1PR0802MB2157.eurprd08.prod.outlook.com (10.172.12.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1382.18; Fri, 30 Nov 2018 11:47:44 +0000
Received: from VI1PR0802MB2528.eurprd08.prod.outlook.com
 ([fe80::3d5c:5229:b634:b1ac]) by VI1PR0802MB2528.eurprd08.prod.outlook.com
 ([fe80::3d5c:5229:b634:b1ac%11]) with mapi id 15.20.1382.020; Fri, 30 Nov
 2018 11:47:44 +0000
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
Subject: [PATCH 5/8] lib/lzo: fast 8-byte copy on arm64
Thread-Topic: [PATCH 5/8] lib/lzo: fast 8-byte copy on arm64
Thread-Index: AQHUiKKBjblqTIUVFUSe6G4re7dwVg==
Date:   Fri, 30 Nov 2018 11:47:44 +0000
Message-ID: <20181130114715.27523-6-dave.rodgman@arm.com>
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
x-microsoft-exchange-diagnostics: 1;VI1PR0802MB2157;6:o0HzgARYA0BzHegQ7+GI2Ndj03RUj+avaefrAL7YUgsyn419bdvgygek5YYDeYtMwn5Fc30UqfQeJtkgYb9pMS8caZy+JvI1umbC7J2+6CeDZJ3r07V3NwAy8tlDv7N2w8I5jGS79PzIgW+k6Xskulj41bgEYnGOu2H0J1PIwcxErAMV9kJWkxCq5sue9/zMcFEhGKgzXhOy3CNNtr60ZdV6BNClJdAaXN8z7zFmOoRRd3HTm7ZhdNpeD3t/G9iM1QTKk7NqSls3Lyn+bssEzotlGlCO8hUwvMjIG6U4kX5pdVxhgAN3fBTIz+xZXBnZG2HZw8zM037hgY6mvaJiKwD1xtqMmIztxBqi7sTOm8ld9GPnGb5oX3VEUzhQvTstO/xjTEnvFDACn87CarP8oHRft8jmAjJfaLuxCehh2zcJa/QpBLoPFdb0X7k6w9hNa5r+SLQQZyuf4XE9xEQFUA==;5:6kcZ4ojrI5cjZ+vGOlyTDWkQCDa9LInW0dopYwWHbSCH0wM+GL2mCYt71avbtG6LYDiBxmwhii4JXzqleY3nqBnZkncEWec3I0BUc0aqbZU0GdkVOqh+B8Ep4ElsArXhHr2ERltZdzBjcW69TxMy65qfJStqETiDj2g3K4F05d8=;7:/1GWx4R1E9EnJFSCRMwLjh+/H/FiQ7ES1xyGLub6/0h9hU5NP2LDpuT7dAptue3jO6nf5gLSGiMsVp75Jxv0ImLaHWv+TWGdsAyY73ZASYImJCjguxS5OHj5b8vgPKY59OKPUrW2mWVGZnYLcbbp1Q==
x-ms-office365-filtering-correlation-id: 6b2e3049-04f3-4a69-afe3-08d656b9a3ec
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR0802MB2157;
x-ms-traffictypediagnostic: VI1PR0802MB2157:
nodisclaimer: True
x-microsoft-antispam-prvs: <VI1PR0802MB215771B4AE381878A0C7C8D38FD30@VI1PR0802MB2157.eurprd08.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231453)(999002)(944501466)(4982022)(52105112)(10201501046)(93006095)(93001095)(3002001)(6055026)(148016)(149066)(150057)(6041310)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:VI1PR0802MB2157;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0802MB2157;
x-forefront-prvs: 087223B4DA
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(396003)(346002)(136003)(376002)(199004)(189003)(50226002)(53936002)(26005)(6306002)(4326008)(186003)(305945005)(7736002)(97736004)(11346002)(54906003)(316002)(68736007)(6512007)(6436002)(14444005)(6486002)(386003)(6506007)(102836004)(81166006)(81156014)(256004)(76176011)(52116002)(8676002)(476003)(2616005)(71190400001)(446003)(71200400001)(486006)(575784001)(39060400002)(99286004)(86362001)(14454004)(44832011)(106356001)(966005)(478600001)(2906002)(25786009)(105586002)(66066001)(8936002)(7416002)(1076002)(110136005)(2501003)(5660300001)(36756003)(3846002)(6116002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0802MB2157;H:VI1PR0802MB2528.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: vwIuSSG84rSD+RYUtPj4Ef3MW/9HFxGyGpOqlvHVhQY19qRJNn6gkAQq/XzIl6rym716ghOcHz821IV+dksDFgTorgr+4Zuz/wOO+7wFpMlsvCNn8tmjsp7g8TDYPYRB7UiqId3RAQFbu56KzOkkGkmj75Otbq0moo6YztS7RhwNtcDH26uQK9nHMwbMpB5X9SKTEyiQiA707TkI23DLgqNtvD5nYsHcMHUOo5Skv4CC7GBW6UbXIjCp8qr+yj24zQAvnXDNtGOZKaS29vfDb9n4RaeHAurBk6h1/PVNG7rj4ezKNlnU0xFyqnS4FuOO6kq8OAG+HAB06C/VUGv0DFuHkjKm700ITUaa4o0aKk8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b2e3049-04f3-4a69-afe3-08d656b9a3ec
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Nov 2018 11:47:44.1162
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0802MB2157
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matt Sealey <matt.sealey@arm.com>

Enable faster 8-byte copies on arm64.

Link: http://lkml.kernel.org/r/20181127161913.23863-6-dave.rodgman@arm.com
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
index c8965dc181df..06fa83a38e0a 100644
--- a/lib/lzo/lzodefs.h
+++ b/lib/lzo/lzodefs.h
@@ -15,7 +15,7 @@
=20
 #define COPY4(dst, src)	\
 		put_unaligned(get_unaligned((const u32 *)(src)), (u32 *)(dst))
-#if defined(CONFIG_X86_64)
+#if defined(CONFIG_X86_64) || defined(CONFIG_ARM64)
 #define COPY8(dst, src)	\
 		put_unaligned(get_unaligned((const u64 *)(src)), (u64 *)(dst))
 #else
--=20
2.17.1

