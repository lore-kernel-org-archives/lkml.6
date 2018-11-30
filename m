Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1E99C64EB4
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 14:26:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 647B22082F
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 14:26:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="oqTC/Kl/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 647B22082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727169AbeLABf6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 20:35:58 -0500
Received: from mail-eopbgr140078.outbound.protection.outlook.com ([40.107.14.78]:30574
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727117AbeLABf5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 20:35:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T70Dk1wJvkEMPK7aFNB7DKCtZfihpotTgaFbDxRTtZk=;
 b=oqTC/Kl/0UYmiYmRmcqVGpKHDcM5TPNx9iRj+Tx7T8Igtkwk7oOep7BVaN8Drvn0NphoPDgNpAE3fHHucKfjqrPq7+NaPP1FZI4ixjWo3Y3N9D5K7xhZto/ZoHzOowVgMsAp9N2clFOu5fjz7li0IDARI27fti1k4lANwpsdAvI=
Received: from VI1PR0802MB2528.eurprd08.prod.outlook.com (10.175.20.142) by
 VI1PR0802MB2415.eurprd08.prod.outlook.com (10.175.25.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.19; Fri, 30 Nov 2018 14:26:24 +0000
Received: from VI1PR0802MB2528.eurprd08.prod.outlook.com
 ([fe80::3d5c:5229:b634:b1ac]) by VI1PR0802MB2528.eurprd08.prod.outlook.com
 ([fe80::3d5c:5229:b634:b1ac%11]) with mapi id 15.20.1382.020; Fri, 30 Nov
 2018 14:26:24 +0000
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
Subject: [PATCH 2/8] lib/lzo: clean-up by introducing COPY16
Thread-Topic: [PATCH 2/8] lib/lzo: clean-up by introducing COPY16
Thread-Index: AQHUiLirBI6/h7mwQEyP8KI0iA2D6g==
Date:   Fri, 30 Nov 2018 14:26:23 +0000
Message-ID: <20181130142600.13782-3-dave.rodgman@arm.com>
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
x-microsoft-exchange-diagnostics: 1;VI1PR0802MB2415;6:viZ3lZaom/zuHMt3odCHjCssw3lA/+xSx0fKCgm5tdmiKkGBvUkTyzP249u59SQdSdbzJyk43S6RGrMPbFtSMRxiAOmBerWsyrPq3aOvWuf3wUL55EjvW5SQ5eM9ZTyyBYo6StAZ+rxIy+i/zNSMgXLNiRPFR59MfNyrX2hDU5hnjfC4GbCaK7697Eyl5JpICeYLItrt1GK5twKghmJm+WLmtS+AARpJqBjtYvtEnJadKbwwc4BuseC58F05Pf0RN3zEWEfp60dBiQ+ALBdBuaSkR+Gbv/pepW6WsqoXcn9/Z/U7JS1BsPAGuZs04SMb6AQCD84oMJOW22YqllFnsMIkEzh0OWyZSqy0E29VNI5coumFoOJ2G14ZrTHrsXUulREbFkevSX7AnnD0ggzp6hjt2w0SmUV7UYUnkOQeLyLZhZ6V8zGa1nCr/J6mPmkz1FDj6ZcyBbMz7dQ/H2RI6w==;5:+GQe5F5IcIblyzBRb92UQbN8ICAVxfBcBRcSEnOa6wiyC1WWrMTwLJxoQhOAzSuWkzKXvlLygJO3Fr8V7CfmHR3sMUG9BNOM76Zqc15KiZX4hk+Bg6HB8iUIYDrrtDXR0PDVjahxZ2FMAjPe++ypkLQ5+37n7bALsP3aSdVE9Ho=;7:u77ihIXtATfGPkZa5MkLCYv5wHISVPzsGF6wuTZz7Dk42wqvvs25Dr8XpPBvWWZbQL6FqSaegTSSh/U0Aj19aWHEyUsjxLAnosnYjepSmYPdu6iyExEB6egEaOjxXh8O/QwntAFi5/GZTHbOKed1pw==
x-ms-office365-filtering-correlation-id: cd318591-fb88-45fb-f5fc-08d656cfce3c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:VI1PR0802MB2415;
x-ms-traffictypediagnostic: VI1PR0802MB2415:
nodisclaimer: True
x-microsoft-antispam-prvs: <VI1PR0802MB2415EBBB1CEED1A6E71BF3D98FD30@VI1PR0802MB2415.eurprd08.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231453)(999002)(944501466)(4982022)(52105112)(3002001)(93006095)(93001095)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:VI1PR0802MB2415;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0802MB2415;
x-forefront-prvs: 087223B4DA
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(376002)(346002)(366004)(136003)(199004)(189003)(386003)(6306002)(5660300001)(476003)(50226002)(11346002)(486006)(8936002)(446003)(6486002)(7416002)(39060400002)(25786009)(6506007)(2616005)(44832011)(6436002)(4326008)(66066001)(102836004)(6512007)(110136005)(71190400001)(71200400001)(76176011)(81166006)(305945005)(81156014)(52116002)(99286004)(186003)(26005)(316002)(8676002)(54906003)(14454004)(97736004)(68736007)(1076002)(256004)(7736002)(2906002)(478600001)(106356001)(105586002)(36756003)(6116002)(2501003)(86362001)(53936002)(966005)(3846002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0802MB2415;H:VI1PR0802MB2528.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: MpOUfiX1GANcqnjPH9gxM+iHvrM6RoOspH0B39XW3VH2JursMx4w7ldyk0O0nQ8SdITqEo4MnW9qW7B+GSa7s4JeB4r0zHrUhzv0XxMPZzzULD4ZJnyyxiPFfYur8ml48f5zqJZ947kqKN4Au1xeP8uXlen9RDFs/C5sIUky7aYRbZpvlJ3Vzal/2rhCMgBJmy8o4/yClOpsSJEn+G/pAabCuZSA86nMuztAXx1YRMQxZmlklVaymxHt7BuVw62tKFtQhyXbWV+3Z/tpIra5gNVKyd5U3sdC9kNAZQDc31ryM0IoAlpa0ZfcWRbeX+PGx+1s2XZ9lB+0BMcDicwahyw5CFPgtj2dm3yw2QVLdj8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd318591-fb88-45fb-f5fc-08d656cfce3c
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Nov 2018 14:26:24.0037
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0802MB2415
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matt Sealey <matt.sealey@arm.com>

Most compilers should be able to merge adjacent loads/stores of sizes
which are less than but effect a multiple of a machine word size (in
effect a memcpy() of a constant amount). However the semantics of the
macro are that it just does the copy, the pointer increment is in the
code, hence we see

    *a =3D *b
    a +=3D 8
    b +=3D 8
    *a =3D *b
    a +=3D 8
    b +=3D 8

This introduces a dependency between the two groups of statements which
seems to defeat said compiler optimizers and generate some very strange
sequences of addition and subtraction of address offsets (i.e. it is
overcomplicated).

Since COPY8 is only ever used to copy amounts of 16 bytes (in pairs),
just define COPY16 as COPY8,COPY8. We leave the definition to preserve
the need to do unaligned accesses to machine-sized words per the
original code intent, we just don't use it in the code proper.

COPY16 then gives us code like:

    *a =3D *b
    *(a+8) =3D *(b+8)
    a +=3D 16
    b +=3D 16

This seems to allow compilers to generate much better code by using
base register writeback or simply positively incrementing offsets which
seems to positively affect performance. It is, at least, fewer
instructions to do the same job.

Link: http://lkml.kernel.org/r/20181127161913.23863-3-dave.rodgman@arm.com
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
 lib/lzo/lzo1x_compress.c        |  9 +++------
 lib/lzo/lzo1x_decompress_safe.c | 18 ++++++------------
 lib/lzo/lzodefs.h               |  3 +++
 3 files changed, 12 insertions(+), 18 deletions(-)

diff --git a/lib/lzo/lzo1x_compress.c b/lib/lzo/lzo1x_compress.c
index 236eb21167b5..82fb5571ce5e 100644
--- a/lib/lzo/lzo1x_compress.c
+++ b/lib/lzo/lzo1x_compress.c
@@ -60,8 +60,7 @@ lzo1x_1_do_compress(const unsigned char *in, size_t in_le=
n,
 				op +=3D t;
 			} else if (t <=3D 16) {
 				*op++ =3D (t - 3);
-				COPY8(op, ii);
-				COPY8(op + 8, ii + 8);
+				COPY16(op, ii);
 				op +=3D t;
 			} else {
 				if (t <=3D 18) {
@@ -76,8 +75,7 @@ lzo1x_1_do_compress(const unsigned char *in, size_t in_le=
n,
 					*op++ =3D tt;
 				}
 				do {
-					COPY8(op, ii);
-					COPY8(op + 8, ii + 8);
+					COPY16(op, ii);
 					op +=3D 16;
 					ii +=3D 16;
 					t -=3D 16;
@@ -255,8 +253,7 @@ int lzo1x_1_compress(const unsigned char *in, size_t in=
_len,
 			*op++ =3D tt;
 		}
 		if (t >=3D 16) do {
-			COPY8(op, ii);
-			COPY8(op + 8, ii + 8);
+			COPY16(op, ii);
 			op +=3D 16;
 			ii +=3D 16;
 			t -=3D 16;
diff --git a/lib/lzo/lzo1x_decompress_safe.c b/lib/lzo/lzo1x_decompress_saf=
e.c
index a1c387f6afba..aa95d3066b7d 100644
--- a/lib/lzo/lzo1x_decompress_safe.c
+++ b/lib/lzo/lzo1x_decompress_safe.c
@@ -86,12 +86,9 @@ int lzo1x_decompress_safe(const unsigned char *in, size_=
t in_len,
 					const unsigned char *ie =3D ip + t;
 					unsigned char *oe =3D op + t;
 					do {
-						COPY8(op, ip);
-						op +=3D 8;
-						ip +=3D 8;
-						COPY8(op, ip);
-						op +=3D 8;
-						ip +=3D 8;
+						COPY16(op, ip);
+						op +=3D 16;
+						ip +=3D 16;
 					} while (ip < ie);
 					ip =3D ie;
 					op =3D oe;
@@ -187,12 +184,9 @@ int lzo1x_decompress_safe(const unsigned char *in, siz=
e_t in_len,
 			unsigned char *oe =3D op + t;
 			if (likely(HAVE_OP(t + 15))) {
 				do {
-					COPY8(op, m_pos);
-					op +=3D 8;
-					m_pos +=3D 8;
-					COPY8(op, m_pos);
-					op +=3D 8;
-					m_pos +=3D 8;
+					COPY16(op, m_pos);
+					op +=3D 16;
+					m_pos +=3D 16;
 				} while (op < oe);
 				op =3D oe;
 				if (HAVE_IP(6)) {
diff --git a/lib/lzo/lzodefs.h b/lib/lzo/lzodefs.h
index 497f9c9f03a8..e1b3cf6459a9 100644
--- a/lib/lzo/lzodefs.h
+++ b/lib/lzo/lzodefs.h
@@ -23,6 +23,9 @@
 		COPY4(dst, src); COPY4((dst) + 4, (src) + 4)
 #endif
=20
+#define COPY16(dst, src) \
+	do { COPY8(dst, src); COPY8((dst) + 8, (src) + 8); } while (0)
+
 #if defined(__BIG_ENDIAN) && defined(__LITTLE_ENDIAN)
 #error "conflicting endian definitions"
 #elif defined(CONFIG_X86_64)
--=20
2.17.1

