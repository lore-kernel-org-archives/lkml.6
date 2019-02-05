Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19159C4151A
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 14:20:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8409217F9
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 14:20:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="NE1YuUJM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729075AbfBEOUL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 09:20:11 -0500
Received: from mail-eopbgr20075.outbound.protection.outlook.com ([40.107.2.75]:22565
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728856AbfBEOUJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 09:20:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gIsb79aiv9IJt7DmEt9fTFmQAfmlJ/kKBQuI9E2Ewmk=;
 b=NE1YuUJMHGFghO9hki8RA5WitT10eoiYRWTs8Zyf1S/tt81QdrYn0v+BKW/EGq1+t43ccpIq6CZZyH6bBIzN8HhIkdxWUw0HpJnEcIvazQjusKMke0vrWN8NZuuOHDfRrIN3MkOVFVHc+6w4c9TLPOnPbT/HVWvMPfmEFhUmPUA=
Received: from VI1PR0802MB2528.eurprd08.prod.outlook.com (10.175.20.142) by
 VI1PR0802MB2158.eurprd08.prod.outlook.com (10.172.12.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.17; Tue, 5 Feb 2019 14:20:07 +0000
Received: from VI1PR0802MB2528.eurprd08.prod.outlook.com
 ([fe80::7446:fa53:3f15:c96c]) by VI1PR0802MB2528.eurprd08.prod.outlook.com
 ([fe80::7446:fa53:3f15:c96c%4]) with mapi id 15.20.1580.019; Tue, 5 Feb 2019
 14:20:07 +0000
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
Subject: [PATCH v5 2/3] lib/lzo: 64-bit CTZ on arm64
Thread-Topic: [PATCH v5 2/3] lib/lzo: 64-bit CTZ on arm64
Thread-Index: AQHUvV3k9gwJmF7oCEOTje49k0Z4Fg==
Date:   Tue, 5 Feb 2019 14:20:07 +0000
Message-ID: <20190205141950.9058-3-dave.rodgman@arm.com>
References: <20190205141950.9058-1-dave.rodgman@arm.com>
In-Reply-To: <20190205141950.9058-1-dave.rodgman@arm.com>
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
x-arm-no-footer: FoSSMail
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR0802MB2158;6:LzjxyxKW81HyEsWY3f0U+fXC7ozHt38V8ugwIQhTQJvIBYOklXHIZ5NaSCxCQBukabXY1c+kCEsrzI9Vz2te0yhdwhO9l7dyMpH90MkuIKzAjOtG73sSxndOgBh4Y6Cagd84eaZVEqIsT0GqhRUdNxefimUuRhhXjvl+KTlc6TOT6czjMTXEtolWsSFdqzlB5I18HISHmoidE3KrC/lw6CBssts1rPUh0P7ex4K1B1CxA/r2J2GzTSIbWYsCW8PT6OjCywwMNd8gQby63aAE74UsV+PuUMyYbFyqKRdwi3P24ALhfKeHpjBrrXdigilAzGTt9MGyeQgWKFzpGQN7m338/WhqlR61rBq0tYN+IKV2GEDVXBJHLuuZ6V+hER0BKji+S0mqu8NWltkeGxnUEuk9exSkB6XK9B1oqDfYr5SI0sloMlZtmJEEceruU0yM3ljK/J8KTkOVjMGR3qwKlg==;5:SjvjUetVQE7c3yTrIJD8oLVZxyQjWi+SENHPO8j2x3nf4XsuGtEbmk0mMhUSKGoECpe1fE5vPPT4niv58/evyZw9O20v48xRRpSDh33rkZcp+hR7xCnfubeimXNQKqRXXdpApWo50A5QfcpHJKoh3EGJsYUTkZnAo/v5b0wkLPIusSwh/cR48K8BbjZl3+TkupaoIZu3Dnmasa3IonA3/A==;7:iHLkSFxW17ytLZCHA1GZz4x2rXs4Vz4zChl0lwDqATz9mwqypYWm71IpZyzTQH0war1JGsUyQvCkf6uzEfGEEQjH+FlySE8HUiWcz0/J7RX4dT2kcQlVcmf7QV9GZq+S0/jBu+Mu9F2GjdLABAwskg==
x-ms-office365-filtering-correlation-id: ce7fe8ac-92fc-4888-2413-08d68b750736
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR0802MB2158;
x-ms-traffictypediagnostic: VI1PR0802MB2158:
nodisclaimer: True
x-microsoft-antispam-prvs: <VI1PR0802MB2158902C7FCD1332D8D2A60E8F6E0@VI1PR0802MB2158.eurprd08.prod.outlook.com>
x-forefront-prvs: 0939529DE2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(396003)(136003)(346002)(376002)(39860400002)(189003)(199004)(476003)(486006)(8676002)(76176011)(2616005)(1076003)(25786009)(11346002)(446003)(68736007)(44832011)(71200400001)(53936002)(71190400001)(52116002)(316002)(2906002)(478600001)(26005)(6512007)(110136005)(102836004)(106356001)(4326008)(105586002)(86362001)(50226002)(36756003)(2201001)(6306002)(186003)(386003)(81156014)(81166006)(66066001)(7416002)(6506007)(14444005)(256004)(6116002)(3846002)(7736002)(966005)(14454004)(8936002)(2501003)(6486002)(99286004)(6436002)(305945005)(97736004)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0802MB2158;H:VI1PR0802MB2528.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ULgzlbie8pbO43D2sFQl7TSOkr7OcBcGAaDUDF7d+HOBYsPEJOgZZTXTuQA8eVmFZTAZGwyHTkqtVT1a/WFw0HmHKVBhC1ZtVV4MnKg9JXo0YM6utn4K8cZcCBV3+ANcPv0b6TtsAF83kTiFHYx+jINAf8MvsuvJRYSpTXr52+WtJe6M9aRbHnH8+AfuL288E42E0ryMIJq7cjB1IOo2M5TXZkx7TOtjilThO1PKt4e8pAgrMf7tPhosVxu/4x4a4lzX+f3l1kNdyC2J8byON5tNTVMSXq9/qv/ekUYO4j1DqVV3k/hb49LW81qoWq1+khzqg6VywxFtZDt6bF+fuKDz3CnvrTL09XIdS1x5UrmhOfMWjzmevJJT/HzOihPh34p41CTJiUHfL09ssVo7p3RjoIyJivNhmklWxZJ06BM=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce7fe8ac-92fc-4888-2413-08d68b750736
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Feb 2019 14:20:06.3042
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0802MB2158
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
index 497f9c9f03a8..00d1080155e4 100644
--- a/lib/lzo/lzodefs.h
+++ b/lib/lzo/lzodefs.h
@@ -25,7 +25,7 @@
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

