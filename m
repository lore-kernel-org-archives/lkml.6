Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B0E4C65BAE
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 14:26:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 458302082F
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 14:26:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="CmM4pOBI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 458302082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727202AbeLABgA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 20:36:00 -0500
Received: from mail-eopbgr140078.outbound.protection.outlook.com ([40.107.14.78]:30574
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726988AbeLABf7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 20:35:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=341YQ18zB/lzRseWGnh5uwAJLLP4jMD+P2MpIHs1Kyw=;
 b=CmM4pOBIJ9QTJxgOOJa+mnEwPxdjCv0InezIGYw6xiNS8unkTOgB2WlMcxsMn1tATTr6OQBn70FZoYcYD3Hhmk3/UuH9/aACZ02zWLRCP39y328ri3693L4pa73/EROS8k4nGczdBp7pHUr2b8JIl58TAu5++AfCLnmgRNEA0nY=
Received: from VI1PR0802MB2528.eurprd08.prod.outlook.com (10.175.20.142) by
 VI1PR0802MB2415.eurprd08.prod.outlook.com (10.175.25.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.19; Fri, 30 Nov 2018 14:26:25 +0000
Received: from VI1PR0802MB2528.eurprd08.prod.outlook.com
 ([fe80::3d5c:5229:b634:b1ac]) by VI1PR0802MB2528.eurprd08.prod.outlook.com
 ([fe80::3d5c:5229:b634:b1ac%11]) with mapi id 15.20.1382.020; Fri, 30 Nov
 2018 14:26:25 +0000
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
Subject: [PATCH 3/8] lib/lzo: enable 64-bit CTZ on Arm
Thread-Topic: [PATCH 3/8] lib/lzo: enable 64-bit CTZ on Arm
Thread-Index: AQHUiLisYEM+UVdPFESrcqxF4MkZXg==
Date:   Fri, 30 Nov 2018 14:26:25 +0000
Message-ID: <20181130142600.13782-4-dave.rodgman@arm.com>
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
x-microsoft-exchange-diagnostics: 1;VI1PR0802MB2415;6:cGniXH3NxxDkJztqcUBAK2jOBqAuyEv2QuDDGNlrkNy0KgT/CXEeo8hTDIc0BLha/wQ/s0JaBVonDNULPxWceg887OkJ0R+bGvwpNMEVS7eNWSvEb8I+fRyIwoAHZt2O8h3xNwhWWiutLPylxvGnNLgJ2Dim9iejcQa7HvLMl9J6YdPhzBuJY1sKs19zqCYkYgJ1xrGpAY7I1zaLhX+9wTHketxuEP+mQ7weyTpHsalxF2GKJwvBjbR8UZ94viCla0pQnrlruZrsMtCXPJfC8SP+JsiLhUJBHSIAsCSKr1/vXY8ypfLRTJQ942zWP/ljxLFc3lvYCZ8/9cb62NDHr5ZBHuecK5P5hLppqGaMmFgxXzG+HMELhRYx5a6rkmJNUTkDghDxGJWJtDkyYscCTeFO+d4/B11RrNSO5AnbN5kLvTbGY7PrtHmjczyEKZ3FTM1jPhtSgAreu74MiVN87w==;5:ZgNeIXSSYPziMttaEo4sZ1NpAEJVONjOfaiKFRh0BOShxQ8qjXBta7iK1M/vbDwDt7mzdElPODG362JysPTT8/dmRq8sqR9LDFXsCGCvBD6qGsI7OhdSEp+sVYzWDWK+OFGR+lHt3lpNy0C8A5bhEbKSmCkXRBcZfp9llYgyGUE=;7:KKCkRNRa797PbGPP1m0DyMobyyT3klm0nuctt1UJuT6h+FpdPetmsqLAN1Xn0254RadKAYzAWhbP5Y+Moap0lMTt6RptEGp7YQASxYUmEn0uQ3rCthp3quDYS5I3K3aohUDsB88q97WCPzEBI2U5iQ==
x-ms-office365-filtering-correlation-id: 592959e5-94e0-4c02-a348-08d656cfcf0e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:VI1PR0802MB2415;
x-ms-traffictypediagnostic: VI1PR0802MB2415:
nodisclaimer: True
x-microsoft-antispam-prvs: <VI1PR0802MB2415D8719316250DB0F496938FD30@VI1PR0802MB2415.eurprd08.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231453)(999002)(944501466)(4982022)(52105112)(3002001)(93006095)(93001095)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:VI1PR0802MB2415;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0802MB2415;
x-forefront-prvs: 087223B4DA
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(376002)(346002)(366004)(136003)(199004)(189003)(386003)(6306002)(5660300001)(476003)(50226002)(11346002)(486006)(14444005)(8936002)(446003)(6486002)(7416002)(39060400002)(25786009)(6506007)(2616005)(44832011)(6436002)(4326008)(66066001)(102836004)(6512007)(110136005)(71190400001)(71200400001)(76176011)(81166006)(305945005)(81156014)(52116002)(99286004)(186003)(26005)(316002)(8676002)(54906003)(575784001)(14454004)(97736004)(68736007)(1076002)(256004)(7736002)(2906002)(478600001)(106356001)(105586002)(36756003)(6116002)(2501003)(86362001)(53936002)(966005)(3846002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0802MB2415;H:VI1PR0802MB2528.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: khFEskhgqTRSQu9iRbfMqovGHavThZrvV7fsKb7owcrcPg2uThNk0YggeRZk9mL+YdvNLnhBSKB3Z2SRaZnWgH1bWEMSu6Us7qFio2mAWjw84S4bSiQRlVrLnjCFFPdSywO3bHW7MXLvKi/djrNu9L8MFZ3vNgLyTboyKhjx1y5HLFKVmeGY7k6qerRwY8H3sGQhghJKpvp2KwcwN8Motei+/jYlZx4ZtHwVAVJgheS1/SPMWcBQVrtYWX786pFH9pl/o0O0fZelOXzjqtTf6STI0DfrwcgPXeiMj79YAD3llyCMjC+Zd14L2X259QDSQKe61L8YluqyOuO5GUQzHuwyqIgPqV2KJUsoTMS9LnU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 592959e5-94e0-4c02-a348-08d656cfcf0e
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Nov 2018 14:26:25.4087
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0802MB2415
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

